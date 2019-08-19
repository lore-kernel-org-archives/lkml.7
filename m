Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2433C3A59B
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 06:58:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7858820874
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 06:58:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P3rK6cja"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbfHSG6R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 02:58:17 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38013 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbfHSG6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 02:58:17 -0400
Received: by mail-pf1-f195.google.com with SMTP id o70so611333pfg.5
        for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2019 23:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HvtA+GBfwHC8fvnaQIIJLLxWYh1rn1153XxRWvxFdUs=;
        b=P3rK6cja54D8TRyXeXPYfTuuwH5EeJR6miORU5/Kef4uXdnOfRpQE6kC2Vx8+smA4u
         zhar+VQMpglRiotAhkMB5M6KLLM+0mIcJIGWxk+xdbnP8w8kZmTVVYAAEVJpYsFH4jtD
         GcIzCPRcMWH3f5JHBPgNaFkRg0DUXIIuLamFhbKMg2HiPLPUN2rb9+rFSzJXp75fbLHx
         Gv5bk4ZdFoEHuwr7EyUSc1p5UoLLng6CzOQUp179nmdihHBt/hSIhTsB20Rr9tr8LbQ7
         ENeyGHfHo79eaE6efoimOa+FG1sYtV34yLMiZfJuhpSvgmufUDZJYCoVey+cMjxlmOCU
         w4jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HvtA+GBfwHC8fvnaQIIJLLxWYh1rn1153XxRWvxFdUs=;
        b=U2b2BCKsfnbHs3m+7ICDfenvpiZN7sL1Fkczvov8cZijtJDVzKHqAEOhJZYq+CAv6l
         5Svhnq3ZSH+bTRta2ndZilrD0BcF5xBThou/WTC1bJH7p0saanu5od3eb2MTInoblr6q
         BFhtoni1xTxP21bqU1mPbavXP29qyIVuHkUTKuvWzUxUEWVlsyaB62r5U8BIRfY8Cm/8
         XqK67RegZJ1RKU8FYhxDKRZManbBTd7mHt6jqpAZilc/kyGeyvjaf5L52srjS9PuAxH/
         j2m7tzv4Wd6TKlOCh7WVyTIhllebYIBBYNy/j4e9dXFQ7zIbHRbVFAeIy9/exgR+rRlS
         SMWQ==
X-Gm-Message-State: APjAAAW/gPcQCRH1Ot2hL1wOSAC/nY5mBrcrU8vxLirvS5MtooJFi8zR
        dTm0XWJC/GGptCGTI3GhF/79/Q==
X-Google-Smtp-Source: APXvYqwmUeKAoNB6rJXK3rhuM5Ub/Wsz5p7XsyHuL0fBQNYaNS4bX0+QSzbe0jQR1GcmLgMOHn1YaA==
X-Received: by 2002:a62:e910:: with SMTP id j16mr23217505pfh.123.1566197896522;
        Sun, 18 Aug 2019 23:58:16 -0700 (PDT)
Received: from localhost ([122.172.76.219])
        by smtp.gmail.com with ESMTPSA id f14sm15662246pfn.53.2019.08.18.23.58.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 18 Aug 2019 23:58:15 -0700 (PDT)
Date:   Mon, 19 Aug 2019 12:28:14 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Colin King <colin.king@canonical.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: remove redundant assignment to ret
Message-ID: <20190819065814.333kowws4mpw3qfx@vireshk-i7>
References: <20190813122121.28160-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190813122121.28160-1-colin.king@canonical.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13-08-19, 13:21, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Variable ret is initialized to a value that is never read and it is
> re-assigned later. The initialization is redundant and can be removed.
> 
> Addresses-Coverity: ("Unused value")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/cpufreq/cpufreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index c28ebf2810f1..26d82e0a2de5 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -2140,7 +2140,7 @@ int cpufreq_driver_target(struct cpufreq_policy *policy,
>  			  unsigned int target_freq,
>  			  unsigned int relation)
>  {
> -	int ret = -EINVAL;
> +	int ret;
>  
>  	down_write(&policy->rwsem);
>  

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
