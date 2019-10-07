Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CED59C47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 13:55:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97A9220673
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 13:55:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vYkaQS7u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727939AbfJGNzG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 09:55:06 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54057 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727490AbfJGNzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 09:55:06 -0400
Received: by mail-wm1-f65.google.com with SMTP id i16so12789390wmd.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 06:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HIwE2HHTxyYipXLKEIdRSNS1N2zOO5yFZjncgRSQ/Cg=;
        b=vYkaQS7u78p1GsL6JJGBdxcIvh5hek2IrzvnqT2ZXhICOZ/MAjAp0Pv/2ENTHPra+9
         gbVRPP2QdIlUb6QBO0E5iebQOmzeXRXcvVKSFzp75tKK9kmYGfaO6ih+FyihVSridZQE
         cDasd05kgT5xeyOHoLsrzcje1WLpQjxQn3T977FXRyG6UGxqGime9+YYzgxiLOlGpc49
         cfI79M0Tfowen9/T+IyrBYG+uBBy+SABuAuOaPYJhnCQmYPoBRPRzHe1v57XXTdDXI0R
         RX+UQtnMTqEVzglgSBk9l31VFteuTu4NDt6ucS96mvn6ur56tKLPNlmIHqPAPtP8NXxo
         o71Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HIwE2HHTxyYipXLKEIdRSNS1N2zOO5yFZjncgRSQ/Cg=;
        b=EIMLOWMr88JuSqaDN3sRbCGaptOQeAvmnEpd06KbId5d0dYzp7Dhgjgoz2h1Q9xzII
         Wa+AhQZRa2JshRvJwFkiWEEax+E62xPMJD3PMQjux/rUjJXx/O2BsHDE7+IYJpvzqyUU
         rDR4gpxn51cDmWUFUU2zMMig8j6QoVC2P7h5qFRMjiUZxFCfaCVAwKJzs6lmH5tE5fpv
         /252myfy52qYY/K/7ELtnZQJuir/KUAVU8pax8yrv1a/hArS9rahdmNwfLPfyhux9kTA
         1wHnp+J/UJOJCNPXUROH/I/w4Y6ge/Y0ez6L3UWb2mg7+ZZq3sHRxJEYgK5+SpNQsTXC
         Xo+w==
X-Gm-Message-State: APjAAAU1HA7eeKENxHiarUZTU1AWc2iwa/YwdHE5kRr2EJfsSddMH1tN
        tEoLE54q14e5PKQgy88OpPTFc71gLy8=
X-Google-Smtp-Source: APXvYqznXn6Yn8jWOxAVikMeJSL6gPA5ufBWBMxd28ES2haKHtYLgj1t+x4kxFIRR6f37SF5CoTvHw==
X-Received: by 2002:a7b:c00e:: with SMTP id c14mr21020782wmb.60.1570456501994;
        Mon, 07 Oct 2019 06:55:01 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id r2sm31671751wma.1.2019.10.07.06.55.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2019 06:55:01 -0700 (PDT)
Date:   Mon, 7 Oct 2019 14:54:59 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        kgdb-bugreport@lists.sourceforge.net,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/4] kdb: Fix "btc <cpu>" crash if the CPU didn't
 round up
Message-ID: <20191007135459.lj3qc2tqzcv3xcia@holly.lan>
References: <20190925200220.157670-1-dianders@chromium.org>
 <20190925125811.v3.3.Id33c06cbd1516b49820faccd80da01c7c4bf15c7@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190925125811.v3.3.Id33c06cbd1516b49820faccd80da01c7c4bf15c7@changeid>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 25, 2019 at 01:02:19PM -0700, Douglas Anderson wrote:
> 
> I noticed that when I did "btc <cpu>" and the CPU I passed in hadn't
> rounded up that I'd crash.  I was going to copy the same fix from
> commit 162bc7f5afd7 ("kdb: Don't back trace on a cpu that didn't round
> up") into the "not all the CPUs" case, but decided it'd be better to
> clean things up a little bit.
> 
> This consolidates the two code paths.  It is _slightly_ wasteful in in
> that the checks for "cpu" being too small or being offline isn't
> really needed when we're iterating over all online CPUs, but that
> really shouldn't hurt.  Better to have the same code path.
> 
> While at it, eliminate at least one slightly ugly (and totally
> needless) recursive use of kdb_parse().
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> 
> Changes in v3:
> - Patch ("kdb: Fix "btc <cpu>" crash if the CPU...") new for v3.
> 
> Changes in v2: None
> 
>  kernel/debug/kdb/kdb_bt.c | 61 ++++++++++++++++++++++-----------------
>  1 file changed, 34 insertions(+), 27 deletions(-)
> 
> diff --git a/kernel/debug/kdb/kdb_bt.c b/kernel/debug/kdb/kdb_bt.c
> index 120fc686c919..d9af139f9a31 100644
> --- a/kernel/debug/kdb/kdb_bt.c
> +++ b/kernel/debug/kdb/kdb_bt.c
> @@ -101,6 +101,27 @@ kdb_bt1(struct task_struct *p, unsigned long mask, bool btaprompt)
>  	return 0;
>  }
>  
> +static void
> +kdb_bt_cpu(unsigned long cpu)
> +{
> +	struct task_struct *kdb_tsk;
> +
> +	if (cpu >= num_possible_cpus() || !cpu_online(cpu)) {
> +		kdb_printf("WARNING: no process for cpu %ld\n", cpu);
> +		return;
> +	}
> +
> +	/* If a CPU failed to round up we could be here */
> +	kdb_tsk = KDB_TSK(cpu);
> +	if (!kdb_tsk) {
> +		kdb_printf("WARNING: no task for cpu %ld\n", cpu);
> +		return;
> +	}
> +
> +	kdb_set_current_task(kdb_tsk);
> +	kdb_bt1(kdb_tsk, ~0UL, false);
> +}
> +
>  int
>  kdb_bt(int argc, const char **argv)
>  {
> @@ -161,7 +182,6 @@ kdb_bt(int argc, const char **argv)
>  	} else if (strcmp(argv[0], "btc") == 0) {
>  		unsigned long cpu = ~0;
>  		struct task_struct *save_current_task = kdb_current_task;
> -		char buf[80];
>  		if (argc > 1)
>  			return KDB_ARGCOUNT;
>  		if (argc == 1) {
> @@ -169,35 +189,22 @@ kdb_bt(int argc, const char **argv)
>  			if (diag)
>  				return diag;
>  		}
> -		/* Recursive use of kdb_parse, do not use argv after
> -		 * this point */
> -		argv = NULL;
>  		if (cpu != ~0) {
> -			if (cpu >= num_possible_cpus() || !cpu_online(cpu)) {
> -				kdb_printf("no process for cpu %ld\n", cpu);
> -				return 0;
> -			}
> -			sprintf(buf, "btt 0x%px\n", KDB_TSK(cpu));
> -			kdb_parse(buf);
> -			return 0;
> -		}
> -		kdb_printf("btc: cpu status: ");
> -		kdb_parse("cpu\n");
> -		for_each_online_cpu(cpu) {
> -			void *kdb_tsk = KDB_TSK(cpu);
> -
> -			/* If a CPU failed to round up we could be here */
> -			if (!kdb_tsk) {
> -				kdb_printf("WARNING: no task for cpu %ld\n",
> -					   cpu);
> -				continue;
> +			kdb_bt_cpu(cpu);
> +		} else {
> +			/*
> +			 * Recursive use of kdb_parse, do not use argv after
> +			 * this point.
> +			 */
> +			argv = NULL;
> +			kdb_printf("btc: cpu status: ");
> +			kdb_parse("cpu\n");
> +			for_each_online_cpu(cpu) {
> +				kdb_bt_cpu(cpu);
> +				touch_nmi_watchdog();
>  			}
> -
> -			sprintf(buf, "btt 0x%px\n", kdb_tsk);
> -			kdb_parse(buf);
> -			touch_nmi_watchdog();
> +			kdb_set_current_task(save_current_task);
>  		}
> -		kdb_set_current_task(save_current_task);

Why does this move out into only one of the conditional branches?
Don't both of the above paths modify the current task?


Daniel.


>  		return 0;
>  	} else {
>  		if (argc) {
> -- 
> 2.23.0.351.gc4317032e6-goog
> 
