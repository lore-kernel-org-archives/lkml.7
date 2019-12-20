Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2D88C3F68F
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 13:16:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6DD3218AC
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 13:16:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ioCYWik0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727384AbfLTNQb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 08:16:31 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:46664 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727269AbfLTNQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 08:16:30 -0500
Received: by mail-io1-f66.google.com with SMTP id t26so9317020ioi.13;
        Fri, 20 Dec 2019 05:16:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uHSX8g5E8trqkmNzyMnHt3mp/c48r8jhgT3X2UgyWzI=;
        b=ioCYWik0WpFyQsofOM8nBzkAXQbvEMoTINnXcGv1H+0nO7/Izv13bfXoV4kddHCXeE
         44jTYoThe1IMQ4RJRuNKc4RL+2LroxWN5iTUvv6yY8Co8H33HGckvVfsN4feWApufJ/n
         tpaf8nQ+EZJ3xNOAuDGPE2en+i1b/+KOx4BfYri0XQUN0pHCAWG958VOFSP+RYdDZR4o
         Bm4HglKZRzZqpzCi0jLr6jJx/mEpvzleHo57Uv5y4aqQsdpD+HS4ivKmxr4Tah5De3pD
         Yf+bUSjQEnmtDccSFz7m2/3vtm9HXvvzOnkkxXa/g1MrloQh8Rjkid3Lj3X8YjTl2M0P
         Zbcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uHSX8g5E8trqkmNzyMnHt3mp/c48r8jhgT3X2UgyWzI=;
        b=d9T3ONN8NyPeXLbTBeUpD05AP8vjtUJe9/YoSnskmed8IIc/8Ihwi29IQbWmSAu8Qr
         j4cYE6fGdPRpIBHW6GoT7uPdnoqGdv1pW/19ZQ2mUkxSOXZR/3M8TalUJ69bdlETVxx3
         Xg3B2Mef/XoJnEJba44yHLvwIVsTqyvLUm5Zs43Y7LhwKDpkHkJgPOJ6+5Eaeg5GFVNF
         METIoA9RQ4yoJbrj5kAFcCcFPfU30M9frnND6K8jmlPL+XbCCU+GF4JYrYfPrBrASFKk
         GWn4Zz/l5PeFonjGsX3MWGreqcTpAmaHzEk3epiQHADx4DTKoFv9s50aMtZRs5ucCxkv
         dSJw==
X-Gm-Message-State: APjAAAUPnm6Obq99u5h8NMbDz6eB+IPyqEl0A98fZt/L4e2ArLLmj/RX
        DpZwTU9Px5Bs0yXYhjh50zoZHKY5LdnHwCrU2VU=
X-Google-Smtp-Source: APXvYqwXKxA5lUxHZ3nZa0stb5w+I89G3O5m7/Ftqj0zT80tIBEUoniCu9OBsllsG/vNnRbcaKrGlNvSnbmvwJWazcI=
X-Received: by 2002:a5e:8505:: with SMTP id i5mr9526629ioj.158.1576847789624;
 Fri, 20 Dec 2019 05:16:29 -0800 (PST)
MIME-Version: 1.0
References: <20191213160542.15757-1-aford173@gmail.com> <20191213160542.15757-3-aford173@gmail.com>
 <20191219234100.GA19269@bogus>
In-Reply-To: <20191219234100.GA19269@bogus>
From:   Adam Ford <aford173@gmail.com>
Date:   Fri, 20 Dec 2019 07:16:18 -0600
Message-ID: <CAHCN7xJLH__Bx+YQFX6sQerkypTYYdJvUSjqbTUwv14RQj5iag@mail.gmail.com>
Subject: Re: [PATCH V2 2/7] soc: imx: gpcv2: Update imx8m-power.h to include
 iMX8M Mini
To:     Rob Herring <robh@kernel.org>
Cc:     arm-soc <linux-arm-kernel@lists.infradead.org>,
        Peng Fan <peng.fan@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 19, 2019 at 5:41 PM Rob Herring <robh@kernel.org> wrote:
>
> On Fri, Dec 13, 2019 at 10:05:37AM -0600, Adam Ford wrote:
> > In preparation for i.MX8M Mini support in the GPC driver, the
> > include file used by both the device tree and the source needs to
> > have the appropriate references for it.
> >
> > Signed-off-by: Adam Ford <aford173@gmail.com>
> > ---
> > V2:  No Change
> >
> >  include/dt-bindings/power/imx8m-power.h | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> >
> > diff --git a/include/dt-bindings/power/imx8m-power.h b/include/dt-bindings/power/imx8m-power.h
> > index 8a513bd9166e..0054bba744b8 100644
> > --- a/include/dt-bindings/power/imx8m-power.h
> > +++ b/include/dt-bindings/power/imx8m-power.h
> > @@ -18,4 +18,18 @@
> >  #define IMX8M_POWER_DOMAIN_MIPI_CSI2 9
> >  #define IMX8M_POWER_DOMAIN_PCIE2     10
> >
> > +#define IMX8MM_POWER_DOMAIN_MIPI     0
> > +#define IMX8MM_POWER_DOMAIN_PCIE     1
> > +#define IMX8MM_POWER_DOMAIN_USB_OTG1 2
> > +#define IMX8MM_POWER_DOMAIN_USB_OTG2 3
> > +#define IMX8MM_POWER_DOMAIN_DDR1     4
> > +#define IMX8MM_POWER_DOMAIN_GPU2D    5
> > +#define IMX8MM_POWER_DOMAIN_GPU      6
> > +#define IMX8MM_POWER_DOMAIN_VPU      7
> > +#define IMX8MM_POWER_DOMAIN_GPU3D    8
> > +#define IMX8MM_POWER_DOMAIN_DISP     9
> > +#define IMX8MM_POWER_VPU_G1          10
> > +#define IMX8MM_POWER_VPU_G2          11
> > +#define IMX8MM_POWER_VPU_H1          12
>
> Why is _DOMAIN missing from the last 3?

I will go back and review it.

adam
>
> > +
> >  #endif
> > --
> > 2.20.1
> >
