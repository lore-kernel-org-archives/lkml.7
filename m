Return-Path: <SRS0=E66v=2U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C992BC2D0C0
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 01:08:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94DC5207FF
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 01:08:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577668126;
	bh=p6eVjqX/8BJ4EZqmYWA7QlEUQWr7Nc8fEY/GzKskeTs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qco4F+MRkP2lxAtAY6AoOuBUarmdOYW6okRFuI1n2c2IXDELE8TVlZV+Nm+Gw0RJC
	 krDuSRrEsgS13wwp4cr2NMOxW5K8s4IS1L34dUSKwxN0Ig73VRf3NxZOmg90ZB3keF
	 0RvUMURLuBF1V1szqjwuqholbe0MJom+4Uc+h4Yc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbfL3BIo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 20:08:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:53504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726543AbfL3BIn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 20:08:43 -0500
Received: from localhost (lfbn-ncy-1-150-155.w83-194.abo.wanadoo.fr [83.194.232.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A85B2207FD;
        Mon, 30 Dec 2019 01:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577668123;
        bh=p6eVjqX/8BJ4EZqmYWA7QlEUQWr7Nc8fEY/GzKskeTs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LUHGkfy/dSnejjScQOCNVj09R7nAcaFnzCnB30+aGUuCvpKxjPa4FxzP1IerLKFuj
         F39jAJ8S9LWgGUi3J69UESavcy4MvVicchaFU5cXdwLO+M77toTnpF22oTU/CRXt1E
         XOF2sNshOJVERQdcaJrmCEKGPE7SSDZQPmpd+LUk=
Date:   Mon, 30 Dec 2019 02:08:40 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Chris Wilson <chris@chris-wilson.co.uk>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Rik van Riel <riel@surriel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 2/6] sched/vtime: Bring up complete kcpustat accessor
Message-ID: <20191230010839.GA8740@lenoir>
References: <20191121024430.19938-1-frederic@kernel.org>
 <20191121024430.19938-3-frederic@kernel.org>
 <157756657962.14652.10349541055640858962@skylake-alporthouse-com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <157756657962.14652.10349541055640858962@skylake-alporthouse-com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 28, 2019 at 08:56:19PM +0000, Chris Wilson wrote:
> I'm randomly hitting this WARN on a non-virtualised system reading
> /proc/stat.
> 
> vtime->state is updated under the write_seqcount, so the access here is
> deliberately racey, and the change in vtime->state would be picked up
> the seqcount_retry.
> 
> Quick suggestion would be something along the lines of
> 
>  static int vtime_state_check(struct vtime *vtime, int cpu)
>  {
> +	int state = READ_ONCE(vtime->state);
> +
>  	/*
>  	 * We raced against a context switch, fetch the
>  	 * kcpustat task again.
> @@ -930,10 +932,10 @@ static int vtime_state_check(struct vtime *vtime, int cpu)
>  	 *
>  	 * Case 1) is ok but 2) is not. So wait for a safe VTIME state.
>  	 */
> -	if (vtime->state == VTIME_INACTIVE)
> +	if (state == VTIME_INACTIVE)
>  		return -EAGAIN;
> 
> -	return 0;
> +	return state;
>  }
> 
>  static u64 kcpustat_user_vtime(struct vtime *vtime)
> @@ -1055,7 +1057,7 @@ static int kcpustat_cpu_fetch_vtime(struct kernel_cpustat *dst,
>  		cpustat = dst->cpustat;
> 
>  		/* Task is sleeping, dead or idle, nothing to add */
> -		if (vtime->state < VTIME_SYS)
> +		if (err < VTIME_SYS)
>  			continue;
> 
>  		delta = vtime_delta(vtime);
> @@ -1064,15 +1066,15 @@ static int kcpustat_cpu_fetch_vtime(struct kernel_cpustat *dst,
>  		 * Task runs either in user (including guest) or kernel space,
>  		 * add pending nohz time to the right place.
>  		 */
> -		if (vtime->state == VTIME_SYS) {
> +		if (err == VTIME_SYS) {
>  			cpustat[CPUTIME_SYSTEM] += vtime->stime + delta;
> -		} else if (vtime->state == VTIME_USER) {
> +		} else if (err == VTIME_USER) {
>  			if (task_nice(tsk) > 0)
>  				cpustat[CPUTIME_NICE] += vtime->utime + delta;
>  			else
>  				cpustat[CPUTIME_USER] += vtime->utime + delta;
>  		} else {
> -			WARN_ON_ONCE(vtime->state != VTIME_GUEST);
> +			WARN_ON_ONCE(err != VTIME_GUEST);
>  			if (task_nice(tsk) > 0) {
>  				cpustat[CPUTIME_GUEST_NICE] += vtime->gtime + delta;
>  				cpustat[CPUTIME_NICE] += vtime->gtime + delta;
> 
> Or drop the warn.

Good catch, can I use your Signed-off-by ?

Thanks.
