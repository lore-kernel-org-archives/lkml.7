Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DEA4C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 14:58:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB62D2147A
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 14:58:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pMFSTh+s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729447AbfCVO6e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 10:58:34 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:45087 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729253AbfCVO6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 10:58:33 -0400
Received: by mail-ed1-f67.google.com with SMTP id m16so1914764edd.12;
        Fri, 22 Mar 2019 07:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3bD/Mf98s2RAFDjZmr4bGpOJviyS/yiwhFYP82vSE0g=;
        b=pMFSTh+sIex8SGDOjSpwUl6nMjnJ8kTHHE6UfD5vuBbFhbmwkNkHCeQ02SD5dD/Dys
         SAmkFw4KneXXZZ/KurxcxhLGMqQg3Gj49LHmgVXNKljHVUoEgwG4w2k716zWcbPzVlgc
         CQkoC+Het0rANkAimJii35UHz117k3Zr8QrOOnIyXsM51C7oNbL8PDaaP3xJK8XSPb90
         hgJ/s8NolcGlyx3fmPybklWskWtRbElrhQ52G3qbNUBtOCAYqN8lKUAMakbSfga52+eF
         g5O9Jz1ZtPC+MGXp0AkrxaKlmjS1ew+MJizNjYEkJ7xVrOHgubrC0WegpOsiHtdRizoI
         wM2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3bD/Mf98s2RAFDjZmr4bGpOJviyS/yiwhFYP82vSE0g=;
        b=uFpM0192Etg9ewFr8Wm9HplTDkbxlYS9LCSuUlfnpV7Fmyws+oHY1t+ZLxl68DwatF
         LljXARYvHJ6neHAojo8XJmoPi1PQ9y7qM4lE+CJWZ8yFScokzkqenMv8sPmWgFTfM4gq
         IHy3RtS9mmXJT2gf4GfQZZgAJewj9XgKybyna4dnjNPvxoJVfReUJd+t2vJlBkjHJvyq
         +W+mHrT+mZH+uhiILyUyQs5U2va5jvX9XbW/Wv1U1q+aJBaLamSl+VAdcu2ot9srqAT3
         g02ccJn0sIlShCh+f8WzMP5NpZQmkfv5f8DiCl5XguSYp5vfwl0itUDSz2MM5Alv6lIc
         O0VA==
X-Gm-Message-State: APjAAAVYtem26r+uHCpfFHQD4w64+H47at55zGzx6Do8mbVpzMIsuc0Z
        BLxRipbK31BFdD5KpvjbhQ4=
X-Google-Smtp-Source: APXvYqyiq1zPylYYqOfJ3K5CFVBnyYlBzFsP4wx9MZq7O5Gl3hRe7lOjTBgfyRcCXpUoAcVeR1pgZg==
X-Received: by 2002:a17:906:1c4e:: with SMTP id l14mr5988583ejg.38.1553266711185;
        Fri, 22 Mar 2019 07:58:31 -0700 (PDT)
Received: from archlinux-ryzen ([2a01:4f9:2a:1fae::2])
        by smtp.gmail.com with ESMTPSA id g32sm2651311ede.78.2019.03.22.07.58.29
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 22 Mar 2019 07:58:30 -0700 (PDT)
Date:   Fri, 22 Mar 2019 07:58:28 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Lee Jones <lee.jones@linaro.org>,
        Stefan Agner <stefan@agner.ch>, linux-iio@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: stmpe-adc: avoid harmless clang warning
Message-ID: <20190322145828.GB6521@archlinux-ryzen>
References: <20190322140906.319267-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190322140906.319267-1-arnd@arndb.de>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 22, 2019 at 03:08:39PM +0100, Arnd Bergmann wrote:
> Clang points out a control flow bug, which happens to be harmless:
> 
> drivers/iio/adc/stmpe-adc.c:204:13: error: variable 'data' is used uninitialized whenever 'if' condition is false [-Werror,-Wsometimes-uninitialized]
> 
> The warning is sensible here, so let's just avoid the case by
> adding appropriate error handling.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/iio/adc/stmpe-adc.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/iio/adc/stmpe-adc.c b/drivers/iio/adc/stmpe-adc.c
> index 37f4b74a5d32..ed3817c5c896 100644
> --- a/drivers/iio/adc/stmpe-adc.c
> +++ b/drivers/iio/adc/stmpe-adc.c
> @@ -205,6 +205,8 @@ static irqreturn_t stmpe_adc_isr(int irq, void *dev_id)
>  		/* Read value */
>  		stmpe_block_read(info->stmpe, STMPE_REG_TEMP_DATA, 2,
>  				(u8 *) &data);
> +	} else {
> +		return IRQ_NONE;
>  	}
>  
>  	info->value = (u32) be16_to_cpu(data);
> -- 
> 2.20.0
> 

I sent a similar patch, which is sitting in Jonathan's testing branch:

https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/commit/?id=e15146e4d4349b3f309f5591ea8de8d24071265f

Nathan
