Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73A8CC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 17:17:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4903620659
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 17:17:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vWoXjYFm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727414AbfKLRRk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 12:17:40 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46855 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726388AbfKLRRj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 12:17:39 -0500
Received: by mail-pf1-f195.google.com with SMTP id 193so13783605pfc.13
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 09:17:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=GAxdQVxMEKhKhuZoX/VBOrcEuUfwMEWl5fY0HVG6jDE=;
        b=vWoXjYFmjOttZKwONjxJ81J/VCuN2XQRhnCSkqlhdQq9oK5QFka4Kd5xp3DT3VV3oY
         zYlVuUuTw6pNdbRM0U88rhr9+IvK8p7V3byHtvvE2T222Ja6mvVJ1M3uPdl0vDtIMEJR
         VuiojmGjxZGBlcczfLdrEsLa9LNOLsBJ8PcjE04J1euiQzsaVxJUrFmR1vGuJ1bLEFPV
         5cf1Z7HXzlfFMFXqM6cJ049jXvSmW6Ze1gIk+LZ/9T80z3mMw9EGqPDudOtNhZrpx8Pf
         CIE4bl5kz22UTrI9bVe5BSve8TehRyoQGGzTsDlNJkWMlMzjGPgqClFTZFgMOMRJhXR/
         6hkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=GAxdQVxMEKhKhuZoX/VBOrcEuUfwMEWl5fY0HVG6jDE=;
        b=U5vTujDoSP3XSlypU09el+YY++uA8b7i/v8P4LuDRgFIuxoHIg9XlyL0SrvqyocPjO
         RTfSf6Xm7F13bpUEN+5f+w+kUaYiRSYRbRnXUP7BFNrdra560ngO6uzDZUZgN2rTjXrX
         mOlGY4RxCZXdkmksLkGpcJd2ZCNIvN9HGEwFDseF9MIbNjIDipJDNuL6/SUKDPgX+7OO
         /Fncqr2J8WBoGjwgfvpeCMjdw/DBUp+mWWymuJoePIXOmGdp9RRX/oL8rC03YZPpQWUO
         ZIRBdais3FZpQGSZtkQBhVr4Iygpdi1IhfKIxB4e3yG+WrnJmbf12SFy1kEJn0KoVFjn
         s98A==
X-Gm-Message-State: APjAAAXPc+6qxCyUcdsAhTRml6wglV1hO9ACzONOg6bm8MhQD8dIdaRT
        MbgKlsjwdJHCnW8rdvznP2gp
X-Google-Smtp-Source: APXvYqwtTdqQJZNRF2wCGHv2Dne2JxqgG/WDm44w3rTdj757M0nHUk5Wv2dL7mF3wT7UkK72qdkqSg==
X-Received: by 2002:a17:90a:b394:: with SMTP id e20mr2437267pjr.130.1573579058856;
        Tue, 12 Nov 2019 09:17:38 -0800 (PST)
Received: from Mani-XPS-13-9360 ([2409:4072:6488:b1d2:4134:76b9:cbea:403])
        by smtp.gmail.com with ESMTPSA id p16sm20720040pfn.171.2019.11.12.09.17.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Nov 2019 09:17:37 -0800 (PST)
Date:   Tue, 12 Nov 2019 22:47:29 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Kever Yang <kever.yang@rock-chips.com>
Cc:     heiko@sntech.de, linux-rockchip@lists.infradead.org,
        Akash Gajjar <akash@openedev.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        daniel.lezcano@linaro.org
Subject: Re: [PATCH 2/3] arm64: dts: rk3399-rock960: add vdd_log
Message-ID: <20191112171726.GA18622@Mani-XPS-13-9360>
References: <20191111005158.25070-1-kever.yang@rock-chips.com>
 <20191111005158.25070-2-kever.yang@rock-chips.com>
 <20191111052232.GA2842@Mani-XPS-13-9360>
 <3d129826-7705-819e-e68b-cc9080eb6c95@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3d129826-7705-819e-e68b-cc9080eb6c95@rock-chips.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 12, 2019 at 04:10:17PM +0800, Kever Yang wrote:
> 
> On 2019/11/11 下午1:22, Manivannan Sadhasivam wrote:
> > Hi Kever,
> > 
> > On Mon, Nov 11, 2019 at 08:51:57AM +0800, Kever Yang wrote:
> > > Add vdd_log node according to rock960 schematic V13.
> > > 
> > > Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
> > > ---
> > > 
> > >   arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi | 12 ++++++++++++
> > >   1 file changed, 12 insertions(+)
> > > 
> > > diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi
> > > index c7d48d41e184..73afee257115 100644
> > > --- a/arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi
> > > +++ b/arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi
> > > @@ -76,6 +76,18 @@
> > >   		regulator-always-on;
> > >   		vin-supply = <&vcc5v0_sys>;
> > >   	};
> > > +
> > > +	vdd_log: vdd-log {
> > > +		compatible = "pwm-regulator";
> > > +		pwms = <&pwm2 0 25000 1>;
> > > +		regulator-name = "vdd_log";
> > > +		regulator-always-on;
> > > +		regulator-boot-on;
> > > +		regulator-min-microvolt = <800000>;
> > > +		regulator-max-microvolt = <1400000>;
> > > +		regulator-init-microvolt = <950000>;
> > The default value seems to be 0.9v as per both Rock960 and Ficus schematics.
> 
> 
> The default value is 0.9V when pwm-regulator is not enabled, and this
> 'init-microvolt' suppose to set the
> 
> init value when pwm-regulator is enabled. I set this to 950mV because Peter
> report that he experience
> 
> the system hang during Fedora boot  up, and update the vdd_log to 950mV can
> fix the issue due to
> 
> engineer measure on another rk3399 board puma-Q7.
> 

okay. Previously we had post-boot hang issue on Rock960 Model A boards when the
performance governor was set as default. So the vdd_log node was removed from
the devicetree. Have you tested that case also?

Here is the commit:
13682e524167 ("arm64: dts: rockchip: remove vdd_log from rock960 to fix a stability issues")

thanks,
Mani
> 
> Thanks,
> 
> - Kever
> 
> > 
> > Other than that,
> > Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > 
> > Thanks,
> > Mani
> > 
> > > +		vin-supply = <&vcc_sys>;
> > > +	};
> > >   };
> > >   &cpu_l0 {
> > > -- 
> > > 2.17.1
> > > 
> 
> 
