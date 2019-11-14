Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90F31C43215
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 00:31:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AB97206D8
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 00:31:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Hlj6rDrl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727237AbfKNAbo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 19:31:44 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40716 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726910AbfKNAbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 19:31:43 -0500
Received: by mail-pg1-f195.google.com with SMTP id 15so2473335pgt.7
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2019 16:31:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9sAWI1/WyVUJMv+/9lzXmr/UTEtbsKqgfoRGVLEnFt8=;
        b=Hlj6rDrliTvU/cepY3VqIv8iG73LNRL7563tZytDrLShqFopNYrRCLMIQdo9EA6jDE
         FInBRd96HhgghlpO3VGkTnv17MaY+PkaVo6Vpr8glXkHGY3k+2KW690kk3LBlh3tLN/K
         QHzIckFi5j/6rdruMb2CNBcJ8fpyccBBCzhrw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9sAWI1/WyVUJMv+/9lzXmr/UTEtbsKqgfoRGVLEnFt8=;
        b=F6ezoEC+q7MlAqpGnE+UFMTwiBRDRZJTk3uPxCghyskI32QfL0Cy1kQI/hWb4i5vl2
         AtTpJQ1ExAILM/TuCnshaM54Av/d0VdF/Od6JoBfbGyO6LnJJPjPkXgRmKjZaatsmrpp
         dpR/BDzwb3mdI77KEpausrTEsKWJGITmY0XqYfuNkV+zMCkraza2h1lpKezc4yH/dlbz
         9iDTc1hue0e2MXd8PQUxsbNFrgNGJB2IX73DzTKN6FCZZYgbzbNIdhQADjRWPOOlGepb
         1lgONhbd9f37twonuZvHtVIfZ5ih16FE+9E7YkRiEhRZMKDCl4D1+68LWZL3L9iDZlf/
         Ca8Q==
X-Gm-Message-State: APjAAAVsBTYU5Oa8ZNZIIAhs8uO64Hil/SI9ns0zfCEZzVOwnEeaZ+0h
        H0g1CWPj11l03SYPJWJHgnoa1K9UGo4=
X-Google-Smtp-Source: APXvYqy73l8AcMr+AtoYg+/uiIszTaLYGFq4eHui1Ai1uiPyzjRywtbILY5sc/7uW/xNvwGKPlOrWQ==
X-Received: by 2002:a17:90a:a898:: with SMTP id h24mr8777377pjq.48.1573691502087;
        Wed, 13 Nov 2019 16:31:42 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d22sm3672614pjd.2.2019.11.13.16.31.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2019 16:31:41 -0800 (PST)
Date:   Wed, 13 Nov 2019 16:31:40 -0800
From:   Kees Cook <keescook@chromium.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: print proper warning on dst underflow
Message-ID: <201911131625.8B0F0BAEDE@keescook>
References: <20190924090937.13001-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190924090937.13001-1-Jason@zx2c4.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 24, 2019 at 11:09:37AM +0200, Jason A. Donenfeld wrote:
> Proper warnings with stack traces make it much easier to figure out
> what's doing the double free and create more meaningful bug reports from
> users.
> 
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
>  net/core/dst.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/core/dst.c b/net/core/dst.c
> index 1325316d9eab..193af526e908 100644
> --- a/net/core/dst.c
> +++ b/net/core/dst.c
> @@ -172,7 +172,7 @@ void dst_release(struct dst_entry *dst)
>  		int newrefcnt;
>  
>  		newrefcnt = atomic_dec_return(&dst->__refcnt);
> -		if (unlikely(newrefcnt < 0))
> +		if (WARN_ONCE(newrefcnt < 0, "dst_release underflow"))
>  			net_warn_ratelimited("%s: dst:%p refcnt:%d\n",
>  					     __func__, dst, newrefcnt);

Should __refcnt be a refcount_t to gain saturation protection? It seems
like going negative is bad...

-Kees

>  		if (!newrefcnt)
> @@ -187,7 +187,7 @@ void dst_release_immediate(struct dst_entry *dst)
>  		int newrefcnt;
>  
>  		newrefcnt = atomic_dec_return(&dst->__refcnt);
> -		if (unlikely(newrefcnt < 0))
> +		if (WARN_ONCE(newrefcnt < 0, "dst_release_immediate underflow"))
>  			net_warn_ratelimited("%s: dst:%p refcnt:%d\n",
>  					     __func__, dst, newrefcnt);
>  		if (!newrefcnt)
> -- 
> 2.21.0
> 

-- 
Kees Cook
