Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48ABAC48BD4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 13:55:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B25C213F2
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 13:55:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SYUsrxCa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727770AbfFYNzL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 09:55:11 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40131 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726659AbfFYNzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 09:55:11 -0400
Received: by mail-wm1-f66.google.com with SMTP id v19so3059768wmj.5
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 06:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Fq/8wsmsvCxlpUInJ+iCbHsUO0noKhQjaU4ngOlYyq8=;
        b=SYUsrxCa9Ax5QjrWiqfKxEmD/uaIx3CEN77nR3iwQrD8xlQvUKybYgYBajfGiQ7SA9
         kTOLhipouE8pPRWjcnKTamBPpGHWnBQiH6cPvGHUbzZ3I/XVKER8OQf+UCcziJtNWyIF
         xB4S/EnEfpzaH1WAfY83tsbrT6o4RVMhtJxky6aP1b0iWHTMkAvvQoGQ6FLGjdK9PHAZ
         DDoQ5KtxRtBOhI26ZuGw4HUqHdRDoT+Ztphe+XLzlvHvomzRHRzWafORM5EINvcOQ06O
         PQIxl5n1c2umszMPbFmgUYnfbqFEX4Lh9HZ034i96td6/DnHiStY/g4EfrWd6kCRGMYm
         AryQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Fq/8wsmsvCxlpUInJ+iCbHsUO0noKhQjaU4ngOlYyq8=;
        b=Mf1vwvLzTZQA4gcIpIfO4rZOX/hMtRK4IsQQ+oNo/SiR28Eb5Xn9GyxebK0hDq2Y1j
         shnQjXvnJuDoqXEQegPXrkbbLJvUTF7HAp3H36VwtvS2iIXEDSAzBxLC7LIzWVKmE0RW
         thKbR7HaYcxnHWLGs7bqN4m2rDdci4Ly/l0qSQiLK3jrZv3mOznWcxwIKyw/q1naRVXX
         YrOwG2KgABM0gCFiEmmU3fMalB6m1sKrUyXc1hs/kWYNkhDdJ7Co34sJDLpe+Z0fnXqq
         VIl7a+62hJQIkDpbCSS/eyUcwXg+wJ+6mhNIqosN+LalxpCdhX3kYrHwcTN7r01IQl12
         ed4w==
X-Gm-Message-State: APjAAAW5Gz+whwBxkgqMWOTYVPlkt7VyzQokpVcDLIOQtYm/2n3deILm
        rjPJWjDeSbjC3CGCjsBOJED7Lvb4
X-Google-Smtp-Source: APXvYqyNstq4W1QhPq1QCzGR/Ck+rdGfukmhVDcL5yJuocUr5YWNivilxZI8Gt8LUNgOtvj+UE7+Rw==
X-Received: by 2002:a1c:968c:: with SMTP id y134mr19551284wmd.75.1561470908553;
        Tue, 25 Jun 2019 06:55:08 -0700 (PDT)
Received: from abel.fritz.box ([2a02:908:1252:fb60:2df2:5da:22f9:1506])
        by smtp.gmail.com with ESMTPSA id y44sm13814441wrd.13.2019.06.25.06.55.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Jun 2019 06:55:07 -0700 (PDT)
From:   "=?UTF-8?q?Christian=20K=C3=B6nig?=" 
        <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
To:     daniel@ffwll.ch, peterz@infradead.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dma-buf: add reservation_context for deadlock handling
Date:   Tue, 25 Jun 2019 15:55:06 +0200
Message-Id: <20190625135507.80548-1-christian.koenig@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ww_mutex framework allows for detecting deadlocks when multiple
threads try to acquire the same set of locks in different order.

The problem is that handling those deadlocks was the burden of the user of
the ww_mutex implementation and at least some users didn't got that right
on the first try.

So introduce a new reservation_context object which can be used to
simplify the deadlock handling. This is done by tracking all locked
reservation objects in the context as well as the last contended
reservation object.

When a deadlock occurse we now unlock all previously locked object and
acquire the contended lock in the slow path. After this is done -EDEADLK
is still returned to signal that all other locks now need to be
re-acquired again.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/dma-buf/reservation.c | 82 +++++++++++++++++++++++++++++++++++
 include/linux/reservation.h   | 38 ++++++++++++++++
 2 files changed, 120 insertions(+)

diff --git a/drivers/dma-buf/reservation.c b/drivers/dma-buf/reservation.c
index 4d32e2c67862..9e53e42b053a 100644
--- a/drivers/dma-buf/reservation.c
+++ b/drivers/dma-buf/reservation.c
@@ -55,6 +55,88 @@ EXPORT_SYMBOL(reservation_seqcount_class);
 const char reservation_seqcount_string[] = "reservation_seqcount";
 EXPORT_SYMBOL(reservation_seqcount_string);
 
+/**
+ * reservation_context_init - initialize a reservation context
+ * @ctx: the context to initialize
+ *
+ * Start using this reservation context to lock reservation objects for update.
+ */
+void reservation_context_init(struct reservation_context *ctx)
+{
+	ww_acquire_init(&ctx->ctx, &reservation_ww_class);
+	init_llist_head(&ctx->locked);
+	ctx->contended = NULL;
+}
+EXPORT_SYMBOL(reservation_context_init);
+
+/**
+ * reservation_context_unlock_all - unlock all reservation objects
+ * @ctx: the context which holds the reservation objects
+ *
+ * Unlocks all reservation objects locked with this context.
+ */
+void reservation_context_unlock_all(struct reservation_context *ctx)
+{
+	struct reservation_object *obj, *next;
+
+	if (ctx->contended)
+		ww_mutex_unlock(&ctx->contended->lock);
+	ctx->contended = NULL;
+
+	llist_for_each_entry_safe(obj, next, ctx->locked.first, locked)
+		ww_mutex_unlock(&obj->lock);
+	init_llist_head(&ctx->locked);
+}
+EXPORT_SYMBOL(reservation_context_unlock_all);
+
+/**
+ * reservation_context_lock - lock a reservation object with deadlock handling
+ * @ctx: the context which should be used to lock the object
+ * @obj: the object which needs to be locked
+ * @interruptible: if we should wait interruptible or not
+ *
+ * Use @ctx to lock the reservation object. If a deadlock is detected we backoff
+ * by releasing all locked objects and use the slow path to lock the reservation
+ * object. After successfully locking in the slow path -EDEADLK is returned to
+ * signal that all other locks must be re-taken as well.
+ */
+int reservation_context_lock(struct reservation_context *ctx,
+			     struct reservation_object *obj,
+			     bool interruptible)
+{
+	int ret = 0;
+
+	if (unlikely(ctx->contended == obj))
+		ctx->contended = NULL;
+	else if (interruptible)
+		ret = ww_mutex_lock_interruptible(&obj->lock, &ctx->ctx);
+	else
+		ret = ww_mutex_lock(&obj->lock, &ctx->ctx);
+
+	if (likely(!ret)) {
+		/* don't use llist_add here, we have separate locking */
+		obj->locked.next = ctx->locked.first;
+		ctx->locked.first = &obj->locked;
+		return 0;
+	}
+	if (unlikely(ret != -EDEADLK))
+		return ret;
+
+	reservation_context_unlock_all(ctx);
+
+	if (interruptible) {
+		ret = ww_mutex_lock_slow_interruptible(&obj->lock, &ctx->ctx);
+		if (unlikely(ret))
+			return ret;
+	} else {
+		ww_mutex_lock_slow(&obj->lock, &ctx->ctx);
+	}
+
+	ctx->contended = obj;
+	return -EDEADLK;
+}
+EXPORT_SYMBOL(reservation_context_lock);
+
 /**
  * reservation_object_reserve_shared - Reserve space to add shared fences to
  * a reservation_object.
diff --git a/include/linux/reservation.h b/include/linux/reservation.h
index ee750765cc94..a8a52e5d3e80 100644
--- a/include/linux/reservation.h
+++ b/include/linux/reservation.h
@@ -44,11 +44,48 @@
 #include <linux/slab.h>
 #include <linux/seqlock.h>
 #include <linux/rcupdate.h>
+#include <linux/llist.h>
 
 extern struct ww_class reservation_ww_class;
 extern struct lock_class_key reservation_seqcount_class;
 extern const char reservation_seqcount_string[];
 
+/**
+ * struct reservation_context - context to lock reservation objects
+ * @ctx: ww_acquire_ctx used for deadlock detection
+ * @locked: list of reservation objects locked in this context
+ * @contended: contended reservation object
+ */
+struct reservation_context {
+	struct ww_acquire_ctx ctx;
+	struct llist_head locked;
+	struct reservation_object *contended;
+};
+
+/**
+ * reservation_context_done - wrapper for ww_acquire_done
+ * @ctx: the reservation context which is done with locking
+ */
+static inline void reservation_context_done(struct reservation_context *ctx)
+{
+	ww_acquire_done(&ctx->ctx);
+}
+
+/**
+ * reservation_context_fini - wrapper for ww_acquire_fini
+ * @ctx: the reservation context which is finished
+ */
+static inline void reservation_context_fini(struct reservation_context *ctx)
+{
+	ww_acquire_fini(&ctx->ctx);
+}
+
+void reservation_context_init(struct reservation_context *ctx);
+void reservation_context_unlock_all(struct reservation_context *ctx);
+int reservation_context_lock(struct reservation_context *ctx,
+			     struct reservation_object *obj,
+			     bool interruptible);
+
 /**
  * struct reservation_object_list - a list of shared fences
  * @rcu: for internal use
@@ -71,6 +108,7 @@ struct reservation_object_list {
  */
 struct reservation_object {
 	struct ww_mutex lock;
+	struct llist_node locked;
 	seqcount_t seq;
 
 	struct dma_fence __rcu *fence_excl;
-- 
2.17.1

