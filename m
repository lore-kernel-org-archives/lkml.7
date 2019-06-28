Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A01AC4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 10:39:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A04120656
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 10:39:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="jsdULTZw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbfF1Kjj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 06:39:39 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:48893 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726484AbfF1Kjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 06:39:39 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190628103937euoutp0120cdd6586fd3668ff5b982dcf9ce27fd~sVpcJCtlM3166331663euoutp01I
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2019 10:39:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190628103937euoutp0120cdd6586fd3668ff5b982dcf9ce27fd~sVpcJCtlM3166331663euoutp01I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1561718377;
        bh=KxYCFb299NuCBuskzrs32fM+mCiZc0Ki+XeRZlLfjq0=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=jsdULTZwxp+xU/hui5qSc5dMtcUCAD+wD4H6XURck7iAQx2nlOVnpZSO8jyOoV42M
         z+1ogKFgVEelOCnGCxeuVB5HxL2mTPKyOQo8jpatoz0hO26WrGJrmwgQ+UlhO+LujG
         cLeWhgUlCou8ay8nB0cMWRZTmkTyPNPalAey4PkM=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190628103936eucas1p26685f8adf006b35a11477e4280202310~sVpbOfd-B2835028350eucas1p2-;
        Fri, 28 Jun 2019 10:39:36 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 49.14.04298.86EE51D5; Fri, 28
        Jun 2019 11:39:36 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190628103935eucas1p1ed57a3e2f9ecae6cb299cfacb48452d3~sVpaJGe031469414694eucas1p1v;
        Fri, 28 Jun 2019 10:39:35 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190628103935eusmtrp1331c3b3754737d4a782136682bb7f5bf~sVpZ64OIs2528125281eusmtrp17;
        Fri, 28 Jun 2019 10:39:35 +0000 (GMT)
X-AuditID: cbfec7f2-f2dff700000010ca-f6-5d15ee68253a
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id B6.DB.04146.66EE51D5; Fri, 28
        Jun 2019 11:39:35 +0100 (BST)
Received: from [106.120.51.74] (unknown [106.120.51.74]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190628103934eusmtip265136dc79895f63db099ac34349007b6~sVpZCX4-D1929119291eusmtip2P;
        Fri, 28 Jun 2019 10:39:34 +0000 (GMT)
Subject: Re: [PATCH v2 7/7] arm64: dts: allwinner: a64: enable ANX6345
 bridge on Teres-I
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Torsten Duwe <duwe@lst.de>, Harald Geyer <harald@ccbib.org>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
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
From:   Andrzej Hajda <a.hajda@samsung.com>
Message-ID: <bb2c2c00-b46e-1984-088f-861ac8952331@samsung.com>
Date:   Fri, 28 Jun 2019 12:39:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190612152022.c3cfhp4cauhzhfyr@flea>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTYRjG+85tR2t1PC72lkW1KCrIjAo+ulHhHwciiCCKLtjKk0pOZafZ
        xcphTrQStRBxmVlp11Wy6WqaCNNcZs7UYRcyLe2OpqmLBWmbx8D/fjzP877f93x8LMkXM7PZ
        uISjoj5BG69hgil7g69leWz/zP0RT58E4Wx3I4FNDZ8RHrPnkfhqvZvGnpGfDPZ6nhP47I2H
        DK6oaqbx0LX3BM7KK1Vga08Hjdurihhc9qqVwN3fahE21dQrcGd5M8I2az6JfVXFFPY5W4hN
        ocIN3yghWIotSCi2pAif6n4ohMvGVkoo/3iPFmq8JZTgMHf6tcxCWrDezWKEfrdbITzydtNC
        7RWLQug67yIEW2mqUP3GyGwP2RO8PlqMj0sW9Ss2HgiO/WYbZZJs6uNDpnuUEeWEnkNBLHCr
        IS3jGXUOBbM8dxuBK6sTBQyeG0aQb+FlYwhB4+s2+v/EcMZ1Sg7dQjB2RyeH+hB42gYVASOU
        2wM5tQVEgFXccsguuUQHQiTXTsPQy6/jBsMthb+2N0yAldxGyLHnjm+luEXwosk7fo2Z3G4Y
        dliRnAmBxsLe8UwQtwrSPMNkgEkuAuqvF9Eyz4NHfUUTuhre9l4lAgcD52GhocBIyRUiIb26
        k5A5FL67KhQyz4GmSxcmMqnQdTudlIczEVSWO0jZWAd1rtaJt9gMfwacfmb9PB1e94XIB0+H
        i/YCUpaVkJnBy+kF0NVcObFFDWUvR5hcpDFPqmaeVMc8qY55Up0SRN1FatEg6WJEaWWCeCxc
        0uokQ0JM+KFEnRX5f23TqOvXYzTSdtCJOBZppinnO1T7eVqbLJ3QORGwpEalnOX2S8po7YmT
        oj4xSm+IFyUnCmMpjVqZMqV7L8/FaI+KR0QxSdT/dwk2aLYRpQ+GrZtxeHfI4jT+ftlY/v2B
        nvIHjrXn/7ZUj605dWyh9MmwRTX1ZtKuDX1hW76kZuQbInGlqa7QvmPV6UMDDfVZD7MvtEd1
        fIja+bx/X+7guwiDq8NycQ6n6kj21VSEt5rcqp+XV2/7PXfrElNP4j5vTbNvgz57seJMV+kP
        3tRbnaKhpFjtymWkXtL+A3HRcwKxAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRjHec9tU1sct5lvQmWDwAKPHS/5Gir1oTgWhNAXsSQPetJoF9mZ
        ZgU1MkOtMEtBN2+lJukg20pTEXGKZda6eMtA0zRjSQZdBotabc7Ab3/+z+/3vLzwSHF5Bxkm
        PaU1CHotr1ZRgcSo58lsZM5KSMbua2p03TGCoeLhJYD+dlbgqGHIQaLxn18p5Bp/hqGipvsU
        etjzgkTfb89iqLSiWYKsC5MkGuuppVDL1GsMzTn7ASruG5KgmY4XANmsVThy99QTyG1/ie1T
        cE1uD8ZZ6i2Aq7ec5z4OLks4s/E1wXV8aCe5PlcjwXWbZrxdSQ3JWdtKKW7F4ZBwXa45kuuv
        s0i491efYJyt+SLXO22kUoPTmUS9Lt8ghOfqREOS6hiLohk2ATHRsQkMGxOfsTc6ThWVnJgt
        qE8VCPqo5Ewm12nzUHm20MLvxe2EEZQrykCAFNKx8MeVO0QZCJTK6RYAS8vMmH8QCnsbvuD+
        rIC/J8soP7QMYNfAAvANFHQ6fNVftAop6Uh4vfEW6YNweoqEVZUda2tbCfi0+gHpoyh6J/xj
        m6Z8WUYnw/LOG4QvE/QO+HzUtbo1hE6D5h4j4WeC4UjN4moOoGPgpfEfq6/hNAMfT/0i/Xkb
        7PpSu9aHwneLDdgNIDet003rFNM6xbROaQREG1AK+aImRyOyjMhrxHxtDpOl01iB91o6h922
        x+DNg6N2QEuBaoMsvFuZISf5AvGsxg6gFFcpZZsd3kqWzZ89J+h1J/T5akG0gzjv5yrwsJAs
        nff2tIYTbBwbjxLY+Jj4mD1IFSoroQeOy+kc3iCcFoQ8Qf/fw6QBYUaQpP4JJ5T2TM6T5ko6
        +PCee3vyOWfQpju6X+Vv48IignhnxK1a5oCiM3Ne9inrcHWVLPvIYHapem+ieUmUXX6UZTBH
        p7TuE8ZSq1siU2KTwk82ba/bksu7rU5d3xls8MLnAzdTqXnPxmXthIUNOmSn9i+tFN28WxnY
        Ujj7besRFSHm8uwuXC/y/wB7i4BKQwMAAA==
X-CMS-MailID: 20190628103935eucas1p1ed57a3e2f9ecae6cb299cfacb48452d3
X-Msg-Generator: CA
X-RootMTR: 20190607094103epcas1p4babbb11ec050974a62f2af79bc64d752
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190607094103epcas1p4babbb11ec050974a62f2af79bc64d752
References: <20190604122150.29D6468B05@newverein.lst.de>
        <20190604122308.98D4868B20@newverein.lst.de>
        <CA+E=qVckHLqRngsfK=AcvstrD0ymEfRkYyhS_kBtZ3YWdE3L=g@mail.gmail.com>
        <20190605101317.GA9345@lst.de> <20190605120237.ekmytfxcwbjaqy3x@flea>
        <E1hYsvP-0000PY-Pz@stardust.g4.wien.funkfeuer.at>
        <20190607062802.m5wslx3imiqooq5a@flea>
        <CGME20190607094103epcas1p4babbb11ec050974a62f2af79bc64d752@epcas1p4.samsung.com>
        <20190607094030.GA12373@lst.de>
        <66707fcc-b48e-02d3-5ed7-6b7e77d53266@samsung.com>
        <20190612152022.c3cfhp4cauhzhfyr@flea>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime,

It seems I have missed your response.

On 12.06.2019 17:20, Maxime Ripard wrote:
>> I am not sure if I understand whole discussion here, but I also do not
>> understand whole edp-connector thing.
> The context is this one:
> https://patchwork.freedesktop.org/patch/257352/?series=51182&rev=1
> https://patchwork.freedesktop.org/patch/283012/?series=56163&rev=1
> https://patchwork.freedesktop.org/patch/286468/?series=56776&rev=2
>
> TL;DR: This bridge is being used on ARM laptops that can come with
> different eDP panels. Some of these panels require a regulator to be
> enabled for the panel to work, and this is obviously something that
> should be in the DT.
>
> However, we can't really describe the panel itself, since the vendor
> uses several of them and just relies on the eDP bus to do its job at
> retrieving the EDIDs. A generic panel isn't really working either
> since that would mean having a generic behaviour for all the panels
> connected to that bus, which isn't there either.
>
> The connector allows to expose this nicely.


As VESA presentation says[1] eDP is based on DP but is much more
flexible, it is up to integrator (!!!) how the connection, power
up/down, initialization sequence should be performed. Trying to cover
every such case in edp-connector seems to me similar to panel-simple
attempt failure. Moreover there is no such thing as physical standard
eDP connector. Till now I though DT connector should describe physical
connector on the device, now I am lost, are there some DT bindings
guidelines about definition of a connector?

Maybe instead of edp-connector one would introduce integrator's specific
connector, for example with compatible "olimex,teres-edp-connector"
which should follow edp abstract connector rules? This will be at least
consistent with below presentation[1] - eDP requirements depends on
integrator. Then if olimex has standard way of dealing with panels
present in olimex/teres platforms the driver would then create
drm_panel/drm_connector/drm_bridge(?) according to these rules, I guess.
Anyway it still looks fishy for me :), maybe because I am not
familiarized with details of these platforms.

[1]: https://www.vesa.org/wp-content/uploads/2010/12/DisplayPort-DevCon-Presentation-eDP-Dec-2010-v3.pdf


>
>> According to VESA[1] eDP is "Internal display interface" - there is no
>> external connector for eDP, the way it is connected is integrator's
>> decision, but it is fixed - ie end user do not plug/unplug it.
> I'm not sure if you mean DRM or DT connector here though. In DRM,
> we're doing this all the time for panels. I'm literaly typing this
> from a laptop that has a screen with an eDP connector.


VESA describes only hardware, but since DT also describes hardware I
guess it should be similar.


Regards

Andrzej




>
> Maxime
>
> --
> Maxime Ripard, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com


