Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98C52C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 04:40:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C7182064A
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 04:40:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="dbqK1B0z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727818AbfDWEky (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 00:40:54 -0400
Received: from conssluserg-03.nifty.com ([210.131.2.82]:46168 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727407AbfDWEkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 00:40:53 -0400
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id x3N4eeSm016732;
        Tue, 23 Apr 2019 13:40:40 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com x3N4eeSm016732
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1555994441;
        bh=fGF133ey52ULnyfwTdFpFg48xgYDrnMo723+NK/wfFY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dbqK1B0zE1eb7vTNJ8xdPgrL9Ze9eLthTBAicgXt//47BYCxVuB9X9PC69Gko4Oci
         8/zbYSf0hBJx0MD112/7xQENu5W70SroUC7O7cV3QcerBwxYTxFwV1h+EN7Oid15Dx
         jygfo2KsYItRyFGKbqhxj9+xnEvCcURlZAPvejealjOdEY2QAzC8PydTLI53lQ1Ble
         sHURB0NaG6U02PldvoddNqa4nraL2jq0aj5xL4apkD49gc5g/4nGiPU35214zxepqh
         hiiZgDGAbRP0RPcI+BWv8QYz3fZHZ0YbjNaL0vTrWoAeUeoiVmxGM62/Wz0i8RTTSQ
         /9pX0nckA0O8Q==
X-Nifty-SrcIP: [209.85.222.45]
Received: by mail-ua1-f45.google.com with SMTP id t15so4324159uao.5;
        Mon, 22 Apr 2019 21:40:40 -0700 (PDT)
X-Gm-Message-State: APjAAAXTByuPmnbYqgYTLvgxjUnAMTGheAH4nLAEVh4gflmBD7BQ+j5k
        e7n+91ioxHjQ+sa+r7oqqD+F20T+sEOLSdffDCw=
X-Google-Smtp-Source: APXvYqxmkxHeIqf7hA0rB8bFDVokw5oLji1q/MN6kUm3qfzXbzDpOk9YQgjq4qEHUswhvbfraE3SX0Zxs1SnztOtsQk=
X-Received: by 2002:a9f:2d99:: with SMTP id v25mr11146662uaj.25.1555994439585;
 Mon, 22 Apr 2019 21:40:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190408075427.6052-1-yamada.masahiro@socionext.com>
 <20190408075427.6052-3-yamada.masahiro@socionext.com> <20190408161802.GI49658@atomide.com>
 <6308904e-443a-46ff-9633-2ccb3b03bef9@ti.com> <CAK7LNASYqkhW_W6K5Y9NvmqnZ2aSCbGZNw0ZFrBB3Dd2FRN8yg@mail.gmail.com>
 <39d9cc92-ef2f-993c-3abd-99b134e1c22e@ti.com> <CAK7LNARKW94j=sOdUd24mNMOcunu9TYXjPMeo_y_kHv7xqnE2Q@mail.gmail.com>
 <20190409141759.GA2839@atomide.com>
In-Reply-To: <20190409141759.GA2839@atomide.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 23 Apr 2019 13:40:03 +0900
X-Gmail-Original-Message-ID: <CAK7LNAR-woScv67owJt5KDNPWH53eh6rzoBJY6e9ktFVoim00A@mail.gmail.com>
Message-ID: <CAK7LNAR-woScv67owJt5KDNPWH53eh6rzoBJY6e9ktFVoim00A@mail.gmail.com>
Subject: Re: [PATCH 3/3] ARM: omap2: move platform-specific asm-offset.h to arch/arm/mach-omap2
To:     Tony Lindgren <tony@atomide.com>
Cc:     Keerthy <j-keerthy@ti.com>, arm-soc <arm@kernel.org>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dave Gerlach <d-gerlach@ti.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 9, 2019 at 11:20 PM Tony Lindgren <tony@atomide.com> wrote:
>
> * Masahiro Yamada <yamada.masahiro@socionext.com> [190409 07:06]:
> > On Tue, Apr 9, 2019 at 2:17 PM Keerthy <j-keerthy@ti.com> wrote:
> > >
> > >
> > >
> > > On 09/04/19 10:37 AM, Masahiro Yamada wrote:
> > > > On Tue, Apr 9, 2019 at 2:00 PM Keerthy <j-keerthy@ti.com> wrote:
> > > >>
> > > >>
> > > >>
> > > >> On 08/04/19 9:48 PM, Tony Lindgren wrote:
> > > >>> Hi,
> > > >>>
> > > >>> * Masahiro Yamada <yamada.masahiro@socionext.com> [190408 07:56]:
> > > >>>> <generated/ti-pm-asm-offsets.h> is only generated and included
> > > >>>> by arch/arm/mach-omap2/, so it does not need to reside in the
> > > >>>> globally visible include/generated/.
> > > >>>>
> > > >>>> I moved and renamed it to arch/arm/mach-omap2/pm-asm-offsets.h
> > > >>>> since the prefix 'omap2-' is just redundant in mach-omap2/.
> > > >>>>
> > > >>>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> > > >>>> ---
> > > >>>>
> > > >>>> Can this be applied to ARM-SOC tree in a series?
> > > >>>> (with Ack from the platform sub-maintainer.)
> > > >>>>
> > > >>>> ti-pm-asm-offsets.h does not need to reside in include/generated/,
> > > >>>> but you may ask "Why must it get out of include/generated/?"
> > > >>>>
> > > >>>> My main motivation is to avoid a race condition in the currently
> > > >>>> proposed patch:
> > > >>>>
> > > >>>> https://lore.kernel.org/patchwork/patch/1052763/
> > > >>>>
> > > >>>> This patch tries to embed some build artifacts into the kernel.
> > > >>>>
> > > >>>> If arch/arm/mach-omap2/ and kernel/ are built at the same time,
> > > >>>> it may embed a truncated file.
> > > >>>
> > > >>> Looks like a nice improvment to me, adding Keerthy and Dave to Cc.
> > > >>>
> > > >>> Keerthy and Dave, can you please test this series with am3 and am4
> > > >>> PM code?
> > > >>
> > > >> Tested for Deep Sleep0 on AM33xx Beaglebone-black.
> > > >> Tested for Deep Sleep0 on AM437x-gp-evm.
> > > >>
> > > >> Applied this on top of Tony's for-next with the gpio patch
> > > >> required for RTC+DDR mode on am437x-gp-evm.
> > > >
> > > > Was it applied to TI tree?
> > > >
> > > > If so ...
> > > >
> > > > Arnd, Olof,
> > > > Please just ignore this patch
> > > > since it looks it was already applied to TI tree.
> > >
> > > Masahiro Yamada,
> > >
> > > No i manually applied this on top.
> > >
> > > Regards,
> > > Keerthy
> >
> > Keerthy,
> > Sorry, I misunderstood.
> >
> > You just applied it to your local tree for testing.
> >
> > Then, I still think it is better to
> > apply this series in a correct order.
> >
> > The reason I sent this in a series was
> > to make sure asm-offset headers are correctly
> > cleaned up.
>
> Yes looks good to me:
>
> Acked-by: Tony Lindgren <tony@atomide.com>

Sorry, this turned out to break the out-of-tree build.

Please do not apply this for now.

I will come back to this later when ready.


-- 
Best Regards
Masahiro Yamada
