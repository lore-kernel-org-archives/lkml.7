Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60532C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 15:17:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E1DD20840
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 15:17:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LYIDiez8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726409AbfCGPRE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 10:17:04 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:35379 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726234AbfCGPRD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 10:17:03 -0500
Received: by mail-ed1-f67.google.com with SMTP id g19so13790852edp.2;
        Thu, 07 Mar 2019 07:17:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EnBG/jYFGZXIPmXjPSsJ0Xe6CVDd0LXpmkp8WyNGT7k=;
        b=LYIDiez8o5sGt/QW7Ty4zb2fWf8DdqHSowQasPybGtWXVQPcp3IE0iAEMNY35V8Mv2
         Qb8ikF0g05oZZ7b23BZbjRgJSmiPONaSnXKdCaCUGRN3qoLSD2rWuhHW41XUvKYhVkQL
         UKs3m1anzPcuLJu6VcS7wc8KyXr9wNylAChAz7PBa41rU8Q+a3/DQI5pZSqNkN7wrKAq
         o1fYWAm8hRyIkZAsq4+JyDNPn4Jihc6/d3YS9Ayel3z48h56PabEf8es0MumZyCnc41q
         CFTlJXaAzTGC7tg5j/P3kcqlLbfxBeGTAT/2CzzW+qp0HZH9bBEHEkgnQbDPFo4pYPnB
         QdYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EnBG/jYFGZXIPmXjPSsJ0Xe6CVDd0LXpmkp8WyNGT7k=;
        b=l71/aiGnkYGCIWB4f3oRcJdsyQ9yURbgy/kdJrIrO4uziamX17A6oM750BX4Fge4KN
         GYp7rmnx5auJSk+PCMAwAk8GjR5DxGqKFQQJlcg5PwWQYGlz/TH2gwWx5zP8bWHm/elI
         80P2iqCnX8G8j/mQTaOedjJDgzcYz1atAM2fgZXAOZeaikRkmpSF16GUJTOVDXsDLV+b
         cTl+zOAfPFhhovWTkMD/R1WvyDRn/TeemgCBcNfDltma1Ir5Ymy1vbEt2G94Qsq/H5W0
         eKvyTqeMsIMrHBFGlyoHfEU3n4HwrnFWqR0MCLQw5INMVk6jrXYHowqVmqke3ZWCbEMo
         OW7A==
X-Gm-Message-State: APjAAAWa5JehncpTlLkY/lbxXdkJbpVJzLogC63HtVE6mtbl1BTLg2hC
        CNdJ0Ob/I9LjcHRcCZhdSVdoB8juX9Q=
X-Google-Smtp-Source: APXvYqwx0JNp23U1y9Lc5OUNt0LfyqwHw8SYZa7Pmh6j89+sH2nsCeQ0fy4eJkiPcPHZ8J7omzm50Q==
X-Received: by 2002:a17:906:b7c2:: with SMTP id fy2mr8282973ejb.9.1551971821280;
        Thu, 07 Mar 2019 07:17:01 -0800 (PST)
Received: from archlinux-ryzen ([2a01:4f9:2a:1fae::2])
        by smtp.gmail.com with ESMTPSA id fy6sm935452ejb.52.2019.03.07.07.17.00
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 07 Mar 2019 07:17:00 -0800 (PST)
Date:   Thu, 7 Mar 2019 08:16:58 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-omap@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] davinci_emac: always build in CONFIG_OF code
Message-ID: <20190307151658.GB20201@archlinux-ryzen>
References: <20190307093135.3354493-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190307093135.3354493-1-arnd@arndb.de>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 07, 2019 at 10:31:20AM +0100, Arnd Bergmann wrote:
> clang warns about what seems to be an unintended use of an obscure C
> language feature where a forward declaration of an array remains usable
> when the final definition is never seen:
> 
> drivers/net/ethernet/ti/davinci_emac.c:1694:34: error: tentative array definition assumed to have one element [-Werror]
> static const struct of_device_id davinci_emac_of_match[];
> 
> There is no harm in always enabling the device tree matching code here,
> and it makes the code behave in a more conventional way aside from
> avoiding the warning.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>

> ---
>  drivers/net/ethernet/ti/davinci_emac.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/ti/davinci_emac.c b/drivers/net/ethernet/ti/davinci_emac.c
> index 840820402cd0..57450b174fc4 100644
> --- a/drivers/net/ethernet/ti/davinci_emac.c
> +++ b/drivers/net/ethernet/ti/davinci_emac.c
> @@ -2029,7 +2029,6 @@ static const struct dev_pm_ops davinci_emac_pm_ops = {
>  	.resume		= davinci_emac_resume,
>  };
>  
> -#if IS_ENABLED(CONFIG_OF)
>  static const struct emac_platform_data am3517_emac_data = {
>  	.version		= EMAC_VERSION_2,
>  	.hw_ram_addr		= 0x01e20000,
> @@ -2046,14 +2045,13 @@ static const struct of_device_id davinci_emac_of_match[] = {
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, davinci_emac_of_match);
> -#endif
>  
>  /* davinci_emac_driver: EMAC platform driver structure */
>  static struct platform_driver davinci_emac_driver = {
>  	.driver = {
>  		.name	 = "davinci_emac",
>  		.pm	 = &davinci_emac_pm_ops,
> -		.of_match_table = of_match_ptr(davinci_emac_of_match),
> +		.of_match_table = davinci_emac_of_match,
>  	},
>  	.probe = davinci_emac_probe,
>  	.remove = davinci_emac_remove,
> -- 
> 2.20.0
> 
