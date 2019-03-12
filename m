Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBF89C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 00:10:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 932F92084F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 00:10:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GBtl+dsO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726575AbfCLAKb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 20:10:31 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:39312 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbfCLAKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 20:10:30 -0400
Received: by mail-lf1-f68.google.com with SMTP id m13so663624lfb.6;
        Mon, 11 Mar 2019 17:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tN4OeTt9O9XlDhfDeVSEzg0krBP4u/4HPI6dyvL0C9s=;
        b=GBtl+dsOSEq2REp62yEu+bTZXpEOvdI5S+OEPPoY5E2Sn9wGfy1ER8RMHwO8pL4PNM
         ebWY498leuAtM8QfjIl3HA8cjquzPGNY1yQ99FEy/xYJXV43XcNZ2uhHUK3gHzPhqf9n
         NB13jH0tqF1cp9mCv1eUbDsD2hvbv+wrwbJGDf7M8rQ97oK7yKu6zFBBEiUp/3CPu4HB
         Qk4+PuEVBNhZEefjcN90l+JLZpnIxDI1Krx5n5iPbGLhcESVTjJGKH0IEhuYSCWoC4mu
         EoV//aO1eehtMI9FjtT63KdyzOTgWCKg6SUz3asGI6NmP4dtuxoz/oDttG3GQzRUoIx+
         dgvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tN4OeTt9O9XlDhfDeVSEzg0krBP4u/4HPI6dyvL0C9s=;
        b=QeIJ7NZipnYJuZW4qUEevWxFm+ubpzPiG1MPYqGrawh1f8oAen7xmIMQjBkCHG0aJu
         dPWzJbvJcesf1zfoMEGqRXEfWtrSkyg2+a3kMPkvTjivcHdB3buAva+WeR3gY834GFDg
         nDs0cRgXivXm6ptYJcrlS19aYoKSk37C2RAwZM46RO/f+H4fqug68JKNMpVN0NJjXXzn
         /R8SEIV1ra3XBZsFX1rOWfYOFQ72hajVFCGcZaJbvEEFmmaUCtRkrReI/F6RTaTFdYY3
         /hifNkU+auJL1DhAtYHkkJvD2ugjLEIe0TzFoTTJkjMJuC3FWF+YY07CKnuf53Pg2Y4B
         u3wQ==
X-Gm-Message-State: APjAAAVl806+GO/vNfZO3nt4/rC64ptbovkQCrAJ5vAYJmDeFfzAzido
        doSaVqL7XJONhuQsMHZJ2JLcXCTNdKXHkIrI3xs=
X-Google-Smtp-Source: APXvYqyIndBsbePhvCAxr2cZeOCAbnuBDmRz8JcopBvb2PPBM+lxlYlJY0YrNMYrak/FOxnWgNr5Ub+5lo2y8S+r4KY=
X-Received: by 2002:ac2:5603:: with SMTP id v3mr19004873lfd.145.1552349428551;
 Mon, 11 Mar 2019 17:10:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190311234655.30357-1-angus@akkea.ca> <20190311234655.30357-3-angus@akkea.ca>
In-Reply-To: <20190311234655.30357-3-angus@akkea.ca>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 11 Mar 2019 21:10:38 -0300
Message-ID: <CAOMZO5BOFoLM-KP8BZrGBDXLUO=8DbUZ9DjVMwr4XTkji6Rbbw@mail.gmail.com>
Subject: Re: [PATCH 2/3] arm64: dts: fsl: Build the Librem5 devkit devicetree
To:     "Angus Ainslie (Purism)" <angus@akkea.ca>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Lucas Stach <l.stach@pengutronix.de>,
        Abel Vesa <abel.vesa@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        =?UTF-8?Q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2019 at 8:47 PM Angus Ainslie (Purism) <angus@akkea.ca> wrote:
>
> Compile the Librem5 devkit device tree
>
> Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
> ---
>  arch/arm64/boot/dts/freescale/Makefile | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
> index 13604e558dc1..95526ee3c27a 100644
> --- a/arch/arm64/boot/dts/freescale/Makefile
> +++ b/arch/arm64/boot/dts/freescale/Makefile
> @@ -22,3 +22,4 @@ dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-lx2160a-rdb.dtb
>
>  dtb-$(CONFIG_ARCH_MXC) += imx8mq-evk.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8qxp-mek.dtb
> +dtb-$(CONFIG_ARCH_MXC) += imx8mq-librem5-devkit.dtb

This should be part of the previous patch that adds the dts.
