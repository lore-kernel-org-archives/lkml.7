Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDFC2C04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 23:04:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9328C20879
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 23:04:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PgBgvpYO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbfEMXEF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 19:04:05 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37913 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726233AbfEMXEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 19:04:05 -0400
Received: by mail-pg1-f196.google.com with SMTP id j26so7530895pgl.5
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 16:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rB/cRbmS+NnD3rWrm7IffP0qW7Mvex47RRx7B+4SZck=;
        b=PgBgvpYOERrp4jwxt2ZoNho4cAbNeZOGoh21BytT926gsZCbBWXxf2L5zAJkG6FGPO
         o4f4KNgZRyTzgyiXKfpzG6ME2oS62CPo1WL8C83y3p7EPKFFukhCcBd6O6JUh21OID9M
         xCX2tOKT0YovAGuoNATEprPZuJSYoma9WPxVk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rB/cRbmS+NnD3rWrm7IffP0qW7Mvex47RRx7B+4SZck=;
        b=d/XBL5nED0Hns2DpwAp+gdCu42SKQ+ARFbMXB7zoDuhsxbWFgHUi658WqWnp/eF2pe
         U9Iit1dtLz8gJhur6scLm6ARWjToHueH5WlybDdKbUvkXRfykuniGcYql7VfQrRvKEIf
         sjR1Pww+XiG8HFK5rhpMcgv/YdNDT77Z1Cqdu4BW7xh+aNh1qU+uzYP/9onbEd/7sH0f
         w6Fro01++m+f8FyGNbGfhTXPM6az1qmx0d3DYsWki5ll1/OTfYyd7DdzcQ0pNdipAW8U
         a2Ug/92VlEGMvxsqoB8Rd9JP6QhbAqXqAry3xqSce8J96np6dxMDVa0be2TFX9M3Ek1Q
         J8KA==
X-Gm-Message-State: APjAAAWDBNm5LjuSL2zNSGWcn8dl/ipCoN/zLlKbHAd0hUNFfVUQh3gZ
        +Nk6wFYCUCUY73/zFtiE+95uQA==
X-Google-Smtp-Source: APXvYqxlIudXX+clAP/f6kkDAYWiiDXa7wFnCEzZ7MCYAnNP7jIhAb88h4ZX6oiry/foD6r4l9DulA==
X-Received: by 2002:a63:e24:: with SMTP id d36mr34928460pgl.80.1557788644576;
        Mon, 13 May 2019 16:04:04 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 132sm17756175pga.79.2019.05.13.16.04.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 May 2019 16:04:03 -0700 (PDT)
Date:   Mon, 13 May 2019 16:04:02 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathanchance@gmail.com>,
        Jordan Rupprect <rupprecht@google.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lkdtm: support llvm-objcopy
Message-ID: <201905131602.DD63783846@keescook>
References: <20190513222109.110020-1-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190513222109.110020-1-ndesaulniers@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 13, 2019 at 03:21:09PM -0700, Nick Desaulniers wrote:
> With CONFIG_LKDTM=y and make OBJCOPY=llvm-objcopy, llvm-objcopy errors:
> llvm-objcopy: error: --set-section-flags=.text conflicts with
> --rename-section=.text=.rodata
> 
> Rather than support setting flags then renaming sections vs renaming
> then setting flags, it's simpler to just change both at the same time
> via --rename-section.
> 
> This can be verified with:
> $ readelf -S drivers/misc/lkdtm/rodata_objcopy.o
> ...
> Section Headers:
>   [Nr] Name              Type             Address           Offset
>        Size              EntSize          Flags  Link  Info  Align
> ...
>   [ 1] .rodata           PROGBITS         0000000000000000  00000040
>        0000000000000004  0000000000000000   A       0     0     4
> ...
> 
> Which shows in the Flags field that .text is now renamed .rodata, the
> append flag A is set, and the section is not flagged as writeable W.
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/448
> Reported-by: Nathan Chancellor <nathanchance@gmail.com>
> Suggested-by: Jordan Rupprect <rupprecht@google.com>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>

Thanks! This looks good. Greg, can you please take this for drivers/misc?

Acked-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  drivers/misc/lkdtm/Makefile | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/misc/lkdtm/Makefile b/drivers/misc/lkdtm/Makefile
> index 951c984de61a..89dee2a9d88c 100644
> --- a/drivers/misc/lkdtm/Makefile
> +++ b/drivers/misc/lkdtm/Makefile
> @@ -15,8 +15,7 @@ KCOV_INSTRUMENT_rodata.o	:= n
>  
>  OBJCOPYFLAGS :=
>  OBJCOPYFLAGS_rodata_objcopy.o	:= \
> -			--set-section-flags .text=alloc,readonly \
> -			--rename-section .text=.rodata
> +			--rename-section .text=.rodata,alloc,readonly
>  targets += rodata.o rodata_objcopy.o
>  $(obj)/rodata_objcopy.o: $(obj)/rodata.o FORCE
>  	$(call if_changed,objcopy)
> -- 
> 2.21.0.1020.gf2820cf01a-goog
> 

-- 
Kees Cook
