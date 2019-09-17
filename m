Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34DDAC4CECD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 08:17:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B84920678
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 08:17:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TlQkcOwi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729110AbfIQIRq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 04:17:46 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34415 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725798AbfIQIRq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 04:17:46 -0400
Received: by mail-pl1-f193.google.com with SMTP id d3so1189435plr.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2019 01:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=F3boCEtfwUpsy+Na7nfCDYv10SwPrOANTgsbZ4pSMzw=;
        b=TlQkcOwi2+E1c+r1OTWiG7zaOtqqzZVufSex8xZHdMLjcFNzuaW4lsje52kYV6qIMN
         9gEK8DHoldXJl/rgBAy4hG53QlG0R1QMuWga/x/bK9NMAhJsPohFPA1hPZbytSUgCNyG
         NSS0P+JEWJyG9WbY/5bHTg0bl0pv2qUImVpDu7uzKGGD3AQT6tKWx+xnloG5ThMrRpS1
         GSJuzzJXjnbr8iRbjD52JSfyZrM89keJv3jaQwrzYHEENG4Dyedjv/s7qJXkDu/BGiSD
         sdVdy1eagfTScozKu0veaB/E8YNnfgEYLLvXiXvyWiFxp/vPAoytN6LQNU+ZGzHv2UsA
         mVew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=F3boCEtfwUpsy+Na7nfCDYv10SwPrOANTgsbZ4pSMzw=;
        b=ZL5jnOeJqoxHcK/awevKhYjeZp2tPSbq+SgZ32rUeT3p/wVKD7ILELMIwHReFjk4jo
         KhKwR0/eZ4SIJwnRFaYmtmcn/jBn8PtbJfs4HnnTWTmEfozEVNElxpME5vCHYC+eg/Yn
         W6zMA/D4MNTwczErcERbTE3A+djNYmogEHv/92kQd+zih/CmrVsV2++xk0yK7beKs9p6
         nR7PS2SbVe5jU/Uzmd6k5XUZP0+cEjxIjSSRUYwro6ts1Mt0Y13gqTwrVFCq/oVuHYUA
         k5ZivxwapKpf4HXRRbyAUL/g1LAEqvsUGj+EzC3lgZNr396gg5xMwDhqa9fc+7InKrft
         kfaQ==
X-Gm-Message-State: APjAAAWSxccSgRPfcYYA3X6SbIUteA4jxIAn3vkSXIaQv6Kg51KwZOAG
        86XIhr8gYmQl9hYEjdoCkZXOOw==
X-Google-Smtp-Source: APXvYqwNaqny1OEDhX1NcIm1yReLAq5ctcXj8dcflq9EEMy5Ef0nOc5/fpAELtYRznjciNeXmlD/dw==
X-Received: by 2002:a17:902:9001:: with SMTP id a1mr2450812plp.148.1568708265107;
        Tue, 17 Sep 2019 01:17:45 -0700 (PDT)
Received: from localhost ([122.172.73.172])
        by smtp.gmail.com with ESMTPSA id f12sm1428941pfn.73.2019.09.17.01.17.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Sep 2019 01:17:44 -0700 (PDT)
Date:   Tue, 17 Sep 2019 09:17:42 +0100
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com, agross@kernel.org,
        tdas@codeaurora.org, swboyd@chromium.org, ilina@codeaurora.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org
Subject: Re: [PATCH 5/5] cpufreq: qcom-hw: Move driver initialisation earlier
Message-ID: <20190917081742.fwoytnx4mzslcan7@vireshk-mac-ubuntu>
References: <cover.1568240476.git.amit.kucheria@linaro.org>
 <b731b713d8738239c26361ece7f5cadea035b353.1568240476.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b731b713d8738239c26361ece7f5cadea035b353.1568240476.git.amit.kucheria@linaro.org>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12-09-19, 04:02, Amit Kucheria wrote:
> Allow qcom-hw driver to initialise right after the cpufreq and thermal
> subsystems are initialised in core_initcall so we get earlier access to
> thermal mitigation.
> 
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> ---
>  drivers/cpufreq/qcom-cpufreq-hw.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
> index 4b0b50403901..04676cc82ba6 100644
> --- a/drivers/cpufreq/qcom-cpufreq-hw.c
> +++ b/drivers/cpufreq/qcom-cpufreq-hw.c
> @@ -327,7 +327,7 @@ static int __init qcom_cpufreq_hw_init(void)
>  {
>  	return platform_driver_register(&qcom_cpufreq_hw_driver);
>  }
> -device_initcall(qcom_cpufreq_hw_init);
> +postcore_initcall(qcom_cpufreq_hw_init);

Even core_initcall should work just fine because of the ordering in
the Makefile in cpufreq directory.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
