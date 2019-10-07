Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E379C4740A
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 05:48:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 541D32084D
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 05:48:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iWm2gbrx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727156AbfJGFsG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 01:48:06 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35758 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726960AbfJGFsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 01:48:06 -0400
Received: by mail-pf1-f195.google.com with SMTP id 205so7930031pfw.2
        for <linux-kernel@vger.kernel.org>; Sun, 06 Oct 2019 22:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5tzoF5jEWBGYn2YEncgp+nUwEVI8tjzoOCexGDe1hVc=;
        b=iWm2gbrxXJtQbLIiHmiKtOzlK0kdACMqzvNyCI0Bvt31xz+eLXkAX3gfjASqtsyxd2
         pibAMwyUux/rIge9wN9ApuhvjHkiHSb6pKraakhzlhJbh8JgeyELWbZL3PIl53pLUXyM
         iC4fFVNWHchNI0Y9vRlKepoKrk43B7Q/GtfRWIqXe+L/euPWh53pNl7YkRPu2Px87Ijb
         ti4S14CzINDFcQoHtWJxeSosRNR3kd6DjPJfm/4b+LrhRudNDYrseCHJvA0sPBhBVIts
         zkUet9HlTvXp/wvmIvi/ZrzCOh/d/RQI2xYxO0LV3j4KYxlVl9xwzjWI37g1ahIIy/6B
         m2Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5tzoF5jEWBGYn2YEncgp+nUwEVI8tjzoOCexGDe1hVc=;
        b=XD42M2ny+RMl4TNjxP8c67rsaR4+tC0wa7dNCzAKJRRpHjbUI1OH+aUz5+fEPS/TIa
         Ndzm2HoS/OB+gCUxU8dtXjIbNdfbg1uRIEgvi9Jf9/WWmn8mm69z0h7so0IO5r73F3G8
         Y6XygAtordmvp+xCrVKJ4zAQUGgCFwhQfzAY7uiAG0mJJdVLN9eMrdiFGw/QxqKqDQcw
         F6S7cWgt66LLlutxi8tyxYCb36ROX1DIn+v10JU1sKVCuRjiYqNU5Pb+ZCA62sZ8fZdF
         YzQ7gmL+m8qRCP3PaMhCjXQx1BL4xCQshw00MrDmg8QNBkGSp3mi/qHEcMr5T7RKRcqc
         gMVA==
X-Gm-Message-State: APjAAAUqT/cwRupTXzUpeurDDtEXTODbroCbKdmOHy8FrCW4aDkySumq
        zr/mkAXgMh1wRpvH4ELrAm4RXQ==
X-Google-Smtp-Source: APXvYqx8wMELgRKaVDfwPVaxFK4vskD26Isa8VG9p6kFK7Fr+X+pG18Z3YrxVjib5kmWx8LxnhwKbg==
X-Received: by 2002:a65:504c:: with SMTP id k12mr16046935pgo.252.1570427285224;
        Sun, 06 Oct 2019 22:48:05 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id u7sm5730980pfn.61.2019.10.06.22.48.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2019 22:48:04 -0700 (PDT)
Date:   Sun, 6 Oct 2019 22:48:01 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Brian Masney <masneyb@onstation.org>
Cc:     robdclark@gmail.com, sean@poorly.run, a.hajda@samsung.com,
        Laurent.pinchart@ideasonboard.com, airlied@linux.ie,
        daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, jonathan@marek.ca,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH RFC v2 3/5] ARM: dts: qcom: pm8941: add 5vs2 regulator
 node
Message-ID: <20191007054801.GH6390@tuxbook-pro>
References: <20191007014509.25180-1-masneyb@onstation.org>
 <20191007014509.25180-4-masneyb@onstation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191007014509.25180-4-masneyb@onstation.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 06 Oct 18:45 PDT 2019, Brian Masney wrote:

> pm8941 is missing the 5vs2 regulator node so let's add it since its
> needed to get the external display working. This regulator was already
> configured in the interrupts property on the parent node.
> 
> Note that this regulator is referred to as mvs2 in the downstream MSM
> kernel sources.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Picked this patch for now, once the driver updates are landed I will
take the last two dts patches.

Regards,
Bjorn

> ---
> Changes since v1:
> - None
> 
>  arch/arm/boot/dts/qcom-pm8941.dtsi | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/qcom-pm8941.dtsi b/arch/arm/boot/dts/qcom-pm8941.dtsi
> index f198480c8ef4..c1f2012d1c8b 100644
> --- a/arch/arm/boot/dts/qcom-pm8941.dtsi
> +++ b/arch/arm/boot/dts/qcom-pm8941.dtsi
> @@ -178,6 +178,16 @@
>  				qcom,vs-soft-start-strength = <0>;
>  				regulator-initial-mode = <1>;
>  			};
> +
> +			pm8941_5vs2: 5vs2 {
> +				regulator-enable-ramp-delay = <1000>;
> +				regulator-pull-down;
> +				regulator-over-current-protection;
> +				qcom,ocp-max-retries = <10>;
> +				qcom,ocp-retry-delay = <30>;
> +				qcom,vs-soft-start-strength = <0>;
> +				regulator-initial-mode = <1>;
> +			};
>  		};
>  	};
>  };
> -- 
> 2.21.0
> 
