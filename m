Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80A2EFA372C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 02:22:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5213E21882
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 02:22:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dEkXwsxI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733097AbfKGCWc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 21:22:32 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46969 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732064AbfKGCWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 21:22:32 -0500
Received: by mail-pl1-f196.google.com with SMTP id l4so346388plt.13
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2019 18:22:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NIN5v3fAUcj/LrA9LEeK5InHeUpLOw2uQDiHG191Meg=;
        b=dEkXwsxI/7/hNhGSyjVTk1KO+wKhv2QUccoxYIopV5I/6lGrN0QN4OfFpzJh33q0xP
         jntgoLq3q6dRzyr58WWrVZawJw2P5iEKzt8kAwj5XUf6PwoGhp202WE4Z06S8IgS9Qni
         mCzAhzT01/lCle8rtKQFayydGux/WcK7WRbFKgGDaeTUoVnzgpf+7HZL1wXOSixUqxsx
         PBcoqIsi0D8lRq4Ke927WyMdkKJVJa2NTrLmR4WG1c+o8g0K2M/4Pd5/PNEvnIiBLRgG
         rchS43/fK/ot4LPMbERie0b0qCcM29DX2LS/VrgoZSrMc4eAjwKLXnjpuZ3SN5MI7bUg
         N9XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NIN5v3fAUcj/LrA9LEeK5InHeUpLOw2uQDiHG191Meg=;
        b=NQeG1+QHnUfYt2c3vhNFy5Jpd+R12hLSixYcDikcXSzOerX8fUkPfClij2GVy9kXms
         YTbc3e0T/Vdb6/TRaZK3BV5E1Zto2cHZYrdhFiE1KptQyBE44SMDu0UjmZBBVftb2cGw
         +8gWhLnggK21PZs+t/EMd3VZAdxhTQNgQAY7gOwUB4fdGh7j9vAbZ5HrYczI+9brnX2H
         5R2hPX6eiQbUH9OCQrAdwvIifbO5X7MR51NP0BYHQ7VrP2KoGfaqHp9J00Qs6XtuO4sH
         sK61n6WWhksJiSmWyrLyVf8+BPw97dAH3dn/JC+ELRQvCEtXp7orVHBjEJNHfLnkMgH1
         Sx2Q==
X-Gm-Message-State: APjAAAXIn1fMWSXuBPhvFL/Rsc18WIlPYzOVSdV/eG+BqTcrzTBEtn6+
        ltcZfx/j6/3RVUKsX0Kk2FOqhA==
X-Google-Smtp-Source: APXvYqwCkWoXqJ9eKOopzqrHOLc2N2rsz96iqN0wSUDBFmcihEHNZvH3q7JRpRvqafMJedRwQCgxxw==
X-Received: by 2002:a17:902:b40e:: with SMTP id x14mr1005028plr.262.1573093351235;
        Wed, 06 Nov 2019 18:22:31 -0800 (PST)
Received: from localhost ([122.171.110.253])
        by smtp.gmail.com with ESMTPSA id z25sm326951pfa.88.2019.11.06.18.22.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Nov 2019 18:22:30 -0800 (PST)
Date:   Thu, 7 Nov 2019 07:52:27 +0530
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
        Zhang Rui <rui.zhang@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 11/11] thermal: zx2967: Appease the kernel-doc deity
Message-ID: <20191107022227.kw7vu2vhbqqjjsnv@vireshk-i7>
References: <cover.1573046440.git.amit.kucheria@linaro.org>
 <b8cca2b414eeb2db19f297571dd4654a733a2417.1573046440.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b8cca2b414eeb2db19f297571dd4654a733a2417.1573046440.git.amit.kucheria@linaro.org>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06-11-19, 18:58, Amit Kucheria wrote:
> Fix up the following warning when compiled with make W=1:
> 
> linux.git/drivers/thermal/zx2967_thermal.c:57: warning: Function
> parameter or member 'dev' not described in 'zx2967_thermal_priv'
> 
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> ---
>  drivers/thermal/zx2967_thermal.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/thermal/zx2967_thermal.c b/drivers/thermal/zx2967_thermal.c
> index 7c8a82c8e1e92..8e3a2d3c2f9a3 100644
> --- a/drivers/thermal/zx2967_thermal.c
> +++ b/drivers/thermal/zx2967_thermal.c
> @@ -45,6 +45,7 @@
>   * @clk_topcrm: topcrm clk structure
>   * @clk_apb: apb clk structure
>   * @regs: pointer to base address of the thermal sensor
> + * @dev: struct device pointer
>   */
>  
>  struct zx2967_thermal_priv {

Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
