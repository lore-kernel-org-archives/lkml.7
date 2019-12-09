Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB3F9C04E30
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 13:37:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DB29206E0
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 13:37:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U49pN4MS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727598AbfLINhq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 08:37:46 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:42224 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727038AbfLINhq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 08:37:46 -0500
Received: by mail-qk1-f196.google.com with SMTP id z14so2675256qkg.9;
        Mon, 09 Dec 2019 05:37:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/xGnfoL+Q5lxOftoFuoAZhd74qwSzhnVOVjw5OvXHFM=;
        b=U49pN4MShVa9I6gosbwKeuRR8/P41PZRcOweU0sHhzfXI8IzpGcs9sPlh23zU3+kd0
         +lMJndGzXUoksfINbZjJUE6yVtb+3WBW7mS5Q9JmYeUhUCSIomQlwKKCpSccenO4qVOs
         KvqNRQpR3N46pN8XTJPJ+CaKt1QVUXEvgEhaUp7oo8gwUBPQBNt2NqwwfQeLcQzNv7Nq
         nu8UurvP+Cg0TIBnAoeXQ+ZouvttiMSUp3V3zg9/h6f/h109GCIpCoNza14pwc5+62vK
         m7qOFGGYKTWmvSenSp8GsGyRZ2mRZMemoWQSxuKeX+Q+pHe5kMKNX0YGLB6xlDQudhWw
         GZiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/xGnfoL+Q5lxOftoFuoAZhd74qwSzhnVOVjw5OvXHFM=;
        b=uPPbt5a/PVZwDJ+jkUYATjdanZRMmkqa4UPf8nJNX/eaphlrNAc1LmMfAKVJT7H3P0
         aNFJXXnARs6pdgtHHpQB/Ha/BFKvVFLlJ07ubHrKQTH9dZsdSuXix/pDNQkIAmocWhHB
         bFYgmM4SW58Y2mE4S6NktuyLwnjLDk9MKYEHoV58r4Lo4DLaKWruhM75jhqEb83iPIg7
         Xr9EBY5C1eHGAv6hCIQcjMsWBXNcCEnTC5TunIxPbofXz4QwbBo15lNXyKcBv8kMIuGP
         qDj5fQrwHeq9crrCqSv4SF7U7sgJt2fbeZytMDFBeMHDHyRJ8UtjwDnegC5dTWXZGmfe
         Sepw==
X-Gm-Message-State: APjAAAXPSSM225UjbBwU17x9W8NQiyNGMegRl5gRmCLcWnYuJbZ1M4mJ
        5MQ9QbaGpKEYyQUU68kviBb3h0UnDx4aJA3kHZQ=
X-Google-Smtp-Source: APXvYqyy+pyt3+tHN1YUVJHOdfhc/PRYtoTCblfW0ozOp9vWQN673XU0C1+hCw+KWhrukdItq0qHZrW+JPcMOPiWEnk=
X-Received: by 2002:a37:6c01:: with SMTP id h1mr26390419qkc.484.1575898664569;
 Mon, 09 Dec 2019 05:37:44 -0800 (PST)
MIME-Version: 1.0
References: <20191206184536.2507-1-linux.amoon@gmail.com> <724aa7db-3838-16f9-d344-1789ae2a5746@arm.com>
In-Reply-To: <724aa7db-3838-16f9-d344-1789ae2a5746@arm.com>
From:   Peter Geis <pgwipeout@gmail.com>
Date:   Mon, 9 Dec 2019 08:37:28 -0500
Message-ID: <CAMdYzYoZY5gau=DGtPhk9CPV_WcyM4wjR9o+rPyaQfOzoy2Y=Q@mail.gmail.com>
Subject: Re: [RFCv1 0/8] RK3399 clean shutdown issue
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Anand Moon <linux.amoon@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Daniel Schultz <d.schultz@phytec.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 9, 2019 at 8:29 AM Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 06/12/2019 6:45 pm, Anand Moon wrote:
> > Most of the RK3399 SBC boards do not perform clean
> > shutdown and clean reboot.
>
> FWIW reboot problems on RK3399 have been tracked down to issues in
> upstream ATF, and are unrelated to the PMIC.
>
> > These patches try to help resolve the issue with proper
> > shutdown by turning off the PMIC.
>
> As mentioned elsewhere[1], although this is what the BSP kernel seems to
> do, and in practice it's unlikely to matter for the majority of devboard
> users like you and me, I still feel a bit uncomfortable with this
> solution for systems using ATF as in principle the secure world might
> want to know about orderly shutdowns, and this effectively makes every
> shutdown an unexpected power loss from secure software's point of view.
>
> Robin.

Since ATF is operating completely in volatile memory, and shouldn't be
touching hardware once it passes off control to the kernel anyways,
what is the harm of pulling the rug out from under it?
If this idea is to prevent issues in the future, such as if ATF does
gain the ability to preempt hardware control, then at that time ATF
will need to be able to handle actually powering off devices using the
same functionality.

But as we discussed previously, ATF doesn't have this capability, so
in this case any board without a dedicated power-off gpio will be
unable to power off at all.
Also it seems that giving ATF this functionality, with the current
state of ATF, would be cost prohibitive.

I personally feel that allowing the kernel to do this is a solution to
the problem we have now.


>
> [1]
> http://lists.infradead.org/pipermail/linux-rockchip/2019-December/028183.html
>
> > For reference
> > RK805 PMCI data sheet:
> > [0] http://rockchip.fr/RK805%20datasheet%20V1.3.pdf
> > RK808 PMIC data sheet:
> > [1] http://rockchip.fr/RK808%20datasheet%20V1.4.pdf
> > RK817 PMIC data sheet:
> > [2] http://rockchip.fr/RK817%20datasheet%20V1.01.pdf
> > RK818 PMIC data sheet:
> > [3] http://rockchip.fr/RK818%20datasheet%20V1.0.pdf
> >
> > Reboot issue:
> > My guess is that we need to some proper sequence of
> > setting to PMCI to perform clean.
> >
> > If you have any input please share them.
> >
> > Tested on SBC
> > Rock960 Model A
> > Odroid N1
> > Rock64
> >
> > -Anand Moon
> >
> > Anand Moon (8):
> >    mfd: rk808: Refactor shutdown functions
> >    mfd: rk808: use syscore for RK805 PMIC shutdown
> >    mfd: rk808: use syscore for RK808 PMIC shutdown
> >    mfd: rk808: use syscore for RK818 PMIC shutdown
> >    mfd: rk808: cleanup unused function pointer
> >    mfd: rk808: use common syscore for all PMCI for clean shutdown
> >    arm64: rockchip: drop unused field from rk8xx i2c node
> >    arm: rockchip: drop unused field from rk8xx i2c node
> >
> >   arch/arm/boot/dts/rk3036-kylin.dts            |   1 -
> >   arch/arm/boot/dts/rk3188-px3-evb.dts          |   1 -
> >   arch/arm/boot/dts/rk3288-evb-rk808.dts        |   1 -
> >   arch/arm/boot/dts/rk3288-phycore-som.dtsi     |   1 -
> >   arch/arm/boot/dts/rk3288-popmetal.dts         |   1 -
> >   arch/arm/boot/dts/rk3288-tinker.dtsi          |   1 -
> >   arch/arm/boot/dts/rk3288-veyron.dtsi          |   1 -
> >   arch/arm/boot/dts/rk3288-vyasa.dts            |   1 -
> >   arch/arm/boot/dts/rv1108-elgin-r1.dts         |   1 -
> >   arch/arm/boot/dts/rv1108-evb.dts              |   1 -
> >   arch/arm64/boot/dts/rockchip/px30-evb.dts     |   1 -
> >   arch/arm64/boot/dts/rockchip/rk3328-a1.dts    |   1 -
> >   arch/arm64/boot/dts/rockchip/rk3328-evb.dts   |   1 -
> >   .../arm64/boot/dts/rockchip/rk3328-roc-cc.dts |   1 -
> >   .../arm64/boot/dts/rockchip/rk3328-rock64.dts |   1 -
> >   .../boot/dts/rockchip/rk3368-geekbox.dts      |   1 -
> >   arch/arm64/boot/dts/rockchip/rk3368-lion.dtsi |   1 -
> >   .../boot/dts/rockchip/rk3368-px5-evb.dts      |   1 -
> >   .../boot/dts/rockchip/rk3399-firefly.dts      |   1 -
> >   .../boot/dts/rockchip/rk3399-hugsun-x99.dts   |   1 -
> >   .../boot/dts/rockchip/rk3399-khadas-edge.dtsi |   1 -
> >   .../boot/dts/rockchip/rk3399-leez-p710.dts    |   1 -
> >   .../boot/dts/rockchip/rk3399-nanopi4.dtsi     |   1 -
> >   .../boot/dts/rockchip/rk3399-orangepi.dts     |   1 -
> >   arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi |   1 -
> >   .../boot/dts/rockchip/rk3399-roc-pc.dtsi      |   1 -
> >   .../boot/dts/rockchip/rk3399-rock-pi-4.dts    |   1 -
> >   .../boot/dts/rockchip/rk3399-rock960.dtsi     |   1 -
> >   .../boot/dts/rockchip/rk3399-rockpro64.dts    |   1 -
> >   .../boot/dts/rockchip/rk3399-sapphire.dtsi    |   1 -
> >   drivers/mfd/rk808.c                           | 144 +++++-------------
> >   include/linux/mfd/rk808.h                     |   2 -
> >   32 files changed, 42 insertions(+), 134 deletions(-)
> >
>
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip
