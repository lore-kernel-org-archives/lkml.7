Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4581C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 20:13:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86811213F2
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 20:13:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="cg6/9xmK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727359AbfCSUNP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 16:13:15 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:46282 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726824AbfCSUNO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 16:13:14 -0400
Received: by mail-oi1-f196.google.com with SMTP id x188so4848146oia.13
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 13:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pChVmqBWNHh+c9JeuJAKczvnZeuFBoIGS35tMLIUbY4=;
        b=cg6/9xmKTOJ0PR1H93EhfAuEZ4Yx3/M/+JUx2Jhh/L+5BMo7PJGWBqu27eZDHs7qLS
         jLyZT/5z/Or1XJSu/2eMuOyycFeYtCAooQ/hQJdeKpSplJ/ht93/f+WGXH3nptplGlGE
         kv+oLq4RH7y/LEfh9BRzxxIaGLFTggtVdWdB26wELBilEpt8j9T1W9wRIr3socNlFnYM
         jE6VIevRtE+q5LeHsrMn0FPOeZPVZgi1k31kaSP4FJcUZLw9tfd44uk5PXo+yI3cGZn+
         P+heNHs6CMWMlTEknaQJTuDSsyQs65XhDtftdq4MddCeQJ1snmlEQTpXxHRtpIQTipqe
         19rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pChVmqBWNHh+c9JeuJAKczvnZeuFBoIGS35tMLIUbY4=;
        b=Bm/DXmvbxfEUCCEs/D72AFPCfxF+6sUwf+YZ7lYed51cyzg0iX1nddWcNkznBHCeUE
         OBgvDUMZV5InTXx1jZMPwX9uz+3j2IZOK+Ehmqw4fgs9VgZjSouBtq5bMPudPwwcHMPI
         Dm5o76fVLjeHv8WiJVx2VHyMWQs5F3HkLQJw2+mUI6Q+w/cZ/8zV612Ig1kKEYviCoXy
         L5CpHRo/eOBBbFwCLM+vtmxadjKDNe8PDA8zvK0Vv89K8QyRGzcwXyJzTDFNXIPraW/b
         wm2LbeW2bnijBqA+HZeqkNmstxPr62iz3wbDAkOo0wp71+766TyjQ5O2iitHASMDjcoS
         T/yw==
X-Gm-Message-State: APjAAAWfU2XoQl32VdX485zpn7YCj9cos6pwkbEAxrxuCtoZQLVW4c+7
        94x4RTznfMzY/frfPmqzHNHeJEOUgEFOAtMGchM=
X-Google-Smtp-Source: APXvYqw0lsMDF11GRsRM/4MI4/qFFiwyhPyUyJKWtMj425kYyaCa0Yc2w6Rx4WiZI27Jyt+QkyWDAWrKUDmCZ7VCrLM=
X-Received: by 2002:aca:cf07:: with SMTP id f7mr2725524oig.39.1553026393798;
 Tue, 19 Mar 2019 13:13:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190318100458.5619-1-narmstrong@baylibre.com>
 <20190318100458.5619-7-narmstrong@baylibre.com> <CAFBinCCSKh145--5EAPQyJjbuefRgWm57G+05so28-WiZjqNYg@mail.gmail.com>
 <c13bc57b-82ea-8f48-75a7-417941b08a11@baylibre.com>
In-Reply-To: <c13bc57b-82ea-8f48-75a7-417941b08a11@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Tue, 19 Mar 2019 21:13:02 +0100
Message-ID: <CAFBinCDj=5VpoJGKVGw5bG50EaBHgKz=WLtSwNVVWXtzfoiQ9A@mail.gmail.com>
Subject: Re: [PATCH v2 06/11] arm64: dts: meson-g12a-x96-max: add regulators
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     khilman@baylibre.com, linux-amlogic@lists.infradead.org,
        Guillaume La Roque <glaroque@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

On Tue, Mar 19, 2019 at 9:29 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> On 18/03/2019 21:13, Martin Blumenstingl wrote:
> > Hi Neil,
> >
> > On Mon, Mar 18, 2019 at 11:06 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
> >>
> >> From: Guillaume La Roque <glaroque@baylibre.com>
> >>
> >> Add system regulators for the X96 Max Set-Top-Box.
> >>
> >> Still missing
> >> * VDD_EE (0.8V - PWM controlled)
> >> * VDD_CPU (PWM controlled)
> >>
> >> Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
> >> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> >> ---
> >>  .../boot/dts/amlogic/meson-g12a-x96-max.dts   | 67 +++++++++++++++++++
> >>  1 file changed, 67 insertions(+)
> >>
> >> diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts b/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts
> >> index 0edbd00b358f..5c37930b09e2 100644
> >> --- a/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts
> >> +++ b/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts
> > [...]
> >> +       vcc_5v: regulator-vcc_5v {
> >> +               compatible = "regulator-fixed";
> >> +               regulator-name = "VCC_5V";
> >> +               regulator-min-microvolt = <5000000>;
> >> +               regulator-max-microvolt = <5000000>;
> >> +               vin-supply = <&dc_in>;
> >> +
> >> +               gpio = <&gpio GPIOH_8 GPIO_OPEN_DRAIN>;
> >> +               enable-active-high;
> > is there any way to test whether this GPIO is the right one?
> > I couldn't find a reference to a GPIOH_8 regulator in
> > buildroot_openlinux_kernel_4.9_fbdev_20180706
>
> The x96 is based on the U212 reference design, and the GPIOH_8 controls the 5V_EN signal,
> but you are right, it's the wrong polarity here, it should be enable-active-low instead.
> (FYI The SEI510 does not use this at all, 5V is always enabled)
>
> The schematics describes :
> VCC5V_EN (GPIOH_8-Hiz OD): 5V_EN
> L: Enable
> Hiz: Disable
thank you for this explanation!

> FYI, the GPIOH_8 is Open-Drain only, this means this pin cannot pull to TTL 1, only to TTL 0
> or set as input. We need to add a way to describe this in the pinctrl driver somehow....
as far as I understand the pinctrl driver changes would result in an
error when the GPIO is used with "active high" (making incompatible
drivers or .dts easier to see). is this correct?

> I will send a fix on v3
>
> I didn't notice because I power the board using a Type-A to Type-A connector,
> and the 5V from the USB port bypasses this regulator...
this is good to know.
I'm also powering some of my boards using a Type-A to Type-A
connector. I'll need to remember this and this whether boards are
still booting with the DC plug


Regards
Martin
