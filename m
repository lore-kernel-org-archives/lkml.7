Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF3C7C10F03
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 15:43:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FD8320652
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 15:43:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="DFyuMIqd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbfCGPn0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 10:43:26 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:39540 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726185AbfCGPn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 10:43:26 -0500
Received: by mail-ot1-f67.google.com with SMTP id e15so14474451otk.6
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 07:43:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qKGaHUyzIh3xGQPZMEblrTpuIIpfqqUpWtcHIge83ME=;
        b=DFyuMIqdhSCl9cGCV0H+W2YCuFo+UOLYLTrUe90UZYTDabNmpNr4YjE23uVNsxoHQY
         N2y7iomY2lAXugTXr9KA6VZY/BoNzHcdPR9TEWdgmfM2NoocRYqLDP4M2zUZVAboG/YU
         40Se2MRU/Anl4K0j2LCHN5wsrlR2uOYlkQJA9R+TU7Pdvj67f6fOBmGWzPVJBFNLJetO
         z5FHVAXMAG0d6eLa4xq2VcnHPJYadkzF/cvQ36ue5gLdLFkuUjbF7WhW+aCiVyitr79g
         w1rVYgxIkZfAPIvZkeuWv61ydRO120C1U8hF61/27Yn2Okkzx8XPmNeGdOlAiug8+57l
         +/LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qKGaHUyzIh3xGQPZMEblrTpuIIpfqqUpWtcHIge83ME=;
        b=t0md7UlFX+FT8vvUJzmLGnWWDeZFCCaAPWfgkSs00zm1z+d1Zqp1dqZ9zvSRqbcWG+
         HG8vzqpsGDudA6MK+D6cLN7/ghcpKZL9iaKLyTwQKvC4sEOGzbwe/XC4NiNGoMFd2ppa
         n8KeokffBeJb0hOLsKEVkLQv6BRjgWGlhbbgq/LMFsvLj+4l+MQ78rypiGshnV/9LoC1
         jvVitMh3vzHexwVrugubT6VnmBkQOPHNfA76ESqMt5rSX7E/1Uw8Ef7Cpv4OSQX0+9uj
         2U+aX3WYR989r8y1D1AdWoRHaSz0jOgPjOLRAxxsIosjw/NI+2DvvG9qWW1y6w8bWG83
         jzeg==
X-Gm-Message-State: APjAAAUA7EU3J16EF5V4XMroWWKoTj9kp9edR2sGsd5MWIs3Vc9oGOwr
        VqCbeWg4j5BqhQlsBucqQTQJJrmG6fyGE4MpbcXk4Q==
X-Google-Smtp-Source: APXvYqzmuBXqeSb5D/wiRVpXtAObgpIaxn+OpnsGIN20WuMuogaiVmT5/JJOybtcmvccCAdKGZHlmsIUHViT89KsQ70=
X-Received: by 2002:a9d:224a:: with SMTP id o68mr8764180ota.214.1551973404975;
 Thu, 07 Mar 2019 07:43:24 -0800 (PST)
MIME-Version: 1.0
References: <20190215185151.GG7897@sirena.org.uk> <20190226155948.299aa894a5576e61dda3e5aa@linux-foundation.org>
 <CAPcyv4ivjC8fNkfjdFyaYCAjGh7wtvFQnoPpOcR=VNZ=c6d6Rg@mail.gmail.com>
 <20190228151438.fc44921e66f2f5d393c8d7b4@linux-foundation.org>
 <CAPcyv4hDmmK-L=0txw7L9O8YgvAQxZfVFiSoB4LARRnGQ3UC7Q@mail.gmail.com>
 <026b5082-32f2-e813-5396-e4a148c813ea@collabora.com> <20190301124100.62a02e2f622ff6b5f178a7c3@linux-foundation.org>
 <3fafb552-ae75-6f63-453c-0d0e57d818f3@collabora.com> <CAPcyv4hMNiiM11ULjbOnOf=9N=yCABCRsAYLpjXs+98bRoRpCA@mail.gmail.com>
 <36faea07-139c-b97d-3585-f7d6d362abc3@collabora.com> <20190306140529.GG3549@rapoport-lnx>
 <21d138a5-13e4-9e83-d7fe-e0639a8d180a@collabora.com>
In-Reply-To: <21d138a5-13e4-9e83-d7fe-e0639a8d180a@collabora.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 7 Mar 2019 07:43:13 -0800
Message-ID: <CAPcyv4jBjUScKExK09VkL8XKibNcbw11ET4WNUWUWbPXeT9DFQ@mail.gmail.com>
Subject: Re: next/master boot bisection: next-20190215 on beaglebone-black
To:     Guillaume Tucker <guillaume.tucker@collabora.com>
Cc:     Mike Rapoport <rppt@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Mark Brown <broonie@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Matt Hart <matthew.hart@linaro.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>, khilman@baylibre.com,
        enric.balletbo@collabora.com, Nicholas Piggin <npiggin@gmail.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Kees Cook <keescook@chromium.org>,
        Adrian Reber <adrian@lisas.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Linux MM <linux-mm@kvack.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Richard Guy Briggs <rgb@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, info@kernelci.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 7, 2019 at 1:17 AM Guillaume Tucker
<guillaume.tucker@collabora.com> wrote:
>
> On 06/03/2019 14:05, Mike Rapoport wrote:
> > On Wed, Mar 06, 2019 at 10:14:47AM +0000, Guillaume Tucker wrote:
> >> On 01/03/2019 23:23, Dan Williams wrote:
> >>> On Fri, Mar 1, 2019 at 1:05 PM Guillaume Tucker
> >>> <guillaume.tucker@collabora.com> wrote:
> >>>
> >>> Is there an early-printk facility that can be turned on to see how far
> >>> we get in the boot?
> >>
> >> Yes, I've done that now by enabling CONFIG_DEBUG_AM33XXUART1 and
> >> earlyprintk in the command line.  Here's the result, with the
> >> commit cherry picked on top of next-20190304:
> >>
> >>   https://lava.collabora.co.uk/scheduler/job/1526326
> >>
> >> [    1.379522] ti-sysc 4804a000.target-module: sysc_flags 00000222 != 00000022
> >> [    1.396718] Unable to handle kernel paging request at virtual address 77bb4003
> >> [    1.404203] pgd = (ptrval)
> >> [    1.406971] [77bb4003] *pgd=00000000
> >> [    1.410650] Internal error: Oops: 5 [#1] ARM
> >> [...]
> >> [    1.672310] [<c07051a0>] (clk_hw_create_clk.part.21) from [<c06fea34>] (devm_clk_get+0x4c/0x80)
> >> [    1.681232] [<c06fea34>] (devm_clk_get) from [<c064253c>] (sysc_probe+0x28c/0xde4)
> >>
> >> It's always failing at that point in the code.  Also when
> >> enabling "debug" on the kernel command line, the issue goes
> >> away (exact same binaries etc..):
> >>
> >>   https://lava.collabora.co.uk/scheduler/job/1526327
> >>
> >> For the record, here's the branch I've been using:
> >>
> >>   https://gitlab.collabora.com/gtucker/linux/tree/beaglebone-black-next-20190304-debug
> >>
> >> The board otherwise boots fine with next-20190304 (SMP=n), and
> >> also with the patch applied but the shuffle configs set to n.
> >>
> >>> Were there any boot *successes* on ARM with shuffling enabled? I.e.
> >>> clues about what's different about the specific memory setup for
> >>> beagle-bone-black.
> >>
> >> Looking at the KernelCI results from next-20190215, it looks like
> >> only the BeagleBone Black with SMP=n failed to boot:
> >>
> >>   https://kernelci.org/boot/all/job/next/branch/master/kernel/next-20190215/
> >>
> >> Of course that's not all the ARM boards that exist out there, but
> >> it's a fairly large coverage already.
> >>
> >> As the kernel panic always seems to originate in ti-sysc.c,
> >> there's a chance it's only visible on that platform...  I'm doing
> >> a KernelCI run now with my test branch to double check that,
> >> it'll take a few hours so I'll send an update later if I get
> >> anything useful out of it.
>
> Here's the result, there were a couple of failures but some were
> due to infrastructure errors (nyan-big) and I'm not sure about
> what was the problem with the meson boards:
>
>   https://staging.kernelci.org/boot/all/job/gtucker/branch/kernelci-local/kernel/next-20190304-1-g4f0b547b03da/
>
> So there's no clear indicator that the shuffle config is causing
> any issue on any other platform than the BeagleBone Black.
>
> >> In the meantime, I'm happy to try out other things with more
> >> debug configs turned on or any potential fixes someone might
> >> have.
> >
> > ARM is the only arch that sets ARCH_HAS_HOLES_MEMORYMODEL to 'y'. Maybe the
> > failure has something to do with it...
> >
> > Guillaume, can you try this patch:

Mike, I appreciate the help!

>
> Sure, it doesn't seem to be fixing the problem though:
>
>   https://lava.collabora.co.uk/scheduler/job/1527471
>
> I've added the patch to the same branch based on next-20190304.
>
> I guess this needs to be debugged a little further to see what
> the panic really is about.  I'll see if I can spend a bit more
> time on it this week, unless there's any BeagleBone expert
> available to help or if someone has another fix to try out.

Thanks for the help Guillaume!

I went ahead and acquired one of these boards to see if I can can
debug this locally.
