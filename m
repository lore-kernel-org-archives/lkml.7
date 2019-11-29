Return-Path: <SRS0=nTU8=ZV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 023CDC43215
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 09:26:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D65FB21774
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 09:26:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbfK2J04 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Nov 2019 04:26:56 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:41356 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726143AbfK2J0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 04:26:55 -0500
Received: by mail-ed1-f66.google.com with SMTP id n24so3826441edo.8;
        Fri, 29 Nov 2019 01:26:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=61Qn8sc6UymCs2JwYwR9E7PQUQwsg86yGcxrakyfLnc=;
        b=tKotwCZB1OIyoWhF3qvKTQ0hh+PK+vJ242n4RXT+4dTLsxyyo8UBX7olemY6onxpuy
         IpimaWFhbSpL9TZU8bZ/b0lXCCJFXv3ut8dhg/R0c9WqnP+g2cawIMj8lZWlwUo6RC3T
         z+Hbf29JRKIsuXk7iRoI+V2qUUu80krKqm0X8cdGYD4BK6QCJH+Oe1LB8HsqEM+ag3o0
         zj9ES8+oTgq+u7YgHSF3gBz/HrdKgpGv9HzXp211MMrOp1yr8IbjwSN7m6J1MZs3iRuJ
         sjAJ/pzpX1DYbURuTyVnikovhmBeq0PLHqlwDT6SYeuulHdcctXNSY2wbj8ToVwYpJ2g
         uraQ==
X-Gm-Message-State: APjAAAX/HFaAZod872BKftOB6Xj70BOKeZZd9Og5oubUklfiVDKPZ6re
        SHz2iYbToTG1ZUx2QDMTJi3S+Tp2kXk=
X-Google-Smtp-Source: APXvYqxxU2OcafQ4X++3xe7l/4gBufnuLKpfQ4uJVFQqfkICOAryrt5kfMoT0vf0z3VhTRnlgRa8sQ==
X-Received: by 2002:a50:fc96:: with SMTP id f22mr44140890edq.119.1575019613340;
        Fri, 29 Nov 2019 01:26:53 -0800 (PST)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com. [209.85.221.51])
        by smtp.gmail.com with ESMTPSA id o30sm1273065edc.61.2019.11.29.01.26.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Nov 2019 01:26:52 -0800 (PST)
Received: by mail-wr1-f51.google.com with SMTP id c14so9622216wrn.7;
        Fri, 29 Nov 2019 01:26:52 -0800 (PST)
X-Received: by 2002:a05:6000:11c6:: with SMTP id i6mr2960888wrx.178.1575019612588;
 Fri, 29 Nov 2019 01:26:52 -0800 (PST)
MIME-Version: 1.0
References: <20191129091336.13104-1-stefan@olimex.com> <20191129091336.13104-2-stefan@olimex.com>
In-Reply-To: <20191129091336.13104-2-stefan@olimex.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Fri, 29 Nov 2019 17:26:39 +0800
X-Gmail-Original-Message-ID: <CAGb2v64oCx90LQScKTiHVyHLd6c7Rgs_g5L79Yr1J8kgS8-Kyg@mail.gmail.com>
Message-ID: <CAGb2v64oCx90LQScKTiHVyHLd6c7Rgs_g5L79Yr1J8kgS8-Kyg@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH 1/3] arm64: dts: allwinner: a64: olinuxino:
 Fix eMMC supply regulator
To:     Stefan Mavrodiev <stefan@olimex.com>
Cc:     Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "moderated list:ARM/Allwinner sunXi SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 29, 2019 at 5:14 PM Stefan Mavrodiev <stefan@olimex.com> wrote:
>
> A64-OLinuXino-eMMC uses 1.8V for eMMC supply. This is done via a triple
> jumper, which sets VCC-PL to either 1.8V or 3.3V. This setting is different
> for boards with and without eMMC.
>
> This is not a big issue for DDR52 mode, however the eMMC will not work in
> HS200/HS400, since these modes explicitly requires 1.8V.
>
> Signed-off-by: Stefan Mavrodiev <stefan@olimex.com>
> ---
>  arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino-emmc.dts | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino-emmc.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino-emmc.dts
> index 96ab0227e82d..7d135decbd53 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino-emmc.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino-emmc.dts
> @@ -14,8 +14,8 @@
>  &mmc2 {
>         pinctrl-names = "default";
>         pinctrl-0 = <&mmc2_pins>;
> -       vmmc-supply = <&reg_dcdc1>;
> -       vqmmc-supply = <&reg_dcdc1>;
> +       vmmc-supply = <&reg_eldo1>;

If I'm reading the schematics correctly, VCC on the eMMC is from 3.3V.
This corresponds to the vmmc-supply property. So you shouldn't change it.

> +       vqmmc-supply = <&reg_eldo1>;

vqmmc-supply is from the VCC-PC rail, which is the one you say is triple-
jumpered. So this change makes sense.

ChenYu
