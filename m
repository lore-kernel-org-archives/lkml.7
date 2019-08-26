Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 983F9C3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 21:06:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C58F21883
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 21:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566853604;
	bh=3DrqY7sNydcXOzeHE3ZB6MRQRURHh4+o2OgPnWcR8Fw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=w7JY36OGNbbojXPbCs3nZXPYYmEm4jMJCnfNFGB/YfmmF4XefQmeKmU+WVQsF8Jr+
	 beI9oCxbvne/EstCy+mSpGaHt1TMn0+faQzmFFDlowQwAg/qx2HTauSprGdEoRJohO
	 DelbXB5ufBAyuxrupTOdq9eFBXzautnnnRkqe7ZY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727674AbfHZVGn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 17:06:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:59218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725866AbfHZVGn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 17:06:43 -0400
Received: from localhost (lfbn-ncy-1-174-150.w83-194.abo.wanadoo.fr [83.194.254.150])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E51C6217F5;
        Mon, 26 Aug 2019 21:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566853602;
        bh=3DrqY7sNydcXOzeHE3ZB6MRQRURHh4+o2OgPnWcR8Fw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pq/TLFQRhOtP1+wwmPICVqR/oDHmBy8cpion+C/aNthU8xHogf0m0cWo+dud+YygD
         Ov6ihdZ4ZEBfGeRH6wsx6gJNwSazPmJqKFRVrGXVqMgGIWRd5N2gpBtcn9F18ZMeXf
         nWs5+RKX1pcuo55hoFS7xwSmrffXXP4AogSKLdOE=
Date:   Mon, 26 Aug 2019 23:06:39 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [patch V2 28/38] posix-cpu-timers: Restructure expiry array
Message-ID: <20190826210639.GC14309@lenoir>
References: <20190821190847.665673890@linutronix.de>
 <20190821192921.895254344@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190821192921.895254344@linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 21, 2019 at 09:09:15PM +0200, Thomas Gleixner wrote:
> @@ -884,7 +888,7 @@ static void check_process_timers(struct
>  				 struct list_head *firing)
>  {
>  	struct signal_struct *const sig = tsk->signal;
> -	struct list_head *timers = sig->posix_cputimers.cpu_timers;
> +	struct posix_cputimer_base *base = sig->posix_cputimers.bases;
>  	u64 utime, ptime, virt_expires, prof_expires;
>  	u64 sum_sched_runtime, sched_expires;
>  	struct task_cputime cputime;
> @@ -912,9 +916,12 @@ static void check_process_timers(struct
>  	ptime = utime + cputime.stime;
>  	sum_sched_runtime = cputime.sum_exec_runtime;
>  
> -	prof_expires = check_timers_list(timers, firing, ptime);
> -	virt_expires = check_timers_list(++timers, firing, utime);
> -	sched_expires = check_timers_list(++timers, firing, sum_sched_runtime);
> +	prof_expires = check_timers_list(&base[CPUCLOCK_PROF].cpu_timers,
> +					 firing, ptime);
> +	virt_expires = check_timers_list(&base[CPUCLOCK_VIRT].cpu_timers,
> +					 firing, utime);
> +	sched_expires = check_timers_list(&base[CLPCLOCK_SCHED].cpu_timers,

                                                ^^
0-day bot should have warned by now.
