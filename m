Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94714C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 17:13:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 594F32082C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 17:13:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AV7X7aYg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbfFTRN5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 13:13:57 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39831 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726530AbfFTRN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 13:13:56 -0400
Received: by mail-pf1-f193.google.com with SMTP id j2so2027219pfe.6
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 10:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SxlO+FSAxDd632DpLfLCq/OUwvg6eaO8V3k3L6zEVyA=;
        b=AV7X7aYgHwBXxgw3zTNxXUoIkYIRKYXuB2SNjcPxrI5cN6QdU5ft8aLqv61MezByn9
         Skir3SYjIi4thmMA+ZaNtCXTpB8zIoHuAXP4x2Li0v0AHE1EAGklVzNFRfD5w0XcO8aw
         NAKrZuz9PjK0bDHSL8idlm6Du30lv3oB9bEmJfs0W0uQ4mHTLhmd1jvwKR4nzmmXhZUZ
         kMNjCskDOQAjK0P1EXeh8f4R5TVcklnmEUbjaNEPz1n8b676CIOwjjrOSGQFBJY1O2Ql
         SU+T+HCUc9gWfrwSXFLpSwyv9XBkGr0MnctGYDbFP4ZydiyRA9B0Eq1gFCoVNhtnBbSD
         xC4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SxlO+FSAxDd632DpLfLCq/OUwvg6eaO8V3k3L6zEVyA=;
        b=Dc2hlFdodj7qGjI+Fc3Eo2QMDdhziQnEza6Ao41nl8nDeTz6C+Uv4g5HOQWByLB/PH
         2nLkgtUI6V/rcCriMUWuoiBGGNIXy8XKsZkt6IkJc7jI24wIR2amv846X/Q6uw0LtoUQ
         lCxM1O7Uvv7REBH/tvaVs6QO44DCkyS9hJ2azfuw/eoH8eKUsajVgbPlaYqbE0nOcz9h
         RH6Sru1H28SAd40mhcb9XHQLGBYatqEEuIzt7FENLsF/BsyNSyBD8MxnN1Pbwko5K6Rt
         4xv/Q6Z4gLb/ekSrOIUnmKJsTOgdXrVrKXAThxYzwO9S/8muQFF60dUKGLwK3ecRwiyt
         fkDw==
X-Gm-Message-State: APjAAAUdpCaKa1b+0wa0TN4fRE5kA+Q+rfAEarqg4vh092j4qhPim9NJ
        JnyPCoZypLmLM+yNKGRJnUulHA==
X-Google-Smtp-Source: APXvYqyWa7oDW4n/vwBZPT9s8zK5XpweT+4yAE05XynKgxzqLcEa8yJCFOcFKJcqjzbZfWH02mCGRQ==
X-Received: by 2002:a63:fa0d:: with SMTP id y13mr13773253pgh.258.1561050835591;
        Thu, 20 Jun 2019 10:13:55 -0700 (PDT)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id s129sm32753pfb.186.2019.06.20.10.13.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Jun 2019 10:13:54 -0700 (PDT)
Date:   Thu, 20 Jun 2019 10:13:52 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
Cc:     lgirdwood@gmail.com, broonie@kernel.org,
        jorge.ramirez-ortiz@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] regulator: qcom_spmi: Do NULL check for lvs
Message-ID: <20190620171352.GA19899@builder>
References: <20190620142228.11773-1-jeffrey.l.hugo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190620142228.11773-1-jeffrey.l.hugo@gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 20 Jun 07:22 PDT 2019, Jeffrey Hugo wrote:

> Low-voltage switches (lvs) don't have set_points since the voltage ranges
> of the output are really controlled by the inputs.  This is a problem for
> the newly added linear range support in the probe(), as that will cause
> a null pointer dereference error on older platforms like msm8974 which
> happen to need to control some of the implemented lvs.
> 
> Fix this by adding the appropriate null check.
> 

Thanks Jeff, this resolves the regression I've seen the last couple of
days on linux-next.

Tested-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> Fixes: 86f4ff7a0c0c ("regulator: qcom_spmi: enable linear range info")
> Reported-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Signed-off-by: Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
> ---
>  drivers/regulator/qcom_spmi-regulator.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/regulator/qcom_spmi-regulator.c b/drivers/regulator/qcom_spmi-regulator.c
> index 877df33e0246..7f51c5fc8194 100644
> --- a/drivers/regulator/qcom_spmi-regulator.c
> +++ b/drivers/regulator/qcom_spmi-regulator.c
> @@ -2045,7 +2045,7 @@ static int qcom_spmi_regulator_probe(struct platform_device *pdev)
>  			}
>  		}
>  
> -		if (vreg->set_points->count == 1) {
> +		if (vreg->set_points && vreg->set_points->count == 1) {
>  			/* since there is only one range */
>  			range = vreg->set_points->range;
>  			vreg->desc.uV_step = range->step_uV;
> -- 
> 2.17.1
> 
