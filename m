Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4462C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 11:52:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 862DE2075E
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 11:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556625142;
	bh=RlH34TrqR6+L8TPt7VcRdcG/xgNAd0vIlgQsh/n2KoQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0uIFfldJwVf6P2fRbgSVTq9BQgve8bkkPVjGgqDHtDSRckKKlYsBqfnk6B7jDCO3D
	 33vSX+JVXJWxB48MR/Mxlx08I6/3mt4DUEDRQeojWhYabea3q3ujVNLTcTbO+Uq8aw
	 9aJMwMVfrXY4rZ7f2ZXwMml4fOnyVEkJWoe2qOso=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731436AbfD3Lvm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 07:51:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:39556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731423AbfD3Lvi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 07:51:38 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC57021670;
        Tue, 30 Apr 2019 11:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556625098;
        bh=RlH34TrqR6+L8TPt7VcRdcG/xgNAd0vIlgQsh/n2KoQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QICrzOo5sa3XKcWsoWZHp/woMYHBuGg25vPmSxtRmzqz0djnGTPjOizhnSgfW3Mu5
         +gyDvyKTK2qF2WEYnrjVTnUc9km9nDPtptdldATd38lEKO2xRpx9cvsRKNTdlfBc/z
         i4iP/oTFfXO7qhjCk18zElqLfNjYLxVmaAIZlG80=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, luca abeni <luca.abeni@santannapisa.it>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "chengjian (D)" <cj.chengjian@huawei.com>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 5.0 54/89] sched/deadline: Correctly handle active 0-lag timers
Date:   Tue, 30 Apr 2019 13:38:45 +0200
Message-Id: <20190430113612.212524332@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190430113609.741196396@linuxfoundation.org>
References: <20190430113609.741196396@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: luca abeni <luca.abeni@santannapisa.it>

commit 1b02cd6a2d7f3e2a6a5262887d2cb2912083e42f upstream.

syzbot reported the following warning:

   [ ] WARNING: CPU: 4 PID: 17089 at kernel/sched/deadline.c:255 task_non_contending+0xae0/0x1950

line 255 of deadline.c is:

	WARN_ON(hrtimer_active(&dl_se->inactive_timer));

in task_non_contending().

Unfortunately, in some cases (for example, a deadline task
continuosly blocking and waking immediately) it can happen that
a task blocks (and task_non_contending() is called) while the
0-lag timer is still active.

In this case, the safest thing to do is to immediately decrease
the running bandwidth of the task, without trying to re-arm the 0-lag timer.

Signed-off-by: luca abeni <luca.abeni@santannapisa.it>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Juri Lelli <juri.lelli@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: chengjian (D) <cj.chengjian@huawei.com>
Link: https://lkml.kernel.org/r/20190325131530.34706-1-luca.abeni@santannapisa.it
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/sched/deadline.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -252,7 +252,6 @@ static void task_non_contending(struct t
 	if (dl_entity_is_special(dl_se))
 		return;
 
-	WARN_ON(hrtimer_active(&dl_se->inactive_timer));
 	WARN_ON(dl_se->dl_non_contending);
 
 	zerolag_time = dl_se->deadline -
@@ -269,7 +268,7 @@ static void task_non_contending(struct t
 	 * If the "0-lag time" already passed, decrease the active
 	 * utilization now, instead of starting a timer
 	 */
-	if (zerolag_time < 0) {
+	if ((zerolag_time < 0) || hrtimer_active(&dl_se->inactive_timer)) {
 		if (dl_task(p))
 			sub_running_bw(dl_se, dl_rq);
 		if (!dl_task(p) || p->state == TASK_DEAD) {


