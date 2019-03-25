Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3C01C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 10:12:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 603A420863
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 10:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553508746;
	bh=0dcTvGmvdH8hkzdvGKePclLuSk+RLnqL0pIjWo67ZE8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=A7G95Z9JniyEXu5O95dPZ9bAnqdeCGnfLCtFYbcf5UjWKXG4HKIkqaoGf6rmd0pJS
	 06r5HcCLqhNMR1wA9snJ8DY3pxgsnWHZKTX/6WthUkB29L69LSNXa0LVJNbQwDvEFC
	 8/+jr1PCbwSiKG5zmfObe1nPjAgeOhZfFRPpCzP4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730605AbfCYKMZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 06:12:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:48438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730456AbfCYKMZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 06:12:25 -0400
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B68A208E4;
        Mon, 25 Mar 2019 10:12:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553508743;
        bh=0dcTvGmvdH8hkzdvGKePclLuSk+RLnqL0pIjWo67ZE8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=EbFm6fUp+EcFnc93Fp3Azv8GQhMNv2tbiaLTkt4rV7cp06ExWQN3+qTSmkriA4SdO
         hO2NWo5CRhX99xdcAsows3D3pHqNZezKvjY5rlraZskc6KZgL2ZpSDiGSL4NvF4eZy
         7arN8HOcJ3P+0AJwH2c4J1GTOgEKV72zOMm/2coQ=
Received: by mail-wr1-f42.google.com with SMTP id q1so9406717wrp.0;
        Mon, 25 Mar 2019 03:12:23 -0700 (PDT)
X-Gm-Message-State: APjAAAXYUtjmgYmy7NWXiNy/IqpelOKUXM2AJ6ssjKtMgH9EiHgE3FFU
        lNfJ3pKbmW3mSKepk228zsU02hlJik/oqcWvdxU=
X-Google-Smtp-Source: APXvYqypNDk+Pcp6LCI3jW6PF/i8fhCaPYr3mIRVoB6WsLcnrVIQadJSN5B9A3S9yY8u+rNDmXT5vib5cyLlkiUxAFU=
X-Received: by 2002:a5d:458f:: with SMTP id p15mr15881410wrq.188.1553508741746;
 Mon, 25 Mar 2019 03:12:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190321084850.20769-1-wens@kernel.org> <20190321084850.20769-4-wens@kernel.org>
 <20190321093012.kg72voxs5kw5xtzu@flea> <CAGb2v66bh0UXcjScHRL5U4f_mBALDN6Vckt=9sjziz09qygcxA@mail.gmail.com>
 <3a896485-d7d4-e221-6e66-34bbdb0c0f6e@redhat.com>
In-Reply-To: <3a896485-d7d4-e221-6e66-34bbdb0c0f6e@redhat.com>
From:   Chen-Yu Tsai <wens@kernel.org>
Date:   Mon, 25 Mar 2019 18:12:11 +0800
X-Gmail-Original-Message-ID: <CAGb2v66128Z=K1NHRqFBNA5RewvWRYZxhXpZgmysZTzrme6DVA@mail.gmail.com>
Message-ID: <CAGb2v66128Z=K1NHRqFBNA5RewvWRYZxhXpZgmysZTzrme6DVA@mail.gmail.com>
Subject: Re: [linux-sunxi] Re: [PATCH v3 3/9] power: supply: axp20x_usb_power:
 allow disabling input current limiting
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Chen-Yu Tsai <wens@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 4:58 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi,
>
> On 25-03-19 03:45, Chen-Yu Tsai wrote:
> > On Thu, Mar 21, 2019 at 5:30 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> >>
> >> Hi,
> >>
> >> The rest of the series is
> >> Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
> >>
> >> On Thu, Mar 21, 2019 at 04:48:44PM +0800, Chen-Yu Tsai wrote:
> >>> From: Chen-Yu Tsai <wens@csie.org>
> >>>
> >>> The AXP PMICs allow the user to disable current limiting on the VBUS
> >>> input. While read-out of this setting was already supported by the
> >>> driver, it did not allow the user to configure the PMIC to disable
> >>> current limiting.
> >>>
> >>> Add support for this.
> >>>
> >>> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> >>
> >> Do we really want to do that though? That could have some pretty bad
> >> consequences.
> >
> > If I understand the manual correctly, the PMIC has two mode of operation
> > with regards to VBUS. Normal operation means the PMIC will try to limit
> > the current draw to maintain VBUS above the set V_hold (defaults to 4.4V).
> > This is in addition to the current limit set in this patch.
> >
> > The other mode of operation is bypass, where it ignores the voltage limit.
> > Not sure if it also ignores the current limit, but probably not. In any
> > case we don't support this mode in the driver.
> >
> > So I can think of a few cases where this might be bad:
> >
> > 1. High current draw results in excessive voltage drop and heating over
> >     line / traces due to insufficient conductor area. This should be covered
> >     by the voltage holding mechanism.
> >
> > 2. Over taxing the external power supply. This should also result in some
> >     voltage drop for simple power bricks. Advanced ones would either have
> >     current limiting or over-current protection.
> >
> > What bad consequences are you thinking of?
>
> Lets say you use a typical 5v / 2A charger-plug, lets also say that at full
> load this brick has an efficiency of 90%. At full load it delivers 10W of
> power, while consuming 11.1W dissipating 1.1W of losses as heat.
>
> Now lets say we disable current-limiting and rely only on the V_hold
> mechanism, lets say that we end up with 4.5 volts at 2.4 amps because of
> this and since we are now operating in overload conditions the
> efficiency has fallen to 80% (approx. 4.5/5.0 * 90%) so now at full load
> it delivers 10.8W of power, while consuming 13.5W dissipating 2.7W of
> losses as heat. Chances are the the small plastic enclosure of your
> typical charger-plug cannot dissipate this much and will start warming
> up, until it bursts into flames.
>
> Disabling current limit protection is a very bad idea because you will
> end up in an equilibrium between the Vhold from the charger-ic and the
> over-current protection from the power-brick where you are over the
> design limit of the power-brick.
>
> I actually like what the TI charger-ics are doing here a lot more then
> what the AXP series is doing, with TI charger-ics if you set a current
> limit > 500mA and the power-brick's voltages drops too much because of
> this (or because of a bad cable) it automatically falls back to 500mA.
> Where as at least with the AXP288, it simply starts drawing 1.5A at 4.5V
> with a bad cable, but in this case the dissipation at least is happening
> inside the cable rather then inside the charger-plug, which typically
> already gets quite hot under normal operation conditions.
>
> Disabling the current limit is basically the same as what bad USB-A
> to USB-C cables which have a Rp-3.0 resistor in the C plug do, these tell
> the device with the Type-C plug it can safely draw 3A from the A-port the
> A plug is plugged into. The web is full of stories about this causing
> damage to machines, e.g.:
>
> "Bohn's Nexus 6P drew too much power from his MacBook Air while using a third-party cord, frying the machine and making the USB Type-C ports work only intermittently."
>
> From: https://www.laptopmag.com/articles/how-to-find-safe-usb-type-c-cables
>
> Another good link about the problems caused by these bad Rp resistor
> values in Type-C to Type-A cables (which also effectively disable the
> current-limit on the device charging on the C-end of the cable):
> https://plus.google.com/102617628172847077584/posts/HakwCMmd346
>
> Note this second link is going away in 6 days as google is retiring
> google+.
>
> Anyways TL;DR: Disabling the current-limit is a bad idea and really
> nothing good can come from this.

OK. I'll respin the series without this.

ChenYu
