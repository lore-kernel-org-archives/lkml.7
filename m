Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31D5CC73C6D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 06:30:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 095DC20693
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 06:30:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="csvKeo3A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbfGJGaa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 02:30:30 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:37561 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbfGJGa3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 02:30:29 -0400
Received: by mail-pl1-f195.google.com with SMTP id b3so691627plr.4
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2019 23:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=L2UuFu7XqMvM2r1vOn9PSk+syiHes80VSZWRI0KeN7o=;
        b=csvKeo3AFSwF0zvXaa7Nb84I6Hp1Rnfm2HabCf4Q/r/5wo6bjIb9wsBIb5ooDOBTIK
         diX/esesvK4hjIMo90u1BW6YAVin333lMooqSuIgDYkAzIrMou7LtcJiWK2phGIYvDwL
         TR1Yyge867FIL67j2G34XWWRJ7rxO5zUk6ZTnPvQYe2XttLceLcHwn5RuK7W3HMzAlfs
         aScdN/JD0V6vAHfy5681hhYzhVbZx8mfR0eePYuhL+xHfeMgosR7nc9DRa1blCrJSz43
         Mu7zXf1IIGpdVvnrRWjHHiLja5rNXPJ2wXkhDRoyfSArqQq1Pe7TNZ1FHlmzsBPbA0he
         nQPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=L2UuFu7XqMvM2r1vOn9PSk+syiHes80VSZWRI0KeN7o=;
        b=qucilGteNVV3Lwez61/HOEu+P70+bYXrvz5a3CLYa8OfQ+e9AaJgVPwdYUUgXL6eDM
         BEYK25WE5wrOm8l8ndpjom8wx3Zgs5s/r4T2J41ORnkMplLd1kKi/jjwdLDZfccImEVW
         LLwTduVFZEYNW90yLDDVGIUYm4cgE5BUqV9EggR7AF8lsYM4SaB31nts94ppwV7sAD55
         TMVEGBhnVnDQmgu9JNnFhXJ29fOS2qJunBmh8m9Vnp58F18oNAJBUM9u+dfRXEKtekzb
         Vf4yzoeuaiOb328p3cDDFFstivTSEEqkU5AM6AnmoCrp4yakGRvo06CkqyK+M2elwiaF
         PIRQ==
X-Gm-Message-State: APjAAAV4J9J0m2bvK4pj2I+Vh7GdtNq98Pbqjmt5XnOCJl44z+NDKckB
        grRO/SHhayhfruHQr+ZvbVUNpg==
X-Google-Smtp-Source: APXvYqykauyIqhVaUB25f/INL57OtdOvUb7VF5uzrbYjjTM0qNLZZF8nHJGHW0OIfH2Lpbu3ikeBTg==
X-Received: by 2002:a17:902:b949:: with SMTP id h9mr28473553pls.120.1562740228543;
        Tue, 09 Jul 2019 23:30:28 -0700 (PDT)
Received: from localhost ([122.172.28.117])
        by smtp.gmail.com with ESMTPSA id p68sm1979337pfb.80.2019.07.09.23.30.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jul 2019 23:30:27 -0700 (PDT)
Date:   Wed, 10 Jul 2019 12:00:26 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Niklas Cassel <niklas.cassel@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, Ilia Lin <ilia.lin@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-arm-msm@vger.kernel.org, jorge.ramirez-ortiz@linaro.org,
        sboyd@kernel.org, vireshk@kernel.org, bjorn.andersson@linaro.org,
        ulf.hansson@linaro.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/13] cpufreq: qcom: Refactor the driver to make it
 easier to extend
Message-ID: <20190710063026.7yyoxjsqp2ck3z6n@vireshk-i7>
References: <20190705095726.21433-1-niklas.cassel@linaro.org>
 <20190705095726.21433-5-niklas.cassel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190705095726.21433-5-niklas.cassel@linaro.org>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05-07-19, 11:57, Niklas Cassel wrote:
> +	drv->opp_tables = kcalloc(num_possible_cpus(), sizeof(*drv->opp_tables),
> +				  GFP_KERNEL);
> +	if (!drv->opp_tables) {
> +		ret = -ENOMEM;
> +		goto free_drv;
> +	}
>  
>  	for_each_possible_cpu(cpu) {
>  		cpu_dev = get_cpu_device(cpu);
> @@ -166,19 +195,23 @@ static int qcom_cpufreq_probe(struct platform_device *pdev)
>  			goto free_opp;
>  		}
>  
> -		opp_tables[cpu] = dev_pm_opp_set_supported_hw(cpu_dev,
> -							      &versions, 1);
> -		if (IS_ERR(opp_tables[cpu])) {
> -			ret = PTR_ERR(opp_tables[cpu]);
> -			dev_err(cpu_dev, "Failed to set supported hardware\n");
> -			goto free_opp;
> +		if (drv->data->get_version) {

Why depend on get_version here ? The OPP table is already allocated
unconditionally.

> +			drv->opp_tables[cpu] =
> +				dev_pm_opp_set_supported_hw(cpu_dev,
> +							    &drv->versions, 1);
> +			if (IS_ERR(drv->opp_tables[cpu])) {
> +				ret = PTR_ERR(drv->opp_tables[cpu]);
> +				dev_err(cpu_dev,
> +					"Failed to set supported hardware\n");
> +				goto free_opp;
> +			}
>  		}
>  	}

-- 
viresh
