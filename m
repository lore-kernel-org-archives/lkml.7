Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60C2EC43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:32:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F73E206A3
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:32:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eJ240hgn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728757AbfD0PcP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 11:32:15 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41434 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728742AbfD0PcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 11:32:08 -0400
Received: by mail-wr1-f66.google.com with SMTP id c12so8740864wrt.8
        for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2019 08:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tw+ip3/cl2Dgl2j36NuswCngMdqYSO6skOoyJNpN018=;
        b=eJ240hgn6AAyx+FNBnLB+GSIdM5TCn0pph1n9ROc/Fchbuo4lZC3R9vu4ePIKYNa0q
         daa3GlojyH0fvDepn1vIsRnY0I6E5kCEd6r8IXD0f/o1t9mEx6dO5OVVgFNPBpB3sYWf
         Y5wfUfcOPxZytdJyRgve8qEJysYojPt1Q0UTh7TfxjeP3s5/n2F326tH/KiHp5OtS5cj
         GPcDcQXs10F+duvQ07LBO1GXdC3yjIcjwCpFXxPDb76jgALop6T0W0EZnJ3bd/bf8Lhd
         oHjwvLHGsTqBPh7alH7thnwJx3M0/LFjCPShmsmIy65b9j5TITsRHPjJs0qPMuoTdLfU
         bl3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tw+ip3/cl2Dgl2j36NuswCngMdqYSO6skOoyJNpN018=;
        b=cg1pMNmHDW4nU6ihhlDcSazlNZiLDMahAlPJAazVVpcFa7ZfW63d9zyVEycDRV6xHR
         EmdqVuz+0LQ6nO7TSZ2yKNkF8kM+ru/welZzCC+UMTS0O2jsoIaosUj4GmaR7Mqg/fQ+
         LDQUnby6zsOellahPg35o9Ou0O2tax+Hn68aiszbfxbaSeg0M8T5Aei1thy/su9jAVcj
         epECBATOue9o8vclZdVoe0sIBjyA+7oSjDR6pBQOWa/jqHVXtOGVTtRGh5BbiMUEAhh9
         6GRTqjEzyJg1UyZwx88zk3rkeIxTqNkRpo6UWd4gWRv4rayChFFZCdlCrQw5QHHAXeiI
         ngDw==
X-Gm-Message-State: APjAAAVx/sovMWEJiHqyOWyr2RR6GYoDK1UvxmBbBjzmaRUgB34sWVYf
        5que/EzgFEMiHixibzufmbZbNg==
X-Google-Smtp-Source: APXvYqw7pAZlMKmSaYWppv28yuzJ5mtWx10PZM3237MkHFcF2ALg5wdss96xiZletxIzMLzs7xK64Q==
X-Received: by 2002:adf:8567:: with SMTP id 94mr4894599wrh.286.1556379126825;
        Sat, 27 Apr 2019 08:32:06 -0700 (PDT)
Received: from [192.168.0.41] (sju31-1-78-210-255-2.fbx.proxad.net. [78.210.255.2])
        by smtp.googlemail.com with ESMTPSA id c6sm23427549wmb.21.2019.04.27.08.32.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Apr 2019 08:32:06 -0700 (PDT)
Subject: Re: [PATCH v1] thermal: Add some error messages
To:     Amit Kucheria <amit.kucheria@linaro.org>,
        linux-kernel@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>
Cc:     linux-pm@vger.kernel.org
References: <cover.1556305991.git.amit.kucheria@linaro.org>
 <640cd0cd93e199459af6d6d04bad228e909faf54.1556305991.git.amit.kucheria@linaro.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <a7496561-cc51-a8bd-2266-d69efbce0981@linaro.org>
Date:   Sat, 27 Apr 2019 17:32:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <640cd0cd93e199459af6d6d04bad228e909faf54.1556305991.git.amit.kucheria@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Amit,

On 26/04/2019 21:15, Amit Kucheria wrote:
> When registering a thermal zone device, we currently return -EINVAL in
> four cases. This is makes is a little hard to debug the real cause of
> the failure.
> 
> Print some error messages to make it easier for developer to figure out
> what happened.

Adding "Error" in the pr_err message is redundant. However I'm not sure
adding more traces is really important, that will add more RO data for a
function which is supposed to be called from wise code.

> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> ---
>  drivers/thermal/thermal_core.c | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index 6590bb5cb688..51cb6d2bf7a2 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -1189,17 +1189,26 @@ thermal_zone_device_register(const char *type, int trips, int mask,
>  	int count;
>  	struct thermal_governor *governor;
>  
> -	if (!type || strlen(type) == 0)
> +	if (!type || strlen(type) == 0) {
> +		pr_err("Error: No thermal zone type defined");
>  		return ERR_PTR(-EINVAL);
> +	}
>  
> -	if (type && strlen(type) >= THERMAL_NAME_LENGTH)
> +	if (type && strlen(type) >= THERMAL_NAME_LENGTH) {
> +		pr_err("Error: Thermal zone name (%s) too long, should be under %d chars",
> +		       type, THERMAL_NAME_LENGTH);
>  		return ERR_PTR(-EINVAL);
> +	}

May be take the opportunity to remove the test 'type' is true because it
is always true after the previous test?

> -	if (trips > THERMAL_MAX_TRIPS || trips < 0 || mask >> trips)
> +	if (trips > THERMAL_MAX_TRIPS || trips < 0 || mask >> trips) {
> +		pr_err("Error: Incorrect number of thermal trips");
>  		return ERR_PTR(-EINVAL);
> +	}
>  
> -	if (!ops)
> +	if (!ops) {
> +		pr_err("Error: Thermal zone device ops not defined");
>  		return ERR_PTR(-EINVAL);
> +	}
>  
>  	if (trips > 0 && (!ops->get_trip_type || !ops->get_trip_temp)>  		return ERR_PTR(-EINVAL);
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

