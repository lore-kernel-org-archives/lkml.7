Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 615CDC5B57D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 06:27:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39D5420665
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 06:27:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wHrS2MKg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729108AbfGHG1M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 02:27:12 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45858 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728474AbfGHG1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 02:27:11 -0400
Received: by mail-pl1-f194.google.com with SMTP id y8so2989435plr.12
        for <linux-kernel@vger.kernel.org>; Sun, 07 Jul 2019 23:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PvaTWFd0jIyj/jWh/gLuDIg+Wz9VdaFcROd1jUU6H5M=;
        b=wHrS2MKgp/qpIFuWhyshvwk7x2tGKyT32qYGZauN0EYywHuPJyrg5ulDYUNFbZ4QNO
         58Ztvc5wOabwQGRa4Lv6Rk28SjdXgvagQt6yX931q03CfOsah3bf/t5myrB0Vs1+YgHF
         LY6zSMxF3ql+oh9z3joSHf/Twfb/WwJX+iZrHMK2G+yWniFiHStbYMpn0jI+qzUXlS0T
         9JoAFd849ZRHJeTmodQFaDLNDP3/J46tcyp4vzEXo6BRtWbP5Fu6mwdWymT/DrOSdmUJ
         ZImcGLQkaDli0BPtB5r0kbTt7aoUXMpGefJy2w7ISitK0rrwfC75uthm9iXe6nYU5duR
         9Tlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PvaTWFd0jIyj/jWh/gLuDIg+Wz9VdaFcROd1jUU6H5M=;
        b=T3z0MznR2p25k8fGKdPL7Pf2R5SizzCRFv3rYZRmV9D4Mkqa97x8hDtkfQ00/D8gh/
         AFvbnWQHXFbdQ9iCC7xXEER7r8Wa1ODKRHG5gXLOZXRW7VZ6G4/9eSeDKcdY+filMRoo
         rt6q491QhU0qHebKkg05DBeB6PJdN3eEjVbvVFy9U3X0s6PHCA6KOEwgiNIXnrC5cs/P
         1ZY9/JKlAEAvnnlaQoV4GdzHaDbHZNsIoiJy6bFkbXioNTkAEBvkPMeqp1usfwcPbSQU
         h5OtrpPx/EKgwWYcGQqe15wdLRCCMmnmLqytjhuGWTJ0dvYwolHbJmuDstFtR3dIBoaO
         mQaA==
X-Gm-Message-State: APjAAAW1D20Ioqg6jGGHqwU5Wvu7hi1W0MvsKZHL+kXVOm+73K4lmNm+
        BWpOPBFZQmietQuDsFVeVIJhjw==
X-Google-Smtp-Source: APXvYqwRjKnkWqnGnTkhQ05etsgpHpjlfberNuCPbKjt7IDKyX3jURUFRxp7JkDCe8+PHZdI8BnNTg==
X-Received: by 2002:a17:902:f301:: with SMTP id gb1mr21987709plb.292.1562567230900;
        Sun, 07 Jul 2019 23:27:10 -0700 (PDT)
Received: from localhost ([122.172.28.117])
        by smtp.gmail.com with ESMTPSA id v10sm17791814pfe.163.2019.07.07.23.27.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Jul 2019 23:27:10 -0700 (PDT)
Date:   Mon, 8 Jul 2019 11:57:08 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Wen Yang <wen.yang99@zte.com.cn>
Cc:     linux-kernel@vger.kernel.org, xue.zhihong@zte.com.cn,
        wang.yi59@zte.com.cn, cheng.shengyu@zte.com.cn,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linuxppc-dev@lists.ozlabs.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH] cpufreq/pasemi: fix an use-after-free in
 pas_cpufreq_cpu_init()
Message-ID: <20190708062708.5zufqsmgso436idn@vireshk-i7>
References: <1562566745-7447-1-git-send-email-wen.yang99@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1562566745-7447-1-git-send-email-wen.yang99@zte.com.cn>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08-07-19, 14:19, Wen Yang wrote:
> The cpu variable is still being used in the of_get_property() call
> after the of_node_put() call, which may result in use-after-free.
> 
> Fixes: a9acc26b75f ("cpufreq/pasemi: fix possible object reference leak")
> Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: linux-pm@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  drivers/cpufreq/pasemi-cpufreq.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)

I will suggest some changes here.

> diff --git a/drivers/cpufreq/pasemi-cpufreq.c b/drivers/cpufreq/pasemi-cpufreq.c
> index 6b1e4ab..d2dd47b 100644
> --- a/drivers/cpufreq/pasemi-cpufreq.c
> +++ b/drivers/cpufreq/pasemi-cpufreq.c
> @@ -132,7 +132,6 @@ static int pas_cpufreq_cpu_init(struct cpufreq_policy *policy)

Don't initialize "err" anymore.

>  	cpu = of_get_cpu_node(policy->cpu, NULL);
>  
> -	of_node_put(cpu);
>  	if (!cpu)
>  		goto out;

Do return -ENODEV; here.

>  
> @@ -141,15 +140,15 @@ static int pas_cpufreq_cpu_init(struct cpufreq_policy *policy)
>  		dn = of_find_compatible_node(NULL, NULL,
>  					     "pasemi,pwrficient-sdc");
>  	if (!dn)
> -		goto out;
> +		goto out_put_cpu_node;
>  	err = of_address_to_resource(dn, 0, &res);
>  	of_node_put(dn);
>  	if (err)
> -		goto out;
> +		goto out_put_cpu_node;
>  	sdcasr_mapbase = ioremap(res.start + SDCASR_OFFSET, 0x2000);
>  	if (!sdcasr_mapbase) {
>  		err = -EINVAL;
> -		goto out;
> +		goto out_put_cpu_node;
>  	}

Don't do above changes.

>  
>  	dn = of_find_compatible_node(NULL, NULL, "1682m-gizmo");
> @@ -177,6 +176,7 @@ static int pas_cpufreq_cpu_init(struct cpufreq_policy *policy)
>  		err = -EINVAL;
>  		goto out_unmap_sdcpwr;
>  	}
> +	of_node_put(cpu);
>  
>  	/* we need the freq in kHz */
>  	max_freq = *max_freqp / 1000;
> @@ -203,6 +203,8 @@ static int pas_cpufreq_cpu_init(struct cpufreq_policy *policy)
>  
>  out_unmap_sdcasr:
>  	iounmap(sdcasr_mapbase);
> +out_put_cpu_node:

Don't add this label, instead use "out" for also having the below
code.

> +	of_node_put(cpu);
>  out:
>  	return err;
>  }
> -- 
> 2.9.5

-- 
viresh
