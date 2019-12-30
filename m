Return-Path: <SRS0=E66v=2U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2931C2D0D3
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 15:38:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B14220718
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 15:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577720284;
	bh=QVnU30Ev3eblfmYmWUuZcBZDRk2imN8YZtU8U+mDa4Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=j7Q71N1OSW++btf4T3WOKtXwWNzL7ahmXX+xumbVZkC9ojEfU/mNl+6lx8IHulxfy
	 dXJELSM6jbnuJn/CnoRAmTeSUJhDsPHhmlfghLB6bS8rvFtxOWZeUHO664voG7soSE
	 pAhxv7q4OX7vVCEjcs6xez1LiEZkIoRE651agW2I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727680AbfL3PiE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Dec 2019 10:38:04 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:35258 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727564AbfL3PiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Dec 2019 10:38:03 -0500
Received: by mail-ed1-f67.google.com with SMTP id f8so32937809edv.2;
        Mon, 30 Dec 2019 07:38:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=S+fvXg7v5gstlV7QHJfLUPtEMEaeWdFQQ5WmiP5N1uk=;
        b=IpW2WB6m9qxouJ5IGy4b1DkSfOQ1rR0UoptuUwpgDinShNusMrKuiwTjRvzjNT0RBz
         /Ht1m2RZ8WyunkhQOfMev8ndnEGxoCo+W2T9uY4K7gZ7yIQcN+C1BfFxHD3QqdkEgqqM
         kpAmEdwsrz9O7TbaFsnqSWiVPCTZ/zU3Zi0ncyp9EfkqKJaJHRxHfX2fx6CSCpKUhuKZ
         +zT/fXLjSYmJm8cDaw5h7G5uVDKKROq8ARGo+ffyHcuOIxz7CMw4T+/PHbu/DTiEHG8i
         1qCOUF8AYt4CL2aiWA/4i35+mcl2BcJsFc4JvoNQcbPnTbvULRIL1w4ZZIf0yzqYyGNT
         3/iQ==
X-Gm-Message-State: APjAAAXvwIiaxACY0l4ECtmf2+N2rcEu7tMSDyFO6s43ZTMv7LSAIfsX
        dwcJAsMUT+70XIfNi+bZnec=
X-Google-Smtp-Source: APXvYqy+53yBifFTLAmU8dsdQ8hL0cLkTBJ1uEgw7SYnSKdV/so5DE1tI+/hP+QWRy6KnJjmAet0wA==
X-Received: by 2002:a17:906:5448:: with SMTP id d8mr39256290ejp.254.1577720281504;
        Mon, 30 Dec 2019 07:38:01 -0800 (PST)
Received: from pi3 ([194.230.155.138])
        by smtp.googlemail.com with ESMTPSA id s22sm2765324ejm.43.2019.12.30.07.38.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Dec 2019 07:38:00 -0800 (PST)
Date:   Mon, 30 Dec 2019 16:37:58 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Benjamin Gaignard <benjamin.gaignard@st.com>
Cc:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        mark.rutland@arm.com, kgene@kernel.org, hminas@synopsys.com,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, m.szyprowski@samsung.com,
        amelie.delaunay@st.com
Subject: Re: [PATCH v2 2/2] ARM: dts: exynos: Remove unneeded "snps,dwc2"
 from hsotg node
Message-ID: <20191230153758.GB4918@pi3>
References: <20191219103536.25485-1-benjamin.gaignard@st.com>
 <20191219103536.25485-3-benjamin.gaignard@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191219103536.25485-3-benjamin.gaignard@st.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 19, 2019 at 11:35:36AM +0100, Benjamin Gaignard wrote:
> Remove "snps,dwc2" from hsotg@12480000 node compatible list because
> "samsung,s3c6400-hsotg" should be enough.

The more detailed compatible is almost always "enough". Some other nodes
also have detailed+generic compatible. In this case there is a driver
matching "snps,dwc2" so why removing it?

Best regards,
Krzysztof

> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> ---
>  arch/arm/boot/dts/exynos3250.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/exynos3250.dtsi b/arch/arm/boot/dts/exynos3250.dtsi
> index b016b0b68306..d4866269f4ee 100644
> --- a/arch/arm/boot/dts/exynos3250.dtsi
> +++ b/arch/arm/boot/dts/exynos3250.dtsi
> @@ -362,7 +362,7 @@
>  		};
>  
>  		hsotg: hsotg@12480000 {
> -			compatible = "samsung,s3c6400-hsotg", "snps,dwc2";
> +			compatible = "samsung,s3c6400-hsotg";
>  			reg = <0x12480000 0x20000>;
>  			interrupts = <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>;
>  			clocks = <&cmu CLK_USBOTG>;
> -- 
> 2.15.0
> 
