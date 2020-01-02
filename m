Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35E8FC2D0DC
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 12:47:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08D7620863
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 12:47:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="GNJfKR2B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728331AbgABMr6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 07:47:58 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42149 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728288AbgABMr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 07:47:57 -0500
Received: by mail-wr1-f65.google.com with SMTP id q6so39043284wro.9
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jan 2020 04:47:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=ZPjjlsLBRy/AsEOd+5TSLn081vD0O0nsEFO/LF3ENuo=;
        b=GNJfKR2BW87CUTDAdER/HrYYLqseSgCIl1bZUDk4RmYZCp4/Z0iULdGwZYN6A8LFIU
         NVpa5uSYKjQ5lujMZfT+b1X0G8kamQVGs1ru8vVPMk/Ka5Sh1/uHDyrkuLKsINdOnOcB
         N1DK/TgTCX3jezUlxvz4SnkpByciHZZjGYtImSdU11ikysE6tfwlY8B67ctRZ4ewZryC
         Dro6n8qznNkXTgbbbScuLuZA5Lit5zdyN8C1+Yj26GmrK9vduR6HLXsq/0iYZTVepNgV
         FOIfYu8f/pv8p01ABASWH6H8VUow27wT2bg2Oq+LXE5D1gY9QG28+VD549EP4RO/b8sI
         fEHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=ZPjjlsLBRy/AsEOd+5TSLn081vD0O0nsEFO/LF3ENuo=;
        b=rpd3E/gIM/ymdao1vUD2MKhT2/DRQ0L9zpNbDx6RoaJMQB7IGIjeW+w4keXb+XiFHd
         zZGdXtUHE/y+FvG7+6fVY5zb+RMrVB3g+UN3K7WBs07LvIsp9M1X2JmEBdzgLs42etOn
         McTYYnjPJcH6yxnfKie6Q92JvKiwhgJah3uvHGJG1vtFohq2eiGm82h1rqSr1hmYe7xj
         Z7oo7Xs7GrOwDt2DzHg7EyFvRsTmumboaJyu7PAHnlzjK046fvmLYpcXLkcgLyW475sH
         v4CPD5cVk+W8gOpSMWznZPItGNZWxtrKc6ZbFfSsFyyXdho1endTUMjgiyjsNJi8zfu/
         bKuQ==
X-Gm-Message-State: APjAAAUeyCc7QD6VP+agvUSGUvrmZV8l5bp1Ic6oJ4YbzKjxSeM/tFT3
        QHKLEfREW484Mia4wgILeHN3fA==
X-Google-Smtp-Source: APXvYqzwGUgWcvkkN8gOC3/lVJJr0Lne8X1G54XU++EANytHtRvN2z6E9NP6cuFHkOL/vDpXUUvwFg==
X-Received: by 2002:adf:d846:: with SMTP id k6mr78632937wrl.337.1577969275854;
        Thu, 02 Jan 2020 04:47:55 -0800 (PST)
Received: from localhost (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id t8sm54509968wrp.69.2020.01.02.04.47.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2020 04:47:54 -0800 (PST)
References: <20200102005503.71923-1-sboyd@kernel.org>
User-agent: mu4e 1.3.3; emacs 26.3
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v2] clk: Warn about critical clks that fail to enable
In-reply-to: <20200102005503.71923-1-sboyd@kernel.org>
Date:   Thu, 02 Jan 2020 13:47:53 +0100
Message-ID: <1j8smqja86.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu 02 Jan 2020 at 01:55, Stephen Boyd <sboyd@kernel.org> wrote:

> If we don't warn here users of the CLK_IS_CRITICAL flag may not know
> that their clk isn't actually enabled because it silently fails to
> enable. Let's print a warning in that case so developers find these
> problems faster.

Thanks Stephen !
Reviewed-by: Jerome Brunet <jbrunet@baylibre.com>

>
> Suggested-by: Jerome Brunet <jbrunet@baylibre.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> ---
>
> Changes from v1:
>  * Switched to pr_warn and indicated clk name
>
>  drivers/clk/clk.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index 772258de2d1f..b03c2be4014b 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -3427,13 +3427,18 @@ static int __clk_core_init(struct clk_core *core)
>  		unsigned long flags;
>  
>  		ret = clk_core_prepare(core);
> -		if (ret)
> +		if (ret) {
> +			pr_warn("%s: critical clk '%s' failed to prepare\n",
> +			       __func__, core->name);
>  			goto out;
> +		}
>  
>  		flags = clk_enable_lock();
>  		ret = clk_core_enable(core);
>  		clk_enable_unlock(flags);
>  		if (ret) {
> +			pr_warn("%s: critical clk '%s' failed to enable\n",
> +			       __func__, core->name);
>  			clk_core_unprepare(core);
>  			goto out;
>  		}
>
> base-commit: 12ead77432f2ce32dea797742316d15c5800cb32

