Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4F86C04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 23:47:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FBA520850
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 23:47:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="cwyYoGhJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbfEMXq7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 19:46:59 -0400
Received: from conssluserg-05.nifty.com ([210.131.2.90]:51451 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726541AbfEMXq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 19:46:58 -0400
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id x4DNkkcb030306
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2019 08:46:46 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com x4DNkkcb030306
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1557791207;
        bh=oYA2p5GkaXMidKiU5+9J4Ht2P1D8tEH3dvi5Nfnx2sU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cwyYoGhJPBC3nLsK4lBksd9ZEDDBaAb29KuHsBvvMUenTuF/UNHzOOXnfUjETCdbW
         LcGwAARtIH4+S9i+TXdEfwb17aiUiwpyivst5U2fBWNeGaid4DiS6AXrpEQoZJz++4
         E/IQygzT1RDIxwBRTqhyREbOWb5PDXV+3ON78fkHxLOSrGGFmxwB3LwUdpzgZMrxIL
         vCc2uH1vpgS1JlZbZk6lS0Ee5jw0i/9di7rCjSxjxgnI053haHiDbAxsDiCCWw5DfI
         n8wHSrC9JZ+G/TAkW4c3AYKLlTwLAD+d/sTpooXd1VRBhxpXNtJgr+EFPrtdt9YTgH
         HLMmFrxwZ/gSw==
X-Nifty-SrcIP: [209.85.222.53]
Received: by mail-ua1-f53.google.com with SMTP id d4so5515842uaj.7
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 16:46:46 -0700 (PDT)
X-Gm-Message-State: APjAAAXVvD2wJCGr5FEQcRrUsle8DA7ziNo/gY0HJZ1RVQsrn+cGUK4z
        U/Gm7MrXBdx1DxDgB+JYWiZcHidWm4N+B+UBEkA=
X-Google-Smtp-Source: APXvYqzB0B3HwdKnfmrS2WNCm1ajwAiMMtQi0kRP0vPOtPww+SVi9fCJxmIko9USDDvvQe/YDa0jcC+ZEWCX/ai/VwM=
X-Received: by 2002:a9f:3381:: with SMTP id p1mr7438852uab.40.1557791205718;
 Mon, 13 May 2019 16:46:45 -0700 (PDT)
MIME-Version: 1.0
References: <CAK7LNAR5j1ygbq9TLqUhbJ+tkMdrtD3BgQoUWZErUrnEoWKYMw@mail.gmail.com>
 <b5e2a4d9eb49290d6dc3449c90cdf07797b1aba6.camel@perches.com>
 <CAK7LNAQxsUheo2dHn5E=4ACafcYL9zNubgiVkJkANuZkx2RgpA@mail.gmail.com> <a28b0616aca51aed38fd99fb85632628e6fd8d60.camel@perches.com>
In-Reply-To: <a28b0616aca51aed38fd99fb85632628e6fd8d60.camel@perches.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 14 May 2019 08:46:09 +0900
X-Gmail-Original-Message-ID: <CAK7LNAROgRBuZOVb5+NZd10+z=SaRhvJZ5eQ09pcknbdEJ+Gng@mail.gmail.com>
Message-ID: <CAK7LNAROgRBuZOVb5+NZd10+z=SaRhvJZ5eQ09pcknbdEJ+Gng@mail.gmail.com>
Subject: Re: [Proposal] end of file checks by checkpatch.pl
To:     Joe Perches <joe@perches.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Whitcroft <apw@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joe,

On Tue, May 14, 2019 at 4:23 AM Joe Perches <joe@perches.com> wrote:
>
> On Mon, 2019-05-13 at 19:11 +0900, Masahiro Yamada wrote:
> > Hi Joe,
>
> Hello again.
>
> > On Fri, May 10, 2019 at 2:20 AM Joe Perches <joe@perches.com> wrote:
> > > On Fri, 2019-05-10 at 00:27 +0900, Masahiro Yamada wrote:
> > > > Does it make sense to check the following
> > > > by checkpatch.pl ?
> > > > [1] blank line at end of file
> > > > [2] no new line at end of file
> > >
> > > I'm pretty sure checkpatch does one this already.
> []
> > Looks like the report depends on the file type.
> >
> > scripts/checkpatch.pl  -f  arch/sparc/lib/NG4clear_page.S
> > scripts/checkpatch.pl  -f  tools/power/cpupower/bench/cpufreq-bench_plot.sh
> >
> > reported it, but
> >
> > scripts/checkpatch.pl  -f  drivers/media/dvb-frontends/cxd2880/Kconfig
> > scripts/checkpatch.pl  -f  drivers/parport/Makefile
> >
> > did not.
>
> Yes, this check is after a test for filename extension.
>
> Currently the only file types it reports as missing an EOF
> newline are done on files with the following extensions:
>
>         .h
>         .c
>         .s
>         .S
>         .sh
>         .dtsi
>         .dts
>
> So the existing test is not done on many file types.
> The same file types are used for the proposed patch.
>
> It's possible to have the existing missing newline at EOF
> test and the proposed test for a blank line at EOF to be
> done on all file types.
>
> Is this reasonable or could it cause some other issue
> for any other file types?


I do not know cases where missing newline at EOF
or blank line at EOF is useful.

(Even if there are some, checkpatch.pl is allowed
to report false positives in my opinion.)


So, I think these two checks can be done for
all file types.


Currently, the following is the list of
missing newline at EOF.

checkpatch.pl misses to report most of them.
(the majority of the warning source is *.json)


./arch/arm/boot/dts/vexpress-v2m.dtsi
./arch/sparc/lib/NG4clear_page.S
./Documentation/ABI/testing/sysfs-bus-iio-dfsdm-adc-stm32
./Documentation/ABI/testing/sysfs-class-leds-gt683r
./Documentation/ABI/testing/sysfs-power
./Documentation/devicetree/bindings/ipmi/npcm7xx-kcs-bmc.txt
./Documentation/devicetree/bindings/pinctrl/nuvoton,npcm7xx-pinctrl.txt
./Documentation/devicetree/bindings/regulator/pv88060.txt
./Documentation/devicetree/bindings/sound/cs42l73.txt
./Documentation/docutils.conf
./drivers/gpu/drm/amd/display/modules/power/Makefile
./drivers/media/dvb-frontends/cxd2880/Kconfig
./drivers/net/ethernet/hisilicon/hns3/hns3vf/Makefile
./drivers/parport/Makefile
./drivers/staging/mt7621-dts/TODO
./drivers/staging/rts5208/TODO
./drivers/staging/vt6655/test
./sound/soc/mediatek/common/Makefile
./sound/soc/tegra/Makefile
./sound/usb/bcd2000/Makefile
./tools/firmware/Makefile
./tools/perf/pmu-events/arch/powerpc/power9/cache.json
./tools/perf/pmu-events/arch/powerpc/power9/floating-point.json
./tools/perf/pmu-events/arch/powerpc/power9/frontend.json
./tools/perf/pmu-events/arch/powerpc/power9/marked.json
./tools/perf/pmu-events/arch/powerpc/power9/memory.json
./tools/perf/pmu-events/arch/powerpc/power9/other.json
./tools/perf/pmu-events/arch/powerpc/power9/pipeline.json
./tools/perf/pmu-events/arch/powerpc/power9/pmc.json
./tools/perf/pmu-events/arch/powerpc/power9/translation.json
./tools/perf/pmu-events/arch/x86/bonnell/cache.json
./tools/perf/pmu-events/arch/x86/bonnell/floating-point.json
./tools/perf/pmu-events/arch/x86/bonnell/frontend.json
./tools/perf/pmu-events/arch/x86/bonnell/memory.json
./tools/perf/pmu-events/arch/x86/bonnell/other.json
./tools/perf/pmu-events/arch/x86/bonnell/pipeline.json
./tools/perf/pmu-events/arch/x86/bonnell/virtual-memory.json
./tools/perf/pmu-events/arch/x86/broadwell/cache.json
./tools/perf/pmu-events/arch/x86/broadwellde/cache.json
./tools/perf/pmu-events/arch/x86/broadwellde/floating-point.json
./tools/perf/pmu-events/arch/x86/broadwellde/frontend.json
./tools/perf/pmu-events/arch/x86/broadwellde/memory.json
./tools/perf/pmu-events/arch/x86/broadwellde/other.json
./tools/perf/pmu-events/arch/x86/broadwellde/pipeline.json
./tools/perf/pmu-events/arch/x86/broadwellde/virtual-memory.json
./tools/perf/pmu-events/arch/x86/broadwell/floating-point.json
./tools/perf/pmu-events/arch/x86/broadwell/frontend.json
./tools/perf/pmu-events/arch/x86/broadwell/memory.json
./tools/perf/pmu-events/arch/x86/broadwell/other.json
./tools/perf/pmu-events/arch/x86/broadwell/pipeline.json
./tools/perf/pmu-events/arch/x86/broadwell/uncore.json
./tools/perf/pmu-events/arch/x86/broadwell/virtual-memory.json
./tools/perf/pmu-events/arch/x86/broadwellx/cache.json
./tools/perf/pmu-events/arch/x86/broadwellx/floating-point.json
./tools/perf/pmu-events/arch/x86/broadwellx/frontend.json
./tools/perf/pmu-events/arch/x86/broadwellx/memory.json
./tools/perf/pmu-events/arch/x86/broadwellx/other.json
./tools/perf/pmu-events/arch/x86/broadwellx/pipeline.json
./tools/perf/pmu-events/arch/x86/broadwellx/virtual-memory.json
./tools/perf/pmu-events/arch/x86/cascadelakex/cache.json
./tools/perf/pmu-events/arch/x86/cascadelakex/floating-point.json
./tools/perf/pmu-events/arch/x86/cascadelakex/frontend.json
./tools/perf/pmu-events/arch/x86/cascadelakex/memory.json
./tools/perf/pmu-events/arch/x86/cascadelakex/other.json
./tools/perf/pmu-events/arch/x86/cascadelakex/pipeline.json
./tools/perf/pmu-events/arch/x86/cascadelakex/virtual-memory.json
./tools/perf/pmu-events/arch/x86/goldmont/cache.json
./tools/perf/pmu-events/arch/x86/goldmont/frontend.json
./tools/perf/pmu-events/arch/x86/goldmont/memory.json
./tools/perf/pmu-events/arch/x86/goldmont/other.json
./tools/perf/pmu-events/arch/x86/goldmont/pipeline.json
./tools/perf/pmu-events/arch/x86/goldmontplus/cache.json
./tools/perf/pmu-events/arch/x86/goldmontplus/frontend.json
./tools/perf/pmu-events/arch/x86/goldmontplus/memory.json
./tools/perf/pmu-events/arch/x86/goldmontplus/other.json
./tools/perf/pmu-events/arch/x86/goldmontplus/pipeline.json
./tools/perf/pmu-events/arch/x86/goldmontplus/virtual-memory.json
./tools/perf/pmu-events/arch/x86/goldmont/virtual-memory.json
./tools/perf/pmu-events/arch/x86/haswell/cache.json
./tools/perf/pmu-events/arch/x86/haswell/floating-point.json
./tools/perf/pmu-events/arch/x86/haswell/frontend.json
./tools/perf/pmu-events/arch/x86/haswell/memory.json
./tools/perf/pmu-events/arch/x86/haswell/other.json
./tools/perf/pmu-events/arch/x86/haswell/pipeline.json
./tools/perf/pmu-events/arch/x86/haswell/uncore.json
./tools/perf/pmu-events/arch/x86/haswell/virtual-memory.json
./tools/perf/pmu-events/arch/x86/haswellx/cache.json
./tools/perf/pmu-events/arch/x86/haswellx/floating-point.json
./tools/perf/pmu-events/arch/x86/haswellx/frontend.json
./tools/perf/pmu-events/arch/x86/haswellx/memory.json
./tools/perf/pmu-events/arch/x86/haswellx/other.json
./tools/perf/pmu-events/arch/x86/haswellx/pipeline.json
./tools/perf/pmu-events/arch/x86/haswellx/virtual-memory.json
./tools/perf/pmu-events/arch/x86/ivybridge/cache.json
./tools/perf/pmu-events/arch/x86/ivybridge/floating-point.json
./tools/perf/pmu-events/arch/x86/ivybridge/frontend.json
./tools/perf/pmu-events/arch/x86/ivybridge/memory.json
./tools/perf/pmu-events/arch/x86/ivybridge/other.json
./tools/perf/pmu-events/arch/x86/ivybridge/pipeline.json
./tools/perf/pmu-events/arch/x86/ivybridge/uncore.json
./tools/perf/pmu-events/arch/x86/ivybridge/virtual-memory.json
./tools/perf/pmu-events/arch/x86/ivytown/cache.json
./tools/perf/pmu-events/arch/x86/ivytown/floating-point.json
./tools/perf/pmu-events/arch/x86/ivytown/frontend.json
./tools/perf/pmu-events/arch/x86/ivytown/memory.json
./tools/perf/pmu-events/arch/x86/ivytown/other.json
./tools/perf/pmu-events/arch/x86/ivytown/pipeline.json
./tools/perf/pmu-events/arch/x86/ivytown/virtual-memory.json
./tools/perf/pmu-events/arch/x86/jaketown/cache.json
./tools/perf/pmu-events/arch/x86/jaketown/floating-point.json
./tools/perf/pmu-events/arch/x86/jaketown/frontend.json
./tools/perf/pmu-events/arch/x86/jaketown/memory.json
./tools/perf/pmu-events/arch/x86/jaketown/other.json
./tools/perf/pmu-events/arch/x86/jaketown/pipeline.json
./tools/perf/pmu-events/arch/x86/jaketown/virtual-memory.json
./tools/perf/pmu-events/arch/x86/knightslanding/cache.json
./tools/perf/pmu-events/arch/x86/knightslanding/frontend.json
./tools/perf/pmu-events/arch/x86/knightslanding/memory.json
./tools/perf/pmu-events/arch/x86/knightslanding/pipeline.json
./tools/perf/pmu-events/arch/x86/knightslanding/virtual-memory.json
./tools/perf/pmu-events/arch/x86/nehalemep/cache.json
./tools/perf/pmu-events/arch/x86/nehalemep/floating-point.json
./tools/perf/pmu-events/arch/x86/nehalemep/frontend.json
./tools/perf/pmu-events/arch/x86/nehalemep/memory.json
./tools/perf/pmu-events/arch/x86/nehalemep/other.json
./tools/perf/pmu-events/arch/x86/nehalemep/pipeline.json
./tools/perf/pmu-events/arch/x86/nehalemep/virtual-memory.json
./tools/perf/pmu-events/arch/x86/nehalemex/cache.json
./tools/perf/pmu-events/arch/x86/nehalemex/floating-point.json
./tools/perf/pmu-events/arch/x86/nehalemex/frontend.json
./tools/perf/pmu-events/arch/x86/nehalemex/memory.json
./tools/perf/pmu-events/arch/x86/nehalemex/other.json
./tools/perf/pmu-events/arch/x86/nehalemex/pipeline.json
./tools/perf/pmu-events/arch/x86/nehalemex/virtual-memory.json
./tools/perf/pmu-events/arch/x86/sandybridge/cache.json
./tools/perf/pmu-events/arch/x86/sandybridge/floating-point.json
./tools/perf/pmu-events/arch/x86/sandybridge/frontend.json
./tools/perf/pmu-events/arch/x86/sandybridge/memory.json
./tools/perf/pmu-events/arch/x86/sandybridge/other.json
./tools/perf/pmu-events/arch/x86/sandybridge/pipeline.json
./tools/perf/pmu-events/arch/x86/sandybridge/uncore.json
./tools/perf/pmu-events/arch/x86/sandybridge/virtual-memory.json
./tools/perf/pmu-events/arch/x86/silvermont/cache.json
./tools/perf/pmu-events/arch/x86/silvermont/frontend.json
./tools/perf/pmu-events/arch/x86/silvermont/memory.json
./tools/perf/pmu-events/arch/x86/silvermont/other.json
./tools/perf/pmu-events/arch/x86/silvermont/pipeline.json
./tools/perf/pmu-events/arch/x86/silvermont/virtual-memory.json
./tools/perf/pmu-events/arch/x86/skylake/cache.json
./tools/perf/pmu-events/arch/x86/skylake/floating-point.json
./tools/perf/pmu-events/arch/x86/skylake/frontend.json
./tools/perf/pmu-events/arch/x86/skylake/memory.json
./tools/perf/pmu-events/arch/x86/skylake/other.json
./tools/perf/pmu-events/arch/x86/skylake/pipeline.json
./tools/perf/pmu-events/arch/x86/skylake/uncore.json
./tools/perf/pmu-events/arch/x86/skylake/virtual-memory.json
./tools/perf/pmu-events/arch/x86/skylakex/cache.json
./tools/perf/pmu-events/arch/x86/skylakex/floating-point.json
./tools/perf/pmu-events/arch/x86/skylakex/frontend.json
./tools/perf/pmu-events/arch/x86/skylakex/memory.json
./tools/perf/pmu-events/arch/x86/skylakex/other.json
./tools/perf/pmu-events/arch/x86/skylakex/pipeline.json
./tools/perf/pmu-events/arch/x86/skylakex/virtual-memory.json
./tools/perf/pmu-events/arch/x86/westmereep-dp/cache.json
./tools/perf/pmu-events/arch/x86/westmereep-dp/floating-point.json
./tools/perf/pmu-events/arch/x86/westmereep-dp/frontend.json
./tools/perf/pmu-events/arch/x86/westmereep-dp/memory.json
./tools/perf/pmu-events/arch/x86/westmereep-dp/other.json
./tools/perf/pmu-events/arch/x86/westmereep-dp/pipeline.json
./tools/perf/pmu-events/arch/x86/westmereep-dp/virtual-memory.json
./tools/perf/pmu-events/arch/x86/westmereep-sp/cache.json
./tools/perf/pmu-events/arch/x86/westmereep-sp/floating-point.json
./tools/perf/pmu-events/arch/x86/westmereep-sp/frontend.json
./tools/perf/pmu-events/arch/x86/westmereep-sp/memory.json
./tools/perf/pmu-events/arch/x86/westmereep-sp/other.json
./tools/perf/pmu-events/arch/x86/westmereep-sp/pipeline.json
./tools/perf/pmu-events/arch/x86/westmereep-sp/virtual-memory.json
./tools/perf/pmu-events/arch/x86/westmereex/cache.json
./tools/perf/pmu-events/arch/x86/westmereex/floating-point.json
./tools/perf/pmu-events/arch/x86/westmereex/frontend.json
./tools/perf/pmu-events/arch/x86/westmereex/memory.json
./tools/perf/pmu-events/arch/x86/westmereex/other.json
./tools/perf/pmu-events/arch/x86/westmereex/pipeline.json
./tools/perf/pmu-events/arch/x86/westmereex/virtual-memory.json
./tools/perf/scripts/python/bin/intel-pt-events-report
./tools/power/cpupower/bench/cpufreq-bench_plot.sh
./tools/power/cpupower/bench/cpufreq-bench_script.sh
./tools/testing/selftests/exec/.gitignore
./tools/testing/selftests/powerpc/mm/.gitignore




>  Should _any_ file extension
> be excluded?
>
> I believe not, but perhaps it's best to ask.
>
>


-- 
Best Regards
Masahiro Yamada
