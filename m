Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD0B1C31E49
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:28:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85CBD21721
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:28:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yO4AmIaX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392389AbfFMQ11 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:27:27 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43134 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392378AbfFMQ1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 12:27:23 -0400
Received: by mail-pf1-f196.google.com with SMTP id i189so12150992pfg.10
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 09:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NQYmrsj8AV8YnHDvnoL6Jmy1MveO6P7UOtTrAk+FJtU=;
        b=yO4AmIaXQ8jEDYvjnej2dizXFrABw/5GGic1bFmoCeLgMiI21RZvXx8ybc6Yc1x0kH
         R/w7rB32UJXmBPWuD/ePCmZqrMSllW+M3Rbb4bYj2kXpZ2cNM/bBS31JWdnOrtEBQmqL
         OPpidHLu9chK2Nn+dvm7uxt+6bMt0vCNo9Qi2kFC1aHi8ito1HhRIxadHhoSMmmyCixT
         B++lIaPsd/25L5g476hjPOQ8QzZ7rVomy7sLdRoPFxHretlJCDAw93t4AGvzFpyVlbPm
         iqLwX4dw2ri+6Ke71NESPos5yxr5a0cBsm8U+6ZLFIw00Uk7K7wl+vEwmvUE1dgXVWgk
         hPnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NQYmrsj8AV8YnHDvnoL6Jmy1MveO6P7UOtTrAk+FJtU=;
        b=rR23/HUhXruRIkL3jo67wcQ6A7FEO9ztA2qpUDT3iZEindOU1YsrsguFw5an+nC9T9
         s4tE1o9PlfLP0yCNHQy1tU8jLSDKAm9pWimv4A9k0dCxIvP64mvbQy8vKHBVLQLAD6Tr
         8cr2aU7c5cQ7/sZiNZRN+1T9Z+rXQRUXnKcqDjr2AEeK0rbPZv6bEKG9DTDxl5wwSTol
         nVrAPcrB6BSZGSaLIpsUfRaUJPZ0Moxov9BxsQ6MExjw5Deon/Y1+0p1W+wdJza8bAVc
         8DMUeaoPBKvjxw8eMo9tLu9bEdzR2sUkxv9dRXlmiamTy/8Vlf44v08xx/GgtkjBu/di
         l4hA==
X-Gm-Message-State: APjAAAWuprgQxcRec4DXSCYtlMi4eF3lj92n0rQHM/kV7R5YbNZei8xk
        0VX+fQ5gNnpepyLwBLHSdI0tBw==
X-Google-Smtp-Source: APXvYqw8DeauGhoNniVQo5Lh9Z6MXZPPOfZzOmYWbhqYprUiFfiahgtcd/MXXKZMwhaITFMWodIx/w==
X-Received: by 2002:a63:1d4:: with SMTP id 203mr5741866pgb.420.1560443242458;
        Thu, 13 Jun 2019 09:27:22 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id i3sm124689pfa.175.2019.06.13.09.27.21
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 13 Jun 2019 09:27:21 -0700 (PDT)
Date:   Thu, 13 Jun 2019 09:28:08 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Nisha Kumari <nishakumari@codeaurora.org>
Cc:     broonie@kernel.org, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        agross@kernel.org, lgirdwood@gmail.com, mark.rutland@arm.com,
        david.brown@linaro.org, linux-kernel@vger.kernel.org,
        kgunda@codeaurora.org, rnayak@codeaurora.org
Subject: Re: [PATCH 1/4] dt-bindings: regulator: Add labibb regulator
Message-ID: <20190613162808.GG22737@tuxbook-pro>
References: <1560337252-27193-1-git-send-email-nishakumari@codeaurora.org>
 <1560337252-27193-2-git-send-email-nishakumari@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1560337252-27193-2-git-send-email-nishakumari@codeaurora.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 12 Jun 04:00 PDT 2019, Nisha Kumari wrote:

> Adding the devicetree binding for labibb regulator.
> 
> Signed-off-by: Nisha Kumari <nishakumari@codeaurora.org>
> ---
>  .../bindings/regulator/qcom-labibb-regulator.txt   | 57 ++++++++++++++++++++++
>  1 file changed, 57 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/regulator/qcom-labibb-regulator.txt
> 
> diff --git a/Documentation/devicetree/bindings/regulator/qcom-labibb-regulator.txt b/Documentation/devicetree/bindings/regulator/qcom-labibb-regulator.txt
> new file mode 100644
> index 0000000..79aad6f4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/regulator/qcom-labibb-regulator.txt
> @@ -0,0 +1,57 @@
> +Qualcomm's LAB(LCD AMOLED Boost)/IBB(Inverting Buck Boost) Regulator
> +
> +LAB can be used as a positive boost power supply and IBB can be used as a negative
> +boost power supply for display panels.
> +
> +Main node required properties:
> +
> +- compatible:			Must be:
> +				"qcom,lab-ibb-regulator"

In order to handle variations in future LABIBB implementations, make
this "qcom,pmi8998-lab-ibb";

> +- #address-cells:		Must be 1
> +- #size-cells:			Must be 0
> +
> +LAB subnode required properties:
> +
> +- reg:				Specifies the SPMI address and size for this peripheral.
> +- regulator-name:		A string used to describe the regulator.
> +- interrupts:			Specify the interrupts as per the interrupt
> +				encoding.
> +- interrupt-names:		Interrupt names to match up 1-to-1 with
> +				the interrupts specified in 'interrupts'
> +				property.
> +
> +IBB subnode required properties:
> +
> +- reg:				Specifies the SPMI address and size for this peripheral.
> +- regulator-name:		A string used to describe the regulator.
> +- interrupts:			Specify the interrupts as per the interrupt
> +				encoding.
> +- interrupt-names:		Interrupt names to match up 1-to-1 with
> +				the interrupts specified in 'interrupts'
> +				property.
> +
> +Example:
> +	pmi8998_lsid1: pmic@3 {
> +		qcom-labibb-regulator {

We typically want to use generic names here, but as the spmi regulator
binding suggest the use of "regulators" without a unit address that
wouldn't work.

But you can shorten this to either "labibb" or at least
"labibb-regulator".

> +			compatible = "qcom,lab-ibb-regulator";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			lab_regulator: qcom,lab@de00 {

Don't use "qcom," in the node names.

> +				reg = <0xde00>;

Please follow the spmi-regulator and hide these in the driver.

> +				regulator-name = "lab_reg";

We know it's a regulator, so no need for _reg, which means that if you
drop "qcom," from the node name and use the node name as the default
regulator name you don't need this.

> +
> +				interrupts = <0x3 0xde 0x0 IRQ_TYPE_EDGE_RISING>;
> +				interrupt-names = "lab-sc-err";
> +			};
> +
> +			ibb_regulator: qcom,ibb@dc00 {
> +				reg = <0xdc00>;
> +				regulator-name = "ibb_reg";
> +
> +				interrupts = <0x3 0xdc 0x2 IRQ_TYPE_EDGE_RISING>;
> +				interrupt-names = "ibb-sc-err";
> +			};
> +
> +		};
> +	};

Regards,
Bjorn
