Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09F11FC6194
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 02:16:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDA492187F
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 02:15:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T59vipNJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732769AbfKGCP6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 21:15:58 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45981 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727751AbfKGCP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 21:15:58 -0500
Received: by mail-pl1-f196.google.com with SMTP id y24so343006plr.12
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2019 18:15:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4cKuNUYvAqunvz+72B7anlYEtcmjqeC5FeNltzDFT5k=;
        b=T59vipNJYtRlVOnfzcZA23VauEahxy7MNspU0b7oX2ekYAE3qzT7B/EnaGYttLoMDQ
         TkM+K1VxwwR9r3IAcW2Flh4PVi7CpxcgKYiJ1Gp5/FrciIQBzjIveyNa6BeFvA0Cg05m
         iiljd57ipGroXvyQ0j/MtNI8E5IYIdVFMfilWKgYNhHQNn99lk+fFSHl2AfsNCElOeyb
         rGDw6zIdYgXGq1SmHNxizrDSS33B0eYcuUOsZeL2H0R8tqygnUZK2kuENLHQVCDiHSXr
         FjS14E2QKkU0EZ8CxEoVy3Em0+YdFMq2F86KoKPL8YywVWgvqHj1U6OEJg1mNqlq4fmd
         BB1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4cKuNUYvAqunvz+72B7anlYEtcmjqeC5FeNltzDFT5k=;
        b=HrZm7pMhqycV5HKlc0KlWVQsLZ2i50zlibqjCMTiaavaOphewh8eIW8cOoSLOzZG8x
         Bz9Oi2LkF00T3VynX9BF1nOH1eCB9CWgnBSEbAn+8kgNFJXjJYAiDje92Q1+UvHIwKyp
         Is4uH3xP6m9J4D/GwzXE/cHWFyLUgenr0RZOXrQLo+WAtQvQ34mmM0JayRd21wP5Zsl/
         ohIWYOJURBqQIloJwpQxp5Rh6SRuWz9fZmyF+Xme94ytIM3ZHvbSwuJjn4/TMXn1XDfk
         JRmLVHWXU5zs5g6MWLyY37oTxADcv/RSmFOuSod5H+GkbdKwJt8Wp7BVf7F5duNa7dnS
         woEw==
X-Gm-Message-State: APjAAAXca/ECqo2YuehKY/BvQ8wkM1ZV9/+Ri4nly6wyT8FLT0hbBATJ
        um1LAk/gKuVY6BWV5N9e/g20Ig==
X-Google-Smtp-Source: APXvYqzCKzlvkuqzRAncs0ielDj0zuGNM9QqxzhWJxgll4/9/pZjwl3R0uj4+gXExMgSAmRcPke6aw==
X-Received: by 2002:a17:902:102:: with SMTP id 2mr1010877plb.156.1573092957436;
        Wed, 06 Nov 2019 18:15:57 -0800 (PST)
Received: from localhost ([122.171.110.253])
        by smtp.gmail.com with ESMTPSA id 70sm326657pfw.160.2019.11.06.18.15.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Nov 2019 18:15:56 -0800 (PST)
Date:   Thu, 7 Nov 2019 07:45:52 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     linux-kernel@vger.kernel.org, edubezval@gmail.com,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Guillaume La Roque <glaroque@baylibre.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Javi Merino <javi.merino@kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Jun Nie <jun.nie@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org
Subject: Re: [PATCH 01/11] thermal: of-thermal: Appease the kernel-doc deity
Message-ID: <20191107021552.qlg2xvan6sajntgm@vireshk-i7>
References: <cover.1573046440.git.amit.kucheria@linaro.org>
 <ebd5991d5554202893fbcab4707be6d26f502aef.1573046440.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ebd5991d5554202893fbcab4707be6d26f502aef.1573046440.git.amit.kucheria@linaro.org>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06-11-19, 18:58, Amit Kucheria wrote:
> Replace a comment starting with /** by simply /* to avoid having
> it interpreted as a kernel-doc comment.
> 
> Fixes the following warning when compile with make W=1:
> linux.git/drivers/thermal/of-thermal.c:761: warning: cannot understand function prototype: 'const char *trip_types[] = '
> 
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> ---
>  drivers/thermal/of-thermal.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-thermal.c
> index dc5093be553ec..5235aed2fadd5 100644
> --- a/drivers/thermal/of-thermal.c
> +++ b/drivers/thermal/of-thermal.c
> @@ -754,7 +754,7 @@ static int thermal_of_populate_bind_params(struct device_node *np,
>  	return ret;
>  }
>  
> -/**
> +/*
>   * It maps 'enum thermal_trip_type' found in include/linux/thermal.h
>   * into the device tree binding of 'trip', property type.
>   */

Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
