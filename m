Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 122B0CA9ECF
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 13:07:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC5592080F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 13:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572527274;
	bh=xMigDxa3I9yFnuaA1/rSvcF5DRLGFmKTKGP8/j2Poeg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=VgOxSLDfImpBZ9gUMclNKtfdkKzw+/MXunD4PKm7WwRxPTxARaMoPWGC9zQk5x4Vk
	 2wezH2QDcWnWml8AlQuhgGKtsP2GlSSaJSlDHtf0ZJxfg1o4EWNV8Oa+bXyUJk2fQg
	 kJPuIosbOtw3PjbjLZtH6+fcJPJhUTqgxLpfq09Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727141AbfJaNHy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 09:07:54 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:35905 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727007AbfJaNHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 09:07:53 -0400
Received: by mail-ed1-f68.google.com with SMTP id f7so1615644edq.3;
        Thu, 31 Oct 2019 06:07:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=33+edZoJSD4COmLxAmuLRBayFF47TyCyfQ5sB53fkNg=;
        b=fmT1nE7RJQoDNhpZQCRgKBXwSv5YmnDIQXc3l4kfQhoIgKS8TtCD839yykMQGro993
         TrzEzza2ZjF5zxQeBe8b/qAhIOH/yF1VOLJHkJZGilgClM09V4r5OQjU4U/5UolneaXQ
         CNEF6bv0RSdvzwtRx9+s8fZE1oGg1LfaWHQfRYcu3VCuDahRMuPLdREcdfBfwQtI8EcW
         vnHzTw3kOdILqCncZxNVwVoeAhekfjn9ZTtfvNRBjbLA/UUueKBjAeBKMivVS1hcAduf
         CAIT+mkGHICRdWbAsIaIEYSaqXXS9XWfbU1s7YNp8cYPpd9flkiPaft3n74inukrQB52
         QB7g==
X-Gm-Message-State: APjAAAUmT6vzgf0YLqZDpK3NsmPKQ1M1+0mjNjHxeN4IFFEj+0VBkgrb
        vB+tlPPEMObnnxp7Ub2sFpyNOyQu
X-Google-Smtp-Source: APXvYqz4VxBrjaFKNam8HxGYebLyu4OQUFPsJAleYl1IAKYrh6TRa2TfdjIxJwYwEwR4b6LuyxC7Xw==
X-Received: by 2002:a17:906:a986:: with SMTP id jr6mr3834820ejb.158.1572527271575;
        Thu, 31 Oct 2019 06:07:51 -0700 (PDT)
Received: from pi3 ([194.230.155.180])
        by smtp.googlemail.com with ESMTPSA id a102sm27645edf.46.2019.10.31.06.07.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2019 06:07:50 -0700 (PDT)
Date:   Thu, 31 Oct 2019 14:07:48 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Schrempf Frieder <frieder.schrempf@kontron.de>
Cc:     Fabio Estevam <festevam@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 11/11] ARM: dts: imx6ul-kontron-n6310-s-43: Add
 missing includes for GPIOs and IRQs
Message-ID: <20191031130748.GC27967@pi3>
References: <20191029112655.15058-1-frieder.schrempf@kontron.de>
 <20191029112655.15058-12-frieder.schrempf@kontron.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191029112655.15058-12-frieder.schrempf@kontron.de>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 29, 2019 at 11:28:16AM +0000, Schrempf Frieder wrote:
> From: Frieder Schrempf <frieder.schrempf@kontron.de>
> 
> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
> Fixes: 1ea4b76cdfde ("ARM: dts: imx6ul-kontron-n6310: Add Kontron i.MX6UL N6310 SoM and boards")
> ---
>  arch/arm/boot/dts/imx6ul-kontron-n6310-s-43.dts | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx6ul-kontron-n6310-s-43.dts b/arch/arm/boot/dts/imx6ul-kontron-n6310-s-43.dts
> index 5bad29683cc3..295bc3138fea 100644
> --- a/arch/arm/boot/dts/imx6ul-kontron-n6310-s-43.dts
> +++ b/arch/arm/boot/dts/imx6ul-kontron-n6310-s-43.dts
> @@ -7,6 +7,9 @@
>  
>  #include "imx6ul-kontron-n6310-s.dts"
>  
> +#include <dt-bindings/interrupt-controller/irq.h>
> +#include <dt-bindings/gpio/gpio.h>

This is not needed. This includes imx6ul-kontron-n6310-s.dts, which
includes imx6ul-kontron-n6310-som.dtsi which has proper GPIO include. It
also polls imx6ul.dtsi which has the IRQ defines.

My comment from v1 was for a case where you have a DTSI standing on its
own. If it does not include anything else, then it should have all
necessary inclusions (not only GPIO but also iMX-specific pinctrl and clock).

Best regards,
Krzysztof


> +
>  / {
>  	model = "Kontron N6310 S 43";
>  	compatible = "kontron,imx6ul-n6310-s-43", "kontron,imx6ul-n6310-s",
> -- 
> 2.17.1
