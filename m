Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D94EBC606D1
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 22:30:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A608520656
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 22:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562625040;
	bh=OffiOYG6R13M9YyPeVgv7b8PG9UD7U6RoXa89hcavPk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=sC92Zvz7F7FwXdE3doNqlEnIngsFBxwDJNT6a6dN1IMv2QBuiBKlx7CNv9xSTm43J
	 uO5AeLzVm2o3HWxxfDsv4T6tAoDzG3C9x8/HK2zByz0DZ4dWy1H6gnLtclcotM/i8i
	 6NR4hb2duGcMKZRR3H6uFJD6BuyWyv1fRyc9+7Ic=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbfGHWaj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 18:30:39 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:35599 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726371AbfGHWaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 18:30:39 -0400
Received: by mail-io1-f68.google.com with SMTP id m24so29454806ioo.2;
        Mon, 08 Jul 2019 15:30:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DKbe5Bw/ZWkGGevk11CJOS1MNbgfdugSW24hlqZbzbo=;
        b=tHMaGIsLukSuB6CqKCJfcHL9Q2DOFCpwAXWWSJqaAnjJK7Dccec+nKsYSuzgWH1Qsx
         OjYvYIkG3UklEh2PUBZnhTXpyY45+9DQJ/dfsozrg18ACjNAyHpx7M0apPwC5TOdr+dk
         zCFpxo4g9KWhOE3WYJfsbw5YxJqwfxMtwQ08PZxLECgnXcWQJTpoVV7cANRHkPVhzy8J
         /4WvOLHa6u+kJVvOSqyKIaklRRiI2rXfWFDz9iomvPvcBGkuThS5OKQPBTOdB6Q9We79
         SWSyaQCvTopobbSFB00XXp6+BwoyBUPd4iEDRc7fqNSs8nIomdzKQK0L27lQ7l8Mmrht
         Qdaw==
X-Gm-Message-State: APjAAAUcwDDdnycTaKhTUoaRWJSSIcrwWbRoEi9yt9/deASN568xaA8W
        Ll7zRL0jxaoN3V+nQ1NEVA==
X-Google-Smtp-Source: APXvYqzSDWN6ooiwDgwx+KLeyHhdjBuL+QsFBURU2G0UGLCiUVOLkcMQl1URO5AdsIaKlOsojsMMsg==
X-Received: by 2002:a5e:c00e:: with SMTP id u14mr7422195iol.196.1562625037976;
        Mon, 08 Jul 2019 15:30:37 -0700 (PDT)
Received: from localhost ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id x22sm14429132iob.84.2019.07.08.15.30.36
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 08 Jul 2019 15:30:36 -0700 (PDT)
Date:   Mon, 8 Jul 2019 16:30:35 -0600
From:   Rob Herring <robh@kernel.org>
To:     min.guo@mediatek.com
Cc:     Bin Liu <b-liu@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        chunfeng.yun@mediatek.com, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, tony@atomide.com,
        hdegoede@redhat.com
Subject: Re: [PATCH v6 1/6] dt-bindings: usb: musb: Add support for MediaTek
 musb controller
Message-ID: <20190708223035.GA7005@bogus>
References: <1559648359-6569-1-git-send-email-min.guo@mediatek.com>
 <1559648359-6569-2-git-send-email-min.guo@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1559648359-6569-2-git-send-email-min.guo@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 04, 2019 at 07:39:14PM +0800, min.guo@mediatek.com wrote:
> From: Min Guo <min.guo@mediatek.com>
> 
> This adds support for MediaTek musb controller in
> host, peripheral and otg mode.
> 
> Signed-off-by: Min Guo <min.guo@mediatek.com>
> ---
> changes in v6:
> 1. Modify usb connector child node
> 
> changes in v5:
> suggested by Rob:
> 1. Modify compatible as 
> - compatible : should be one of:
>                "mediatek,mt-2701"

No, should be: mediatek,mt2701-musb

>                ...
>                followed by "mediatek,mtk-musb"
> 2. Add usb connector child node
> 
> changes in v4:
> suggested by Sergei:
> 1. String alignment
> 
> changes in v3:
> 1. no changes
> 
> changes in v2:
> suggested by Bin:
> 1. Modify DRC to DRD
> suggested by Rob:
> 2. Drop the "<soc-model>-musb" in compatible
> 3. Remove phy-names
> 4. Add space after comma in clock-names
> ---
>  .../devicetree/bindings/usb/mediatek,musb.txt      | 55 ++++++++++++++++++++++
>  1 file changed, 55 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/mediatek,musb.txt
> 
> diff --git a/Documentation/devicetree/bindings/usb/mediatek,musb.txt b/Documentation/devicetree/bindings/usb/mediatek,musb.txt
> new file mode 100644
> index 0000000..7434299
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/mediatek,musb.txt
> @@ -0,0 +1,55 @@
> +MediaTek musb DRD/OTG controller
> +-------------------------------------------
> +
> +Required properties:
> + - compatible      : should be one of:
> +                     "mediatek,mt-2701"
> +                     ...
> +                     followed by "mediatek,mtk-musb"
> + - reg             : specifies physical base address and size of
> +                     the registers
> + - interrupts      : interrupt used by musb controller
> + - interrupt-names : must be "mc"
> + - phys            : PHY specifier for the OTG phy
> + - dr_mode         : should be one of "host", "peripheral" or "otg",
> +                     refer to usb/generic.txt
> + - clocks          : a list of phandle + clock-specifier pairs, one for
> +                     each entry in clock-names
> + - clock-names     : must contain "main", "mcu", "univpll"
> +                     for clocks of controller
> +
> +Optional properties:
> + - power-domains   : a phandle to USB power domain node to control USB's
> +                     MTCMOS
> +
> +Required child nodes:
> + usb connector node as defined in bindings/connector/usb-connector.txt
> +Optional properties:
> + - id-gpios        : input GPIO for USB ID pin.
> + - vbus-gpios      : input GPIO for USB VBUS pin.
> + - vbus-supply     : reference to the VBUS regulator, needed when supports
> +                     dual-role mode
> +
> +Example:
> +
> +usb2: usb@11200000 {
> +	compatible = "mediatek,mt2701-musb",
> +		     "mediatek,mtk-musb";
> +	reg = <0 0x11200000 0 0x1000>;
> +	interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_LOW>;
> +	interrupt-names = "mc";
> +	phys = <&u2port2 PHY_TYPE_USB2>;
> +	dr_mode = "otg";
> +	clocks = <&pericfg CLK_PERI_USB0>,
> +		 <&pericfg CLK_PERI_USB0_MCU>,
> +		 <&pericfg CLK_PERI_USB_SLV>;
> +	clock-names = "main","mcu","univpll";
> +	power-domains = <&scpsys MT2701_POWER_DOMAIN_IFR_MSC>;
> +	connector{
> +		compatible = "linux,typeb-conn-gpio", "usb-b-connector";

linux,typeb-conn-gpio is not an accepted compatible string.

> +		label = "micro-USB";
> +		type = "micro";
> +		id-gpios = <&pio 44 GPIO_ACTIVE_HIGH>;
> +		vbus-supply = <&usb_vbus>;
> +	};
> +};
> -- 
> 1.9.1
> 
