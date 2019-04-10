Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72619C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 18:47:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 381742070D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 18:47:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n3YNKzuF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731913AbfDJSrs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 14:47:48 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:56072 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727223AbfDJSrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 14:47:47 -0400
Received: by mail-it1-f196.google.com with SMTP id y134so5208977itc.5
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 11:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KmeZIPQTPn+lqE41RAFN7IhbVAjjmUvq4wno4Mr9aKA=;
        b=n3YNKzuFsTz609VMBePA34i1+BTNDGUEAkNxtqrpGhuab4GGQOd7AUklkRnRTQqd3m
         cbJPCRlzzzXkB8jMp93rLjc4itoj7012uYKHuEPV+oS/C8cz1Oe29vsl/OsAyisvfI61
         4P1gAMfXU+ElgYgV/CdiOsTuXdrT4Dv7sZJ0suH4Pt1VAdTCgCXLVsH6ok+Pcdywc9lP
         HA4J5ViqOW3vUzl1ndPbSV3AEC0P+pWwBnRoeCS4o2RrQotk1q49tFn0Wuc4bYx8HiEM
         cusmy4UAhoDbzU5DEZ8tVvozjQZR7J1Wbr68IgczRwUwtK6X1gklukNBzk1SaAeYqUXt
         EQDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KmeZIPQTPn+lqE41RAFN7IhbVAjjmUvq4wno4Mr9aKA=;
        b=Qu2r1203HChSXKtJaVXPxBjH4eoggBTwrNgQh4IwDw3qrdpMHJNCromWbAEOHdQWcp
         gLYOtEz1q5akIG73EUtU85QCoeQkcPMfU6V7frLCM8/VodYdaw+JEbBI+u2UmRAhT3c/
         aiyQIGiFlQdeeuWsqHjEDWmxPCACWN6iq8HAkYlcWwiRg6WWNdHXfniaYl0KOujBw7kw
         h6fh81P/gwPOn/5MEA9M2Mt8GIItHI3v/1xLvhP45DgFWddRx4MnoBoQj1xoM9TYt2Ty
         KuYL7Lenwf6GY2FGjzjS2wP0EIPMi7aDMokCporzeGyLjgHy/h0/6H5FyXdHd0i+kB5o
         vq4g==
X-Gm-Message-State: APjAAAXFgPbMQPdsrIhlftTi3WB6hbrruf+cNgWFjkQHA24WR7E90zc4
        MCit+Hrh1/q40CczH8LfJ+bgLR646LkDzK8PSa4=
X-Google-Smtp-Source: APXvYqy0rldCp9ePVYzACHdMGzl2vc6hxUan8+cCSSjsoqPGrEYCZFvZc+VRE8nLweK15+xlBOYdKxFKRF2qw+bsiQY=
X-Received: by 2002:a24:b70b:: with SMTP id h11mr4424385itf.98.1554922066561;
 Wed, 10 Apr 2019 11:47:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190329064924.8728-1-andrew.smirnov@gmail.com>
In-Reply-To: <20190329064924.8728-1-andrew.smirnov@gmail.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Wed, 10 Apr 2019 13:47:34 -0500
Message-ID: <CAHCN7xLKNO3+2pY4-S7=yPnxOF3mDCjTOUi4jVHufkhZuJNzAg@mail.gmail.com>
Subject: Re: [PATCH v3 1/9] ARM: dts: imx6qdl: Specify IMX6QDL_CLK_IPG as
 "ipg" clock to SDMA
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     Shawn Guo <shawnguo@kernel.org>, Angus Ainslie <angus@akkea.ca>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chris Healy <cphealy@gmail.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 29, 2019 at 1:49 AM Andrey Smirnov <andrew.smirnov@gmail.com> wrote:
>
> Since 25aaa75df1e6 SDMA driver uses clock rates of "ipg" and "ahb"
> clock to determine if it needs to configure the IP block as operating
> at 1:1 or 1:2 clock ratio (ACR bit in SDMAARM_CONFIG). Specifying both
> clocks as IMX6QDL_CLK_SDMA results in driver incorrectly thinking that
> ratio is 1:1 which results in broken SDMA funtionality(this at least
> breaks RAVE SP serdev driver on RDU2). Fix the code to specify
> IMX6QDL_CLK_IPG as "ipg" clock for SDMA, to avoid detecting incorrect
> clock ratio.
>
Thank you for this!  I the 5.1 kernel is the first revision to include
the i.MX6 kit from Logic PD and I thought I messed something up, so I
was off in a completely different direction trying to figure out why
it was broken.  With your patch, my board works again!

> Fixes: 25aaa75df1e6 ("dmaengine: imx-sdma: add clock ratio 1:1 check")
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

Tested-by: Adam Ford <aford173@gmail.com> #imx6q-logicpd

> Cc: Angus Ainslie (Purism) <angus@akkea.ca>
> Cc: Chris Healy <cphealy@gmail.com>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  arch/arm/boot/dts/imx6qdl.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
> index 9f9aa6e7ed0e..354feba077b2 100644
> --- a/arch/arm/boot/dts/imx6qdl.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl.dtsi
> @@ -949,7 +949,7 @@
>                                 compatible = "fsl,imx6q-sdma", "fsl,imx35-sdma";
>                                 reg = <0x020ec000 0x4000>;
>                                 interrupts = <0 2 IRQ_TYPE_LEVEL_HIGH>;
> -                               clocks = <&clks IMX6QDL_CLK_SDMA>,
> +                               clocks = <&clks IMX6QDL_CLK_IPG>,
>                                          <&clks IMX6QDL_CLK_SDMA>;
>                                 clock-names = "ipg", "ahb";
>                                 #dma-cells = <3>;
> --
> 2.20.1
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
