Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E251C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 20:51:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A697320821
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 20:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558558304;
	bh=dcl6XpzG1DDiMx3oHbMcInJ4R+XbGpCs4f6YYoK6WEk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=GZkiCT4QJHBYbdurC0G03Cc/gTUbRsN7KmASsq6dfzMz5GXc+2N7AJ9diWbVOGWCd
	 kVRxA1G0AQQ+3uYKgVk44hHjOsach2Qb1wGbsK1JMQGhf+PayFNSGEV2cFyfJ0wQjG
	 zuhLK9cs+iD/TEHlwYrMWTd5h5LfvNdPVQP9N82A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730545AbfEVUvn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 16:51:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:37538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729906AbfEVUvn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 16:51:43 -0400
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6038D2186A;
        Wed, 22 May 2019 20:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558558301;
        bh=dcl6XpzG1DDiMx3oHbMcInJ4R+XbGpCs4f6YYoK6WEk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LJZbItmKpX56PBXWugXHQzTgAjsfEm5s1uaBT2O8qqjizQ/Es1rq0wQCtlYQF+jCB
         cjUHCJjB6zbf4/stUzWPHJTzh7/zwfY+5Jx2/LRyFn/O9x2nw/3NqkFQdaZpfBkbE2
         okPV6H9Cu2UdrP1Nh4TKrBEgZ92kMJasUrH+HspE=
Received: by mail-qt1-f175.google.com with SMTP id i26so4133978qtr.10;
        Wed, 22 May 2019 13:51:41 -0700 (PDT)
X-Gm-Message-State: APjAAAU4m7kwaFWyvIUGwAZlYK5qkg2/v2E7UWRSDKulKjlNAJZsD2C7
        jRB2xXFJZuqJ61XRTTUpHIyts+TQ3KtyTnnvEQ==
X-Google-Smtp-Source: APXvYqyuy3fJbwEjpTWrBUVbta5lNl+N55jezZNxTU+YA/kaLAInc8ArDeyhPPPfhRkmH2QkuaA5kq4A9TjtCfyoUE8=
X-Received: by 2002:aed:3f5b:: with SMTP id q27mr75854887qtf.143.1558558300682;
 Wed, 22 May 2019 13:51:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190521161102.29620-1-peron.clem@gmail.com> <CAL_Jsq+86nNEBzjbf_GLWWrAN91jwU+JQ7zrEoFaT_dxUzVv4A@mail.gmail.com>
 <CAJiuCcdPXdG1ZcWypJZy_d04c2obEuqFZXna-voMmbK6Au84CA@mail.gmail.com>
In-Reply-To: <CAJiuCcdPXdG1ZcWypJZy_d04c2obEuqFZXna-voMmbK6Au84CA@mail.gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 22 May 2019 15:51:29 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJAMTmSiPD4RqcW_uSPXda-+ifjVKpJ4Xc_C6mx5phaig@mail.gmail.com>
Message-ID: <CAL_JsqJAMTmSiPD4RqcW_uSPXda-+ifjVKpJ4Xc_C6mx5phaig@mail.gmail.com>
Subject: Re: [PATCH v6 0/6] Allwinner H6 Mali GPU support
To:     =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Cc:     Joerg Roedel <joro@8bytes.org>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Will Deacon <will.deacon@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Steven Price <steven.price@arm.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux IOMMU <iommu@lists.linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 22, 2019 at 2:41 PM Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.c=
om> wrote:
>
> Hi Rob,
>
> On Wed, 22 May 2019 at 21:27, Rob Herring <robh+dt@kernel.org> wrote:
> >
> > On Tue, May 21, 2019 at 11:11 AM Cl=C3=A9ment P=C3=A9ron <peron.clem@gm=
ail.com> wrote:
> > >
> > > Hi,
> > >
> > > The Allwinner H6 has a Mali-T720 MP2 which should be supported by
> > > the new panfrost driver. This series fix two issues and introduce the
> > > dt-bindings but a simple benchmark show that it's still NOT WORKING.
> > >
> > > I'm pushing it in case someone want to continue the work.
> > >
> > > This has been tested with Mesa3D 19.1.0-RC2 and a GPU bitness patch[1=
].
> > >
> > > One patch is from Icenowy Zheng where I changed the order as required
> > > by Rob Herring[2].
> > >
> > > Thanks,
> > > Clement
> > >
> > > [1] https://gitlab.freedesktop.org/kszaq/mesa/tree/panfrost_64_32
> > > [2] https://patchwork.kernel.org/patch/10699829/
> > >
> > >
> > > [  345.204813] panfrost 1800000.gpu: mmu irq status=3D1
> > > [  345.209617] panfrost 1800000.gpu: Unhandled Page fault in AS0 at V=
A
> > > 0x0000000002400400
> > > [  345.209617] Reason: TODO
> > > [  345.209617] raw fault status: 0x800002C1
> > > [  345.209617] decoded fault status: SLAVE FAULT
> > > [  345.209617] exception type 0xC1: TRANSLATION_FAULT_LEVEL1
> > > [  345.209617] access type 0x2: READ
> > > [  345.209617] source id 0x8000
> > > [  345.729957] panfrost 1800000.gpu: gpu sched timeout, js=3D0,
> > > status=3D0x8, head=3D0x2400400, tail=3D0x2400400, sched_job=3D0000000=
09e204de9
> > > [  346.055876] panfrost 1800000.gpu: mmu irq status=3D1
> > > [  346.060680] panfrost 1800000.gpu: Unhandled Page fault in AS0 at V=
A
> > > 0x0000000002C00A00
> > > [  346.060680] Reason: TODO
> > > [  346.060680] raw fault status: 0x810002C1
> > > [  346.060680] decoded fault status: SLAVE FAULT
> > > [  346.060680] exception type 0xC1: TRANSLATION_FAULT_LEVEL1
> > > [  346.060680] access type 0x2: READ
> > > [  346.060680] source id 0x8100
> > > [  346.561955] panfrost 1800000.gpu: gpu sched timeout, js=3D1,
> > > status=3D0x8, head=3D0x2c00a00, tail=3D0x2c00a00, sched_job=3D0000000=
0b55a9a85
> > > [  346.573913] panfrost 1800000.gpu: mmu irq status=3D1
> > > [  346.578707] panfrost 1800000.gpu: Unhandled Page fault in AS0 at V=
A
> > > 0x0000000002C00B80
> > >
> > > Change in v5:
> > >  - Remove fix indent
> > >
> > > Changes in v4:
> > >  - Add bus_clock probe
> > >  - Fix sanity check in io-pgtable
> > >  - Add vramp-delay
> > >  - Merge all boards into one patch
> > >  - Remove upstreamed Neil A. patch
> > >
> > > Change in v3 (Thanks to Maxime Ripard):
> > >  - Reauthor Icenowy for her path
> > >
> > > Changes in v2 (Thanks to Maxime Ripard):
> > >  - Drop GPU OPP Table
> > >  - Add clocks and clock-names in required
> > >
> > > Cl=C3=A9ment P=C3=A9ron (5):
> > >   drm: panfrost: add optional bus_clock
> > >   iommu: io-pgtable: fix sanity check for non 48-bit mali iommu
> > >   dt-bindings: gpu: mali-midgard: Add H6 mali gpu compatible
> > >   arm64: dts: allwinner: Add ARM Mali GPU node for H6
> > >   arm64: dts: allwinner: Add mali GPU supply for H6 boards
> > >
> > > Icenowy Zheng (1):
> > >   dt-bindings: gpu: add bus clock for Mali Midgard GPUs
> >
> > I've applied patches 1 and 3 to drm-misc. I was going to do patch 4
> > too, but it doesn't apply.
>
> Thanks,
>
> I have tried to applied on drm-misc/for-linux-next but it doesn't apply t=
oo.
> It looks like commit d5ff1adb3809e2f74a3b57cea2e57c8e37d693c4 is
> missing on drm-misc ?
> https://github.com/torvalds/linux/commit/d5ff1adb3809e2f74a3b57cea2e57c8e=
37d693c4#diff-c3172f5d421d492ff91d7bb44dd44917

5.2-rc1 is merged in now and I've applied patch 4.

Rob
