Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B00C0C04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 10:27:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81060208CA
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 10:27:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WsbkEv2+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728406AbfEMK1e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 06:27:34 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38241 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727132AbfEMK1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 06:27:33 -0400
Received: by mail-pl1-f193.google.com with SMTP id f97so1161218plb.5
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 03:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jCVFFIvk/dM3akUvv+q1GBXV3JQofCa1Kd1PS4pC1i4=;
        b=WsbkEv2+u24qjjfmf5Q7lHIg7ZqB/Df3kEknjnkM6zUpRkL07KG025dbev1wr3tMm3
         hHmHSWy2pZ2SIT0KxFuI8LuaxpkOMXgjkLT7YfBVpqNFf31HHlg+Bx5d8o6pqWvoNDyr
         OBG0jcnDbHODSFWpmVam0d1S8qO5kfM6/yV2yb+zn90dVcw1E9QeuMHYwKGCxJxRj5jz
         nkdqTEFQJjANCy9ubw9WO87Eba76vpXii3PMKYMaNXWGjCWbOiDF5UdGy/tkja2FDdmV
         eOj/q6o7LDkFi8r3SIUnBFU0SIfT4sQvRTa4jBpYAYbyStyqom9+dPsx2xyDrZ2aqpbI
         QRcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jCVFFIvk/dM3akUvv+q1GBXV3JQofCa1Kd1PS4pC1i4=;
        b=DgNqHUNa+upWUpT8+clY/BaTHnZRbMjn023fecOGTPvu8pajHk+pagYc71jdWimLHk
         kYoSwbO60dQ79zMvJ+l/WHOxoIhJoOUKLIkwS2Cq9MTP2ceZy6ihR/ZQXjH2vroGz6J0
         scF564HY/vlEL9dSZaN64eWFS2rdjlF97VKB51wPsQK+byMl6V7GHZaPnbTZbEQEyzQC
         dLWm08WPz1jXSWbqC92MHflzCEwpzh5Q87XDaH7/XKaGTSPE0l5bMaYiZDV2kqMr2yXO
         vUOKlbkD7K6/lAyBMr+nud59BMjj0JKMnJuG/uPwxswqF9Hr+BIuC4Lvo8YylP/PzrIz
         LOoQ==
X-Gm-Message-State: APjAAAXbQG7IQLzKiUkysdGXPXEL0m8WCyOri+cEE+VfOO8jV3b68HZY
        4YaTB3FkSW6UchLllUOEBzGuRTSp6C4=
X-Google-Smtp-Source: APXvYqymWvZ4WEVfo0YerAxV4IAUGp6ilTSVL4wfLHxcBZVZ0y3n26ysaI3oTx4uh2W0rOWxnXaavQ==
X-Received: by 2002:a17:902:e305:: with SMTP id cg5mr29472095plb.112.1557743252621;
        Mon, 13 May 2019 03:27:32 -0700 (PDT)
Received: from bnva-HP-Pavilion-g6-Notebook-PC.domain.name ([117.248.72.152])
        by smtp.gmail.com with ESMTPSA id r124sm11773487pgr.91.2019.05.13.03.27.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2019 03:27:32 -0700 (PDT)
From:   Vandana BN <bnvandana@gmail.com>
To:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, lukas.bulwahn@gmail.com
Cc:     skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Vandana BN <bnvandana@gmail.com>
Subject: [PATCH v3 8/8] Staging: kpc2000: kpc_dma: Resolve cast warning and use const for file_operation
Date:   Mon, 13 May 2019 15:56:22 +0530
Message-Id: <20190513102622.22398-8-bnvandana@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190513102622.22398-1-bnvandana@gmail.com>
References: <20190510193833.1051-1-bnvandana@gmail.com>
 <20190513102622.22398-1-bnvandana@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This Patch resolves unnecessary cast warning and const file_operations
reported by checkpath.pl
WARNING: unnecessary cast may hide bugs
WARNING: struct file_operations should normally be const
---
v2 - split changes to multiple patches
v3 - edit commit message
---

Signed-off-by: Vandana BN <bnvandana@gmail.com>
---
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

