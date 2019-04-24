Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF6FBC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 05:53:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CE15218B0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 05:53:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="EVkCO3GN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729669AbfDXFxP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 01:53:15 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:35808 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729244AbfDXFxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 01:53:15 -0400
Received: by mail-qk1-f195.google.com with SMTP id n81so6256354qke.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 22:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=swwar00FpA8AMNE18ADRhjjaugrMNkFTGN7yRfbhtdM=;
        b=EVkCO3GNVH+G/SXpfTJHuR7/vobA3fiTxX7MO1bfiNuahJlVZmRffUFodYOeJuXFO6
         ABrR51q5RaD/CTT1f4wra8cECp6ErzknmjzG3Qe74e7pcZnUAt0m3hnichWWPE70O0h5
         BHh/GDnRdHLSx5lkOaBAxd5GcpVbn7GNfthaW8hHy0ZvcSeDN4qazjt2QWeQcWjelBBQ
         G5XSXor90o9gwNfGJoW6ZNYTRZdW9gF/noDsgfJ86JDAubwQIBdBWwymvIQ4b6gO4UdV
         T9p7VfDqz27CkyFU29GmBKp6Xvqpvp37zc1uUbgK10nvyS/vqN9FjsH2C1FoVFxkJKVc
         oXYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=swwar00FpA8AMNE18ADRhjjaugrMNkFTGN7yRfbhtdM=;
        b=rwaD0yblxWeGH6OKDQakQvCJE/yl5EdA6P8KMBc0CVcuvi2XB9HicfxeR0cVkOBK27
         p0f+WkQZbLoanre/bZ7SYRyzsDjfpgRkIUIQ6GoNnzTQOK7S+h3ol3liz8rVPTBS2cOD
         4OnSwEtXAZ1kzbR67s1VtNWnJHqNLYzPblCc2qIufjrArGk50RrI4mwRkYV6jUShiIxr
         udxVrWhOzLx8asxc5am4TszTrbKfMXntL8lEJwd6ohKhBjU4P7L+mwTkDoIvy7gavb9L
         4cJXUU9l6tfc9YWcxzUc3kyZVBf/92pWk+uOi8DWr9nP13NyaUG5mcQIOfAeCivMr4Dr
         /R/w==
X-Gm-Message-State: APjAAAUuVNa9XKh90S6mtaWiXgA5XYRiFkDdej+ivoeDp3spyd+E1y0P
        h3490TLosuJgTiK5jw5/jnEQUBo1gk2ZUyJ7DbQVEA==
X-Google-Smtp-Source: APXvYqxGC/o/7hadFe1K4ZjteAayq/0Vp+0h81tBzalh2wrLn7H98AzldQ4Y8c/lf+7BVT6Vof3iIfzfjSVSm6zVuSA=
X-Received: by 2002:a05:620a:12bc:: with SMTP id x28mr22520243qki.329.1556085193920;
 Tue, 23 Apr 2019 22:53:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190422101526.28415-1-drake@endlessm.com> <20190423090849.GH11158@hirez.programming.kicks-ass.net>
In-Reply-To: <20190423090849.GH11158@hirez.programming.kicks-ass.net>
From:   Daniel Drake <drake@endlessm.com>
Date:   Wed, 24 Apr 2019 13:53:02 +0800
Message-ID: <CAD8Lp45C2EsEpxtpdNp6afPvqGOSU1yW4=AB2fi0Rhk3fxZ89Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] x86/tsc: use CPUID.0x16 to calculate missing crystal frequency
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        hpa@zytor.com, x86@kernel.org,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Len Brown <len.brown@intel.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        Linux Upstreaming Team <linux@endlessm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2019 at 5:08 PM Peter Zijlstra <peterz@infradead.org> wrote:
> Well, SKX isn't exactly 'missing'; it would be very good if we can
> confirm the new code is still correct under the below mentioned
> conditions.
>
> commit b511203093489eb1829cb4de86e8214752205ac6
> Author: Len Brown <len.brown@intel.com>
> Date:   Fri Dec 22 00:27:55 2017 -0500
>
>     x86/tsc: Fix erroneous TSC rate on Skylake Xeon
>
>     The INTEL_FAM6_SKYLAKE_X hardcoded crystal_khz value of 25MHZ is
>     problematic:
>
>      - SKX workstations (with same model # as server variants) use a 24 MHz
>        crystal.  This results in a -4.0% time drift rate on SKX workstations.

Checking http://instlatx64.atw.hu/ there are 11 platforms listed as
00050654 (skylake X), doing the calculations manually:
18-Core Intel Xeon Gold 6154, 3000 MHz: 25000000
2x 16-Core Intel Xeon Gold 6130, 2100 MHz: 25000000
2x 18-Core Intel Xeon Gold 6154, 3000 MHz: 25000000
2x 28-Core Intel Xeon Platinum 8180, 2500 MHz: 25000000
2x HexaCore Intel Xeon Bronze 3106: 25000000
2x OctalCore Intel Xeon Silver 4108, 3000 MHz: 25000000
10-Core Xeon W-2155: 23913043
HexaCore Intel Core i7-7800X: 23972602
10-Core Intel Core i9-7900X, 4000 MHz: 23913043
18-Core Intel Core i9-7980XE: 24074074
28-Core Intel Xeon W-3175X: 25000000

So given that the results include 24MHz and 25MHz crystal clocks
calculated on different products then it looks like this variance is
correctly accounted for.

>      - SKX servers subject the crystal to an EMI reduction circuit that reduces its
>        actual frequency by (approximately) -0.25%.  This results in -1 second per
>        10 minute time drift as compared to network time.
>
>     This issue can also trigger a timer and power problem, on configurations
>     that use the LAPIC timer (versus the TSC deadline timer).  Clock ticks
>     scheduled with the LAPIC timer arrive a few usec before the time they are
>     expected (according to the slow TSC).  This causes Linux to poll-idle, when
>     it should be in an idle power saving state.  The idle and clock code do not
>     graciously recover from this error, sometimes resulting in significant
>     polling and measurable power impact.
>
>     Stop using native_calibrate_tsc() for INTEL_FAM6_SKYLAKE_X.
>     native_calibrate_tsc() will return 0, boot will run with tsc_khz = cpu_khz,
>     and the TSC refined calibration will update tsc_khz to correct for the
>     difference.

It sounds like I should add a condition:
    if (boot_cpu_data.x86_model != INTEL_FAM6_SKYLAKE_X)
        setup_force_cpu_cap(X86_FEATURE_TSC_KNOWN_FREQ);
so that refined TSC calibration will run on SKYLAKE_X.

That does raise another question though. Taking other platforms such
as KABYLAKE_MOBILE, the previous code hardcoded a precise 24MHz value,
but my new code calculates 23893805Hz. Is that small discrepancy small
enough to trigger the timer and power problem as described for
SKYLAKE_X above?

If so, maybe the logic should instead be:
    if (CPUID.0x15 provided Crystal Hz, i.e. we didn't have to calculate it)
        setup_force_cpu_cap(X86_FEATURE_TSC_KNOWN_FREQ);
This would enable TSC refinement on all variants of skylake and kabylake.

Daniel
