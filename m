Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 823ADC10F14
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 20:36:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DD772082A
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 20:36:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WJ3PJA9c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726778AbfDJUgA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 16:36:00 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41494 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726022AbfDJUf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 16:35:59 -0400
Received: by mail-pl1-f195.google.com with SMTP id d1so2103258plj.8;
        Wed, 10 Apr 2019 13:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=AOCruZGFxfGAvkYSTxXE5TT5bCaL54M+IDuOn13hQzU=;
        b=WJ3PJA9cV7UpLzPKtF7p0y/RlbPPDPomlhtWe9If0aR12RSXpsZIZva31UKVRu8GCg
         nxjNBVMSmHpjb4Pi9nz+XoKfbgbSRutzTZpVSSrV9WT/a7tN1t1afagTMvaPf4w8+BQx
         /dn3wl0aQFKDlBNatqopGGzavSfWuoC0QJbQqq0sW0U0FTXWqgHA1OP6VRGA5Tda8e/S
         j92G1zgyCZsP8uj57sCDu+DYQsySepmCX8aUp97PE1/BhyyAWZ4c3HRjUxVSFP6gH4Iw
         wSRAz3sdzxtREvq7oklDR7wRreXAf3PlKscfc+tdVqz68WP7wYKafKqw2VLZNVnb1F9A
         rLPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=AOCruZGFxfGAvkYSTxXE5TT5bCaL54M+IDuOn13hQzU=;
        b=Kl6kuuHfRVlEUsliu83gdlW1V7Q1hywMyB2n0Yqt//lBcZvZdSY3qjppgEPCyqsxRo
         F+x/sgp3g5eHAJ48r3q4l15XQ8H0iz391xl1GW+RLZlUwZltZM8wbJDeM8Auvy3O8nKs
         MVmNBHO6rpND+oufBKfpNTSqXEIiszB+dz2NQS62pd4zxpwgO/hj6OkziYotUrVkcsIj
         tPrb0v5fTnrOJxdKM6W8jAgzYNCvKkJl/7yuiB8ntP+hpqireRQ3d++6mnx+BuNdTIAL
         v80gJ4yUmUcZEh1ftM8KANTryCA1vWYXraEE07woZRHDTqcL7p/Fj7Wiquk0+WWLRfQi
         VGwg==
X-Gm-Message-State: APjAAAXozfjFIjH+0yTiL425bZWndrbNsKVNqWyY/TCr6yOxUxoVLMRW
        ZGRo8irIpjNhNJO1SZbdG4PJZSFW
X-Google-Smtp-Source: APXvYqySgV2KtvX8oS31dQ8VIBcUMvrTKB2xeWoY5JYz5rBkJ25itUD1uTNe5/P/2PlxjWSgW9dgvw==
X-Received: by 2002:a17:902:102a:: with SMTP id b39mr11963364pla.188.1554928558994;
        Wed, 10 Apr 2019 13:35:58 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c3sm70112108pfg.88.2019.04.10.13.35.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 13:35:57 -0700 (PDT)
Date:   Wed, 10 Apr 2019 13:35:56 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] watchdog: machzwd: Mark expected switch fall-through
Message-ID: <20190410203556.GA18676@roeck-us.net>
References: <20190410184905.GA24283@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190410184905.GA24283@embeddedor>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2019 at 01:49:05PM -0500, Gustavo A. R. Silva wrote:
> In preparation to enabling -Wimplicit-fallthrough, mark switch
> cases where we are expecting to fall through.
> 
> This patch fixes the following warnings:
> 
> drivers/watchdog/machzwd.c: In function ‘zf_set_timer’:
> ./arch/x86/include/asm/io.h:355:14: warning: this statement may fall through [-Wimplicit-fallthrough=]
>  #define outw outw
> drivers/watchdog/machzwd.c:80:53: note: in expansion of macro ‘outw’
>  #define zf_writew(port, data)  { outb(port, INDEX); outw(data, DATA_W); }
>                                                      ^~~~
> drivers/watchdog/machzwd.c:179:3: note: in expansion of macro ‘zf_writew’
>    zf_writew(COUNTER_1, new);
>    ^~~~~~~~~
> drivers/watchdog/machzwd.c:180:2: note: here
>   case WD2:
>   ^~~~
> 
> Warning level 3 was used: -Wimplicit-fallthrough=3
> 
> This patch is part of the ongoing efforts to enable
> -Wimplicit-fallthrough.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/machzwd.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/watchdog/machzwd.c b/drivers/watchdog/machzwd.c
> index 88d823d87a4b..108928dbc754 100644
> --- a/drivers/watchdog/machzwd.c
> +++ b/drivers/watchdog/machzwd.c
> @@ -177,6 +177,7 @@ static inline void zf_set_timer(unsigned short new, unsigned char n)
>  	switch (n) {
>  	case WD1:
>  		zf_writew(COUNTER_1, new);
> +		/* fall through */
>  	case WD2:
>  		zf_writeb(COUNTER_2, new > 0xff ? 0xff : new);
>  	default:
> -- 
> 2.21.0
> 
