Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71EAAC004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 11:59:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AB75206BF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 11:59:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbfEGL71 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 07:59:27 -0400
Received: from gloria.sntech.de ([185.11.138.130]:34788 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726404AbfEGL70 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 07:59:26 -0400
Received: from we0048.dip.tu-dresden.de ([141.76.176.48] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1hNykl-0008Hr-QN; Tue, 07 May 2019 13:59:23 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        ezequiel@collabora.com, tom@vamrs.com, dev@vamrs.com
Subject: Re: [PATCH 2/2] arm64: dts: rockchip: Enable SPI1 on Ficus
Date:   Tue, 07 May 2019 13:59:23 +0200
Message-ID: <111262745.IyAHIOZrRb@phil>
In-Reply-To: <20190507113635.GB309@Mani-XPS-13-9360>
References: <20190506120458.25842-1-manivannan.sadhasivam@linaro.org> <2127870.SxaTtWf5LP@phil> <20190507113635.GB309@Mani-XPS-13-9360>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 7. Mai 2019, 13:36:35 CEST schrieb Manivannan Sadhasivam:
> On Tue, May 07, 2019 at 01:22:03PM +0200, Heiko Stuebner wrote:
> > Am Montag, 6. Mai 2019, 14:04:58 CEST schrieb Manivannan Sadhasivam:
> > > Enable SPI1 exposed on both Low and High speed expansion connectors
> > > of Ficus. SPI1 has 3 different chip selects wired as below:
> > > 
> > > CS0 - Serial Flash (unpopulated)
> > > CS1 - Low Speed expansion
> > > CS2 - High Speed expansion
> > > 
> > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > ---
> > >  arch/arm64/boot/dts/rockchip/rk3399-ficus.dts | 6 ++++++
> > >  1 file changed, 6 insertions(+)
> > > 
> > > diff --git a/arch/arm64/boot/dts/rockchip/rk3399-ficus.dts b/arch/arm64/boot/dts/rockchip/rk3399-ficus.dts
> > > index 027d428917b8..9baa378fc770 100644
> > > --- a/arch/arm64/boot/dts/rockchip/rk3399-ficus.dts
> > > +++ b/arch/arm64/boot/dts/rockchip/rk3399-ficus.dts
> > > @@ -146,6 +146,12 @@
> > >  	};
> > >  };
> > >  
> > > +&spi1 {
> > > +	/* On both Low speed and High speed expansion */
> > > +	cs-gpios = <0>, <&gpio4 6 0>, <&gpio4 7 0>;
> > 
> > cs0 should still be part of the cs-gpios though (gpio1 RK_PB2).
> > The flash is part of the schematics, so there might be board with
> > it pre-populated or people might put a flash chip on it.
> > 
> 
> Why? CS0 is owned by the SPI controller itself, so we can't use it as
> a GPIO. Otherwise, we need to change the pinctrl definition of it, which
> doesn't look good to me.

Ok, but are you sure mixing both pinctrl-based chip-select with gpio-based
chip-select will actually work when the spi-flash is populated?

But it looks like you're right in that spi_set_cs() checks for a gpio-cs
first and falls back to the controller-based chip-select.

So I guess this can stay as it is.

> 
> > Also please use the constants for pin specification (RK_PA6, RK_PA7 above)
> > 
> 
> Sure.

Thanks
Heiko

> 
> Thanks,
> Mani
> 
> > 
> > Heiko
> > 
> > > +	status = "okay";
> > > +};
> > > +
> > >  &usbdrd_dwc3_0 {
> > >  	dr_mode = "host";
> > >  };
> > > 
> > 
> > 
> > 
> > 
> 




