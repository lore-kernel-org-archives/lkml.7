Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 759B3C76190
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 17:04:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4291621901
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 17:04:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="A4d/8rph"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730675AbfGVRER (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 13:04:17 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45997 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728233AbfGVREQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 13:04:16 -0400
Received: by mail-pl1-f193.google.com with SMTP id y8so19453234plr.12
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 10:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=K29Ipcclc60RzAqsCilgMUO0dkXQXIOf0pnWrIHk3gk=;
        b=A4d/8rphmQo5d4NUW7y46xQIA1eEtFulENS+5nt6hdufFHyi+85QBVeoqzosK2gZpZ
         79LJ2Fddb8/vAdXFHFMv7dTtfkW7OWAkvUUoopGEHgqHjrDTGByiTo4pS8OjkWTdggk+
         jbeyjhK6TmsIHP/Gqqedd7t+rhbcLsUey9W2M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=K29Ipcclc60RzAqsCilgMUO0dkXQXIOf0pnWrIHk3gk=;
        b=jO+H1AMC4s0kJq5/5MQQNnAu6+mmPgYVkqvhqRa6zQ+2z2im9mjba6gsLYcnc+yJlt
         9WBTXmWuG3kXiaOD+oeCTPgVoMPXFi/bvMymTbKYO7I88MTJrXYFJG/ClA0TRpr5vFTV
         AAkjsmikcgmpejwr+EdwNAnxH1boEDIuExE41RvYnGYF0yUAcSpi+Y0bilXC2ZshlMDb
         D69Yq6DU50m5K5/PP8Du3oPshF94fdnrCYrHKBop/6GVwpKbd1jaxhZ5gLje0Pg60MG2
         E9X0WC58zkLwlZ8S+1HoZu+o076pJn4BBDG8a+gE1WJXei48G0um1VDrB+WuaeHKseO9
         FsUw==
X-Gm-Message-State: APjAAAXNGyKGkimXn/F3sG4xmQPBnHxe56WE/xQHSA9tTmCU5E8U3ZbU
        3GaJx8cFl5Twkaf1zXN3kFzQjQ==
X-Google-Smtp-Source: APXvYqwN4047pf65tRkSxrGBJj4B2PHvPUaE8Y8ZoJVAklTqww0m5YFE674/gDSflGmF4h/HGNSlqg==
X-Received: by 2002:a17:902:24c:: with SMTP id 70mr75713783plc.2.1563815055886;
        Mon, 22 Jul 2019 10:04:15 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g2sm52865120pfb.95.2019.07.22.10.04.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Jul 2019 10:04:15 -0700 (PDT)
Date:   Mon, 22 Jul 2019 10:04:14 -0700
From:   Kees Cook <keescook@chromium.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     gustavo@embeddedor.com, terrelln@fb.com, clm@fb.com,
        yamada.masahiro@socionext.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lib: zstd: Make ZSTD_compressBlock_greedy_extDict static
Message-ID: <201907221004.76B87B1A@keescook>
References: <20190717091852.50808-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190717091852.50808-1-yuehaibing@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 17, 2019 at 05:18:52PM +0800, YueHaibing wrote:
> Fix sparse warnings:
> 
> lib/zstd/compress.c:2252:6: warning:
>  symbol 'ZSTD_compressBlock_greedy_extDict' was not declared. Should it be static?
> lib/zstd/compress.c:2982:14: warning:
>  symbol 'ZSTD_createCStream_advanced' was not declared. Should it be static?
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  lib/zstd/compress.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/zstd/compress.c b/lib/zstd/compress.c
> index 5e0b67003e55..651d686c00b6 100644
> --- a/lib/zstd/compress.c
> +++ b/lib/zstd/compress.c
> @@ -2249,7 +2249,11 @@ void ZSTD_compressBlock_lazy_extDict_generic(ZSTD_CCtx *ctx, const void *src, si
>  	}
>  }
>  
> -void ZSTD_compressBlock_greedy_extDict(ZSTD_CCtx *ctx, const void *src, size_t srcSize) { ZSTD_compressBlock_lazy_extDict_generic(ctx, src, srcSize, 0, 0); }
> +static void ZSTD_compressBlock_greedy_extDict(ZSTD_CCtx *ctx, const void *src,
> +					      size_t srcSize)
> +{
> +	ZSTD_compressBlock_lazy_extDict_generic(ctx, src, srcSize, 0, 0);
> +}
>  
>  static void ZSTD_compressBlock_lazy_extDict(ZSTD_CCtx *ctx, const void *src, size_t srcSize)
>  {
> @@ -2979,7 +2983,7 @@ size_t ZSTD_CStreamWorkspaceBound(ZSTD_compressionParameters cParams)
>  	return ZSTD_CCtxWorkspaceBound(cParams) + ZSTD_ALIGN(sizeof(ZSTD_CStream)) + ZSTD_ALIGN(inBuffSize) + ZSTD_ALIGN(outBuffSize);
>  }
>  
> -ZSTD_CStream *ZSTD_createCStream_advanced(ZSTD_customMem customMem)
> +static ZSTD_CStream *ZSTD_createCStream_advanced(ZSTD_customMem customMem)
>  {
>  	ZSTD_CStream *zcs;
>  
> -- 
> 2.20.1
> 
> 

-- 
Kees Cook
