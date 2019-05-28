Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61B23C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 07:27:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3300C20657
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 07:27:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o1TsHp1R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727509AbfE1H1W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 03:27:22 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46310 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbfE1H1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 03:27:22 -0400
Received: by mail-pl1-f194.google.com with SMTP id bb3so344011plb.13;
        Tue, 28 May 2019 00:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Gd99PMPFJDNN97/m1Xc5Z5yEsmfPQoIA8ErP+1/NeNQ=;
        b=o1TsHp1R8T8aB9jUprTmkPlBMcX4GSTekb6GAaaTrYUJ8b++KMHFwVl3wtG8iu1QVX
         BwykifL2WmW/OZBCmjx8GVHJQNxU3ASZOxx8UARRfykmtmCvkC+Ym0esJqfEhpp1KGmm
         NIzckkUr+O79w9ZY3CfcFzRrsB/L5LHo0auRkJoy65+gX3UP/Txw9NSp/JdRIj3eVyxU
         Hl8ho4inr4Up4ysRV2sp8HQl4/LryT/d+jH98vSUKIizE8rm+ARh2fENRah/x6i8dfYN
         Sfdd+P4CzlQxJ7TXaDjTGpX08ocBZwQc2e2/UMSNsrBNjsJZrMCs+DmTYfQZUuDoJfkN
         y4/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Gd99PMPFJDNN97/m1Xc5Z5yEsmfPQoIA8ErP+1/NeNQ=;
        b=Z9zIQWL7HGAO5z6jG0onwuk29lYEFxJ7UzdqpAkIEpqPZsU3McMBAMSc05EebqN9P6
         JGtFOfdp9PQXtYygJzHzvDlWF1Qr2VV/Sie0EiqaUY2O5h9kyJ3o7Q3ujaGKZl5/05/V
         Hs1e1OpMB/xW4Vw9SmjV60LrnqKDSknBRdoQTTJgjyM86cY1qEmCA3EiqDsTRojWPkuI
         En3MRwf/HFfiHFyVPwZh9/zOsBZvfWqRNcRlkYNIwgQiyNa3yqLijKiiDD6Ez5AgEYbR
         aElln9dNLJF1oSIeGV5a7+S27mYvNewbsjdQDNloq0X+HG0Xc80yeXZ+Bag9UZtovwTz
         IBrg==
X-Gm-Message-State: APjAAAVJeqTv2qk6DkVoDkFpfY6M8awCeXYA7wyRg8VDkRWfwUHWWpXD
        6RpYyS8M6VKiPX82N9aFUI5ErPzVrEY=
X-Google-Smtp-Source: APXvYqwyD67Ev4HArmTeE5xIhkSRsaqQgUA+ci0w1XvOYhg8JGl1RQyxwhAxievjTsGbEzOWQ4NFrg==
X-Received: by 2002:a17:902:29e6:: with SMTP id h93mr23939164plb.297.1559028440959;
        Tue, 28 May 2019 00:27:20 -0700 (PDT)
Received: from ?IPv6:2402:b801:2855:200:d90c:5599:3fa5:5f45? ([2402:b801:2855:200:d90c:5599:3fa5:5f45])
        by smtp.gmail.com with ESMTPSA id k14sm20796720pga.5.2019.05.28.00.27.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 May 2019 00:27:19 -0700 (PDT)
Subject: Re: [PATCH] mmc: meson-gx: fix irq ack
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     linux-amlogic@lists.infradead.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190523145950.7030-1-jbrunet@baylibre.com>
From:   Brad Harper <bjharper@gmail.com>
Message-ID: <4786e031-b070-f4b0-c7ba-1ffe1a2eab2d@gmail.com>
Date:   Tue, 28 May 2019 17:27:16 +1000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190523145950.7030-1-jbrunet@baylibre.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/05/2019 12:59 am, Jerome Brunet wrote:
> While cleaning the ISR of the meson-gx and acking only raised irqs,
> the ack of the irq was moved at the very last stage of the function.
> 
> This was stable during the initial tests but it triggered issues with
> hs200, under specific loads (like booting android). Acking the irqs
> after calling the mmc_request_done() causes the problem.
> 
> Moving the ack back to the original place solves the issue. Since the
> irq is edge triggered, it does not hurt to ack irq even earlier, so
> let's do it early in the ISR.
> 
> Fixes: 9c5fdb07a28d ("mmc: meson-gx: ack only raised irq")
> Tested-by: Neil Armstrong <narmstrong@baylibre.com>
> Tested-by: Kevin Hilman <khilman@baylibre.com>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>   drivers/mmc/host/meson-gx-mmc.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
> index 6ef465304052..cb3f6811d69a 100644
> --- a/drivers/mmc/host/meson-gx-mmc.c
> +++ b/drivers/mmc/host/meson-gx-mmc.c
> @@ -873,6 +873,9 @@ static irqreturn_t meson_mmc_irq(int irq, void *dev_id)
>   	if (WARN_ON(!host) || WARN_ON(!host->cmd))
>   		return IRQ_NONE;
>   
> +	/* ack all raised interrupts */
> +	writel(status, host->regs + SD_EMMC_STATUS);
> +
>   	cmd = host->cmd;
>   	data = cmd->data;
>   	cmd->error = 0;
> @@ -919,9 +922,6 @@ static irqreturn_t meson_mmc_irq(int irq, void *dev_id)
>   	if (ret == IRQ_HANDLED)
>   		meson_mmc_request_done(host->mmc, cmd->mrq);
>   
> -	/* ack all raised interrupts */
> -	writel(status, host->regs + SD_EMMC_STATUS);
> -
>   	return ret;
>   }
>   
> 
This patch resolves issues I was having with hung tasks waiting for emmc 
& sd cards on the odroid N2.

Tested-by: Brad Harper <bjharper@gmail.com>
