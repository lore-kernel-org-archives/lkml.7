Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A315C606B0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 00:49:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D8D6216C4
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 00:49:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A+6tMfOy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbfGIAtc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 20:49:32 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:45279 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbfGIAtb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 20:49:31 -0400
Received: by mail-oi1-f194.google.com with SMTP id m206so14065383oib.12;
        Mon, 08 Jul 2019 17:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mZfF3qmGUmaIXGQVLjO4ElcPFOkI/q/c+xioJlIBg2U=;
        b=A+6tMfOydkWZAq3FLs4JYZTw3Q+rRUwRJpGF79VNLOKlzkmnFjXBBoVFCPB6WH032H
         heRFES7RMAV1lT9/7vozKekg8HAZa7l54YEJ+ZJvC6W6P2DKHqFGmZ/zYZBf99ICvwaY
         6WK+H/4RwupNppMbKV5C81EiPhx08soNSJCaWtntbLw7fXD9/hCk929ra2K1C7XAoME0
         Z8aWaXfodpDgxVje7iFZrELXqv/9UCQpZt3t5HaDSVfbslLjbJ9j1yT2gI+cn0cjNAZE
         lLyUEpU6GREM2LLCUFPqQAHbDl2HpMKDqnru4XN80ye/ljTCNYMwEb/7SmrGmEPZg9Qf
         4pWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mZfF3qmGUmaIXGQVLjO4ElcPFOkI/q/c+xioJlIBg2U=;
        b=JIuY/o6UFLYoJSwgkKS4TiNXqWjvcO2ssVjDAJVMAbYOpqwZukPTwZZGvLC4rhp4rO
         s8u2xCTPxizyY3u9k34gGZ0ZUWfGjBPIAoDCHjcMOnZKBtInHByZIgm7IjOzah3Ii6YG
         SheKvw0wDTEYpmXzVjrC9/Waxnk/+70vzGYaAXmR0X7k8GCumBPwOxUMRWWuhuBgRRcA
         a9UD8B36dVsBBYC85TOVg572y3BQjS5/DsELWn/wIoLqJ80BAHo/XJwT0hccb3TsKyaX
         3f/AzUnKEhQe6/ebjLWyWlgd6vp2E+TGmkSqFDiS/U/Nty3h6kvRfeMAOVw4WSnMk91Y
         /xzA==
X-Gm-Message-State: APjAAAW89gDjtExZH1LuGpxZELFsCW0tlMF2tgR6i/Fn+x25jmWvDI7N
        3rY8sNSM+lIfiRwRbHunm3mfTnzPgkqdYWOfLtE=
X-Google-Smtp-Source: APXvYqwn/NmbXG3TvpJ/5pRB/ldFPNOG9MC5TDpP7mMGAObq2oBz7QvF8Qh6xGlGhVhQcK1KBKGA38nN+dBvrIRtU7Y=
X-Received: by 2002:aca:f552:: with SMTP id t79mr10221713oih.145.1562633370288;
 Mon, 08 Jul 2019 17:49:30 -0700 (PDT)
MIME-Version: 1.0
References: <CA+E=qVckHLqRngsfK=AcvstrD0ymEfRkYyhS_kBtZ3YWdE3L=g@mail.gmail.com>
 <20190605101317.GA9345@lst.de> <20190605120237.ekmytfxcwbjaqy3x@flea>
 <E1hYsvP-0000PY-Pz@stardust.g4.wien.funkfeuer.at> <20190607062802.m5wslx3imiqooq5a@flea>
 <CGME20190607094103epcas1p4babbb11ec050974a62f2af79bc64d752@epcas1p4.samsung.com>
 <20190607094030.GA12373@lst.de> <66707fcc-b48e-02d3-5ed7-6b7e77d53266@samsung.com>
 <20190612152022.c3cfhp4cauhzhfyr@flea> <bb2c2c00-b46e-1984-088f-861ac8952331@samsung.com>
 <20190701095842.fvganvycce2cy7jn@flea>
In-Reply-To: <20190701095842.fvganvycce2cy7jn@flea>
From:   Vasily Khoruzhick <anarsoul@gmail.com>
Date:   Mon, 8 Jul 2019 17:49:21 -0700
Message-ID: <CA+E=qVdsYV2Bxk245=Myq=otd7-7WHzUnSJN8_1dciAzvSOG8g@mail.gmail.com>
Subject: Re: [PATCH v2 7/7] arm64: dts: allwinner: a64: enable ANX6345 bridge
 on Teres-I
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Andrzej Hajda <a.hajda@samsung.com>, Torsten Duwe <duwe@lst.de>,
        Harald Geyer <harald@ccbib.org>, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Sean Paul <seanpaul@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree <devicetree@vger.kernel.org>,
        arm-linux <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 1, 2019 at 2:58 AM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> Hi!
>
> On Fri, Jun 28, 2019 at 12:39:32PM +0200, Andrzej Hajda wrote:
> > On 12.06.2019 17:20, Maxime Ripard wrote:
> > >> I am not sure if I understand whole discussion here, but I also do not
> > >> understand whole edp-connector thing.
> > > The context is this one:
> > > https://patchwork.freedesktop.org/patch/257352/?series=51182&rev=1
> > > https://patchwork.freedesktop.org/patch/283012/?series=56163&rev=1
> > > https://patchwork.freedesktop.org/patch/286468/?series=56776&rev=2
> > >
> > > TL;DR: This bridge is being used on ARM laptops that can come with
> > > different eDP panels. Some of these panels require a regulator to be
> > > enabled for the panel to work, and this is obviously something that
> > > should be in the DT.
> > >
> > > However, we can't really describe the panel itself, since the vendor
> > > uses several of them and just relies on the eDP bus to do its job at
> > > retrieving the EDIDs. A generic panel isn't really working either
> > > since that would mean having a generic behaviour for all the panels
> > > connected to that bus, which isn't there either.
> > >
> > > The connector allows to expose this nicely.
> >
> > As VESA presentation says[1] eDP is based on DP but is much more
> > flexible, it is up to integrator (!!!) how the connection, power
> > up/down, initialization sequence should be performed. Trying to cover
> > every such case in edp-connector seems to me similar to panel-simple
> > attempt failure. Moreover there is no such thing as physical standard
> > eDP connector. Till now I though DT connector should describe physical
> > connector on the device, now I am lost, are there some DT bindings
> > guidelines about definition of a connector?
>
> This might be semantics but I guess we're in some kind of grey area?
>
> Like, for eDP, if it's soldered I guess we could say that there's no
> connector. But what happens if for some other board, that signal is
> routed through a ribbon?
>
> You could argue that there's no physical connector in both cases, or
> that there's one in both, or one for the ribbon and no connector for
> the one soldered in.
>
> > Maybe instead of edp-connector one would introduce integrator's specific
> > connector, for example with compatible "olimex,teres-edp-connector"
> > which should follow edp abstract connector rules? This will be at least
> > consistent with below presentation[1] - eDP requirements depends on
> > integrator. Then if olimex has standard way of dealing with panels
> > present in olimex/teres platforms the driver would then create
> > drm_panel/drm_connector/drm_bridge(?) according to these rules, I guess.
> > Anyway it still looks fishy for me :), maybe because I am not
> > familiarized with details of these platforms.
>
> That makes sense yes

Actually, it makes no sense at all. Current implementation for anx6345
driver works fine as is with any panel specified assuming panel delays
are long enough for connected panel. It just doesn't use panel timings
from the driver. Creating a platform driver for connector itself looks
redundant since it can't be reused, it doesn't describe actual
hardware and it's just defeats purpose of DT by introducing
board-specific code.

There's another issue: if we introduce edp-connector we'll have to
specify power up delays somewhere (in dts? or in platform driver?), so
edp-connector doesn't really solve the issue of multiple panels with
same motherboard.

I'd say DT overlays should be preferred solution here, not another
connector binding.

> Maxime
>
> --
> Maxime Ripard, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
