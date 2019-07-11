Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5477C74A48
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 06:22:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEBF820838
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 06:22:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bCJUZdgF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728030AbfGKGWa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 02:22:30 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35639 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727972AbfGKGWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 02:22:30 -0400
Received: by mail-pl1-f194.google.com with SMTP id w24so2482073plp.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2019 23:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2/izmyLx3zgLly59CRyGw1zLBbtbQty91ZENtAWD4Vk=;
        b=bCJUZdgFXSL1JPheXWrE2SvDktcgz7ZRvLp8UkZ09vb/Prg3mHtmdw0CdPu+kNUcGI
         a+TMxXx6wNfmwQtEtIXMhXKR2VzbJQGJVBT4Jcr78m07BpKzdxphTgR8GXJ75FNnpqAB
         FNgXp0c4Bq/bsz0u8wFe6FU1NqqZn1sx5kV5TnReJTFWuqsfXI0nlrO3bGvOpcXDoF9E
         kH2fUTOxrcxqE6WyOVzMskdFpKOYyKgmdeY68u0Bz7QfklwW+Yz9KVGimSXOF4E3tW+I
         Ndk3OY2HRkZ2wOYaljBN7Ygo+45k9VGREMHudaTh1IrRGsaLJbxdRM0v/ZdSiMQ7S5FG
         78xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2/izmyLx3zgLly59CRyGw1zLBbtbQty91ZENtAWD4Vk=;
        b=RF/RMbpAxHP1luxjX/0j6nMVAZP2CvZ19GXZnqmpTb6x/7S/yte1WSEM++hVl8TN8c
         +SzSFYoJD0Pom209gVXC4QHmkq+uP2xywmuN8RZdsA/+BHB7854nbs+xT8/eAyIWt8vl
         1qIxwKK62MldHL2/8X5J5iC/IQw6TJ4vYSnbudDtci230lcGC4jFE036pZAzlfqcjE3S
         AMgpdLSduxO/26uNPxErEfG5h75xBFlhNwjiv1ws0pQqs0yIpfoNURe+GVfZKt/lhjDZ
         5ZFnUHxY0p4gVgDspPlKsDebpuwR5m/mD1ZFJxHFIvi1NTHF+5mtMr2yaR6vjrX/7/wo
         rLaA==
X-Gm-Message-State: APjAAAU1xUPb3TnK21xcPYy3STq109MY4P0PhkJkOvK0AhLkmM8vQUHY
        eChVPis5873JxMC4GRw5PTCxEg==
X-Google-Smtp-Source: APXvYqzBa57SST8CdNhPOntlhzTG7OeoEa6rXNRY1hYntSU2vCbtVOJveAMlqx/1mMk4cJDBYNLgNw==
X-Received: by 2002:a17:902:da4:: with SMTP id 33mr2477954plv.209.1562826149501;
        Wed, 10 Jul 2019 23:22:29 -0700 (PDT)
Received: from localhost ([122.172.28.117])
        by smtp.gmail.com with ESMTPSA id j19sm1516594pgn.19.2019.07.10.23.22.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Jul 2019 23:22:28 -0700 (PDT)
Date:   Thu, 11 Jul 2019 11:52:26 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     k.konieczny@partner.samsung.com
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Mark Rutland <mark.rutland@arm.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH 1/3] opp: core: add regulators enable and disable
Message-ID: <20190711062226.4i4bvbsyczshdlyr@vireshk-i7>
References: <20190708141140.24379-1-k.konieczny@partner.samsung.com>
 <CGME20190708141159eucas1p1751506975ff96a436e14940916623722@eucas1p1.samsung.com>
 <20190708141140.24379-2-k.konieczny@partner.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190708141140.24379-2-k.konieczny@partner.samsung.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08-07-19, 16:11, k.konieczny@partner.samsung.com wrote:
> From: Kamil Konieczny <k.konieczny@partner.samsung.com>
> 
> Add enable regulators to dev_pm_opp_set_regulators() and disable
> regulators to dev_pm_opp_put_regulators(). This prepares for
> converting exynos-bus devfreq driver to use dev_pm_opp_set_rate().
> 
> Signed-off-by: Kamil Konieczny <k.konieczny@partner.samsung.com>
> ---
>  drivers/opp/core.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index 0e7703fe733f..947cac452854 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -1580,8 +1580,19 @@ struct opp_table *dev_pm_opp_set_regulators(struct device *dev,
>  	if (ret)
>  		goto free_regulators;
>  
> +	for (i = 0; i < opp_table->regulator_count; i++) {
> +		ret = regulator_enable(opp_table->regulators[i]);
> +		if (ret < 0)
> +			goto disable;
> +	}

What about doing this in the same loop of regulator_get_optional() ?

> +
>  	return opp_table;
>  
> +disable:
> +	while (i != 0)
> +		regulator_disable(opp_table->regulators[--i]);
> +
> +	i = opp_table->regulator_count;

You also need to call _free_set_opp_data() here.

>  free_regulators:
>  	while (i != 0)
>  		regulator_put(opp_table->regulators[--i]);
> @@ -1609,6 +1620,8 @@ void dev_pm_opp_put_regulators(struct opp_table *opp_table)
>  
>  	/* Make sure there are no concurrent readers while updating opp_table */
>  	WARN_ON(!list_empty(&opp_table->opp_list));

Preserve the blank line here.

> +	for (i = opp_table->regulator_count - 1; i >= 0; i--)
> +		regulator_disable(opp_table->regulators[i]);
>  
>  	for (i = opp_table->regulator_count - 1; i >= 0; i--)
>  		regulator_put(opp_table->regulators[i]);

Only single loop should be sufficient for this.

> -- 
> 2.22.0

-- 
viresh
