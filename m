Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36DC8C04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 15:17:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0988C2166E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 15:17:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dmpRF7RZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbfENPRh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 11:17:37 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:40910 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbfENPRg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 11:17:36 -0400
Received: by mail-yw1-f66.google.com with SMTP id 18so14265617ywe.7;
        Tue, 14 May 2019 08:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XlpJYHLmPG7Uggd9+oaIZ1OeCPKgknlGwcKeYgcPgps=;
        b=dmpRF7RZxloSc1IpirAVs4uHNLPmixu1h5DGL0kn80zjR4NMuvwbzk04I71iyTq+I6
         FFq4icPffkFrDE80DZkTbIEQCePFMc6rrKjiDUKR2yLzjDDytq3bmNcVsvDM4YW+CNgz
         uh+dqa4DzyxtUGio4Fzqq7gmif5BzLB2GD3La6kHR6PqSV8Jh38XdxUXeygbQJkkyz8V
         pMx1cxToi+sqCT0rMD5tgdgdT7YAYp9JAD8Ama+b8XJW5XO4LWLh0vYiEtHW60/m4NRb
         FlkhmS5dSRhK2bO96CC0vcQwG/KLBjyZbG4F2bclAP8r1VMdbOAfq01Px1CG3FiVoVTU
         jTlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XlpJYHLmPG7Uggd9+oaIZ1OeCPKgknlGwcKeYgcPgps=;
        b=FMdSZXPOQ6iyvbaS9C4KjlzQmIk9jcXYVfWNhYJNg+tfqAlwvWslrO96UAj7gNQZ5u
         HjvxMD4fnVheevvBqsoZ4drm53dMEo0meVoHf1HYXj7zPxC/eft3dQ1LJhdkAr2qrqvW
         cF03xORbuYd1s5Wf7v72E2uTLVEu2SSj7TjB0Zy1hU/zcIe81srtpLgpNaNpeFM7VkZ7
         4PXXnUJESjiNq34t24ctkt8hHvBlUmGk47xYtKfxkUcvAhtEJaelROmBwUWJrblewVbK
         0QB9AF7IOtDdjF9WF+w+BJxi7my43RueOeInB2HdRpAzXG96dghecuy/jsLn9iaqAXfE
         qKQA==
X-Gm-Message-State: APjAAAUHRhQlA1m9Xa8lJ5ClkcMfOuDl1x/o1cvg2wWYpbLpAr1BL1ni
        CyZyq4nvwZrPX1mKF7ULTB3JZp1C7zFg9O1XxVc=
X-Google-Smtp-Source: APXvYqxEriT2XkWrsa7sMupzbhPrCGn4wsQkd2YWnSKAQ8Mjc/v1DzNBx9GbGA3XQKwGm9ujepe0XUdZIaO+zUVSBaE=
X-Received: by 2002:a25:9b88:: with SMTP id v8mr17000341ybo.153.1557847055669;
 Tue, 14 May 2019 08:17:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190512174608.10083-1-peron.clem@gmail.com> <20190513151405.GW17751@phenom.ffwll.local>
 <de50a9da-669f-ab25-2ef2-5ffb90f8ee03@baylibre.com>
In-Reply-To: <de50a9da-669f-ab25-2ef2-5ffb90f8ee03@baylibre.com>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Tue, 14 May 2019 17:17:24 +0200
Message-ID: <CAJiuCccuEw0BK6MwROR+XUDvu8AJTmZ5tu=pYwZbGAuvO31pgg@mail.gmail.com>
Subject: Re: [PATCH v4 0/8] Allwinner H6 Mali GPU support
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     David Airlie <airlied@linux.ie>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, dri-devel@lists.freedesktop.org,
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

On Tue, 14 May 2019 at 12:29, Neil Armstrong <narmstrong@baylibre.com> wrot=
e:
>
> Hi,
>
> On 13/05/2019 17:14, Daniel Vetter wrote:
> > On Sun, May 12, 2019 at 07:46:00PM +0200, peron.clem@gmail.com wrote:
> >> From: Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>
> >>
> >> Hi,
> >>
> >> The Allwinner H6 has a Mali-T720 MP2. The drivers are
> >> out-of-tree so this series only introduce the dt-bindings.
> >
> > We do have an in-tree midgard driver now (since 5.2). Does this stuff w=
ork
> > together with your dt changes here?
>
> No, but it should be easy to add.
I will give it a try and let you know.

>
> Cl=C3=A9ment, no need to resend the first patch, it's now on
> linus master.
Ok

Thanks,
Clement

>
> Could you also add support for the bus clock in panfrost
> in the same patchset since it's also on master now ?
>
> Neil
>
> > -Daniel
> >
> >> The first patch is from Neil Amstrong and has been already
> >> merged in linux-amlogic. It is required for this series.
> >>
> >> The second patch is from Icenowy Zheng where I changed the
> >> order has required by Rob Herring.
> >> See: https://patchwork.kernel.org/patch/10699829/
> >>
> >> Thanks,
> >> Cl=C3=A9ment
> >>
> >> Changes in v4:
> >>  - Add Rob Herring reviewed-by tag
> >>  - Resent with correct Maintainers
> >>
> >> Changes in v3 (Thanks to Maxime Ripard):
> >>  - Reauthor Icenowy for her patch
> >>
> >> Changes in v2 (Thanks to Maxime Ripard):
> >>  - Drop GPU OPP Table
> >>  - Add clocks and clock-names in required
> >>
> >> Cl=C3=A9ment P=C3=A9ron (6):
> >>   dt-bindings: gpu: mali-midgard: Add H6 mali gpu compatible
> >>   arm64: dts: allwinner: Add ARM Mali GPU node for H6
> >>   arm64: dts: allwinner: Add mali GPU supply for Pine H64
> >>   arm64: dts: allwinner: Add mali GPU supply for Beelink GS1
> >>   arm64: dts: allwinner: Add mali GPU supply for OrangePi Boards
> >>   arm64: dts: allwinner: Add mali GPU supply for OrangePi 3
> >>
> >> Icenowy Zheng (1):
> >>   dt-bindings: gpu: add bus clock for Mali Midgard GPUs
> >>
> >> Neil Armstrong (1):
> >>   dt-bindings: gpu: mali-midgard: Add resets property
> >>
> >>  .../bindings/gpu/arm,mali-midgard.txt         | 27 ++++++++++++++++++=
+
> >>  .../dts/allwinner/sun50i-h6-beelink-gs1.dts   |  5 ++++
> >>  .../dts/allwinner/sun50i-h6-orangepi-3.dts    |  5 ++++
> >>  .../dts/allwinner/sun50i-h6-orangepi.dtsi     |  5 ++++
> >>  .../boot/dts/allwinner/sun50i-h6-pine-h64.dts |  5 ++++
> >>  arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi  | 14 ++++++++++
> >>  6 files changed, 61 insertions(+)
> >>
> >> --
> >> 2.17.1
> >>
> >
>
