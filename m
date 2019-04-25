Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D422C43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 17:44:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D68C20675
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 17:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556214273;
	bh=9Ec71msp8ibwwqMuxQnhvPOhv1JK1bp12ieuXwIKPzs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NLKugW6ItAejkDzh3byyeqJCT5AmzM1P5Fd25nKrBpX15uwqevnWn8/Ni2hRrCtYO
	 8vgBMI1JA98jDRw1K/QDVYgMVitzjyJSXfrrT2uJBasSGG+aexPaBYSAK6hIWEEUmE
	 SqOAllRw7ar68nOke9N4vLGa61koQmIFe+Qr6eR8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729874AbfDYRob (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 13:44:31 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33795 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbfDYRoa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 13:44:30 -0400
Received: by mail-wr1-f66.google.com with SMTP id c6so611659wrm.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 10:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Xm2/cwTdPPGF1yC/BRPfGQgynoGVvF0gmfXfN3IZSZM=;
        b=bQQ20QAfDR4TKzZBVf8ATmqMnCwDRSxTjXyjp0ybW/xE0jSQPgrc/7SbaHnD7ggODZ
         3mC1CW+zSpdBB1usoR1tLWn9HsquYd0Hug9JJqiGDwhW1cNuAwljO2Jfqs2X4B/bh/Gf
         MpMPrlhiik23co521gdo/p7qUml+zti2jDlQXBE6rv8fZjMMRejw2Y5LMG8SIJJH7JPn
         t10YBAFyPDiZkcoHyzpXoilyJPyPwWdAvo/PEChBuR1DFSDZR3WBq3AE1lPeaCWSQ3h9
         6b94bJ8CMYH0KaMLzyIvVhYpqG7Be4s2+JPxIbwwoWUK39G+VZy6nsgSsW1/QoOSH01k
         ayMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Xm2/cwTdPPGF1yC/BRPfGQgynoGVvF0gmfXfN3IZSZM=;
        b=AIX+Mp/Iu3buDbrUreSoyn3loZLF3J/JCzLtG9zwmvbmWUHLxRs6TIUA06FLw6TpRx
         OLwI8JazuBJGZ1gib8R1K9+jUIpnfWQFwIQknAZoyoNM6p409NbIcaDlcxcS+9EkTRK5
         d80gNmz8nFdpk73j5NbjEhPquNfPzDjyuyb+IamoGC0dSeSVcogFl8sK+CpzriRK77CI
         dxVCvi3HomaisJFMS1tr0b4RNtzkqqKzMlnPoU+mr646V9MQKMAboLEDQovWiGMG4rtK
         ycHVBB8Gk7px2yD4WlgjDfNTEcakEo1IgCpqgkbmlh43bmkR14NFGu1zedBFt/PYJRdF
         b5pg==
X-Gm-Message-State: APjAAAWp+2fu6keMvXLW4ymwuy+NRjalZ6unHqDMD1jRizobPaLdCD0o
        tfBW39DhqX4pBxY0RZbdUvyZjecR
X-Google-Smtp-Source: APXvYqyPpI8KXbWLuIX3MCRb0pSf4yrUnQGiN3eHnfYH+hJj9bjIzs1VGV7tnL2UB97cc0BiGD+vXQ==
X-Received: by 2002:adf:b3d4:: with SMTP id x20mr28922841wrd.284.1556214269212;
        Thu, 25 Apr 2019 10:44:29 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id q24sm19503259wmj.26.2019.04.25.10.44.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Apr 2019 10:44:28 -0700 (PDT)
Date:   Thu, 25 Apr 2019 19:44:25 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thara Gopinath <thara.gopinath@linaro.org>, mingo@redhat.com,
        rui.zhang@intel.com, linux-kernel@vger.kernel.org,
        amit.kachhap@gmail.com, viresh.kumar@linaro.org,
        javi.merino@kernel.org, edubezval@gmail.com,
        daniel.lezcano@linaro.org, vincent.guittot@linaro.org,
        nicolas.dechesne@linaro.org, bjorn.andersson@linaro.org,
        dietmar.eggemann@arm.com, Quentin Perret <quentin.perret@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V2 0/3] Introduce Thermal Pressure
Message-ID: <20190425174425.GA121124@gmail.com>
References: <1555443521-579-1-git-send-email-thara.gopinath@linaro.org>
 <20190417053626.GA47282@gmail.com>
 <5CB75FD9.3070207@linaro.org>
 <20190417182932.GB5140@gmail.com>
 <20190424163424.GG4038@hirez.programming.kicks-ass.net>
 <20190425173333.GA4081@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190425173333.GA4081@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@kernel.org> wrote:

> 
> * Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > On Wed, Apr 17, 2019 at 08:29:32PM +0200, Ingo Molnar wrote:
> > > Assuming PeterZ & Rafael & Quentin doesn't hate the whole thermal load 
> > > tracking approach. 
> > 
> > I seem to remember competing proposals, and have forgotten everything
> > about them; the cover letter also didn't have references to them or
> > mention them in any way.
> > 
> > As to the averaging and period, I personally prefer a PELT signal with
> > the windows lined up, if that really is too short a window, then a PELT
> > like signal with a natural multiple of the PELT period would make sense,
> > such that the windows still line up nicely.
> > 
> > Mixing different averaging methods and non-aligned windows just makes me
> > uncomfortable.
> 
> Yeah, so the problem with PELT is that while it nicely approximates 
> variable-period decay calculations with plain additions, shifts and table 
> lookups (i.e. accelerates pow()), AFAICS the most important decay 
> parameter is fixed: the speed of decay, the dampening factor, which is 
> fixed at 32:
> 
>   Documentation/scheduler/sched-pelt.c
> 
>   #define HALFLIFE 32
> 
> Right?
> 
> Thara's numbers suggest that there's high sensitivity to the speed of 
> decay. By using PELT we'd be using whatever averaging speed there is 
> within PELT.
> 
> Now we could make that parametric of course, but that would both 
> complicate the PELT lookup code (one more dimension) and would negatively 
> affect code generation in a number of places.

I missed the other solution, which is what you suggested: by 
increasing/reducing the PELT window size we can effectively shift decay 
speed and use just a single lookup table.

I.e. instead of the fixed period size of 1024 in accumulate_sum(), use 
decay_load() directly but use a different (longer) window size from 1024 
usecs to calculate 'periods', and make it a multiple of 1024.

This might just work out right: with a half-life of 32 the fastest decay 
speed should be around ~20 msecs (?) - and Thara's numbers so far suggest 
that the sweet spot averaging is significantly longer, at a couple of 
hundred millisecs.

Thanks,

	Ingo
