Return-Path: <SRS0=ATYp=YN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 429D1CA9EAE
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Oct 2019 12:33:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1174F2089C
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Oct 2019 12:33:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=colorfullife-com.20150623.gappssmtp.com header.i=@colorfullife-com.20150623.gappssmtp.com header.b="v+QqMerf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726423AbfJTMdY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Oct 2019 08:33:24 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36031 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726295AbfJTMdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Oct 2019 08:33:23 -0400
Received: by mail-wr1-f68.google.com with SMTP id w18so10241871wrt.3
        for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2019 05:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorfullife-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OZT+NISkOyfbxR8rapjvnBr1FAL+HjL4G2bXcv5bE7k=;
        b=v+QqMerf2KjUeGUeOHN5ES/geH/ND+WZUVKaqW9Be3poiotNwyP3yycbkYsD0TW8Bw
         aAREBHHxhCi7KW0/xlfU6oJ4hAiPhOvX6gDfB+5mfYoUO0/ItDt+G8jQ3xuEguXmu0ex
         La2hBmyCKDIhWf0QVOKFPulVltlVzboAO5SNfMbtIGufdlxWaLjuCIZUYmwWU9X7exyu
         qL542r3nsV1ftlxaZDwr4d/PDXgH534TMui3ju//4cDsknYiBJxRKgT2XKcULMav5e4b
         VFEC2O+xYq7A5WtfQIVFcpggMWFMTK8E9RhYq/wzeq5K8kOGhNFg/82eUoxOHY4JqfsB
         2IGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OZT+NISkOyfbxR8rapjvnBr1FAL+HjL4G2bXcv5bE7k=;
        b=fpyQJEysGubYjGmyBMxMqFKuSwXDdTZVny4ZeXf3x7Xk30VAk8OkdbX3nRObqVK1Uz
         UMHJGnDUMf0QaI+wqNAHmF2sdYeZXM1rTplW435X/MTTQC2iiEt2eURRMv+Ehnbd1AgT
         ZdSSdmI6BUzdBEN48FlRZTbI5XSEs4S5ENGYhrdUidZ6mvmP0LsyyMiChgWndRLM0zvS
         qByXgF4nQZpB1EQu/9QPYCeTuVK5iOrkwYfD1ypnm6hTfKSfpgq1nT3qPl+gMPQAwe8r
         103DfQ/dLtah4WIPYNvpY39aLfQnfmFIbUwJttDqhQGlaXYOa2mjzC0NE0O7VyBZeBVH
         icaw==
X-Gm-Message-State: APjAAAXGlzwdEObRJcmkGnX4M1pyejlYcwzp0NUJARkHnysv+u3lekeT
        g24HmzlIPqCoaPnlRouNsJAXHSVZccw=
X-Google-Smtp-Source: APXvYqxGsD8kDqZpk33KPRbhl2Sz+M22AGvVPoBzX5jicNVranQj8Iicw3jkZ0MVt/os76LSzwYEcw==
X-Received: by 2002:a5d:5705:: with SMTP id a5mr15980903wrv.112.1571574799814;
        Sun, 20 Oct 2019 05:33:19 -0700 (PDT)
Received: from linux.fritz.box (p200300D99703FC00226A5479D1389944.dip0.t-ipconnect.de. [2003:d9:9703:fc00:226a:5479:d138:9944])
        by smtp.googlemail.com with ESMTPSA id t13sm15065400wra.70.2019.10.20.05.33.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2019 05:33:19 -0700 (PDT)
From:   Manfred Spraul <manfred@colorfullife.com>
To:     LKML <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Waiman Long <longman@redhat.com>
Cc:     1vier1@web.de, Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Manfred Spraul <manfred@colorfullife.com>
Subject: [PATCH 2/5] ipc/mqueue.c: Remove duplicated code
Date:   Sun, 20 Oct 2019 14:33:02 +0200
Message-Id: <20191020123305.14715-3-manfred@colorfullife.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191020123305.14715-1-manfred@colorfullife.com>
References: <20191020123305.14715-1-manfred@colorfullife.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch from Davidlohr, I just added this change log.
pipelined_send() and pipelined_receive() are identical, so merge them.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Manfred Spraul <manfred@colorfullife.com>
---
 ipc/mqueue.c | 31 ++++++++++++++++++-------------
 1 file changed, 18 insertions(+), 13 deletions(-)

diff --git a/ipc/mqueue.c b/ipc/mqueue.c
index 3d920ff15c80..270456530f6a 100644
--- a/ipc/mqueue.c
+++ b/ipc/mqueue.c
@@ -918,17 +918,12 @@ SYSCALL_DEFINE1(mq_unlink, const char __user *, u_name)
  * The same algorithm is used for senders.
  */
 
-/* pipelined_send() - send a message directly to the task waiting in
- * sys_mq_timedreceive() (without inserting message into a queue).
- */
-static inline void pipelined_send(struct wake_q_head *wake_q,
+static inline void __pipelined_op(struct wake_q_head *wake_q,
 				  struct mqueue_inode_info *info,
-				  struct msg_msg *message,
-				  struct ext_wait_queue *receiver)
+				  struct ext_wait_queue *this)
 {
-	receiver->msg = message;
-	list_del(&receiver->list);
-	wake_q_add(wake_q, receiver->task);
+	list_del(&this->list);
+	wake_q_add(wake_q, this->task);
 	/*
 	 * Rely on the implicit cmpxchg barrier from wake_q_add such
 	 * that we can ensure that updating receiver->state is the last
@@ -937,7 +932,19 @@ static inline void pipelined_send(struct wake_q_head *wake_q,
 	 * yet, at that point we can later have a use-after-free
 	 * condition and bogus wakeup.
 	 */
-	receiver->state = STATE_READY;
+	this->state = STATE_READY;
+}
+
+/* pipelined_send() - send a message directly to the task waiting in
+ * sys_mq_timedreceive() (without inserting message into a queue).
+ */
+static inline void pipelined_send(struct wake_q_head *wake_q,
+				  struct mqueue_inode_info *info,
+				  struct msg_msg *message,
+				  struct ext_wait_queue *receiver)
+{
+	receiver->msg = message;
+	__pipelined_op(wake_q, info, receiver);
 }
 
 /* pipelined_receive() - if there is task waiting in sys_mq_timedsend()
@@ -955,9 +962,7 @@ static inline void pipelined_receive(struct wake_q_head *wake_q,
 	if (msg_insert(sender->msg, info))
 		return;
 
-	list_del(&sender->list);
-	wake_q_add(wake_q, sender->task);
-	sender->state = STATE_READY;
+	__pipelined_op(wake_q, info, sender);
 }
 
 static int do_mq_timedsend(mqd_t mqdes, const char __user *u_msg_ptr,
-- 
2.21.0

