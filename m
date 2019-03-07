Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04EDDC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 10:13:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF20220835
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 10:13:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wO3FSUKZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbfCGKNu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 05:13:50 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37029 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726425AbfCGKNV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 05:13:21 -0500
Received: by mail-wr1-f68.google.com with SMTP id w6so16710732wrs.4
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 02:13:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kcTfOS4Sv44YjvbK1N2vMmkz/JIfFV0zpTQndWw2C2o=;
        b=wO3FSUKZJKQmqaRn4bNgRRQBbS/urgDEedce1emHnQPNxHN6bwAxu+FxLng93k74x6
         tm+gtcaPAh/X9TGu+We7nzdtQp+m+vlnVaFev0bg4sDarrgJG94EumxJ/0zTfAsmGNRi
         2L+qGoAGLzPKi+ClzCASGnJmHhFkrwu5DU/CsG60PYUmX8l/50R97lhQqvkNbf51kVkE
         VNqqvwrJWwkhCGnpnX2JUbNx3uP0FWZ7zL2roK8yq7I64utV1PnOx2HRYdiBh0Xfd2Ti
         XsKmH+Bl1fDE9NTzKfLkcoZHJlMKdTY7CBGHfmyuCiHjI0GAtklN0t4Kzb+o+WqEnAxt
         s4WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kcTfOS4Sv44YjvbK1N2vMmkz/JIfFV0zpTQndWw2C2o=;
        b=E+Bx2r6KlrcCytrodgKjES1bsMTpNBZZ0PEJtZDOsT2UetuNscoO4OHahNRhfQ5hj5
         27FjPX1eeANdqgUz9RCteoeoKbGvYI0nbBuV/qpZLBvOn87d9u229xM3OTr3mkB7ut6Z
         aCjMJN81VePS1l2N7zHeqmKmnQiH76v/7x7pBeHFKGqqX+8oFFsGbsxrFtpMqvhDDsIA
         Tlj+kbCTZq4oQBhdxNYg4U16MNLmgoUliaIZpo7owBK5f7XxP8kKFgObMG3MiZzohrZs
         hUvhDeus9JSEFdNyr8qtMIEwnaQ8birRQk+vriUiWcpw1hgPt9E8sLkwkHKB0Cpyp/hZ
         j7Xg==
X-Gm-Message-State: APjAAAU93FhAvMD1eIPlFz8ak5L9kJUIbeXuvuJWW3zTrAVZfdZkRvOY
        9AFA8io1NwEc52Lt8kwKAQIdHA==
X-Google-Smtp-Source: APXvYqyCrzTzwXUjJibcn/v1ll2EMmv9yLlXtUipbPAtNSp63n26pkMkIGFvjTgFmoASes6QSvIgQg==
X-Received: by 2002:adf:afe3:: with SMTP id y35mr6136409wrd.318.1551953599096;
        Thu, 07 Mar 2019 02:13:19 -0800 (PST)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id n9sm3529767wmi.33.2019.03.07.02.13.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 07 Mar 2019 02:13:18 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org, arnd@arndb.de
Cc:     linux-kernel@vger.kernel.org, bjorn.andersson@linaro.org,
        bkumar@qti.qualcomm.com, linux-arm-msm@vger.kernel.org,
        ktadakam@qti.qualcomm.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 4/8] misc: fastrpc: use correct spinlock variant
Date:   Thu,  7 Mar 2019 10:12:25 +0000
Message-Id: <20190307101229.7856-5-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190307101229.7856-1-srinivas.kandagatla@linaro.org>
References: <20190307101229.7856-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

context spin lock can be interrupted from callback path so use correct spinlock
so that we do not hit spinlock recursion.

Fixes: c68cfb718c8f ("misc: fastrpc: Add support for context Invoke method")
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/misc/fastrpc.c | 48 +++++++++++++++++++++++++-----------------
 1 file changed, 29 insertions(+), 19 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 753d62ceb1fb..f71b5faae1dd 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -283,6 +283,7 @@ static void fastrpc_context_free(struct kref *ref)
 {
 	struct fastrpc_invoke_ctx *ctx;
 	struct fastrpc_channel_ctx *cctx;
+	unsigned long flags;
 	int i;
 
 	ctx = container_of(ref, struct fastrpc_invoke_ctx, refcount);
@@ -294,9 +295,9 @@ static void fastrpc_context_free(struct kref *ref)
 	if (ctx->buf)
 		fastrpc_buf_free(ctx->buf);
 
-	spin_lock(&cctx->lock);
+	spin_lock_irqsave(&cctx->lock, flags);
 	idr_remove(&cctx->ctx_idr, ctx->ctxid >> 4);
-	spin_unlock(&cctx->lock);
+	spin_unlock_irqrestore(&cctx->lock, flags);
 
 	kfree(ctx->maps);
 	kfree(ctx);
@@ -326,6 +327,7 @@ static struct fastrpc_invoke_ctx *fastrpc_context_alloc(
 {
 	struct fastrpc_channel_ctx *cctx = user->cctx;
 	struct fastrpc_invoke_ctx *ctx = NULL;
+	unsigned long flags;
 	int ret;
 
 	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
@@ -360,15 +362,15 @@ static struct fastrpc_invoke_ctx *fastrpc_context_alloc(
 	list_add_tail(&ctx->node, &user->pending);
 	spin_unlock(&user->lock);
 
-	spin_lock(&cctx->lock);
+	spin_lock_irqsave(&cctx->lock, flags);
 	ret = idr_alloc_cyclic(&cctx->ctx_idr, ctx, 1,
 			       FASTRPC_CTX_MAX, GFP_ATOMIC);
 	if (ret < 0) {
-		spin_unlock(&cctx->lock);
+		spin_unlock_irqrestore(&cctx->lock, flags);
 		goto err_idr;
 	}
 	ctx->ctxid = ret << 4;
-	spin_unlock(&cctx->lock);
+	spin_unlock_irqrestore(&cctx->lock, flags);
 
 	kref_init(&ctx->refcount);
 
@@ -948,9 +950,10 @@ static struct fastrpc_session_ctx *fastrpc_session_alloc(
 					struct fastrpc_channel_ctx *cctx)
 {
 	struct fastrpc_session_ctx *session = NULL;
+	unsigned long flags;
 	int i;
 
-	spin_lock(&cctx->lock);
+	spin_lock_irqsave(&cctx->lock, flags);
 	for (i = 0; i < cctx->sesscount; i++) {
 		if (!cctx->session[i].used && cctx->session[i].valid) {
 			cctx->session[i].used = true;
@@ -958,7 +961,7 @@ static struct fastrpc_session_ctx *fastrpc_session_alloc(
 			break;
 		}
 	}
-	spin_unlock(&cctx->lock);
+	spin_unlock_irqrestore(&cctx->lock, flags);
 
 	return session;
 }
@@ -966,9 +969,11 @@ static struct fastrpc_session_ctx *fastrpc_session_alloc(
 static void fastrpc_session_free(struct fastrpc_channel_ctx *cctx,
 				 struct fastrpc_session_ctx *session)
 {
-	spin_lock(&cctx->lock);
+	unsigned long flags;
+
+	spin_lock_irqsave(&cctx->lock, flags);
 	session->used = false;
-	spin_unlock(&cctx->lock);
+	spin_unlock_irqrestore(&cctx->lock, flags);
 }
 
 static int fastrpc_release_current_dsp_process(struct fastrpc_user *fl)
@@ -994,12 +999,13 @@ static int fastrpc_device_release(struct inode *inode, struct file *file)
 	struct fastrpc_channel_ctx *cctx = fl->cctx;
 	struct fastrpc_invoke_ctx *ctx, *n;
 	struct fastrpc_map *map, *m;
+	unsigned long flags;
 
 	fastrpc_release_current_dsp_process(fl);
 
-	spin_lock(&cctx->lock);
+	spin_lock_irqsave(&cctx->lock, flags);
 	list_del(&fl->user);
-	spin_unlock(&cctx->lock);
+	spin_unlock_irqrestore(&cctx->lock, flags);
 
 	if (fl->init_mem)
 		fastrpc_buf_free(fl->init_mem);
@@ -1027,6 +1033,7 @@ static int fastrpc_device_open(struct inode *inode, struct file *filp)
 {
 	struct fastrpc_channel_ctx *cctx = miscdev_to_cctx(filp->private_data);
 	struct fastrpc_user *fl = NULL;
+	unsigned long flags;
 
 	fl = kzalloc(sizeof(*fl), GFP_KERNEL);
 	if (!fl)
@@ -1050,9 +1057,9 @@ static int fastrpc_device_open(struct inode *inode, struct file *filp)
 		return -EBUSY;
 	}
 
-	spin_lock(&cctx->lock);
+	spin_lock_irqsave(&cctx->lock, flags);
 	list_add_tail(&fl->user, &cctx->users);
-	spin_unlock(&cctx->lock);
+	spin_unlock_irqrestore(&cctx->lock, flags);
 
 	return 0;
 }
@@ -1208,6 +1215,7 @@ static int fastrpc_cb_probe(struct platform_device *pdev)
 	struct fastrpc_session_ctx *sess;
 	struct device *dev = &pdev->dev;
 	int i, sessions = 0;
+	unsigned long flags;
 
 	cctx = dev_get_drvdata(dev->parent);
 	if (!cctx)
@@ -1215,7 +1223,7 @@ static int fastrpc_cb_probe(struct platform_device *pdev)
 
 	of_property_read_u32(dev->of_node, "qcom,nsessions", &sessions);
 
-	spin_lock(&cctx->lock);
+	spin_lock_irqsave(&cctx->lock, flags);
 	sess = &cctx->session[cctx->sesscount];
 	sess->used = false;
 	sess->valid = true;
@@ -1236,7 +1244,7 @@ static int fastrpc_cb_probe(struct platform_device *pdev)
 		}
 	}
 	cctx->sesscount++;
-	spin_unlock(&cctx->lock);
+	spin_unlock_irqrestore(&cctx->lock, flags);
 	dma_set_mask(dev, DMA_BIT_MASK(32));
 
 	return 0;
@@ -1246,16 +1254,17 @@ static int fastrpc_cb_remove(struct platform_device *pdev)
 {
 	struct fastrpc_channel_ctx *cctx = dev_get_drvdata(pdev->dev.parent);
 	struct fastrpc_session_ctx *sess = dev_get_drvdata(&pdev->dev);
+	unsigned long flags;
 	int i;
 
-	spin_lock(&cctx->lock);
+	spin_lock_irqsave(&cctx->lock, flags);
 	for (i = 1; i < FASTRPC_MAX_SESSIONS; i++) {
 		if (cctx->session[i].sid == sess->sid) {
 			cctx->session[i].valid = false;
 			cctx->sesscount--;
 		}
 	}
-	spin_unlock(&cctx->lock);
+	spin_unlock_irqrestore(&cctx->lock, flags);
 
 	return 0;
 }
@@ -1337,11 +1346,12 @@ static void fastrpc_rpmsg_remove(struct rpmsg_device *rpdev)
 {
 	struct fastrpc_channel_ctx *cctx = dev_get_drvdata(&rpdev->dev);
 	struct fastrpc_user *user;
+	unsigned long flags;
 
-	spin_lock(&cctx->lock);
+	spin_lock_irqsave(&cctx->lock, flags);
 	list_for_each_entry(user, &cctx->users, user)
 		fastrpc_notify_users(user);
-	spin_unlock(&cctx->lock);
+	spin_unlock_irqrestore(&cctx->lock, flags);
 
 	misc_deregister(&cctx->miscdev);
 	of_platform_depopulate(&rpdev->dev);
-- 
2.21.0

