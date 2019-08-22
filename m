Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 567C6C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 02:42:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BF6922CF7
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 02:42:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nSstffzo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730144AbfHVCm2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 22:42:28 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34607 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726998AbfHVCm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 22:42:28 -0400
Received: by mail-pg1-f193.google.com with SMTP id n9so2570499pgc.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2019 19:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NgNbAg8LMhyX90LlgIEI3ox3xP9DSn9WzzFTkSBbr1g=;
        b=nSstffzoNuXC8At32BW8GVT+2kLpVRBo1TbHwgWRM48q3jY1MRhiw5h7peR/OWeLXW
         eUVQ2VyG98El7mw1A2n+pBPOwC/MUH8mgKfijCCj0/HMe0u3sxP7Qv+y9SRCMZYB+FkR
         2bi5hPGHRZHCyhMaUuQVecxaFFDIPxAyZ2rLpN+Ew4Oy7FqOLNUIHztSdVR6v+rm17R7
         KMSthUsQKaXTmh6witGeDW2u4YElAwlNvZsizh1gtAxGvSIcglM3DL2e4HbjIEx3tx7Q
         wQyEtr8ZSKSbF3p4WeMoSSSyZPe8qihdP9TNTfRwIUu1N6Vqoza3pQjuq5OpNz1PSnqh
         LkQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NgNbAg8LMhyX90LlgIEI3ox3xP9DSn9WzzFTkSBbr1g=;
        b=l2WtzSFFpJhOe4B6e7Uj7M1C3MaohdYzfeYf8o1X/ax/dHrN6trY7Hd06ud12/7sph
         4IPwQEdtsIcGNwOUSbgEwMu7WAndgKNWmNjUpKWCNfQ+W0/ni1hJsJI6PSvyQyyq7XXc
         SOjsOdAleAyX8yoozSZaEA6YOFP1ZtXw8RsaS5xbAaXmd/rRTh4At1Ilcvy3a9RwLtMG
         yTJihtk42aVsoVxAGF62dBWwZc5CGGyav9MkLkelQbbq6nWAJcghvie++ZZmXp4nZmow
         R1mx1UvMG5EwvR+2A9JocMiv3gYC82JnK5NG0h7AyoeW+3IXAeDCt50C/TdLQwiKREY5
         YmwQ==
X-Gm-Message-State: APjAAAWIFf+ZNNMCkXbBDp7WcAn9t7YnPDP7nJiNg75GogHA6ODAltWp
        +k2rA183lv1eds+JJKlW1mxFsw==
X-Google-Smtp-Source: APXvYqwlT9owBX9i8KeoniR31rqUbD2ekZHttd7fvbTto1FEW78Fcq7E+nLkn2nOL4T0dvqDef9yOQ==
X-Received: by 2002:a62:2c93:: with SMTP id s141mr39038219pfs.114.1566441747058;
        Wed, 21 Aug 2019 19:42:27 -0700 (PDT)
Received: from localhost ([122.172.76.219])
        by smtp.gmail.com with ESMTPSA id d12sm24803245pfn.11.2019.08.21.19.42.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Aug 2019 19:42:26 -0700 (PDT)
Date:   Thu, 22 Aug 2019 08:12:22 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "open list:CPU FREQUENCY SCALING FRAMEWORK" 
        <linux-pm@vger.kernel.org>
Subject: Re: [PATCH] cpufreq: Print driver name if cpufreq_suspend() fails
Message-ID: <20190822024221.wt7mx2zrm3fetnjp@vireshk-i7>
References: <20190821231632.29133-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190821231632.29133-1-f.fainelli@gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-08-19, 16:16, Florian Fainelli wrote:
> Instead of printing the policy, which is incidentally a kernel pointer,
> so with limited interest, print the cpufreq driver name that failed to
> be suspend, which is more useful for debugging.
> 
> Fixes: 2f0aea936360 ("cpufreq: suspend governors on system suspend/hibernate")

I will drop this tag as this isn't a bug really.

> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  drivers/cpufreq/cpufreq.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index c28ebf2810f1..330d789f81fc 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1807,8 +1807,8 @@ void cpufreq_suspend(void)
>  		}
>  
>  		if (cpufreq_driver->suspend && cpufreq_driver->suspend(policy))
> -			pr_err("%s: Failed to suspend driver: %p\n", __func__,
> -				policy);
> +			pr_err("%s: Failed to suspend driver: %s\n", __func__,
> +				cpufreq_driver->name);
>  	}
>  
>  suspend:

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
