Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62BC9C48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 13:06:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F11421670
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 13:06:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="az3YMGn6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727495AbfFZNGa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 09:06:30 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35644 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726484AbfFZNGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 09:06:30 -0400
Received: by mail-wm1-f67.google.com with SMTP id c6so2055393wml.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 06:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=jasW8iOP/d7sV94RnAWZopvnxi1Y0wq0BsXNBk9SRx0=;
        b=az3YMGn6W5/V0lTRT7btk/EvmdAaHV3zlj7lFfCrrDaPgWeW+GkaDdCLu5Ti3YcHJh
         Fx7JihhubV9v9A08WOjo1XrhxT5tKrFosChP6JevXIKk+A8kTQvG6fox4JmIB7y1V+N8
         JgMotdeT1jmFxqF2uEzKkknQCaPmv8DrNqEplpZpBan+ElZb4oW2suYIwNnMqCjoLSiH
         hmjt/pQiYxutG3NxKvZZ/LO+LJ6es5KMaEVmgjmCWx+Vclj2PZHQZyE0xferHxhTR8ww
         TF01LNoctOqtERCc0HaXPpKvxcKGAr2WArzXblymP/ju5pIv6V9uj1zcHczpyK2IQC1E
         T2Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=jasW8iOP/d7sV94RnAWZopvnxi1Y0wq0BsXNBk9SRx0=;
        b=spCJG77mkRMgeDS6lcgvgWsq5lT08zjz5wj177i2FKMlSyqsIeNUGT1C01067qorOF
         VO7hPlPlGbgBLfGwO4YbdO/gHm7a9rOzXZQyKfyUEDuePF6rHgkhwqcBuI5Xg2ym/mbp
         waHWMw51UemQ4JuPAWefvwf3X2kA9DxKzwK7HOwLtyz8yu2p2+0uaTBuxIz9pSOv0kl+
         gkIcSq9AyhgRjpK4adVQLPNrzlQrUJ7PmCMelXBkSb4yoT9VhxE/hayqxfDtS4AFlSGW
         uh+XORRUt6tJuuJ51zlfuoQa9i0QkWn2hH0NGHE0tjqFZ4aFaqXV8XcR14smm3jnXmHc
         B0RA==
X-Gm-Message-State: APjAAAWAWIX7Vw7sLOIo+Y24wDALqSjHvBZF7YoKYn3zF8Ty14n7psmk
        unhnAAAkOIMZHM5QSmBZA/iUzw==
X-Google-Smtp-Source: APXvYqy7eXiwnfpfAmsno9wnKxOy/4jY/0GIhWf/bt1xBsOxMhdmhWTPBButZn+09ZxaqLFX7HZJOQ==
X-Received: by 2002:a1c:c6:: with SMTP id 189mr2743811wma.112.1561554387914;
        Wed, 26 Jun 2019 06:06:27 -0700 (PDT)
Received: from dell ([2.27.35.164])
        by smtp.gmail.com with ESMTPSA id d1sm15782413wru.41.2019.06.26.06.06.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Jun 2019 06:06:26 -0700 (PDT)
Date:   Wed, 26 Jun 2019 14:06:24 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     =?utf-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>
Cc:     sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH v4 2/2] dt-bindings: mfd: max8998: Add charger subnode
 binding
Message-ID: <20190626130624.GT21119@dell>
References: <20190621115602.17559-1-pawel.mikolaj.chmiel@gmail.com>
 <20190621115602.17559-3-pawel.mikolaj.chmiel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190621115602.17559-3-pawel.mikolaj.chmiel@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Jun 2019, Paweł Chmiel wrote:

> This patch adds devicetree bindings documentation for
> battery charging controller as the subnode of MAX8998 PMIC.

It makes sense to place this in:

 Documentation/devicetree/bindings/power/supply/

And link to it from this file using the following syntax:

 See: ../power/supply/<file>.txt

> Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
> ---
> Changes from v3:
>   - Property prefix should be maxim, not max8998
>   - Describe what End of Charge in percent means
> 
> Changes from v2:
>   - Make charge-restart-level-microvolt optional.
>   - Make charge-timeout-hours optional.
> 
> Changes from v1:
>   - Removed unneeded Fixes tag
>   - Correct description of all charger values
>   - Added missing property unit
> ---
>  .../devicetree/bindings/mfd/max8998.txt       | 26 +++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/max8998.txt b/Documentation/devicetree/bindings/mfd/max8998.txt
> index 5f2f07c09c90..368f787d6079 100644
> --- a/Documentation/devicetree/bindings/mfd/max8998.txt
> +++ b/Documentation/devicetree/bindings/mfd/max8998.txt
> @@ -48,6 +48,25 @@ Additional properties required if max8998,pmic-buck2-dvs-gpio is defined:
>  - max8998,pmic-buck2-dvs-voltage: An array of 2 voltage values in microvolts
>    for buck2 regulator that can be selected using dvs gpio.
>  
> +Charger: Configuration for battery charging controller should be added
> +inside a child node named 'charger'.
> +  Required properties:
> +  - maxim,end-of-charge-percentage: End of Charge in percent.
> +    When the charge current in constant-voltage phase drops below
> +    end-of-charge-percentage of it's start value, charging is terminated.
> +    If value equals 0, leave it unchanged. Otherwise it should be value
> +    from 10 to 45 by 5 step.
> +
> +  Optional properties:
> +  - maxim,charge-restart-threshold: Charge restart threshold in millivolts.
> +    If property is not present, this will be disabled.
> +    Valid values are: 0, 100, 150, 200. If the value equals 0, leave it
> +    unchanged.
> +
> +  - maxim,charge-timeout: Charge timeout in hours. If property is not
> +    present, this will be disabled. Valid values are: 0, 5, 6, 7.
> +    If the value equals 0, leave it unchanged.
> +
>  Regulators: All the regulators of MAX8998 to be instantiated shall be
>  listed in a child node named 'regulators'. Each regulator is represented
>  by a child node of the 'regulators' node.
> @@ -97,6 +116,13 @@ Example:
>  		max8998,pmic-buck2-dvs-gpio = <&gpx0 0 3 0 0>; /* SET3 */
>  		max8998,pmic-buck2-dvs-voltage = <1350000>, <1300000>;
>  
> +		/* Charger configuration */
> +		charger {
> +			maxim,end-of-charge-percentage = <20>;
> +			maxim,charge-restart-threshold = <100>;
> +			maxim,charge-timeout = <7>;
> +		};
> +
>  		/* Regulators to instantiate */
>  		regulators {
>  			ldo2_reg: LDO2 {

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
