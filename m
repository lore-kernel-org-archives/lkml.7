Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D233C76195
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 08:59:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2028921849
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 08:59:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="UovNcYRJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727248AbfGSI7u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 04:59:50 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36468 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727056AbfGSI7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 04:59:49 -0400
Received: by mail-wm1-f65.google.com with SMTP id g67so24138473wme.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2019 01:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=r+mZG8DpAsPgWT5sar/21/BjX4up+4WpKJWqDr5y+XE=;
        b=UovNcYRJpNCwUpWYyK80hMB+LmsasMk/b+zRnOMrEiqyWDbVXt28ZRGBCmPPcZUN0Q
         /7jz/DscGGQ7KK1NVhsYrrZmsyJ1wT1ynx4YUOcbWknTuTYIitiIhSJYSjfxO7NDoc6A
         cYTtdySKxzcVDcyjoGRWTNZh5axkeqLWNaFU3JH3CGLkOMa8TXXFqu/1bhPnrwEP690/
         j7DnqohaO9uqFP/XnDXVak9aGhsnxhZrKERoM4ZBlXxPF8LvDVS/mfZ+LZ+SnCvaDFOj
         OBJIhRPnkIjaY5vjk8XEn2AqEibXwCokadCTrFNtJLDod4kk6C3EMdkFR9PqkEePJCcG
         HoOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=r+mZG8DpAsPgWT5sar/21/BjX4up+4WpKJWqDr5y+XE=;
        b=GZ8gzU0cs+EWcZssGBu9zTOjaJO87q3C/efuExpOmnCRP4vUGGaKTzdWQiAj/tiN3w
         2L0WbemqFE+AzH1gev88ll35NnjIDxH6aKsHnj79P/zE0KyB479UbRdS9eNwHeQzyWDo
         hLF7Y4EeQFsBjFNKKL9rhOtCEfN8r9SX4QcjgmTmR65rTOggBZqt+ku1GwqbCyA2f2YP
         nNJQLh4wM5G6u/OmB/rz8U2PX6jILcytSQjWw1Ofz7AzvYDt4da6jnwCJhT6VYpZrZaF
         i6d6ODmPVCfOFQCmAEcwWO+JLS4ErDuLUzLHepOK+FJrGKLv+V7ZpYYY6F1sFUCg8IYb
         q/xw==
X-Gm-Message-State: APjAAAXMQHjZbMRfKGeMgZJ0aXEoJ3YpVMoFMe5vP/Ubtgpex0sSnkwf
        LBUYEAeTttB3PtguLRevQTs=
X-Google-Smtp-Source: APXvYqwNeo4Lm2KsUkZw2PBIJv7c22XTMebEqmZ6IGLFDVHBMaZWzxlIxEOLZBcK+t8KjqIA8Sw8Mg==
X-Received: by 2002:a1c:6555:: with SMTP id z82mr48409335wmb.129.1563526787404;
        Fri, 19 Jul 2019 01:59:47 -0700 (PDT)
Received: from brauner.io ([81.92.17.140])
        by smtp.gmail.com with ESMTPSA id j17sm39177701wrb.35.2019.07.19.01.59.46
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 19 Jul 2019 01:59:46 -0700 (PDT)
Date:   Fri, 19 Jul 2019 10:59:45 +0200
From:   Christian Brauner <christian@brauner.io>
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: Re: [PATCH] riscv: enable sys_clone3 syscall for rv64
Message-ID: <20190719085944.n4ypavxdlf6go4tl@brauner.io>
References: <alpine.DEB.2.21.9999.1907182118500.7083@viisi.sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.9999.1907182118500.7083@viisi.sifive.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 18, 2019 at 09:20:01PM -0700, Paul Walmsley wrote:
> 
> Enable the sys_clone3 syscall for RV64.  We simply include the generic
> version.
> 
> Tested by running the program from
> 
>    https://lore.kernel.org/lkml/20190716130631.tohj4ub54md25dys@brauner.io/
> 
> and verifying that it completes successfully.
> 
> Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
> Cc: Christian Brauner <christian@brauner.io>

Thank you!

Acked-by: Christian Brauner <christian@brauner.io>

> ---
>  arch/riscv/include/uapi/asm/unistd.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/riscv/include/uapi/asm/unistd.h b/arch/riscv/include/uapi/asm/unistd.h
> index 0e2eeeb1fd27..13ce76cc5aff 100644
> --- a/arch/riscv/include/uapi/asm/unistd.h
> +++ b/arch/riscv/include/uapi/asm/unistd.h
> @@ -18,6 +18,7 @@
>  #ifdef __LP64__
>  #define __ARCH_WANT_NEW_STAT
>  #define __ARCH_WANT_SET_GET_RLIMIT
> +#define __ARCH_WANT_SYS_CLONE3
>  #endif /* __LP64__ */
>  
>  #include <asm-generic/unistd.h>
> -- 
> 2.22.0
> 
