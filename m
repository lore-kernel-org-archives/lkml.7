Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1A65C606B0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 08:58:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EA82216C4
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 08:58:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726232AbfGII6w convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 04:58:52 -0400
Received: from hermes.aosc.io ([199.195.250.187]:50534 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726105AbfGII6w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 04:58:52 -0400
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: icenowy@aosc.io)
        by hermes.aosc.io (Postfix) with ESMTPSA id 557806E5CF;
        Tue,  9 Jul 2019 08:58:42 +0000 (UTC)
Date:   Tue, 09 Jul 2019 16:58:35 +0800
In-Reply-To: <20190709085532.cdqv7whuesrjs64c@flea>
References: <20190605120237.ekmytfxcwbjaqy3x@flea> <E1hYsvP-0000PY-Pz@stardust.g4.wien.funkfeuer.at> <20190607062802.m5wslx3imiqooq5a@flea> <CGME20190607094103epcas1p4babbb11ec050974a62f2af79bc64d752@epcas1p4.samsung.com> <20190607094030.GA12373@lst.de> <66707fcc-b48e-02d3-5ed7-6b7e77d53266@samsung.com> <20190612152022.c3cfhp4cauhzhfyr@flea> <bb2c2c00-b46e-1984-088f-861ac8952331@samsung.com> <20190701095842.fvganvycce2cy7jn@flea> <CA+E=qVdsYV2Bxk245=Myq=otd7-7WHzUnSJN8_1dciAzvSOG8g@mail.gmail.com> <20190709085532.cdqv7whuesrjs64c@flea>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCH v2 7/7] arm64: dts: allwinner: a64: enable ANX6345 bridge on Teres-I
To:     linux-arm-kernel@lists.infradead.org,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Vasily Khoruzhick <anarsoul@gmail.com>
CC:     Mark Rutland <mark.rutland@arm.com>,
        devicetree <devicetree@vger.kernel.org>,
        Sean Paul <seanpaul@chromium.org>,
        David Airlie <airlied@linux.ie>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Torsten Duwe <duwe@lst.de>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Harald Geyer <harald@ccbib.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        arm-linux <linux-arm-kernel@lists.infradead.org>
From:   Icenowy Zheng <icenowy@aosc.io>
Message-ID: <72E7C765-3660-413A-8450-94BE4B3D1345@aosc.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



于 2019年7月9日 GMT+08:00 下午4:55:32, Maxime Ripard <maxime.ripard@bootlin.com> 写到:
>On Mon, Jul 08, 2019 at 05:49:21PM -0700, Vasily Khoruzhick wrote:
>> > > Maybe instead of edp-connector one would introduce integrator's
>specific
>> > > connector, for example with compatible
>"olimex,teres-edp-connector"
>> > > which should follow edp abstract connector rules? This will be at
>least
>> > > consistent with below presentation[1] - eDP requirements depends
>on
>> > > integrator. Then if olimex has standard way of dealing with
>panels
>> > > present in olimex/teres platforms the driver would then create
>> > > drm_panel/drm_connector/drm_bridge(?) according to these rules, I
>guess.
>> > > Anyway it still looks fishy for me :), maybe because I am not
>> > > familiarized with details of these platforms.
>> >
>> > That makes sense yes
>>
>> Actually, it makes no sense at all. Current implementation for
>anx6345
>> driver works fine as is with any panel specified assuming panel
>delays
>> are long enough for connected panel. It just doesn't use panel
>timings
>> from the driver. Creating a platform driver for connector itself
>looks
>> redundant since it can't be reused, it doesn't describe actual
>> hardware and it's just defeats purpose of DT by introducing
>> board-specific code.
>
>I'm not sure where you got the idea that the purpose of DT is to not
>have any board-specific code.
>
>It's perfectly fine to have some, that's even why there's a compatible
>assigned to each and every board.
>
>What the DT is about is allowing us to have a generic behaviour that
>we can detect: we can have a given behaviour for a given board, and a
>separate one for another one, and this will be evaluated at runtime.
>
>This is *exactly* what this is about: we can have a compatible that
>sets a given, more specific, behaviour (olimex,teres-edp-connector)
>while saying that this is compatible with the generic behaviour
>(edp-connector). That way, any OS will know what quirk to apply if
>needed, and if not that it can use the generic behaviour.
>
>And we could create a generic driver, for the generic behaviour if
>needed.
>
>> There's another issue: if we introduce edp-connector we'll have to
>> specify power up delays somewhere (in dts? or in platform driver?),
>so
>> edp-connector doesn't really solve the issue of multiple panels with
>> same motherboard.
>
>And that's what that compatible is about :)

Maybe we can introduce a connector w/o any driver just like hdmi-connector?

>
>> I'd say DT overlays should be preferred solution here, not another
>> connector binding.
>
>Overlays are a way to apply a device tree dynamically. It's orthogonal
>to the binding.
>
>Maxime
>
>--
>Maxime Ripard, Bootlin
>Embedded Linux and Kernel engineering
>https://bootlin.com

-- 
使用 K-9 Mail 发送自我的Android设备。
