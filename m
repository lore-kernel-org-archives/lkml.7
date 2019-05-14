Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 213C3C04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 21:22:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D26B720850
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 21:22:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jgD6Qxr2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726519AbfENVWN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 17:22:13 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:40478 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbfENVWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 17:22:13 -0400
Received: by mail-yw1-f66.google.com with SMTP id 18so368177ywe.7;
        Tue, 14 May 2019 14:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KZdgPzJMm2Uc8AnrgWwgN1MqujNNgYXR6NcAgSjGT5o=;
        b=jgD6Qxr2AaXHKwZJIVQclWoIaXtmXUdu+G2944cyw0Z0iq3nk/dRopNS9C8YpPwqOO
         kG1IYdzeieuBVOI9b4ByB6lB77SaAu3CgrMsqzoC/ErV7vQmkMHyHfuY00X+nD7k1ILO
         NmA6RDOTSusGjjn+SMXp650jQqdQ+A7mzOuqk+p9X4O8iqnFOKJX3W+xskAoderh2TkU
         /PUOF8dk2qIRYAxb3KpsYLka3JcE6YpSdzXw0YGicwlXuxvxLAjhV6drP3x8YLau0WGl
         SqJQn4iJCblBVXiQrmOUPX3rS12CUzaT24KK3kr2w08AJ8HFuD0qtF5+KhyLHcBZKwZ4
         9SOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KZdgPzJMm2Uc8AnrgWwgN1MqujNNgYXR6NcAgSjGT5o=;
        b=D+QWjuEi/dUn+ngyotQWWISKf163NsZ4I6U5icLD6Sfq/A9wxFuiLSYlaZLvju8q5J
         CJ/VXki8MZM+rXpxaDsVMGRa3X7pXlcOipPoCDajIADzNpLZhalsfrL68QDuDSG59/ZN
         Yo8co+t8r3CFh/QDCQNcSJa9O+B1EhG9X/I1yn/hnut/Gc5jhJ2B8i+5e1R59kHTjRSo
         VEBk+U/D8DtqdJI2js2YcajahjDDVXRn+P9q1mz9DIa3LseymDS2qmLqrmYy9c7D97oh
         aljFGQzY5YuA7EJmEIkLxCh6HVEFMhQkyxb6O49jENKZiG8gxdhmtrTIuHeQlOsWy4ZD
         Eisg==
X-Gm-Message-State: APjAAAW0IkCnTLh/SFCV6yZnOP92lA/FJ6QptXBUgxGNh4zsvpcEhwF2
        +X//g3xcppzKCqh8+i43WuzNHEEgvFhBI4FcVqA=
X-Google-Smtp-Source: APXvYqyWOSbU8dyN+32a7dkVQJ+qYqNHyfYP8x5BUxI4N2/LF4O6Ua0czFAl5rn5BSO1jIhtA3NFbTSFU94W9Bm33bQ=
X-Received: by 2002:a81:6f44:: with SMTP id k65mr18528638ywc.36.1557868931626;
 Tue, 14 May 2019 14:22:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190512174608.10083-1-peron.clem@gmail.com> <20190513151405.GW17751@phenom.ffwll.local>
 <de50a9da-669f-ab25-2ef2-5ffb90f8ee03@baylibre.com> <CAJiuCccuEw0BK6MwROR+XUDvu8AJTmZ5tu=pYwZbGAuvO31pgg@mail.gmail.com>
In-Reply-To: <CAJiuCccuEw0BK6MwROR+XUDvu8AJTmZ5tu=pYwZbGAuvO31pgg@mail.gmail.com>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Tue, 14 May 2019 23:22:00 +0200
Message-ID: <CAJiuCccWa5UTML68JDQq6q8SyNZzVWwQWTOL=+84Bh4EMHGC3A@mail.gmail.com>
Subject: Re: [PATCH v4 0/8] Allwinner H6 Mali GPU support
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     David Airlie <airlied@linux.ie>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 14 May 2019 at 17:17, Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com=
> wrote:
>
> Hi,
>
> On Tue, 14 May 2019 at 12:29, Neil Armstrong <narmstrong@baylibre.com> wr=
ote:
> >
> > Hi,
> >
> > On 13/05/2019 17:14, Daniel Vetter wrote:
> > > On Sun, May 12, 2019 at 07:46:00PM +0200, peron.clem@gmail.com wrote:
> > >> From: Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>
> > >>
> > >> Hi,
> > >>
> > >> The Allwinner H6 has a Mali-T720 MP2. The drivers are
> > >> out-of-tree so this series only introduce the dt-bindings.
> > >
> > > We do have an in-tree midgard driver now (since 5.2). Does this stuff=
 work
> > > together with your dt changes here?
> >
> > No, but it should be easy to add.
> I will give it a try and let you know.
Added the bus_clock and a ramp delay to the gpu_vdd but the driver
fail at probe.

[    3.052919] panfrost 1800000.gpu: clock rate =3D 432000000
[    3.058278] panfrost 1800000.gpu: bus_clock rate =3D 100000000
[    3.179772] panfrost 1800000.gpu: mali-t720 id 0x720 major 0x1
minor 0x1 status 0x0
[    3.187432] panfrost 1800000.gpu: features: 00000000,10309e40,
issues: 00000000,21054400
[    3.195531] panfrost 1800000.gpu: Features: L2:0x07110206
Shader:0x00000000 Tiler:0x00000809 Mem:0x1 MMU:0x00002821 AS:0xf
JS:0x7
[    3.207178] panfrost 1800000.gpu: shader_present=3D0x3 l2_present=3D0x1
[    3.238257] panfrost 1800000.gpu: Fatal error during GPU init
[    3.244165] panfrost: probe of 1800000.gpu failed with error -12

The ENOMEM is coming from "panfrost_mmu_init"
alloc_io_pgtable_ops(ARM_MALI_LPAE, &pfdev->mmu->pgtbl_cfg,
                                         pfdev);

Which is due to a check in the pgtable alloc "cfg->ias !=3D 48"
arm-lpae io-pgtable: arm_mali_lpae_alloc_pgtable cfg->ias 33 cfg->oas 40

DRI stack is totally new for me, could you give me a little clue about
this issue ?

Thanks,
Cl=C3=A9ment

>
> >
> > Cl=C3=A9ment, no need to resend the first patch, it's now on
> > linus master.
> Ok
>
> Thanks,
> Clement
>
> >
> > Could you also add support for the bus clock in panfrost
> > in the same patchset since it's also on master now ?
> >
> > Neil
> >
> > > -Daniel
> > >
> > >> The first patch is from Neil Amstrong and has been already
> > >> merged in linux-amlogic. It is required for this series.
> > >>
> > >> The second patch is from Icenowy Zheng where I changed the
> > >> order has required by Rob Herring.
> > >> See: https://patchwork.kernel.org/patch/10699829/
> > >>
> > >> Thanks,
> > >> Cl=C3=A9ment
> > >>
> > >> Changes in v4:
> > >>  - Add Rob Herring reviewed-by tag
> > >>  - Resent with correct Maintainers
> > >>
> > >> Changes in v3 (Thanks to Maxime Ripard):
> > >>  - Reauthor Icenowy for her patch
> > >>
> > >> Changes in v2 (Thanks to Maxime Ripard):
> > >>  - Drop GPU OPP Table
> > >>  - Add clocks and clock-names in required
> > >>
> > >> Cl=C3=A9ment P=C3=A9ron (6):
> > >>   dt-bindings: gpu: mali-midgard: Add H6 mali gpu compatible
> > >>   arm64: dts: allwinner: Add ARM Mali GPU node for H6
> > >>   arm64: dts: allwinner: Add mali GPU supply for Pine H64
> > >>   arm64: dts: allwinner: Add mali GPU supply for Beelink GS1
> > >>   arm64: dts: allwinner: Add mali GPU supply for OrangePi Boards
> > >>   arm64: dts: allwinner: Add mali GPU supply for OrangePi 3
> > >>
> > >> Icenowy Zheng (1):
> > >>   dt-bindings: gpu: add bus clock for Mali Midgard GPUs
> > >>
> > >> Neil Armstrong (1):
> > >>   dt-bindings: gpu: mali-midgard: Add resets property
> > >>
> > >>  .../bindings/gpu/arm,mali-midgard.txt         | 27 ++++++++++++++++=
+++
> > >>  .../dts/allwinner/sun50i-h6-beelink-gs1.dts   |  5 ++++
> > >>  .../dts/allwinner/sun50i-h6-orangepi-3.dts    |  5 ++++
> > >>  .../dts/allwinner/sun50i-h6-orangepi.dtsi     |  5 ++++
> > >>  .../boot/dts/allwinner/sun50i-h6-pine-h64.dts |  5 ++++
> > >>  arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi  | 14 ++++++++++
> > >>  6 files changed, 61 insertions(+)
> > >>
> > >> --
> > >> 2.17.1
> > >>
> > >
> >
