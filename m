Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AA4FC3A5A5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 07:30:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53D7A2332B
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 07:30:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Kv5HIPYV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732040AbfIEHaq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 03:30:46 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42048 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732011AbfIEHaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 03:30:46 -0400
Received: by mail-wr1-f68.google.com with SMTP id q14so1399336wrm.9
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2019 00:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UrUg55b04dM+yl9nRPJPjzzhoddXyzVLDYekdXcQSgc=;
        b=Kv5HIPYVfI9PgdgwlCV07ZyFJgXqw7sq2+0Vh5bvfl+bSA4H2DjB6yuku9I/09UJw0
         c7wiE0Ah5S4Fwoi9aBtWJH9SA4mfKNahb4AgmRQ8aZPo9BWBWuINo1P0Tn7z4hJ+4o1s
         m9aEA88V6xZZlC5r+OqaJE0phxLyFQx9G2JkUi6cTgFXGyHk7dyWzV6kVkwQsDV1KUBY
         TvfJiDilT5QL7nboF06DNKSjOH+13DXqo4K76QFFXnFY+3lzNTkOCb27liOVWBjTBcwN
         2cuANjLSloAdEcbrbP/5EwasNynZDopVKktayAkqiU9ZOqJSJblQ4qdOTzyJwGtq4u6k
         IPrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UrUg55b04dM+yl9nRPJPjzzhoddXyzVLDYekdXcQSgc=;
        b=RgBIYW4HcnRM3+a5Tbe2LXeu5GdRy342udolDiFdZ0LdUzegNtIMFJrfT1OZmgdoH2
         PFxHkEt4xTRn1FQnNpuh4qxrXLBcE3N702UsJFzFkvMvDpDKPofiK3PQ8swHYntcwU0G
         bvwFN16UcWl2qhzPk4/GWXljCgTmbXifBv7UP6X3sopk8juVjK+V3Zf2epvesDSYIl39
         z0x8oc3SJbvIo8+7ByOXImt+Vp8EShW+gFnHyiHb+0ujCoJdItcCUk1xg5YnAB/UaDgT
         wo06sPqkqskY2ZMq2LA4uqttNU6RAk76YH+836/PF91BKJtGuuqZSDSCwrYklB1kxnd3
         uhnA==
X-Gm-Message-State: APjAAAXlghgmWhpoKTTMLolg4/xbtB18fTn6DGWCnJ1vLhTEQE/eXJDR
        HkAtslWIOaaUhSt0e2vZYDNxmii2AhQ=
X-Google-Smtp-Source: APXvYqxH10enx77PdMtYP8D35eEzL9IT8FWMAW4RDBDvOLJ+k8dnLJcHq1w5oeNLhxbZDZ5naLBEdQ==
X-Received: by 2002:adf:f20f:: with SMTP id p15mr1376482wro.17.1567668644139;
        Thu, 05 Sep 2019 00:30:44 -0700 (PDT)
Received: from [192.168.1.6] (124.red-83-36-179.dynamicip.rima-tde.net. [83.36.179.124])
        by smtp.gmail.com with ESMTPSA id j26sm3633386wrd.2.2019.09.05.00.30.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Sep 2019 00:30:43 -0700 (PDT)
Subject: Re: [PATCH 1/5] clk: qcom: gcc: limit GPLL0_AO_OUT operating
 frequency
To:     sboyd@kernel.org, agross@kernel.org, mturquette@baylibre.com
Cc:     bjorn.andersson@linaro.org, niklas.cassel@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190826164510.6425-1-jorge.ramirez-ortiz@linaro.org>
From:   Jorge Ramirez <jorge.ramirez-ortiz@linaro.org>
Message-ID: <f2e43da9-2d31-e8d5-83d2-77020e85e2a7@linaro.org>
Date:   Thu, 5 Sep 2019 09:30:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190826164510.6425-1-jorge.ramirez-ortiz@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/26/19 18:45, Jorge Ramirez-Ortiz wrote:
> Limit the GPLL0_AO_OUT_MAIN operating frequency as per its hardware
> specifications.
> 
> Co-developed-by: Niklas Cassel <niklas.cassel@linaro.org>
> Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Acked-by: Stephen Boyd <sboyd@kernel.org>
> ---
>  drivers/clk/qcom/clk-alpha-pll.c | 8 ++++++++
>  drivers/clk/qcom/clk-alpha-pll.h | 1 +
>  drivers/clk/qcom/gcc-qcs404.c    | 2 +-
>  3 files changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/qcom/clk-alpha-pll.c b/drivers/clk/qcom/clk-alpha-pll.c
> index 055318f97991..9228b7b1f56e 100644
> --- a/drivers/clk/qcom/clk-alpha-pll.c
> +++ b/drivers/clk/qcom/clk-alpha-pll.c
> @@ -878,6 +878,14 @@ static long clk_trion_pll_round_rate(struct clk_hw *hw, unsigned long rate,
>  	return clamp(rate, min_freq, max_freq);
>  }
>  
> +const struct clk_ops clk_alpha_pll_fixed_ops = {
> +	.enable = clk_alpha_pll_enable,
> +	.disable = clk_alpha_pll_disable,
> +	.is_enabled = clk_alpha_pll_is_enabled,
> +	.recalc_rate = clk_alpha_pll_recalc_rate,
> +};
> +EXPORT_SYMBOL_GPL(clk_alpha_pll_fixed_ops);
> +
>  const struct clk_ops clk_alpha_pll_ops = {
>  	.enable = clk_alpha_pll_enable,
>  	.disable = clk_alpha_pll_disable,
> diff --git a/drivers/clk/qcom/clk-alpha-pll.h b/drivers/clk/qcom/clk-alpha-pll.h
> index 15f27f4b06df..c28eb1a08c0c 100644
> --- a/drivers/clk/qcom/clk-alpha-pll.h
> +++ b/drivers/clk/qcom/clk-alpha-pll.h
> @@ -109,6 +109,7 @@ struct alpha_pll_config {
>  };
>  
>  extern const struct clk_ops clk_alpha_pll_ops;
> +extern const struct clk_ops clk_alpha_pll_fixed_ops;
>  extern const struct clk_ops clk_alpha_pll_hwfsm_ops;
>  extern const struct clk_ops clk_alpha_pll_postdiv_ops;
>  extern const struct clk_ops clk_alpha_pll_huayra_ops;
> diff --git a/drivers/clk/qcom/gcc-qcs404.c b/drivers/clk/qcom/gcc-qcs404.c
> index e12c04c09a6a..567140709c7d 100644
> --- a/drivers/clk/qcom/gcc-qcs404.c
> +++ b/drivers/clk/qcom/gcc-qcs404.c
> @@ -330,7 +330,7 @@ static struct clk_alpha_pll gpll0_ao_out_main = {
>  			.parent_names = (const char *[]){ "cxo" },
>  			.num_parents = 1,
>  			.flags = CLK_IS_CRITICAL,
> -			.ops = &clk_alpha_pll_ops,
> +			.ops = &clk_alpha_pll_fixed_ops,
>  		},
>  	},
>  };
> 

just a quick follow up, is this series being picked-up?
