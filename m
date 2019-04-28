Return-Path: <SRS0=wfQU=S6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1F6FC43219
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 12:17:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 706A82075D
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 12:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556453848;
	bh=QQ4jYknkONX+FauOuZHAVnwi/so2X9bQPTqcBLvN7lU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=MN883jVy/q9fWZ1Cx6WxldSnf/Z9lXi7qPRK0esXJENh12gqTu7wSLOT/L06skcMk
	 OZCp70dbGBZkKOAJNntkRpBYfdtUk6HA1v80IJXiY6gS8w82ChWkFeuC5Fl2WxvG+N
	 7CVR4mM3c9FGMAI0htQ6g3/y74vigRhxPE0Ma/c0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbfD1MR1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Apr 2019 08:17:27 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46179 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbfD1MR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Apr 2019 08:17:26 -0400
Received: by mail-wr1-f65.google.com with SMTP id t17so11439935wrw.13
        for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2019 05:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TwBPjPMqNZxcT9Q6smXuEERZNadMZXwilI4z0tYvPy8=;
        b=SHgLCpsQ6qC3nAQ3ByNaR9MGGc3JhiwG/vewMa8CVZMvC+mToY2dwNpoz+24mNPLBV
         nhAG5hwuFDEQptrhi5wzTvO1ACQYZWrEMOmIcRhVFspZ4oS9fbHW4mlsHVF+mxGI05Hc
         +rlacYdXYiCLJGiDnNCtclYo4feXfwwLDDh5w5M4r85d7sIUtor+SJkseTHX9reoTrrA
         QiCWdOEn75vWRqK9pWh01M0xBDLEtCA9uVH8/YYcfLElLTDK/wvzyzRJQhLB4zoxusQ/
         5MwWOU5w2CBdrTujYf3ulrNFVtx2iGlabG2N+O2MKRz7CIyrbhV+rDJhr+YTpkPJ/FXU
         O58A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=TwBPjPMqNZxcT9Q6smXuEERZNadMZXwilI4z0tYvPy8=;
        b=KfcByRAsGySU7Wl5RqaLGYrwQg1uNDQGIgyFdMHQ1529PIJPgFCZ/BxOko0Ts2uiYM
         An8032QX8GJTIQq8LIulMnpIWnsQS5A3KR7UwUnrsbCbTE7KJd1wUQ65yPuWbxziLCu9
         IFxpn4r0NyTu4NZLanYCFjdcVVDZdaUrtNLCDMAl3J9HXve36QRIWcLS3iyXSiQL59sM
         l6AjigCjBWXwwGTqVzQoo/nUaJwBGJRXG7KfmJqSMblXmH2RTd4OpwcCb2K+GQecA4Ls
         eTmrxAq3c+j7ZJqtxl/vcK9TqrN5TZ7qZ8GD2NFz0n49gL5ffSa6golJ4qgXo+A4aY1o
         8www==
X-Gm-Message-State: APjAAAX/nYIDHED5QuOYNFWH7BI+bNonncYhb2PrezffmLbb6rPKqSW6
        5CgJWOfveRrbb3efdPthftY=
X-Google-Smtp-Source: APXvYqzwBcCyMgSz8LtQhEz6rVshzNq7VxStQhKk6bx8Llypm3FbPHyEmECUiu2i8C1Hqcj9+GV3sg==
X-Received: by 2002:adf:f70a:: with SMTP id r10mr20989881wrp.96.1556453844279;
        Sun, 28 Apr 2019 05:17:24 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id h16sm924254wrb.31.2019.04.28.05.17.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 28 Apr 2019 05:17:23 -0700 (PDT)
Date:   Sun, 28 Apr 2019 14:17:21 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Aubrey Li <aubrey.intel@gmail.com>
Cc:     Julien Desfossez <jdesfossez@digitalocean.com>,
        Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Turner <pjt@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Subhra Mazumdar <subhra.mazumdar@oracle.com>,
        =?iso-8859-1?Q?Fr=E9d=E9ric?= Weisbecker <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>, Phil Auld <pauld@redhat.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH v2 00/17] Core scheduling v2
Message-ID: <20190428121721.GA121434@gmail.com>
References: <20190424140013.GA14594@sinkpad>
 <CAERHkrtVjU4SaHjPGNb140qBiU+wVELGaH6j9Z=cctToZ0qn9g@mail.gmail.com>
 <20190425095508.GA8387@gmail.com>
 <CAERHkrs0=xcx9UUZbZPYq4QbznUqHAuVbTnafSVpZFKwAEFyMA@mail.gmail.com>
 <20190427091716.GC99668@gmail.com>
 <CAERHkruEAVBsh6FphMKqgR2+HjsVVegxjnpOFRNfbrfZDNpc9w@mail.gmail.com>
 <20190427142137.GA72051@gmail.com>
 <CAERHkrtaU=Y-Lxypu_7uBbe-mJtG-3friz=ZLhV53X4FXHcEyA@mail.gmail.com>
 <20190428093304.GA7393@gmail.com>
 <CAERHkrvaSSR1wRECF1AcLOhpmCAH0ecvFEL5MOFjK05F0xSuzA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAERHkrvaSSR1wRECF1AcLOhpmCAH0ecvFEL5MOFjK05F0xSuzA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Aubrey Li <aubrey.intel@gmail.com> wrote:

> On Sun, Apr 28, 2019 at 5:33 PM Ingo Molnar <mingo@kernel.org> wrote:
> > So because I'm a big fan of presenting data in a readable fashion, here
> > are your results, tabulated:
> 
> I thought I tried my best to make it readable, but this one looks much better,
> thanks, ;-)
> >
> >  #
> >  # Sysbench throughput comparison of 3 different kernels at different
> >  # load levels, higher numbers are better:
> >  #
> >
> >  .--------------------------------------|----------------------------------------------------------------.
> >  |  NA/AVX     vanilla-SMT    [stddev%] |coresched-SMT   [stddev%]   +/-  |   no-SMT    [stddev%]   +/-  |
> >  |--------------------------------------|----------------------------------------------------------------|
> >  |   1/1             508.5    [  0.2% ] |        504.7   [  1.1% ]   0.8% |    509.0    [  0.2% ]   0.1% |
> >  |   2/2            1000.2    [  1.4% ] |       1004.1   [  1.6% ]   0.4% |    997.6    [  1.2% ]   0.3% |
> >  |   4/4            1912.1    [  1.0% ] |       1904.2   [  1.1% ]   0.4% |   1914.9    [  1.3% ]   0.1% |
> >  |   8/8            3753.5    [  0.3% ] |       3748.2   [  0.3% ]   0.1% |   3751.3    [  0.4% ]   0.1% |
> >  |  16/16           7139.3    [  2.4% ] |       7137.9   [  1.8% ]   0.0% |   7049.2    [  2.4% ]   1.3% |
> >  |  32/32          10899.0    [  4.2% ] |      10780.3   [  4.4% ]  -1.1% |  10339.2    [  9.6% ]  -5.1% |
> >  |  64/64          15086.1    [ 11.5% ] |      14262.0   [  8.2% ]  -5.5% |  11168.7    [ 22.2% ] -26.0% |
> >  | 128/128         15371.9    [ 22.0% ] |      14675.8   [ 14.4% ]  -4.5% |  10963.9    [ 18.5% ] -28.7% |
> >  | 256/256         15990.8    [ 22.0% ] |      12227.9   [ 10.3% ] -23.5% |  10469.9    [ 19.6% ] -34.5% |
> >  '--------------------------------------|----------------------------------------------------------------'
> >
> > One major thing that sticks out is that if we compare the stddev numbers
> > to the +/- comparisons then it's pretty clear that the benchmarks are
> > very noisy: in all but the last row stddev is actually higher than the
> > measured effect.
> >
> > So what does 'stddev' mean here, exactly? The stddev of multipe runs,
> > i.e. measured run-to-run variance? Or is it some internal metric of the
> > benchmark?
> >
> 
> The benchmark periodically reports intermediate statistics in one second,
> the raw log looks like below:
> [ 11s ] thds: 256 eps: 14346.72 lat (ms,95%): 44.17
> [ 12s ] thds: 256 eps: 14328.45 lat (ms,95%): 44.17
> [ 13s ] thds: 256 eps: 13773.06 lat (ms,95%): 43.39
> [ 14s ] thds: 256 eps: 13752.31 lat (ms,95%): 43.39
> [ 15s ] thds: 256 eps: 15362.79 lat (ms,95%): 43.39
> [ 16s ] thds: 256 eps: 26580.65 lat (ms,95%): 35.59
> [ 17s ] thds: 256 eps: 15011.78 lat (ms,95%): 36.89
> [ 18s ] thds: 256 eps: 15025.78 lat (ms,95%): 39.65
> [ 19s ] thds: 256 eps: 15350.87 lat (ms,95%): 39.65
> [ 20s ] thds: 256 eps: 15491.70 lat (ms,95%): 36.89
> 
> I have a python script to parse eps(events per second) and lat(latency)
> out, and compute the average and stddev. (And I can draw a curve locally).
> 
> It's noisy indeed when tasks number is greater than the CPU number.
> It's probably caused by high frequent load balance and context switch.

Ok, so it's basically an internal workload noise metric, it doesn't 
represent the run-to-run noise.

So it's the real stddev of the workload - but we don't know whether the 
measured performance figure is exactly in the middle of the runtime 
probability distribution.

> Do you have any suggestions? Or any other information I can provide?

Yeah, so we don't just want to know the "standard deviation" of the 
measured throughput values, but also the "standard error of the mean".

I suspect it's pretty low, below 1% for all rows?

Thanks,

	Ingo
