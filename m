Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B9D6C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 12:59:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E62DB208C3
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 12:59:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E8lKpOLN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729242AbfGaM7J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 08:59:09 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43285 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727941AbfGaM7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 08:59:07 -0400
Received: by mail-wr1-f67.google.com with SMTP id p13so69550236wru.10
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 05:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=AOFhIckhQmYMamZEnniJSByOBHPTNuKeX0q317r/B6o=;
        b=E8lKpOLNq06ZvxmzRtnx3rZmOP+a1TYORuNE+WwUIHemP4Z1ebjOJH3iDMSOmCgyZg
         jCjIireKy00ANDYsbRudFA6lZsYe+qHtDO0mJA5SA3l/KRpJfEqL1OKrm72anx9bXrzg
         rgpg56Q0tXvSQ1ANYvkUxqTstwG/DW5wyfPVaiWjBP7JHF8pZzpIHbRaTT4dY0gPmVn2
         7cv02ze04J+t83YZOiLGLoVKeHc5u10pW4JY4OKmq1jdJqoSLW5PzdZR2NaA5NY4lRi8
         XsjVXinmS+2jThcxectkIEaN/k5XXyFLx3Fw/13LVTrSG/skPKhqMdFZjmkp6f+BMG/o
         lDFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=AOFhIckhQmYMamZEnniJSByOBHPTNuKeX0q317r/B6o=;
        b=HFk9ud4SaqdLDiSyFLha8tvY2kdCqyFlbNYt9yogPA/IaA+jD3e6TOkzr6WFqHH5/5
         SS9/Yj41nlE5BXTXYYi+8CUvzSuQ9XivNx2VchyvfTJdSC5ouhKMYolF0x8tCTWwTdNa
         4piCuoPzHXXPHryln+L6ao/91yqgOjI2uX8XhRmeSbC3mxbdpYJzq8DQAdhEkiNdWG+Q
         vnrgzlmlIp8P5MsW8sUupy4Z25qwJo/6TPhIn4pcjtcupIG6WWrG9FL1dnf6Bl5i1LN2
         jEQb9t+we2QqKqQbuByk2uapuu4Dzq/hrLaZ62ykw3SIxcTqlUCLYJdngOuN5+h4i1Iu
         GhAw==
X-Gm-Message-State: APjAAAX5bSYZDiDHZssCQgBTnu1Pb0fejPZLJDvl8MscmGmHeBjcu8U4
        fcgla8k92QrCP9Sdrupcb2+4jG93Wmg=
X-Google-Smtp-Source: APXvYqxGXUDF8d4s3G+Fzamcp5EovROGh/VEYJDLV1fzGGt5DLlTG3q3WVz92EXea/4/lHzybg4bwA==
X-Received: by 2002:adf:ce88:: with SMTP id r8mr9331949wrn.42.1564577945300;
        Wed, 31 Jul 2019 05:59:05 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id c6sm69247800wma.25.2019.07.31.05.59.04
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 31 Jul 2019 05:59:04 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, oshpigelman@habana.ai,
        ttayar@habana.ai, gregkh@linuxfoundation.org
Subject: [PATCH v3 1/7] habanalabs: add handle field to context structure
Date:   Wed, 31 Jul 2019 15:58:55 +0300
Message-Id: <20190731125901.20709-2-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190731125901.20709-1-oded.gabbay@gmail.com>
References: <20190731125901.20709-1-oded.gabbay@gmail.com>
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

