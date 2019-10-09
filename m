Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A37BDECE58E
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 06:05:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BDE420679
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 06:05:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="PeJGKH/z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728839AbfJIGFX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 02:05:23 -0400
Received: from onstation.org ([52.200.56.107]:50062 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726651AbfJIGFW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 02:05:22 -0400
Received: from localhost (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id 3A03A3E996;
        Wed,  9 Oct 2019 06:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=onstation.org;
        s=default; t=1570601122;
        bh=axje7sL3QyYCSKa+ojdsfnQjsAnMmmRKJzoEmQLtvCs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PeJGKH/zxhgEi7hoksppuXNSbE7Ofwy1/81LxzfdzpBr52IAUIdv6MC8U6uglf8hP
         ZTGzVZuRgoCOgfBJaW+QiPEPCF0QLcXgrYPIGbppfHUr5VVcHFqiwxR8h637DHUG3X
         Ry0LDIc+l/e4q6Xoow9Tj5U/2v4bmjAKZUJpozLo=
Date:   Wed, 9 Oct 2019 02:05:20 -0400
From:   Brian Masney <masneyb@onstation.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     robdclark@gmail.com, sean@poorly.run, bjorn.andersson@linaro.org,
        a.hajda@samsung.com, Laurent.pinchart@ideasonboard.com,
        airlied@linux.ie, daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, jonathan@marek.ca,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH RFC v2 4/5] ARM: dts: qcom: msm8974: add HDMI nodes
Message-ID: <20191009060520.GA14506@onstation.org>
References: <20191007014509.25180-1-masneyb@onstation.org>
 <20191007014509.25180-5-masneyb@onstation.org>
 <20191009022131.604B52070B@mail.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191009022131.604B52070B@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 08, 2019 at 07:21:30PM -0700, Stephen Boyd wrote:
> Quoting Brian Masney (2019-10-06 18:45:08)
> > diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom-msm8974.dtsi
> > index 7fc23e422cc5..af02eace14e2 100644
> > --- a/arch/arm/boot/dts/qcom-msm8974.dtsi
> > +++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
> > @@ -1335,6 +1342,77 @@
> >                                 clocks = <&mmcc MDSS_AHB_CLK>;
> >                                 clock-names = "iface";
> >                         };
> > +
> > +                       hdmi: hdmi-tx@fd922100 {
> > +                               status = "disabled";
> > +
> > +                               compatible = "qcom,hdmi-tx-8974";
> > +                               reg = <0xfd922100 0x35c>,
> > +                                     <0xfc4b8000 0x60f0>;
> > +                               reg-names = "core_physical",
> > +                                           "qfprom_physical";
> 
> Is this the qfprom "uncorrected" physical address? If so, why can't this
> node use an nvmem to read whatever it needs out of the qfprom?

The MSM HDMI code is configured to look for this reg-name here:

https://elixir.bootlin.com/linux/latest/source/drivers/gpu/drm/msm/hdmi/hdmi.c#L582

There is a qcom,qfprom configured for this board in DTS, however its at
a different address range, so maybe there are multiple qfproms?

https://elixir.bootlin.com/linux/latest/source/arch/arm/boot/dts/qcom-msm8974.dtsi#L424

msm8996.dtsi has the same style of configuration:

https://elixir.bootlin.com/linux/latest/source/arch/arm64/boot/dts/qcom/msm8996.dtsi#L956
https://elixir.bootlin.com/linux/latest/source/arch/arm64/boot/dts/qcom/msm8996.dtsi#L1736

Brian
