Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36A29C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:35:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A1002082C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:35:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qQC72Jqy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732048AbfFMPex (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:34:53 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33668 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728019AbfFMKbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 06:31:48 -0400
Received: by mail-pf1-f196.google.com with SMTP id x15so11603481pfq.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 03:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=X1ybKF8wUkHdnaXcEVMx2e6e4CdYBWVAzo6oWbimFYQ=;
        b=qQC72JqyNS5M5jXNAY8R3qU0KXWZM5lNzLTY1x45KapGIu5nY1kzXvtp8ytpYYAhNe
         VgEDc2Xb0TO9QjIR1scrGcXdU1EZBuzhgCjzfe7X1+jpmGG6K1x+Pf/9uqbgffhKrmNG
         wAPT1c1JfaM31idoL06nNamvN48hNPdql4a3HXfHAOdWsQOsfRkD3H3nKJpZB6TPX0ee
         lVLcpBU+49fTw+3zzRIdis+1cNwUKR2A2T/WWhA/MY121JqRxbEReGNv2toR6GuMHHgy
         yiSnAlAD6mp1f8mPJKrUvuiGbO6NmXN56mS8pPbZRAPe4I32m2XLpwja0iWkRglQCnZf
         F3Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=X1ybKF8wUkHdnaXcEVMx2e6e4CdYBWVAzo6oWbimFYQ=;
        b=P0jdWxYU11WFZjM+uPbEr0+VkHA0h23HGYz5gkzya74bYk1olzWbl/I01xL3t2QftM
         T17H8e1Yu3VWOtwt7Vr108P+P2VseirR1n36jHUp0IU9GjH2AfygY9REAVqqe4T8PvDV
         LUQlUu9rZ9JAooiuJeXmUmiNgO5a3EzGWsbAOx+Vsd27VYmI2OR5e8M8QOJ+sKGnMTlK
         /iXpamUZGJj+fi50SHvEi/kYfUzv3vv/RoyLYph18TcYXMN931S363pFweuaK4Nc2he8
         08Dg631xwIbuZ3uM9a/7R/nBcr3orHBFcpcnt1kMkoYfbdSsAUAXT6FUz5ZnhipUWx93
         zXUA==
X-Gm-Message-State: APjAAAVK595017ZESi1z6ijGd3Y+wll1r25kwh1yd0SePnWZveaqERNk
        lNLtaFaNE7513gIbNTDwVmRacQ==
X-Google-Smtp-Source: APXvYqw0m+SBvdVQmbAIqGHxz8wWKmEDiAXyPgV/c4Ovyt4Pnd4N4physSGHsq7lD1C9XamuJuH9gA==
X-Received: by 2002:a63:e24:: with SMTP id d36mr29935015pgl.80.1560421908050;
        Thu, 13 Jun 2019 03:31:48 -0700 (PDT)
Received: from localhost.localdomain ([117.196.234.139])
        by smtp.gmail.com with ESMTPSA id a12sm2265078pgq.0.2019.06.13.03.31.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 13 Jun 2019 03:31:47 -0700 (PDT)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     keyrings@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     jens.wiklander@linaro.org, corbet@lwn.net, dhowells@redhat.com,
        jejb@linux.ibm.com, jarkko.sakkinen@linux.intel.com,
        zohar@linux.ibm.com, jmorris@namei.org, serge@hallyn.com,
        ard.biesheuvel@linaro.org, daniel.thompson@linaro.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        tee-dev@lists.linaro.org, Sumit Garg <sumit.garg@linaro.org>
Subject: [RFC 2/7] tee: enable support to register kernel memory
Date:   Thu, 13 Jun 2019 16:00:28 +0530
Message-Id: <1560421833-27414-3-git-send-email-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1560421833-27414-1-git-send-email-sumit.garg@linaro.org>
References: <1560421833-27414-1-git-send-email-sumit.garg@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable support to register kernel memory reference with TEE. This change
will allow TEE bus drivers to register memory references.

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 drivers/tee/tee_shm.c   | 16 ++++++++++++++--
 include/linux/tee_drv.h |  1 +
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
index 2da026f..5c69b89 100644
--- a/drivers/tee/tee_shm.c
+++ b/drivers/tee/tee_shm.c
@@ -9,6 +9,7 @@
 #include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/tee_drv.h>
+#include <linux/uio.h>
 #include "tee_private.h"
 
 static void tee_shm_release(struct tee_shm *shm)
@@ -224,13 +225,14 @@ struct tee_shm *tee_shm_register(struct tee_context *ctx, unsigned long addr,
 {
 	struct tee_device *teedev = ctx->teedev;
 	const u32 req_flags = TEE_SHM_DMA_BUF | TEE_SHM_USER_MAPPED;
+	const u32 req_ker_flags = TEE_SHM_DMA_BUF | TEE_SHM_KERNEL_MAPPED;
 	struct tee_shm *shm;
 	void *ret;
 	int rc;
 	int num_pages;
 	unsigned long start;
 
-	if (flags != req_flags)
+	if (flags != req_flags && flags != req_ker_flags)
 		return ERR_PTR(-ENOTSUPP);
 
 	if (!tee_device_get(teedev))
@@ -264,7 +266,17 @@ struct tee_shm *tee_shm_register(struct tee_context *ctx, unsigned long addr,
 		goto err;
 	}
 
-	rc = get_user_pages_fast(start, num_pages, FOLL_WRITE, shm->pages);
+	if (flags & TEE_SHM_USER_MAPPED) {
+		rc = get_user_pages_fast(start, num_pages, FOLL_WRITE,
+					 shm->pages);
+	} else {
+		const struct kvec kiov = {
+			.iov_base = (void *)start,
+			.iov_len = PAGE_SIZE
+		};
+
+		rc = get_kernel_pages(&kiov, num_pages, 0, shm->pages);
+	}
 	if (rc > 0)
 		shm->num_pages = rc;
 	if (rc != num_pages) {
diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
index 7a03f68..dedf8fa 100644
--- a/include/linux/tee_drv.h
+++ b/include/linux/tee_drv.h
@@ -26,6 +26,7 @@
 #define TEE_SHM_REGISTER	BIT(3)  /* Memory registered in secure world */
 #define TEE_SHM_USER_MAPPED	BIT(4)  /* Memory mapped in user space */
 #define TEE_SHM_POOL		BIT(5)  /* Memory allocated from pool */
+#define TEE_SHM_KERNEL_MAPPED	BIT(6)  /* Memory mapped in kernel space */
 
 struct device;
 struct tee_device;
-- 
2.7.4

