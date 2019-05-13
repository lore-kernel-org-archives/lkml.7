Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C35A6C04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 13:44:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D35B20879
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 13:44:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BswZVRen"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729815AbfEMNoS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 09:44:18 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40398 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729814AbfEMNoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 09:44:16 -0400
Received: by mail-pf1-f196.google.com with SMTP id u17so7240044pfn.7
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 06:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mGX2Mr21OsC3Cf9X1D+KearNv+Y7HOxRT8DWKLBU5XU=;
        b=BswZVRenIQoRa1xpUYuemfaD/LHQlw286KXz6QNHklzB74ZV6xOnMZlAz/Q706M91D
         mFJwK0RgqLCtu1tGp3drl8f28I6Hu7jBtTKzf3FawwDc2gwq2uezFeIFqgjURdj6Uir/
         27AwPiF8DenxGlYyN87IMaNu+1Mz5/HpZA5Ex+kOjjBMwvXnFa73BRnZpWMdRUlsPRpI
         QEZmGFbEAduuGy4dwp2WJ3NagbWefQlSitYEwza4VDRu1L+c3VZp3nX/PZu7TYtMm1aD
         L+8jlF6wcyInuqsL8r65S8fArDdkd3AkCfM5LcUGXJZWJ5m2BoRwTCk6VAKvi5xineDz
         CzyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mGX2Mr21OsC3Cf9X1D+KearNv+Y7HOxRT8DWKLBU5XU=;
        b=qDK8psO+xHDsb49ZmpuQDaUMS85tY6D8seSXY5jDdKM95bnVF+aVgcYq9oaVzlhsMZ
         8lwKfX4ABZK+OdyrxIe99r3opIuNWKjJYjAWNEbx+C/TaBt8kVPvOic3Kb4jlcOCZOLf
         ndvzw843YS2wOkbjb8oTYIX7F/fb9NH2qn+lQMA85AAcmqUx7eU+radZvEO7IBdk4PTp
         s+H2sYyviYPrgsp933jzRGseyKIQOG560+iQdvlMyXVC/O6eUrdIm2IxgH0G9kJ0upt7
         YsGKDNjWVwQbaIXstYe2gHqb1+Xql5GH06zWiN5/oTkpYwBAyF2zBV3iMkD+NDqye7UB
         l+kg==
X-Gm-Message-State: APjAAAUpGnxs9ehm3H0KVcMPljVJWw5TiLuOf3UEvD0XqrwXfdKmHoIy
        XlPUu6DmX5LXZeZ1SKW/wZQ=
X-Google-Smtp-Source: APXvYqwr4pPzQqbXmnklb6QjRpiYodUB+i9pz1rAxhjyHMvLN2r2B4x7igVYZjIluZEnKRLvXgTxkw==
X-Received: by 2002:a63:9dc8:: with SMTP id i191mr30507243pgd.91.1557755056031;
        Mon, 13 May 2019 06:44:16 -0700 (PDT)
Received: from bnva-HP-Pavilion-g6-Notebook-PC.domain.name ([117.248.72.152])
        by smtp.gmail.com with ESMTPSA id e10sm10874261pfm.137.2019.05.13.06.44.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2019 06:44:15 -0700 (PDT)
From:   Vandana BN <bnvandana@gmail.com>
To:     dan.carpenter@oracle.com, gregkh@linuxfoundation.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        lukas.bulwahn@gmail.com
Cc:     skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Vandana BN <bnvandana@gmail.com>
Subject: [PATCH v4 8/8] Staging: kpc2000: kpc_dma: Resolve cast warning and use const for file_operation
Date:   Mon, 13 May 2019 19:13:27 +0530
Message-Id: <20190513134327.26320-8-bnvandana@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190513134327.26320-1-bnvandana@gmail.com>
References: <20190510193833.1051-1-bnvandana@gmail.com>
 <20190513134327.26320-1-bnvandana@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This Patch resolves unnecessary cast warning and const file_operations
reported by checkpath.pl
WARNING: unnecessary cast may hide bugs
WARNING: struct file_operations should normally be const

Signed-off-by: Vandana BN <bnvandana@gmail.com>
---
v2 - split changes to multiple patches
v3 - edit commit message, subject line
v4 - edit commit message

 drivers/staging/kpc2000/kpc_dma/fileops.c        | 4 ++--
 drivers/staging/kpc2000/kpc_dma/kpc_dma_driver.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/kpc2000/kpc_dma/fileops.c b/drivers/staging/kpc2000/kpc_dma/fileops.c
index c21672ea2b4f..54a1419728ce 100644
--- a/drivers/staging/kpc2000/kpc_dma/fileops.c
+++ b/drivers/staging/kpc2000/kpc_dma/fileops.c
@@ -59,7 +59,7 @@ int  kpc_dma_transfer(struct dev_private_data *priv, struct kiocb *kcb, unsigned
 
 	dev_dbg(&priv->ldev->pldev->dev, "%s(priv = [%p], kcb = [%p], iov_base = [%p], iov_len = %ld) ldev = [%p]\n", __func__, priv, kcb, (void *)iov_base, iov_len, ldev);
 
-	acd = (struct aio_cb_data *) kzalloc(sizeof(struct aio_cb_data), GFP_KERNEL);
+	acd = kzalloc(sizeof(struct aio_cb_data), GFP_KERNEL);
 	if (!acd) {
 		dev_err(&priv->ldev->pldev->dev, "Couldn't kmalloc space for for the aio data\n");
 		return -ENOMEM;
@@ -418,7 +418,7 @@ long  kpc_dma_ioctl(struct file *filp, unsigned int ioctl_num, unsigned long ioc
 	return -ENOTTY;
 }
 
-struct file_operations  kpc_dma_fops = {
+const struct file_operations  kpc_dma_fops = {
 	.owner      = THIS_MODULE,
 	.open           = kpc_dma_open,
 	.release        = kpc_dma_close,
diff --git a/drivers/staging/kpc2000/kpc_dma/kpc_dma_driver.h b/drivers/staging/kpc2000/kpc_dma/kpc_dma_driver.h
index cf781940ac1b..ee47f43e71cf 100644
--- a/drivers/staging/kpc2000/kpc_dma/kpc_dma_driver.h
+++ b/drivers/staging/kpc2000/kpc_dma/kpc_dma_driver.h
@@ -57,7 +57,7 @@ struct dev_private_data {
 
 struct kpc_dma_device *kpc_dma_lookup_device(int minor);
 
-extern struct file_operations  kpc_dma_fops;
+extern const struct file_operations  kpc_dma_fops;
 
 #define ENG_CAP_PRESENT                 0x00000001
 #define ENG_CAP_DIRECTION               0x00000002
-- 
2.17.1

