Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C905C04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 06:08:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40CA726431
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 06:08:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bY1OiOlZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbfEaGIo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 02:08:44 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46360 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbfEaGIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 02:08:44 -0400
Received: by mail-pl1-f195.google.com with SMTP id e5so1814485pls.13
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 23:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XwfqNiumqbGzIIC/RNtiSYns0HQ4qYSUZptMwlc/kUo=;
        b=bY1OiOlZBhPceUCRbkGtku9P7C5GJFH3r7S5acpROqVkrL05YeRY2a4qN5z6EKQJM8
         HBr9g7zmWxowRUXVStXMxAg7dVUlRxYdxmpE3sq/QqbaeswrsfMCUXyBpRLNp/ujYKBB
         5EPPuzwHc4Hbp+qHmZ8J3FbgxJ6JE+JGCoE86hVtf0xv8uoeM7UaskO0HZPG3P4kn+lb
         NjdnZUF0HuHXT3b5htg14CKa8jsYNHWJ9ZyIjpEe5+s+WFsg8xPObN4EIvF5jWb+9Tcd
         f3l/CMowGFQt1LUp0RHBs4IxDNYz7EF1K4+2NUKO41PdKjF90Abagopk8qQLg6a+VcmE
         PjvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XwfqNiumqbGzIIC/RNtiSYns0HQ4qYSUZptMwlc/kUo=;
        b=cKzOE5AysvVFpXbQG3kyn2Elk3AMa/6gvWiSL/rn7Jir01w/tNaNSonZrMqG1Vv7D+
         VnVoXE5oFLeI8WimIiIsEX6ywlSv6gQpW2knDhUOB9xM9Ol1hrNwHshjfJ6lzq7Yu1Na
         LxUxRKQKB56hnD2y31C1I/ocStzy1kQ1stvkHrUFn7AHEM5c5zcDKuxxf1JfzXYMLryV
         jjs9fX3k6hjqQlbW5sVsoyEMDSWPpVizWAJkw3JA2D2BI7/832C0fmegf659NEs9uFCr
         zaeTX6s0yv3W9Lw0KBw0D+7h8kP4BieioxLDniDI+r0dNxUVoO/t3IaCkXwBrlU7aPFG
         fshQ==
X-Gm-Message-State: APjAAAU6I55pCqNvW5a3QfAX2QoqYh6INMBpKBav/v4BLEeO5ZxCaE04
        EiB7eCwXk+J7mNXrSObjOv9uNJp0Xw==
X-Google-Smtp-Source: APXvYqzrAfkfqti29DEdzisOmgSYSBFSIKUocZpAqFeqT3IHD3Tat99veY4H0d3/uwy4LsUUxMGAYA==
X-Received: by 2002:a17:902:e00a:: with SMTP id ca10mr7527559plb.18.1559282923093;
        Thu, 30 May 2019 23:08:43 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2405:204:72cb:ebf2:a51d:3877:feab:5634])
        by smtp.gmail.com with ESMTPSA id j64sm11527264pfb.126.2019.05.30.23.08.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 30 May 2019 23:08:42 -0700 (PDT)
Date:   Fri, 31 May 2019 11:38:34 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Anand Moon <linux.amoon@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-rockchip@lists.infradead.org,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: rockchip: Add missing PCIe pwr amd rst
 configuration
Message-ID: <20190531060834.GA23771@Mani-XPS-13-9360>
References: <20190530125837.730-1-linux.amoon@gmail.com>
 <20190531040222.GB9641@Mani-XPS-13-9360>
 <CANAwSgQ13PizDuNEVF5JMM=byt-HELCmZFhLAa3RS6kvxmXuhw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANAwSgQ13PizDuNEVF5JMM=byt-HELCmZFhLAa3RS6kvxmXuhw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 31, 2019 at 10:27:22AM +0530, Anand Moon wrote:
> Hi Manivannan,
> 
> On Fri, 31 May 2019 at 09:32, Manivannan Sadhasivam
> <manivannan.sadhasivam@linaro.org> wrote:
> >
> > Hi,
> >
> > On Thu, May 30, 2019 at 12:58:37PM +0000, Anand Moon wrote:
> > > This patch add missing PCIe gpio and pinctrl for power (#PCIE_PWR)
> > > also add PCIe gpio and pinctrl for reset (#PCIE_PERST_L).
> > >
> > > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > > ---
> > > Tested on Rock960 Model A
> > > ---
> > >  arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi | 16 ++++++++++++++--
> > >  1 file changed, 14 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi
> > > index c7d48d41e184..f5bef6b0fe89 100644
> > > --- a/arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi
> > > +++ b/arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi
> > > @@ -55,9 +55,10 @@
> > >
> > >       vcc3v3_pcie: vcc3v3-pcie-regulator {
> > >               compatible = "regulator-fixed";
> > > +             gpio = <&gpio2 RK_PA2 GPIO_ACTIVE_HIGH>;
> > >               enable-active-high;
> > >               pinctrl-names = "default";
> > > -             pinctrl-0 = <&pcie_drv>;
> > > +             pinctrl-0 = <&pcie_drv &pcie_pwr>;
> > >               regulator-boot-on;
> > >               regulator-name = "vcc3v3_pcie";
> > >               regulator-min-microvolt = <3300000>;
> > > @@ -381,9 +382,10 @@
> > >  };
> > >
> > >  &pcie0 {
> > > +     ep-gpio = <&gpio2 RK_PD4 GPIO_ACTIVE_HIGH>;
> > >       num-lanes = <4>;
> > >       pinctrl-names = "default";
> > > -     pinctrl-0 = <&pcie_clkreqn_cpm>;
> > > +     pinctrl-0 = <&pcie_clkreqn_cpm &pcie_perst_l>;
> > >       vpcie3v3-supply = <&vcc3v3_pcie>;
> > >       status = "okay";
> > >  };
> > > @@ -408,6 +410,16 @@
> > >               };
> > >       };
> > >
> > > +     pcie {
> > > +             pcie_pwr: pcie-pwr {
> > > +                     rockchip,pins = <2 RK_PA2 RK_FUNC_GPIO &pcfg_pull_none>;
> > > +             };
> > > +
> > > +             pcie_perst_l:pcie-perst-l {
> > > +                     rockchip,pins = <2 RK_PD4 RK_FUNC_GPIO &pcfg_pull_none>;
> > > +             };
> >
> > Which schematics did you refer? According to Rock960 v2.1 schematics [1], below
> > is the pin mapping for PCI-E PWR and PERST:
> >
> > PCIE_PERST - GPIO2_A2
> > PCIE_PWR - GPIO2_A5
> >
> 
> Opps, I have referred the wrong schematics *RK3399_Rock960_V1.0.pdf*
> may be old version.
> Thanks for pointing out the correct schematics.
> 
> > Above mapping holds true for Rock960 version 1.1, 1.2 and 1.3. Also,
> > rk3399-rock960.dtsi is common for both Rock960 and Ficus boards, so the board
> > specific parts should go to rk3399-rock960.dts and rk3399-ficus.dts.
> >
> > Thanks,
> > Mani
> 
> I have ROCK960-V 1.2 (Model A) for testing so. I will be sending patch
> v2 the relevant
> node update in rk3399-rock960.dts and rk3399-ficus.dts if below common
> for both the boards.

Both boards are different in terms of pin mapping!

-Mani

> 
> PCIE_PERST - GPIO2_A2
> PCIE_PWR - GPIO2_A5
> 
> >
> > [1] https://dl.vamrs.com/products/rock960/docs/hw/rock960_sch_v12_20180314.pdf
> 
> Best Regards
> -Anand
