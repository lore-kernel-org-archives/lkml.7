Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B5CBC432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 16:50:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15D1B2067D
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 16:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574355005;
	bh=TB9g6SOH+1ya0uwgfVHDrexpC8uetzw8yiOnRhgswBs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=k2uWTf3FuqZhsxNcQ3HRj1QGggj7kuKifpSi9uuuZlfePib1eGLCA8JJziX5s/mM+
	 c9jvD59I/kf4QPXj8rhRSnudrT7VusUxwg1pi06Oh6I6IeY9k3VlLkmgjxu2IZXRLp
	 9B9uvzLo1eqIcymEO0W6SDnQyK8d+mdnxiCsOUOQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbfKUQuE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 11:50:04 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36581 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726279AbfKUQuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 11:50:03 -0500
Received: by mail-wm1-f66.google.com with SMTP id n188so2593113wme.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 08:50:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nARvRJe8IG8Ozbyqs0oQ0/7TITtn5wag058peJHBpZg=;
        b=Md7qsHyhqKF3kozzj2W2LpQc9Ck3Zlp4BsZy3JhEM1p8qJalTWheghmCL9n1sNqHvU
         /sHDzMTnhYsRu/X9pKjmSn9nOEDyDnlbCwx54F/mQ43AIraqwOu7GjXd6rSpvx3MXvXb
         9HbH/fgMaAos2pfN0KSBPXxwmX2nLNThFT2mbfWicLtAsJ4ZlmFMkFSkhDKu6n5xQ551
         SJUUCbW/6tHnmysyuRKdplPMlh+AU3hw9bLZrit3VOKV9fyEU0kKgQnLuq16ekO6Qj2k
         fpZB0mJC7ZMBfA+qwiUuAvbsDB8nNTz7i+aRMCo8h7Z/UPh7jkYd46xjRIQ10+D1w52U
         buAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=nARvRJe8IG8Ozbyqs0oQ0/7TITtn5wag058peJHBpZg=;
        b=ulPviOFXYyniF3CIuBSumC9KTXzMZe5yVGqR/UWPCsuInPb2WuSbwC7o87v+W3fffP
         +K+N4DFY92Ts4SxvdzsW/U0gZzYng7Qqggco0UFMCBOmbQ+UT7ZTtL24wUdt9q9v/xOh
         SB2OZksUaMClEUbDCzB89S1nLV8TQC+fAaoZh7MHgYUklGE/7Pg14TB4KJGVXbKCpIo8
         RO+ar/LqyvOlAlBXOQSZ18l9bAJQNYF2uopyHmZo2W6leXrFqfM7tzulkFZv7MEg5vIn
         +xdBdZSVw1adPtVcWE48F41+GBp1Uos5kJ5Sc1pFLdd87VNwVNjDgqyNd8NA31eMZ/BB
         aIpA==
X-Gm-Message-State: APjAAAUuho3KxjGzExjtc5KviM54ZwUbtfFnHIx9CxYqmexT1sUUlqez
        Gs2OdyVVX0g52U9EIbmjxCY=
X-Google-Smtp-Source: APXvYqyalndcchVSDARCT74h65CZta/v+w5MAn9OYVISbrmcoBLXrvACtNcMrL2KQ7h5zdtRzuvZjQ==
X-Received: by 2002:a05:600c:2253:: with SMTP id a19mr11068931wmm.97.1574355001650;
        Thu, 21 Nov 2019 08:50:01 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id i71sm4369790wri.68.2019.11.21.08.50.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2019 08:50:01 -0800 (PST)
Date:   Thu, 21 Nov 2019 17:49:58 +0100
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
Subject: Re: [PATCH 5/6] leds: Use all-in-one vtime aware kcpustat accessor
Message-ID: <20191121164958.GA46146@gmail.com>
References: <20191121024430.19938-1-frederic@kernel.org>
 <20191121024430.19938-6-frederic@kernel.org>
 <20191121065826.GA3552@gmail.com>
 <20191121141410.GA17301@lenoir>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191121141410.GA17301@lenoir>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Frederic Weisbecker <frederic@kernel.org> wrote:

> On Thu, Nov 21, 2019 at 07:58:26AM +0100, Ingo Molnar wrote:
> > 
> > * Frederic Weisbecker <frederic@kernel.org> wrote:
> > 
> > > We can now safely read user kcpustat fields on nohz_full CPUs.
> > > Use the appropriate accessor.
> > > 
> > > Reported-by: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
> > > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> > > Cc: Jacek Anaszewski <jacek.anaszewski@gmail.com>
> > > Cc: Pavel Machek <pavel@ucw.cz>
> > > Cc: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
> > > Cc: Thomas Gleixner <tglx@linutronix.de>
> > > Cc: Rik van Riel <riel@surriel.com>
> > > Cc: Peter Zijlstra <peterz@infradead.org>
> > > Cc: Wanpeng Li <wanpengli@tencent.com>
> > > Cc: Ingo Molnar <mingo@kernel.org>
> > > ---
> > >  drivers/leds/trigger/ledtrig-activity.c | 14 +++++++++-----
> > >  1 file changed, 9 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/drivers/leds/trigger/ledtrig-activity.c b/drivers/leds/trigger/ledtrig-activity.c
> > > index ddfc5edd07c8..6901e3631c22 100644
> > > --- a/drivers/leds/trigger/ledtrig-activity.c
> > > +++ b/drivers/leds/trigger/ledtrig-activity.c
> > > @@ -57,11 +57,15 @@ static void led_activity_function(struct timer_list *t)
> > >  	curr_used = 0;
> > >  
> > >  	for_each_possible_cpu(i) {
> > > -		curr_used += kcpustat_cpu(i).cpustat[CPUTIME_USER]
> > > -			  +  kcpustat_cpu(i).cpustat[CPUTIME_NICE]
> > > -			  +  kcpustat_field(&kcpustat_cpu(i), CPUTIME_SYSTEM, i)
> > > -			  +  kcpustat_cpu(i).cpustat[CPUTIME_SOFTIRQ]
> > > -			  +  kcpustat_cpu(i).cpustat[CPUTIME_IRQ];
> > > +		struct kernel_cpustat kcpustat;
> > > +
> > > +		kcpustat_fetch_cpu(&kcpustat, i);
> > > +
> > > +		curr_used += kcpustat.cpustat[CPUTIME_USER]
> > > +			  +  kcpustat.cpustat[CPUTIME_NICE]
> > > +			  +  kcpustat.cpustat[CPUTIME_SYSTEM]
> > > +			  +  kcpustat.cpustat[CPUTIME_SOFTIRQ]
> > > +			  +  kcpustat.cpustat[CPUTIME_IRQ];
> > 
> > Not the best tested series:
> > 
> > --- a/drivers/leds/trigger/ledtrig-activity.c
> > +++ b/drivers/leds/trigger/ledtrig-activity.c
> > @@ -59,7 +59,7 @@ static void led_activity_function(struct timer_list *t)
> >  	for_each_possible_cpu(i) {
> >  		struct kernel_cpustat kcpustat;
> >  
> > -		kcpustat_fetch_cpu(&kcpustat, i);
> > +		kcpustat_cpu_fetch(&kcpustat, i);
> >  
> >  		curr_used += kcpustat.cpustat[CPUTIME_USER]
> >  			  +  kcpustat.cpustat[CPUTIME_NICE]
> > 
> > 
> > :-)
> 
> Oops, I tested with vtime on and off but that one slipped under my config.
> Do you want me to resend?

No need, I suspect this slipped in via my last minute request for that 
interface cleanup - so I just applied the fix and tested it - it all 
passed testing today and I just pushed it out into tip:sched/core.

So all's good so far.

Thanks Frederic!

	Ingo
