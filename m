Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1B75C31E40
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 17:00:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A7312171F
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 17:00:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jLURGumw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436773AbfHIRAB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 13:00:01 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44152 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436716AbfHIRAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 13:00:01 -0400
Received: by mail-pl1-f196.google.com with SMTP id t14so45170598plr.11
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2019 10:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HzTYQAsTwaeVmkPpyYA1+naQMbibccJuAVbeLptpfdo=;
        b=jLURGumwZc6E/p0KiMVcYkNhD2BqzUR63Qb5/zAULhocRqcCYmkB3afGtGBPibGK8g
         kE9JHSlMRB/Dv6m6pfftnIfCMzVc7OsepxQRXmXOeC9MqYcZB9lNEKVXGBrSiGHv4CWi
         Mt2hQMxvMS8k5RAg5MRZDajoCjGOVCxONDVAyo7HssYFEUF6miW/Ph9ojHWuz4Wwnrwb
         INWAX2BJIs8RhNAAqZbBG0BHV92QTFpkXtUFFNOlfm7rWNa5Mg7caNoonzIH7PYhKqx/
         jAmstmGYBm9Q4d+XKNpjbylQCgtRL8fVbGjcCMT6b5m8wHwvqzhrjmXMddlQFa7+zlFy
         dq7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HzTYQAsTwaeVmkPpyYA1+naQMbibccJuAVbeLptpfdo=;
        b=BiEB3blrDE2RLMk1YV54Y3FA/6vx7YdL6atRAaCfQ92UPXBSZJf3NXv0zUVR+ikGvT
         E4LiqtvWfqy0dgnGYCfOhOy6xLdKU0kHilhc87MwsihI8JuAIikS+hBVcvd1DHifymjQ
         hgzWZxg9LOkx1u7tdflap607AkYOLroXv6pDOJN/u1uh1Uuu51sITK3ZuKU8SBcNEF2A
         BdjfFgwEQ6gK6sRdXWtHpyZnn4LNSrgv74wUohG4CQuwbMwgHYfjdYbGrKQ2siGnfXLU
         J/wAeG/iMHAdPJ3mWDzq249dRr8JzPfeg2FG5eRSho1oYsT/WOJUw+WWFRrT6gl8d2Oy
         nSYw==
X-Gm-Message-State: APjAAAVqdNsWFN/kDCoO8fv3KmSYNszZi2W0WEl2XQiOXtj5Ped0t1Y9
        wlC8W/Nqxb/jPuhYALyiRtRLkw==
X-Google-Smtp-Source: APXvYqxIvh8RXaUTDHMAAPall519zovv23HzUG1DHQ2lDtsV6hbQ9nI3rJVwqZmuAYs+AgsL8D8x4Q==
X-Received: by 2002:a17:902:a40c:: with SMTP id p12mr20027983plq.146.1565370000206;
        Fri, 09 Aug 2019 10:00:00 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id 185sm98899540pfd.125.2019.08.09.09.59.58
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 09 Aug 2019 09:59:59 -0700 (PDT)
Date:   Fri, 9 Aug 2019 10:01:34 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>, linux-arm-msm@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/4] regulator: dt-bindings: Sort the compatibles and
 nodes
Message-ID: <20190809170134.GM26807@tuxbook-pro>
References: <20190809073616.1235-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190809073616.1235-1-vkoul@kernel.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 09 Aug 00:36 PDT 2019, Vinod Koul wrote:

> It helps to keep sorted order for compatibles and nodes, so sort them
> 
> Suggested-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> ---
>  .../regulator/qcom,rpmh-regulator.txt         | 19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.txt b/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.txt
> index 1a9cab50503a..bab9f71140b8 100644
> --- a/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.txt
> +++ b/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.txt
> @@ -22,12 +22,12 @@ RPMh resource.
>  
>  The names used for regulator nodes must match those supported by a given PMIC.
>  Supported regulator node names:
> -	PM8998:		smps1 - smps13, ldo1 - ldo28, lvs1 - lvs2
> -	PMI8998:	bob
>  	PM8005:		smps1 - smps4
> +	PM8009:		smps1 - smps2, ldo1 - ldo7
>  	PM8150:		smps1 - smps10, ldo1 - ldo18
>  	PM8150L:	smps1 - smps8, ldo1 - ldo11, bob, flash, rgb
> -	PM8009:		smps1 - smps2, ld01 - ldo7
> +	PM8998:		smps1 - smps13, ldo1 - ldo28, lvs1 - lvs2
> +	PMI8998:	bob
>  
>  ========================
>  First Level Nodes - PMIC
> @@ -36,12 +36,13 @@ First Level Nodes - PMIC
>  - compatible
>  	Usage:      required
>  	Value type: <string>
> -	Definition: Must be one of: "qcom,pm8998-rpmh-regulators",
> -		    "qcom,pmi8998-rpmh-regulators" or
> -		    "qcom,pm8005-rpmh-regulators" or
> -		    "qcom,pm8150-rpmh-regulators" or
> -		    "qcom,pm8150l-rpmh-regulators" or
> -		    "qcom,pm8009-rpmh-regulators".
> +	Definition: Must be one of below:
> +		    "qcom,pm8005-rpmh-regulators"
> +		    "qcom,pm8009-rpmh-regulators"
> +		    "qcom,pm8150-rpmh-regulators"
> +		    "qcom,pm8150l-rpmh-regulators"
> +		    "qcom,pm8998-rpmh-regulators"
> +		    "qcom,pmi8998-rpmh-regulators"

Thanks for dropping the "or" as well.

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

>  
>  - qcom,pmic-id
>  	Usage:      required
> -- 
> 2.20.1
> 
