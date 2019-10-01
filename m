Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14F8EC352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 10:26:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8FD121920
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 10:26:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="MW/6KBSt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730682AbfJAK01 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 06:26:27 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:43165 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730596AbfJAK00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 06:26:26 -0400
Received: by mail-io1-f68.google.com with SMTP id v2so46407372iob.10
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2019 03:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7dJvQt2XADSP58gshAp3mouDAHa/fpvN+3lt4rGrgN0=;
        b=MW/6KBStB07v5dXk4ZigslPFPugYyqpQ/ScdkbBrgCiKH3o4AbFDQ1qwAd32i3L1Ut
         qcFaTGc/lhLrM65+N2L6mT4GH2quV73dZ3OW0f6J3hfFwX4x/zkGKr+2BK03MWo28DBy
         KNoWV2aGvRV8NEKSqzFK7sgsmnnNqr38yDafY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7dJvQt2XADSP58gshAp3mouDAHa/fpvN+3lt4rGrgN0=;
        b=Cn578em20bHTtSxqdlteLe9DEB80qBnoAj9w+GVCAFwhpSBhHLawoihg9t+xo2Oxvk
         L0leSoIfX/7n5N7tEt38u905v7wZ//mUr2vv+9QWlUSyDFJF+KS2VipaqpaKws0LcGYU
         410wtrE465/qSa7AlLq12f6XkAoVQLWHKOx4/Nz1fq/FpbEPG5BxpDcJqzRypaMUY+Ri
         5KqsoEUaFN+j3oIvSlSzJzoCwu7rwcjBtXSWHfEwsVxIHi6Ouaqfw69/bqiakG4PRXak
         TRI1sVfn4GNAn4vG8/68sULy6oiM2o4ocdDZZ5JhsJALAUVIXkFDAlZKj4eOUXLYlAT7
         eWuw==
X-Gm-Message-State: APjAAAVX3kxliCG7plR9Dn+OuwBXt0zW5QjvxV0PTBcpQtr60eybQwGg
        CiBBG1AMf8/vtfBBTHkakoYdlCfsEOw0d0lPJwGAWg==
X-Google-Smtp-Source: APXvYqyE36IiztYNTVOMhjmeAHCFxs73KTI2V5Ei5/NiBQ6XuIFOw+4jhZSV1acSSHmC1qFffPrmWbSyxu+uPa3yx0A=
X-Received: by 2002:a5d:89da:: with SMTP id a26mr23534629iot.61.1569925585423;
 Tue, 01 Oct 2019 03:26:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190919052822.10403-1-jagan@amarulasolutions.com>
 <20190919052822.10403-2-jagan@amarulasolutions.com> <6797961.eJj5WIFbM9@phil>
In-Reply-To: <6797961.eJj5WIFbM9@phil>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Tue, 1 Oct 2019 15:56:14 +0530
Message-ID: <CAMty3ZDKaywoPxCSD-5N2pLjtGmZ-dZ7ZgUOJqiB1V_9rfR26A@mail.gmail.com>
Subject: Re: [PATCH 1/6] arm64: dts: rockchip: Fix rk3399-roc-pc pwm2 pin
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Levin Du <djw@t-chip.com.cn>, Akash Gajjar <akash@openedev.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Da Xue <da@lessconfused.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-amarula <linux-amarula@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heiko,

On Mon, Sep 30, 2019 at 2:51 AM Heiko Stuebner <heiko@sntech.de> wrote:
>
> Hi Jagan,
>
> Am Donnerstag, 19. September 2019, 07:28:17 CEST schrieb Jagan Teki:
> > ROC-PC is not able to boot linux console if PWM2_d is
> > unattached to any pinctrl logic.
> >
> > To be precise the linux boot hang with last logs as,
> > ...
> > .....
> > [    0.003367] Console: colour dummy device 80x25
> > [    0.003788] printk: console [tty0] enabled
> > [    0.004178] printk: bootconsole [uart8250] disabled
> >
> > In ROC-PC the PWM2_d pin is connected to LOG_DVS_PWM of
> > VDD_LOG. So, for normal working operations this needs to
> > active and pull-down.
> >
> > This patch fix, by attaching pinctrl active and pull-down
> > the pwm2.
>
> This looks highly dubious on first glance. The pwm subsystem nor
> the Rockchip pwm driver do not do any pinctrl handling.
>
> So I don't really see where that "active" pinctrl state is supposed
> to come from.
>
> Comparing with the pwm driver in the vendor tree I see that there
> is such a state defined there. But that code there also looks strange
> as that driver never again leaves this active state after entering it.
>
> Also for example all the Gru devices run with quite a number of pwm-
> regulators without needing additional fiddling with the pwm itself, so
> I don't really see why that should be different here.

I deed, I was supposed to think the same. but the vendor kernel dts
from firefly do follow the pwm2 pinctrl [1]. I wouldn't find any
information other than this vensor information, ie one of the reason I
have marked "Levin Du" who initially supported this board.

One, think I have seen was this pinctrl active fixed the boot hang.
any inputs from would be very helpful.

Levin Du, any inputs?

[1] https://github.com/FireflyTeam/kernel/blob/stable-4.4-rk3399-linux/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi#L1184
