Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5C19C4CECE
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 14:45:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFA7020854
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 14:45:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="acWQ55Ai"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733017AbfJNOpN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 10:45:13 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40666 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732847AbfJNOpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 10:45:12 -0400
Received: by mail-pg1-f193.google.com with SMTP id e13so2046165pga.7
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2019 07:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lN3aRAuKpYaZ+ZuEn6xFUroPN9c8Y6dWN+cO0mavUPk=;
        b=acWQ55Aiyz7bzg/1t6x1p4ZfHhb0zNpeZtu5QsyIdzgE1QI6KUJxYkaysyyqghEd2n
         41wFIFxypCPBodguQ7QviQd8/dveMM5h0qbssgoQLldYCRe90n15XVAtxr4abyn8T0jT
         CDFf+R5syJKkVWkiBYpgaUFQHjnjI4m0NxuJiu9I6TkeB1DMa9ZcR5jpnCdQko93nvKS
         WeLNUbdlnHZ3IHqpQlJ7mDBf4/4BbLmeF8P4beDw9Qm1EAgeW+UUoTkN4fW0nwdToN4t
         dnY8pm3GrHlVUm9BUV+viabKQ/FXPLT6JWWKgudSDhEl8xHA8esTfz4x8C+U4RFzFP5J
         +phg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lN3aRAuKpYaZ+ZuEn6xFUroPN9c8Y6dWN+cO0mavUPk=;
        b=fN4tlnZnfuJX+yGOKCHdS+vcdOBS8KESIfa6oZ0S1VsbAvrICZ3IY0Vg1TiMKrHS08
         1mM2pwjMekGcuFKWHzSBjo93FJA87tuuiWyatdxcWW3fxE+H+dpF5OyYQgU4UJaC9sTk
         cEJ6cjLIKJBixGzRdkmjxyvXgpB/Wq7KGrKhvarA4IOzCceQi1XMVZdqm8JBvnP9dmK+
         beiE7+/Wp1Qq8PS8q16vX3gq/MtUm/hw3909QSGZg/jUM5rr9jWrm4Trri4/mjQc+ViT
         Q6E+8BOAWBaDRpARwytNX66G8Wp3QBLlL2HkO0Z566JHKjtp8Mkq/ekjm7IBIMk1O9Aq
         qGKA==
X-Gm-Message-State: APjAAAX6IAI9rR0+aADR0cIsvWeHbpXdyMrNw6E5yG9Iyvk+VxYEPhCG
        1gJ6g38gPPsQrAT7eXoCet3c
X-Google-Smtp-Source: APXvYqzDg0QrcgcQ38e0+fcKt09OO187d0GYMhUan8xXe5sagd9k+8PSQ+8vzIrqqnKkx9XTu0FHlg==
X-Received: by 2002:a62:31c3:: with SMTP id x186mr32802372pfx.260.1571064311986;
        Mon, 14 Oct 2019 07:45:11 -0700 (PDT)
Received: from mani ([103.59.133.81])
        by smtp.gmail.com with ESMTPSA id f185sm25155509pfb.183.2019.10.14.07.45.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Oct 2019 07:45:11 -0700 (PDT)
Date:   Mon, 14 Oct 2019 20:15:03 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     ulf.hansson@linaro.org, afaerber@suse.de, robh+dt@kernel.org,
        sboyd@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        thomas.liau@actions-semi.com, linux-actions@lists.infradead.org,
        linus.walleij@linaro.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v4 4/7] arm64: dts: actions: Add uSD and eMMC support for
 Bubblegum96
Message-ID: <20191014144503.GB8583@mani>
References: <20190916154546.24982-1-manivannan.sadhasivam@linaro.org>
 <20190916154546.24982-5-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190916154546.24982-5-manivannan.sadhasivam@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 16, 2019 at 09:15:43PM +0530, Manivannan Sadhasivam wrote:
> Add uSD and eMMC support for Bubblegum96 board based on Actions Semi
> S900 SoC. SD0 is connected to uSD slot and SD2 is connected to eMMC.
> Since there is no PMIC support added yet, fixed regulator has been
> used as a regulator node.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Applied for v5.5.

Thanks,
Mani

> ---
>  .../boot/dts/actions/s900-bubblegum-96.dts    | 62 +++++++++++++++++++
>  1 file changed, 62 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/actions/s900-bubblegum-96.dts b/arch/arm64/boot/dts/actions/s900-bubblegum-96.dts
> index 732daaa6e9d3..59291e0ea1ee 100644
> --- a/arch/arm64/boot/dts/actions/s900-bubblegum-96.dts
> +++ b/arch/arm64/boot/dts/actions/s900-bubblegum-96.dts
> @@ -12,6 +12,9 @@
>  	model = "Bubblegum-96";
>  
>  	aliases {
> +		mmc0 = &mmc0;
> +		mmc1 = &mmc1;
> +		mmc2 = &mmc2;
>  		serial5 = &uart5;
>  	};
>  
> @@ -23,6 +26,24 @@
>  		device_type = "memory";
>  		reg = <0x0 0x0 0x0 0x80000000>;
>  	};
> +
> +	/* Fixed regulator used in the absence of PMIC */
> +	vcc_3v1: vcc-3v1 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "fixed-3.1V";
> +		regulator-min-microvolt = <3100000>;
> +		regulator-max-microvolt = <3100000>;
> +		regulator-always-on;
> +	};
> +
> +	/* Fixed regulator used in the absence of PMIC */
> +	sd_vcc: sd-vcc {
> +		compatible = "regulator-fixed";
> +		regulator-name = "fixed-3.1V";
> +		regulator-min-microvolt = <3100000>;
> +		regulator-max-microvolt = <3100000>;
> +		regulator-always-on;
> +	};
>  };
>  
>  &i2c0 {
> @@ -241,6 +262,47 @@
>  			bias-pull-up;
>  		};
>  	};
> +
> +	mmc0_default: mmc0_default {
> +		pinmux {
> +			groups = "sd0_d0_mfp", "sd0_d1_mfp", "sd0_d2_d3_mfp",
> +				 "sd0_cmd_mfp", "sd0_clk_mfp";
> +			function = "sd0";
> +		};
> +	};
> +
> +	mmc2_default: mmc2_default {
> +		pinmux {
> +			groups = "nand0_d0_ceb3_mfp";
> +			function = "sd2";
> +		};
> +	};
> +};
> +
> +/* uSD */
> +&mmc0 {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&mmc0_default>;
> +	no-sdio;
> +	no-mmc;
> +	no-1-8-v;
> +	cd-gpios = <&pinctrl 120 GPIO_ACTIVE_LOW>;
> +	bus-width = <4>;
> +	vmmc-supply = <&sd_vcc>;
> +	vqmmc-supply = <&sd_vcc>;
> +};
> +
> +/* eMMC */
> +&mmc2 {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&mmc2_default>;
> +	no-sdio;
> +	no-sd;
> +	non-removable;
> +	bus-width = <8>;
> +	vmmc-supply = <&vcc_3v1>;
>  };
>  
>  &timer {
> -- 
> 2.17.1
> 
