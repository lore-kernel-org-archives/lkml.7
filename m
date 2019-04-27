Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CE9BC43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:54:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36E042087F
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:54:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QlxvsJh7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbfD0Pyj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 11:54:39 -0400
Received: from mail-lj1-f173.google.com ([209.85.208.173]:36894 "EHLO
        mail-lj1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbfD0Pyj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 11:54:39 -0400
Received: by mail-lj1-f173.google.com with SMTP id b12so4412274lji.4
        for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2019 08:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v9jRGvR38YeS8duXc5CkzDu4r22TqaqtlDoyKR/OJfM=;
        b=QlxvsJh79oTuZ15fsP4HEluar8SoZbUYXIbDYYZMncKuxeVn5fBVVlByVmjT5QeUnb
         srXbGbCg+kefTQGJ+S17q+XYWnMAqwcRmqOb466LrXzuD6cAgAug4kTd6ouLLdMw4Yf+
         fcT0SVKIYmcPOa6Ts5jdiwChxooXXzeTCXL4Z3g/Gci7MXFhmMohG+p39BV0FrlV7VxQ
         oenLyqNlDqCu2X0kZ4yVBKE0a3M7+4mu8x82ynp351xjEfW/ugX5paR5y/ciCYCFPJF6
         4Tkv6MLgb0xLrHBDxcMTZ56MH8+0RvIexcg6EbCY0olifa1OawZbut5mduu5mkpXFO1j
         hWJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v9jRGvR38YeS8duXc5CkzDu4r22TqaqtlDoyKR/OJfM=;
        b=Yb7bK5eKS3XipkSi9DC6IrVzEmFbY7miYO3LsjnrxcdmT1iltgf5S+lbmzrQfFEvsP
         +BzUMT+faxuxzfoBXxR+puEbLHLl9Bd7lRTwYgE2PJvuT9vv7hrOBp/8e2yFJeo//l3M
         9muhkGNKXjjcWnKHpHsLwREUuu1bHz5e7ZD3VkLtl01M+2gZ0fIueaqtPhP6ee5cYzFw
         BcuLTWtHAGoDpPwA+cfB6VzpSYXDHIlSfd+D4oCOm57K8C8BSwFb0MPlMKR91TjqBjdG
         Dxy6VnFSprEjwVT4MPnNmbJZSyyVWu7NQ78caRxDA0tEujU0s7SoBJ88aDWFHhtXwfVp
         mD4w==
X-Gm-Message-State: APjAAAUDrUuMRbCsZ6lm85p+X+ksD2PRkhuKTVGOmXVuI0k2HwSoU9bc
        Vcob1b90papz6PzdQaKPqfJ4elu4ZSfeid/4Oyw=
X-Google-Smtp-Source: APXvYqyppcVschcq3ERdOB0briUIt1itxWbcXgE1bwck2mLD3KA7+D3PK1qrWXz/jV+gNSdLBgPl8srpPsnbL3fp6TE=
X-Received: by 2002:a2e:810d:: with SMTP id d13mr27963815ljg.93.1556380476495;
 Sat, 27 Apr 2019 08:54:36 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1556025155.git.vpillai@digitalocean.com>
 <CAERHkrtOCbLQ-tFq9ujjnyaudtd_e0UaSA2GQG64JqdS6cuTKg@mail.gmail.com>
 <20190424140013.GA14594@sinkpad> <CAERHkrtVjU4SaHjPGNb140qBiU+wVELGaH6j9Z=cctToZ0qn9g@mail.gmail.com>
 <20190425095508.GA8387@gmail.com> <CAERHkrs0=xcx9UUZbZPYq4QbznUqHAuVbTnafSVpZFKwAEFyMA@mail.gmail.com>
 <20190427091716.GC99668@gmail.com> <CAERHkruEAVBsh6FphMKqgR2+HjsVVegxjnpOFRNfbrfZDNpc9w@mail.gmail.com>
 <20190427142137.GA72051@gmail.com>
In-Reply-To: <20190427142137.GA72051@gmail.com>
From:   Aubrey Li <aubrey.intel@gmail.com>
Date:   Sat, 27 Apr 2019 23:54:24 +0800
Message-ID: <CAERHkrtaU=Y-Lxypu_7uBbe-mJtG-3friz=ZLhV53X4FXHcEyA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 00/17] Core scheduling v2
To:     Ingo Molnar <mingo@kernel.org>
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
        =?UTF-8?B?RnLDqWTDqXJpYyBXZWlzYmVja2Vy?= <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>, Phil Auld <pauld@redhat.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 27, 2019 at 10:21 PM Ingo Molnar <mingo@kernel.org> wrote:
>
> * Aubrey Li <aubrey.intel@gmail.com> wrote:
>
> > On Sat, Apr 27, 2019 at 5:17 PM Ingo Molnar <mingo@kernel.org> wrote:
> > >
> > >
> > > * Aubrey Li <aubrey.intel@gmail.com> wrote:
> > >
> > > > I have the same environment setup above, for nosmt cases, I used
> > > > /sys interface Thomas mentioned, below is the result:
> > > >
> > > > NA/AVX  baseline(std%)  coresched(std%) +/-     nosmt(std%) +/-
> > > > 1/1      1.987( 1.97%)   2.043( 1.76%) -2.84% 1.985( 1.70%)  0.12%
> > > > NA/AVX  baseline(std%)  coresched(std%) +/-     nosmt(std%) +/-
> > > > 2/2      2.074( 1.16%)   2.057( 2.09%)  0.81% 2.072( 0.77%)  0.10%
> > > > NA/AVX  baseline(std%)  coresched(std%) +/-     nosmt(std%) +/-
> > > > 4/4      2.140( 0.00%)   2.138( 0.49%)  0.09% 2.137( 0.89%)  0.12%
> > > > NA/AVX  baseline(std%)  coresched(std%) +/-     nosmt(std%) +/-
> > > > 8/8      2.140( 0.00%)   2.144( 0.53%) -0.17% 2.140( 0.00%)  0.00%
> > > > NA/AVX  baseline(std%)  coresched(std%) +/-     nosmt(std%) +/-
> > > > 16/16    2.361( 2.99%)   2.369( 2.65%) -0.30% 2.406( 2.53%) -1.87%
> > > > NA/AVX  baseline(std%)  coresched(std%) +/-     nosmt(std%) +/-
> > > > 32/32    5.032( 8.68%)   3.485( 0.49%) 30.76% 6.002(27.21%) -19.27%
> > > > NA/AVX  baseline(std%)  coresched(std%) +/-     nosmt(std%) +/-
> > > > 64/64    7.577(34.35%)   3.972(23.18%) 47.57% 18.235(14.14%) -140.68%
> > > > NA/AVX  baseline(std%)  coresched(std%) +/-     nosmt(std%) +/-
> > > > 128/128 24.639(14.28%)  27.440( 8.24%) -11.37% 34.746( 6.92%) -41.02%
> > > > NA/AVX  baseline(std%)  coresched(std%) +/-     nosmt(std%) +/-
> > > > 256/256 38.797( 8.59%)  44.067(16.20%) -13.58% 42.536( 7.57%) -9.64%
> > >
> > > What do these numbers mean? Are these latencies, i.e. lower is better?
> >
> > Yeah, like above setup, I run sysbench(Non-AVX task, NA) and gemmbench
> > (AVX512 task, AVX) in different level utilizatoin. The machine has 104 CPUs, so
> > nosmt has 52 CPUs.  These numbers are 95th percentile latency of sysbench,
> > lower is better.
>
> But what we are really interested in are throughput numbers under these
> three kernel variants, right?
>

These are sysbench events per second number, higher is better.

NA/AVX  baseline(std%)  coresched(std%) +/-     nosmt(std%) +/-
1/1       508.5( 0.2%)    504.7( 1.1%) -0.8%     509.0( 0.2%)  0.1%
NA/AVX  baseline(std%)  coresched(std%) +/-     nosmt(std%) +/-
2/2      1000.2( 1.4%)   1004.1( 1.6%)  0.4%     997.6( 1.2%) -0.3%
NA/AVX  baseline(std%)  coresched(std%) +/-     nosmt(std%) +/-
4/4      1912.1( 1.0%)   1904.2( 1.1%) -0.4%    1914.9( 1.3%)  0.1%
NA/AVX  baseline(std%)  coresched(std%) +/-     nosmt(std%) +/-
8/8      3753.5( 0.3%)   3748.2( 0.3%) -0.1%    3751.3( 0.4%) -0.1%
NA/AVX  baseline(std%)  coresched(std%) +/-     nosmt(std%) +/-
16/16    7139.3( 2.4%)   7137.9( 1.8%) -0.0%    7049.2( 2.4%) -1.3%
NA/AVX  baseline(std%)  coresched(std%) +/-     nosmt(std%) +/-
32/32   10899.0( 4.2%)  10780.3( 4.4%) -1.1%    10339.2( 9.6%) -5.1%
NA/AVX  baseline(std%)  coresched(std%) +/-     nosmt(std%) +/-
64/64   15086.1(11.5%)  14262.0( 8.2%) -5.5%    11168.7(22.2%) -26.0%
NA/AVX  baseline(std%)  coresched(std%) +/-     nosmt(std%) +/-
128/128 15371.9(22.0%)  14675.8(14.4%) -4.5%    10963.9(18.5%) -28.7%
NA/AVX  baseline(std%)  coresched(std%) +/-     nosmt(std%) +/-
256/256 15990.8(22.0%)  12227.9(10.3%) -23.5%   10469.9(19.6%) -34.5%
