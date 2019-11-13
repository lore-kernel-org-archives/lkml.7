Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 906AFC432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 16:22:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6656A21A49
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 16:22:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TCUiQT7J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728317AbfKMQWo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 11:22:44 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36780 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728305AbfKMQWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 11:22:44 -0500
Received: by mail-lj1-f195.google.com with SMTP id k15so3271940lja.3;
        Wed, 13 Nov 2019 08:22:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/NPT2VbqBD/1/3nxqwL+OAW0hVteVP5bc9nbYT9sEWw=;
        b=TCUiQT7JDPjm9ZDg0Vzu38IlPaZ5tO/stIvb/xwZ0XpUs93vCiPqU8zUC/HnYM3vr6
         v52ml+3tmPsBYOP+DTmBc558lXk2sHLf9NsAxejdS46A0QCD9jlNB+aL4eMyQOi57Xwl
         SIakmAC6pclJPomWXqIInEmRx/lk2tTkrYe1cCZFZwU2FVPWz/CWbz++PFBYfSLH1ML/
         M2X9j8owFamvUc2idjYI1eGjX5q5/B1BlDxCrCLdW2lFwkevIwESTUdicWwKJqLk/Ixj
         dINXdaGcMyHePZe7lEbya/rouptapaeKveZvag/tRzxVnluBGYfxjXWSueTBDmHnmG7t
         EUUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/NPT2VbqBD/1/3nxqwL+OAW0hVteVP5bc9nbYT9sEWw=;
        b=NdWEUnKFdPdBXa0iklUiNUSw2SvTww7VZSLJuhK2hQ1zKUO5gRCOev1Oye7NIflk4r
         YT3Ny+8LFhFdrJiASzJKJwVfo9qf1rj9Wf4DrG9qLMUfsWVMmb75GUWhS2mOcXaR6JhW
         3r/CNLLPwiVhnZHa5gI8mLXt7GBQheAAtWEA599awV5GrLBwZwqYNcpqhyHa/njzbDF3
         JG+UasoouZ93kcjEl+mlcg+pnqapwRoAV0X2rnmJisth5J50QPgfHnHVsl7zldr2+Ha0
         C0QQgIxRcXQbVxxr4DruGiYDrdqpU/QZoJ4PdxevYkF5K2ZTnNsNFJnlGKX5L5MrEZKe
         FDQA==
X-Gm-Message-State: APjAAAXayz7Fdx7ihvwoh+4W3Zl3BVD4D+ioqdqHZyXT/8hM3l19tyFW
        FjSrd5t3FBZeoRU2H95JxfqDwEcv
X-Google-Smtp-Source: APXvYqzyck+QscJgPGHJHezhAv7xscVf5jyjQo+FEHbpQ0mvtZpFzoFgG83d9v4QvhOqJnbbV8YZxA==
X-Received: by 2002:a2e:9bc9:: with SMTP id w9mr3335411ljj.35.1573662161438;
        Wed, 13 Nov 2019 08:22:41 -0800 (PST)
Received: from [192.168.2.145] (94-29-10-250.dynamic.spd-mgts.ru. [94.29.10.250])
        by smtp.googlemail.com with ESMTPSA id x23sm1275538lfe.8.2019.11.13.08.22.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Nov 2019 08:22:40 -0800 (PST)
Subject: Re: [PATCH v1] clk: tegra: clk-dfll: Fix to remove
 pm_runtime_irq_safe
To:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        thierry.reding@gmail.com, jonathanh@nvidia.com, sboyd@kernel.org,
        mturquette@baylibre.com, pgaikwad@nvidia.com
Cc:     pdeschrijver@nvidia.com, linux-tegra@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1573575426-31314-1-git-send-email-skomatineni@nvidia.com>
 <1573575426-31314-2-git-send-email-skomatineni@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <353b9aef-3bcc-65d2-a942-91d6710b89ca@gmail.com>
Date:   Wed, 13 Nov 2019 19:22:39 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <1573575426-31314-2-git-send-email-skomatineni@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

12.11.2019 19:17, Sowjanya Komatineni пишет:
> pm_runtime_irq_safe is not needed as interrupts are allowed during
> suspend and resume. This was added mistakenly during dfll suspend
> and resume support patch.
> 
> This patch includes fix to remove pm_runtime_irq_safe.
> 
> Also updated description of dfll_suspend argument.
> 
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---
>  drivers/clk/tegra/clk-dfll.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/clk/tegra/clk-dfll.c b/drivers/clk/tegra/clk-dfll.c
> index c051d92c2bbf..cfbaa90c7adb 100644
> --- a/drivers/clk/tegra/clk-dfll.c
> +++ b/drivers/clk/tegra/clk-dfll.c
> @@ -1487,7 +1487,6 @@ static int dfll_init(struct tegra_dfll *td)
>  	td->last_unrounded_rate = 0;
>  
>  	pm_runtime_enable(td->dev);
> -	pm_runtime_irq_safe(td->dev);
>  	pm_runtime_get_sync(td->dev);
>  
>  	dfll_set_mode(td, DFLL_DISABLED);
> @@ -1516,7 +1515,7 @@ static int dfll_init(struct tegra_dfll *td)
>  
>  /**
>   * tegra_dfll_suspend - check DFLL is disabled
> - * @dev: DFLL device *
> + * @dev: DFLL instance
>   *
>   * DFLL clock should be disabled by the CPUFreq driver. So, make
>   * sure it is disabled and disable all clocks needed by the DFLL.
> 

Hello Sowjanya,

It should be better to have the commit's title saying something more
generic like "Clean up code" or to have two separate patches because
this patch does two things that are unrelated to each other in
accordance to the title and this is a bit confusing at first glance.
Although, that's not a big deal for a trivial patch like this and it
should be fine as is (IMO). Please take into account in the future
patches that both commit's title and description should be accurate.

Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
