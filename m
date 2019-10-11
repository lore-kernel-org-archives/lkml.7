Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54BAEECE58E
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 11:20:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2537E222C9
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 11:20:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=colorfullife-com.20150623.gappssmtp.com header.i=@colorfullife-com.20150623.gappssmtp.com header.b="jmyGBZrC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727998AbfJKLUW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 07:20:22 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33808 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727541AbfJKLUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 07:20:21 -0400
Received: by mail-wr1-f68.google.com with SMTP id j11so11503942wrp.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2019 04:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorfullife-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mR7MBM4W0U2PBQNbuoWRfjVtc2eVBH4kCIRTHNZxIuI=;
        b=jmyGBZrCBVoI8GWnTkdnckFlOumuGpJ/Uhn/i3HGR7WUBfmRggC5gj1z2Zb7Nw1Xi8
         Y1wY9/WLYe5Hbjkbgw+f5zw0obb8XCzksXVoKrQC3N+v8rheHgZS1YCR0XQYLZtMLo2L
         0DL/Pt9JLXO1t5kgecNjRlEKH1ch3ws0PoAxLhvFj+8SOeQ86Qmhex5NcDg9hLMW+PFD
         PWLGT0QdygR1Ceo1jL0OMSJdoTWAVO+IcLpzCgpY+X9C+96HeQzbmFiPSnlvGWeANLhE
         IZn+NJNC+wAqFA3qJAxM8rPqi2oYrtTP3WZes0EQqfX7V+W94B+Tc+shLdrMaXNEdgtG
         UeiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mR7MBM4W0U2PBQNbuoWRfjVtc2eVBH4kCIRTHNZxIuI=;
        b=WXC+Zb4LQcFtCo6A4TafdNdON8/akiwLZO3+3IpFMqV9ZQAg+lic3B9hrJ1QeNJMDp
         ujo5c4DCcT+rxmcSoiAF0Iioa4IR1hyHk7umL95jiIsSwl0QWdzvhy7Nb7cqiskuVG3T
         7IAR2GBzPmj+rNp2Gv4PLbUWq9tSSqn4xiI4avsNBipSk1SN4p35D3DW0ktC/QDKDXON
         8gqWQE3s1hSSSFfa9KgFw6mElriQXAlvhBZVtTYtyMD3d6jLq3flSsI6gZhmAUkfRTzo
         X1MYvVtMnIb42vCONX8ybt++BQRAC5qPoaB75ybWS0iR7V/LxJULj7Z4Eh6vGlimntrg
         ZGBg==
X-Gm-Message-State: APjAAAV6H4CR90tanSBefG5mZKAQxnuSR7Wr42b16mhAzROgu5VHSM2d
        luwAN3eLLTuB4EbEdl5/M/MLRo+Bi4o=
X-Google-Smtp-Source: APXvYqz8ROcGa+C/QBav8H9xwuHmNfUUG/FQXkngUOduL1b/kItnBwK+pvgMZxuQ3H+itNn7pW5m4Q==
X-Received: by 2002:adf:f50b:: with SMTP id q11mr9109210wro.310.1570792819173;
        Fri, 11 Oct 2019 04:20:19 -0700 (PDT)
Received: from linux.fritz.box (p200300D99705BE00E22045ECB41D901D.dip0.t-ipconnect.de. [2003:d9:9705:be00:e220:45ec:b41d:901d])
        by smtp.googlemail.com with ESMTPSA id 63sm12781226wri.25.2019.10.11.04.20.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2019 04:20:18 -0700 (PDT)
From:   Manfred Spraul <manfred@colorfullife.com>
To:     LKML <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Waiman Long <longman@redhat.com>
Cc:     1vier1@web.de, Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Manfred Spraul <manfred@colorfullife.com>
Subject: [PATCH 3/5] ipc/msg.c: Update and document memory barriers.
Date:   Fri, 11 Oct 2019 13:20:07 +0200
Message-Id: <20191011112009.2365-4-manfred@colorfullife.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191011112009.2365-1-manfred@colorfullife.com>
References: <20191011112009.2365-1-manfred@colorfullife.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Transfer findings from ipc/sem.c:
- A control barrier was missing for the lockless receive case
  So in theory, not yet initialized data may have been copied
  to user space - obviously only for architectures where
  control barriers are not NOP.

- Add documentation. Especially, document that the code relies
  on the barrier inside wake_q_add().

Signed-off-by: Manfred Spraul <manfred@colorfullife.com>
Cc: Waiman Long <longman@redhat.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>
---
 ipc/msg.c | 39 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 38 insertions(+), 1 deletion(-)

diff --git a/ipc/msg.c b/ipc/msg.c
index 8dec945fa030..1e2c0a3d4998 100644
--- a/ipc/msg.c
+++ b/ipc/msg.c
@@ -184,6 +184,10 @@ static inline void ss_add(struct msg_queue *msq,
 {
 	mss->tsk = current;
 	mss->msgsz = msgsz;
+	/*
+	 * No memory barrier required: we did ipc_lock_object(),
+	 * and the waker obtains that lock before calling wake_q_add().
+	 */
 	__set_current_state(TASK_INTERRUPTIBLE);
 	list_add_tail(&mss->list, &msq->q_senders);
 }
@@ -238,6 +242,12 @@ static void expunge_all(struct msg_queue *msq, int res,
 
 	list_for_each_entry_safe(msr, t, &msq->q_receivers, r_list) {
 		wake_q_add(wake_q, msr->r_tsk);
+
+		/*
+		 * A memory barrier is required that pairs with the
+		 * READ_ONCE()+smp_mb__after_ctrl_dep(). It is provided by
+		 * wake_q_add().
+		 */
 		WRITE_ONCE(msr->r_msg, ERR_PTR(res));
 	}
 }
@@ -798,12 +808,24 @@ static inline int pipelined_send(struct msg_queue *msq, struct msg_msg *msg,
 			list_del(&msr->r_list);
 			if (msr->r_maxsize < msg->m_ts) {
 				wake_q_add(wake_q, msr->r_tsk);
+
+				/*
+				 * A memory barrier is required that pairs with
+				 * the READ_ONCE()+smp_mb__after_ctrl_dep().
+				 * It is provided by wake_q_add().
+				 */
 				WRITE_ONCE(msr->r_msg, ERR_PTR(-E2BIG));
 			} else {
 				ipc_update_pid(&msq->q_lrpid, task_pid(msr->r_tsk));
 				msq->q_rtime = ktime_get_real_seconds();
 
 				wake_q_add(wake_q, msr->r_tsk);
+
+				/*
+				 * A memory barrier is required that pairs with
+				 * the READ_ONCE()+smp_mb__after_ctrl_dep().
+				 * It is provided by wake_q_add().
+				 */
 				WRITE_ONCE(msr->r_msg, msg);
 				return 1;
 			}
@@ -1155,6 +1177,8 @@ static long do_msgrcv(int msqid, void __user *buf, size_t bufsz, long msgtyp, in
 		else
 			msr_d.r_maxsize = bufsz;
 		msr_d.r_msg = ERR_PTR(-EAGAIN);
+
+		/* memory barrier not required, we own ipc_lock_object() */
 		__set_current_state(TASK_INTERRUPTIBLE);
 
 		ipc_unlock_object(&msq->q_perm);
@@ -1183,8 +1207,21 @@ static long do_msgrcv(int msqid, void __user *buf, size_t bufsz, long msgtyp, in
 		 * signal) it will either see the message and continue ...
 		 */
 		msg = READ_ONCE(msr_d.r_msg);
-		if (msg != ERR_PTR(-EAGAIN))
+		if (msg != ERR_PTR(-EAGAIN)) {
+			/*
+			 * Memory barrier for msr_d.r_msg
+			 * The smp_acquire__after_ctrl_dep(), together with the
+			 * READ_ONCE() above pairs with the barrier inside
+			 * wake_q_add().
+			 * The barrier protects the accesses to the message in
+			 * do_msg_fill(). In addition, the barrier protects user
+			 * space, too: User space may assume that all data from
+			 * the CPU that sent the message is visible.
+			 */
+			smp_acquire__after_ctrl_dep();
+
 			goto out_unlock1;
+		}
 
 		 /*
 		  * ... or see -EAGAIN, acquire the lock to check the message
-- 
2.21.0

