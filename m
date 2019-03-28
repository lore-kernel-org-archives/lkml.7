Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E457C10F06
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 18:02:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5C8520651
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 18:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553796123;
	bh=yR35LbV0zjeTKLLONMeTl8OefYcShsXNBBCEyKYcrpQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=eiMGc2yZjZAcvALd4zomxW0d5sgRIDmNS3Dk4pUoHGmgUNnTlEgk9yYjsrb4FpH70
	 aI/PQcPPuGnjr3hrm1kR7YhvNY6bsyc4ClnDEN7SQP9ECBTMY4PVwcDU8xudWwoGNA
	 1LNmicuXxKpCFAEeSQoLnmFEoJjn8rB6uwL7Hg80=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbfC1SCC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 14:02:02 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:41224 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725849AbfC1SCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 14:02:01 -0400
Received: by mail-ot1-f68.google.com with SMTP id 64so19184384otb.8;
        Thu, 28 Mar 2019 11:02:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vTgtxQ03sR8a8ohtGcqFORH34Fjsaap8ekjhbrBO66k=;
        b=tF32dzcEMo20nsKrTR5yrPPtDw+PDfO/s52c73D/sC3BIQpD60hlSfNRioAeNwmD3p
         xb/YTcpri37pFl4asYkxjXsYhck0FoizLLinG8AR3NvNSuaXfNwgr7PLsMktDs225baX
         NT5hAM4OSvNkQQgXtTJPOa1i8RJvmCSHlpvvPqta3Ia3JuQmujyrB7oDJ+JWbayng+RG
         KbFqT31cQKJtQ5edL4+mubbABDB1mNMR5Xvw4KFIzbXjJjEgbSaBJjk+Q9/1EGuVOiAX
         ZqMIriRiGw/+LNe2maN3l22CL7pMG68GPGOSef5VpS5gW7dWx9QRgAiSIF22Du87LFOY
         +WWw==
X-Gm-Message-State: APjAAAU7A/2FxDDCX2g2n7B9l7mzK/8XQfyfavsmmxCUb5vqcAzir72b
        pFNqaQ4mhGYa+AX1eeYG9gU5Q82dbg==
X-Google-Smtp-Source: APXvYqwmrvh1/NS+Jr1BGz+50LT/tq6a9Wk7K2T+jbj6TS4F7ABkxJTwKzHf2vRqKleKRXMLkFqm9w==
X-Received: by 2002:a9d:5b7:: with SMTP id 52mr25479706otd.279.1553796120629;
        Thu, 28 Mar 2019 11:02:00 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id p186sm1703598oif.34.2019.03.28.11.01.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Mar 2019 11:01:59 -0700 (PDT)
Date:   Thu, 28 Mar 2019 13:01:59 -0500
From:   Rob Herring <robh@kernel.org>
To:     Stefan Wahren <stefan.wahren@i2se.com>
Cc:     Kamil Debski <kamil@wypas.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 1/3] dt-bindings: hwmon: Add tachometer interrupt to
 pwm-fan
Message-ID: <20190328180159.GA29107@bogus>
References: <1553243043-19486-1-git-send-email-stefan.wahren@i2se.com>
 <1553243043-19486-2-git-send-email-stefan.wahren@i2se.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1553243043-19486-2-git-send-email-stefan.wahren@i2se.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 22, 2019 at 09:24:01AM +0100, Stefan Wahren wrote:
> This adds the tachometer interrupt to the pwm-fan binding, which is
> necessary for RPM support.
> 
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> ---
>  .../devicetree/bindings/hwmon/pwm-fan.txt          | 22 +++++++++++++++++++++-
>  1 file changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/pwm-fan.txt b/Documentation/devicetree/bindings/hwmon/pwm-fan.txt
> index 49ca5d8..722005f 100644
> --- a/Documentation/devicetree/bindings/hwmon/pwm-fan.txt
> +++ b/Documentation/devicetree/bindings/hwmon/pwm-fan.txt
> @@ -7,7 +7,16 @@ Required properties:
>  			which correspond to thermal cooling states
>  
>  Optional properties:
> -- fan-supply    : phandle to the regulator that provides power to the fan
> +- fan-supply		: phandle to the regulator that provides power to the fan
> +- interrupts		: This contains a single interrupt specifier which
> +			  describes the tachometer output of the fan as an
> +			  interrupt source. The output signal must generate a
> +			  defined number of interrupts per fan revolution, which
> +			  require that it must be self resetting edge interrupts.
> +			  See interrupt-controller/interrupts.txt for the format.
> +- pulses-per-revolution : define the tachometer pulses per fan revolution as
> +			  an integer (default is 2 interrupts per revolution).
> +			  The value must be greater than zero.
>  
>  Example:
>  	fan0: pwm-fan {
> @@ -38,3 +47,14 @@ Example:
>  					};
>  			     };
>  		};
> +
> +Example 2:
> +	fan0: pwm-fan {
> +		fan0: pwm-fan {

This line should go.

Otherwise,

Reviewed-by: Rob Herring <robh@kernel.org>

> +		compatible = "pwm-fan";
> +		pwms = <&pwm 0 40000 0>;
> +		fan-supply = <&reg_fan>;
> +		interrupt-parent = <&gpio5>;
> +		interrupts = <1 IRQ_TYPE_EDGE_FALLING>;
> +		pulses-per-revolution = <2>;
> +	};
> -- 
> 2.7.4
> 
