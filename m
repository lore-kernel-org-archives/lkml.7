Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C82AEC04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 04:57:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89650263D5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 04:57:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kfoYhZkf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbfEaE5f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 00:57:35 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:39499 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbfEaE5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 00:57:35 -0400
Received: by mail-it1-f193.google.com with SMTP id j204so7894228ite.4;
        Thu, 30 May 2019 21:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pYMrn55kLH2S++DFur1WFLWOoxAYXbVwA77jHVN56K0=;
        b=kfoYhZkf6QrrWJKyrfZm2jySez/Ob1PR92nLjbtbCIkwApTrJE8LqKlBo+hOLDWtzm
         Kbtq5RETimAdVvyEQlSWLCxb9FxX67p4RfrZmKYTPVmM/7a66eqQt8supqC5Jl68mjXl
         3g0meLrU3kkQS2nIBulztcE8EsYVtq5Zt3yldQON/t2fiIgLNmGmq0iW9TjOf3cb8HRV
         hQUCSI48LvaJU4wgAQw6+tTPUsfGbpYE1FTI8IlM24vtiVxgkCJdT3er1u/dmKP5v9xo
         6pn8gVndXm6lkx/pDiVVkcj0Aqz42IxHdM3Zo+vXVJjOCDvwGBRmjTKMTNy21DiMmG6H
         FnfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pYMrn55kLH2S++DFur1WFLWOoxAYXbVwA77jHVN56K0=;
        b=Ehn4b8YkAqvu/76XT3bfWlGQHzij9YfL3YhqVanRYndsmpwlAW2VUK9Subjnt1jsGC
         WJrQCfPdunCEJTN5TMU8vtqMfqxg1Pqxnqql2FePz1PSP1YOt4+LtLBpU1rKnvHfRJe3
         GOWl0PQMf0ULSsTu9rmsDod9pjmw1CmHIRpSBVt0h6Y+nJ5tNPR6DfCfQllsRTElwOBW
         fKBixJ6oJcIS22u9AonnItThbccT3UnQKdw7Bqn6ZZR1H5+ON9yIyQfMiou6+wLlmXn7
         yZQB/RsO0xoaatRK2lob4+LQEEp5nyZtA8nuVwgq+F5ZcZJf8JxddQGDXmdyi9xH3wkW
         Iq6Q==
X-Gm-Message-State: APjAAAXGaDBlxpHPU+gIFKyRmWaJcXAwQd5toJ95Dtb7k2jNlesf5hzY
        q365fps38mrkSR5lKRbj3DepxYqQq6PYRAdrM7KOhyvp
X-Google-Smtp-Source: APXvYqyrNSflW/4/Z9Kt+shMt+wzrH+meKU5Uw8V7PnnqJVcWdQXyvi3s2unKfCvSA99bkG0l1jdlkupXL3T+WefGeQ=
X-Received: by 2002:a24:4acd:: with SMTP id k196mr5575395itb.157.1559278654178;
 Thu, 30 May 2019 21:57:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190530125837.730-1-linux.amoon@gmail.com> <20190531040222.GB9641@Mani-XPS-13-9360>
In-Reply-To: <20190531040222.GB9641@Mani-XPS-13-9360>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Fri, 31 May 2019 10:27:22 +0530
Message-ID: <CANAwSgQ13PizDuNEVF5JMM=byt-HELCmZFhLAa3RS6kvxmXuhw@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: rockchip: Add missing PCIe pwr amd rst configuration
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-rockchip@lists.infradead.org,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Manivannan,

On Fri, 31 May 2019 at 09:32, Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> Hi,
>
> On Thu, May 30, 2019 at 12:58:37PM +0000, Anand Moon wrote:
> > This patch add missing PCIe gpio and pinctrl for power (#PCIE_PWR)
> > also add PCIe gpio and pinctrl for reset (#PCIE_PERST_L).
> >
> > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > ---
> > Tested on Rock960 Model A
> > ---
> >  arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi | 16 ++++++++++++++--
> >  1 file changed, 14 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi
> > index c7d48d41e184..f5bef6b0fe89 100644
> > --- a/arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi
> > +++ b/arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi
> > @@ -55,9 +55,10 @@
> >
> >       vcc3v3_pcie: vcc3v3-pcie-regulator {
> >               compatible = "regulator-fixed";
> > +             gpio = <&gpio2 RK_PA2 GPIO_ACTIVE_HIGH>;
> >               enable-active-high;
> >               pinctrl-names = "default";
> > -             pinctrl-0 = <&pcie_drv>;
> > +             pinctrl-0 = <&pcie_drv &pcie_pwr>;
> >               regulator-boot-on;
> >               regulator-name = "vcc3v3_pcie";
> >               regulator-min-microvolt = <3300000>;
> > @@ -381,9 +382,10 @@
> >  };
> >
> >  &pcie0 {
> > +     ep-gpio = <&gpio2 RK_PD4 GPIO_ACTIVE_HIGH>;
> >       num-lanes = <4>;
> >       pinctrl-names = "default";
> > -     pinctrl-0 = <&pcie_clkreqn_cpm>;
> > +     pinctrl-0 = <&pcie_clkreqn_cpm &pcie_perst_l>;
> >       vpcie3v3-supply = <&vcc3v3_pcie>;
> >       status = "okay";
> >  };
> > @@ -408,6 +410,16 @@
> >               };
> >       };
> >
> > +     pcie {
> > +             pcie_pwr: pcie-pwr {
> > +                     rockchip,pins = <2 RK_PA2 RK_FUNC_GPIO &pcfg_pull_none>;
> > +             };
> > +
> > +             pcie_perst_l:pcie-perst-l {
> > +                     rockchip,pins = <2 RK_PD4 RK_FUNC_GPIO &pcfg_pull_none>;
> > +             };
>
> Which schematics did you refer? According to Rock960 v2.1 schematics [1], below
> is the pin mapping for PCI-E PWR and PERST:
>
> PCIE_PERST - GPIO2_A2
> PCIE_PWR - GPIO2_A5
>

Opps, I have referred the wrong schematics *RK3399_Rock960_V1.0.pdf*
may be old version.
Thanks for pointing out the correct schematics.

> Above mapping holds true for Rock960 version 1.1, 1.2 and 1.3. Also,
> rk3399-rock960.dtsi is common for both Rock960 and Ficus boards, so the board
> specific parts should go to rk3399-rock960.dts and rk3399-ficus.dts.
>
> Thanks,
> Mani

I have ROCK960-V 1.2 (Model A) for testing so. I will be sending patch
v2 the relevant
node update in rk3399-rock960.dts and rk3399-ficus.dts if below common
for both the boards.

PCIE_PERST - GPIO2_A2
PCIE_PWR - GPIO2_A5

>
> [1] https://dl.vamrs.com/products/rock960/docs/hw/rock960_sch_v12_20180314.pdf

Best Regards
-Anand
