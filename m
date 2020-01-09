Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69642C32771
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 12:37:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E86D2075D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 12:37:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ut+WtLUt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729881AbgAIMhh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 07:37:37 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:38824 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728660AbgAIMhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 07:37:24 -0500
Received: by mail-lj1-f194.google.com with SMTP id w1so7069552ljh.5
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 04:37:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0SiPYkpY1LZoKU7ldF/7ST/2p0dy5rt5wH0O4CV27+M=;
        b=ut+WtLUt+pWdeMMS9uQnf0695MJcJzhFVZPGp6n2yJdGkJ63SPUSLX4YBjOWUmrlIj
         BYLV6R2eblFlnMpmHaVqXJGo/a2vvA9RQ0B92Deq5J3ohCgvYoKqX1n365g6UuwlFLxl
         CXA+SZwkGhaZbA+vWNQ/h7yqHF5QMMDSLPgo6Rl9sLb/5dR88cl2MZ2wgJeMvI2EEktR
         /xopYHyiZQiQRB4v/RM7KhNRhZzp3c+krDQH0p9W6oJYE2IzsXD/1xCHjPCczkcQHDKj
         JuEDnTMRf6uOVGxyWGtvFc1SZKZLJUiITLGcAq5N0N5PNNGnXlShsF+DhKJgeHrKgbNO
         PcXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0SiPYkpY1LZoKU7ldF/7ST/2p0dy5rt5wH0O4CV27+M=;
        b=Kt8RWJCEo3ivl+Fd7Z9FVud7WRZ6YfeEXcxD0dp0nkvLLCNWKWJJ7VgPI3AaGvVIw3
         POxaRDPrmtle51VkcDx5iPdDkAUSHntgu3h1ALwIgu6RJNfvj4mY69XdgEL/+F+pbxhm
         mg5KFeuBNwn0BD0GxAe7A074WhsyZpDbf2Ch1AIX/nPXHG6v8RB1iU7h/NxX/zPU6G3X
         1aw3QPXVzOewkW2kErCmP6nnGpBgi/gb6F9jYbad4e5M6CCV1BsyZ1emTIT2faZGypjx
         CeH7Z5Cb7sxctdGpY8LpvUOBCUWvChT+FuMMtz0O0DSO1K8qbl1PgZa1x0rwI4P2GwUH
         vZ7w==
X-Gm-Message-State: APjAAAUQsjsYfGBpL7AtosamuZ2XUNr44axEkVz/tdZxUSpL3JYmshJf
        TR5+r/uVia60csCKTbi5D+dEnQ==
X-Google-Smtp-Source: APXvYqwSidHTC+rWtz8NqvtvCCR/vrebJWl9LIeuT91aGsl+rvCSvHfRSiC9O+qKFLNlyR0MMzuH0A==
X-Received: by 2002:a05:651c:20a:: with SMTP id y10mr6452038ljn.216.1578573442603;
        Thu, 09 Jan 2020 04:37:22 -0800 (PST)
Received: from jax.urgonet (h-249-223.A175.priv.bahnhof.se. [98.128.249.223])
        by smtp.gmail.com with ESMTPSA id u16sm2887724ljo.22.2020.01.09.04.37.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 04:37:22 -0800 (PST)
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     tee-dev@lists.linaro.org, linux-kernel@vger.kernel.org
Cc:     Jerome Forissier <jerome@forissier.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Etienne Carriere <etienne.carriere@linaro.org>,
        Rijo Thomas <Rijo-john.Thomas@amd.com>,
        Devaraj Rangasamy <Devaraj.Rangasamy@amd.com>,
        Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH 2/5] tee: remove unused tee_shm_priv_alloc()
Date:   Thu,  9 Jan 2020 13:36:48 +0100
Message-Id: <20200109123651.18520-3-jens.wiklander@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200109123651.18520-1-jens.wiklander@linaro.org>
References: <20200109123651.18520-1-jens.wiklander@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tee_shm_priv_alloc() isn't useful in the current state and it's also not
not used so remove it.

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 drivers/tee/tee_shm.c   | 33 ++-------------------------------
 include/linux/tee_drv.h | 12 ------------
 2 files changed, 2 insertions(+), 43 deletions(-)

diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
index 6cabb834db7d..8afe08b23242 100644
--- a/drivers/tee/tee_shm.c
+++ b/drivers/tee/tee_shm.c
@@ -95,20 +95,14 @@ static const struct dma_buf_ops tee_shm_dma_buf_ops = {
 	.mmap = tee_shm_op_mmap,
 };
 
-static struct tee_shm *__tee_shm_alloc(struct tee_context *ctx,
-				       struct tee_device *teedev,
-				       size_t size, u32 flags)
+struct tee_shm *tee_shm_alloc(struct tee_context *ctx, size_t size, u32 flags)
 {
+	struct tee_device *teedev = ctx->teedev;
 	struct tee_shm_pool_mgr *poolm = NULL;
 	struct tee_shm *shm;
 	void *ret;
 	int rc;
 
-	if (ctx && ctx->teedev != teedev) {
-		dev_err(teedev->dev.parent, "ctx and teedev mismatch\n");
-		return ERR_PTR(-EINVAL);
-	}
-
 	if (!(flags & TEE_SHM_MAPPED)) {
 		dev_err(teedev->dev.parent,
 			"only mapped allocations supported\n");
@@ -188,31 +182,8 @@ static struct tee_shm *__tee_shm_alloc(struct tee_context *ctx,
 	tee_device_put(teedev);
 	return ret;
 }
-
-/**
- * tee_shm_alloc() - Allocate shared memory
- * @ctx:	Context that allocates the shared memory
- * @size:	Requested size of shared memory
- * @flags:	Flags setting properties for the requested shared memory.
- *
- * Memory allocated as global shared memory is automatically freed when the
- * TEE file pointer is closed. The @flags field uses the bits defined by
- * TEE_SHM_* in <linux/tee_drv.h>. TEE_SHM_MAPPED must currently always be
- * set. If TEE_SHM_DMA_BUF global shared memory will be allocated and
- * associated with a dma-buf handle, else driver private memory.
- */
-struct tee_shm *tee_shm_alloc(struct tee_context *ctx, size_t size, u32 flags)
-{
-	return __tee_shm_alloc(ctx, ctx->teedev, size, flags);
-}
 EXPORT_SYMBOL_GPL(tee_shm_alloc);
 
-struct tee_shm *tee_shm_priv_alloc(struct tee_device *teedev, size_t size)
-{
-	return __tee_shm_alloc(NULL, teedev, size, TEE_SHM_MAPPED);
-}
-EXPORT_SYMBOL_GPL(tee_shm_priv_alloc);
-
 struct tee_shm *tee_shm_register(struct tee_context *ctx, unsigned long addr,
 				 size_t length, u32 flags)
 {
diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
index cbddb883a7f8..42687f6c546d 100644
--- a/include/linux/tee_drv.h
+++ b/include/linux/tee_drv.h
@@ -315,18 +315,6 @@ void *tee_get_drvdata(struct tee_device *teedev);
  */
 struct tee_shm *tee_shm_alloc(struct tee_context *ctx, size_t size, u32 flags);
 
-/**
- * tee_shm_priv_alloc() - Allocate shared memory privately
- * @dev:	Device that allocates the shared memory
- * @size:	Requested size of shared memory
- *
- * Allocates shared memory buffer that is not associated with any client
- * context. Such buffers are owned by TEE driver and used for internal calls.
- *
- * @returns a pointer to 'struct tee_shm'
- */
-struct tee_shm *tee_shm_priv_alloc(struct tee_device *teedev, size_t size);
-
 /**
  * tee_shm_register() - Register shared memory buffer
  * @ctx:	Context that registers the shared memory
-- 
2.17.1

