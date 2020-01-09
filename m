Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E4ADC32771
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 12:37:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E486A206ED
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 12:37:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hwBDdSr7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729756AbgAIMh1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 07:37:27 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:44118 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728925AbgAIMh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 07:37:27 -0500
Received: by mail-lj1-f195.google.com with SMTP id u71so7000689lje.11
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 04:37:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5KD/2e75f6x17C/yWNN9lJ6c3FFXNUAEGSK6KA9QyHc=;
        b=hwBDdSr7WL1hbEYdEVYShfN5tXgJMyByGcTrycNP2NCiZWYa90T0uSS1duVBeG3wcx
         VEf173mbnI0xtaCYhSi1yzw1x9GuXvVtzOuZ0MVQV1ni5e+CkgjRTOU2mcQrmEDKHdYr
         /c4NLAM1byBcwZW3JcI2GYsSy7/H81ElDtzCqLnu5tkWOMs7/JbtUopyJhb8CZ7Jszmh
         jfvSBHtxTZrLUZA0TxfCTlwzq6/8isYtjh5o+OwM4QGGxxI6TssUZmdmFtjAludyJfpy
         X2vYkFI+d4CRjOKouiSwvHGC0SBMITmOooONoFAzwZdLuKuJ5cL0MHbkwRe2QUN0AoEj
         Tlkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5KD/2e75f6x17C/yWNN9lJ6c3FFXNUAEGSK6KA9QyHc=;
        b=N/+CVHXnabF3NIdWhIm9NF1mfdg+FqTpJ0PTGGMmnO6DLnwkhqu/L2FI57R3zoKgzN
         P4MhpK01/sWtkKkPd7zR2XysaHLcBz2R9jKLrdng7TGPt1tD9aqGoo2t5n5tnLidbwoU
         E6KeqCJn5mXUH5SVWWMPuY2J6wyJIYB3rabqIwTUSzw62dNdIkNIGDiVO91KSURHTIOf
         r1LLbWPK2fesn1aVsFDXu83pPdZyMwK7M0zlG7Ief9C4eFtOJvOXuP5T/ifSqMxklH8z
         S5nPb+CYsDtAvco8TQ2rhlSYDBxP0ZZzisd5UcgVRc+YVNdvYGWSGQ105Z3z6mY91FRo
         fenw==
X-Gm-Message-State: APjAAAVDMIqupcU/IrvJ0kg0L7mrPxX+QoR2ogePdkT9YtF52YsrvGAU
        O1JusNAGFssr+wfM9ecn2qws4Q==
X-Google-Smtp-Source: APXvYqwlnulDrn/OVZFEfC7A4zhXwL1W37Gitw/kGfEymgF8YDh/GDiCLwd1otNIZu/BEzr4CAOWuQ==
X-Received: by 2002:a2e:9a04:: with SMTP id o4mr6722903lji.214.1578573445054;
        Thu, 09 Jan 2020 04:37:25 -0800 (PST)
Received: from jax.urgonet (h-249-223.A175.priv.bahnhof.se. [98.128.249.223])
        by smtp.gmail.com with ESMTPSA id u16sm2887724ljo.22.2020.01.09.04.37.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 04:37:24 -0800 (PST)
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     tee-dev@lists.linaro.org, linux-kernel@vger.kernel.org
Cc:     Jerome Forissier <jerome@forissier.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Etienne Carriere <etienne.carriere@linaro.org>,
        Rijo Thomas <Rijo-john.Thomas@amd.com>,
        Devaraj Rangasamy <Devaraj.Rangasamy@amd.com>,
        Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH 4/5] tee: remove redundant teedev in struct tee_shm
Date:   Thu,  9 Jan 2020 13:36:50 +0100
Message-Id: <20200109123651.18520-5-jens.wiklander@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200109123651.18520-1-jens.wiklander@linaro.org>
References: <20200109123651.18520-1-jens.wiklander@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ctx element in struct tee_shm is always valid. So remove the now
redundant teedev element.

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 drivers/tee/tee_shm.c   | 7 ++-----
 include/linux/tee_drv.h | 4 +---
 2 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
index e636cf82acdb..c64ec5c5e464 100644
--- a/drivers/tee/tee_shm.c
+++ b/drivers/tee/tee_shm.c
@@ -13,7 +13,7 @@
 
 static void tee_shm_release(struct tee_shm *shm)
 {
-	struct tee_device *teedev = shm->teedev;
+	struct tee_device *teedev = shm->ctx->teedev;
 
 	if (shm->flags & TEE_SHM_DMA_BUF) {
 		mutex_lock(&teedev->mutex);
@@ -44,8 +44,7 @@ static void tee_shm_release(struct tee_shm *shm)
 		kfree(shm->pages);
 	}
 
-	if (shm->ctx)
-		teedev_ctx_put(shm->ctx);
+	teedev_ctx_put(shm->ctx);
 
 	kfree(shm);
 
@@ -132,7 +131,6 @@ struct tee_shm *tee_shm_alloc(struct tee_context *ctx, size_t size, u32 flags)
 	}
 
 	shm->flags = flags | TEE_SHM_POOL;
-	shm->teedev = teedev;
 	shm->ctx = ctx;
 	if (flags & TEE_SHM_DMA_BUF)
 		poolm = teedev->pool->dma_buf_mgr;
@@ -221,7 +219,6 @@ struct tee_shm *tee_shm_register(struct tee_context *ctx, unsigned long addr,
 	}
 
 	shm->flags = flags | TEE_SHM_REGISTER;
-	shm->teedev = teedev;
 	shm->ctx = ctx;
 	shm->id = -1;
 	addr = untagged_addr(addr);
diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
index 42687f6c546d..1412e9cc79ce 100644
--- a/include/linux/tee_drv.h
+++ b/include/linux/tee_drv.h
@@ -167,8 +167,7 @@ void tee_device_unregister(struct tee_device *teedev);
 
 /**
  * struct tee_shm - shared memory object
- * @teedev:	device used to allocate the object
- * @ctx:	context using the object, if NULL the context is gone
+ * @ctx:	context using the object
  * @paddr:	physical address of the shared memory
  * @kaddr:	virtual address of the shared memory
  * @size:	size of shared memory
@@ -183,7 +182,6 @@ void tee_device_unregister(struct tee_device *teedev);
  * subsystem and from drivers that implements their own shm pool manager.
  */
 struct tee_shm {
-	struct tee_device *teedev;
 	struct tee_context *ctx;
 	phys_addr_t paddr;
 	void *kaddr;
-- 
2.17.1

