Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D652C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 10:13:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC55820657
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 10:13:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mxibRsT7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726455AbfCGKNV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 05:13:21 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46295 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726279AbfCGKNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 05:13:17 -0500
Received: by mail-wr1-f68.google.com with SMTP id i16so16692786wrs.13
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 02:13:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o8BYMahdyLpS4J6ZFucCS3ofixQiIJoSCGVZibyHjj8=;
        b=mxibRsT7eF/cC6Ed0qLikadqu+huQ+J+lx0QPSPyd/w64x2ow9v2ZMCyJEe3tLVLZu
         XrypsmopYuOcwmFYpNQG4Ko6Hnx38/In8wp3BR0swJiyHteZFPZ9LdZAwgiQ2Ob7Az9i
         +1zavAurpgt+LUClF0wRabX7coBlUMXGPvRgZhxH037v0gGmVLMFy83eg8z3Cx3EvwDP
         yPUpMHD6PMwAzmTjIFZDgmbIjny1BkR0pEtnjFqxrmR4JdykRxZqdJMnD0YM+rzmAyYp
         ePKMlYlUAl9xR+Uq6DCMvhYtXCSWP4Bl1AOkkuXEXLJHSAfH7kgk5bVN0KbTelZQI6im
         OR1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o8BYMahdyLpS4J6ZFucCS3ofixQiIJoSCGVZibyHjj8=;
        b=SxEM08cWvmISlhcHcKKUgDnzvwOAarTuZ7CMbysqZOU8r+BOZWD28jUMQuttyUc3+M
         aNfLRaddl3ckhnlrA27L0Yg+1lVmQeal9P0oj3BwCmQz+4e0sMSvpLeHJEbUF7RUXlII
         IkbMaA9muGKnuLznP1SlNiWzBZubXlxoYrAEvpq3GtWcAKka9TbkRBZqpQaaIW+g52vs
         n4zURF6KqOfgPq5d6ZDFQv3304ZTSpeasVTKwTNscUYhoS0V9xWnhyd8z32YKmuuo964
         hZaNNlHPMh65/yATOW4ou4YGN9JJ6IX3aShoDIxsE7RL/9YL0nnK1uFh2Ya7dCmme4d4
         EtxA==
X-Gm-Message-State: APjAAAW7kCoNTSGhesgJrIqbN8g2HO+FHZ5DdPWGiK1FMVEr/yemiSB4
        EbwnwdRWP7mPAl9Blc+OU+7WxQ==
X-Google-Smtp-Source: APXvYqyQGvCBC3IQlw6zZ0nfAJimJ03uAVNbdTiF9EneF5Qyse1FflLLFj+sBuBjHF6Fi9rUA2FTIg==
X-Received: by 2002:adf:f792:: with SMTP id q18mr5995764wrp.324.1551953595673;
        Thu, 07 Mar 2019 02:13:15 -0800 (PST)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id n9sm3529767wmi.33.2019.03.07.02.13.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 07 Mar 2019 02:13:15 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org, arnd@arndb.de
Cc:     linux-kernel@vger.kernel.org, bjorn.andersson@linaro.org,
        bkumar@qti.qualcomm.com, linux-arm-msm@vger.kernel.org,
        ktadakam@qti.qualcomm.com,
        Thierry Escande <thierry.escande@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 1/8] misc: fastrpc: Avoid free of DMA buffer in interrupt context
Date:   Thu,  7 Mar 2019 10:12:22 +0000
Message-Id: <20190307101229.7856-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190307101229.7856-1-srinivas.kandagatla@linaro.org>
References: <20190307101229.7856-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Escande <thierry.escande@linaro.org>

When the remote DSP invocation is interrupted by the user, the
associated DMA buffer can be freed in interrupt context causing a kernel
BUG.

This patch adds a worker thread associated to the fastrpc context. It
is scheduled in the rpmsg callback to decrease its refcount out of the
interrupt context.

Fixes: c68cfb718c8f ("misc: fastrpc: Add support for context Invoke method")
Signed-off-by: Thierry Escande <thierry.escande@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/misc/fastrpc.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 89aec17738ef..82e7217ae87a 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -149,6 +149,7 @@ struct fastrpc_invoke_ctx {
 	struct kref refcount;
 	struct list_head node; /* list of ctxs */
 	struct completion work;
+	struct work_struct put_work;
 	struct fastrpc_msg msg;
 	struct fastrpc_user *fl;
 	struct fastrpc_remote_arg *rpra;
@@ -311,6 +312,14 @@ static void fastrpc_context_put(struct fastrpc_invoke_ctx *ctx)
 	kref_put(&ctx->refcount, fastrpc_context_free);
 }
 
+static void fastrpc_context_put_wq(struct work_struct *work)
+{
+	struct fastrpc_invoke_ctx *ctx =
+			container_of(work, struct fastrpc_invoke_ctx, put_work);
+
+	fastrpc_context_put(ctx);
+}
+
 static struct fastrpc_invoke_ctx *fastrpc_context_alloc(
 			struct fastrpc_user *user, u32 kernel, u32 sc,
 			struct fastrpc_invoke_args *args)
@@ -345,6 +354,7 @@ static struct fastrpc_invoke_ctx *fastrpc_context_alloc(
 	ctx->tgid = user->tgid;
 	ctx->cctx = cctx;
 	init_completion(&ctx->work);
+	INIT_WORK(&ctx->put_work, fastrpc_context_put_wq);
 
 	spin_lock(&user->lock);
 	list_add_tail(&ctx->node, &user->pending);
@@ -1349,7 +1359,13 @@ static int fastrpc_rpmsg_callback(struct rpmsg_device *rpdev, void *data,
 
 	ctx->retval = rsp->retval;
 	complete(&ctx->work);
-	fastrpc_context_put(ctx);
+
+	/*
+	 * The DMA buffer associated with the context cannot be freed in
+	 * interrupt context so schedule it through a worker thread to
+	 * avoid a kernel BUG.
+	 */
+	schedule_work(&ctx->put_work);
 
 	return 0;
 }
-- 
2.21.0

