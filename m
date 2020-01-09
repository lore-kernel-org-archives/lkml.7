Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1BBCC32771
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 12:37:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97F0C206ED
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 12:37:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j3fnF3SC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729620AbgAIMhY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 07:37:24 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39405 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728925AbgAIMhX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 07:37:23 -0500
Received: by mail-lj1-f196.google.com with SMTP id l2so7048995lja.6
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 04:37:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DapFo7QvZ/nQtlvq1G7tXg+K9hOg8zrkdknT+T3enfE=;
        b=j3fnF3SCzRm36Ul5fOtjNqsysynAbawq0BkyG9ddhn7ARggmE8R01V7x/1V30EfZK+
         7fn3RCbhvJmaewcXpkwQGqGAyUL7KwFxKNYT1vY0gK5tQEYJPdf2NhfNmVmlrqVz2xRW
         OepVCs+6u+qmEpxRPZqr7akrqKJW0AV4fsWFkhUVU5pgTXrhh+kxH5uW8no5akEnKFU3
         EDBlh2zGE643V0kfTX/xLBqxz1BBaiCgfd8fRRwW2P1ddv2BT9QuaFtjypVfEUtQKYw2
         uL1vor0WYGiNuX9rTZt+7qzEQbsnW1H5A5vC1MZCwlaqXTgIVhvvyyoBKrNVXaujV6BF
         QphA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DapFo7QvZ/nQtlvq1G7tXg+K9hOg8zrkdknT+T3enfE=;
        b=foEkSZRD6LF2J7Qsat0Nrsmm6Ss+9dhvBlzMF1hlt/haoQqIEJuSGzM+qu+qHtocOP
         AquvV7VQW68RGwNy7Ee/zXtXLRGWQjEqxx4Ws61B5TfQ3VGke2vj2i3q4EJTMXK5U6ob
         Xxwe8L+z1fXrbG1nkskXBC5iXww6C7L3PXu8C57cc9Pn3Y2Ct+JGR6RsHQpI1cERnuIb
         OY6McKoxgnZ9pbcVRoG+2mILrsUlfN1X+JAZMU85c5TjCT9CPqZB8KJ63BrOIUMSURVb
         /yGPKCPAUkydCJT6sY8Koh9v9r0LGusb0+ITFvWOvnE5NUksf1YuGRzbaAq9zH+p4+UM
         Yigg==
X-Gm-Message-State: APjAAAXdBsuLCLY7LijsmsA4r1x/bcUOXqTXsHz8E1wKnUGascyh3sLy
        HYec8YebXrxOq0WTTBhHU7AnHw==
X-Google-Smtp-Source: APXvYqw+YohJh2EP1e9IDoEwFSgAQxBhunpU4hUnPei2UaMVwOuy/wQZCsl5X+dHdhdLZLH6HbnURw==
X-Received: by 2002:a2e:9ad8:: with SMTP id p24mr6459232ljj.148.1578573441345;
        Thu, 09 Jan 2020 04:37:21 -0800 (PST)
Received: from jax.urgonet (h-249-223.A175.priv.bahnhof.se. [98.128.249.223])
        by smtp.gmail.com with ESMTPSA id u16sm2887724ljo.22.2020.01.09.04.37.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 04:37:20 -0800 (PST)
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     tee-dev@lists.linaro.org, linux-kernel@vger.kernel.org
Cc:     Jerome Forissier <jerome@forissier.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Etienne Carriere <etienne.carriere@linaro.org>,
        Rijo Thomas <Rijo-john.Thomas@amd.com>,
        Devaraj Rangasamy <Devaraj.Rangasamy@amd.com>,
        Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH 1/5] tee: remove linked list of struct tee_shm
Date:   Thu,  9 Jan 2020 13:36:47 +0100
Message-Id: <20200109123651.18520-2-jens.wiklander@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200109123651.18520-1-jens.wiklander@linaro.org>
References: <20200109123651.18520-1-jens.wiklander@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removes list_shm from struct tee_context since the linked list isn't used
any longer.

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 drivers/tee/tee_core.c  |  1 -
 drivers/tee/tee_shm.c   | 12 +-----------
 include/linux/tee_drv.h |  3 ---
 3 files changed, 1 insertion(+), 15 deletions(-)

diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
index 37d22e39fd8d..6aec502c495c 100644
--- a/drivers/tee/tee_core.c
+++ b/drivers/tee/tee_core.c
@@ -44,7 +44,6 @@ static struct tee_context *teedev_open(struct tee_device *teedev)
 
 	kref_init(&ctx->refcount);
 	ctx->teedev = teedev;
-	INIT_LIST_HEAD(&ctx->list_shm);
 	rc = teedev->desc->ops->open(ctx);
 	if (rc)
 		goto err;
diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
index 09ddcd06c715..6cabb834db7d 100644
--- a/drivers/tee/tee_shm.c
+++ b/drivers/tee/tee_shm.c
@@ -17,8 +17,6 @@ static void tee_shm_release(struct tee_shm *shm)
 
 	mutex_lock(&teedev->mutex);
 	idr_remove(&teedev->idr, shm->id);
-	if (shm->ctx)
-		list_del(&shm->link);
 	mutex_unlock(&teedev->mutex);
 
 	if (shm->flags & TEE_SHM_POOL) {
@@ -174,12 +172,8 @@ static struct tee_shm *__tee_shm_alloc(struct tee_context *ctx,
 		}
 	}
 
-	if (ctx) {
+	if (ctx)
 		teedev_ctx_get(ctx);
-		mutex_lock(&teedev->mutex);
-		list_add_tail(&shm->link, &ctx->list_shm);
-		mutex_unlock(&teedev->mutex);
-	}
 
 	return shm;
 err_rem:
@@ -307,10 +301,6 @@ struct tee_shm *tee_shm_register(struct tee_context *ctx, unsigned long addr,
 		}
 	}
 
-	mutex_lock(&teedev->mutex);
-	list_add_tail(&shm->link, &ctx->list_shm);
-	mutex_unlock(&teedev->mutex);
-
 	return shm;
 err:
 	if (shm) {
diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
index 7a03f68fb982..cbddb883a7f8 100644
--- a/include/linux/tee_drv.h
+++ b/include/linux/tee_drv.h
@@ -49,7 +49,6 @@ struct tee_shm_pool;
  */
 struct tee_context {
 	struct tee_device *teedev;
-	struct list_head list_shm;
 	void *data;
 	struct kref refcount;
 	bool releasing;
@@ -170,7 +169,6 @@ void tee_device_unregister(struct tee_device *teedev);
  * struct tee_shm - shared memory object
  * @teedev:	device used to allocate the object
  * @ctx:	context using the object, if NULL the context is gone
- * @link	link element
  * @paddr:	physical address of the shared memory
  * @kaddr:	virtual address of the shared memory
  * @size:	size of shared memory
@@ -187,7 +185,6 @@ void tee_device_unregister(struct tee_device *teedev);
 struct tee_shm {
 	struct tee_device *teedev;
 	struct tee_context *ctx;
-	struct list_head link;
 	phys_addr_t paddr;
 	void *kaddr;
 	size_t size;
-- 
2.17.1

