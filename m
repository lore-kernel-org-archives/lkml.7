Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDB4CC31E4C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 12:41:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A35092133D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 12:41:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pQOCCGqA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728005AbfFNMlh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 08:41:37 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33177 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727573AbfFNMlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 08:41:31 -0400
Received: by mail-wr1-f67.google.com with SMTP id n9so2412390wru.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2019 05:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=ydRvlr8GrTeHWJG9VkVQSxp2WSHz7znDNO6P33s8ZXY=;
        b=pQOCCGqAMDd6pBzhOwghY/3foEwLP4s4c1Wc1dGov2C4zJBl+VjVFjKY+zhxqdq1Lf
         zIBsPKYcMbzfB9ZiDJ0x0+Mb04T3GDUtHp/dKTOynwDMMiDcETM16YHXm/T4Z/uZZEcB
         fOmRqgpEBT0WQ6nV+dK10V64uDR41sjO2GLZrH5RLG3ERGj/gIzpj1fbF5OQryA8w/6X
         TjYDsXg3Echybd6tIIYKs0U/miL0HLlMPWxnV9FpRHYaVKZC4xj9zYYqBuqvMNj5uQyY
         /a/w/cw13oDHALmSZU78tClcu7pqqVpeVR0OZQnT+hEDzYnpwZAf7sYhYLKCVHw8n///
         S0Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ydRvlr8GrTeHWJG9VkVQSxp2WSHz7znDNO6P33s8ZXY=;
        b=I+xa3tKogoiXz40HBMo30VQElKrpQ+7yzqio9g6jMbigA2LMKdsSK8+94hfMQMYNCg
         cMDcB1mzmhY5hoyRjrnwd+eyIFraKW5LlWvdT9x8LPo5oJ9HXpjja15dEsCOJsAFXsJ0
         +r78Jk8y1NjqTYl8HW/jQ0mv2wgXqqTfvJ/FR5XvmAg2WPPwuW3jrpg4p7OLMg0HWYcC
         tkYBeZV7vXuxf/GY8WB1wl21zHXza8hCUb1tzg1rCr9zsKkD+sx/pSpAdC3F8uO9QPqJ
         2o4PbkglAEUnC6XWzkuoc6e6baW9xyP4vP6znJfqq2c2TPC9nk6XFJTWYonTS3OjHwNY
         sU+g==
X-Gm-Message-State: APjAAAVo+4Tu6QjnjvTYpJ/o1MwwxNOQIMOvpMcCPgrmr+iXA83pG/J6
        dnNc5UtyE1zUNUyFGod79wY=
X-Google-Smtp-Source: APXvYqxemwoMWkSm1jSN79GD079pyYew4LokB4mGKgAC5BALG1haYBR1QzGpWEjJCSHvxOAHbuLLzw==
X-Received: by 2002:adf:df10:: with SMTP id y16mr5861671wrl.302.1560516088657;
        Fri, 14 Jun 2019 05:41:28 -0700 (PDT)
Received: from abel.fritz.box ([2a02:908:1252:fb60:e0eb:ed4e:b781:3e9f])
        by smtp.gmail.com with ESMTPSA id n1sm2648209wrx.39.2019.06.14.05.41.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Jun 2019 05:41:28 -0700 (PDT)
From:   "=?UTF-8?q?Christian=20K=C3=B6nig?=" 
        <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
To:     daniel@ffwll.ch, l.stach@pengutronix.de,
        linux+etnaviv@armlinux.org.uk, christian.gmeiner@gmail.com,
        yuq825@gmail.com, eric@anholt.net, peterz@infradead.org,
        thellstrom@vmware.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, etnaviv@lists.freedesktop.org,
        lima@lists.freedesktop.org
Subject: [PATCH 1/6] locking: add ww_mutex_(un)lock_for_each helpers
Date:   Fri, 14 Jun 2019 14:41:20 +0200
Message-Id: <20190614124125.124181-2-christian.koenig@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190614124125.124181-1-christian.koenig@amd.com>
References: <20190614124125.124181-1-christian.koenig@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ww_mutex implementation allows for detection deadlocks when multiple
threads try to acquire the same set of locks in different order.

The problem is that handling those deadlocks was the burden of the user of
the ww_mutex implementation and at least some users didn't got that right
on the first try.

I'm not a big fan of macros, but it still better then implementing the same
logic at least halve a dozen times. So this patch adds two macros to lock
and unlock multiple ww_mutex instances with the necessary deadlock handling.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 include/linux/ww_mutex.h | 75 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/include/linux/ww_mutex.h b/include/linux/ww_mutex.h
index 3af7c0e03be5..a0d893b5b114 100644
--- a/include/linux/ww_mutex.h
+++ b/include/linux/ww_mutex.h
@@ -369,4 +369,79 @@ static inline bool ww_mutex_is_locked(struct ww_mutex *lock)
 	return mutex_is_locked(&lock->base);
 }
 
+/**
+ * ww_mutex_unlock_for_each - cleanup after error or contention
+ * @loop: for loop code fragment iterating over all the locks
+ * @pos: code fragment returning the currently handled lock
+ * @contended: the last contended ww_mutex or NULL or ERR_PTR
+ *
+ * Helper to make cleanup after error or lock contention easier.
+ * First unlock the last contended lock and then all other locked ones.
+ */
+#define ww_mutex_unlock_for_each(loop, pos, contended)	\
+	if (!IS_ERR(contended)) {			\
+		if (contended)				\
+			ww_mutex_unlock(contended);	\
+		contended = (pos);			\
+		loop {					\
+			if (contended == (pos))		\
+				break;			\
+			ww_mutex_unlock(pos);		\
+		}					\
+	}
+
+/**
+ * ww_mutex_lock_for_each - implement ww_mutex deadlock handling
+ * @loop: for loop code fragment iterating over all the locks
+ * @pos: code fragment returning the currently handled lock
+ * @contended: ww_mutex pointer variable for state handling
+ * @ret: int variable to store the return value of ww_mutex_lock()
+ * @intr: If true ww_mutex_lock_interruptible() is used
+ * @ctx: ww_acquire_ctx pointer for the locking
+ *
+ * This macro implements the necessary logic to lock multiple ww_mutex
+ * instances. Lock contention with backoff and re-locking is handled by the
+ * macro so that the loop body only need to handle other errors and
+ * successfully acquired locks.
+ *
+ * With the @loop and @pos code fragment it is possible to apply this logic
+ * to all kind of containers (array, list, tree, etc...) holding multiple
+ * ww_mutex instances.
+ *
+ * @contended is used to hold the current state we are in. -ENOENT is used to
+ * signal that we are just starting the handling. -EDEADLK means that the
+ * current position is contended and we need to restart the loop after locking
+ * it. NULL means that there is no contention to be handled. Any other value is
+ * the last contended ww_mutex.
+ */
+#define ww_mutex_lock_for_each(loop, pos, contended, ret, intr, ctx)	\
+	for (contended = ERR_PTR(-ENOENT); ({				\
+		__label__ relock, next;					\
+		ret = -ENOENT;						\
+		if (contended == ERR_PTR(-ENOENT))			\
+			contended = NULL;				\
+		else if (contended == ERR_PTR(-EDEADLK))		\
+			contended = (pos);				\
+		else							\
+			goto next;					\
+		loop {							\
+			if (contended == (pos))	{			\
+				contended = NULL;			\
+				continue;				\
+			}						\
+relock:									\
+			ret = !(intr) ? ww_mutex_lock(pos, ctx) :	\
+				ww_mutex_lock_interruptible(pos, ctx);	\
+			if (ret == -EDEADLK) {				\
+				ww_mutex_unlock_for_each(loop, pos,	\
+							 contended);	\
+				contended = ERR_PTR(-EDEADLK);		\
+				goto relock;				\
+			}						\
+			break;						\
+next:									\
+			continue;					\
+		}							\
+	}), ret != -ENOENT;)
+
 #endif
-- 
2.17.1

