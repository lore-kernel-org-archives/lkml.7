Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E92DDC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 11:51:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9894223D0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 11:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574250708;
	bh=fJL6xJRgZK2J6azQu5Bbs7i6OL7gxtv3W+Ya7In/6Og=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0WWmbaCKX93pqYIrI62748ecELfQa/6mxewAMTS2DF/AvJw3gm6mSt+12JsI8B4w7
	 LUbSdILXj6hnHaKW/6qV2KCftY2dHwJjkI4JPTrRFdKw7yYysPRFdURk1Za25j1Z7t
	 CmI+npH+qrnRFP1aQt9eJxF9Vi/eRnYEqG/0pnxQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729379AbfKTLvr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 06:51:47 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43891 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728753AbfKTLvr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 06:51:47 -0500
Received: by mail-wr1-f65.google.com with SMTP id n1so27758498wra.10
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2019 03:51:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tI6OKEwlVvSFWzzP0j2qRSoJbuopPUtmq4V1NmM4b4c=;
        b=SgdQoJPPepQK44LRX3SjvfpT3nspCWZKw+YmFBIb88MWhysL2JFk6j2A3ZvERYWNp+
         GXIpsFAV9siIjtA3t7UdDMZuBe0bi5+5X178WIBKaGjQQGRawqKzuaRQVKV4pVc1LY+D
         PRneOoJFokWHh+WKl4uy8r3arkmhojWveQXtOiil7y3tWyw0ehYZfQ87uwD+rvQEV75a
         bw7eB3ApLir1z6mS74e1XkfEE86KGBq9qh45H+RQkVnRtq/kqHsd4LbuamSbLQ2mgniD
         B44DQFAo4aksAJCyM1aUjOS0R6S3bHSx9E4aWv6Px5HTcQjlG5dcU47n3zsnYtELSc2F
         PTAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=tI6OKEwlVvSFWzzP0j2qRSoJbuopPUtmq4V1NmM4b4c=;
        b=WgsMza6lDQInAh31f17CItAKHZz2EUVjAw+YfBe705otrsExVIw+O7PgelAC4afk8V
         hk8LY51AW57zAs81cS1mNT6HWM8IsqK6KVTtoMEy9w7a2JjzYtocqLcl7UdFdFnl+g0a
         r5E8OBdqpkEuPzGTsuBBYplL5u02axP9//nOQLhFy4b2ZmY7n8qDI8s5DGRE3xz0auem
         GMZvRhRX8ROj8kOm3qqmif5AKeodnrtpt/m50NyAJielZcMtrLjdtSoifyoZR+IKh/um
         0bAUa0xiTuzFJCFwjDditSE/kYOh2FGSprW2Ny4/JjD58CE4piRJaBVVwSXg2riznEXr
         nUzg==
X-Gm-Message-State: APjAAAWt9dMB3+pDPJ4EU+jmtLZapOO2Q1yyZqyQsibJ/KtNus88KcDv
        XPblw+TMGkDUMXs1BzdXVWQ=
X-Google-Smtp-Source: APXvYqxIL2PtdFUess86i3VJ8hEapF4hXx7K/NYiOLuP5EkAOtpnTIF7JMYESjtU88fL+KJTIzSwqA==
X-Received: by 2002:adf:df0e:: with SMTP id y14mr2117531wrl.377.1574250705104;
        Wed, 20 Nov 2019 03:51:45 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id 11sm6358795wmi.8.2019.11.20.03.51.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2019 03:51:44 -0800 (PST)
Date:   Wed, 20 Nov 2019 12:51:42 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
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
Subject: Re: [PATCH 1/6] sched/cputime: Support other fields on
 kcpustat_field()
Message-ID: <20191120115142.GA89662@gmail.com>
References: <20191119232218.4206-1-frederic@kernel.org>
 <20191119232218.4206-2-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191119232218.4206-2-frederic@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Frederic Weisbecker <frederic@kernel.org> wrote:

> Provide support for user, nice, guest and guest_nice fields through
> kcpustat_field().
> 
> Whether we account the delta to a nice or not nice field is decided on
> top of the nice value snapshot taken at the time we call kcpustat_field().
> If the nice value of the task has been changed since the last vtime
> update, we may have inacurrate distribution of the nice VS unnice
> cputime.
> 
> However this is considered as a minor issue compared to the proper fix
> that would involve interrupting the target on nice updates, which is
> undesired on nohz_full CPUs.
> 
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> Cc: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Rik van Riel <riel@surriel.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Wanpeng Li <wanpengli@tencent.com>
> Cc: Ingo Molnar <mingo@kernel.org>
> ---
>  kernel/sched/cputime.c | 53 +++++++++++++++++++++++++++++++++---------
>  1 file changed, 42 insertions(+), 11 deletions(-)
> 
> diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
> index e0cd20693ef5..b2cf544e2109 100644
> --- a/kernel/sched/cputime.c
> +++ b/kernel/sched/cputime.c
> @@ -912,11 +912,21 @@ void task_cputime(struct task_struct *t, u64 *utime, u64 *stime)
>  	} while (read_seqcount_retry(&vtime->seqcount, seq));
>  }
>  
> +static u64 kcpustat_user_vtime(struct vtime *vtime)
> +{
> +	if (vtime->state == VTIME_USER)
> +		return vtime->utime + vtime_delta(vtime);
> +	else if (vtime->state == VTIME_GUEST)
> +		return vtime->gtime + vtime_delta(vtime);
> +	return 0;
> +}
> +
>  static int kcpustat_field_vtime(u64 *cpustat,
> -				struct vtime *vtime,
> +				struct task_struct *tsk,
>  				enum cpu_usage_stat usage,
>  				int cpu, u64 *val)
>  {
> +	struct vtime *vtime = &tsk->vtime;
>  	unsigned int seq;
>  	int err;
>  
> @@ -946,9 +956,36 @@ static int kcpustat_field_vtime(u64 *cpustat,
>  
>  		*val = cpustat[usage];
>  
> -		if (vtime->state == VTIME_SYS)
> -			*val += vtime->stime + vtime_delta(vtime);
> -
> +		/*
> +		 * Nice VS unnice cputime accounting may be inaccurate if
> +		 * the nice value has changed since the last vtime update.
> +		 * But proper fix would involve interrupting target on nice
> +		 * updates which is a no go on nohz_full.

Well, we actually already interrupt the target in both sys_nice() and 
sys_setpriority() etc. syscall variants: we call set_user_nice() which 
calls resched_curr() and the task is sent an IPI and runs through a 
reschedule.

But ... I do agree that this kind of granularity of nice/non-nice 
accounting doesn't really matter in practice: the changing of nice values 
is a relatively low frequency operation on most systems.

But nevertheless the comment should probably be updated to reflect this.

Thanks,

	Ingo
