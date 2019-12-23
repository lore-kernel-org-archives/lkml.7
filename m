Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4777AC2D0D2
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 22:06:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CD1320709
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 22:06:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bywnbBQN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbfLWWGM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 17:06:12 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:41893 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726817AbfLWWGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 17:06:11 -0500
Received: by mail-lj1-f195.google.com with SMTP id h23so19087793ljc.8;
        Mon, 23 Dec 2019 14:06:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZoDTN0tAP4UxL3pRwsJo0kDQkgx7F0cKeDJGsDtJLqY=;
        b=bywnbBQNSXt35oFe163CE9RBzx1F3a5jgaRdbSalfAskaEaW6W/JkuGrUhHjcxQ+UE
         LQcshd1zb/ztbz8y6tzyN5HBCNeBQ2JptlRgk589Fnf1Nag+1AY6znwdB3xDoLCj7ZCD
         4AZVydbHYqEG5oRa7zzabl1UDTeD87lFqCdBsocPg918+9LvMN7PZSmOBx8hBEMDa2ln
         /+Uq9hcvwf+uD9huqFDpy3No7JoYuoObm6pNn98ehzz0NyhI53L3KImxnSR8kfNp64h9
         APFm+/US132gAv9gzG7RFeQ+4q03mUvv2pfV7CCCXsWknU6tuliTHaG7xv9Zj8jajiL6
         Em/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZoDTN0tAP4UxL3pRwsJo0kDQkgx7F0cKeDJGsDtJLqY=;
        b=pJplq2JY8d7zexNmFNyvz3/bA2Lz6oNxDVUoX0Ckw3kEVLTsFPAXvLGqh8hBZGAsWI
         NF3mUKbdNXFVC2QWZUAHGZ0TcuhvEyhKGjEd8ZJFMPyIp7a1UPSGIKoUOuu5rrPcnT7h
         YyP/v0M/F5FK2fj8KF8Owx83lEpvA5IOD8kuB9IXYjBjy60vM93Ar4+GjV1ZpSP5pVAO
         bQ7g+QlV9URXxyV5t0dcg03SpIb2lxudnu4FPuEBBiXGN5MJaG7kA3rLQ546zyp0Jtg0
         0VVmwMxqSHqtcDpoajKFmD+c/+fi/kZ5Cfm27rKH17cVFJHVXhnogKfDOlXiadYjSFAD
         f84g==
X-Gm-Message-State: APjAAAXDYOel0xAM/4kC8JhQkhTarBoOv6rTGILCix/A3dNi65/vQ02X
        5UhtYZLl8glBSe4PSGtz9C5gP6URfpF7Q1g4BtjIi2hvMzk=
X-Google-Smtp-Source: APXvYqwfG8lTEmVUklHua2nUo1PoQYbrA0O9crTZ1Q3KU3RzKuvPKZx2lfnBqjIdHMf5yhXOuidmIW8CzEyATzbg+Oo=
X-Received: by 2002:a2e:943:: with SMTP id 64mr7392159ljj.17.1577138769532;
 Mon, 23 Dec 2019 14:06:09 -0800 (PST)
MIME-Version: 1.0
References: <20191223214412.12259-1-rjones@gateworks.com> <20191223214412.12259-2-rjones@gateworks.com>
In-Reply-To: <20191223214412.12259-2-rjones@gateworks.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 23 Dec 2019 19:05:56 -0300
Message-ID: <CAOMZO5CLfyZjuz3c+Xr9v0D5h+r83PGgi8BrMnQZOOZSM-iGGw@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] ARM: dts: imx: Add GW5907 board support
To:     Robert Jones <rjones@gateworks.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Tim Harvey <tharvey@gateworks.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robert,

On Mon, Dec 23, 2019 at 6:44 PM Robert Jones <rjones@gateworks.com> wrote:
>
> The Gateworks GW5907 is an IMX6 SoC based single board computer with:
>  - IMX6Q or IMX6DL
>  - 32bit DDR3 DRAM
>  - FEC GbE Phy
>  - bi-color front-panel LED
>  - 256MB NAND boot device
>  - Gateworks System Controller (hwmon, pushbutton controller, EEPROM)
>  - Digital IO expander (pca9555)
>  - Joystick 12bit adc (ads1015)
>
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> Signed-off-by: Robert Jones <rjones@gateworks.com>

Not clear on the authorship on this patch.

If the original author is Tim, then his name should appear in the From field.

> ---
>  arch/arm/boot/dts/Makefile            |   2 +
>  arch/arm/boot/dts/imx6dl-gw5907.dts   |  14 ++
>  arch/arm/boot/dts/imx6q-gw5907.dts    |  14 ++
>  arch/arm/boot/dts/imx6qdl-gw5907.dtsi | 399 ++++++++++++++++++++++++++++++++++
>  4 files changed, 429 insertions(+)
>  create mode 100644 arch/arm/boot/dts/imx6dl-gw5907.dts
>  create mode 100644 arch/arm/boot/dts/imx6q-gw5907.dts
>  create mode 100644 arch/arm/boot/dts/imx6qdl-gw5907.dtsi
>
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 1e9e1af..9ee80e2 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -422,6 +422,7 @@ dtb-$(CONFIG_SOC_IMX6Q) += \
>         imx6dl-gw560x.dtb \
>         imx6dl-gw5903.dtb \
>         imx6dl-gw5904.dtb \
> +       imx6dl-gw5907.dtb \

You should add an additional patch that add these new boards in
Documentation/devicetree/bindings/arm/fsl.yaml
