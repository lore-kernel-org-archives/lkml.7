Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9EC3C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 02:40:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7684F22CF7
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 02:40:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nsTgn0i3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730805AbfHVCk6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 22:40:58 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45487 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726894AbfHVCk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 22:40:58 -0400
Received: by mail-pg1-f196.google.com with SMTP id o13so2539671pgp.12
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2019 19:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=43GEvCft8nMJFLB+nTdZDz3Ku9zd5Z0S8EKkYV/XwO8=;
        b=nsTgn0i3Th/wy8FgI5cIWRJ4TK9B9ZcN5ZwBL5RTrHOzfv+tJ5DkHxxh2Y2MfFXTS6
         9qSzMul1OGxVPEZRkFJwbvwTc2isJuuCndRh5LOSsLMPqA6kQwdWzVg/jHcjy7kBBAXc
         520tVw6i9X1ejfuKZX32ui11PRTrfLx2VkluXpjUhOXjB8q3CRg+/0jrOUujInsBefNG
         y4xntkRWLpSJxiV9wjTPLXCBwirDSzEK/FkyKj00buDKYJ9Y/imSyqsznneVMfeX9fa7
         zmSlxGz2oQkaxvaGGE5u+ZLrZeYpcXjfQC+dlLxbNy+S7ABCQQMdjV+3qUILX/X9tOji
         /+Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=43GEvCft8nMJFLB+nTdZDz3Ku9zd5Z0S8EKkYV/XwO8=;
        b=tvpGrUjjv6eM6tP0/mW2y67uxtFSO1ER0sB4Xekz9Lw1OcJm6n731BCpQPPl6w+A3M
         KvoN/rwoz9IlMqCGTcVVL0LCaFC5XL8HX2gcVg/grbrh0vhO80rBdLJb88Kj3edJZW0j
         hPh3fxpMj0TEJEf3jAV9jg0PbDm80b/25x+QhuoyzXh0yrc9DSlOC58mC7V1irpRjcyM
         3cFJynJo4GCn75syj/pyPijklPjIXUYMacHOcr9IfT0Lw6RHyCi0EgcBBWanSQRgsRFS
         UsTVNjZnOllD3ExkJVCth0d1Vj/bQD/1APP1o088YjrexPr9TCXWsjiDsmYxW2QbkOPa
         nktg==
X-Gm-Message-State: APjAAAWxoqMHibKJSVzJIqeOWZRBsgtegtvdQYB//wcbnNZ431vlKz75
        8li4UvVlENbQCAExuN0wnPNQ4QWikn0=
X-Google-Smtp-Source: APXvYqzHtyT3YDd/cLPhVSy+7THC/RtNzvd5nFbExS+j6Yto5pGt1hjPPyeXgBC1QiP5G65qQlOQ/Q==
X-Received: by 2002:a63:ab08:: with SMTP id p8mr404210pgf.340.1566441657106;
        Wed, 21 Aug 2019 19:40:57 -0700 (PDT)
Received: from localhost ([122.172.76.219])
        by smtp.gmail.com with ESMTPSA id h42sm1186807pjb.24.2019.08.21.19.40.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Aug 2019 19:40:56 -0700 (PDT)
Date:   Thu, 22 Aug 2019 08:10:51 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     agross@kernel.org, rjw@rjwysocki.net, sibis@codeaurora.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH -next] cpufreq: qcom-hw: remove set but not used variable
 'prev_cc'
Message-ID: <20190822024051.eubzzxh3b2ip2gzv@vireshk-i7>
References: <20190821121445.72588-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190821121445.72588-1-yuehaibing@huawei.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-08-19, 20:14, YueHaibing wrote:
> drivers/cpufreq/qcom-cpufreq-hw.c: In function qcom_cpufreq_hw_read_lut:
> drivers/cpufreq/qcom-cpufreq-hw.c:89:38: warning:
>  variable prev_cc set but not used [-Wunused-but-set-variable]
> 
> It is not used since commit 3003e75a5045 ("cpufreq:
> qcom-hw: Update logic to detect turbo frequency")
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/cpufreq/qcom-cpufreq-hw.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
> index 3eea197..a9ae2f8 100644
> --- a/drivers/cpufreq/qcom-cpufreq-hw.c
> +++ b/drivers/cpufreq/qcom-cpufreq-hw.c
> @@ -86,7 +86,7 @@ static int qcom_cpufreq_hw_read_lut(struct device *cpu_dev,
>  				    struct cpufreq_policy *policy,
>  				    void __iomem *base)
>  {
> -	u32 data, src, lval, i, core_count, prev_cc = 0, prev_freq = 0, freq;
> +	u32 data, src, lval, i, core_count, prev_freq = 0, freq;
>  	u32 volt;
>  	struct cpufreq_frequency_table	*table;
>  
> @@ -139,7 +139,6 @@ static int qcom_cpufreq_hw_read_lut(struct device *cpu_dev,
>  			break;
>  		}
>  
> -		prev_cc = core_count;
>  		prev_freq = freq;
>  	}

@Sibi, you fine with this change ? I will merge it with the original patch then.

-- 
viresh
