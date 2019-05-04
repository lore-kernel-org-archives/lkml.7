Return-Path: <SRS0=6aFo=TE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 186DBC43219
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 11:04:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D03DF20862
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 11:03:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q97G8pZi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727282AbfEDLD6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 May 2019 07:03:58 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:38293 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbfEDLD6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 May 2019 07:03:58 -0400
Received: by mail-lj1-f194.google.com with SMTP id e18so7299445lja.5;
        Sat, 04 May 2019 04:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=BiywJZA9r6kxv/OyDdQ+nsf3ks4JUNhEjjCyaz/iKGE=;
        b=Q97G8pZiOy62ZVDNe0KVvckArrkMdxecNMK4C/6pgUuK8qH7i5kTR0Xp9u0nXvwy7h
         ieRz1pH9APKGOrspbwKDycEg93+6W263uNuzYcBeJQYleT8EaeL6QY6XR/yIrk+xtufz
         C6371n8NrtHYFPe6DHKMlYBxBa1EXFXF5t3V276WQnuPj9AFY5iwuk7lSd8RMNRHtAau
         XMzujU6b0I2dH/9Qdfs9Te1PrrHwdrUEIrc0lpC7nPuqmC8A/QxsznKfCrqNVO0iWXQ5
         8Qm1DP/ACg/HV3uBVnYP5tyRc0+y7isFYLES++OZ0zSPeZN0GeWiwiXuoMQX/Cifce8V
         qWJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=BiywJZA9r6kxv/OyDdQ+nsf3ks4JUNhEjjCyaz/iKGE=;
        b=We1011AvdsidE1gxliuTsal6ZnL1SLQzMNvQNUdCA77csaSurqw1ift8VpdtDEJMB+
         oZsIXk1Dy5Jn6DN0zL4VpI9ANn+IGVnN4LFEYHYVmEaq0C2iU5iYRmLLfY64mOHvlBWw
         LT7rTGSbgXOLAkE0p3v5PXiJCArr4ePJUdhyrihwUqwM0uGvWOJOC7a+UKLhh0mTBSQe
         PYo2PF8MlR1mgxolRUgn56657K9ljYI29Qn5hZlUXajnDoAjDE0OeflBFmxgXrByJwU4
         tn+cc5mvmuWX/bkVUzqMcBLcmewGsP3qptV7xZ6oF4gl2x8Ux1cgHrWdgJxrHL1HioAA
         K47w==
X-Gm-Message-State: APjAAAWvPd9VhqcdS1T4m9RpY8N+m3I2hXykGt5juI5+gP6uBgXt11VK
        0ZyQ82KZ/8BhtaeULu5Q/tnKAIOYqfGYqyrm7kM=
X-Google-Smtp-Source: APXvYqxAdM8lMj0YVduKkje1fAP2BJHG25g2COytac2Z1uIxoAVV6UQJjuekl53q0zv8YxsZvrYsyKGgLHP7ZDgHWOA=
X-Received: by 2002:a2e:9188:: with SMTP id f8mr5201827ljg.100.1556967835818;
 Sat, 04 May 2019 04:03:55 -0700 (PDT)
MIME-Version: 1.0
References: <1556190530-19541-1-git-send-email-liuk@cetca.net.cn>
In-Reply-To: <1556190530-19541-1-git-send-email-liuk@cetca.net.cn>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Sat, 4 May 2019 08:03:55 -0300
Message-ID: <CAOMZO5BbA6oq8okTR-r800k4XY76XxxEdufd1mjcV6HdTpVotA@mail.gmail.com>
Subject: Re: [PATCHv2 1/2] ARM: dts: imx6sx: Use MX6SX_CLK_ENET for fec 'ahb' clock
To:     Kay-Liu <liuk@cetca.net.cn>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kay-Liu,

On Thu, Apr 25, 2019 at 8:09 AM <liuk@cetca.net.cn> wrote:
>
> From: Kay-Liu <liuk@cetca.net.cn>
>
> The imx6sx's dts file defines five clocks for fec, the
> 'ahb'clock's value is IMX6SX_CLK_ENET_AHB, but in the
> i.MX6SX Reference Manual there is no such enet ahb clock,
> there is only one "enet clock" in the CCM_CCGR3 register
> which is controlled by bits 5-4, the enet clock is defined
> for the 'ipg' clock, this can cause problem.
> The original phenomenon is using imx6-solox processor and
> Marvel 88E6390 switch with linux OS, the kernel will hang
> during the startup of the linux OS.
> After analyzing the phenomenon, the reason of CPU hang is
> read/write enet module's register when the enet clock
> is disabled. The kernel code try to avoids the problem
> by resume enet clock before read/write enet register.
> But the enet module's clock config will cause a special
> environment which can bypass the clock resume mechanism.
> The CPU has only one enet clock, after kernel parses
> the dts file, the two clock variables 'ipg' and 'ahb'
> finnaly point to the same enet clock register. This will
> cause enet clock be disabled after fec probe over.
> Because the power saving module will affect the BUG, so
> there are two situations for this problem:
> 1)Turn off power saving
> Turn off power saving means that the resume mechanism is
> disabled, so after fec probe over if any one read/write
> enet module's register, the CPU will hang because no one
> could resume the enet clock.
> 2)Turn on power saving
> Turn on power saving could resume enet clock before
> read/write enet register by enable 'ipg' clk, this will
> cause 'ahb' variable state and enet clock register value
> don't match.If any task read/write enet at a high
> frequently, the kernel will keep resume state and never
> enter suspend process, this means that the kernel will
> only modifies the register value during the first resume.
> But the kernel init will check unused clock variable in
> the late initcall, the 'ahb' clock will be treated as
> unused, at this time, the enet clock will be disabled
> bypass the resume mechanism, then the next read/write
> enet module's register will cause the CPU hang.
> Proposed solution is delete the 'ahb' clock's definition
> in the clk-imx6sx.c, and modify fec device=E2=80=99s clocks in
> the dts file, point =E2=80=98ahb=E2=80=99 from IMX6SX_CLK_ENET_AHB to
> IMX6SX_CLK_ENET
>
> Signed-off-by: Kay-Liu <liuk@cetca.net.cn>
> ---
> Change since v1:
> -inproved commit log description
> -add platform related clock change instead of describe is in the external=
 URL
>
>  arch/arm/boot/dts/imx6sx.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dts=
i
> index 5b16e65..b8b23a6 100644
> --- a/arch/arm/boot/dts/imx6sx.dtsi
> +++ b/arch/arm/boot/dts/imx6sx.dtsi
> @@ -919,7 +919,7 @@
>                                 interrupts =3D <GIC_SPI 118 IRQ_TYPE_LEVE=
L_HIGH>,
>                                              <GIC_SPI 119 IRQ_TYPE_LEVEL_=
HIGH>;
>                                 clocks =3D <&clks IMX6SX_CLK_ENET>,
> -                                        <&clks IMX6SX_CLK_ENET_AHB>,
> +                                        <&clks IMX6SX_CLK_ENET>,

Yes, there is really no IMX6SX_CLK_ENET_AHB as per the Refernce Manual
and it is the same we do on imx6qdl.dtsi:

Reviewed-by: Fabio Estevam <festevam@gmail.com>
