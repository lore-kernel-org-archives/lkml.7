Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B70CC76196
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 05:43:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27965219BE
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 05:43:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R6TtVKr6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727335AbfGVFnr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 01:43:47 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34453 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726839AbfGVFnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 01:43:47 -0400
Received: by mail-pg1-f193.google.com with SMTP id n9so10885682pgc.1
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2019 22:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RCQRh8f7Am9Pu3Zrt8ca1tiYCAmgZh8iO4K+Ia+HeDY=;
        b=R6TtVKr6FzRXGzpuk4JA7iix7Rqg/Vj3Jml5vRJxELGIZUOhzNNDE+ORehUvK5+iLl
         34dKdx5dh9Ut0OilqkR3jl7qf3z7nuSnyrxQ8X2g2ylzFyyNI4ARLewsc9mz0zxcRZQM
         FTDztbAtB5f93ji0gTdc2ocUGsq7LyRPCPmvutWPqOMLAk10C9bb2DEfH7e6ues1cx7A
         zDuafqss/khT0E8w7sdPyVOIhJjuI+SmronKkfeqQcxZVefr3Uqhk0RE67MOLgJelL1X
         fa3xSvPr/Ax34q1v2Ns7ZtFNrwZbgdS8LWKdoOy07EMDUdiRuPJWE7SPLKUTucmknMOV
         ZIEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RCQRh8f7Am9Pu3Zrt8ca1tiYCAmgZh8iO4K+Ia+HeDY=;
        b=uaJ46yzUqGTNCRqnEcQK028LvKI+Y8y9MQgsK0g1YroaN3cFhXcH5Welkzj9kchVjC
         eK1mJTK6AiHFFckfI7f/Xy0q/lIr7dmGXGxOKeUHJcHhRNaZdNg+A50s6NiCE9cyakwB
         hSTkB+bzJtq5Bb3jIdNqe/Uk3xZxA1Jvt7fEJopmFLycBQbrcDmj/uyZkUbgC8Yw1l3Q
         /gbYtTlI0Qa4Q52snHhvhRmmK2CClE6iTKOoX4fCzlTmFKfs11AipsSECViZp0dnSSAk
         +F9YbqsZdWaYD9RIbbcuXqYltS8j2edp7UZSouy0Pw10tfSO2qG48mRqxtYmDei9xXek
         lVlw==
X-Gm-Message-State: APjAAAWwQ73K5oIJUHXZwdD6SJ5CT+vudMX30Cl9GuFS2HopWjWFrAzN
        ipc/9xIBqKjKdAz29gyR7c5EWg==
X-Google-Smtp-Source: APXvYqwGj+0Wjj4RUowbz6W/lmlIStZnbmKiIZOWeUKE5oUz5EPZK0z/QTRB0FLK7EZANdtJypPPLw==
X-Received: by 2002:a17:90a:fa07:: with SMTP id cm7mr73019980pjb.138.1563774226648;
        Sun, 21 Jul 2019 22:43:46 -0700 (PDT)
Received: from localhost ([122.172.28.117])
        by smtp.gmail.com with ESMTPSA id i3sm40833413pfo.138.2019.07.21.22.43.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Jul 2019 22:43:46 -0700 (PDT)
Date:   Mon, 22 Jul 2019 11:13:44 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Hariprasad Kelam <hariprasad.kelam@gmail.com>
Cc:     Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: ap806: Add NULL check after kcalloc
Message-ID: <20190722054344.w3vxrxaozd2tuajd@vireshk-i7>
References: <20190721180815.GA12437@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190721180815.GA12437@hari-Inspiron-1545>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-07-19, 23:38, Hariprasad Kelam wrote:
> Add NULL check  after kcalloc.
> 
> Fix below issue reported by coccicheck
> ./drivers/cpufreq/armada-8k-cpufreq.c:138:1-12: alloc with no test,
> possible model on line 151
> 
> Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
> ---
>  drivers/cpufreq/armada-8k-cpufreq.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/cpufreq/armada-8k-cpufreq.c b/drivers/cpufreq/armada-8k-cpufreq.c
> index 988ebc3..39e34f50 100644
> --- a/drivers/cpufreq/armada-8k-cpufreq.c
> +++ b/drivers/cpufreq/armada-8k-cpufreq.c
> @@ -136,6 +136,8 @@ static int __init armada_8k_cpufreq_init(void)
>  
>  	nb_cpus = num_possible_cpus();
>  	freq_tables = kcalloc(nb_cpus, sizeof(*freq_tables), GFP_KERNEL);
> +	if (!freq_tables)
> +		return -ENOMEM;
>  	cpumask_copy(&cpus, cpu_possible_mask);
>  
>  	/*

Applied. Thanks.

-- 
viresh
