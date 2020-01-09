Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F23B3C33CA2
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 12:37:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C85B02075D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 12:37:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cEQgiXqa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729687AbgAIMh1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 07:37:27 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:32773 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729607AbgAIMhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 07:37:25 -0500
Received: by mail-lj1-f195.google.com with SMTP id y6so7112332lji.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 04:37:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=m+zKWVO9TLVpTp9i0f9ernZ1zXoj4gKi+YUbC7Ltz2s=;
        b=cEQgiXqa3+cQZm1ve97A9JbfnBQCFSW56kelcwbCfUGFz42EsDR7jdt4LPz2WzwsNw
         l9VZmKvHCuBYwpiEVMBvE6DLIiCMyi4vHxIcRMhWG7S/ICjsMbdSSDf7XzUevUup3qSa
         WiGQINg4a2RNJBMXQA5rZNinxCHmlZ7CRepc2Tf2ByDmCX/2rME0g9tovfpmEXpFdAGk
         h09PNJcRFV+G+5nMjYKrsUfYZ/qg00LWzssvCt8sA5CUPt3JJuz6njSqXecLQSpIt8FJ
         U5F2L7f0EEHd7KTf1zwVoPCW5+nyuOiAi6G4lgf1eiUsooewg+HD9WIBopdbitWckREE
         kDEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=m+zKWVO9TLVpTp9i0f9ernZ1zXoj4gKi+YUbC7Ltz2s=;
        b=khhKPOg1vK/Wc00HxXv/F3s4ld9ohNQ5ALHk734dPTo4Ll1XEvNd/bpMV6o/xzWFF0
         70xaoW7yM/msl5kVcpPgojRnzcU+4WYhUEJ3TDozvk+YtZa4SvRGvsXOHdENrgDqzTIA
         2yYuGfHwoDnfOY6jqP12M4NZSsr3cbWuo/mIY80bX9Gl/eczgruKdFmYsACv+/IkmZ/a
         8pXLr3uhrMrJ9Urtt5km+kXzrYXc60pOqv3jB2DKtdCxUYAGnOgghs/6wPrQKgmwYcmx
         +bu00c9M054CGzswAMCLy8dqU5mdSgb2qxqyx1q10ChZnFTIz82cRyQsyeJM8lpEO8OC
         KyiQ==
X-Gm-Message-State: APjAAAUVj5LDs61l9UJbBXQmabxG3T0lBHPrFqPua/mdcFD1cWcuIPZ7
        CbV2cAlAqcjy9Km75Ram2Lr0lQ==
X-Google-Smtp-Source: APXvYqyclBcFxWDYkwVsygkW+EYYaSYSeckiu3GjZmonF/L3lUd7nc+VX3DKEGGQzUvnzL+mDTyhQQ==
X-Received: by 2002:a05:651c:1b3:: with SMTP id c19mr6660158ljn.115.1578573443839;
        Thu, 09 Jan 2020 04:37:23 -0800 (PST)
Received: from jax.urgonet (h-249-223.A175.priv.bahnhof.se. [98.128.249.223])
        by smtp.gmail.com with ESMTPSA id u16sm2887724ljo.22.2020.01.09.04.37.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 04:37:23 -0800 (PST)
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     tee-dev@lists.linaro.org, linux-kernel@vger.kernel.org
Cc:     Jerome Forissier <jerome@forissier.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Etienne Carriere <etienne.carriere@linaro.org>,
        Rijo Thomas <Rijo-john.Thomas@amd.com>,
        Devaraj Rangasamy <Devaraj.Rangasamy@amd.com>,
        Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH 3/5] tee: don't assign shm id for private shms
Date:   Thu,  9 Jan 2020 13:36:49 +0100
Message-Id: <20200109123651.18520-4-jens.wiklander@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200109123651.18520-1-jens.wiklander@linaro.org>
References: <20200109123651.18520-1-jens.wiklander@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Private shared memory object must not be referenced from user space. To
guarantee that, don't assign an id to shared memory objects which are
driver private.

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 drivers/tee/tee_private.h |  3 ++-
 drivers/tee/tee_shm.c     | 31 ++++++++++++++++++-------------
 2 files changed, 20 insertions(+), 14 deletions(-)

diff --git a/drivers/tee/tee_private.h b/drivers/tee/tee_private.h
index f797171f0434..e55204df31ce 100644
--- a/drivers/tee/tee_private.h
+++ b/drivers/tee/tee_private.h
@@ -37,7 +37,8 @@ struct tee_shm_pool {
  * @num_users:	number of active users of this device
  * @c_no_user:	completion used when unregistering the device
  * @mutex:	mutex protecting @num_users and @idr
- * @idr:	register of shared memory object allocated on this device
+ * @idr:	register of user space shared memory objects allocated or
+ *		registered on this device
  * @pool:	shared memory pool
  */
 struct tee_device {
diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
index 8afe08b23242..e636cf82acdb 100644
--- a/drivers/tee/tee_shm.c
+++ b/drivers/tee/tee_shm.c
@@ -15,9 +15,11 @@ static void tee_shm_release(struct tee_shm *shm)
 {
 	struct tee_device *teedev = shm->teedev;
 
-	mutex_lock(&teedev->mutex);
-	idr_remove(&teedev->idr, shm->id);
-	mutex_unlock(&teedev->mutex);
+	if (shm->flags & TEE_SHM_DMA_BUF) {
+		mutex_lock(&teedev->mutex);
+		idr_remove(&teedev->idr, shm->id);
+		mutex_unlock(&teedev->mutex);
+	}
 
 	if (shm->flags & TEE_SHM_POOL) {
 		struct tee_shm_pool_mgr *poolm;
@@ -143,17 +145,18 @@ struct tee_shm *tee_shm_alloc(struct tee_context *ctx, size_t size, u32 flags)
 		goto err_kfree;
 	}
 
-	mutex_lock(&teedev->mutex);
-	shm->id = idr_alloc(&teedev->idr, shm, 1, 0, GFP_KERNEL);
-	mutex_unlock(&teedev->mutex);
-	if (shm->id < 0) {
-		ret = ERR_PTR(shm->id);
-		goto err_pool_free;
-	}
 
 	if (flags & TEE_SHM_DMA_BUF) {
 		DEFINE_DMA_BUF_EXPORT_INFO(exp_info);
 
+		mutex_lock(&teedev->mutex);
+		shm->id = idr_alloc(&teedev->idr, shm, 1, 0, GFP_KERNEL);
+		mutex_unlock(&teedev->mutex);
+		if (shm->id < 0) {
+			ret = ERR_PTR(shm->id);
+			goto err_pool_free;
+		}
+
 		exp_info.ops = &tee_shm_dma_buf_ops;
 		exp_info.size = shm->size;
 		exp_info.flags = O_RDWR;
@@ -171,9 +174,11 @@ struct tee_shm *tee_shm_alloc(struct tee_context *ctx, size_t size, u32 flags)
 
 	return shm;
 err_rem:
-	mutex_lock(&teedev->mutex);
-	idr_remove(&teedev->idr, shm->id);
-	mutex_unlock(&teedev->mutex);
+	if (flags & TEE_SHM_DMA_BUF) {
+		mutex_lock(&teedev->mutex);
+		idr_remove(&teedev->idr, shm->id);
+		mutex_unlock(&teedev->mutex);
+	}
 err_pool_free:
 	poolm->ops->free(poolm, shm);
 err_kfree:
-- 
2.17.1

