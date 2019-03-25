Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F52BC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 02:45:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5756F2080F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 02:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553481916;
	bh=GjnI2BEpx2hjKi1OtnX5B8pSFx7DJWOnCd0dIwqIFYs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=fr03RJffHCAZIaiIqApzJDmLtBCb9hLmppp5g4UTq17HRhZr3DHG62LgOrIMKbpc4
	 ke7o0fC4fRLxapni00yyS/1IvxkqdZ4Egx4Cv5X7Ah4Fz3KDJPiMqjvj+Zo/rPwGI7
	 FFn6l81wSqYiT0nPK4KWWwRamqJe/JHR3MDAp/24=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729343AbfCYCpO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 22:45:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:42440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729154AbfCYCpN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 22:45:13 -0400
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9509A2133F;
        Mon, 25 Mar 2019 02:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553481912;
        bh=GjnI2BEpx2hjKi1OtnX5B8pSFx7DJWOnCd0dIwqIFYs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NZ9dER7WVNPPavbt/F9xodY0NRjFuV/h+hTIvDXi30nPM5GJYqozQFMd1BMZbyozN
         4L6dYRYrdsD4n7Uqm7rc9yJUMxfVGfwiJhKn3HFmSL0HI7mVt+mT0cPRRrylj1V3lX
         wC94Upo82VynZJ6ta0Dh2vz0D1W2FG1K4CJbmEco=
Received: by mail-wr1-f41.google.com with SMTP id y7so4185059wrn.11;
        Sun, 24 Mar 2019 19:45:12 -0700 (PDT)
X-Gm-Message-State: APjAAAU1s72/vnua6o35IVU/n4qhU8Y5V1v8pVLJGek4a/Zw+TUHLETW
        Jvvw+/mfZHvs31OREqWw274UQ7QQIVu0vEiZSWk=
X-Google-Smtp-Source: APXvYqwvMGbaGyoQM+3/IaCrgdEiqBCIa30TwwURzLC6MzbNa05CiucVG9duHaBC8KatdTtdEsmPwhUikShMV1UYu0M=
X-Received: by 2002:adf:ec11:: with SMTP id x17mr13478902wrn.120.1553481911134;
 Sun, 24 Mar 2019 19:45:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190321084850.20769-1-wens@kernel.org> <20190321084850.20769-4-wens@kernel.org>
 <20190321093012.kg72voxs5kw5xtzu@flea>
In-Reply-To: <20190321093012.kg72voxs5kw5xtzu@flea>
From:   Chen-Yu Tsai <wens@kernel.org>
Date:   Mon, 25 Mar 2019 10:45:01 +0800
X-Gmail-Original-Message-ID: <CAGb2v66bh0UXcjScHRL5U4f_mBALDN6Vckt=9sjziz09qygcxA@mail.gmail.com>
Message-ID: <CAGb2v66bh0UXcjScHRL5U4f_mBALDN6Vckt=9sjziz09qygcxA@mail.gmail.com>
Subject: Re: [linux-sunxi] Re: [PATCH v3 3/9] power: supply: axp20x_usb_power:
 allow disabling input current limiting
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Chen-Yu Tsai <wens@kernel.org>, Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Hans de Goede <hdegoede@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 21, 2019 at 5:30 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> Hi,
>
> The rest of the series is
> Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
>
> On Thu, Mar 21, 2019 at 04:48:44PM +0800, Chen-Yu Tsai wrote:
> > From: Chen-Yu Tsai <wens@csie.org>
> >
> > The AXP PMICs allow the user to disable current limiting on the VBUS
> > input. While read-out of this setting was already supported by the
> > driver, it did not allow the user to configure the PMIC to disable
> > current limiting.
> >
> > Add support for this.
> >
> > Signed-off-by: Chen-Yu Tsai <wens@csie.org>
>
> Do we really want to do that though? That could have some pretty bad
> consequences.

If I understand the manual correctly, the PMIC has two mode of operation
with regards to VBUS. Normal operation means the PMIC will try to limit
the current draw to maintain VBUS above the set V_hold (defaults to 4.4V).
This is in addition to the current limit set in this patch.

The other mode of operation is bypass, where it ignores the voltage limit.
Not sure if it also ignores the current limit, but probably not. In any
case we don't support this mode in the driver.

So I can think of a few cases where this might be bad:

1. High current draw results in excessive voltage drop and heating over
   line / traces due to insufficient conductor area. This should be covered
   by the voltage holding mechanism.

2. Over taxing the external power supply. This should also result in some
   voltage drop for simple power bricks. Advanced ones would either have
   current limiting or over-current protection.

What bad consequences are you thinking of?

ChenYu
