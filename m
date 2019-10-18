Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91387CA9EC9
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 05:30:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63D032067B
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 05:30:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XEk+TXgF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437704AbfJRFa4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 01:30:56 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43003 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727932AbfJRFaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 01:30:55 -0400
Received: by mail-pf1-f195.google.com with SMTP id q12so3115585pff.9
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 22:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FUYBDax7NE3CDwWsYLZOhPAtyneP9Q/Jy0zNmRGZwqk=;
        b=XEk+TXgFbeAE3e37n2OZJ2gc7DQz2UgSVuKwMUCPB2WRmo4ZEUyFBRhanr7tQGVC9X
         qcOGvaw04wTYnk45J4bCBIcwnn6fx7r/2v6wIVQQrsNQ1iIw+v8h94s9XUgVWug4aA6O
         qD8xN/3mgtupJyvN1mFLQzjJ8+J9zeamLEoam6KnRYkgKSMDMvt18aS7XAvqvZuy2o4E
         9EVmvS3JmM21cgRhd4/8ObOSiFvEpeBIJqLHBMJb6kBIilkuoxPvkA7UpE4Kpld/aPl2
         HV1zUNsO6vCMZ2rE8TS0bEtnoi9IMLjHZ/hW61XLGt5k6q22OPcDcp9ewwTgTLi3sz/z
         HUNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FUYBDax7NE3CDwWsYLZOhPAtyneP9Q/Jy0zNmRGZwqk=;
        b=V9YdDY9IvMESv7AggeIi/YU6oEKLjwpx9yz8k5ZzDoiS9V8fBMpb6IEG6iAQf/JgaN
         IHf3B6i8ge51ChV7ALw4Irlrv8BEAdIyfyD6nRuYWZK4TF3uxhmXZ9VNh6jNQNmIxtuL
         vWsZAqdtSrMwp6d9DT3VITwTjG2CcMpDvoMFd8iwgfLTyozM0TeUPr6BMSLhxQJXOWKQ
         4MDdWaGXMS+sYMKuEw9uVaqDc//EbEIBlCJpe00hvIBryH8gPc/pIdXCl6NNpQypyecP
         G7tZdbTEqnxQj4v5Sbr38l5WqoFvnCdOc3AjDzO1YoepjLnQIhtO+ngM2xlcBWph1e/3
         mK7A==
X-Gm-Message-State: APjAAAU4ORBjfgRLqO5W2IxY/kzhNEb3asHjA4VwhvSa3dsqNJ3+0W9b
        71bBZQqXrQbISiDqAYeasxpTTQ==
X-Google-Smtp-Source: APXvYqwu8XgdnF2JM+MIZ5+YJ18wqOQAMwBOQsDC97X7zyp+1ufZ3YNe9XktzUrdJo31658oXdc7GA==
X-Received: by 2002:a17:90a:17c4:: with SMTP id q62mr8306937pja.83.1571372840048;
        Thu, 17 Oct 2019 21:27:20 -0700 (PDT)
Received: from localhost ([122.172.151.112])
        by smtp.gmail.com with ESMTPSA id q6sm6160453pgn.44.2019.10.17.21.27.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Oct 2019 21:27:18 -0700 (PDT)
Date:   Fri, 18 Oct 2019 09:57:15 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Preeti U Murthy <preeti@linux.vnet.ibm.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] cpufreq: powernv: fix stack bloat and NR_CPUS limitation
Message-ID: <20191018042715.f76bawmoyk66isap@vireshk-i7>
References: <20191018000431.1675281-1-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191018000431.1675281-1-jhubbard@nvidia.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17-10-19, 17:04, John Hubbard wrote:
> The following build warning occurred on powerpc 64-bit builds:
> 
> drivers/cpufreq/powernv-cpufreq.c: In function 'init_chip_info':
> drivers/cpufreq/powernv-cpufreq.c:1070:1: warning: the frame size of 1040 bytes is larger than 1024 bytes [-Wframe-larger-than=]

How come we are catching this warning after 4 years ?

> 
> This is due to putting 1024 bytes on the stack:
> 
>     unsigned int chip[256];
> 
> ...and while looking at this, it also has a bug: it fails with a stack
> overrun, if CONFIG_NR_CPUS > 256.
> 
> Fix both problems by dynamically allocating based on CONFIG_NR_CPUS.
> 
> Fixes: 053819e0bf840 ("cpufreq: powernv: Handle throttling due to Pmax capping at chip level")
> Cc: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
> Cc: Preeti U Murthy <preeti@linux.vnet.ibm.com>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> Cc: linux-pm@vger.kernel.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---
> 
> Hi,
> 
> I have only compile-tested this, so I would appreciate if anyone
> could do a basic runtime test on it. But (famous last words) it
> seems simple enough that I'm confident it's correct. oh boy. :)
> 
> thanks,
> John Hubbard
> NVIDIA
> 
>  drivers/cpufreq/powernv-cpufreq.c | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
> index 6061850e59c9..78e04402125f 100644
> --- a/drivers/cpufreq/powernv-cpufreq.c
> +++ b/drivers/cpufreq/powernv-cpufreq.c
> @@ -1041,9 +1041,14 @@ static struct cpufreq_driver powernv_cpufreq_driver = {
>  
>  static int init_chip_info(void)
>  {
> -	unsigned int chip[256];
> +	unsigned int *chip;
>  	unsigned int cpu, i;
>  	unsigned int prev_chip_id = UINT_MAX;
> +	int ret = 0;
> +
> +	chip = kcalloc(CONFIG_NR_CPUS, sizeof(int), GFP_KERNEL);

                                       sizeof(*chip)

> +	if (!chips)

           (!chip)

> +		return -ENOMEM;
>  
>  	for_each_possible_cpu(cpu) {
>  		unsigned int id = cpu_to_chip_id(cpu);
> @@ -1055,8 +1060,10 @@ static int init_chip_info(void)
>  	}
>  
>  	chips = kcalloc(nr_chips, sizeof(struct chip), GFP_KERNEL);
> -	if (!chips)
> -		return -ENOMEM;
> +	if (!chips) {
> +		ret = -ENOMEM;
> +		goto free_and_return;
> +	}
>  
>  	for (i = 0; i < nr_chips; i++) {
>  		chips[i].id = chip[i];
> @@ -1066,7 +1073,9 @@ static int init_chip_info(void)
>  			per_cpu(chip_info, cpu) =  &chips[i];
>  	}
>  
> -	return 0;
> +free_and_return:
> +	kfree(chip);
> +	return ret;
>  }
>  
>  static inline void clean_chip_info(void)
> -- 
> 2.23.0

-- 
viresh
