Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39901C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 12:57:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBC9722CEC
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 12:57:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="x3UMbC/b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395108AbfHWM5g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 08:57:36 -0400
Received: from conssluserg-06.nifty.com ([210.131.2.91]:36980 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732003AbfHWM5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 08:57:36 -0400
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id x7NCvTgE012916;
        Fri, 23 Aug 2019 21:57:29 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com x7NCvTgE012916
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1566565050;
        bh=Ub/aJVgL0Rn8PS4l6h9MNegKzCHvoAER+77sx19M0UY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=x3UMbC/bnXW7WwUIPfky1srdR+lkOf6ENu7W4g32BgP9neaRCruuC32JcjlhjxN50
         JCL5rpdimcwEhwnUW6elfxYfS2nlO2SCXR6k01yAU1wN83eOMb5beFGx/3cx7HTwq6
         n+rpv8LepgsA0BDfGZ0UHdpzQ5RSS7mI5TAxFCuzoboOT0g3d/M0HxQu4SVst8XDYo
         Ud5zaiI4DPM58r7+q3a6n5/a8MgSRX31R8Xn3IsduQFic7/qGwzMYkn6xELF578JDr
         aZxbRSKfBjDcn4O0xsYJjWy3uimPl8qTSQPR0ww3RhRIGaDq66wYW2dit4Q6M7c7ja
         N/LW4Lt0Fgyng==
X-Nifty-SrcIP: [209.85.217.53]
Received: by mail-vs1-f53.google.com with SMTP id m62so6096817vsc.8;
        Fri, 23 Aug 2019 05:57:29 -0700 (PDT)
X-Gm-Message-State: APjAAAWQ5p7JxhDoE/4k1h5UWec/fC8BVOzR/xXu3nUmmLQ/awL81myW
        uGRJIXF0bH7jajq0rS19G2fSU8Nt8WD8+HROKHs=
X-Google-Smtp-Source: APXvYqxkUJRBa4Gu9eJJ/5yY3HcOprjiA+d7CfrbMqgNuwpDTZWvyQ2suLPAbzt4RY2ouQTzsdu17SpfNRdBFLKueKM=
X-Received: by 2002:a67:8a83:: with SMTP id m125mr2655031vsd.181.1566565048153;
 Fri, 23 Aug 2019 05:57:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190506223334.1834-1-nicoleotsuka@gmail.com> <20190506223334.1834-3-nicoleotsuka@gmail.com>
 <CAK7LNARacEorb38mVBw_V-Zvz-znWgBma1AP1-z_5B_xZU4ogg@mail.gmail.com>
In-Reply-To: <CAK7LNARacEorb38mVBw_V-Zvz-znWgBma1AP1-z_5B_xZU4ogg@mail.gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 23 Aug 2019 21:56:52 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQfYBCoChMV=MOwcUyVoqRkrPWs7DaWdzDqjBe18gGiAQ@mail.gmail.com>
Message-ID: <CAK7LNAQfYBCoChMV=MOwcUyVoqRkrPWs7DaWdzDqjBe18gGiAQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] dma-contiguous: Use fallback alloc_pages for
 single pages
To:     Nicolin Chen <nicoleotsuka@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>, vdumpa@nvidia.com,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Tony Lindgren <tony@atomide.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Thierry Reding <treding@nvidia.com>,
        Kees Cook <keescook@chromium.org>, iamjoonsoo.kim@lge.com,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-xtensa@linux-xtensa.org, iommu@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ linux-mmc, Ulf Hansson, Adrian Hunter,


ADMA of SDHCI is not working
since bd2e75633c8012fc8a7431c82fda66237133bf7e


Did anybody see the same problem?


Masahiro




On Fri, Aug 23, 2019 at 9:49 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> On Tue, May 7, 2019 at 7:36 AM Nicolin Chen <nicoleotsuka@gmail.com> wrote:
> >
> > The addresses within a single page are always contiguous, so it's
> > not so necessary to always allocate one single page from CMA area.
> > Since the CMA area has a limited predefined size of space, it may
> > run out of space in heavy use cases, where there might be quite a
> > lot CMA pages being allocated for single pages.
> >
> > However, there is also a concern that a device might care where a
> > page comes from -- it might expect the page from CMA area and act
> > differently if the page doesn't.
> >
> > This patch tries to use the fallback alloc_pages path, instead of
> > one-page size allocations from the global CMA area in case that a
> > device does not have its own CMA area. This'd save resources from
> > the CMA global area for more CMA allocations, and also reduce CMA
> > fragmentations resulted from trivial allocations.
> >
> > Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
>
>
> This commit (bd2e75633c8012fc8a7431c82fda66237133bf7e)
> broke the DMA for my MMC driver in the following way:
>
>
>
>
> [    1.876755] mmc0: ADMA error
> [    1.883385] mmc0: sdhci: ============ SDHCI REGISTER DUMP ===========
> [    1.889834] mmc0: sdhci: Sys addr:  0x00000000 | Version:  0x00000002
> [    1.896284] mmc0: sdhci: Blk size:  0x00007200 | Blk cnt:  0x00000001
> [    1.902733] mmc0: sdhci: Argument:  0x00000000 | Trn mode: 0x00000013
> [    1.909182] mmc0: sdhci: Present:   0x01ff02f6 | Host ctl: 0x00000019
> [    1.915631] mmc0: sdhci: Power:     0x0000000b | Blk gap:  0x00000000
> [    1.922081] mmc0: sdhci: Wake-up:   0x00000000 | Clock:    0x0000fa07
> [    1.928530] mmc0: sdhci: Timeout:   0x0000000b | Int stat: 0x00000001
> [    1.934981] mmc0: sdhci: Int enab:  0x03ff008b | Sig enab: 0x03ff008b
> [    1.941429] mmc0: sdhci: ACmd stat: 0x00000000 | Slot int: 0x00000001
> [    1.947880] mmc0: sdhci: Caps:      0x546ec800 | Caps_1:   0x00000000
> [    1.954329] mmc0: sdhci: Cmd:       0x0000083a | Max curr: 0x00000000
> [    1.960778] mmc0: sdhci: Resp[0]:   0x00000900 | Resp[1]:  0xffffffff
> [    1.967229] mmc0: sdhci: Resp[2]:   0x320f5903 | Resp[3]:  0x3fd05e00
> [    1.973678] mmc0: sdhci: Host ctl2: 0x00000000
> [    1.978125] mmc0: sdhci: ADMA Err:  0x00000001 | ADMA Ptr: 0x000000013965b200
> [    1.985271] mmc0: sdhci: ============================================
> [    1.991758] mmc0: error -5 whilst initialising MMC card
> [    1.991913] 43fb0000.uart: ttyS1 at MMIO 0x43fb0000 (irq = 0,
> base_baud = 768000) is a 16550A
> [    2.011011] hctosys: unable to open rtc device (rtc0)
> [    2.017694] Freeing unused kernel memory: 2368K
> [    2.027131] Run /init as init process
> Starting syslogd: OK
> Starting klogd: OK
> Initializing random number generator... [    2.074399] random: dd:
> uninitialized urandom read (512 bytes read)
> done.
> Starting network: OK
> [    2.109593] mmc0: ADMA error
> [    2.112488] mmc0: sdhci: ============ SDHCI REGISTER DUMP ===========
> [    2.118941] mmc0: sdhci: Sys addr:  0x00000000 | Version:  0x00000002
> [    2.125389] mmc0: sdhci: Blk size:  0x00007200 | Blk cnt:  0x00000001
> [    2.131840] mmc0: sdhci: Argument:  0x00000000 | Trn mode: 0x00000013
> [    2.138289] mmc0: sdhci: Present:   0x01ff02f6 | Host ctl: 0x00000019
> [    2.144738] mmc0: sdhci: Power:     0x0000000b | Blk gap:  0x00000000
> [    2.151188] mmc0: sdhci: Wake-up:   0x00000000 | Clock:    0x00004e47
> [    2.157637] mmc0: sdhci: Timeout:   0x0000000b | Int stat: 0x00000001
> [    2.164087] mmc0: sdhci: Int enab:  0x03ff008b | Sig enab: 0x03ff008b
> [    2.170536] mmc0: sdhci: ACmd stat: 0x00000000 | Slot int: 0x00000001
> [    2.176987] mmc0: sdhci: Caps:      0x546ec800 | Caps_1:   0x00000000
> [    2.183435] mmc0: sdhci: Cmd:       0x0000083a | Max curr: 0x00000000
> [    2.189886] mmc0: sdhci: Resp[0]:   0x00000900 | Resp[1]:  0xffffffff
> [    2.196335] mmc0: sdhci: Resp[2]:   0x320f5903 | Resp[3]:  0x3fd05e00
> [    2.202784] mmc0: sdhci: Host ctl2: 0x00000000
> [    2.207232] mmc0: sdhci: ADMA Err:  0x00000001 | ADMA Ptr: 0x000000013965b200
> [    2.214379] mmc0: sdhci: ============================================
>
> [    2.220881] mmc0: error -5 whilst initialising MMC card
> Welcome to Buildroot
> buildroot login: [    2.332786] mmc0: ADMA error
> [    2.335668] mmc0: sdhci: ============ SDHCI REGISTER DUMP ===========
> [    2.342119] mmc0: sdhci: Sys addr:  0x00000000 | Version:  0x00000002
> [    2.348568] mmc0: sdhci: Blk size:  0x00007200 | Blk cnt:  0x00000001
> [    2.355018] mmc0: sdhci: Argument:  0x00000000 | Trn mode: 0x00000013
> [    2.361468] mmc0: sdhci: Present:   0x01ff02f6 | Host ctl: 0x00000019
> [    2.367917] mmc0: sdhci: Power:     0x0000000b | Blk gap:  0x00000000
> [    2.374367] mmc0: sdhci: Wake-up:   0x00000000 | Clock:    0x0000f447
> [    2.380816] mmc0: sdhci: Timeout:   0x0000000b | Int stat: 0x00000001
> [    2.387267] mmc0: sdhci: Int enab:  0x03ff008b | Sig enab: 0x03ff008b
> [    2.393716] mmc0: sdhci: ACmd stat: 0x00000000 | Slot int: 0x00000001
> [    2.400166] mmc0: sdhci: Caps:      0x546ec800 | Caps_1:   0x00000000
> [    2.406615] mmc0: sdhci: Cmd:       0x0000083a | Max curr: 0x00000000
> [    2.413065] mmc0: sdhci: Resp[0]:   0x00000900 | Resp[1]:  0xffffffff
> [    2.419515] mmc0: sdhci: Resp[2]:   0x320f5903 | Resp[3]:  0x3fd05e00
> [    2.425963] mmc0: sdhci: Host ctl2: 0x00000000
> [    2.430412] mmc0: sdhci: ADMA Err:  0x00000001 | ADMA Ptr: 0x000000013965b200
> [    2.437557] mmc0: sdhci: ============================================
> [    2.444031] mmc0: error -5 whilst initialising MMC card
> [    2.572203] mmc0: ADMA error
> [    2.575089] mmc0: sdhci: ============ SDHCI REGISTER DUMP ===========
> [    2.581540] mmc0: sdhci: Sys addr:  0x00000000 | Version:  0x00000002
> [    2.587989] mmc0: sdhci: Blk size:  0x00007200 | Blk cnt:  0x00000001
> [    2.594439] mmc0: sdhci: Argument:  0x00000000 | Trn mode: 0x00000013
> [    2.600889] mmc0: sdhci: Present:   0x01ef02f6 | Host ctl: 0x00000019
> [    2.607339] mmc0: sdhci: Power:     0x0000000b | Blk gap:  0x00000000
> [    2.613788] mmc0: sdhci: Wake-up:   0x00000000 | Clock:    0x0000e8c7
> [    2.620237] mmc0: sdhci: Timeout:   0x0000000b | Int stat: 0x00000001
> [    2.626686] mmc0: sdhci: Int enab:  0x03ff008b | Sig enab: 0x03ff008b
> [    2.633137] mmc0: sdhci: ACmd stat: 0x00000000 | Slot int: 0x00000001
> [    2.639586] mmc0: sdhci: Caps:      0x546ec800 | Caps_1:   0x00000000
> [    2.646036] mmc0: sdhci: Cmd:       0x0000083a | Max curr: 0x00000000
> [    2.652485] mmc0: sdhci: Resp[0]:   0x00000900 | Resp[1]:  0xffffffff
> [    2.658936] mmc0: sdhci: Resp[2]:   0x320f5903 | Resp[3]:  0x3fd05e00
> [    2.665384] mmc0: sdhci: Host ctl2: 0x00000000
> [    2.669832] mmc0: sdhci: ADMA Err:  0x00000001 | ADMA Ptr: 0x000000013965b200
> [    2.676979] mmc0: sdhci: ============================================
> [    2.683450] mmc0: error -5 whilst initialising MMC card
>
> CTRL-A Z for help | 115200 8N1 | NOR | Minicom 2.7.1 | VT102 | Offline
> | ttyUSB0
>
> Reverting this commit fixed the problem.
>
>
>
> --
> Best Regards
> Masahiro Yamada



-- 
Best Regards
Masahiro Yamada
