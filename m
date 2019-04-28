Return-Path: <SRS0=wfQU=S6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2A57C43218
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 09:33:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81FAD2075D
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 09:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556443993;
	bh=Vb1JJQ9xvxumQkdu6cvGNnE2WEZBrX1ZNzqx2/9QEpU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=gPo7x7HugLT5+pf/z6fkvj4Hfp9pxYtmSVm13UazoYqhy8Q1W2/zrU9+B6GKUD5Q2
	 S35mN9PFHhfIYWHhBLv/hzAjoEY6bJ4OQpZdoGQUSg02I0fHoXKvLM0dj6fjMvHRn3
	 UGU0SIwhWgL++pAEFt/Df5ef7o2zo9qYEf0Y7Frw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726404AbfD1JdL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Apr 2019 05:33:11 -0400
Received: from mail-wm1-f54.google.com ([209.85.128.54]:54144 "EHLO
        mail-wm1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbfD1JdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Apr 2019 05:33:11 -0400
Received: by mail-wm1-f54.google.com with SMTP id 26so9731938wmj.3
        for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2019 02:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jhpxb0r0e1gp4SSO4x9DgfEoKeCHE8A72qe/Aukkisg=;
        b=iVENs9lDMYE+QsydqIXAYd6UC0gt7/Qt28dzyrHXL/V9psvFfeur1My0HJrJA+Mmn2
         3Cm1roptNReDlBDM/JJArG23PtMSRIm+OT5TJchT2E9dgmoycN5L0lwCLcdCfGk/L3ct
         DME8hNj9+2vWSPOg6Flf5VfgY1RYGQdryoO2Gd4PU/RdlJru1l10m41pNR5K7Rf6+lR1
         2TkSeb233dCD/G1jdcccn0y8SyXVpE7Fd5hD2/pwqfip5qAg7Ab6rRh05iA//QYA+Fqz
         1fg7rPbcu4g0CU4nyAdl/q7gzSydbIV60uko6+3OiFRzIzO+ZZ3JI2hoXyDHMSJm/8EB
         Z6tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=jhpxb0r0e1gp4SSO4x9DgfEoKeCHE8A72qe/Aukkisg=;
        b=Jb365tmPSrO1m7QhSpPxT5UX0JhCz+m3NBObCUc0vcNLsvTBCcpH41T51rqS6lPAvf
         cSMcfHCGwjz+RHZnKfuyfGdpgxl2GR5AKf6kdIqBxTS3e8zbJtde+7ZsQD5aiOLftNjO
         4JnYJCgP4h3WlR8gqwTeCWu4GtAtL6fxhOx0yEq439PFjYqz0eXBFO/KqiJihpmSwLMG
         /t8A7sUr1sjWGNDEGKif4NISM6AVUIW7QrASZyIgDdLdSEK4vyzBL9XLQkiNleR9ulWV
         9wqGLbZNLXBXAuAo8SWXwujCTxr8EhStyAXNryV9j4B4hh4n8fW4ORAFjBVMk3hDwZz6
         KjZA==
X-Gm-Message-State: APjAAAVnjOOyPOqWtxdc1Wcnx4Bfm/F93OmCBNnG9qSmHdVjdj8iuLLr
        mjZmaNU6hL/ntzbwplb1cu8=
X-Google-Smtp-Source: APXvYqx2GW2VWDzFOgtUCOP62qnL1IxUPUnvz51Xaf8IjHkhtF8qRZpxub+0eIitidRQGsekiUpqfw==
X-Received: by 2002:a7b:c00e:: with SMTP id c14mr13480208wmb.110.1556443988974;
        Sun, 28 Apr 2019 02:33:08 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id e3sm14053600wro.35.2019.04.28.02.33.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 28 Apr 2019 02:33:07 -0700 (PDT)
Date:   Sun, 28 Apr 2019 11:33:04 +0200
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
Message-ID: <20190428093304.GA7393@gmail.com>
References: <cover.1556025155.git.vpillai@digitalocean.com>
 <CAERHkrtOCbLQ-tFq9ujjnyaudtd_e0UaSA2GQG64JqdS6cuTKg@mail.gmail.com>
 <20190424140013.GA14594@sinkpad>
 <CAERHkrtVjU4SaHjPGNb140qBiU+wVELGaH6j9Z=cctToZ0qn9g@mail.gmail.com>
 <20190425095508.GA8387@gmail.com>
 <CAERHkrs0=xcx9UUZbZPYq4QbznUqHAuVbTnafSVpZFKwAEFyMA@mail.gmail.com>
 <20190427091716.GC99668@gmail.com>
 <CAERHkruEAVBsh6FphMKqgR2+HjsVVegxjnpOFRNfbrfZDNpc9w@mail.gmail.com>
 <20190427142137.GA72051@gmail.com>
 <CAERHkrtaU=Y-Lxypu_7uBbe-mJtG-3friz=ZLhV53X4FXHcEyA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAERHkrtaU=Y-Lxypu_7uBbe-mJtG-3friz=ZLhV53X4FXHcEyA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Aubrey Li <aubrey.intel@gmail.com> wrote:

> > But what we are really interested in are throughput numbers under 
> > these three kernel variants, right?
> 
> These are sysbench events per second number, higher is better.
> 
> NA/AVX  baseline(std%)  coresched(std%) +/-     nosmt(std%) +/-
> 1/1       508.5( 0.2%)    504.7( 1.1%) -0.8%     509.0( 0.2%)  0.1%
> NA/AVX  baseline(std%)  coresched(std%) +/-     nosmt(std%) +/-
> 2/2      1000.2( 1.4%)   1004.1( 1.6%)  0.4%     997.6( 1.2%) -0.3%
> NA/AVX  baseline(std%)  coresched(std%) +/-     nosmt(std%) +/-
> 4/4      1912.1( 1.0%)   1904.2( 1.1%) -0.4%    1914.9( 1.3%)  0.1%
> NA/AVX  baseline(std%)  coresched(std%) +/-     nosmt(std%) +/-
> 8/8      3753.5( 0.3%)   3748.2( 0.3%) -0.1%    3751.3( 0.4%) -0.1%
> NA/AVX  baseline(std%)  coresched(std%) +/-     nosmt(std%) +/-
> 16/16    7139.3( 2.4%)   7137.9( 1.8%) -0.0%    7049.2( 2.4%) -1.3%
> NA/AVX  baseline(std%)  coresched(std%) +/-     nosmt(std%) +/-
> 32/32   10899.0( 4.2%)  10780.3( 4.4%) -1.1%    10339.2( 9.6%) -5.1%
> NA/AVX  baseline(std%)  coresched(std%) +/-     nosmt(std%) +/-
> 64/64   15086.1(11.5%)  14262.0( 8.2%) -5.5%    11168.7(22.2%) -26.0%
> NA/AVX  baseline(std%)  coresched(std%) +/-     nosmt(std%) +/-
> 128/128 15371.9(22.0%)  14675.8(14.4%) -4.5%    10963.9(18.5%) -28.7%
> NA/AVX  baseline(std%)  coresched(std%) +/-     nosmt(std%) +/-
> 256/256 15990.8(22.0%)  12227.9(10.3%) -23.5%   10469.9(19.6%) -34.5%

So because I'm a big fan of presenting data in a readable fashion, here 
are your results, tabulated:

 #
 # Sysbench throughput comparison of 3 different kernels at different 
 # load levels, higher numbers are better:
 #

 .--------------------------------------|----------------------------------------------------------------.
 |  NA/AVX     vanilla-SMT    [stddev%] |coresched-SMT   [stddev%]   +/-  |   no-SMT    [stddev%]   +/-  |
 |--------------------------------------|----------------------------------------------------------------|
 |   1/1             508.5    [  0.2% ] |        504.7   [  1.1% ]   0.8% |    509.0    [  0.2% ]   0.1% |
 |   2/2            1000.2    [  1.4% ] |       1004.1   [  1.6% ]   0.4% |    997.6    [  1.2% ]   0.3% |
 |   4/4            1912.1    [  1.0% ] |       1904.2   [  1.1% ]   0.4% |   1914.9    [  1.3% ]   0.1% |
 |   8/8            3753.5    [  0.3% ] |       3748.2   [  0.3% ]   0.1% |   3751.3    [  0.4% ]   0.1% |
 |  16/16           7139.3    [  2.4% ] |       7137.9   [  1.8% ]   0.0% |   7049.2    [  2.4% ]   1.3% |
 |  32/32          10899.0    [  4.2% ] |      10780.3   [  4.4% ]  -1.1% |  10339.2    [  9.6% ]  -5.1% |
 |  64/64          15086.1    [ 11.5% ] |      14262.0   [  8.2% ]  -5.5% |  11168.7    [ 22.2% ] -26.0% |
 | 128/128         15371.9    [ 22.0% ] |      14675.8   [ 14.4% ]  -4.5% |  10963.9    [ 18.5% ] -28.7% |
 | 256/256         15990.8    [ 22.0% ] |      12227.9   [ 10.3% ] -23.5% |  10469.9    [ 19.6% ] -34.5% |
 '--------------------------------------|----------------------------------------------------------------'

One major thing that sticks out is that if we compare the stddev numbers 
to the +/- comparisons then it's pretty clear that the benchmarks are 
very noisy: in all but the last row stddev is actually higher than the 
measured effect.

So what does 'stddev' mean here, exactly? The stddev of multipe runs, 
i.e. measured run-to-run variance? Or is it some internal metric of the 
benchmark?

Thanks,

	Ingo
