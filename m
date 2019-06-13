Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC675C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:36:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1703206BB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:36:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T1xzSsA9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731110AbfFMPgk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:36:40 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40426 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727757AbfFMPgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 11:36:36 -0400
Received: by mail-pf1-f193.google.com with SMTP id p184so8783547pfp.7
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 08:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dIxmbqoHolBJ5JcAhkZwY20MNsxdVQHEXSvHFfDlnuo=;
        b=T1xzSsA9CWPyw7MWBoY1BkfuWJPaojXzqycfSspyble27NyBTeDRkcyEZlH3+A5O3T
         Z6NEGv0WS/CcB1j1VNYkJchhJJ9R9qZXDRNePgDjSugQ1t0q8105sxVsOZRxc+TLwaqs
         7kV//PH0M1EB4KS7oeLAVuKDggdnPQjpP8SIC2JqHFNKJG42LdxB9rFX6PDVXIKLsRT0
         6ULmpK6ETnJzaxuVhH0qZBw3k4cP2Za66kFl4eSE8OeQt0XCpjtZUKr+pjRA8J0H0usm
         QCJAafRqj3DAkuKtPOiLbmIvPRSGJTbM3N4gy3M8+ZeF1U2doaNJUOH0OO+R0Rz64xah
         d8oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dIxmbqoHolBJ5JcAhkZwY20MNsxdVQHEXSvHFfDlnuo=;
        b=IxUh5mjSvTONTyXgv/XTbmEFZHBWp8NxtoICZCh/ViDaeysn60mOphAzA2pQKFm996
         QePHSn2vtjM0vg9amBE8mOKZNPbA/08TQLEoXrWnagaEs7Eh8+gb6oqjaV4xzxHHh6x4
         fzJTI4v06bReATm6LGYulKd695G+Tfli6kZO+jz8ripOd+DqHy2BpcKwpCZBbDJ3TRX3
         bohO7gwi6K0M0Bk6Fy6C2RAHIZhbVt1rpkqtHAv2ph0yvJhqpf8ol/aBSemHo7xK/53m
         /sXdUF8YVgRFH7AT2WKf/paLHV8sKjyzdNzFnc14Wj2C8ck5pBe5dPLEU8K+ppwKkCD2
         8G2A==
X-Gm-Message-State: APjAAAX/6K3eiQY6VO9FbggqOJfgtevFcRIqG6W7YSGamc9B2DzEx3NI
        EUilNslSkrEcblTdsG+EV+C9uw==
X-Google-Smtp-Source: APXvYqzi2uLTJsw+edMFJq+DNQyvGd0PcsK9UYvnv+v8xA1dRESupytCXLoyfUCnalLWUD65g6ISdQ==
X-Received: by 2002:a63:52:: with SMTP id 79mr30999563pga.381.1560440195944;
        Thu, 13 Jun 2019 08:36:35 -0700 (PDT)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id t13sm276008pjo.13.2019.06.13.08.36.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Jun 2019 08:36:35 -0700 (PDT)
Date:   Thu, 13 Jun 2019 08:36:33 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
Cc:     lgirdwood@gmail.com, broonie@kernel.org, agross@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Jorge Ramirez <jorge.ramirez-ortiz@linaro.org>
Subject: Re: [PATCH v3 6/7] dt-bindings: qcom_spmi: Document pms405 support
Message-ID: <20190613153633.GF6792@builder>
References: <20190613142157.8674-1-jeffrey.l.hugo@gmail.com>
 <20190613142416.8985-1-jeffrey.l.hugo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190613142416.8985-1-jeffrey.l.hugo@gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 13 Jun 07:24 PDT 2019, Jeffrey Hugo wrote:

> From: Jorge Ramirez <jorge.ramirez-ortiz@linaro.org>
> 
> The PMS405 supports 5 SMPS and 13 LDO regulators.
> 
> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
> ---
>  .../regulator/qcom,spmi-regulator.txt         | 24 +++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/regulator/qcom,spmi-regulator.txt b/Documentation/devicetree/bindings/regulator/qcom,spmi-regulator.txt
> index ba94bc2d407a..19cffb239094 100644
> --- a/Documentation/devicetree/bindings/regulator/qcom,spmi-regulator.txt
> +++ b/Documentation/devicetree/bindings/regulator/qcom,spmi-regulator.txt
> @@ -10,6 +10,7 @@ Qualcomm SPMI Regulators
>  			"qcom,pm8941-regulators"
>  			"qcom,pm8994-regulators"
>  			"qcom,pmi8994-regulators"
> +			"qcom,pms405-regulators"
>  
>  - interrupts:
>  	Usage: optional
> @@ -111,6 +112,29 @@ Qualcomm SPMI Regulators
>  	Definition: Reference to regulator supplying the input pin, as
>  		    described in the data sheet.
>  
> +- vdd_s1-supply:
> +- vdd_s2-supply:
> +- vdd_s3-supply:
> +- vdd_s4-supply:
> +- vdd_s5-supply:
> +- vdd_l1-supply:
> +- vdd_l2-supply:
> +- vdd_l3-supply:
> +- vdd_l4-supply:
> +- vdd_l5-supply:
> +- vdd_l6-supply:
> +- vdd_l7-supply:
> +- vdd_l8-supply:
> +- vdd_l9-supply:
> +- vdd_l10-supply:
> +- vdd_l11-supply:
> +- vdd_l12-supply:
> +- vdd_l13-supply:

No, the supply pins are as follows:

- vdd_l1_l2-supply:
- vdd_l3_l8-supply:
- vdd_l4-supply:
- vdd_l5_l6-supply:
- vdd_l10_l11_l12_l13-supply:
- vdd_l7-supply:
- vdd_l9-supply:
- vdd_s1-supply:
- vdd_s2-supply:
- vdd_s3-supply:
- vdd_s4-supply:
- vdd_s5-supply:


Regards,
Bjorn

> +	Usage: optional (pms405 only)
> +	Value type: <phandle>
> +	Definition: Reference to regulator supplying the input pin, as
> +		    described in the data sheet.
> +
>  - qcom,saw-reg:
>  	Usage: optional
>  	Value type: <phandle>
> -- 
> 2.17.1
> 
