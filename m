Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BA09C43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 17:33:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA7A5206BF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 17:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556213621;
	bh=QLSbqHxG/0q8XH8MdX1Gda0er9CbZaWjSlGpOKXAU10=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=D052asl0w200ipDtkCqynyTz4fuf8Vnw++SdaUpdcOg2sSDmEmJMsNzGN1zC9sYw0
	 LCieXx4AOaR8w7hCx0ELgN24IpnnO3Fz0NlpX1TVRk8tBi7TIh2KerDFwwr94OUWlm
	 DUnLZyoL2bfMLCT3759F3z7l0gqs6j6C7MvFCy04=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729410AbfDYRdj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 13:33:39 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42355 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728011AbfDYRdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 13:33:39 -0400
Received: by mail-wr1-f65.google.com with SMTP id g3so502594wrx.9
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 10:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dZHYHqpu9SWa5ODyfZe83JOj5HsHBUXs/KvHWmSE064=;
        b=purKpi5qU3/RaZEldCRCVgJK+0A7OJS3xEuMw1RWfPYP3+MPpNgO/b5CMMavL12jIt
         VlWMvArWcR+YlJsQ9UM2ch0BBHDKnHCNcNebphQNRYw7AZg19TtZIU1CCKIULyQomYoh
         YINqsWxmB/VjecNXejyqb4tlYgvdCWxElAbyI0QOzqyTcMVzS2WJuMunPnGkq6iI1D2i
         8Lnu4u03c80W6nnY92KCJyPNmZqwkqGwPpm7o8FmEfg2kwJ3cBr/nBpKmywKNt7s3uG3
         ffT/6vEEGZTIznnxWkgA1HIXGM966gfQh0U+e7Nw2D7OH5EMgGfNRsr6WU4g8v1CgCkg
         uuvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=dZHYHqpu9SWa5ODyfZe83JOj5HsHBUXs/KvHWmSE064=;
        b=a2NLHfsbs9Y2pgJk+rtU39am4/tR+vgNB6HfPMb8aRrW5sSwtX5cUOTWsQP9RU/5Cm
         exe5q8rugIPHcJWBiwtGBI7xCW0V2OS6Nwje2RiB4f8iRChoprSKVm1VLYU3Q1SO9/Cr
         GyfxaD2iEGwEcXEt1v5k53fw/S86qCPY1QSLfezquxqCImn5FgyWmDKglIjQTiVbpmxS
         QV4gi8Em8NES2xf3L19RMttwiDUJP64j2h9+5td6uCpT67Q2b+MtSCBX6Kt9yVVzWbS0
         IAYuwPebAVzMD1qZPP80b9MadB4/VKjaqOs8xdmrzzcLhwFPERWDJngCAgE2VG6895wk
         HhQQ==
X-Gm-Message-State: APjAAAWYQrLMN7keQqloTMBpYejVNGE6RRHS4kr25Egv8JRTUn0Bs5i4
        sqUPQZs3RR3FQCAIX6c8wBI=
X-Google-Smtp-Source: APXvYqx5kLY1P1bebUiseZYz3806gpfmstV+Is8wASNUCbLCdWHxr0M1/Fj0p09XBD0kEHrOraXBLw==
X-Received: by 2002:adf:eb87:: with SMTP id t7mr1206647wrn.39.1556213617459;
        Thu, 25 Apr 2019 10:33:37 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id v13sm41988211wrg.46.2019.04.25.10.33.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Apr 2019 10:33:36 -0700 (PDT)
Date:   Thu, 25 Apr 2019 19:33:33 +0200
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
Message-ID: <20190425173333.GA4081@gmail.com>
References: <1555443521-579-1-git-send-email-thara.gopinath@linaro.org>
 <20190417053626.GA47282@gmail.com>
 <5CB75FD9.3070207@linaro.org>
 <20190417182932.GB5140@gmail.com>
 <20190424163424.GG4038@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190424163424.GG4038@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Peter Zijlstra <peterz@infradead.org> wrote:

> On Wed, Apr 17, 2019 at 08:29:32PM +0200, Ingo Molnar wrote:
> > Assuming PeterZ & Rafael & Quentin doesn't hate the whole thermal load 
> > tracking approach. 
> 
> I seem to remember competing proposals, and have forgotten everything
> about them; the cover letter also didn't have references to them or
> mention them in any way.
> 
> As to the averaging and period, I personally prefer a PELT signal with
> the windows lined up, if that really is too short a window, then a PELT
> like signal with a natural multiple of the PELT period would make sense,
> such that the windows still line up nicely.
> 
> Mixing different averaging methods and non-aligned windows just makes me
> uncomfortable.

Yeah, so the problem with PELT is that while it nicely approximates 
variable-period decay calculations with plain additions, shifts and table 
lookups (i.e. accelerates pow()), AFAICS the most important decay 
parameter is fixed: the speed of decay, the dampening factor, which is 
fixed at 32:

  Documentation/scheduler/sched-pelt.c

  #define HALFLIFE 32

Right?

Thara's numbers suggest that there's high sensitivity to the speed of 
decay. By using PELT we'd be using whatever averaging speed there is 
within PELT.

Now we could make that parametric of course, but that would both 
complicate the PELT lookup code (one more dimension) and would negatively 
affect code generation in a number of places.

Thanks,

	Ingo
