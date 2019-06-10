Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BC81C468BC
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 08:44:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6785B207E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 08:44:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nikanor-nu.20150623.gappssmtp.com header.i=@nikanor-nu.20150623.gappssmtp.com header.b="ZpmXYIEp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388690AbfFJIo6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 04:44:58 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:37883 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388538AbfFJIo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 04:44:56 -0400
Received: by mail-lf1-f68.google.com with SMTP id m15so6033175lfh.4
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2019 01:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nikanor-nu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YwBLl66NqeKEJLREj2TUkgvnSGnVe+6R0g0OhEgqv+c=;
        b=ZpmXYIEpLDdxcfpn9XFd+WFwmB1ZRxjmQVdaWhMtgZZvd6JSoLfvm3w0NTlitm/h2C
         UIpTmsTsNoERASK3xQL4JXKJjJYLZTlsuKMKWa9uFOyJ9Dxr6oznPJS3O6PbQYTUgcvy
         74xfegqTtxiUpdEm52E4nDS59fgGrlZyK+HHvj/l+e9pT7CY5GRPhZtoonqZVwfkc9OT
         f3qEWJh8AXL+BXQJ1UZ2o0Cx1jfIZ/BglNRkmTfP5Wl+UDp42aQIuxvp4iTRsZfkqvVC
         bcdI/q/AdxM9einXcxQWNkVjoQHVNPmuwygB1OKxvoOF+782pGO+yOtHORvHwH+o6Ak/
         5yPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YwBLl66NqeKEJLREj2TUkgvnSGnVe+6R0g0OhEgqv+c=;
        b=hC211SA2t48cx0tGr9epzeQTSACw0Vo3laI8ER8UPSuCFrZ7fmESsBnBTVCKXmzxsW
         5rwQY/2QPG9tvKz+R53SWMeYCsTy1f17KhiFpNdUYOlocj/b1j3U8ZlykkwM+eRlIWZY
         yOqHgQSU5Bsvt2NKNNL5x7FT5pqgsaK5oLriGScwH5jSa3FDSyWZ9L3Me+Fw46pyyO1e
         dHIq+jaASf2DUxYQKOuGli1Vei6kSZhWyn42KqvegshhdDNrYAltO2bF9ClPnzR+rO7X
         fes/LNNeMxH1owSsx0t1mjdt2MPDZJiP/ZJoeuj4hb1+Ai2nqRkoBW2I/mDcdLuURAMu
         52TQ==
X-Gm-Message-State: APjAAAUOPQT1UnMq4uzJjirS0YhKhi71n89i2x8KFeq06MkqoiDfrGH5
        f953c0D2YQT/XOdykNe8Lw+9rg==
X-Google-Smtp-Source: APXvYqx2KQnSI4tF/BTeGX3NLsV99u+r5qrRxAwuBoESku4zqxNNvCW5Ib68szvs0vuOhG30/T2O4A==
X-Received: by 2002:a05:6512:dc:: with SMTP id c28mr33376734lfp.105.1560156293204;
        Mon, 10 Jun 2019 01:44:53 -0700 (PDT)
Received: from dev.nikanor.nu (78-72-133-4-no161.tbcn.telia.com. [78.72.133.4])
        by smtp.gmail.com with ESMTPSA id e26sm1826486ljl.33.2019.06.10.01.44.52
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 10 Jun 2019 01:44:52 -0700 (PDT)
From:   =?UTF-8?q?Simon=20Sandstr=C3=B6m?= <simon@nikanor.nu>
To:     gregkh@linuxfoundation.org
Cc:     =simon@nikanor.nu, jeremy@azazel.net, dan.carpenter@oracle.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Simon=20Sandstr=C3=B6m?= <simon@nikanor.nu>
Subject: [PATCH 4/5] staging: kpc2000: remove unnecessary debug prints in fileops.c
Date:   Mon, 10 Jun 2019 10:44:31 +0200
Message-Id: <20190610084432.12597-5-simon@nikanor.nu>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190610084432.12597-1-simon@nikanor.nu>
References: <20190610084432.12597-1-simon@nikanor.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Debug prints that are used only to inform about function entry or exit
can be removed as ftrace can be used to get this information.

Signed-off-by: Simon Sandström <simon@nikanor.nu>
---
 drivers/staging/kpc2000/kpc_dma/fileops.c | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/drivers/staging/kpc2000/kpc_dma/fileops.c b/drivers/staging/kpc2000/kpc_dma/fileops.c
index fdec1ab25dfd..f80b01715d93 100644
--- a/drivers/staging/kpc2000/kpc_dma/fileops.c
+++ b/drivers/staging/kpc2000/kpc_dma/fileops.c
@@ -54,8 +54,6 @@ int  kpc_dma_transfer(struct dev_private_data *priv, struct kiocb *kcb, unsigned
 	ldev = priv->ldev;
 	BUG_ON(ldev == NULL);
 
-	dev_dbg(&priv->ldev->pldev->dev, "%s(priv = [%p], kcb = [%p], iov_base = [%p], iov_len = %zu) ldev = [%p]\n", __func__, priv, kcb, (void *)iov_base, iov_len, ldev);
-
 	acd = kzalloc(sizeof(*acd), GFP_KERNEL);
 	if (!acd) {
 		dev_err(&priv->ldev->pldev->dev, "Couldn't kmalloc space for for the aio data\n");
@@ -218,8 +216,6 @@ void  transfer_complete_cb(struct aio_cb_data *acd, size_t xfr_count, u32 flags)
 	BUG_ON(acd->ldev == NULL);
 	BUG_ON(acd->ldev->pldev == NULL);
 
-	dev_dbg(&acd->ldev->pldev->dev, "%s(acd = [%p])\n", __func__, acd);
-
 	for (i = 0 ; i < acd->page_count ; i++) {
 		if (!PageReserved(acd->user_pages[i])) {
 			set_page_dirty(acd->user_pages[i]);
@@ -275,7 +271,6 @@ int  kpc_dma_open(struct inode *inode, struct file *filp)
 	priv->ldev = ldev;
 	filp->private_data = priv;
 
-	dev_dbg(&priv->ldev->pldev->dev, "%s(inode = [%p], filp = [%p]) priv = [%p] ldev = [%p]\n", __func__, inode, filp, priv, priv->ldev);
 	return 0;
 }
 
@@ -286,8 +281,6 @@ int  kpc_dma_close(struct inode *inode, struct file *filp)
 	struct dev_private_data *priv = (struct dev_private_data *)filp->private_data;
 	struct kpc_dma_device *eng = priv->ldev;
 
-	dev_dbg(&priv->ldev->pldev->dev, "%s(inode = [%p], filp = [%p]) priv = [%p], ldev = [%p]\n", __func__, inode, filp, priv, priv->ldev);
-
 	lock_engine(eng);
 
 	stop_dma_engine(eng);
@@ -330,8 +323,6 @@ ssize_t   kpc_dma_aio_read(struct kiocb *kcb, const struct iovec *iov, unsigned
 {
 	struct dev_private_data *priv = (struct dev_private_data *)kcb->ki_filp->private_data;
 
-	dev_dbg(&priv->ldev->pldev->dev, "%s(kcb = [%p], iov = [%p], iov_count = %ld, pos = %lld) priv = [%p], ldev = [%p]\n", __func__, kcb, iov, iov_count, pos, priv, priv->ldev);
-
 	if (priv->ldev->dir != DMA_FROM_DEVICE)
 		return -EMEDIUMTYPE;
 
@@ -350,8 +341,6 @@ ssize_t  kpc_dma_aio_write(struct kiocb *kcb, const struct iovec *iov, unsigned
 {
 	struct dev_private_data *priv = (struct dev_private_data *)kcb->ki_filp->private_data;
 
-	dev_dbg(&priv->ldev->pldev->dev, "%s(kcb = [%p], iov = [%p], iov_count = %ld, pos = %lld) priv = [%p], ldev = [%p]\n", __func__, kcb, iov, iov_count, pos, priv, priv->ldev);
-
 	if (priv->ldev->dir != DMA_TO_DEVICE)
 		return -EMEDIUMTYPE;
 
@@ -371,8 +360,6 @@ ssize_t  kpc_dma_read(struct file *filp,       char __user *user_buf, size_t cou
 {
 	struct dev_private_data *priv = (struct dev_private_data *)filp->private_data;
 
-	dev_dbg(&priv->ldev->pldev->dev, "%s(filp = [%p], user_buf = [%p], count = %zu, ppos = [%p]) priv = [%p], ldev = [%p]\n", __func__, filp, user_buf, count, ppos, priv, priv->ldev);
-
 	if (priv->ldev->dir != DMA_FROM_DEVICE)
 		return -EMEDIUMTYPE;
 
@@ -384,8 +371,6 @@ ssize_t  kpc_dma_write(struct file *filp, const char __user *user_buf, size_t co
 {
 	struct dev_private_data *priv = (struct dev_private_data *)filp->private_data;
 
-	dev_dbg(&priv->ldev->pldev->dev, "%s(filp = [%p], user_buf = [%p], count = %zu, ppos = [%p]) priv = [%p], ldev = [%p]\n", __func__, filp, user_buf, count, ppos, priv, priv->ldev);
-
 	if (priv->ldev->dir != DMA_TO_DEVICE)
 		return -EMEDIUMTYPE;
 
@@ -397,8 +382,6 @@ long  kpc_dma_ioctl(struct file *filp, unsigned int ioctl_num, unsigned long ioc
 {
 	struct dev_private_data *priv = (struct dev_private_data *)filp->private_data;
 
-	dev_dbg(&priv->ldev->pldev->dev, "%s(filp = [%p], ioctl_num = 0x%x, ioctl_param = 0x%lx) priv = [%p], ldev = [%p]\n", __func__, filp, ioctl_num, ioctl_param, priv, priv->ldev);
-
 	switch (ioctl_num) {
 	case KND_IOCTL_SET_CARD_ADDR:
 		priv->card_addr  = ioctl_param; return priv->card_addr;
-- 
2.20.1

