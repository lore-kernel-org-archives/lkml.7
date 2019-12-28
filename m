Return-Path: <SRS0=tgXE=2S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E571C2D0C8
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Dec 2019 20:57:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8B0A207E0
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Dec 2019 20:57:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726816AbfL1U5T convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Dec 2019 15:57:19 -0500
Received: from mail.fireflyinternet.com ([109.228.58.192]:52509 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726661AbfL1U5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Dec 2019 15:57:19 -0500
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 19715024-1500050 
        for multiple; Sat, 28 Dec 2019 20:56:21 +0000
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To:     Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
From:   Chris Wilson <chris@chris-wilson.co.uk>
In-Reply-To: <20191121024430.19938-3-frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Rik van Riel <riel@surriel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Pavel Machek <pavel@ucw.cz>
References: <20191121024430.19938-1-frederic@kernel.org>
 <20191121024430.19938-3-frederic@kernel.org>
Message-ID: <157756657962.14652.10349541055640858962@skylake-alporthouse-com>
User-Agent: alot/0.6
Subject: Re: [PATCH 2/6] sched/vtime: Bring up complete kcpustat accessor
Date:   Sat, 28 Dec 2019 20:56:19 +0000
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Frederic Weisbecker (2019-11-21 02:44:26)
> +static int kcpustat_cpu_fetch_vtime(struct kernel_cpustat *dst,
> +                                   const struct kernel_cpustat *src,
> +                                   struct task_struct *tsk, int cpu)
> +{
> +       struct vtime *vtime = &tsk->vtime;
> +       unsigned int seq;
> +       int err;
> +
> +       do {
> +               u64 *cpustat;
> +               u64 delta;
> +
> +               seq = read_seqcount_begin(&vtime->seqcount);
> +
> +               err = vtime_state_check(vtime, cpu);
> +               if (err < 0)
> +                       return err;
> +
> +               *dst = *src;
> +               cpustat = dst->cpustat;
> +
> +               /* Task is sleeping, dead or idle, nothing to add */
> +               if (vtime->state < VTIME_SYS)
> +                       continue;
> +
> +               delta = vtime_delta(vtime);
> +
> +               /*
> +                * Task runs either in user (including guest) or kernel space,
> +                * add pending nohz time to the right place.
> +                */
> +               if (vtime->state == VTIME_SYS) {
> +                       cpustat[CPUTIME_SYSTEM] += vtime->stime + delta;
> +               } else if (vtime->state == VTIME_USER) {
> +                       if (task_nice(tsk) > 0)
> +                               cpustat[CPUTIME_NICE] += vtime->utime + delta;
> +                       else
> +                               cpustat[CPUTIME_USER] += vtime->utime + delta;
> +               } else {
> +                       WARN_ON_ONCE(vtime->state != VTIME_GUEST);

I'm randomly hitting this WARN on a non-virtualised system reading
/proc/stat.

vtime->state is updated under the write_seqcount, so the access here is
deliberately racey, and the change in vtime->state would be picked up
the seqcount_retry.

Quick suggestion would be something along the lines of

 static int vtime_state_check(struct vtime *vtime, int cpu)
 {
+	int state = READ_ONCE(vtime->state);
+
 	/*
 	 * We raced against a context switch, fetch the
 	 * kcpustat task again.
@@ -930,10 +932,10 @@ static int vtime_state_check(struct vtime *vtime, int cpu)
 	 *
 	 * Case 1) is ok but 2) is not. So wait for a safe VTIME state.
 	 */
-	if (vtime->state == VTIME_INACTIVE)
+	if (state == VTIME_INACTIVE)
 		return -EAGAIN;

-	return 0;
+	return state;
 }

 static u64 kcpustat_user_vtime(struct vtime *vtime)
@@ -1055,7 +1057,7 @@ static int kcpustat_cpu_fetch_vtime(struct kernel_cpustat *dst,
 		cpustat = dst->cpustat;

 		/* Task is sleeping, dead or idle, nothing to add */
-		if (vtime->state < VTIME_SYS)
+		if (err < VTIME_SYS)
 			continue;

 		delta = vtime_delta(vtime);
@@ -1064,15 +1066,15 @@ static int kcpustat_cpu_fetch_vtime(struct kernel_cpustat *dst,
 		 * Task runs either in user (including guest) or kernel space,
 		 * add pending nohz time to the right place.
 		 */
-		if (vtime->state == VTIME_SYS) {
+		if (err == VTIME_SYS) {
 			cpustat[CPUTIME_SYSTEM] += vtime->stime + delta;
-		} else if (vtime->state == VTIME_USER) {
+		} else if (err == VTIME_USER) {
 			if (task_nice(tsk) > 0)
 				cpustat[CPUTIME_NICE] += vtime->utime + delta;
 			else
 				cpustat[CPUTIME_USER] += vtime->utime + delta;
 		} else {
-			WARN_ON_ONCE(vtime->state != VTIME_GUEST);
+			WARN_ON_ONCE(err != VTIME_GUEST);
 			if (task_nice(tsk) > 0) {
 				cpustat[CPUTIME_GUEST_NICE] += vtime->gtime + delta;
 				cpustat[CPUTIME_NICE] += vtime->gtime + delta;

Or drop the warn.
-Chris
