Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8657EC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 11:04:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59450218D8
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 11:04:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728023AbfCULEd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 07:04:33 -0400
Received: from terminus.zytor.com ([198.137.202.136]:47151 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727575AbfCULEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 07:04:33 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x2LB462a098373
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 21 Mar 2019 04:04:06 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x2LB45Qh098364;
        Thu, 21 Mar 2019 04:04:05 -0700
Date:   Thu, 21 Mar 2019 04:04:05 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Bart Van Assche <tipbot@zytor.com>
Message-ID: <tip-82efcab3b9f3ef59e9713237c6e3c05c3a95c1ae@git.kernel.org>
Cc:     hpa@zytor.com, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, peterz@infradead.org,
        mingo@kernel.org, cai@lca.pw, bvanassche@acm.org, tj@kernel.org
Reply-To: cai@lca.pw, bvanassche@acm.org, tj@kernel.org,
          tglx@linutronix.de, hpa@zytor.com, linux-kernel@vger.kernel.org,
          torvalds@linux-foundation.org, peterz@infradead.org,
          mingo@kernel.org
In-Reply-To: <20190311230255.176081-1-bvanassche@acm.org>
References: <20190311230255.176081-1-bvanassche@acm.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/urgent] workqueue: Only unregister a registered
 lockdep key
Git-Commit-ID: 82efcab3b9f3ef59e9713237c6e3c05c3a95c1ae
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  82efcab3b9f3ef59e9713237c6e3c05c3a95c1ae
Gitweb:     https://git.kernel.org/tip/82efcab3b9f3ef59e9713237c6e3c05c3a95c1ae
Author:     Bart Van Assche <bvanassche@acm.org>
AuthorDate: Mon, 11 Mar 2019 16:02:55 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 21 Mar 2019 12:00:18 +0100

workqueue: Only unregister a registered lockdep key

The recent change to prevent use after free and a memory leak introduced an
unconditional call to wq_unregister_lockdep() in the error handling
path. If the lockdep key had not been registered yet, then the lockdep core
emits a warning.

Only call wq_unregister_lockdep() if wq_register_lockdep() has been
called first.

Fixes: 009bb421b6ce ("workqueue, lockdep: Fix an alloc_workqueue() error path")
Reported-by: syzbot+be0c198232f86389c3dd@syzkaller.appspotmail.com
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: Qian Cai <cai@lca.pw>
Link: https://lkml.kernel.org/r/20190311230255.176081-1-bvanassche@acm.org

---
 kernel/workqueue.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 4026d1871407..ddee541ea97a 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -4266,7 +4266,7 @@ struct workqueue_struct *alloc_workqueue(const char *fmt,
 	INIT_LIST_HEAD(&wq->list);
 
 	if (alloc_and_link_pwqs(wq) < 0)
-		goto err_free_wq;
+		goto err_unreg_lockdep;
 
 	if (wq_online && init_rescuer(wq) < 0)
 		goto err_destroy;
@@ -4292,9 +4292,10 @@ struct workqueue_struct *alloc_workqueue(const char *fmt,
 
 	return wq;
 
-err_free_wq:
+err_unreg_lockdep:
 	wq_unregister_lockdep(wq);
 	wq_free_lockdep(wq);
+err_free_wq:
 	free_workqueue_attrs(wq->unbound_attrs);
 	kfree(wq);
 	return NULL;
