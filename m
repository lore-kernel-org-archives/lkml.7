Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D544EC43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 14:05:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F6EB208C2
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 14:05:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bBCvnOjc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726222AbfD0OFN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 10:05:13 -0400
Received: from mail-lj1-f179.google.com ([209.85.208.179]:34957 "EHLO
        mail-lj1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbfD0OFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 10:05:13 -0400
Received: by mail-lj1-f179.google.com with SMTP id z26so5482124ljj.2
        for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2019 07:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D5JBJtaA8+xU/ta8vSAI+EZKEYF6gg1DC6VLGtaKsrU=;
        b=bBCvnOjceZyWqo2j9QVR9UZnuJz5RXf4yYvhal6JIK5vTbSR7dTeEeA1i/biXWnkhG
         NaPWVrPTWFdtlHI748HIIQfPSp6RaSd3rc1L4WvN/VLDjAYvyuiIeSu3OIAgMhlCMY/t
         hcuyaBDGMz4YIpppAsZuyd2/JJSBE7cuEk1of67rMa5P7HrGL+6h/l/BbaarzEeYZlGB
         43kbVfhjTHOarh6ODxQvLcaRsqRbue3uNwaHaokvGv+1G62NXA50LTIoJzUkZQkS5HVY
         s1jkwkxIIo1Qjb8KDXVSvFA04VrekpMvGyGhqJkq/1Qh+GoROuE7+IOpgdUvPgDyS0w3
         kxHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D5JBJtaA8+xU/ta8vSAI+EZKEYF6gg1DC6VLGtaKsrU=;
        b=QOPET+cIPmY/HmnOyBTR8Xr4Fl6xfPtbc2weXSImI//zNlazR0QTbsIPANN4UM3Brx
         qFguOBeDqQZBEvkuphsvL+IhzoYPLi8sT5GbJP1wgcVeQpZJg+Q2opGMinFdlXF1zft3
         8f1BIfvFydqaulPPMMlSeQ8G1+326WsfbucSqA8LpRmBJNhgSrbviLjSrCMekVi5f0iU
         BHvKcP6UU2x+Qw3on4v2QMqKBP8QHbB/QB+MPqEMNI7gJu312hSS5Qw/ZXdsXZgRjykT
         0GcP4d5LS8i/KH38j1BoFy4ZLCi/cmTHdB+tHK24325zxZQEA+omfsQ5b1af28qUObb6
         D5eA==
X-Gm-Message-State: APjAAAWtINWD2kPkI//NPrvjqkpkwuCt8/TgDFCHmJfrF2QhTDcWyaTq
        moyOpEfRmpmjBmjE1BdUn5w32eJH1YYh2jO1HJ8=
X-Google-Smtp-Source: APXvYqxiFZQ9foKQ6fslbmxkGdkfQQWbcjv1U+5/EuxVGrfQm+4e4iUVUVg9qCIrPcD7T693eP3KhXr9V8y10/VGB0Q=
X-Received: by 2002:a2e:984d:: with SMTP id e13mr5502187ljj.61.1556373910808;
 Sat, 27 Apr 2019 07:05:10 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1556025155.git.vpillai@digitalocean.com>
 <CAERHkrtOCbLQ-tFq9ujjnyaudtd_e0UaSA2GQG64JqdS6cuTKg@mail.gmail.com>
 <20190424140013.GA14594@sinkpad> <CAERHkrtVjU4SaHjPGNb140qBiU+wVELGaH6j9Z=cctToZ0qn9g@mail.gmail.com>
 <20190425095508.GA8387@gmail.com> <CAERHkrs0=xcx9UUZbZPYq4QbznUqHAuVbTnafSVpZFKwAEFyMA@mail.gmail.com>
 <20190427091716.GC99668@gmail.com>
In-Reply-To: <20190427091716.GC99668@gmail.com>
From:   Aubrey Li <aubrey.intel@gmail.com>
Date:   Sat, 27 Apr 2019 22:04:59 +0800
Message-ID: <CAERHkruEAVBsh6FphMKqgR2+HjsVVegxjnpOFRNfbrfZDNpc9w@mail.gmail.com>
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

On Sat, Apr 27, 2019 at 5:17 PM Ingo Molnar <mingo@kernel.org> wrote:
>
>
> * Aubrey Li <aubrey.intel@gmail.com> wrote:
>
> > I have the same environment setup above, for nosmt cases, I used
> > /sys interface Thomas mentioned, below is the result:
> >
> > NA/AVX  baseline(std%)  coresched(std%) +/-     nosmt(std%) +/-
> > 1/1      1.987( 1.97%)   2.043( 1.76%) -2.84% 1.985( 1.70%)  0.12%
> > NA/AVX  baseline(std%)  coresched(std%) +/-     nosmt(std%) +/-
> > 2/2      2.074( 1.16%)   2.057( 2.09%)  0.81% 2.072( 0.77%)  0.10%
> > NA/AVX  baseline(std%)  coresched(std%) +/-     nosmt(std%) +/-
> > 4/4      2.140( 0.00%)   2.138( 0.49%)  0.09% 2.137( 0.89%)  0.12%
> > NA/AVX  baseline(std%)  coresched(std%) +/-     nosmt(std%) +/-
> > 8/8      2.140( 0.00%)   2.144( 0.53%) -0.17% 2.140( 0.00%)  0.00%
> > NA/AVX  baseline(std%)  coresched(std%) +/-     nosmt(std%) +/-
> > 16/16    2.361( 2.99%)   2.369( 2.65%) -0.30% 2.406( 2.53%) -1.87%
> > NA/AVX  baseline(std%)  coresched(std%) +/-     nosmt(std%) +/-
> > 32/32    5.032( 8.68%)   3.485( 0.49%) 30.76% 6.002(27.21%) -19.27%
> > NA/AVX  baseline(std%)  coresched(std%) +/-     nosmt(std%) +/-
> > 64/64    7.577(34.35%)   3.972(23.18%) 47.57% 18.235(14.14%) -140.68%
> > NA/AVX  baseline(std%)  coresched(std%) +/-     nosmt(std%) +/-
> > 128/128 24.639(14.28%)  27.440( 8.24%) -11.37% 34.746( 6.92%) -41.02%
> > NA/AVX  baseline(std%)  coresched(std%) +/-     nosmt(std%) +/-
> > 256/256 38.797( 8.59%)  44.067(16.20%) -13.58% 42.536( 7.57%) -9.64%
>
> What do these numbers mean? Are these latencies, i.e. lower is better?

Yeah, like above setup, I run sysbench(Non-AVX task, NA) and gemmbench
(AVX512 task, AVX) in different level utilizatoin. The machine has 104 CPUs, so
nosmt has 52 CPUs.  These numbers are 95th percentile latency of sysbench,
lower is better.

Thanks,
-Aubrey
