Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D32CBC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:47:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A16EF20870
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574891248;
	bh=EkA1v2/1S366xNgUBA8JF1UoqzxfzHPPRcLBNop72jg=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=fq5BuueUQ6FnJfKUzfCBJIQpHwwquVBY/zFjA/MY1mxkuDxyAkd/I3RApiIsgEFk8
	 nRUcvYnjJtH+9RS4uQn3CY3VU11YbP7FFPx+MsLSwC5E8XX2oMOvI6LU/MIv909sZo
	 TcDj29PPfzJ/RqRfA2E14qNuPeSpIFrrp6PvFFaw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727903AbfK0Vr1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 16:47:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:56814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727491AbfK0Vr1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 16:47:27 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D574420869;
        Wed, 27 Nov 2019 21:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574891245;
        bh=EkA1v2/1S366xNgUBA8JF1UoqzxfzHPPRcLBNop72jg=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=L6yhIeX7vtUrVoZIffP/tyZL5DNmbG1YiL9mIQjZQzz/LICwd+ImdBHrT5GstwJLl
         yb2BOXbZvt0vSsKxef1qXTSTE/p7tKpoG8+4GMmD7qT7/HQIy5RnwePNoL0vY1QH9H
         qoLOfaP8YkPp96MCHRj1tspm87P4GP6w694oua/Y=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id A6B2A352151A; Wed, 27 Nov 2019 13:47:25 -0800 (PST)
Date:   Wed, 27 Nov 2019 13:47:25 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 12/14] torture: Replace cpu_up/down with
 device_online/offline
Message-ID: <20191127214725.GG2889@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20191125112754.25223-1-qais.yousef@arm.com>
 <20191125112754.25223-13-qais.yousef@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191125112754.25223-13-qais.yousef@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 25, 2019 at 11:27:52AM +0000, Qais Yousef wrote:
> The core device API performs extra housekeeping bits that are missing
> from directly calling cpu_up/down.
> 
> See commit a6717c01ddc2 ("powerpc/rtas: use device model APIs and
> serialization during LPM") for an example description of what might go
> wrong.
> 
> This also prepares to make cpu_up/down a private interface for anything
> but the cpu subsystem.
> 
> Signed-off-by: Qais Yousef <qais.yousef@arm.com>
> CC: Davidlohr Bueso <dave@stgolabs.net>
> CC: "Paul E. McKenney" <paulmck@kernel.org>
> CC: Josh Triplett <josh@joshtriplett.org>
> CC: linux-kernel@vger.kernel.org

Looks fine from an rcutorture viewpoint, but why not provide an API
that pulled lock_device_hotplug() and unlock_device_hotplug() into the
online/offline calls?

							Thanx, Paul

> ---
>  kernel/torture.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/torture.c b/kernel/torture.c
> index 7c13f5558b71..12115024feb2 100644
> --- a/kernel/torture.c
> +++ b/kernel/torture.c
> @@ -97,7 +97,9 @@ bool torture_offline(int cpu, long *n_offl_attempts, long *n_offl_successes,
>  			 torture_type, cpu);
>  	starttime = jiffies;
>  	(*n_offl_attempts)++;
> -	ret = cpu_down(cpu);
> +	lock_device_hotplug();
> +	ret = device_offline(get_cpu_device(cpu));
> +	unlock_device_hotplug();
>  	if (ret) {
>  		if (verbose)
>  			pr_alert("%s" TORTURE_FLAG
> @@ -148,7 +150,9 @@ bool torture_online(int cpu, long *n_onl_attempts, long *n_onl_successes,
>  			 torture_type, cpu);
>  	starttime = jiffies;
>  	(*n_onl_attempts)++;
> -	ret = cpu_up(cpu);
> +	lock_device_hotplug();
> +	ret = device_online(get_cpu_device(cpu));
> +	unlock_device_hotplug();
>  	if (ret) {
>  		if (verbose)
>  			pr_alert("%s" TORTURE_FLAG
> @@ -192,17 +196,20 @@ torture_onoff(void *arg)
>  	for_each_online_cpu(cpu)
>  		maxcpu = cpu;
>  	WARN_ON(maxcpu < 0);
> -	if (!IS_MODULE(CONFIG_TORTURE_TEST))
> +	if (!IS_MODULE(CONFIG_TORTURE_TEST)) {
> +		lock_device_hotplug();
>  		for_each_possible_cpu(cpu) {
>  			if (cpu_online(cpu))
>  				continue;
> -			ret = cpu_up(cpu);
> +			ret = device_online(get_cpu_device(cpu));
>  			if (ret && verbose) {
>  				pr_alert("%s" TORTURE_FLAG
>  					 "%s: Initial online %d: errno %d\n",
>  					 __func__, torture_type, cpu, ret);
>  			}
>  		}
> +		unlock_device_hotplug();
> +	}
>  
>  	if (maxcpu == 0) {
>  		VERBOSE_TOROUT_STRING("Only one CPU, so CPU-hotplug testing is disabled");
> -- 
> 2.17.1
> 
