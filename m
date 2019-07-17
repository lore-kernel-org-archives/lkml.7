Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56236C76192
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 11:11:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BF3A2173B
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 11:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563361899;
	bh=S+zz2te9bgVDNvvPDBj9cd9KNHESF6XIWx165fsWXKs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=QPcAlUmWuwSsgfwbSF9ZsjRgz5cvGFIZToIWYdFQOMNl8QrpORpiEtbPP2e0KJPUV
	 azaCkB60hkYo5N76FN29Lfmq76uEueThQxdgOnmtQH66X5xDHQ6ev86on3XcoV6NcN
	 XqsCSK0xc91ezPV9Kpm9szie3TH5Bzm+Po0lhCm4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730633AbfGQLLi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 07:11:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:40944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725948AbfGQLLh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 07:11:37 -0400
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA8972173B;
        Wed, 17 Jul 2019 11:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563361896;
        bh=S+zz2te9bgVDNvvPDBj9cd9KNHESF6XIWx165fsWXKs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=SPDEn+XMeskc4LwiBwImwxEarlR2o2Jl8Nrijnk7aK2bRxzh9bVoTr7B3m+SUXK6a
         d8XK/tLtoJ0th/XxsfYz9L1EJLw7fQcYRdOVuDzgLz15pgtE1GBJiIkh3CyDCslpQU
         ZxK2ZmPbMbTZ7hFhEqQk3KgRsRjbc2Xu3Z0vWI44=
Received: by mail-lj1-f171.google.com with SMTP id d24so23205877ljg.8;
        Wed, 17 Jul 2019 04:11:35 -0700 (PDT)
X-Gm-Message-State: APjAAAUf8vArrr8NSMWW93aTWA544GHYD1yPYLhvbYC5AUa2CrAtuoYH
        ZEPaCelwTJlqKvx84nf+XZuUehfX4joRC3KHRnk=
X-Google-Smtp-Source: APXvYqy+wB5Py8UKuQnvHerPK6HtAXuBZ1HjpDkxUA2U6kmM++5iJrx97dB39dcvHvv6RLVbDgvFtdBpKcNBAb8qo7g=
X-Received: by 2002:a2e:124b:: with SMTP id t72mr20875095lje.143.1563361894145;
 Wed, 17 Jul 2019 04:11:34 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20190715124504eucas1p1afe0da2c6ac3a8b45d85017a77ba9edf@eucas1p1.samsung.com>
 <20190715124417.4787-1-l.luba@partner.samsung.com> <20190715124417.4787-38-l.luba@partner.samsung.com>
 <CAJKOXPfrGgAczQ-=1aE453RpJ9BN10ZDmFcrEMPkNyF6GcGtNA@mail.gmail.com>
 <2fe2e840-f4b2-773b-7d92-4ffb8502d4e6@partner.samsung.com>
 <CAJKOXPd3gm7no-0TnPmgFg+X3FgdiM6ov5rtzFSM6hKEdEzRCg@mail.gmail.com> <518c26ca-4254-056c-d6d0-ae1b4b63709c@partner.samsung.com>
In-Reply-To: <518c26ca-4254-056c-d6d0-ae1b4b63709c@partner.samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Wed, 17 Jul 2019 13:11:22 +0200
X-Gmail-Original-Message-ID: <CAJKOXPfDX06s7eMctbnPabxho2EaWcTM4xAGKCd_+O6jCCDcRQ@mail.gmail.com>
Message-ID: <CAJKOXPfDX06s7eMctbnPabxho2EaWcTM4xAGKCd_+O6jCCDcRQ@mail.gmail.com>
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

On Wed, 17 Jul 2019 at 13:06, Lukasz Luba <l.luba@partner.samsung.com> wrote:
>
>
>
> On 7/17/19 12:45 PM, Krzysztof Kozlowski wrote:
> > On Wed, 17 Jul 2019 at 12:39, Lukasz Luba <l.luba@partner.samsung.com> wrote:
> >>>>
> >>>>    &bus_fsys {
> >>>>           devfreq = <&bus_wcore>;
> >>>> +       assigned-clocks = <&clock CLK_MOUT_ACLK200_FSYS>,
> >>>> +                         <&clock CLK_DOUT_ACLK200_FSYS>,
> >>>> +                         <&clock CLK_FOUT_DPLL>;
> >>>> +       assigned-clock-parents = <&clock CLK_MOUT_SCLK_DPLL>;
> >>>> +       assigned-clock-rates = <0>, <240000000>,<1200000000>;
> >>>
> >>> Here and in all other patches:
> >>> I am not entirely sure that this should be here. It looks like
> >>> property of the SoC. Do we expect that buses will be configured to
> >>> different clock rates between different boards? Since the OPP tables
> >>> are shared (they are property of the SoC, not board) then I would
> >>> assume that default frequency is shared as well.
> >> These clocks they all relay on some bootloader configuration. It depends
> >> which version of the bootloader you have, then you might get different
> >> default configuration in the clocks.
> >
> > I do not agree here. This configuration is not dependent on
> > bootloader. Although one bootloader might set the clocks to X and
> > other to Y, but still you provide here valid configuration setting
> > them, e.g. to Y (or to Z). What bootloader set before does not matter
> > because you always override it.
> This exactly the patch set is aim to do: overwrite any bootloader
> configuration which could be wrong set after boot.
> I don't know for how long it is left in such
> 'bootloader-default-clock-settings' but it is not accurate
> configuration. The pattern in the DT to change the clock rates is
> there.

Still it is not the answer to my concerns and questions.

> >
> >> The pattern of changing the parent
> >> or even rate is known in the DT files (or I am missing something).
> >> When you grep for it, you get 168 hits (38 for exynos*):
> >> git grep -n "assigned-clock-rates" ./arch/arm/boot/dts/ | wc -l
> >
> > Yeah, and if you grep per type you got:
> > DTSI: 114
> > DTS: 54
> > so what do you want to say?
> Thus, It could be changed in DT.

Of course, why not. But how this relevant to my question?

> > My thinking is that all the boards have buses configured to the same
> > initial frequency. I am not questioning the use of
> > assigned-clock-rates at all. Just the place...
> It is not only 'initial frequency' as you name it. It has three changes:
> - re-parent to proper PLL
> - changing this PLL rate
> - change the OPPs frequency values to integer values derived from PLL
>
> The initial frequencies will be changed by devfreq governor using OPP
> tables and the load after the whole system boots.

I simplified with "initial frequency" but it does not matter. Let me
try to raise my concerns again, different wording:
All this looks like property of the SoC, not the board, because:
1. the OPPs are already properties of the SoC, not the board (XU3 Lite
is kind of exception but in fact it uses different flavor of
Exynos5422 SoC which we do not model here as separate DTSI),
2. I expect all boards to have the same properties.

Best regards,
Krzysztof
