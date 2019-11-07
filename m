Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28D33C5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 12:46:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFBBB2187F
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 12:46:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="G+b5F0zs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388747AbfKGMqZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 07:46:25 -0500
Received: from merlin.infradead.org ([205.233.59.134]:60264 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388407AbfKGMqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 07:46:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Xa3xcbvcNii0ckLDCeWLHK/ql7ey1ORYLLY0djGGeQI=; b=G+b5F0zsTBN+89jWdmm+g3GUT
        dAp0DdRzLdcdJt3d/VA9pu3ahL7Uspd+ccWn2SDhwCutIaN0FES4q/uTVaUihfitkSe/4BPdomRBn
        jo2BbmEllza+WOBsq0BCfHtnJhco/BmOP5Z7J8n4+8EHBdPb2kF9i13edAE+GgFtAq1DbufjCSUnZ
        mUg8UYhtZLV80L2GVxYA3KoIyDK8pD7pnfhay26rVUDZ5ftZelLPpWLsueZNXIdBqZKa79+myWtc/
        unCYTqzClb1hBngRB896GlSl7hagF6dkPl2XUpi1wapvGxfmKvQmtYKWYb7jwJ97kDrKR3Wn0YF69
        eOHvcNAYA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iShB4-0005kt-9O; Thu, 07 Nov 2019 12:46:18 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1144A301747;
        Thu,  7 Nov 2019 13:45:11 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 91DF52025EDA7; Thu,  7 Nov 2019 13:46:15 +0100 (CET)
Date:   Thu, 7 Nov 2019 13:46:15 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Jan Stancek <jstancek@redhat.com>, linux-kernel@vger.kernel.org,
        ltp@lists.linux.it, viro@zeniv.linux.org.uk,
        kstewart@linuxfoundation.org, gregkh@linuxfoundation.org,
        rfontana@redhat.com
Subject: Re: [PATCH] kernel: use ktime_get_real_ts64() to calculate
 acct.ac_btime
Message-ID: <20191107124615.GG4131@hirez.programming.kicks-ass.net>
References: <a87876829697e1b3c63601b1401a07af79eddae6.1572651216.git.jstancek@redhat.com>
 <20191107123224.GA6315@hirez.programming.kicks-ass.net>
 <alpine.DEB.2.21.1911071335320.4256@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1911071335320.4256@nanos.tec.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 07, 2019 at 01:40:47PM +0100, Thomas Gleixner wrote:
> Typing real_start_time makes me really cringe.

I have a patch fixing that...

---
Subject: kernel: Rename tsk->real_start_time
From: Peter Zijlstra <peterz@infradead.org>
Date: Thu Nov  7 11:07:58 CET 2019

Since it stores CLOCK_BOOTTIME, not, as the name suggests,
CLOCK_REALTIME, let's rename real_start_time.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1132,7 +1132,7 @@ static int de_thread(struct task_struct
 		 * also take its birthdate (always earlier than our own).
 		 */
 		tsk->start_time = leader->start_time;
-		tsk->real_start_time = leader->real_start_time;
+		tsk->start_boottime = leader->start_boottime;
 
 		BUG_ON(!same_thread_group(leader, tsk));
 		BUG_ON(has_group_leader_pid(tsk));
--- a/fs/proc/array.c
+++ b/fs/proc/array.c
@@ -533,7 +533,7 @@ static int do_task_stat(struct seq_file
 	nice = task_nice(task);
 
 	/* convert nsec -> ticks */
-	start_time = nsec_to_clock_t(task->real_start_time);
+	start_time = nsec_to_clock_t(task->start_boottime);
 
 	seq_put_decimal_ull(m, "", pid_nr_ns(pid, ns));
 	seq_puts(m, " (");
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -879,7 +879,7 @@ struct task_struct {
 	u64				start_time;
 
 	/* Boot based time in nsecs: */
-	u64				real_start_time;
+	u64				start_boottime;
 
 	/* MM fault and swap info: this can arguably be seen as either mm-specific or thread-specific: */
 	unsigned long			min_flt;
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2130,7 +2130,7 @@ static __latent_entropy struct task_stru
 	 */
 
 	p->start_time = ktime_get_ns();
-	p->real_start_time = ktime_get_boottime_ns();
+	p->start_boottime = ktime_get_boottime_ns();
 
 	/*
 	 * Make it visible to the rest of the system, but dont wake it up yet.
