Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C88D9CA9EC4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 13:15:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D9182087F
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 13:15:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hZjxpuAg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388258AbfJ2NPb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 09:15:31 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44586 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732534AbfJ2NPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 09:15:31 -0400
Received: by mail-lj1-f196.google.com with SMTP id c4so15200769lja.11;
        Tue, 29 Oct 2019 06:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rQbCwQn4OcCXCHFwwmFatk+l/n8S/B77Id3xHHz9OsQ=;
        b=hZjxpuAgz7brG/rgG0uL289gCvd0Rg+88SXtx9mT7soxurM5WbTxvC1hQ/lW/drlyR
         wXm8QSuoxTtFS380W5cBhc+CWa6zdNldQWI5Z7iYoXnhFcTkJJoSWA/mUpPSTN9nILM2
         o0hdPoyUu2RlEnrDpVfatezm1YRMLbsCb2kQZx1vd6xmo/sjU9ffvr+4tGMLGX1iBbgN
         HjA33qGO4LaEfelPQxH0Qtm8nbxY2owSG3UliwWk9PLtpSyTCg70RiaotxwE5P/tTNNL
         4/+BJck94WL0BsUuYjAzgaFG74yvXqKueQivrG3a/z+li8SYPnjsU+XJBvnrsz7rCPPp
         xfZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rQbCwQn4OcCXCHFwwmFatk+l/n8S/B77Id3xHHz9OsQ=;
        b=te4TVB5WNIjt1p5mD9DUQAIapDQueXDRZeVO0wmwFIRSoX4cOCCkLXNbe6fhlfULiW
         FBDqUFFQSidDmxT3DjI6zyxmiVrgLTr1Wp1L0Fi/s6uTumjcc476mXAdF0i7TFO8iX6e
         +kXeds1CU2XJ8CdiYWnRB5W9Gp1W4cxpub2UoWqCAuCY4uJzxWsW65fPzuCTnVVcxbjt
         hvJxDbSmTlxjF+/4HaQVI5FKtwIyva5yMP9XyBYcEJCgmGkubx3l6gsIRu+srmpgTLrQ
         rp4PIjwYJWNCD3pGDEbkofcs/73J/RzabYn74/HWwLzGgRJlcebWe7jU3LrPj/pxsTTs
         4cIw==
X-Gm-Message-State: APjAAAUQzQ1ouEfbMs02TXOwdnd3zUfnQrct9VZSV+Otmez35kE5slQr
        itbPTBSvMDbstwyZLGWOjUR4sV2LItN1mymI6EA=
X-Google-Smtp-Source: APXvYqyAwsBC9wzuv9VJycNb0BcgLvYOqtu9D89Ede9Rm7uVYGbmJDn/HV4nb+IlolpfBAIr7w5KPoyDEC0kHOBnxgk=
X-Received: by 2002:a2e:819a:: with SMTP id e26mr2713781ljg.26.1572354929138;
 Tue, 29 Oct 2019 06:15:29 -0700 (PDT)
MIME-Version: 1.0
References: <1572343372-6303-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1572343372-6303-1-git-send-email-Anson.Huang@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 29 Oct 2019 10:15:31 -0300
Message-ID: <CAOMZO5CnBCbM2uhDpgUgRVXkVsPTDw27CxZUp3+FMZi+7DH1XQ@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: imx7ulp-evk: Use APLL_PFD1 as usdhc's clock source
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        NXP Linux Team <Linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anson,

On Tue, Oct 29, 2019 at 7:06 AM Anson Huang <Anson.Huang@nxp.com> wrote:
>
> i.MX7ULP does NOT support runtime switching clock source for PCC,
> APLL_PFD1 by default is usdhc's clock source, so just use it
> in kernel to avoid below kernel dump during kernel boot up and
> make sure kernel can boot up with SD root file-system.
>
> [    3.035892] Loading compiled-in X.509 certificates
> [    3.136301] sdhci-esdhc-imx 40370000.mmc: Got CD GPIO
> [    3.242886] mmc0: Reset 0x1 never completed.
> [    3.247190] mmc0: sdhci: ============ SDHCI REGISTER DUMP ===========
> [    3.253751] mmc0: sdhci: Sys addr:  0x00000000 | Version:  0x00000002
> [    3.260218] mmc0: sdhci: Blk size:  0x00000200 | Blk cnt:  0x00000001
> [    3.266775] mmc0: sdhci: Argument:  0x00009a64 | Trn mode: 0x00000000
> [    3.273333] mmc0: sdhci: Present:   0x00088088 | Host ctl: 0x00000002
> [    3.279794] mmc0: sdhci: Power:     0x00000000 | Blk gap:  0x00000080
> [    3.286350] mmc0: sdhci: Wake-up:   0x00000008 | Clock:    0x0000007f
> [    3.292901] mmc0: sdhci: Timeout:   0x0000008c | Int stat: 0x00000000
> [    3.299364] mmc0: sdhci: Int enab:  0x007f010b | Sig enab: 0x00000000
> [    3.305918] mmc0: sdhci: ACmd stat: 0x00000000 | Slot int: 0x00008402
> [    3.312471] mmc0: sdhci: Caps:      0x07eb0000 | Caps_1:   0x0000b400
> [    3.318934] mmc0: sdhci: Cmd:       0x0000113a | Max curr: 0x00ffffff
> [    3.325488] mmc0: sdhci: Resp[0]:   0x00000900 | Resp[1]:  0x0039b37f
> [    3.332040] mmc0: sdhci: Resp[2]:   0x325b5900 | Resp[3]:  0x00400e00
> [    3.338501] mmc0: sdhci: Host ctl2: 0x00000000
> [    3.343051] mmc0: sdhci: ============================================
>
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Thanks, with this patch applied I can get SD card rootfs to get mounted:

Tested-by: Fabio Estevam <festevam@gmail.com>

I think this fix deserves a Fixes tag so that it can be backported to
older kernels.
