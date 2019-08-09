Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26F24C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 06:51:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F16152171F
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 06:51:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SsbRib01"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405655AbfHIGvK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 02:51:10 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43951 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404414AbfHIGvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 02:51:10 -0400
Received: by mail-pf1-f196.google.com with SMTP id i189so45515802pfg.10
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2019 23:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=x9ssWGxxkq/9CJ5eSvVdzA303ipkDIEQtqVxaUjKwFc=;
        b=SsbRib01Pj2gUuvX3T8Lm77keoa+JZT4ELGim2VsT9a0H7zTkkNbr6/ScWIAzwdEJt
         AHN34hewtcSxWKhwg+3qOKMMiFg5RR83i2HrLisNL6hlem5JsYxNfFSbrtUV9ozm6m73
         OEbekcNowDDtkk1lO+hr2hXF4dwgVMxtaSqQXc0wf28fCSyIYP+FnxRrzIjAqiELgWMO
         f7BwHNPy5M7ubdrGApqRsWe4beq0fRQnDNeWYHZl4MLB1Q4tKGUQTDzcMHks6tFz+XV9
         enIX3FHWF8L+iDtErrXctX/AKIAo4VkiX+YOl6WPF3UP5I6zrDoSHtlKcxH5NK7g2Sry
         ecgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=x9ssWGxxkq/9CJ5eSvVdzA303ipkDIEQtqVxaUjKwFc=;
        b=jl0rsReTTYHSYNa8+B2nVKAEc7LCap5bhrp4b1B5PpJ3BwbW3fHPUb06Ayu3jJVl6I
         GDg60gz/qtY88mDfmDzMho/pMYFTySooB5omSN9IZXWa7oBx8wgQFwwHCVstEta7gOMc
         rk0935exJv77qoJK34VpeWUgTz17NfgIjrCgDEutEcM28KfuAwN8sGaiwUxljTycO0YC
         6t7ihqhYf5dbkuuMaYAPd1DyvzpXGqEOIGyTGC4JhcfmJelenVvHEBcpCNE8D6qOynZe
         m7gsHmFo8WZQz8ZkGFBN+quhaVnuKZZlfz2Ki+cLZGxRNQ4YZ8JoE42plKstAO3i8yA1
         Z1lQ==
X-Gm-Message-State: APjAAAXAXdaPKslnrXVGe4yTjeMqwHRN6KRR1D2KsVPxn3ZB24b+pO2A
        7xa9JMw/8m8E69O42cKp6V0KIg==
X-Google-Smtp-Source: APXvYqzmflZ43IP8/glS2bIIc3supdngf9NBrzjh0vj0kZEYHOEi2yV4/xOwRKsLL3G7rpWyYTn2Ig==
X-Received: by 2002:aa7:8711:: with SMTP id b17mr20008573pfo.234.1565333469218;
        Thu, 08 Aug 2019 23:51:09 -0700 (PDT)
Received: from localhost ([122.172.76.219])
        by smtp.gmail.com with ESMTPSA id j10sm66195278pfn.188.2019.08.08.23.51.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Aug 2019 23:51:08 -0700 (PDT)
Date:   Fri, 9 Aug 2019 12:21:06 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Doug Smythies <dsmythies@telus.net>
Cc:     linux-pm@vger.kernel.org,
        'Vincent Guittot' <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org, 'Rafael Wysocki' <rjw@rjwysocki.net>,
        'Srinivas Pandruvada' <srinivas.pandruvada@linux.intel.com>,
        'Len Brown' <lenb@kernel.org>
Subject: Re: [PATCH V4 2/2] cpufreq: intel_pstate: Implement QoS supported
 freq constraints
Message-ID: <20190809065106.vpktdp44qohdt3jk@vireshk-i7>
References: <70fce19e43bb825c3b2546e1211d262a59ae7378.1565161495.git.viresh.kumar@linaro.org>
 <e789eceae3f32a66fff923daeb85b33b88f21fe1.1565161495.git.viresh.kumar@linaro.org>
 <000601d54e05$e93d0130$bbb70390$@net>
 <20190809021607.j4qj3jm72gbisvqh@vireshk-i7>
 <001f01d54e7c$a22395d0$e66ac170$@net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <001f01d54e7c$a22395d0$e66ac170$@net>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08-08-19, 23:35, Doug Smythies wrote:
> O.K. While I understand the explanations, I still struggle with
> this scenario:
>  
> doug@s15:~/temp$ cat /sys/devices/system/cpu/intel_pstate/max_perf_pct
> 50    <<< Note: 50% = 1.9 GHz in my system)
> doug@s15:~/temp$ grep . /sys/devices/system/cpu/cpufreq/policy*/scaling_max_freq
> /sys/devices/system/cpu/cpufreq/policy0/scaling_max_freq:1900000
> /sys/devices/system/cpu/cpufreq/policy1/scaling_max_freq:1900000
> /sys/devices/system/cpu/cpufreq/policy2/scaling_max_freq:1900000
> /sys/devices/system/cpu/cpufreq/policy3/scaling_max_freq:1900000
> /sys/devices/system/cpu/cpufreq/policy4/scaling_max_freq:1900000
> /sys/devices/system/cpu/cpufreq/policy5/scaling_max_freq:1900000
> /sys/devices/system/cpu/cpufreq/policy6/scaling_max_freq:1900000
> /sys/devices/system/cpu/cpufreq/policy7/scaling_max_freq:1900000
> 
> At this point I am not certain what I'll get if I try to
> set max_perf_pct to 100%, nor do I know how to find out
> with a user command.
> 
> So, I'll try it:
> 
> doug@s15:~/temp$ echo 100 | sudo tee /sys/devices/system/cpu/intel_pstate/max_perf_pct
> 100
> doug@s15:~/temp$ cat /sys/devices/system/cpu/intel_pstate/max_perf_pct
> 100  <<< Note: 100% = 3.8 GHz in my system)
> doug@s15:~/temp$ grep . /sys/devices/system/cpu/cpufreq/policy*/scaling_max_freq
> /sys/devices/system/cpu/cpufreq/policy0/scaling_max_freq:2200000
> /sys/devices/system/cpu/cpufreq/policy1/scaling_max_freq:2200000
> /sys/devices/system/cpu/cpufreq/policy2/scaling_max_freq:2200000
> /sys/devices/system/cpu/cpufreq/policy3/scaling_max_freq:2200000
> /sys/devices/system/cpu/cpufreq/policy4/scaling_max_freq:2200000
> /sys/devices/system/cpu/cpufreq/policy5/scaling_max_freq:2200000
> /sys/devices/system/cpu/cpufreq/policy6/scaling_max_freq:2200000
> /sys/devices/system/cpu/cpufreq/policy7/scaling_max_freq:2200000
> 
> I guess I had set it sometime earlier, forgot, and then didn't
> get 3.8 Ghz as I had expected via max_perf_pct.

Right, so the problem here (since ages) is that there is no file in
sysfs to show the value earlier set by the user to
scaling_max/min_freq. Rather when you try to read those files, cpufreq
core gives you the current value of policy->min/max, which can come
from so many factors, like userspace, thermal, max_perf_pct, etc.

You saw 2200000 here because you must have set that value to
scaling_max_freq earlier, else maybe thermal or other stuff
constrained that value for you.

Though the cpufreq core stores the value set by user and uses it to
recalculate policy->max using it. To get rid of your constraint, set
scaling_max_freq to the highest frequency and you will be good.

-- 
viresh
