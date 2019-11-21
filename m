Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59114C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 14:14:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C8FA206DA
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 14:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574345657;
	bh=yrY1+PrSgHnuhC1q4l+RJtecHMlK3eI481hfgDhR2nI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=fJkOZYV/oiF2IJGIDuJ8Ot/sYlGWTe6AfCQaz3IpoIswP0e4WhAUB4dQmKChfhuLE
	 Hpbiz9AlvNs8BanhSzHnjpGOnHa1IDyX8cOs0Lz5OpqFNHTanWpO6UPEjYnWSFrUIZ
	 ssGQnlr96NYdWha4FnhIvZkE10KWFYwGoLubSCiE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbfKUOOQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 09:14:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:42862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726613AbfKUOOP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 09:14:15 -0500
Received: from localhost (lfbn-ncy-1-150-155.w83-194.abo.wanadoo.fr [83.194.232.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E40D2206D7;
        Thu, 21 Nov 2019 14:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574345654;
        bh=yrY1+PrSgHnuhC1q4l+RJtecHMlK3eI481hfgDhR2nI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YWaunm5rNrJy8+9XedsaT48F+WyCoeAqkczVNMjaIbaw+MDbTeoaJ7hPH/84HZFLi
         CcbauHV82zlmLimN1wnrWNQtICWuiuKybcR3GEJI8cQ8K31dopCswGGkB9GLcxMMXw
         V+2kp0z6sdLO/mqpraeK7hwe2vA/SdgDBEFIqbIA=
Date:   Thu, 21 Nov 2019 15:14:11 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
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
Message-ID: <20191121141410.GA17301@lenoir>
References: <20191121024430.19938-1-frederic@kernel.org>
 <20191121024430.19938-6-frederic@kernel.org>
 <20191121065826.GA3552@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191121065826.GA3552@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 21, 2019 at 07:58:26AM +0100, Ingo Molnar wrote:
> 
> * Frederic Weisbecker <frederic@kernel.org> wrote:
> 
> > We can now safely read user kcpustat fields on nohz_full CPUs.
> > Use the appropriate accessor.
> > 
> > Reported-by: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
> > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> > Cc: Jacek Anaszewski <jacek.anaszewski@gmail.com>
> > Cc: Pavel Machek <pavel@ucw.cz>
> > Cc: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Rik van Riel <riel@surriel.com>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Wanpeng Li <wanpengli@tencent.com>
> > Cc: Ingo Molnar <mingo@kernel.org>
> > ---
> >  drivers/leds/trigger/ledtrig-activity.c | 14 +++++++++-----
> >  1 file changed, 9 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/leds/trigger/ledtrig-activity.c b/drivers/leds/trigger/ledtrig-activity.c
> > index ddfc5edd07c8..6901e3631c22 100644
> > --- a/drivers/leds/trigger/ledtrig-activity.c
> > +++ b/drivers/leds/trigger/ledtrig-activity.c
> > @@ -57,11 +57,15 @@ static void led_activity_function(struct timer_list *t)
> >  	curr_used = 0;
> >  
> >  	for_each_possible_cpu(i) {
> > -		curr_used += kcpustat_cpu(i).cpustat[CPUTIME_USER]
> > -			  +  kcpustat_cpu(i).cpustat[CPUTIME_NICE]
> > -			  +  kcpustat_field(&kcpustat_cpu(i), CPUTIME_SYSTEM, i)
> > -			  +  kcpustat_cpu(i).cpustat[CPUTIME_SOFTIRQ]
> > -			  +  kcpustat_cpu(i).cpustat[CPUTIME_IRQ];
> > +		struct kernel_cpustat kcpustat;
> > +
> > +		kcpustat_fetch_cpu(&kcpustat, i);
> > +
> > +		curr_used += kcpustat.cpustat[CPUTIME_USER]
> > +			  +  kcpustat.cpustat[CPUTIME_NICE]
> > +			  +  kcpustat.cpustat[CPUTIME_SYSTEM]
> > +			  +  kcpustat.cpustat[CPUTIME_SOFTIRQ]
> > +			  +  kcpustat.cpustat[CPUTIME_IRQ];
> 
> Not the best tested series:
> 
> --- a/drivers/leds/trigger/ledtrig-activity.c
> +++ b/drivers/leds/trigger/ledtrig-activity.c
> @@ -59,7 +59,7 @@ static void led_activity_function(struct timer_list *t)
>  	for_each_possible_cpu(i) {
>  		struct kernel_cpustat kcpustat;
>  
> -		kcpustat_fetch_cpu(&kcpustat, i);
> +		kcpustat_cpu_fetch(&kcpustat, i);
>  
>  		curr_used += kcpustat.cpustat[CPUTIME_USER]
>  			  +  kcpustat.cpustat[CPUTIME_NICE]
> 
> 
> :-)

Oops, I tested with vtime on and off but that one slipped under my config.
Do you want me to resend?

Thanks.
