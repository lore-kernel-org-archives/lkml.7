Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 323E8CA9EA0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 03:23:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01F5120700
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 03:23:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LXsEOBqK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731988AbfJWDXG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 23:23:06 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45118 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727140AbfJWDXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 23:23:06 -0400
Received: by mail-pg1-f193.google.com with SMTP id r1so11231866pgj.12
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2019 20:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vG1wlSoVjAH3TslkWdryreWfIFyS6PFtkukPqp6iu6k=;
        b=LXsEOBqKOd15Ki+pYR61bVtYMBRigi5yBLP9kWdnCjKN1Swh9GjKCUwx0e3QhP41oi
         f6UJc+sH3LzMZoN5qWZvLMzAjEU16NRk8kTsJPTu7URZghySrGM6OTxY9fqqjuAyt3uB
         HxfziLk4zNdgSGfMY3vn4D+fHbIQTuh2zDQX0+0jzinbdY/BmlbbGmqBiBOcegI/b0tJ
         ojhMWWAwm3fDesTkzWreV/gkOS+mhpjHcAcqoqKZc4aFnm+M4kBRGIj5lV0WwPW/N7Pj
         2xkTKceWyv4TxlJ6s5uVbJ7Pb8+aahzzhlR9yxioAT2pJFcOEdxw0J2tRmXjARLs2pFt
         whlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vG1wlSoVjAH3TslkWdryreWfIFyS6PFtkukPqp6iu6k=;
        b=OLgh2CtsH8xPxqlyNUWyZbtSo2Hfzvj6uGhGAKFmTvA3mZVw4Lu9mYl9cwllTD0xVq
         IUwHjA4zJUzM32NPVt6So4ny1hgwuLJsRCq+ezlB/uFlr1xKGAjnc45ek4UlcWt8Uqog
         aUAztVg8ToG/HhA2j3b8yz1iqUKDhC0JfM7B2xaonMwW08NKTDpOGB1lZ726AcbsM3Wf
         fUQrsI+/iTjDur5GxV53UafEO8LBhXNbZnXTyRdhINqSKFh4nfn+zZAcRT5a0v4BW56W
         fF+VFwo11agW0m2XNzzrFVruOKYNI/I0WjF4aEO5i7+F3IRUhCaKc3QWRyrk0dfeKd+u
         JoAw==
X-Gm-Message-State: APjAAAWf//l4mFd6ObWPCRTXGPmU3IZti+voVgVRHdHZvQuktseW1UGw
        tkwNGduhuB4xLAJFqaiR/mUYjw==
X-Google-Smtp-Source: APXvYqzL207UMotVVbLIBySCNyQniimBEc7wiboiIj6T8IbhYFht01SBvULx1tt1kgQWqReZqGRDrQ==
X-Received: by 2002:a17:90a:ac12:: with SMTP id o18mr8782943pjq.93.1571800985488;
        Tue, 22 Oct 2019 20:23:05 -0700 (PDT)
Received: from localhost ([122.172.151.112])
        by smtp.gmail.com with ESMTPSA id f15sm19700257pfd.141.2019.10.22.20.23.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Oct 2019 20:23:04 -0700 (PDT)
Date:   Wed, 23 Oct 2019 08:53:02 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Nathan Chancellor <natechancellor@gmail.com>, broonie@kernel.org
Cc:     Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH] cpufreq: s3c64xx: Remove pointless NULL check in
 s3c64xx_cpufreq_driver_init
Message-ID: <20191023032302.tu5nkvulo2yoctgr@vireshk-i7>
References: <20191023000906.14374-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191023000906.14374-1-natechancellor@gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-10-19, 17:09, Nathan Chancellor wrote:
> When building with Clang + -Wtautological-pointer-compare:
> 
> drivers/cpufreq/s3c64xx-cpufreq.c:152:6: warning: comparison of array
> 's3c64xx_freq_table' equal to a null pointer is always false
> [-Wtautological-pointer-compare]
>         if (s3c64xx_freq_table == NULL) {
>             ^~~~~~~~~~~~~~~~~~    ~~~~
> 1 warning generated.
> 
> The definition of s3c64xx_freq_table is surrounded by an ifdef
> directive for CONFIG_CPU_S3C6410, which is always true for this driver
> because it depends on it in drivers/cpufreq/Kconfig.arm (and if it
> weren't, there would be a build error because s3c64xx_freq_table would
> not be a defined symbol).
> 
> Resolve this warning by removing the unnecessary NULL check because it
> is always false as Clang notes. While we are at it, remove the
> unnecessary ifdef conditional because it is always true.
> 
> Fixes: b3748ddd8056 ("[ARM] S3C64XX: Initial support for DVFS")

+broonie, who wrote this patch to see his views on why he kept it like
this.

> Link: https://github.com/ClangBuiltLinux/linux/issues/748
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  drivers/cpufreq/s3c64xx-cpufreq.c | 7 -------
>  1 file changed, 7 deletions(-)
> 
> diff --git a/drivers/cpufreq/s3c64xx-cpufreq.c b/drivers/cpufreq/s3c64xx-cpufreq.c
> index af0c00dabb22..c6bdfc308e99 100644
> --- a/drivers/cpufreq/s3c64xx-cpufreq.c
> +++ b/drivers/cpufreq/s3c64xx-cpufreq.c
> @@ -19,7 +19,6 @@
>  static struct regulator *vddarm;
>  static unsigned long regulator_latency;
>  
> -#ifdef CONFIG_CPU_S3C6410
>  struct s3c64xx_dvfs {
>  	unsigned int vddarm_min;
>  	unsigned int vddarm_max;
> @@ -48,7 +47,6 @@ static struct cpufreq_frequency_table s3c64xx_freq_table[] = {
>  	{ 0, 4, 800000 },
>  	{ 0, 0, CPUFREQ_TABLE_END },
>  };
> -#endif
>  
>  static int s3c64xx_cpufreq_set_target(struct cpufreq_policy *policy,
>  				      unsigned int index)
> @@ -149,11 +147,6 @@ static int s3c64xx_cpufreq_driver_init(struct cpufreq_policy *policy)
>  	if (policy->cpu != 0)
>  		return -EINVAL;
>  
> -	if (s3c64xx_freq_table == NULL) {
> -		pr_err("No frequency information for this CPU\n");
> -		return -ENODEV;
> -	}
> -
>  	policy->clk = clk_get(NULL, "armclk");
>  	if (IS_ERR(policy->clk)) {
>  		pr_err("Unable to obtain ARMCLK: %ld\n",
> -- 
> 2.23.0

-- 
viresh
