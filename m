Return-Path: <SRS0=t4ha=TM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACE70C04A6B
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 23:40:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78BA82084E
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 23:40:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="odEjzDhB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727278AbfELXkz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 May 2019 19:40:55 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44541 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726664AbfELXkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 May 2019 19:40:53 -0400
Received: by mail-pl1-f196.google.com with SMTP id d3so5484674plj.11
        for <linux-kernel@vger.kernel.org>; Sun, 12 May 2019 16:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TsfAx4zdDRwJihvbXlCQCbZL+ogh5EWvAaFZBJ14qzE=;
        b=odEjzDhBDSt624wUmmRe80CWR+X4JGaDOdCMbKq0o37HRRK17Wp/tODyVPGA6vuhGW
         JnxqMWAJnkIw9E2d6RbPkVVKpZNZ9chvGfC2U90PDhJodQOJw1qWiWZafr+g0Ui9EI5m
         BdhJuy4n4o0e7uUriKzc3z6/Q26HY2DHx+hS/oPhqpirqlow9suQ6febvnBQcVkHGRFV
         lMG122BCVItxkakMcMJ101r23OwcDFw8poh8Z98lFOx4lvgGnjNyqSI4K0CfRaQ8z5Dy
         dhHNaG0OMzHlrw19ETI6zcg2z2Hqv+Ybje6g2nQtOMI5D14N2ZAtWRW7FokerbPG9hnz
         LQiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TsfAx4zdDRwJihvbXlCQCbZL+ogh5EWvAaFZBJ14qzE=;
        b=QVFvohtRc4j6z75cBPkBXoXyvwf3IaJ9Jt3S7W3q9wr59e82ocq5gpd7eMjC0YsjpE
         TihK/q+tgGlz1wA7jHI+smzKVhEa+wCqvnuCctDNt8XwCZ304uTXWFGErnbqwDxFo4f9
         WsUkRrhhwnevsOyVtAQn6OHEsLQEj1ECkQqPLl3WHWFxMTIkzEU6aWEZjpcuMdwCcReg
         aKttNiJrb2Wf7qmYdgfTOCTTuk6ILOwHUBkpuKdQf5D2Zwtrr1MIBDu2jWKjfp17Qn1l
         3y9fEZpLFIWlgODpNo0OVKblymgcFXej+dnEjKxeU1PKVSQYYe4ZutOYFUOMU0lREVQx
         C6Og==
X-Gm-Message-State: APjAAAUMuCnl+N3jB7QxQ3rvSVoY9JZFJ4xA5ZIzFKbNfa3p/Uo8YTf/
        9dXKcCG6SjEHb/kWU8i4HKU=
X-Google-Smtp-Source: APXvYqyihJeYKxyJYA5oX+uDnBAJTL69DTbZ+7rv3dodfLpO627ZNHCV14A+621NrF3LLSa251I5Hw==
X-Received: by 2002:a17:902:a01:: with SMTP id 1mr27085632plo.36.1557704452022;
        Sun, 12 May 2019 16:40:52 -0700 (PDT)
Received: from bnva-HP-Pavilion-g6-Notebook-PC.domain.name ([117.241.202.125])
        by smtp.gmail.com with ESMTPSA id e29sm13528376pgb.37.2019.05.12.16.40.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 May 2019 16:40:51 -0700 (PDT)
From:   Vandana BN <bnvandana@gmail.com>
To:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, lukas.bulwahn@gmail.com
Cc:     skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Vandana BN <bnvandana@gmail.com>
Subject: [PATCH v2 8/8] Staging: kpc2000: kpc_dma: Resolve coding style warning reported by checkpatch
Date:   Mon, 13 May 2019 05:10:00 +0530
Message-Id: <20190512234000.16555-8-bnvandana@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190512234000.16555-1-bnvandana@gmail.com>
References: <20190510193833.1051-1-bnvandana@gmail.com>
 <20190512234000.16555-1-bnvandana@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This Patch resolves unnecessary cast warning and const file_operations
WARNING: unnecessary cast may hide bugs
WARNING: struct file_operations should normally be const

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

