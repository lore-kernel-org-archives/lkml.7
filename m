Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 119ABC76186
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 10:45:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D21A2217F4
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 10:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563360327;
	bh=BV67gKZo3TGKl5Dyp0PiXOnjcwWPe3Mb76WeWSeK1Kk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=o5eiM73nTa9aUhZVWe7HEyjXfPkQigkn5F8B3c4a+mtMhdvtoGpNpI7xJ+bAlBPNW
	 w57vmiQmiXvJ6dXvHEb6nXnBxGIHqMYj64Y0yOUniWjMdWAH5X0GCmQ1Gjk0k57Z1u
	 cgq87y+nrEijo2ZeWko1iIUardHmpKfh/pxIGJeg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbfGQKp1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 06:45:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:60764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725941AbfGQKp0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 06:45:26 -0400
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 69D1A21848;
        Wed, 17 Jul 2019 10:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563360325;
        bh=BV67gKZo3TGKl5Dyp0PiXOnjcwWPe3Mb76WeWSeK1Kk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=sa8VZxLKaZ+t14tOXNmprtzrJLglCy1PsYbfA7DaZjZWLlWOGSE2XXPDiXWLjjJu3
         VPJZky6Y3S2KNNFSXUQ3+8QTmYQK6LvWghSlFzaQox1pb08nQHZccweJymSuv2XWyh
         Djc4YBEe9OaGYriJGMQORgbhm+bhtvGKGXQFhlPo=
Received: by mail-lj1-f176.google.com with SMTP id m8so23103156lji.7;
        Wed, 17 Jul 2019 03:45:25 -0700 (PDT)
X-Gm-Message-State: APjAAAWgiUnLIR+hulklTJp+BRNVwkWztkGMypRbgT2IT8i7bmnT1jpN
        nE/klcTiZCMy8skaXaDNh9afojUgxPaa4XIb2Zs=
X-Google-Smtp-Source: APXvYqwlyzdnXsJBMRHPL0vNfSLDb9PnHTvcxtKUhMNdwslUbRE4WspET8zxNcy1qzE2312nOzDKyeMEQIBX887w5Xk=
X-Received: by 2002:a2e:124b:: with SMTP id t72mr20810837lje.143.1563360323685;
 Wed, 17 Jul 2019 03:45:23 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20190715124504eucas1p1afe0da2c6ac3a8b45d85017a77ba9edf@eucas1p1.samsung.com>
 <20190715124417.4787-1-l.luba@partner.samsung.com> <20190715124417.4787-38-l.luba@partner.samsung.com>
 <CAJKOXPfrGgAczQ-=1aE453RpJ9BN10ZDmFcrEMPkNyF6GcGtNA@mail.gmail.com> <2fe2e840-f4b2-773b-7d92-4ffb8502d4e6@partner.samsung.com>
In-Reply-To: <2fe2e840-f4b2-773b-7d92-4ffb8502d4e6@partner.samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Wed, 17 Jul 2019 12:45:12 +0200
X-Gmail-Original-Message-ID: <CAJKOXPd3gm7no-0TnPmgFg+X3FgdiM6ov5rtzFSM6hKEdEzRCg@mail.gmail.com>
Message-ID: <CAJKOXPd3gm7no-0TnPmgFg+X3FgdiM6ov5rtzFSM6hKEdEzRCg@mail.gmail.com>
Subject: Re: [PATCH v1 37/50] ARM: dts: exynos: change parent and rate of
 bus_fsys in Exynos5422
To:     Lukasz Luba <l.luba@partner.samsung.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>, linux-clk@vger.kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        =?UTF-8?B?QmFydMWCb21pZWogxbtvxYJuaWVya2lld2ljeg==?= 
        <b.zolnierkie@samsung.com>, kgene@kernel.org, mark.rutland@arm.com,
        robh+dt@kernel.org, Chanwoo Choi <cw00.choi@samsung.com>,
        kyungmin.park@samsung.com, Andrzej Hajda <a.hajda@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        s.nawrocki@samsung.com, myungjoo.ham@samsung.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Jul 2019 at 12:39, Lukasz Luba <l.luba@partner.samsung.com> wrote:
> >>
> >>   &bus_fsys {
> >>          devfreq = <&bus_wcore>;
> >> +       assigned-clocks = <&clock CLK_MOUT_ACLK200_FSYS>,
> >> +                         <&clock CLK_DOUT_ACLK200_FSYS>,
> >> +                         <&clock CLK_FOUT_DPLL>;
> >> +       assigned-clock-parents = <&clock CLK_MOUT_SCLK_DPLL>;
> >> +       assigned-clock-rates = <0>, <240000000>,<1200000000>;
> >
> > Here and in all other patches:
> > I am not entirely sure that this should be here. It looks like
> > property of the SoC. Do we expect that buses will be configured to
> > different clock rates between different boards? Since the OPP tables
> > are shared (they are property of the SoC, not board) then I would
> > assume that default frequency is shared as well.
> These clocks they all relay on some bootloader configuration. It depends
> which version of the bootloader you have, then you might get different
> default configuration in the clocks.

I do not agree here. This configuration is not dependent on
bootloader. Although one bootloader might set the clocks to X and
other to Y, but still you provide here valid configuration setting
them, e.g. to Y (or to Z). What bootloader set before does not matter
because you always override it.

> The pattern of changing the parent
> or even rate is known in the DT files (or I am missing something).
> When you grep for it, you get 168 hits (38 for exynos*):
> git grep -n "assigned-clock-rates" ./arch/arm/boot/dts/ | wc -l

Yeah, and if you grep per type you got:
DTSI: 114
DTS: 54
so what do you want to say?

My thinking is that all the boards have buses configured to the same
initial frequency. I am not questioning the use of
assigned-clock-rates at all. Just the place...

BR,
Krzysztof
