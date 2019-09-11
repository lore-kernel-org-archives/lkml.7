Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5E30ECDE27
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 09:17:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCDBC2087E
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 09:17:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F7q/rlCV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727416AbfIKJRg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 05:17:36 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37485 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726930AbfIKJRe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 05:17:34 -0400
Received: by mail-wr1-f65.google.com with SMTP id i1so23049760wro.4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2019 02:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=CvSWNGsfSG1sshb9s1EDdJReSoxTISoAGD+1pfVDxyc=;
        b=F7q/rlCVfShEWRlTFaXZoWsn7ac1oQJJyQuElIuIsdCUY73256m3uxItJ4dxeLme/e
         btftQ3Yxe1a2Z8qIWTg50DgpkXymF/RAKCfeQrPFunaUhp6aOzxr8GIPSMCeguLIv5Yy
         QT8K1ALdIXrZyAyYM3dX55uiMzgNVBSUQ1shR4mFLfYqMZAPbSlIoKAj3IrYhtpinEvx
         MHzGfx5nf/mmLUYWEkXAmd3hHcFD5mO6TVantjHMklWNizc8xI12U3bZpkMyWNgu2hbm
         k9DqNqVfJutzS8OG2XbE4aRAGB7IR7eKLql3rojiURJHcXngyvzrs8qN0OWpboBS6vcd
         9g5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=CvSWNGsfSG1sshb9s1EDdJReSoxTISoAGD+1pfVDxyc=;
        b=tHqc5I1UTh1V7hGXFYWVWlfHp62T2PaSUhb3G1NmvIxBZ9KVKma3/Wln3dSl7K2jQt
         TpnJs6dI3Rrq33+qdLVO7g2RLZoiL46CqsLSEWGsHFi/9Lbtrx7WF/BTn/Of3lrUTxFz
         0lIG1xgf3jS73Rg/VvzKEfmtBycOOi+1a1HH03OVurVWzAOv6wJFLy6aFPdD8vxFbcSr
         6izbQXdSqjJAQHKT07o9bMcLNStkN2veHC9kAuG8jwi9YDvVHB3aSYU0RN00pCgcjRGO
         8V3DtE1L/lp1jBCuH0w4XFMKUZUdmjEzui+IPae4h7AJ4phrvd1ipsjtaRZ/J+0VcF/1
         0b+w==
X-Gm-Message-State: APjAAAUwt/1x8bsRPvTW33JFNh7TqTmh/nqsuOrqjMHIPUCC4njPALz2
        IFtq2W4sCv0Vd8YY5loLGKCLOExTzT8cAw==
X-Google-Smtp-Source: APXvYqxRMwsayDYeAxgwWdYFhf0lJ7v5s5sqVxMyGnluLJElV52fQ9ESHXB/Xyu87A+TkMV/wNA4KQ==
X-Received: by 2002:adf:e388:: with SMTP id e8mr1342609wrm.306.1568193451950;
        Wed, 11 Sep 2019 02:17:31 -0700 (PDT)
Received: from linaro.org ([148.69.85.38])
        by smtp.gmail.com with ESMTPSA id v7sm17985808wru.87.2019.09.11.02.17.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Sep 2019 02:17:31 -0700 (PDT)
Date:   Wed, 11 Sep 2019 11:17:28 +0200
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>, Jun Li <jun.li@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH 1/2] arm64: dts: imx8mm: Remove incorrect fallback
 compatible for ocotp
Message-ID: <20190911091728.GA10331@linaro.org>
References: <1568211887-19318-1-git-send-email-Anson.Huang@nxp.com>
 <749f8dc6-dbf9-127c-9924-33432b8af00a@linaro.org>
 <DB3PR0402MB3916E0F566E35DD30275A8E9F5B10@DB3PR0402MB3916.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DB3PR0402MB3916E0F566E35DD30275A8E9F5B10@DB3PR0402MB3916.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 11, 2019 at 09:05:49AM +0000, Anson Huang wrote:
> Hi, Daniel
> 
> > On 11/09/2019 16:24, Anson Huang wrote:
> > > Compared to i.MX7D, i.MX8MM has different ocotp layout, so it should
> > > NOT use "fsl,imx7d-ocotp" as ocotp's fallback compatible, remove it.
> > >
> > > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> > > ---
> > >  arch/arm64/boot/dts/freescale/imx8mm.dtsi | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> > > b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> > > index 5f9d0da..7c4dcce 100644
> > > --- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> > > +++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> > > @@ -426,7 +426,7 @@
> > >  			};
> > >
> > >  			ocotp: ocotp-ctrl@30350000 {
> > > -				compatible = "fsl,imx8mm-ocotp", "fsl,imx7d-
> > ocotp", "syscon";
> > > +				compatible = "fsl,imx8mm-ocotp", "syscon";
> > >  				reg = <0x30350000 0x10000>;
> > >  				clocks = <&clk IMX8MM_CLK_OCOTP_ROOT>;
> > >  				/* For nvmem subnodes */
> > 
> > Why not fold the two patches?
> 
> For i.MX8MM, it just removes the incorrect fallback compatible, for i.MX8MN, it needs
> to replace the incorrect fallback compatible in order to support SoC UID read, so I think
> this should be 2 separate patch?

Oh, yes, there is a subtle difference in the file name :) m|n. I understand
now why you splitted it.


-- 

 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
