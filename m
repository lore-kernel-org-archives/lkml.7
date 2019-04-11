Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1463C282CE
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 16:42:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71F812083E
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 16:42:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZHLg5oUi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726872AbfDKQmt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 12:42:49 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:46550 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726106AbfDKQms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 12:42:48 -0400
Received: by mail-yb1-f195.google.com with SMTP id m5so643183ybk.13
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 09:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BSA7wAcOkSLlzctNlW4vWiUg1c9DSNGuTiqEkfsYEjo=;
        b=ZHLg5oUiZ7PADbbxTPmb/WsaETcl7adx55BpjlMoWbMWOUMagh8EL+bnGH7n4dVIWC
         qIOFh+IZ4PXVC+gpv1xWnXCTDaIkAs/aYqw4hdqipEov8gj480QMTrffAfUdi3t/5ZCC
         ltm4BxoinZ37dYVl2S4vxNSMIyAWgMB5MiV6GWuQ+K4AZF94R5PHOm+aLCsbZJ+eYo4P
         5lvp3KA2ER4agUaLhJ2YrtqZybvuymIFVHcFYzcTJnbRDOujXyeU6e/kJjze+bmz/ZSM
         qznxmiBhseZ1op2Dc+iNdJy2sSiaVri/gJnsd431sO+SGY+XMqhvpzwECiFx72JBYAYz
         G/Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BSA7wAcOkSLlzctNlW4vWiUg1c9DSNGuTiqEkfsYEjo=;
        b=i7/YS7htxDZs2J/xpS/a59EY79chlptJ0bwbK0candKDacbHBk4UA78bTgjtUT4T5W
         a/VXgvoVcODu+CteQTa/gcxg1JIKXww+MM7Fpz+xfJrLiVRoydqMj0HG4hCyrdiiIcA+
         SUna+msOU+yt8rnv7CI+4X0pEQXag1uxlrDBokas53K8v9Nms22U9IZ5dT551TqCMJH0
         a2Po6UjB6rvCvVQG1n8BfclZU0WNOpINhFXFNv5StwQRhaZTS5OMssG/XKWc2bas1lrt
         hmweZAQlxkCjzSG61m8sw9QIRf1FRTVNOgH7d2Q3FrjdMe60Ml1D/NvT5kcTpu9Bxo9n
         BY2w==
X-Gm-Message-State: APjAAAVwHCP02xXE5aiphkr8elBuqMPx+njq2RdZeDSxweVKr45pEhD3
        pZJiFWIBp/Qb80OScdeo4Jphy4An8YjBNrQM3sZNEg==
X-Google-Smtp-Source: APXvYqwitDr3lcVKRDmlY1iKyvtiPzjYrs/F9J5p5FgXRkJnmEUEV+NtSF97So8fFJqc1eKEHvCRAmddioLmTd0my8c=
X-Received: by 2002:a25:e54a:: with SMTP id c71mr40728505ybh.336.1555000967421;
 Thu, 11 Apr 2019 09:42:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190215185151.GG7897@sirena.org.uk> <20190226155948.299aa894a5576e61dda3e5aa@linux-foundation.org>
 <CAPcyv4ivjC8fNkfjdFyaYCAjGh7wtvFQnoPpOcR=VNZ=c6d6Rg@mail.gmail.com>
 <20190228151438.fc44921e66f2f5d393c8d7b4@linux-foundation.org>
 <CAPcyv4hDmmK-L=0txw7L9O8YgvAQxZfVFiSoB4LARRnGQ3UC7Q@mail.gmail.com>
 <026b5082-32f2-e813-5396-e4a148c813ea@collabora.com> <20190301124100.62a02e2f622ff6b5f178a7c3@linux-foundation.org>
 <3fafb552-ae75-6f63-453c-0d0e57d818f3@collabora.com> <CAPcyv4hMNiiM11ULjbOnOf=9N=yCABCRsAYLpjXs+98bRoRpCA@mail.gmail.com>
 <36faea07-139c-b97d-3585-f7d6d362abc3@collabora.com> <20190306140529.GG3549@rapoport-lnx>
 <21d138a5-13e4-9e83-d7fe-e0639a8d180a@collabora.com> <CAPcyv4jBjUScKExK09VkL8XKibNcbw11ET4WNUWUWbPXeT9DFQ@mail.gmail.com>
 <CAGXu5jLAPKBE-EdfXkg2AK5P=qZktW6ow4kN5Yzc0WU2rtG8LQ@mail.gmail.com>
In-Reply-To: <CAGXu5jLAPKBE-EdfXkg2AK5P=qZktW6ow4kN5Yzc0WU2rtG8LQ@mail.gmail.com>
From:   Guenter Roeck <groeck@google.com>
Date:   Thu, 11 Apr 2019 09:42:35 -0700
Message-ID: <CABXOdTdVvFn=Nbd_Anhz7zR1H-9QeGByF3HFg4ZFt58R8=H6zA@mail.gmail.com>
Subject: Re: next/master boot bisection: next-20190215 on beaglebone-black
To:     kernelci@groups.io, Kees Cook <keescook@chromium.org>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Guillaume Tucker <guillaume.tucker@collabora.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Mark Brown <broonie@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Matt Hart <matthew.hart@linaro.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Kevin Hilman <khilman@baylibre.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
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

On Thu, Apr 11, 2019 at 9:19 AM Kees Cook <keescook@chromium.org> wrote:
>
> On Thu, Mar 7, 2019 at 7:43 AM Dan Williams <dan.j.williams@intel.com> wrote:
> >
> > On Thu, Mar 7, 2019 at 1:17 AM Guillaume Tucker
> > <guillaume.tucker@collabora.com> wrote:
> > >
> > > On 06/03/2019 14:05, Mike Rapoport wrote:
> > > > On Wed, Mar 06, 2019 at 10:14:47AM +0000, Guillaume Tucker wrote:
> > > >> On 01/03/2019 23:23, Dan Williams wrote:
> > > >>> On Fri, Mar 1, 2019 at 1:05 PM Guillaume Tucker
> > > >>> <guillaume.tucker@collabora.com> wrote:
> > > >>>
> > > >>> Is there an early-printk facility that can be turned on to see how far
> > > >>> we get in the boot?
> > > >>
> > > >> Yes, I've done that now by enabling CONFIG_DEBUG_AM33XXUART1 and
> > > >> earlyprintk in the command line.  Here's the result, with the
> > > >> commit cherry picked on top of next-20190304:
> > > >>
> > > >>   https://lava.collabora.co.uk/scheduler/job/1526326
> > > >>
> > > >> [    1.379522] ti-sysc 4804a000.target-module: sysc_flags 00000222 != 00000022
> > > >> [    1.396718] Unable to handle kernel paging request at virtual address 77bb4003
> > > >> [    1.404203] pgd = (ptrval)
> > > >> [    1.406971] [77bb4003] *pgd=00000000
> > > >> [    1.410650] Internal error: Oops: 5 [#1] ARM
> > > >> [...]
> > > >> [    1.672310] [<c07051a0>] (clk_hw_create_clk.part.21) from [<c06fea34>] (devm_clk_get+0x4c/0x80)
> > > >> [    1.681232] [<c06fea34>] (devm_clk_get) from [<c064253c>] (sysc_probe+0x28c/0xde4)
> > > >>
> > > >> It's always failing at that point in the code.  Also when
> > > >> enabling "debug" on the kernel command line, the issue goes
> > > >> away (exact same binaries etc..):
> > > >>
> > > >>   https://lava.collabora.co.uk/scheduler/job/1526327
> > > >>
> > > >> For the record, here's the branch I've been using:
> > > >>
> > > >>   https://gitlab.collabora.com/gtucker/linux/tree/beaglebone-black-next-20190304-debug
> > > >>
> > > >> The board otherwise boots fine with next-20190304 (SMP=n), and
> > > >> also with the patch applied but the shuffle configs set to n.
> > > >>
> > > >>> Were there any boot *successes* on ARM with shuffling enabled? I.e.
> > > >>> clues about what's different about the specific memory setup for
> > > >>> beagle-bone-black.
> > > >>
> > > >> Looking at the KernelCI results from next-20190215, it looks like
> > > >> only the BeagleBone Black with SMP=n failed to boot:
> > > >>
> > > >>   https://kernelci.org/boot/all/job/next/branch/master/kernel/next-20190215/
> > > >>
> > > >> Of course that's not all the ARM boards that exist out there, but
> > > >> it's a fairly large coverage already.
> > > >>
> > > >> As the kernel panic always seems to originate in ti-sysc.c,
> > > >> there's a chance it's only visible on that platform...  I'm doing
> > > >> a KernelCI run now with my test branch to double check that,
> > > >> it'll take a few hours so I'll send an update later if I get
> > > >> anything useful out of it.
> > >
> > > Here's the result, there were a couple of failures but some were
> > > due to infrastructure errors (nyan-big) and I'm not sure about
> > > what was the problem with the meson boards:
> > >
> > >   https://staging.kernelci.org/boot/all/job/gtucker/branch/kernelci-local/kernel/next-20190304-1-g4f0b547b03da/
> > >
> > > So there's no clear indicator that the shuffle config is causing
> > > any issue on any other platform than the BeagleBone Black.
> > >
> > > >> In the meantime, I'm happy to try out other things with more
> > > >> debug configs turned on or any potential fixes someone might
> > > >> have.
> > > >
> > > > ARM is the only arch that sets ARCH_HAS_HOLES_MEMORYMODEL to 'y'. Maybe the
> > > > failure has something to do with it...
> > > >
> > > > Guillaume, can you try this patch:
> >
> > Mike, I appreciate the help!
> >
> > >
> > > Sure, it doesn't seem to be fixing the problem though:
> > >
> > >   https://lava.collabora.co.uk/scheduler/job/1527471
> > >
> > > I've added the patch to the same branch based on next-20190304.
> > >
> > > I guess this needs to be debugged a little further to see what
> > > the panic really is about.  I'll see if I can spend a bit more
> > > time on it this week, unless there's any BeagleBone expert
> > > available to help or if someone has another fix to try out.
> >
> > Thanks for the help Guillaume!
> >
> > I went ahead and acquired one of these boards to see if I can can
> > debug this locally.
>
> Hi! Any progress on this? Might it be possible to unblock this series
> for v5.2 by adding a temporary "not on ARM" flag?
>

Can someone send me a pointer to the series in question ? I would like
to run it through my testbed.

Thanks,
Guenter

> Thanks!
>
> --
> Kees Cook
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Groups.io Links: You receive all messages sent to this group.
>
> View/Reply Online (#350): https://groups.io/g/kernelci/message/350
> Mute This Topic: https://groups.io/mt/30172851/955378
> Group Owner: kernelci+owner@groups.io
> Unsubscribe: https://groups.io/g/kernelci/unsub  [groeck@google.com]
> -=-=-=-=-=-=-=-=-=-=-=-
>
