Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DABAAC3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 18:13:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE27B21874
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 18:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566584032;
	bh=0xCTw48rry1GjSWCA20nVEdZYRx5dvv2Tbjic/QpYPY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=FSzYjgJefUBPWg5xax+T36IGs5nZuUdrRUA0D76YUx9GKUOWDSr4pzJNq1quIr/AS
	 EcWweyODJtkEPPFtO83K79gPjFdIptFUJJ/9mN1ySLLz8rrfB5B4U+/MsO5aTIEAdj
	 SGszQtmh2M/XoMFr2NGf2fRAjY0oKolNLpHa4HRs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405109AbfHWSNv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 14:13:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:50022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404488AbfHWSNv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 14:13:51 -0400
Received: from localhost (lfbn-ncy-1-174-150.w83-194.abo.wanadoo.fr [83.194.254.150])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E90D621848;
        Fri, 23 Aug 2019 18:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566584030;
        bh=0xCTw48rry1GjSWCA20nVEdZYRx5dvv2Tbjic/QpYPY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j3tW81QpTB4r67eNegKPJ86zydDCKm1MRiXRPdCkc4qp949w72IBq4QydoGi5xGp9
         LBXwnh2eI8YZD/1fF1yl4nIf4m7PQZgkBEgqwcYY1s27N+TUI3QexUE6fG/2jwjmgN
         R64GaEWxd78Sdbut6vtF4HYAxYbnnbe7AwjtHkDE=
Date:   Fri, 23 Aug 2019 20:13:48 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [patch V2 23/38] posix-cpu-timers: Switch check_*_timers() to
 array cache
Message-ID: <20190823181347.GD18880@lenoir>
References: <20190821190847.665673890@linutronix.de>
 <20190821192921.408222378@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190821192921.408222378@linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 21, 2019 at 09:09:10PM +0200, Thomas Gleixner wrote:
> Use the array based expiry cache in check_thread_timers() and convert the
> store in check_process_timers() for consistency.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  kernel/time/posix-cpu-timers.c |   26 +++++++++++---------------
>  1 file changed, 11 insertions(+), 15 deletions(-)
> 
> --- a/kernel/time/posix-cpu-timers.c
> +++ b/kernel/time/posix-cpu-timers.c
> @@ -778,8 +778,7 @@ static void check_thread_timers(struct t
>  				struct list_head *firing)
>  {
>  	struct list_head *timers = tsk->posix_cputimers.cpu_timers;
> -	struct task_cputime *tsk_expires = &tsk->posix_cputimers.cputime_expires;
> -	u64 expires, stime, utime;
> +	u64 stime, utime, *expires = tsk->posix_cputimers.expiries;
>  	unsigned long soft;
>  
>  	if (dl_task(tsk))
> @@ -789,19 +788,14 @@ static void check_thread_timers(struct t
>  	 * If cputime_expires is zero, then there are no active
>  	 * per thread CPU timers.
>  	 */
> -	if (task_cputime_zero(tsk_expires))
> +	if (task_cputime_zero(&tsk->posix_cputimers.cputime_expires))
>  		return;
>  
>  	task_cputime(tsk, &utime, &stime);
>  
> -	expires = check_timers_list(timers, firing, utime + stime);
> -	tsk_expires->prof_exp = expires;
> -
> -	expires = check_timers_list(++timers, firing, utime);
> -	tsk_expires->virt_exp = expires;
> -
> -	tsk_expires->sched_exp = check_timers_list(++timers, firing,
> -						   tsk->se.sum_exec_runtime);
> +	*expires++ = check_timers_list(timers, firing, utime + stime);
> +	*expires++ = check_timers_list(++timers, firing, utime);
> +	*expires = check_timers_list(++timers, firing, tsk->se.sum_exec_runtime);

What a nice reading for anyone learning the difference between pointers's
pre and post incrementation :-)

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
