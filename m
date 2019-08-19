Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B666FC3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 20:06:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85EC02087E
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 20:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566245216;
	bh=P9qfTEqxT6ZHograv3Z89yuDOfq2mcYK+Rb/cgibrXI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=HDgqIeymH3Kc1Achy4/aSuGHCXYqkwwZ5pF5trXxlVdb2OY+/T1000kpzLhlN7Qg5
	 aqQASIdqccYmq4RXp+YULuZ2VqXEjPn9aqR2jVPEd/N4oSwCkBcfkbSOyqFozpTc1f
	 L6rWXfAtWQSSIqQVsPapP2K0+agFHE938PFtTfIM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728245AbfHSUGz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 16:06:55 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36994 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727970AbfHSUGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 16:06:55 -0400
Received: by mail-wm1-f65.google.com with SMTP id d16so630881wme.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 13:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tzYRXUYr0FCbyyy6fmJd28X4pd6BBGIYoagBzr4MQ4s=;
        b=CACSxZagY+2/vcqXSh4+v6a4u7FriX4fu7ZGnayF1HfoNyCWbEg70WRA0dTqFW9ZJC
         iXefL7eKH8Ls4snJROLwl4wzXQ9xhtuYy63Htmw2Kr3pi10NS1GUZvnIax7WbrRYdBAZ
         gVHY7ThMgekPh1bWTS2WtJk9i8ovfGqlsBF+9Zw6V2sCuQEeAV+DMgpR4NMkVIFN/IdJ
         resqvH/2VJqF5mxYpJT+sBSo4nqbp5+PnVKONnh9mP562Br4sZn7GwduHrVKCuKIDaue
         ZrFDpZAdUyYR8VJ7kwFYkBi91x9DAKkmFVelYv0dghxjRh90PRPemgy3Cr+ibqXx6wAa
         YM0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=tzYRXUYr0FCbyyy6fmJd28X4pd6BBGIYoagBzr4MQ4s=;
        b=HSde/0E+9+EPgQ5nh2p3xLFVywwSD9bC3LqgGiwgkjkpbD/JcVFKVCFfGHbn54Cn9Z
         49pHazrTmkPfn20IDpF4OAgyvcmTF+0hCOxdfngC8x6VuaNq5BdY2nFNPKnhznekqCvQ
         dBjSM0ZrY6fd3xWo6zklbr51ZO+POOjm9IMxtWPwcJp5BMPWNI/Y6kLHMTVE+wz+LxDw
         PThgq5tmHGAJ9MbAxvpmtLtEc9W3vybFGWTdPTsjD/xwPUy5fc6BETh5K8DSfQDG1jTp
         qM8w25k1pU2PD+3Gw9n/Z5dbHCNmxgHw6OG0hJuSOD/Dzjr0I5EpUeJWcbiL3zKmMvU5
         F+4w==
X-Gm-Message-State: APjAAAXFo3RkQ1N96zdod0ayt1CNrkloFqQlKSl9caDT6/A+9AEvRB6S
        wWedAk6vj+PfLpGOQ3Nxykc=
X-Google-Smtp-Source: APXvYqyK6YIWo3Rql9ZFbZU+YTEAySlNGkcsHTJot2CtbNdO7qMlqfl+HAio/F9za3W/9TJZZB1lOw==
X-Received: by 2002:a1c:7d08:: with SMTP id y8mr23446635wmc.50.1566245212852;
        Mon, 19 Aug 2019 13:06:52 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id u129sm19375565wmb.12.2019.08.19.13.06.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2019 13:06:52 -0700 (PDT)
Date:   Mon, 19 Aug 2019 22:06:50 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: Re: [patch 38/44] posix-cpu-timers: Respect INFINITY for hard RTTIME
 limit
Message-ID: <20190819200650.GE68079@gmail.com>
References: <20190819143141.221906747@linutronix.de>
 <20190819143805.022020654@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190819143805.022020654@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Thomas Gleixner <tglx@linutronix.de> wrote:

> The RTIME limit expiry code does not check the hard RTTIME limit for
> INFINITY, i.e. being disabled.  Add it.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  kernel/time/posix-cpu-timers.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- a/kernel/time/posix-cpu-timers.c
> +++ b/kernel/time/posix-cpu-timers.c
> @@ -905,7 +905,7 @@ static void check_process_timers(struct
>  		u64 softns, ptime = samples[CPUCLOCK_PROF];
>  		unsigned long psecs = div_u64(ptime, NSEC_PER_SEC);
>  
> -		if (psecs >= hard) {
> +		if (hard != RLIM_INFINITY && psecs >= hard) {
>  			/*
>  			 * At the hard limit, we just die.
>  			 * No need to calculate anything else now.

Might make sense to mark this as a possible ABI change in the changelog: 
if some weird code learned to rely on this (arguably broken) behavior 
then the bug turned into an ABI.

Thanks,

	Ingo
