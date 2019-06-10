Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B2B9C31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 16:05:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D4AF20820
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 16:05:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VV9N9tGP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403843AbfFJQFH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 12:05:07 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45306 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391423AbfFJQFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 12:05:07 -0400
Received: by mail-pl1-f194.google.com with SMTP id bi6so3442544plb.12
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2019 09:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=I97k1/yDNx0Ud4d53tFJ+yzis1/msAxhI7LkJXdDlMI=;
        b=VV9N9tGP8t2WAQUQ+OSK2mKKCq5hw/N4x7i7RZ590iX541DGS+qpKTG/j+IEqxn3rZ
         H21R38eWL4cZzvIqWG7yGw0Yx4RUYnU9IA3evlNHfq6dOXsAFoXgTAcwEqrrt/75qDWv
         1WNhWrZEc0F/+0Ap5HW9EQB8XXHjjpSbB6ID2xPX1JuBstBbT7ctDcNGOvhu80VQPrY5
         MUkeQgFjzhu8vYi6C7HA4Rt/jmQHHLQuvUs9a4wdno0iKRSy0ijN+2sbahr1MiseeeI2
         YTg3k9hu+cDwt1c8aDmL0YZ4s0933Hol8De084L5JSPIBTCLwUBcgcKYL4aMYP0xWafo
         mnSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=I97k1/yDNx0Ud4d53tFJ+yzis1/msAxhI7LkJXdDlMI=;
        b=Yp+vZwhzUxsGlQM6CFrLA1AQJ6MtT1Q9Kujo5XogpkwHgDI02OxRv8P/GkxAu8nJ0w
         c3gDh3sc3z2wqbRCVJPqjn5WtIP7iErlpkjPto/txxu+916plwpud1xQzmOsrRaWw5Y9
         uU92uhIU07OSE2MLzuhshH+6IqDDanxs3FJqI6iA5MeVkK9+eGa/O4jFwhSCZ4+R9qhs
         qyyXaPF7d4FZcLwzU1CvMktsxqp3ttKI7RViRKYvYA94ftPR2KG4ZXoV7wuQtJ4NoImw
         Q708oKeDxVB+RSzzBlLMEO6TFFkLWnp0JZutFJ2UJAHKBiRaMwNsugIB8d7Bav6YueMB
         r+JA==
X-Gm-Message-State: APjAAAX8DEbEfA0f+hscnPYZoiLqVkWbJauVro/oCA2p14j++rNXx0/D
        vZlnSY+qqfRNdX/bAHIcfjbP
X-Google-Smtp-Source: APXvYqwH/NmDelm4Qk4hvpw7av9GCUs379dTbeOaPUH87D6Xn3audTYv6l3vxIFimcWYviwc+NPV4Q==
X-Received: by 2002:a17:902:ac1:: with SMTP id 59mr9967531plp.168.1560182706367;
        Mon, 10 Jun 2019 09:05:06 -0700 (PDT)
Received: from mani ([103.59.133.81])
        by smtp.gmail.com with ESMTPSA id 144sm8900066pfa.180.2019.06.10.09.05.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Jun 2019 09:05:05 -0700 (PDT)
Date:   Mon, 10 Jun 2019 21:34:59 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>
Cc:     ulf.hansson@linaro.org, robh+dt@kernel.org, sboyd@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        thomas.liau@actions-semi.com, linux-actions@lists.infradead.org,
        linus.walleij@linaro.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH 2/7] dt-bindings: mmc: Add Actions Semi SD/MMC/SDIO
 controller binding
Message-ID: <20190610160459.GA31461@mani>
References: <20190608195317.6336-1-manivannan.sadhasivam@linaro.org>
 <20190608195317.6336-3-manivannan.sadhasivam@linaro.org>
 <5d164528-c797-5f94-f905-719d4f69542c@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5d164528-c797-5f94-f905-719d4f69542c@suse.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Andreas,

On Mon, Jun 10, 2019 at 03:45:37PM +0200, Andreas Färber wrote:
> Am 08.06.19 um 21:53 schrieb Manivannan Sadhasivam:
> > Add devicetree binding for Actions Semi Owl SoC's SD/MMC/SDIO controller.
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >  .../devicetree/bindings/mmc/owl-mmc.txt       | 37 +++++++++++++++++++
> >  1 file changed, 37 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/mmc/owl-mmc.txt
> 
> Rob, should this be YAML now?
> 
> > 
> > diff --git a/Documentation/devicetree/bindings/mmc/owl-mmc.txt b/Documentation/devicetree/bindings/mmc/owl-mmc.txt
> > new file mode 100644
> > index 000000000000..a702f8d66cec
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mmc/owl-mmc.txt
> > @@ -0,0 +1,37 @@
> > +Actions Semi Owl SoCs SD/MMC/SDIO controller
> > +
> > +Required properties:
> > +- compatible: should be "actions,owl-mmc"
> > +- reg: offset and length of the register set for the device.
> > +- interrupts: single interrupt specifier.
> > +- clocks: single clock specifier of the controller clock.
> > +- resets: phandle to the reset line.
> > +- dma-names: should be "mmc".
> > +- dmas: single DMA channel specifier
> 
> I recall the main blocker for MMC being regulators, i.e. the I²C
> attached multi-function PMIC. Yet I don't see any such required property
> here, nor any patch series implementing it. Seems like this relies on
> U-Boot having initialized SD/eMMC? Do you intend to make them optional
> or did you want to hold off merging this one until the rest is done?
> 

Yeah, I'm planning to rely on u-boot for regulator enablement. PMIC support
in kernel will take some time because the floating SIRQ patchset is not yet
finished.

> > +
> > +Optional properties:
> > +- pinctrl-names: pinctrl state names "default" must be defined.
> > +- pinctrl-0: phandle referencing pin configuration of the controller.
> > +- bus-width: see mmc.txt
> > +- cap-sd-highspeed: see mmc.txt
> > +- cap-mmc-highspeed: see mmc.txt
> > +- sd-uhs-sdr12: see mmc.txt
> > +- sd-uhs-sdr25: see mmc.txt
> > +- sd-uhs-sdr50: see mmc.txt
> > +- non-removable: see mmc.txt
> 
> I'm not convinced duplicating common properties is a good idea here, in
> particular pinctrl.
> 

Hmmm, I thought of adding the MMC properties which were supported by the SoC.
I can remove those if needed.

Thanks,
Mani

> Regards,
> Andreas
> 
> > +
> > +Example:
> > +
> > +		mmc0: mmc@e0330000 {
> > +			compatible = "actions,owl-mmc";
> > +			reg = <0x0 0xe0330000 0x0 0x4000>;
> > +			interrupts = <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>;
> > +			clocks = <&cmu CLK_SD0>;
> > +			resets = <&cmu RESET_SD0>;
> > +			dmas = <&dma 2>;
> > +			dma-names = "mmc";
> > +			pinctrl-names = "default";
> > +			pinctrl-0 = <&mmc0_default>;
> > +			bus-width = <4>;
> > +			cap-sd-highspeed;
> > +		};
> > 
> 
> 
> -- 
> SUSE Linux GmbH, Maxfeldstr. 5, 90409 Nürnberg, Germany
> GF: Felix Imendörffer, Mary Higgins, Sri Rasiah
> HRB 21284 (AG Nürnberg)
