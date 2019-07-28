Return-Path: <SRS0=snA0=VZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24114C7618B
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 11:28:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE2CC2087C
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 11:28:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hbRbyfRL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726103AbfG1L20 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jul 2019 07:28:26 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:32982 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbfG1L2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jul 2019 07:28:25 -0400
Received: by mail-wm1-f66.google.com with SMTP id h19so41024482wme.0
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2019 04:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=AOFhIckhQmYMamZEnniJSByOBHPTNuKeX0q317r/B6o=;
        b=hbRbyfRLWmIf0fWaG/urbUnpNUEt+yVDfRP4bCA3bNoyozMdY87WszmkQak4QB2CqO
         yCvV2eP7hYkWAPVVBuCRnsINYUCpJH9qoyJed+LvCN357ZY7EwNY/y0T9cgQhD7tfh66
         B2UIPZbzPq+1Pom6962V3rH96hHtqLCDHBTKpprPyW6gEIg7HT32gnGdQ78UWKaZ7LPp
         zy6nm0Zd096BldmuznsH3WExKGCbqNjwKRH94yvTaVB0Jc1+WrtcArVTRHmLU31IjkSD
         55X70ggnFPHkyzbo/mCdBNT7wSMX9XRh/2bFoQmkBYFHnOuuTAzrBHMdgB1fnoZnHMg1
         edOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=AOFhIckhQmYMamZEnniJSByOBHPTNuKeX0q317r/B6o=;
        b=uY2fmPh4j4Nwo3Xn25Q/KJSXAp0GXz1/9clZI3zgizXbQG0Dd0hHE7fOoWOPL5DK6d
         aAi7XVoUQGYfLc6Dk0H6dbJ/uzFAgZ9g6enpBRGxpzHA7+MOy7J96VGzPi2EBH1g9ScR
         /BiUc+9/6IA0MsCnzH7b5fUN+WV7IarbA8KYUXGHm9482+jnAMDYfqhg31JZVKAhTl1V
         FOJTnyHjlR8+ob7tF/Ps8ApFZ1hwiHyLIcVlXt05IblkrLiHUwWSz8Xy6Ioif/B+J8Od
         3HkhlpVM/6leRDh61VM//SdvuMAiNM1WS6w1cBpcrK4jOmRSwzOk2CpmUMmoq0FikN0w
         Mg/w==
X-Gm-Message-State: APjAAAU/9wVVf6oknOAclmYiUPgzQ3vz1pC2OQ3k5912aYVM5puq4iCq
        lRByFqIhJx0m+W4+KYCZT0m6zLdw/q4=
X-Google-Smtp-Source: APXvYqxxrOIbNWNUmo/+haxMevkxCCFTHL0SZLa2exBYq6+4wCHF+QuGNBED6rGLwCl0++x6WVq9Iw==
X-Received: by 2002:a05:600c:23cd:: with SMTP id p13mr87225776wmb.86.1564313302586;
        Sun, 28 Jul 2019 04:28:22 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id r12sm69805174wrt.95.2019.07.28.04.28.21
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 28 Jul 2019 04:28:22 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, oshpigelman@habana.ai,
        ttayar@habana.ai, gregkh@linuxfoundation.org
Subject: [PATCH 1/9] habanalabs: add handle field to context structure
Date:   Sun, 28 Jul 2019 14:28:10 +0300
Message-Id: <20190728112818.30397-2-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190728112818.30397-1-oded.gabbay@gmail.com>
References: <20190728112818.30397-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a field to the context's structure that will hold a unique
handle for the context.

This will be needed when the user will create the context.

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/context.c    | 27 ++++++++++++++++-----------
 drivers/misc/habanalabs/habanalabs.h |  2 ++
 2 files changed, 18 insertions(+), 11 deletions(-)

diff --git a/drivers/misc/habanalabs/context.c b/drivers/misc/habanalabs/context.c
index 8682590e3f6e..1d8390418234 100644
--- a/drivers/misc/habanalabs/context.c
+++ b/drivers/misc/habanalabs/context.c
@@ -67,9 +67,20 @@ int hl_ctx_create(struct hl_device *hdev, struct hl_fpriv *hpriv)
 		goto out_err;
 	}
 
+	mutex_lock(&mgr->ctx_lock);
+	rc = idr_alloc(&mgr->ctx_handles, ctx, 1, 0, GFP_KERNEL);
+	mutex_unlock(&mgr->ctx_lock);
+
+	if (rc < 0) {
+		dev_err(hdev->dev, "Failed to allocate IDR for a new CTX\n");
+		goto free_ctx;
+	}
+
+	ctx->handle = rc;
+
 	rc = hl_ctx_init(hdev, ctx, false);
 	if (rc)
-		goto free_ctx;
+		goto remove_from_idr;
 
 	hl_hpriv_get(hpriv);
 	ctx->hpriv = hpriv;
@@ -78,18 +89,12 @@ int hl_ctx_create(struct hl_device *hdev, struct hl_fpriv *hpriv)
 	hpriv->ctx = ctx;
 	hdev->user_ctx = ctx;
 
-	mutex_lock(&mgr->ctx_lock);
-	rc = idr_alloc(&mgr->ctx_handles, ctx, 1, 0, GFP_KERNEL);
-	mutex_unlock(&mgr->ctx_lock);
-
-	if (rc < 0) {
-		dev_err(hdev->dev, "Failed to allocate IDR for a new CTX\n");
-		hl_ctx_free(hdev, ctx);
-		goto out_err;
-	}
-
 	return 0;
 
+remove_from_idr:
+	mutex_lock(&mgr->ctx_lock);
+	idr_remove(&mgr->ctx_handles, ctx->handle);
+	mutex_unlock(&mgr->ctx_lock);
 free_ctx:
 	kfree(ctx);
 out_err:
diff --git a/drivers/misc/habanalabs/habanalabs.h b/drivers/misc/habanalabs/habanalabs.h
index 57183ae9b95d..e41800e68578 100644
--- a/drivers/misc/habanalabs/habanalabs.h
+++ b/drivers/misc/habanalabs/habanalabs.h
@@ -631,6 +631,7 @@ struct hl_va_range {
  *				execution phase before the context switch phase
  *				has finished.
  * @asid: context's unique address space ID in the device's MMU.
+ * @handle: context's opaque handle for user
  */
 struct hl_ctx {
 	DECLARE_HASHTABLE(mem_hash, MEM_HASH_TABLE_BITS);
@@ -652,6 +653,7 @@ struct hl_ctx {
 	atomic_t		thread_ctx_switch_token;
 	u32			thread_ctx_switch_wait_token;
 	u32			asid;
+	u32			handle;
 };
 
 /**
-- 
2.17.1

