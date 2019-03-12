Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 134F2C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 06:24:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D15A1214AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 06:24:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EgCxl3hO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727024AbfCLGYO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 02:24:14 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:46619 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbfCLGYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 02:24:13 -0400
Received: by mail-ed1-f66.google.com with SMTP id n17so1225973edt.13;
        Mon, 11 Mar 2019 23:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S0j6G0dAnj1Zop/kD2wTxZhM6eri9WTR09RdMrlO02E=;
        b=EgCxl3hO2IYMzBqVD7ezanKa4EBJWWFmBYEHwkhxuLibf6s73dL+/oj8FSOzGbjHV0
         Pq1RC5p+0c4JxPd10T7Aw50KKh0R10RWPbT0Rh9yDstkOnNf8JS67ryclj8kwJMiGWY0
         2cJPPDz8W7/OPbGwklLnOeVh0dDXEzlQuKT/se/UdL+wixUtw8QXwXGw6ZxTpz6sV+e9
         6APFfTj/Gy1mk6b5j+0FDMvijkW20uhpNe9o1HwtexDae/GI5/nOhFcDysN+8CHErbkI
         ZpiYESLITr9N+3yul10WDkj8chcPD3oM6osyljJb3DzXY11huXKrOCpDTTBuBYbS9QXr
         9a4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S0j6G0dAnj1Zop/kD2wTxZhM6eri9WTR09RdMrlO02E=;
        b=aUtBFW909I2Gi4NZBEBXNrwxz48WWwYKGaJnxfOfUvlPgffythmhDDGh+TmsOBd1Sp
         y/JfYHWAQOZfcL749tPBbVjhBRnQxIuap7ureZHx+MJINyhlVBeoMHbbboEby5aLaJAk
         CZJAZcNQTHV4P2gLh2nDTOsdwoixHXLI7stzfXg8HiEGPtjbSnbYRgpf+6RF5diZFTRU
         WtDHNQ9RQ//xpXRouCjpCAoTQ7UjOO7TbXku6QGL6RAPoKE404pBs9t03D8nrxLBxiMd
         +4z2MP43sMl/XZKh80Jy7Bj4tFAWtjJLDWqRvdDQf1HVWE7Zbhq47WkG/WJ+OqznMUkJ
         Elmw==
X-Gm-Message-State: APjAAAVZIZz8v0lz2ftBWmKHcjFkLqLWguKCMnBwV9EYTjjfAalzgicV
        P4veUFPTx3ueIMMzZRQtoAnYAaANX1ZoP9iLkCQ=
X-Google-Smtp-Source: APXvYqwR9WL+bvNpHbfvlW3/XQ9Uo+fFCW8RzlJmAdVCCOxhFIHqccORPFvU6i9BW7ibwWpFA3epm2Yxcep/uBLqpuo=
X-Received: by 2002:a17:906:90da:: with SMTP id v26mr24826995ejw.146.1552371851955;
 Mon, 11 Mar 2019 23:24:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190311234655.30357-1-angus@akkea.ca> <20190311234655.30357-3-angus@akkea.ca>
In-Reply-To: <20190311234655.30357-3-angus@akkea.ca>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Tue, 12 Mar 2019 08:24:00 +0200
Message-ID: <CAEnQRZDhvmWCjWXU_P66OTL2QngM8MKxDmAq1nTSZ8HK2Gm2AQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] arm64: dts: fsl: Build the Librem5 devkit devicetree
To:     "Angus Ainslie (Purism)" <angus@akkea.ca>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Lucas Stach <l.stach@pengutronix.de>,
        Abel Vesa <abel.vesa@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>, agx@sigxcpu.org,
        dl-linux-imx <linux-imx@nxp.com>,
        Devicetree List <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 12, 2019 at 1:48 AM Angus Ainslie (Purism) <angus@akkea.ca> wrote:
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
This should be in alphabetical order. So move this immediately
after imx8mq-evk.dtb

> --
> 2.17.1
>
