Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7894FC432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 13:29:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50C2820715
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 13:29:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="z0D/vAdj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727312AbfKUN3e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 08:29:34 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:39672 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727277AbfKUN3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 08:29:32 -0500
Received: by mail-lj1-f195.google.com with SMTP id p18so3220155ljc.6
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 05:29:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YN2w1QdeDBIuN3qrvGe7lcTmletib6z+wgOMFKHY7Jc=;
        b=z0D/vAdjjQSyzAWXFCGlx0mQhnZHTcZlfWaq5Qz5iceeXxCA4g/kzxHhHFEFlTe1+N
         nhZogCkSWdq55opMhIVeMgHKii93UZkSEwOzzefX64wRD+5244EDJLmgZh4vS4GHvxGX
         iY/4KLPuCtQ+5vUYXQnVsXirlpHZfrSD8NqYLTskvhXDRRzExKj9C7ABEeBDZPUR8Sh9
         IivRc7UELfFmAbKWQBW8pdUMVq7ujo9lH4i1hhdCX+AfD+tuapyWaOxjdn1akEC32+mN
         2411hXmyZbtqijqvGxZkiA3KvTGiFb8CNvvOdYI7li575zqxOY8YzlQyNpGU+lhM9U6J
         V1xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YN2w1QdeDBIuN3qrvGe7lcTmletib6z+wgOMFKHY7Jc=;
        b=B3O+1E71AGvE3/f7VWi4x+xLY+LxEmMIVujaLK65qFJwVeg7EVFkM5OMI2TpsDFNSO
         b/MfNf3wnAy4sVIIWwMp8/a645dRI/Ji+sCxzc/586KjR86AaPredUoCkbzyqK0M956Y
         TEu3p0v8LT2Zj9ngYF+gatwPrhHVOERFOP6zmIFi3t8oY5Emc78U/NFlWNZj4IXU8DYZ
         U2ZBEoFeWZIPz7QOYa7NW4gYmTQxeQBhZqfisAoyRvMzyowWNnhRpH4bdpqdFFhYqsUs
         V2kJXmRYR2tAy4pPQLCW6/vevGjEqAWjwfEP6E0ERMEMrFrY1b+qQx1DGAhEIyC8L5+E
         fR7w==
X-Gm-Message-State: APjAAAWTIIZf+8oct2b/65eM6jL9BwDKgNeQ5PxgM8EMsm7F7+oNP+kv
        QwnW9na1eYJaFDYADyCkO8yRvhxks9/zG9B6EHlUJ5TUu4/bmg==
X-Google-Smtp-Source: APXvYqzJjUSGVSxtMk/wGwbd/ToHrDSThJ5abTzaibpX5Atj5Wt8bITkUmmAvXD2mRbW1lHFa+1ERqvKcZOi8m3HrVU=
X-Received: by 2002:a2e:5c46:: with SMTP id q67mr7269836ljb.42.1574342970066;
 Thu, 21 Nov 2019 05:29:30 -0800 (PST)
MIME-Version: 1.0
References: <20191115125551.31061-1-olteanv@gmail.com>
In-Reply-To: <20191115125551.31061-1-olteanv@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 21 Nov 2019 14:29:18 +0100
Message-ID: <CACRpkdZ5eWHEV-oN77QxH9X4DZRUB3zM=gP=+rM=ZLAX6Wxw9w@mail.gmail.com>
Subject: Re: [PATCH] gpio: mpc8xxx: Don't overwrite default irq_set_type callback
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Vladimir Oltean <vladimir.oltean@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 15, 2019 at 1:56 PM Vladimir Oltean <olteanv@gmail.com> wrote:

> From: Vladimir Oltean <vladimir.oltean@nxp.com>
>
> The per-SoC devtype structures can contain their own callbacks that
> overwrite mpc8xxx_gpio_devtype_default.
>
> The clear intention is that mpc8xxx_irq_set_type is used in case the SoC
> does not specify a more specific callback. But what happens is that if
> the SoC doesn't specify one, its .irq_set_type is de-facto NULL, and
> this overwrites mpc8xxx_irq_set_type to a no-op. This means that the
> following SoCs are affected:
>
> - fsl,mpc8572-gpio
> - fsl,ls1028a-gpio
> - fsl,ls1088a-gpio
>
> On these boards, the irq_set_type does exactly nothing, and the GPIO
> controller keeps its GPICR register in the hardware-default state. On
> the LS1028A, that is ACTIVE_BOTH, which means 2 interrupts are raised
> even if the IRQ client requests LEVEL_HIGH. Another implication is that
> the IRQs are not checked (e.g. level-triggered interrupts are not
> rejected, although they are not supported).
>
> Fixes: 82e39b0d8566 ("gpio: mpc8xxx: handle differences between incarnations at a single place")
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Patch applied with Michael's Tested tag.

Yours,
Linus Walleij
