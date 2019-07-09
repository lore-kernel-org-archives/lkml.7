Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DA5EC606B0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 05:40:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E527E2073D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 05:40:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qj/En8SA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbfGIFkV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 01:40:21 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45037 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726394AbfGIFkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 01:40:19 -0400
Received: by mail-pl1-f193.google.com with SMTP id t14so6382868plr.11
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 22:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oNfoBSAVs4HwlcfNYsclg/dP1n0XavIgjkMDpD1mPiY=;
        b=qj/En8SAcjlo3abd1feAIjM0u/Mro4Llh0ow4E5dJPGEUYTgknUTKxU1/i+J3jWMBN
         p25OPQsFgd7UEZdsGY6Ix40FcQTMNKciT4LNWrGbY+OeyG9jIxEI2RBpPnmpn5e8ORa4
         k0mt57EeQt3A48ZZOsXkdS5epjRbA1SLO1Ka2SyShqNIbp0lVHJWqYVmsT6VR8FFtQsK
         DFhDLtC7yfbeY27Br1XDph3bkoPnKvgG1iMFUaOUBpyUvVBo8OUPEIO6Xvo+5OHjrrUe
         qRGZfmT4Bcz6Y4Fkj1e6/gkz2Y8JL8TLEthi+V2VYj2DUGcr0fiiOU+Jeg2nsd4X3lBK
         Jjyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oNfoBSAVs4HwlcfNYsclg/dP1n0XavIgjkMDpD1mPiY=;
        b=fqZo/A/ZLziwU8ZFjng41mYeQm7CVGxzfyDqa4Y9YukBQvNN5wAmuZdH4aoubT3es+
         2yqp1eRh5jdjVRRX4MYZlLpjfdbO4PoAdU0IMXUD1N3KVFOchJd0GfGuXor7MODx9smH
         Rcm7v3WEFm4HCS6TSKisZpl+6WcVJ5H2w2gPRx5QZ4b1Y1JefQZC649/vJo2blE0BuyS
         +rz+LjTd99YLCGr0PnKIQD14tBqpk2aX7gpD2LjIChhJLByh7Qztu83rSPim1vrKnQqh
         xHEVMsX5y88lJgesjGRkgl/tVzw9xpYRazIzuh2S35mHgcIHgZlgVndwe9ocuhhdsPc8
         m59Q==
X-Gm-Message-State: APjAAAXV4o1Ghqiunu7m396Z1fcSYN2BGnuVj98CQkQ2l+MwPAD/wtqO
        jVSh5fkIl6f1b6/ROZ1Mh3bN3A==
X-Google-Smtp-Source: APXvYqyV89mc4OQKczZ8sRKuZ6VoDj+GFu/P2sqMf45IqdFh8iCwtAvZ5SJ+Cb5vmTNA4cnNYsunBw==
X-Received: by 2002:a17:902:b20c:: with SMTP id t12mr29930984plr.285.1562650818025;
        Mon, 08 Jul 2019 22:40:18 -0700 (PDT)
Received: from localhost ([122.172.28.117])
        by smtp.gmail.com with ESMTPSA id l31sm41547789pgm.63.2019.07.08.22.40.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Jul 2019 22:40:16 -0700 (PDT)
Date:   Tue, 9 Jul 2019 11:10:14 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     k.konieczny@partner.samsung.com
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Mark Rutland <mark.rutland@arm.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH 1/3] opp: core: add regulators enable and disable
Message-ID: <20190709054014.o3g4e6gbovrq3vvn@vireshk-i7>
References: <20190708141140.24379-1-k.konieczny@partner.samsung.com>
 <CGME20190708141159eucas1p1751506975ff96a436e14940916623722@eucas1p1.samsung.com>
 <20190708141140.24379-2-k.konieczny@partner.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190708141140.24379-2-k.konieczny@partner.samsung.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08-07-19, 16:11, k.konieczny@partner.samsung.com wrote:
> From: Kamil Konieczny <k.konieczny@partner.samsung.com>
> 
> Add enable regulators to dev_pm_opp_set_regulators() and disable
> regulators to dev_pm_opp_put_regulators(). This prepares for
> converting exynos-bus devfreq driver to use dev_pm_opp_set_rate().
> 
> Signed-off-by: Kamil Konieczny <k.konieczny@partner.samsung.com>
> ---
>  drivers/opp/core.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index 0e7703fe733f..947cac452854 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -1580,8 +1580,19 @@ struct opp_table *dev_pm_opp_set_regulators(struct device *dev,
>  	if (ret)
>  		goto free_regulators;
>  
> +	for (i = 0; i < opp_table->regulator_count; i++) {
> +		ret = regulator_enable(opp_table->regulators[i]);
> +		if (ret < 0)
> +			goto disable;
> +	}

I am wondering on why is this really required as this isn't done for
any other platform, probably because the regulators are enabled by
bootloader and are always on.

-- 
viresh
