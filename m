Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A041C282CE
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 00:40:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D39920B1F
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 00:40:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729726AbfEWAko (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 20:40:44 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:57329 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729697AbfEWAkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 20:40:43 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hTbmj-0008Ie-38; Wed, 22 May 2019 18:40:41 -0600
Received: from ip72-206-97-68.om.om.cox.net ([72.206.97.68] helo=x220.int.ebiederm.org)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hTbmh-0005Z3-A9; Wed, 22 May 2019 18:40:40 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        drbd-dev@lists.linbit.com
Date:   Wed, 22 May 2019 19:38:54 -0500
Message-Id: <20190523003916.20726-5-ebiederm@xmission.com>
X-Mailer: git-send-email 2.21.0.dirty
In-Reply-To: <20190523003916.20726-1-ebiederm@xmission.com>
References: <20190523003916.20726-1-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1hTbmh-0005Z3-A9;;;mid=<20190523003916.20726-5-ebiederm@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=72.206.97.68;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18Ab4QBip6TyqutT6aM0jfESK8bA8OSRRM=
X-SA-Exim-Connect-IP: 72.206.97.68
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [REVIEW][PATCH 04/26] signal/drbd: Use send_sig not force_sig
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The drbd module exclusively sends signals to kernel threads it creates with
kthread_create.  These kernel threads do not block or ignore signals (only
flush signals after they have been delivered), nor can drbd threads
possibly be pid namespace init processes so the extra work that force_sig
performs that send_sig does not is unnecessary.

Further force_sig is for delivering synchronous signals (aka exceptions).
The locking in force_sig is not prepared to deal with running processes, as
tsk->sighand may change during exec for a running process.

In short it is not only unnecessary for drbd to use force_sig it is
semantically wrong.

With drbd using send_sig it becomes easier to maintain force_sig as only
synchronous signals need to be considered.

Cc: Philipp Reisner <philipp.reisner@linbit.com>
Cc: Lars Ellenberg <lars.ellenberg@linbit.com>
Cc: drbd-dev@lists.linbit.com
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 drivers/block/drbd/drbd_int.h  | 2 +-
 drivers/block/drbd/drbd_main.c | 2 +-
 drivers/block/drbd/drbd_nl.c   | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.h
index 549c64df9708..035829435710 100644
--- a/drivers/block/drbd/drbd_int.h
+++ b/drivers/block/drbd/drbd_int.h
@@ -1972,7 +1972,7 @@ static inline void wake_ack_receiver(struct drbd_connection *connection)
 {
 	struct task_struct *task = connection->ack_receiver.task;
 	if (task && get_t_state(&connection->ack_receiver) == RUNNING)
-		force_sig(SIGXCPU, task);
+		send_sig(SIGXCPU, task, 1);
 }
 
 static inline void request_ping(struct drbd_connection *connection)
diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index 714eb64fabfd..8597aefe027b 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -477,7 +477,7 @@ void _drbd_thread_stop(struct drbd_thread *thi, int restart, int wait)
 		smp_mb();
 		init_completion(&thi->stop);
 		if (thi->task != current)
-			force_sig(DRBD_SIGKILL, thi->task);
+			send_sig(DRBD_SIGKILL, thi->task, 1);
 	}
 
 	spin_unlock_irqrestore(&thi->t_lock, flags);
diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index 1cb5a0b85fd9..638b3ba9b976 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -611,7 +611,7 @@ void conn_try_outdate_peer_async(struct drbd_connection *connection)
 	struct task_struct *opa;
 
 	kref_get(&connection->kref);
-	/* We may just have force_sig()'ed this thread
+	/* We may have just sent a signal to this thread
 	 * to get it out of some blocking network function.
 	 * Clear signals; otherwise kthread_run(), which internally uses
 	 * wait_on_completion_killable(), will mistake our pending signal
-- 
2.21.0

