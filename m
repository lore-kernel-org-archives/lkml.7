Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB18EC04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 20:35:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AE7F21743
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 20:35:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557347729;
	bh=5aJG1c6vlheNdOqjrdl3fJiyQzUboYjwPsleuLlW+7s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=tBJR+st+3LPQ3JlQh9XT3fYzA0k7g2t86Xvl9FBdnPaLLFBjbtkf27aHXOXpOacs3
	 H20QTyj+Us5ljcgBYeEsN3FoJ4JjECBRWUVTql7z3Pyi3N9xUYkVRpdwHTF+pI88t0
	 Xwfb+5e78Mpjk2nB31U/Rvh9H40Nv6ycBvrC9dUc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728427AbfEHUf2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 16:35:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:39340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726526AbfEHUf2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 16:35:28 -0400
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 679042173E;
        Wed,  8 May 2019 20:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557347727;
        bh=5aJG1c6vlheNdOqjrdl3fJiyQzUboYjwPsleuLlW+7s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NVRkrMZZAMA55Yn9gLTgQc1JSqU32PF1aw5Z7lEUXbLaF1VOaCTYr9NN7g3zR6eek
         Yjjc6KY51ZTFSq1SER63IvktW0DkDb8dxTcniSKWMv4PnFFKTZ1AfopaDuHQbcukfc
         +Spl7TjXmM0Qt8o/7LLIhRQbcixnrtiLiBoKdZ+I=
Received: by mail-qt1-f172.google.com with SMTP id a17so27733qth.3;
        Wed, 08 May 2019 13:35:27 -0700 (PDT)
X-Gm-Message-State: APjAAAUw7oLSJEXNcU+ry8adEGCxx0LqQVuUNwcXjFX1rYqUlYRFcXq0
        yQ2bPkcHTAryVEEhsa2NV3VGxpnwAjM3clcbxg==
X-Google-Smtp-Source: APXvYqzhynLu+eXujmCNyMI9GKUO6g2F1Q4xurKMelb8wXbTG2ZjDze7NlPsYU0W4Z2FLpF7y9/rCsLlKkgEOI2kSY4=
X-Received: by 2002:a0c:f68e:: with SMTP id p14mr182544qvn.77.1557347726619;
 Wed, 08 May 2019 13:35:26 -0700 (PDT)
MIME-Version: 1.0
References: <1557155521-30949-1-git-send-email-l.luba@partner.samsung.com>
 <CGME20190506151215eucas1p2c57147edac5671c5ec9a223efb6b4adc@eucas1p2.samsung.com>
 <1557155521-30949-8-git-send-email-l.luba@partner.samsung.com>
 <20190507170422.GA25179@bogus> <CAJKOXPdacKBrKeCyCaE7VS8-NOR4Oo27XY7rx20P2ORY2vBBSg@mail.gmail.com>
 <ab489925-040c-815c-2aef-50ed0ee6cd6c@partner.samsung.com>
In-Reply-To: <ab489925-040c-815c-2aef-50ed0ee6cd6c@partner.samsung.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 8 May 2019 15:35:15 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJSbi5jNZSRhiE-h74DdbsgM7O+tqP9HOf037pyN7TbFA@mail.gmail.com>
Message-ID: <CAL_JsqJSbi5jNZSRhiE-h74DdbsgM7O+tqP9HOf037pyN7TbFA@mail.gmail.com>
Subject: Re: [PATCH v7 07/13] dt-bindings: memory-controllers: add Exynos5422
 DMC device description
To:     Lukasz Luba <l.luba@partner.samsung.com>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        =?UTF-8?B?QmFydMWCb21pZWogxbtvxYJuaWVya2lld2ljeg==?= 
        <b.zolnierkie@samsung.com>, Kukjin Kim <kgene@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kees Cook <keescook@chromium.org>,
        Tony Lindgren <tony@atomide.com>,
        Joerg Roedel <jroedel@suse.de>,
        Thierry Reding <treding@nvidia.com>,
        Dmitry Osipenko <digetx@gmail.com>, willy.mh.wolff.ml@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 8, 2019 at 4:45 AM Lukasz Luba <l.luba@partner.samsung.com> wrote:
>
>
> On 5/8/19 9:19 AM, Krzysztof Kozlowski wrote:
> > On Tue, 7 May 2019 at 19:04, Rob Herring <robh@kernel.org> wrote:
> >>> +- devfreq-events : phandles of the PPMU events used by the controller.
> >>> +- samsung,syscon-chipid : phandle of the ChipID used by the controller.
> >>> +- samsung,syscon-clk : phandle of the clock register set used by the controller.
> >>
> >> Looks like a hack. Can't you get this from the clocks property? What is
> >> this for?
> >
> > Hi Rob,
> >
> > Lukasz uses these two syscon regmaps to read certain registers. For
> > chipid he reads it to check the size of attached memory (only 2 GB
> > version is supported). This indeed looks like a hack. However the
> > second regmap (clk) is needed to get the timing data from registers
> > from DMC clock driver address space. These are registers with memory
> > timing so their data is not exposed anyway in common clk framework.

Okay, please just explain what your accessing. Consider adding the
offset as a cell in case stuff moves around on another chip.

> >
> > Best regards,
> > Krzysztof
>
> Thank you Krzysztof for a fast response. I have also responded to Rob.
> I wouldn't call accessing chipid registers as a hack, though. The DMC
> registers do not contain information about the memory chip since it is
> in phase of production the board not the chip. Thus, chipid regs (which
> loads from e-fuses) are best place to put information about memory
> type/size.

For efuses, we have a binding (nvmem). Maybe you should use it.

Rob
