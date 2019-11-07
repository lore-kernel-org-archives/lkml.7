Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CACEEC5DF61
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 12:32:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B5272187F
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 12:32:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QORicF9P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388494AbfKGMcd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 07:32:33 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:43716 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727619AbfKGMcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 07:32:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=5b6dL4GU7b0E4m+87rHIiqniNskuz8XJPlTDMY3zCsI=; b=QORicF9PleMxv8poQOXsiir5J
        1sBpNIs3/HKgGcSlGkkjPCArd7lTJ3NQI+txxI6GwMpcVaMyjWtACK2KlyPqXfuP/39LD8+ffKN9p
        fB/x73hq9tYzxCBYGYNufCDbWOLmqxtHWxvWursQSwMSKVgLjqldH7LM94UhsTH4Vl2kZQ+eXOrEO
        XQAIp1FFk/ZgutTuRWHIqXgHmF35kWbPvJdayt7DueI6Zh3uDG6rgnN5s0pwSlIaBnauPSftVYFCn
        dcObLkppz20g10ag6fBJUCr6a30vuKGSYDXedxFEXyKsQxu/w0wluU0c19jq7v5JCCttgU65+aDPv
        O5Npvlt8A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iSgxf-00080d-5M; Thu, 07 Nov 2019 12:32:27 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DFAC0300692;
        Thu,  7 Nov 2019 13:31:19 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 57BED2025EDB3; Thu,  7 Nov 2019 13:32:24 +0100 (CET)
Date:   Thu, 7 Nov 2019 13:32:24 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jan Stancek <jstancek@redhat.com>
Cc:     linux-kernel@vger.kernel.org, ltp@lists.linux.it,
        viro@zeniv.linux.org.uk, kstewart@linuxfoundation.org,
        gregkh@linuxfoundation.org, tglx@linutronix.de, rfontana@redhat.com
Subject: Re: [PATCH] kernel: use ktime_get_real_ts64() to calculate
 acct.ac_btime
Message-ID: <20191107123224.GA6315@hirez.programming.kicks-ass.net>
References: <a87876829697e1b3c63601b1401a07af79eddae6.1572651216.git.jstancek@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a87876829697e1b3c63601b1401a07af79eddae6.1572651216.git.jstancek@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 02, 2019 at 12:39:24AM +0100, Jan Stancek wrote:
> fill_ac() calculates process creation time from current time as:
>    ac->ac_btime = get_seconds() - elapsed
> 
> get_seconds() doesn't accumulate nanoseconds as regular time getters.
> This creates race for user-space (e.g. LTP acct02), which typically
> uses gettimeofday(), because process creation time sometimes appear
> to be dated 'in past':
> 
>     acct("myfile");
>     time_t start_time = time(NULL);
>     if (fork()==0) {
>         sleep(1);
>         exit(0);
>     }
>     waitpid(NULL);
>     acct(NULL);
> 
>     // acct.ac_btime == 1572616777
>     // start_time == 1572616778
> 

Lets start by saying this accounting stuff is terrible crap and it
deserves to fail and burn.

The only spec I found for what it actually wants in those fields is
Documentation/accounting/taskstats-struct.rst, that states:

	/* The time when a task begins, in [secs] since 1970. */
	__u32   ac_btime;               /* Begin time [sec since 1970] */

	/* The elapsed time of a task, in [usec]. */
	__u64   ac_etime;               /* Elapsed time [usec] */

But that is not really well defined. As implemented etime does not
include suspend time (maybe on purpose, maybe not).

And what does btime want? As implemented it jumps around if you ask the
question twice with an adjtime() call or suspend in between. Of course,
if we take an actual CLOCK_REALTIME timestamp at fork() the value
doesn't change, but then it can be in the future (DST,adjtime()), which
is exactly the reason why CLOCK_REALTIME is absolute shit for timestamps
(logging, accounting, etc.).

And your 'fix' is pretty terible too. Arguably ktime_get_seconds() wants
fixing for not having the ns accumulation and actually differing from
tv_sec, but now you accrue one source of ns while still disregarding
another (also, I friggin hate timespec, it's a terrible interface for
time).

All in all, I'm tempted to just declare this stuff broken and -EWONTFIX,
but if we have to do something, something like the below is at least
internally consistent.

---
diff --git a/kernel/tsacct.c b/kernel/tsacct.c
index 7be3e7530841..76d6325c2724 100644
--- a/kernel/tsacct.c
+++ b/kernel/tsacct.c
@@ -23,18 +23,31 @@ void bacct_add_tsk(struct user_namespace *user_ns,
 {
 	const struct cred *tcred;
 	u64 utime, stime, utimescaled, stimescaled;
-	u64 delta;
+	u64 mono, real, btime;
 
 	BUILD_BUG_ON(TS_COMM_LEN < TASK_COMM_LEN);
 
+	mono = ktime_get_ns();
+	real = ktime_get_real_ns();
+
 	/* calculate task elapsed time in nsec */
-	delta = ktime_get_ns() - tsk->start_time;
+	delta = mono - tsk->start_time;
 	/* Convert to micro seconds */
 	do_div(delta, NSEC_PER_USEC);
 	stats->ac_etime = delta;
-	/* Convert to seconds for btime */
-	do_div(delta, USEC_PER_SEC);
-	stats->ac_btime = get_seconds() - delta;
+
+	/*
+	 * Compute btime by subtracting the elapsed time from the current
+	 * CLOCK_REALTIME.
+	 *
+	 * XXX totally buggered, because it changes results across
+	 * adjtime() calls and suspend/resume.
+	 */
+	delta = mono - tsk->start_time; // elapsed in ns
+	btime = real - delta;		// real ns - elapsed ns
+	do_div(btime, NSEC_PER_SEC);	// truncated to seconds
+	stats->ac_btime = btime;
+
 	if (thread_group_leader(tsk)) {
 		stats->ac_exitcode = tsk->exit_code;
 		if (tsk->flags & PF_FORKNOEXEC)
