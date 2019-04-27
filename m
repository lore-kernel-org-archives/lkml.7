Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D04EBC43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 14:21:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CF582087F
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 14:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556374904;
	bh=GZKtDaEsN/F+JDLwg5ykxqDb1yjXhyKeuO5kAypZArE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=2Artq/GtD4OtBkH9v0KkuWzkdTat41TCT+Oi9hDjvK0iWQGyPH8SXJ3nrftK0kMr/
	 uiGPtIYhvBzH5gcu99ZpSnGR1MdylPVwWRAVop9M4kg3aq26sKW9TavXnLOTrIvwPt
	 HbiNZ5TePwGJ6xilB9OGNp5VLHx8tb/j1TkoQw1c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbfD0OVn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 10:21:43 -0400
Received: from mail-wm1-f42.google.com ([209.85.128.42]:37130 "EHLO
        mail-wm1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbfD0OVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 10:21:42 -0400
Received: by mail-wm1-f42.google.com with SMTP id y5so7575971wma.2
        for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2019 07:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4jQd8SJfZtl1FpOLk0pkyPQuYiQg4sNit4xSpmVk9dw=;
        b=LOUemY7y4bimDXQdSQ4L80wgU0DzeTuQO1iTcFtxXdjO/5/dJfQmoTMa3gktFST630
         X8u9XH+F1FSjKek+Npf/MnEdNvC+7SDKyX1+XyMdpqYfBeG57XgexVf8UJpDJ6CmXdgG
         l6uMTCMna2UqRNtHrJ4WkvIN/GTx4aq6fQe2kRoSRm5pyR3Q1yzjN8e3MVsklcooOHKS
         6zo0mM9z20B1Cb/cE1ferAAJiGUFSiYO8ubXCr/dCBAWWnuWAJGN7SBlI3DtscW1Qio4
         XxkZigHsa/tUq4tqxYBarabJ9IcT/pFH1+Lnqd8GNv2hcsuxZu2cl2I3wJ2TZV4Qm4Ul
         HwSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=4jQd8SJfZtl1FpOLk0pkyPQuYiQg4sNit4xSpmVk9dw=;
        b=Bg1hjGU/5vrA/nvqEkkdT1VIPs7Zi6V9mkPzUdRCGlZPyS2h18c9nmE1CVtY8TsaVl
         X+7TUmhJuhqafXI1feTh57YUVHDCZo30cEhnGKAhQ0f+GnoM6eel5iLXSJFLeR1Ank0+
         tUmlBljv6VR0jDOqLZ3vlCFOAoTWefglIXvbToQMu/+ITuLlUUEpw3h4p1lUAKZCBQFI
         i1c9CY6GEyM8r/PzJkr6VDq6Txwo/zblW0Qcga7dNRb3Ki2SZpLPTj1qAWW1AlyDYmPe
         UeXLgVC7/Cm801TgDeSHnj4ADdXc0s5e9X5XwH/zuniGEWjxr5/UDDCh1qcCc4ovauSW
         1udQ==
X-Gm-Message-State: APjAAAWsUiCvB8k2dzW4mVEm9KNPJGNVel0magHy563gPp+5ng3G0z/m
        ZEGOyNUSH6Sm+r8mrKuFRp4=
X-Google-Smtp-Source: APXvYqyFvyCmbnUkUJkMs/B3BuqKK0luCWCmsPgZz2gR5o2A/drMJWv7JYE2pj4k3r1BQC5WNjAwIA==
X-Received: by 2002:a1c:44d7:: with SMTP id r206mr11225751wma.129.1556374900562;
        Sat, 27 Apr 2019 07:21:40 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id 13sm30086940wmf.23.2019.04.27.07.21.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 27 Apr 2019 07:21:39 -0700 (PDT)
Date:   Sat, 27 Apr 2019 16:21:37 +0200
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
Message-ID: <20190427142137.GA72051@gmail.com>
References: <cover.1556025155.git.vpillai@digitalocean.com>
 <CAERHkrtOCbLQ-tFq9ujjnyaudtd_e0UaSA2GQG64JqdS6cuTKg@mail.gmail.com>
 <20190424140013.GA14594@sinkpad>
 <CAERHkrtVjU4SaHjPGNb140qBiU+wVELGaH6j9Z=cctToZ0qn9g@mail.gmail.com>
 <20190425095508.GA8387@gmail.com>
 <CAERHkrs0=xcx9UUZbZPYq4QbznUqHAuVbTnafSVpZFKwAEFyMA@mail.gmail.com>
 <20190427091716.GC99668@gmail.com>
 <CAERHkruEAVBsh6FphMKqgR2+HjsVVegxjnpOFRNfbrfZDNpc9w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAERHkruEAVBsh6FphMKqgR2+HjsVVegxjnpOFRNfbrfZDNpc9w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Aubrey Li <aubrey.intel@gmail.com> wrote:

> On Sat, Apr 27, 2019 at 5:17 PM Ingo Molnar <mingo@kernel.org> wrote:
> >
> >
> > * Aubrey Li <aubrey.intel@gmail.com> wrote:
> >
> > > I have the same environment setup above, for nosmt cases, I used
> > > /sys interface Thomas mentioned, below is the result:
> > >
> > > NA/AVX  baseline(std%)  coresched(std%) +/-     nosmt(std%) +/-
> > > 1/1      1.987( 1.97%)   2.043( 1.76%) -2.84% 1.985( 1.70%)  0.12%
> > > NA/AVX  baseline(std%)  coresched(std%) +/-     nosmt(std%) +/-
> > > 2/2      2.074( 1.16%)   2.057( 2.09%)  0.81% 2.072( 0.77%)  0.10%
> > > NA/AVX  baseline(std%)  coresched(std%) +/-     nosmt(std%) +/-
> > > 4/4      2.140( 0.00%)   2.138( 0.49%)  0.09% 2.137( 0.89%)  0.12%
> > > NA/AVX  baseline(std%)  coresched(std%) +/-     nosmt(std%) +/-
> > > 8/8      2.140( 0.00%)   2.144( 0.53%) -0.17% 2.140( 0.00%)  0.00%
> > > NA/AVX  baseline(std%)  coresched(std%) +/-     nosmt(std%) +/-
> > > 16/16    2.361( 2.99%)   2.369( 2.65%) -0.30% 2.406( 2.53%) -1.87%
> > > NA/AVX  baseline(std%)  coresched(std%) +/-     nosmt(std%) +/-
> > > 32/32    5.032( 8.68%)   3.485( 0.49%) 30.76% 6.002(27.21%) -19.27%
> > > NA/AVX  baseline(std%)  coresched(std%) +/-     nosmt(std%) +/-
> > > 64/64    7.577(34.35%)   3.972(23.18%) 47.57% 18.235(14.14%) -140.68%
> > > NA/AVX  baseline(std%)  coresched(std%) +/-     nosmt(std%) +/-
> > > 128/128 24.639(14.28%)  27.440( 8.24%) -11.37% 34.746( 6.92%) -41.02%
> > > NA/AVX  baseline(std%)  coresched(std%) +/-     nosmt(std%) +/-
> > > 256/256 38.797( 8.59%)  44.067(16.20%) -13.58% 42.536( 7.57%) -9.64%
> >
> > What do these numbers mean? Are these latencies, i.e. lower is better?
> 
> Yeah, like above setup, I run sysbench(Non-AVX task, NA) and gemmbench
> (AVX512 task, AVX) in different level utilizatoin. The machine has 104 CPUs, so
> nosmt has 52 CPUs.  These numbers are 95th percentile latency of sysbench,
> lower is better.

But what we are really interested in are throughput numbers under these 
three kernel variants, right?

Thanks,

	Ingo
