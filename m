Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E72DC43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 07:19:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77A1A208CA
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 07:19:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D8OxJ5hD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727240AbfFXHTB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 03:19:01 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36481 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726453AbfFXHTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 03:19:01 -0400
Received: by mail-pg1-f194.google.com with SMTP id f21so6627107pgi.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 00:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QPAEHfwyfOjLp/c8rpixuI8ADZDNn2aJbjyiJvtOkdo=;
        b=D8OxJ5hDzCPBUMggYfCNKwGemPJce4+u+TfYfAbR8MrtPwew9AeuDKQMqu8YxU3t47
         SAx4jQYpXtZ6AEp4Nuct7lskoBwDi9vzvyTzjWQEtlXgbgoC089UdXSzWVc3CimUDwJk
         GWxJAI97HZZVQHxxG56xQvY7sgif+RF/QHKs4EJDYsamYFiWJvjMBBde0zpDkGaZUboo
         Zj8fzlk2e22lsjS6lCASD2aqIEZGaipyvHpfM/zws4+HQs5xM9B2fTiWaVMCCQlMg9aS
         9otkd1IWKyQ0//+50kafrirm1sR8h+SvndhWpm93tRkfimZ+6osB1HxjxAcgU/hAH0zs
         OLbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QPAEHfwyfOjLp/c8rpixuI8ADZDNn2aJbjyiJvtOkdo=;
        b=FjIWRZQrCJG8zjA1jRuWnIJSB6Owt28EQp/VtKWsRCA6FuJwcm2WjaXGQGYuDxZmme
         0N7brjWgHyOjakRjts1X03su/BewGFbxp62ZItuARbz+y///ZaWLfEUAassALtaRB1LI
         uheLi4hYlZH5frJWzFGCMqybcPu8+9r9y7GErmTrZG5CG+PfLH+qTx52bsx3/u7qIBT2
         xTe96ioJ4acHCTgOhJ7Z7n7KBivtWY9znxAVcsEAe+4gOu4U68ufpX1PzfqGmo9vi86H
         FggN3n8h0OMLftEXF2l+GFEJHyEzB08QGtMINcg+miT8A14I65/xohusYaFTKC0tGV3X
         3ryg==
X-Gm-Message-State: APjAAAWigOtuk+mGT3ysxSIwdRHFrXE1lJlnYDCSSm2bct7ZiKORaIiF
        cQ8PFeGiOKHLVc9YA3o5zSmkPw==
X-Google-Smtp-Source: APXvYqzIgwcVlBKHTTwWRSeNdStEXG4H82G1BHRelc3PSTsht1dC5KsSDCo4jQ24mGQ9s86jMDAYUQ==
X-Received: by 2002:a17:90a:4f0e:: with SMTP id p14mr12184025pjh.40.1561360740638;
        Mon, 24 Jun 2019 00:19:00 -0700 (PDT)
Received: from localhost ([122.172.211.128])
        by smtp.gmail.com with ESMTPSA id n5sm21169200pgd.26.2019.06.24.00.18.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2019 00:18:59 -0700 (PDT)
Date:   Mon, 24 Jun 2019 12:48:57 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Marc Dietrich <marvin24@gmx.de>, linux-pm@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] OPP: Fix crashing when current OPP has unsupportable
 voltage
Message-ID: <20190624071857.6ji4zc55qugpqnij@vireshk-i7>
References: <20190623175053.26167-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190623175053.26167-1-digetx@gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-06-19, 20:50, Dmitry Osipenko wrote:
> Fix NULL dereference caused by a typo in the code. In particular it
> happens when CPU is running on a frequency which has unsupportable voltage
> (by regulator) defined in the OPP table and a custom set_opp() callback is
> being used. The problem was spotted during of testing of upcoming update
> for the NVIDIA Tegra CPUFreq driver.
> 
> Cc: stable <stable@vger.kernel.org>
> Fixes: 7e535993fa4f ("OPP: Separate out custom OPP handler specific code")
> Reported-by: Marc Dietrich <marvin24@gmx.de>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/opp/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index 9fda9a0ec016..89ec6aa220cf 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -685,7 +685,7 @@ static int _set_opp_custom(const struct opp_table *opp_table,
>  
>  	data->old_opp.rate = old_freq;
>  	size = sizeof(*old_supply) * opp_table->regulator_count;
> -	if (IS_ERR(old_supply))
> +	if (!old_supply)
>  		memset(data->old_opp.supplies, 0, size);
>  	else
>  		memcpy(data->old_opp.supplies, old_supply, size);

While the change is fine, the commit log isn't. It isn't about
unsupportable voltage but frequency. The frequency the CPU is
currently running at, is not present in the OPP table and so there is
no corresponding OPP, hence no voltage supplies.

I have applied this patch with following change log:

commit 560d1bcad715c215e7ffe5d7cffe045974b623d0 (HEAD -> opp/linux-next)
Author: Dmitry Osipenko <digetx@gmail.com>
Date:   Sun Jun 23 20:50:53 2019 +0300

    opp: Don't use IS_ERR on invalid supplies
    
    _set_opp_custom() receives a set of OPP supplies as its arguments and
    the caller of it passes NULL when the supplies are not valid. But
    _set_opp_custom(), by mistake, checks for error by performing
    IS_ERR(old_supply) on it which will always evaluate to false.
    
    The problem was spotted during of testing of upcoming update for the
    NVIDIA Tegra CPUFreq driver.
    
    Cc: stable <stable@vger.kernel.org>
    Fixes: 7e535993fa4f ("OPP: Separate out custom OPP handler specific code")
    Reported-by: Marc Dietrich <marvin24@gmx.de>
    Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
    [ Viresh: Massaged changelog ]
    Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)


-- 
viresh
