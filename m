Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D40FDC7618B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 16:34:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC42021655
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 16:34:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XbJNhEas"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729209AbfG2Qe6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 12:34:58 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43285 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729195AbfG2Qe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 12:34:58 -0400
Received: by mail-pf1-f196.google.com with SMTP id i189so28309456pfg.10
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 09:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sDSCepMkR2bL5Wr/nR20Z2uWmhbnLcrsn71Gn90luLw=;
        b=XbJNhEas82gAqvT7+0uKPnBQXmY1bdSWMvlhGYnRuK2Tz53TPDGRi+sZihvQRqBA9E
         eH7iEjvJVAtqr4SwQkBV7kLJd9vGJP8LDI4g6xbbGLgfkVlamu0amAGZa06ft0WabEhb
         dW/YDi4mgPWPnbznja2Au4bxUF8sISHe/hfaI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sDSCepMkR2bL5Wr/nR20Z2uWmhbnLcrsn71Gn90luLw=;
        b=aQrieRP50UazgbPkvufaNHWWLtHIasoTdG6Ck6lUsN5f0xVuHmwFRjd7L5tBORFGfx
         fpt55cJQ6F0OV+aSbtKofrIc3ZNT3fv1w0T1IAPKxL3vUtj9xsaEhaKtSJlzYNbFAn06
         kOdBVN+knw9yV06aUbWGwrWjvpo3X6IDD0EGdaOOHZp7q4ZTn3wYgKrCb12d60Crp1PM
         MkMOJqyF0W6eLhjNMQgheQ54af43rLCiK6WbOFMvjU36xPNBkFqb9cIkziHt/09mS88K
         T/9AzNekTgEKVLGCrx/sUx2nmcKrIg2E2k00XyQ6sAVqF5HLypD7C4Vsx0pC0bzyHHk8
         qMdA==
X-Gm-Message-State: APjAAAVWPmko1DfCIzREbWTcOMuAv66g3K+ucTSZC2DukuIWnNG/2tzy
        2FBTUBshHBP/7l2KdZJRLQlYnVZi+Ss=
X-Google-Smtp-Source: APXvYqxaKTxKSNNjt8UOl7wNOOomuHl6ngrDpmPTgBkq84LNTpXKwVVinqdCXykfOa5exwsXSmvowQ==
X-Received: by 2002:a17:90a:b104:: with SMTP id z4mr112755496pjq.102.1564418097415;
        Mon, 29 Jul 2019 09:34:57 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 2sm110616451pgm.39.2019.07.29.09.34.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Jul 2019 09:34:56 -0700 (PDT)
Date:   Mon, 29 Jul 2019 09:34:55 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] i2c: s3c2410: Mark expected switch fall-through
Message-ID: <201907290934.959721D@keescook>
References: <20190728235138.GA23429@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190728235138.GA23429@embeddedor>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 28, 2019 at 06:51:38PM -0500, Gustavo A. R. Silva wrote:
> Mark switch cases where we are expecting to fall through.
> 
> This patch fixes the following warning:
> 
> drivers/i2c/busses/i2c-s3c2410.c: In function 'i2c_s3c_irq_nextbyte':
> drivers/i2c/busses/i2c-s3c2410.c:431:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
>    if (i2c->state == STATE_READ)
>       ^
> drivers/i2c/busses/i2c-s3c2410.c:439:2: note: here
>   case STATE_WRITE:
>   ^~~~
> 
> Notice that, in this particular case, the code comment is
> modified in accordance with what GCC is expecting to find.
> 
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  drivers/i2c/busses/i2c-s3c2410.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/i2c/busses/i2c-s3c2410.c b/drivers/i2c/busses/i2c-s3c2410.c
> index d97fb857b0ea..c98ef4c4a0c9 100644
> --- a/drivers/i2c/busses/i2c-s3c2410.c
> +++ b/drivers/i2c/busses/i2c-s3c2410.c
> @@ -435,6 +435,7 @@ static int i2c_s3c_irq_nextbyte(struct s3c24xx_i2c *i2c, unsigned long iicstat)
>  		 * fall through to the write state, as we will need to
>  		 * send a byte as well
>  		 */
> +		/* Fall through */
>  
>  	case STATE_WRITE:
>  		/*
> -- 
> 2.22.0
> 

-- 
Kees Cook
