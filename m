Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C36DCC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 17:51:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9819C20823
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 17:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553795499;
	bh=NHUtwjRIFTvBhyozLmJJJws+hL5MUUljHuFRyyHy30E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=elJJRt6ZlAOHMhhTeICP1fS6PR0D0PSvqlDb/idjzF6rweO4+9jkvTh//5+qVPRHZ
	 UyYjcD2kU8QR7Zza64woAQglj7QoLwG1De2q91n829GhfLfLq9SIDfA7uPqATWz33T
	 o3NJLesnDqN8fVLH8VW7xsdsfD8oG7TFoi398lI8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727682AbfC1Rvh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 13:51:37 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:37503 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbfC1Rvh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 13:51:37 -0400
Received: by mail-ot1-f67.google.com with SMTP id c16so19176427otn.4;
        Thu, 28 Mar 2019 10:51:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6nr15hFnrNU7DCIEqf1JuRuMjrJ40wiGfDteWVuhoY4=;
        b=i97DyXYoNVgmhc2Hrxz7beYTpigz8e9ZCJABnXxT9YBQlZH8XaH44QiuipeOO47avo
         HrdZ/JzKwTqSA0VXWe1dxBVTSEsKWKN67taUrC9xSPcG3kRnTHbSFVnSFdh9Shd784e9
         aVTZz3jNGbraQ8w41rTRlk+aB65uAGyy0dlAIihLtUbtXKq+PG0pXXz8pjDT7BcpXjbO
         sZEvE4KiJBln7Hj4LU/h3lUpH4zu8I9vqttJ6mN1yV1tyQsSPp8wUK2STrcSTdEKkHtX
         ZjMWKvRQ+Eqwlxp40a/TfQApnlcduQhCMXO/MzGogG6+aY+T3qvACMmzNOM7q4z96uRX
         81RA==
X-Gm-Message-State: APjAAAXuXOXPLN2dxPSA7vVdS1K1r/esC0hRaBLRvb4LCNwN/zFaRuPx
        1P0cbsMc/Ry0h/Umu2+5+w==
X-Google-Smtp-Source: APXvYqzlwaeVmj5o9+QiNXlXr2/9CvnmCdP/yNsjqZrjyhvCmOzwbxSN0qtb1bZM0iyyKgKfFyhFtQ==
X-Received: by 2002:a05:6830:2009:: with SMTP id e9mr6518039otp.142.1553795496390;
        Thu, 28 Mar 2019 10:51:36 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id o83sm8838149oif.33.2019.03.28.10.51.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Mar 2019 10:51:35 -0700 (PDT)
Date:   Thu, 28 Mar 2019 12:51:35 -0500
From:   Rob Herring <robh@kernel.org>
To:     Andreas Klinger <ak@it-klinger.de>
Cc:     devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        jic23@kernel.org, mark.rutland@arm.com, afaerber@suse.de,
        arnd@arndb.de, davem@davemloft.net, gregkh@linuxfoundation.org,
        johan@kernel.org, khilman@baylibre.com, knaack.h@gmx.de,
        lars@metafoo.de, linux-kernel@vger.kernel.org,
        martin.blumenstingl@googlemail.com, mchehab+samsung@kernel.org,
        m.othacehe@gmail.com, nicolas.ferre@microchip.com,
        pmeerw@pmeerw.net, songqiang1304521@gmail.com, treding@nvidia.com,
        techsupport@maxbotix.com
Subject: Re: [PATCH v3 2/4] dt-bindings: maxbotix,mb1232: Add MaxBotix i2c
 ultrasonic rangers
Message-ID: <20190328175134.GA15033@bogus>
References: <20190317203526.4pcwo4gdrrng44v7@arbad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190317203526.4pcwo4gdrrng44v7@arbad>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 17, 2019 at 09:35:27PM +0100, Andreas Klinger wrote:
> Add doc for dt binding maxbotix,mb1232. This binding is for MaxBotix
> I2CXL-MaxSonar ultrasonic rangers which share a common i2c interface.
> 
> Signed-off-by: Andreas Klinger <ak@it-klinger.de>
> ---
>  .../bindings/iio/proximity/maxbotix,mb1232.txt     | 31 ++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/proximity/maxbotix,mb1232.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/proximity/maxbotix,mb1232.txt b/Documentation/devicetree/bindings/iio/proximity/maxbotix,mb1232.txt
> new file mode 100644
> index 000000000000..0e9df87eca1d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/proximity/maxbotix,mb1232.txt
> @@ -0,0 +1,31 @@
> +* MaxBotix I2CXL-MaxSonar ultrasonic distance sensor of type  mb1202,
> +  mb1212, mb1222, mb1232, mb1242, mb7040 or mb7137 using the i2c interface
> +  for ranging
> +
> +Required properties:
> + - compatible:		"maxbotix,mb1202",
> +			"maxbotix,mb1212",
> +			"maxbotix,mb1222",
> +			"maxbotix,mb1232",
> +			"maxbotix,mb1242",
> +			"maxbotix,mb7040" or
> +			"maxbotix,mb7137"
> +
> + - reg:			i2c address of the device, see also i2c/i2c.txt
> +
> +Optional properties:
> + - interrupt-parent:	Interrupt controller to use

Don't need this as it is implied and could be in the parent.

Otherwise,

Reviewed-by: Rob Herring <robh@kernel.org>

> +
> + - interrupts:		Interrupt used to announce the preceding reading
> +			request has finished and that data is available.
> +			If no interrupt is specified the device driver
> +			falls back to wait a fixed amount of time until
> +			data can be retrieved.
> +
> +Example:
> +proximity@70 {
> +	compatible = "maxbotix,mb1232";
> +	reg = <0x70>;
> +	interrupt-parent = <&gpio2>;
> +	interrupts = <2 IRQ_TYPE_EDGE_FALLING>;
> +};
> -- 
> 2.11.0
