Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0934DC74A35
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 14:57:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C37B621537
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 14:57:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NUlVnSN1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729021AbfGKO5f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 10:57:35 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40807 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728594AbfGKO5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 10:57:35 -0400
Received: by mail-pl1-f195.google.com with SMTP id a93so3168089pla.7
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2019 07:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1/51w3laLLHPJ0Jx8O5jQMFKbvaBG/KhA0i4QusfUus=;
        b=NUlVnSN1ZMozKzTTGTTf+dnmZy+oc7h+fkpA9vhU47HxFHvlVDPSulkA1Se+YW0lul
         a2Hl+Y+UF18CpnIowTxwNNiel7ZRfnqqs8kywkv/NBUopy1XvcOOZJMB3iAT0EXbtseS
         VAzcoF4h8N7Q9r6KXfZdvxPjGp0UjEV+v3L3IgsHLIyiRi7CrwchE/rsxF593RlIxYHi
         3wiwOvkX6fhJh2rotOBUo9vVg2/Xyp0lUMABQezBmPnrFbCPGRndV2BOmlH/aWDp57+s
         gfmEyQlNCfGHDvidcClyVlOqb9FZMYOAicIGBfnKPPwvWhttN9JYVRiE24tySch7kg15
         oZXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1/51w3laLLHPJ0Jx8O5jQMFKbvaBG/KhA0i4QusfUus=;
        b=Qx/LLeN+WPs7xLeAFBXthEuVIbJXrOXbcKyvqsfByb2LeBGdqUxUFDZwn+NghlOWlu
         5Bnk8a0udRVk9KgmHcuJKmkJo9sgHiNnLAIIgBtDghobLPJ/que6UZcZY63dnpzu698a
         hoNWUPpvvUWWcDf3FAtTtwIi+6NR8noR+CJOuLa7+2z8oMTYLl/fqKMBNlYDZygbMF4M
         GzvWL/PGwQgia/A0LLvWK63gQTMaHMsmg3aEfEhTHf2vKsUA3/H8mV8LQsxcI6PlqXSS
         Qr0fahlGO+UYEBFqvdktxfHOk45+IWAxS3eqBFD3cyUfAFJDGG+tMRMMkpM9RaIbC1Mv
         AiFA==
X-Gm-Message-State: APjAAAUxx1GxB1elXlhZIcfUB2MMSt8HvlcH4GrLW1lyq8RSfNblJZRR
        N9As6dlUF1Tbs4rDqYmz3jEtCg==
X-Google-Smtp-Source: APXvYqz9ilITyyaY2+RDyr6nQhrALzPWqIjNUnMLGWpxZ53G74RZ+C2rjf+qUux7JInSF+mZPbR+/g==
X-Received: by 2002:a17:902:848b:: with SMTP id c11mr5083756plo.217.1562857053720;
        Thu, 11 Jul 2019 07:57:33 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id x13sm6878242pfn.6.2019.07.11.07.57.31
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 11 Jul 2019 07:57:33 -0700 (PDT)
Date:   Thu, 11 Jul 2019 07:58:38 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
Cc:     sboyd@kernel.org, david.brown@linaro.org, jassisinghbrar@gmail.com,
        mark.rutland@arm.com, mturquette@baylibre.com, robh+dt@kernel.org,
        will.deacon@arm.com, arnd@arndb.de, horms+renesas@verge.net.au,
        heiko@sntech.de, sibis@codeaurora.org,
        enric.balletbo@collabora.com, jagan@amarulasolutions.com,
        olof@lixom.net, vkoul@kernel.org, niklas.cassel@linaro.org,
        georgi.djakov@linaro.org, amit.kucheria@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, khasim.mohammed@linaro.org
Subject: Re: [PATCH v3 05/14] clk: qcom: apcs-msm8916: get parent clock names
 from DT
Message-ID: <20190711145838.GF7234@tuxbook-pro>
References: <20190625164733.11091-1-jorge.ramirez-ortiz@linaro.org>
 <20190625164733.11091-6-jorge.ramirez-ortiz@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190625164733.11091-6-jorge.ramirez-ortiz@linaro.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 25 Jun 09:47 PDT 2019, Jorge Ramirez-Ortiz wrote:

> Allow accessing the parent clock names required for the driver
> operation by using the device tree node.
> 
> This permits extending the driver to other platforms without having to
> modify its source code.
> 
> For backwards compatibility leave previous values as default.
> 
> Co-developed-by: Niklas Cassel <niklas.cassel@linaro.org>
> Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> ---
>  drivers/clk/qcom/apcs-msm8916.c | 23 ++++++++++++++++++++---
>  1 file changed, 20 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/clk/qcom/apcs-msm8916.c b/drivers/clk/qcom/apcs-msm8916.c
> index a6c89a310b18..dd82eb1e5202 100644
> --- a/drivers/clk/qcom/apcs-msm8916.c
> +++ b/drivers/clk/qcom/apcs-msm8916.c
> @@ -19,7 +19,7 @@
>  
>  static const u32 gpll0_a53cc_map[] = { 4, 5 };
>  
> -static const char * const gpll0_a53cc[] = {
> +static const char *gpll0_a53cc[] = {
>  	"gpll0_vote",
>  	"a53pll",
>  };
> @@ -50,6 +50,8 @@ static int qcom_apcs_msm8916_clk_probe(struct platform_device *pdev)
>  	struct regmap *regmap;
>  	struct clk_init_data init = { };
>  	int ret = -ENODEV;
> +	const char *parents[2];
> +	int pll_index = 0;
>  
>  	regmap = dev_get_regmap(parent, NULL);
>  	if (!regmap) {
> @@ -61,6 +63,16 @@ static int qcom_apcs_msm8916_clk_probe(struct platform_device *pdev)
>  	if (!a53cc)
>  		return -ENOMEM;
>  
> +	/* legacy bindings only defined the pll parent clock (index = 0) with no
> +	 * name; when both of the parents are specified in the bindings, the
> +	 * pll is the second one (index = 1).
> +	 */
> +	if (of_clk_parent_fill(parent->of_node, parents, 2) == 2) {
> +		gpll0_a53cc[0] = parents[0];
> +		gpll0_a53cc[1] = parents[1];
> +		pll_index = 1;
> +	}
> +
>  	init.name = "a53mux";
>  	init.parent_names = gpll0_a53cc;
>  	init.num_parents = ARRAY_SIZE(gpll0_a53cc);
> @@ -76,10 +88,11 @@ static int qcom_apcs_msm8916_clk_probe(struct platform_device *pdev)
>  	a53cc->src_shift = 8;
>  	a53cc->parent_map = gpll0_a53cc_map;
>  
> -	a53cc->pclk = devm_clk_get(parent, NULL);
> +	a53cc->pclk = of_clk_get(parent->of_node, pll_index);
>  	if (IS_ERR(a53cc->pclk)) {
>  		ret = PTR_ERR(a53cc->pclk);
> -		dev_err(dev, "failed to get clk: %d\n", ret);
> +		if (ret != -EPROBE_DEFER)
> +			dev_err(dev, "failed to get clk: %d\n", ret);
>  		return ret;
>  	}
>  
> @@ -87,6 +100,7 @@ static int qcom_apcs_msm8916_clk_probe(struct platform_device *pdev)
>  	ret = clk_notifier_register(a53cc->pclk, &a53cc->clk_nb);
>  	if (ret) {
>  		dev_err(dev, "failed to register clock notifier: %d\n", ret);
> +		clk_put(a53cc->pclk);
>  		return ret;
>  	}
>  
> @@ -109,6 +123,8 @@ static int qcom_apcs_msm8916_clk_probe(struct platform_device *pdev)
>  
>  err:
>  	clk_notifier_unregister(a53cc->pclk, &a53cc->clk_nb);
> +	clk_put(a53cc->pclk);
> +
>  	return ret;
>  }
>  
> @@ -117,6 +133,7 @@ static int qcom_apcs_msm8916_clk_remove(struct platform_device *pdev)
>  	struct clk_regmap_mux_div *a53cc = platform_get_drvdata(pdev);
>  
>  	clk_notifier_unregister(a53cc->pclk, &a53cc->clk_nb);
> +	clk_put(a53cc->pclk);
>  
>  	return 0;
>  }
> -- 
> 2.21.0
> 
