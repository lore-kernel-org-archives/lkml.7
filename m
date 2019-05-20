Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C770AC04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 16:30:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B62921479
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 16:30:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gJpyToqR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389545AbfETQaI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 12:30:08 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33923 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730795AbfETQaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 12:30:08 -0400
Received: by mail-pg1-f193.google.com with SMTP id c13so7043612pgt.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 09:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FVKmNQJMqTAQAcsz/9SSssbO/SW9TTP8CoLZIOoi9yQ=;
        b=gJpyToqRVPXO+ltYTK4Lky5OkAaw69Mrtrad5aCa7yGfK4El/0DXFkagU8tetuVEYZ
         FNuq5yCeUJLwscIO7jFNskEvfjsv0z13hPpROg4VNeSVpMdiT7xEx8vop6Hyzv4xl8Ad
         PyzdjtAoIZ60HpyLZmSOm6nzlppl5UquAwBes=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FVKmNQJMqTAQAcsz/9SSssbO/SW9TTP8CoLZIOoi9yQ=;
        b=KLE8Upb8EgR+B97LrnrrfrKO8ikpcyy7qammg3vMi3LMEANueZb1aEV/vU9ceTwaKx
         9HIMFhG+bQAt6zOxuQYPgHk7psbgaI3pg7w6yvtyhuHPEhXaGhjUb2o/GUDvYB7YUr3s
         XirRSkEiSbp0h+fdKR+ZDeDXmKH/Wkn51zYyMQPeRSR1guQ8n2FaqXiLdonvaAsx/HSo
         Dhqrdz3izTJ51EsppsYCajrbb7wMmjVDXMuWuqfEf33PwV/bwbkEkKRRuINA+qzWrpvM
         WwSQhAn7NpHe4TLMmvfdH8y02DLenMtPL9OsWoDh07r64b1OJu0l2B+Q9MOfMAG9uc1M
         VliA==
X-Gm-Message-State: APjAAAVZGUiTjSigUwkEvoO7UdR/KY3DSdEkVN+RVMALP45ygT3GTwCZ
        x13xSgt/qlSxMpl1yOG4x6OZkA==
X-Google-Smtp-Source: APXvYqzVifvMDX/kjUG1eWvAREG10gaiZB1oYdhgARh5JcvRgycmh9aS3rg0LlGcDI8ft1WFltEFsQ==
X-Received: by 2002:a62:1ec1:: with SMTP id e184mr14275504pfe.185.1558369807924;
        Mon, 20 May 2019 09:30:07 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e184sm23783506pfa.169.2019.05.20.09.30.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 May 2019 09:30:07 -0700 (PDT)
Date:   Mon, 20 May 2019 09:30:06 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Pi-Hsun Shih <pihsun@chromium.org>
Cc:     Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pstore: Set tfm to NULL on free_buf_for_compression.
Message-ID: <201905200928.08FE9977F3@keescook>
References: <20190520065120.245811-1-pihsun@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190520065120.245811-1-pihsun@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 20, 2019 at 02:51:19PM +0800, Pi-Hsun Shih wrote:
> Set tfm to NULL on free_buf_for_compression after crypto_free_comp.
> 
> This avoid a use-after-free when allocate_buf_for_compression and
> free_buf_for_compression are called twice. Although
> free_buf_for_compression freed the tfm, allocate_buf_for_compression
> won't reinitialize the tfm since the tfm pointer is not NULL.
> 
> Fixes: 95047b0519c1 ("pstore: Refactor compression initialization")
> Signed-off-by: Pi-Hsun Shih <pihsun@chromium.org>

Thank you! Yes, without this, reloading pstore backend modules would
cause bad behavior. :)

Applied; will send to Linus shortly.

-Kees

> ---
>  fs/pstore/platform.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/pstore/platform.c b/fs/pstore/platform.c
> index 75887a269b64..8355a46638d0 100644
> --- a/fs/pstore/platform.c
> +++ b/fs/pstore/platform.c
> @@ -347,8 +347,10 @@ static void allocate_buf_for_compression(void)
>  
>  static void free_buf_for_compression(void)
>  {
> -	if (IS_ENABLED(CONFIG_PSTORE_COMPRESS) && tfm)
> +	if (IS_ENABLED(CONFIG_PSTORE_COMPRESS) && tfm) {
>  		crypto_free_comp(tfm);
> +		tfm = NULL;
> +	}
>  	kfree(big_oops_buf);
>  	big_oops_buf = NULL;
>  	big_oops_buf_sz = 0;
> -- 
> 2.21.0.1020.gf2820cf01a-goog
> 

-- 
Kees Cook
