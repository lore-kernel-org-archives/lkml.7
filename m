Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A29FBC0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 09:48:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7660520679
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 09:48:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cDap9tzq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732079AbfG3JsD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 05:48:03 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39153 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730150AbfG3Jrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 05:47:31 -0400
Received: by mail-wm1-f65.google.com with SMTP id u25so45656353wmc.4
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 02:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=AOFhIckhQmYMamZEnniJSByOBHPTNuKeX0q317r/B6o=;
        b=cDap9tzqXKnWMFaPGlKoO46EBeCxR5sHYphIYa0XgZ2HX1sDcG9f2RfVkVp9wKk5lt
         3oNv/eeT3EJxAJzJF3495LZI/M8qqXzXEnx6Klx2nxI+HEL32Y3njVDdaUraYFOUw4Ox
         c+YfMrDml5m9uFjfa8bcRpR2DtWnwJMCMsGY0ymWTHDJ1L8v2XZETsIDzRY3olivX5WV
         BVlHW+39TxxyuqLjzt6hlVVTw2SFo3edNiRluF3ju2wkI7av51Tkt++GZotKiRqAktO/
         qmzoCMwv+sjIcHNn7/MvUGW6RWwPvxuWvpb1671bcn5dlxr3CRoLcZA8NOQ5RZoIsbt3
         GTQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=AOFhIckhQmYMamZEnniJSByOBHPTNuKeX0q317r/B6o=;
        b=X+8M46oIsVB6WCliE7Azuhd0qrjGPRHkrRfmPNujhqYJc976WSRWjpZozHyhpKKADf
         oYTYVrTiLVeie5EWIIzhYPuIpmoNIks6pCp7G3Al46BiTCVz3C1S0qx+MIWtfmwjFmr1
         hbQS/i1w7bJdmIxLaGEQ9pOHrofoFir9dIbKUI9Rzu4ITZfiSYXLkZipDLWOIZtMiZEQ
         Q6JBM6TlEjmhdEwiFbCRZ0/g5cNreZXoAD1EyHHtmLEIlw38EaCWqCPPu/dSOc0LJoZT
         cotjBPdEayOM86LktVA6InVAHk9owRpCOdK4oaZVA57OFn80WhCINILLqBRNv25eupDy
         +D2g==
X-Gm-Message-State: APjAAAX/4/n13FkOlHP7oc9NPEdCES6lTBx5/O2Jfgg3e4+hamE30QnU
        uC+WbHRTzKr96p+F5+UKZtASZzVamoc=
X-Google-Smtp-Source: APXvYqxxqR4CoL3MLTyK1xkvNBl0KgyJ96lOKuKCjVm1BaZRuUlfjaPQo60Sx3bNRBcXQKm92SltHA==
X-Received: by 2002:a1c:e90d:: with SMTP id q13mr103501900wmc.89.1564480049162;
        Tue, 30 Jul 2019 02:47:29 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id k124sm105967360wmk.47.2019.07.30.02.47.27
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 30 Jul 2019 02:47:28 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, oshpigelman@habana.ai,
        ttayar@habana.ai, gregkh@linuxfoundation.org
Subject: [PATCH v2 1/7] habanalabs: add handle field to context structure
Date:   Tue, 30 Jul 2019 12:47:18 +0300
Message-Id: <20190730094724.18691-2-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190730094724.18691-1-oded.gabbay@gmail.com>
References: <20190730094724.18691-1-oded.gabbay@gmail.com>
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

