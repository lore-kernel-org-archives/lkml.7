Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 503A9C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 16:58:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28417208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 16:58:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NYl99vyA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730058AbfG3Q6c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 12:58:32 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41004 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729922AbfG3Q6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 12:58:25 -0400
Received: by mail-pl1-f196.google.com with SMTP id m9so29022158pls.8
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 09:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=jqpmDskC1TX3bDYKWtDCT3o+UHu1vSyRRlAS80boooA=;
        b=NYl99vyAT2g2qXKQ/ttxv6aK/4pI+Jl+Rn3x41C+8nOthzPscIoxz6kHmXyo684aqG
         rb/0K0XKFlgYoF+kY7SOO8gNgdlwyN4HM3Sr/Il3Cc81/9hBsWfLxJ3iCYgJPxoT4CkQ
         pH7WKK76bW5K7Dey9WO+grzz2tU/TbIwhooDY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=jqpmDskC1TX3bDYKWtDCT3o+UHu1vSyRRlAS80boooA=;
        b=dB55XDSMJ/wpdlHDnNTQRbirbAuIJuoFDk1NWHRCPU/Qm2HrJTpe09GufaUxgsTLYV
         NtWUQUGwm/EicP8vg+Z23jJ4Mq258ILmpUyJWJ2GLFP5B9KmqfhzSZiy9NuEdnaOrR2V
         PSmTXmK23BeTBJWO5S2zv6rSp4jgMqPz5mzM/Hue/9dLQ+wznoAgZatjYEHPAZaTSS0X
         dacnNLR2NENebcCzGcV4llyMoHf66uwjC/glX5qH99zAyXtzf0gOtKtT6b6ofa2LYNab
         QBCz1I0uXZ8hLGLF470taYZUxtD9wQUUIFKElJtgbtEtp1GgRX1KunVE1jAqTO/OnF0G
         7f0g==
X-Gm-Message-State: APjAAAUuQ8mO+U43LEPK1aKRr+CQP08DUStGT2R/DyuxhKMUTpWCTv7A
        2tb1+87KUty65QglmGLoURwqkg==
X-Google-Smtp-Source: APXvYqy+gf0+nnb94maI7cm2nLvFWTuE6F7PLqZv3vnkSk94sQZV8oHEN6i6kMXftvAY1TByP9u8+g==
X-Received: by 2002:a17:902:724:: with SMTP id 33mr113301701pli.49.1564505904179;
        Tue, 30 Jul 2019 09:58:24 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h6sm62711549pfb.20.2019.07.30.09.58.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Jul 2019 09:58:23 -0700 (PDT)
Date:   Tue, 30 Jul 2019 09:58:22 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Sebastian Reichel <sre@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HSI: ssi_protocol: Mark expected switch fall-throughs
Message-ID: <201907300958.6BA873C4E@keescook>
References: <20190729224519.GA23078@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190729224519.GA23078@embeddedor>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 29, 2019 at 05:45:19PM -0500, Gustavo A. R. Silva wrote:
> Mark switch cases where we are expecting to fall through.
> 
> This patch fixes the following warning (Building: arm):
> 
> drivers/hsi/clients/ssi_protocol.c: In function ‘ssip_set_rxstate’:
> drivers/hsi/clients/ssi_protocol.c:291:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
>    if (atomic_read(&ssi->tx_usecnt))
>       ^
> drivers/hsi/clients/ssi_protocol.c:294:2: note: here
>   case RECEIVING:
>   ^~~~
> 
> drivers/hsi/clients/ssi_protocol.c: In function ‘ssip_keep_alive’:
> drivers/hsi/clients/ssi_protocol.c:466:7: warning: this statement may fall through [-Wimplicit-fallthrough=]
>     if (atomic_read(&ssi->tx_usecnt) == 0)
>        ^
> drivers/hsi/clients/ssi_protocol.c:472:3: note: here
>    case SEND_IDLE:
>    ^~~~
> 
> Notice that, in this particular case, the code comment is
> modified in accordance with what GCC is expecting to find.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  drivers/hsi/clients/ssi_protocol.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/hsi/clients/ssi_protocol.c b/drivers/hsi/clients/ssi_protocol.c
> index 9aeed98b87a1..504d00ec1ea7 100644
> --- a/drivers/hsi/clients/ssi_protocol.c
> +++ b/drivers/hsi/clients/ssi_protocol.c
> @@ -290,7 +290,7 @@ static void ssip_set_rxstate(struct ssi_protocol *ssi, unsigned int state)
>  		/* CMT speech workaround */
>  		if (atomic_read(&ssi->tx_usecnt))
>  			break;
> -		/* Otherwise fall through */
> +		/* Else, fall through */
>  	case RECEIVING:
>  		mod_timer(&ssi->keep_alive, jiffies +
>  						msecs_to_jiffies(SSIP_KATOUT));
> @@ -465,9 +465,10 @@ static void ssip_keep_alive(struct timer_list *t)
>  		case SEND_READY:
>  			if (atomic_read(&ssi->tx_usecnt) == 0)
>  				break;
> +			/* Fall through */
>  			/*
> -			 * Fall through. Workaround for cmt-speech
> -			 * in that case we relay on audio timers.
> +			 * Workaround for cmt-speech in that case
> +			 * we relay on audio timers.
>  			 */
>  		case SEND_IDLE:
>  			spin_unlock(&ssi->lock);
> -- 
> 2.22.0
> 

-- 
Kees Cook
