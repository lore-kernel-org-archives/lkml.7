Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E6C6C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 04:43:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 157BF2075E
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 04:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556599405;
	bh=TeMBNG0STInOJKrZ7lzD0xdsHkPLuiCXL+1dTT2VabQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=f8219o+2q2eDwY5jarmeThQximNj8VT6B8d6gNMvzTJRLRJl0PMSa7LyR6R1cLS8u
	 eUPDGy6+CTZRXbvCtJyEuG3TQeCCC96RlYLe99MTp0eY6DUPTCY2wPVgUEdhB+K6eI
	 GVLwQefytZ9Ljy5myBVZHYejTvi3XFkaEctarNKw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbfD3Em6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 00:42:58 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35818 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbfD3Em5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 00:42:57 -0400
Received: by mail-wm1-f67.google.com with SMTP id y197so2221607wmd.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2019 21:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=95ElxBUisDLl2oakdawK7d9Lg88o3di7LnAFmSTN78w=;
        b=CZYl3/rfLAl3eQocHA15kNDAUIaDHv2KmhrIyXoJQkmnhRb89gkeK4OIuYkomLWkwq
         0HNalC+vrsnriyz4jhwEISRrXM7tJioKZsd0U0Ug0gajAYPE9d5AGli/7cYweDl9qprE
         T1KgaGM44SX63uCwSlmjTibq34gaPzEJtTyPmmrLQCiI5WvKgKZ+0BX0N05Ul+SiIh6s
         y80miI+Lih1uMZHGexwFpTdPTLGhmUfaCiasG4NtwGolO+XhbOIczip16AHIBg+VEJ+1
         L50ycz6AnEJ5wWnaiLyUB7JyxIeiS0N+V1Ye6YLqL2lrof/VdCQFgy5rM3wVDNxQdPtm
         RC7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=95ElxBUisDLl2oakdawK7d9Lg88o3di7LnAFmSTN78w=;
        b=qD3wpbu2gybrmkxVEyjHwrwHqOXNoqXX6nmTJQwn1gX+QcGrpZNIuIIqbkY++h8TFp
         jgNP9Q1T3nrVT2H50vdsiQoZS+WPzWo2oFi+boCqK0hhAfpsJu3Hic6q1eOh5rSK+GjP
         56C+1C0lsuxr6DFj1dX6LX95T6enPIaNfRiBQko2Z5jkErYzCiLxQMKJDL3+kNSxBQKL
         LQ6UUBUH15ujnmZs7m9o3MnHJ5bDvPr51WDwu1gWj2M/aQ1NJOMYP9q7zah8iWBIiNb7
         iGdX3UFJxYYzhOQsYvSe77uWvUB94eix3QYDnztsR/EDBfS37UKg3EQwSDALjjTbByM4
         /Hmw==
X-Gm-Message-State: APjAAAU6P3Jc51VENUq7Arl0/AtZ13QG9AqGc1ianx8YFEPegAHr3ARZ
        J8EXQszO8fBLptH7B1xfs+Y=
X-Google-Smtp-Source: APXvYqwgwPb/NKpsdM7IVkp0jhMPnhiWVz1mq8A+QvUa3XoGsrDEo4WK1olGWOlfhobt2785YebZyQ==
X-Received: by 2002:a1c:f910:: with SMTP id x16mr1556018wmh.114.1556599375049;
        Mon, 29 Apr 2019 21:42:55 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id c6sm1091548wmb.21.2019.04.29.21.42.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Apr 2019 21:42:53 -0700 (PDT)
Date:   Tue, 30 Apr 2019 06:42:50 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Aubrey Li <aubrey.intel@gmail.com>
Cc:     "Li, Aubrey" <aubrey.li@linux.intel.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
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
Message-ID: <20190430044250.GC73609@gmail.com>
References: <20190427142137.GA72051@gmail.com>
 <CAERHkrtaU=Y-Lxypu_7uBbe-mJtG-3friz=ZLhV53X4FXHcEyA@mail.gmail.com>
 <20190428093304.GA7393@gmail.com>
 <CAERHkrvaSSR1wRECF1AcLOhpmCAH0ecvFEL5MOFjK05F0xSuzA@mail.gmail.com>
 <20190428121721.GA121434@gmail.com>
 <db7c3e51-d013-b3d9-7bce-c247aa2e7144@linux.intel.com>
 <20190429061422.GA20939@gmail.com>
 <24bca399-5370-c4b5-725f-979db06bfc29@linux.intel.com>
 <20190429160058.GA82935@gmail.com>
 <CAERHkrvhggb8nkGOx1GHUftGhh5b0qLvq4HvuHJreNrRC1RXow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAERHkrvhggb8nkGOx1GHUftGhh5b0qLvq4HvuHJreNrRC1RXow@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Aubrey Li <aubrey.intel@gmail.com> wrote:

> On Tue, Apr 30, 2019 at 12:01 AM Ingo Molnar <mingo@kernel.org> wrote:
> > * Li, Aubrey <aubrey.li@linux.intel.com> wrote:
> >
> > > > I.e. showing the approximate CPU thread-load figure column would be
> > > > very useful too, where '50%' shows half-loaded, '100%' fully-loaded,
> > > > '200%' over-saturated, etc. - for each row?
> > >
> > > See below, hope this helps.
> > > .--------------------------------------------------------------------------------------------------------------------------------------.
> > > |NA/AVX vanilla-SMT     [std% / sem%]     cpu% |coresched-SMT   [std% / sem%]     +/-     cpu% |  no-SMT [std% / sem%]   +/-      cpu% |
> > > |--------------------------------------------------------------------------------------------------------------------------------------|
> > > |  1/1        508.5     [ 0.2%/ 0.0%]     2.1% |        504.7   [ 1.1%/ 0.1%]    -0.8%    2.1% |   509.0 [ 0.2%/ 0.0%]   0.1%     4.3% |
> > > |  2/2       1000.2     [ 1.4%/ 0.1%]     4.1% |       1004.1   [ 1.6%/ 0.2%]     0.4%    4.1% |   997.6 [ 1.2%/ 0.1%]  -0.3%     8.1% |
> > > |  4/4       1912.1     [ 1.0%/ 0.1%]     7.9% |       1904.2   [ 1.1%/ 0.1%]    -0.4%    7.9% |  1914.9 [ 1.3%/ 0.1%]   0.1%    15.1% |
> > > |  8/8       3753.5     [ 0.3%/ 0.0%]    14.9% |       3748.2   [ 0.3%/ 0.0%]    -0.1%   14.9% |  3751.3 [ 0.4%/ 0.0%]  -0.1%    30.5% |
> > > | 16/16      7139.3     [ 2.4%/ 0.2%]    30.3% |       7137.9   [ 1.8%/ 0.2%]    -0.0%   30.3% |  7049.2 [ 2.4%/ 0.2%]  -1.3%    60.4% |
> > > | 32/32     10899.0     [ 4.2%/ 0.4%]    60.3% |      10780.3   [ 4.4%/ 0.4%]    -1.1%   55.9% | 10339.2 [ 9.6%/ 0.9%]  -5.1%    97.7% |
> > > | 64/64     15086.1     [11.5%/ 1.2%]    97.7% |      14262.0   [ 8.2%/ 0.8%]    -5.5%   82.0% | 11168.7 [22.2%/ 1.7%] -26.0%   100.0% |
> > > |128/128    15371.9     [22.0%/ 2.2%]   100.0% |      14675.8   [14.4%/ 1.4%]    -4.5%   82.8% | 10963.9 [18.5%/ 1.4%] -28.7%   100.0% |
> > > |256/256    15990.8     [22.0%/ 2.2%]   100.0% |      12227.9   [10.3%/ 1.0%]   -23.5%   73.2% | 10469.9 [19.6%/ 1.7%] -34.5%   100.0% |
> > > '--------------------------------------------------------------------------------------------------------------------------------------'
> >
> > Very nice, thank you!
> >
> > What's interesting is how in the over-saturated case (the last three
> > rows: 128, 256 and 512 total threads) coresched-SMT leaves 20-30% CPU
> > performance on the floor according to the load figures.
> 
> Yeah, I found the next focus.
> 
> > Is this true idle time (which shows up as 'id' during 'top'), or some 
> > load average artifact?
> 
> vmstat periodically reported intermediate CPU utilization in one 
> second, it was running simultaneously when the benchmarks run. The cpu% 
> is computed by the average of (100-idle) series.

Ok - so 'vmstat' uses /proc/stat, which uses cpustat[CPUTIME_IDLE] (or 
its NOHZ work-alike), so this should be true idle time - to the extent 
the HZ process clock's sampling is accurate.

So I guess the answer to my question is "yes". ;-)

BTW., for robustness sake you might want to add iowait to idle time (it's 
the 'wa' field of vmstat) - it shouldn't matter for this particular 
benchmark which doesn't do much IO, but it might for others.

Both CPUTIME_IDLE and CPUTIME_IOWAIT are idle states when a CPU is not 
utilized.

[ Side note: we should really implement precise idle time accounting when 
  CONFIG_IRQ_TIME_ACCOUNTING=y is enabled. We pay all the costs of the 
  timestamps, but AFAICS we don't propagate that into the idle cputime
  metrics. ]

Thanks,

	Ingo
