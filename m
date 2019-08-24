Return-Path: <SRS0=py8C=WU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CFCAC3A5A2
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 02:23:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AC4221670
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 02:23:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lVEqWFw6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbfHXCXA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 22:23:00 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:35445 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726063AbfHXCW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 22:22:59 -0400
Received: by mail-io1-f66.google.com with SMTP id b10so15415805ioj.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2019 19:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NGSMDcjJGR/lxbJbfE5aNWOUlk38H0AtLy17bR4uyIE=;
        b=lVEqWFw60a4Z78tdeJFx8bcay1/2obbySui1sMdFVBfXHcgKpx3c7rSPBxka29TjRj
         kKdemlYYm1Lzn8YkZEVR3sFLamF69Ck4ne2HSR63Sm3wtF9QX7qi0FybeTyHDZWllcOt
         9olkCxKRKxC/WFDRrMStm0wffKbBnOsizhXt/7iaf1z7Xombt646BkIXK4waSGazKztD
         UNqTIUY7+mDTKgU/pgUKSSFZGCgshzDMYZMRjoGuexMsxVmpfx6L8YBqSo6G6kT1X7Kv
         ntUSabphSNwXSGVRGvlRt9s3rSk8vtwvw7/8HaUSQClH89NuR0jzkDtZhxfTW0ekNRY/
         Fs/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NGSMDcjJGR/lxbJbfE5aNWOUlk38H0AtLy17bR4uyIE=;
        b=nJFGZ6l6rCzhOJKw2dLCb+bMjG4Rl5rCHsTr+nH72XvL/I43FHo0wsJ6UQLhMoZMi8
         H/LlC3agQt2qy3U4/trP/dLKXQOXhzKBgOi3wDLSsnYZmjgkROGVPHg36z6bnloOcUj/
         Y+q7CD799QE1avonZ0F5y0PcySPyU+CB63IijyCqBB0zC4G1PTpHwzdgzYQXEbnI8x1E
         hmJxDACip2D86yI6MA+GrenkennzMVWaplDaN24G13fgxy7R8AOrmm1olrEdkKJbGf0p
         K8RueVQEiH/YOzvu0ctkl7V4PWhRhQSvw/l3Hg7grc7ZuTdflfFnRt5HySPVPFIpda+2
         QB9g==
X-Gm-Message-State: APjAAAWnv1Rm15x78pGDGXkpPSA3o9lRRoKZs17tcgLB26D2lZQRw2oe
        A66Gcx32FVx+h6a8lRzSjPZjcarGvw1d2Eqbqyw=
X-Google-Smtp-Source: APXvYqyQIS+kgykE1sTKO8zMu+2MUNM9kWz2yqg6PIfQIEfkX6L20qIXdmAnNPfbFL2O745HrdYDKv5zosTqwd5B/9U=
X-Received: by 2002:a5d:9714:: with SMTP id h20mr4704721iol.294.1566613378979;
 Fri, 23 Aug 2019 19:22:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190824002703.13902-1-andrew.smirnov@gmail.com>
In-Reply-To: <20190824002703.13902-1-andrew.smirnov@gmail.com>
From:   Chris Healy <cphealy@gmail.com>
Date:   Fri, 23 Aug 2019 19:22:47 -0700
Message-ID: <CAFXsbZqxoR491hT2oqNcH3YbO+C0=EsFYc_Wu+UVQMw5zqH4cw@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: vf610-zii-scu4-aib: Configure IRQ line for GPIO expander
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     linux ARM <linux-arm-kernel@lists.infradead.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Cory Tusar <cory.tusar@zii.aero>,
        Fabio Estevam <festevam@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 23, 2019 at 5:27 PM Andrey Smirnov <andrew.smirnov@gmail.com> wrote:
>
> Configure IRQ line for SX1503 GPIO expander. We already have
> appropriate pinmux entry and all that is missing is "interrupt-parent"
> and "interrupts" properties. Add them.
>
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Chris Healy <cphealy@gmail.com>
> Cc: Cory Tusar <cory.tusar@zii.aero>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  arch/arm/boot/dts/vf610-zii-scu4-aib.dts | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/arm/boot/dts/vf610-zii-scu4-aib.dts b/arch/arm/boot/dts/vf610-zii-scu4-aib.dts
> index e6c3621079e0..45a978defbdc 100644
> --- a/arch/arm/boot/dts/vf610-zii-scu4-aib.dts
> +++ b/arch/arm/boot/dts/vf610-zii-scu4-aib.dts
> @@ -570,6 +570,8 @@
>                 #gpio-cells = <2>;
>                 reg = <0x20>;
>                 gpio-controller;
> +               interrupt-parent = <&gpio1>;
> +               interrupts = <31 IRQ_TYPE_EDGE_FALLING>;
>         };
>
>         lm75@4e {
> --

Tested-by: Chris Healy <cphealy@gmail.com>
