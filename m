Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0746BC28EBD
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 03:05:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C320F206DF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 03:05:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gWJqJqZ/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726822AbfFGDFv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 23:05:51 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44696 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726519AbfFGDFv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 23:05:51 -0400
Received: by mail-pl1-f195.google.com with SMTP id c5so231213pll.11
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2019 20:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=H7CLFdoBPP7l3IEmTINBabW4dT5YeAQBXDwoCOrfxvs=;
        b=gWJqJqZ/rTPWluupY1DKV0rs4A0c12jlcS2mQCrIgvFlvE4DLaYkH0Mpnaqh6CFTRk
         hQ5vDNYBgxu2Mp6ixcG6H+sfcV7pgJI89ga9Gbii2TFfvWvN+kSVqR8IFnA4xblRNN+V
         0xrL9CLXQNm4N0vSzsdojo6s2BbCNoo2nC9Qm/Sp8qDo2UT6U0XjkalIqnBqaKhVTJKl
         dmriwLNb/yJj5YShFvsJRqGETxyylTOFYNIUf1j8iq1dTvBPYyPDDgWTXhKqsDIXuYCU
         ouPHkzdk4erPChcVHtkKctfxV+MGw/a0OJUQNxgrPH+6eRUHzmcT1c11gypDlW1AXZqb
         kSaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=H7CLFdoBPP7l3IEmTINBabW4dT5YeAQBXDwoCOrfxvs=;
        b=fn7qE60FuVf5NgcCKePBi4FVOQokDv7hVhcgiGwWrXH3KwhbVrTu23SD2b4p+BmOym
         UOjU1ssQU6/6sCaYLB+aDfynUwZx21N29H+DaXY1j/Qmk3liAEoPvhyxdQmBUWl+ePzl
         4ptdShcJZUePgfKDN1qvymnk+rNXjdOGQqOd+zall3z+DgpzC8vVVyXCMiHdGNZv7WXO
         W8OoLkqC6LL+ihlCeOS61LaETxe+kmuyscLfA/T/G//Q8gw0s7K5o+TDS9Z3GDaw9qsH
         HLDcfbn4AX1KjEa7KotJRnkVkxmDuMAx61hbwjtbCrWzjE+245p1Wj1+Jhoya5o/e5u0
         nJeg==
X-Gm-Message-State: APjAAAUkn5jkN5b/CpbByqtUCryhawbChGwOqN0rKYi+eLpuSIRTuQ9S
        YE4YFObtl6I1nvSyPaak1jHQiA==
X-Google-Smtp-Source: APXvYqzOsQK1uUlnEwMVs04oCLLIhbjE1dCIGxyd7z/1Wp6i3/lBhIk8qFnzdWcwXwlca7/ZPbULGQ==
X-Received: by 2002:a17:902:2ae6:: with SMTP id j93mr54928338plb.130.1559876750555;
        Thu, 06 Jun 2019 20:05:50 -0700 (PDT)
Received: from localhost ([122.172.66.84])
        by smtp.gmail.com with ESMTPSA id n184sm529337pfn.21.2019.06.06.20.05.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Jun 2019 20:05:48 -0700 (PDT)
Date:   Fri, 7 Jun 2019 08:35:46 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     David Arcari <darcari@redhat.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq: pcc-cpufreq: Fail initialization if driver
 cannot be registered
Message-ID: <20190607030546.7kjg466wbkzxfym4@vireshk-i7>
References: <20190606185052.71959-1-darcari@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190606185052.71959-1-darcari@redhat.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06-06-19, 14:50, David Arcari wrote:
> Make pcc_cpufreq_init() return error codes when the driver cannot be
> registered.  Otherwise the driver can shows up loaded via lsmod even
> though it failed initialization.  This is confusing to the user.
> 
> Signed-off-by: David Arcari <darcari@redhat.com>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/pcc-cpufreq.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/pcc-cpufreq.c b/drivers/cpufreq/pcc-cpufreq.c
> index 1e5e64643c3a..fdc767fdbe6a 100644
> --- a/drivers/cpufreq/pcc-cpufreq.c
> +++ b/drivers/cpufreq/pcc-cpufreq.c
> @@ -582,10 +582,10 @@ static int __init pcc_cpufreq_init(void)
>  
>  	/* Skip initialization if another cpufreq driver is there. */
>  	if (cpufreq_get_current_driver())
> -		return 0;
> +		return -EEXIST;
>  
>  	if (acpi_disabled)
> -		return 0;
> +		return -ENODEV;
>  
>  	ret = pcc_cpufreq_probe();
>  	if (ret) {

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
