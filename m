Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6902FC6194
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 02:16:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7124B2187F
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 02:16:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eTdHzwVu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732923AbfKGCQQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 21:16:16 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36404 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727751AbfKGCQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 21:16:16 -0500
Received: by mail-pl1-f196.google.com with SMTP id g9so376623plp.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2019 18:16:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hkI5keue15c70TenbBfy9bg92TtC6pCPOVzBq/HJpyg=;
        b=eTdHzwVu6jEySebi56HeUDL5zeulh4E/HycKmsZWBMb7r/lHOijGiHX2hWFtXoN0D8
         JfJ8EF+eEeYlG4rCMf1y8gz8vdvBultdRIdwO2nR9hjlYNNTXc/6gu8+8zVTso2sXnTX
         4iAGmpxuTCYkFvVBGUl/7COhmqKXIaXyz0kukwlvdksFR6NV61q5PT9qcTsqF7uijnQn
         lEPgRKGwZ273o1XJmMGxLTE314tL1iQsydVrK6Zw4U1Gn0NnPW/P2OQDAJX2Yb+3HmjV
         54quJgIbczFaSmaUT55O+Mmjscs+4SRGgVdFSStve9ucq05X4DOK90DSX/I8u/TywwKp
         wbmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hkI5keue15c70TenbBfy9bg92TtC6pCPOVzBq/HJpyg=;
        b=UPKQnYh39O26lCNXwYYnocKw+BAq3JL1LePJ1G1bAsnwbgrXU/8ai0SmzmfUSv/3R7
         CJCzSj409y1eniXT4NLTLudbXK1AN6+RAtPBoyrCGdleCSEAwestRWiCGf6cCCiaQNfd
         cjNc0L3wEOf05r11xdbJOZH8+jpMxnwnuRQtjFz2wgHy4Km2pYcRxrTsR+zpLR2Gpv/w
         pXKWz0pSPRsQsMneR+fWFzy1nJooGeGcIROXb2Q7Is5KiHdefQgLVA0vhoXpxGEqVyNh
         5pXdpHwOtQtyiG/GMuKfi76Vj3vO52Omq2+LTXBUk881RvuRIU1nyt9obXPcqywP/dfL
         EWeQ==
X-Gm-Message-State: APjAAAV5RFJJ3k4Tfz1h/X0cDK0amnV1u/2LAytZK8lSxJSkQhA6D1na
        8rb7/TeIY+l6U24zTtxwtWmFyQ==
X-Google-Smtp-Source: APXvYqwbV5KH9kjIyCQxecsWMBVbFYwyi62GiiuDuVD2nVPKRPJrBXdHcO9McvsLG22N5Y4gIMcywQ==
X-Received: by 2002:a17:902:8345:: with SMTP id z5mr947021pln.113.1573092975094;
        Wed, 06 Nov 2019 18:16:15 -0800 (PST)
Received: from localhost ([122.171.110.253])
        by smtp.gmail.com with ESMTPSA id e59sm258709pjk.28.2019.11.06.18.16.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Nov 2019 18:16:14 -0800 (PST)
Date:   Thu, 7 Nov 2019 07:46:11 +0530
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
Subject: Re: [PATCH 02/11] thermal: cpu_cooling: Appease the kernel-doc deity
Message-ID: <20191107021611.euv5hndc34l7ydxg@vireshk-i7>
References: <cover.1573046440.git.amit.kucheria@linaro.org>
 <b545988db993ea8fe54c5250d35a8cb7ddaad1e5.1573046440.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b545988db993ea8fe54c5250d35a8cb7ddaad1e5.1573046440.git.amit.kucheria@linaro.org>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06-11-19, 18:58, Amit Kucheria wrote:
> Describe the function parameter to fix the following warning with make
> W=1:
> 
> linux.git/drivers/thermal/cpu_cooling.c:92: warning: Function parameter
> or member 'qos_req' not described in 'cpufreq_cooling_device'
> 
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> ---
>  drivers/thermal/cpu_cooling.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
> index 6b9865c786ba3..c1523b9d06954 100644
> --- a/drivers/thermal/cpu_cooling.c
> +++ b/drivers/thermal/cpu_cooling.c
> @@ -75,6 +75,7 @@ struct time_in_idle {
>   * @policy: cpufreq policy.
>   * @node: list_head to link all cpufreq_cooling_device together.
>   * @idle_time: idle time stats
> + * @qos_req: PM QoS contraint to apply
>   *
>   * This structure is required for keeping information of each registered
>   * cpufreq_cooling_device.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
