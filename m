Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17EF2C3A59F
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 21:36:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1C4F2077C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 21:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565991412;
	bh=27Wyj/QJgaCrveHT5w2aKeM6rcyqtc5ZT1tcxH4d55U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=J6bYXY889HbyBZ9Dzv5sjP3+9CMD+YOK3M1bO3DrsMMGSefK/QxIkVXOIq1yDXP75
	 21Sm1crwnEmS0aB4ohJ4nMUXmGLjNuyEFI3y9vv5CO+tJQz84Mjg35rU8V56rjl1rU
	 o/NrSgoPqSsPjwLNNjHG+OCaQsH8WDEKn3+Hhfdg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727801AbfHPVgv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 17:36:51 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:45164 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727669AbfHPVgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 17:36:50 -0400
Received: by mail-ot1-f67.google.com with SMTP id m24so10809059otp.12;
        Fri, 16 Aug 2019 14:36:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EqlNFjx8Ch5lQdeRcSUE5YdRlHoeAi8lFa9/QkEjgTM=;
        b=HxTcv2KuOI64KV6DMNes5u0U0pNHQqn/foS5LjijGIAlzxP/uSaQXsEcgDlM10uJnf
         KmjGbFPrGI80Do54XxPJr7c/KJIKj5kcjohBmtH10tt1IXwtP8BBcrdOLhRmOhttkCub
         A8df62TkuuI2FVoh7bB70GsklYvQoET4TJTPwGAf9tlmU5F8SU7QDgyIfWEM7XH663fl
         CcQKKoJbU/gb/w/GAn9x8I1b6D0GYdhruUadmG2p2B8fYp1zLxXs4zjPg2pcqMLhrFCN
         1Z3m7G5nYALbgzMAJI2WJaBif8g5G1MdoPQrnOeCsEh/DwclkIYA9zjXprMWSgUgQqIo
         gb/g==
X-Gm-Message-State: APjAAAXj9ws3gyad41oznSEUgD6JQyO8nm7iARgq4CiI7T/aYOid+OhB
        IGkmqhP4UcC33LvW6wNFjg==
X-Google-Smtp-Source: APXvYqzv3GJEnxTv+5jBFCXAMe2okebHAbr3nDOEFdGzRvfDJjMgdr9GsqRb97UrQUIQnU9DH0AIEw==
X-Received: by 2002:a05:6830:1e79:: with SMTP id m25mr3749268otr.109.1565991409708;
        Fri, 16 Aug 2019 14:36:49 -0700 (PDT)
Received: from localhost ([2607:fb90:1cdf:eef6:c125:340:5598:396e])
        by smtp.gmail.com with ESMTPSA id h25sm695855oih.22.2019.08.16.14.36.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2019 14:36:49 -0700 (PDT)
Date:   Fri, 16 Aug 2019 16:36:48 -0500
From:   Rob Herring <robh@kernel.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        andy.gross@linaro.org, Andy Gross <agross@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 07/15] dt: thermal: tsens: Document interrupt support in
 tsens driver
Message-ID: <20190816213648.GA10244@bogus>
References: <cover.1564091601.git.amit.kucheria@linaro.org>
 <72bce036fa8cba3db6e5ba82249837ee46e9c077.1564091601.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <72bce036fa8cba3db6e5ba82249837ee46e9c077.1564091601.git.amit.kucheria@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 26, 2019 at 03:48:42AM +0530, Amit Kucheria wrote:
> Define two new required properties to define interrupts and
> interrupt-names for tsens.
> 
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> ---
>  Documentation/devicetree/bindings/thermal/qcom-tsens.txt | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.txt b/Documentation/devicetree/bindings/thermal/qcom-tsens.txt
> index 673cc1831ee9..3d3dd5dc6d36 100644
> --- a/Documentation/devicetree/bindings/thermal/qcom-tsens.txt
> +++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.txt
> @@ -22,6 +22,8 @@ Required properties:
>  
>  - #thermal-sensor-cells : Should be 1. See ./thermal.txt for a description.
>  - #qcom,sensors: Number of sensors in tsens block
> +- interrupts: Interrupts generated from Always-On subsystem (AOSS)
> +- interrupt-names: The name of the interrupt e.g. "tsens0", "tsens1"

How many interrupts? A name with just indices isn't too useful.

>  - Refer to Documentation/devicetree/bindings/nvmem/nvmem.txt to know how to specify
>  nvmem cells
>  
> @@ -40,6 +42,9 @@ tsens0: thermal-sensor@c263000 {
>  		reg = <0xc263000 0x1ff>, /* TM */
>  			<0xc222000 0x1ff>; /* SROT */
>  		#qcom,sensors = <13>;
> +		interrupts = <GIC_SPI 506 IRQ_TYPE_LEVEL_HIGH>;
> +		interrupt-names = "tsens0";
> +
>  		#thermal-sensor-cells = <1>;
>  	};
>  
> -- 
> 2.17.1
> 
