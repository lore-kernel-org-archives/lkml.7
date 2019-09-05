Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66758C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 17:38:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B63D2070C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 17:38:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Tpv2lsp4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391036AbfIERiQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 13:38:16 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:34349 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729017AbfIERiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 13:38:16 -0400
Received: by mail-pl1-f196.google.com with SMTP id d3so1657477plr.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2019 10:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KZtEeWQvjAbW4RpXx5Rs391kaT1lN+fLEO9kJk7Fxys=;
        b=Tpv2lsp4ZSX1/DDksSNxod7O8sssf87giKmImdkfKrYTvSGHFs3sT35VSHoMs3cYRi
         7gHbtoMEE6KbCyDUhhPDkXYnu2oW1AUfIu8fqBgIUNKb/jiqlkHPsP0Gi8PGXejv+8Uh
         VdQgYO0NEyVCFXYB4Vkk7vVo+rEOI9+mk0ztU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KZtEeWQvjAbW4RpXx5Rs391kaT1lN+fLEO9kJk7Fxys=;
        b=FKya8KPXYGCNr3bZOuyGOSgOTGycY8x9h4Ho6hIWpehE7bhVHr4dAGhoO6gG2Gl1IR
         h/EHRU9vcqXKHhZSkzwafQF3gxjKtFzI5GfZBds2oLc1WwQRdVQnZRrHTiwGYmPm1U8g
         lC04R6DN4z1aFVGmArcx2fJr8nvY1w/e3T2zoUu0iclSsvAIUXIhGNhW5vnFc9EWjwzq
         FV2U2r6C1vZ2N23NGER1BSiqIxzVEZzWo6oZ2T9uqfx/whnUlIqFmWcPSr3E2HjouxR8
         iFmx2OkxAiYu0n+n2JWcs4T9cZ4a8+HrtBmHUQ1jTRQZLXECRDH3LrmMHAwNJXTpEkIv
         ttSw==
X-Gm-Message-State: APjAAAXVQGb9jTPl1p/hLMYBeMLroQvrKa+yPtWM+ay0wIqJOdNq3Zsh
        TAAumx1/EocbS2o9BPX0mVg0Dg==
X-Google-Smtp-Source: APXvYqzppQYLVqSQxNu0WP8Ij9s84K1CSFUQ+cCcQwDX8geaiRWH3nZwKL16gKlY7J3Px/24N6L3Aw==
X-Received: by 2002:a17:902:8b85:: with SMTP id ay5mr1652431plb.120.1567705095379;
        Thu, 05 Sep 2019 10:38:15 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id n185sm2632568pga.16.2019.09.05.10.38.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Sep 2019 10:38:14 -0700 (PDT)
Date:   Thu, 5 Sep 2019 10:38:13 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
        Douglas Anderson <dianders@chromium.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Yong Mao <yong.mao@mediatek.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/11] mmc: core: WARN if SDIO IRQs are enabled for
 non-powered card in suspend
Message-ID: <20190905173813.GL70797@google.com>
References: <20190903142207.5825-1-ulf.hansson@linaro.org>
 <20190903142207.5825-8-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190903142207.5825-8-ulf.hansson@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 03, 2019 at 04:22:03PM +0200, Ulf Hansson wrote:
> To make sure SDIO func drivers behaves correctly during system
> suspend/resume, let add a WARN_ON in case the condition is a non-powered
> SDIO card and there are some SDIO IRQs still being claimed.
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/mmc/core/sdio.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
> index 8dd8fc32ecca..c557f1519b77 100644
> --- a/drivers/mmc/core/sdio.c
> +++ b/drivers/mmc/core/sdio.c
> @@ -951,6 +951,8 @@ static int mmc_sdio_pre_suspend(struct mmc_host *host)
>   */
>  static int mmc_sdio_suspend(struct mmc_host *host)
>  {
> +	WARN_ON(host->sdio_irqs && !mmc_card_keep_power(host));
> +
>  	/* Prevent processing of SDIO IRQs in suspended state. */
>  	mmc_card_set_suspended(host->card);
>  	cancel_delayed_work_sync(&host->sdio_irq_work);

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
