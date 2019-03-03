Return-Path: <SRS0=GAfv=RG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58E6AC43381
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 03:04:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CA1320863
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 03:04:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U/omCN80"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727250AbfCCDEy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Mar 2019 22:04:54 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:37925 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbfCCDEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Mar 2019 22:04:54 -0500
Received: by mail-ed1-f66.google.com with SMTP id h58so1476918edb.5
        for <linux-kernel@vger.kernel.org>; Sat, 02 Mar 2019 19:04:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NT+i6KbSGt97JaAkaMzs+KIYok+NESXIcKEDph3d8mo=;
        b=U/omCN80NV+pQWYvUPS5lGM8EYWAt0rkE53zUe22sHQOhhhG3uzdWcOaX5hg+dA9sN
         3vGNhxFqc2YnBS+e4O+u/Htb3VADvWObMV6yfAGekHn7sWE/lgo1+TFsV1+LLTR9tSuB
         4w6BQafUr0fiotHfYBP2VlyY1mcMtI2GB2L6VHBsPJDapS6PbM7YTMQ8nl8uU79kaM+k
         bX2SOAjsOtIgcx52z5sg3+Pdt5XNyrZMQwB9SE3SRWLSxDAa2bBZipCGxa4Axa9zmG0Z
         l2VAT/wWgm5w53mAXOmadkbE4EFanPYhmiZ/+ZtusppMTtscYN82jI9Il7KXArCQRxua
         RfTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NT+i6KbSGt97JaAkaMzs+KIYok+NESXIcKEDph3d8mo=;
        b=ecGbH3bNEfYw58VVwAG8ETU5ynOM0JaSLkT4HTAoT9IUhwQdywKcOb3vaSAcsDRj7e
         qSA2qPlhUP5QTQB3F8L27yhN02yg/jH7dalkpSpOPickcmsxYAAa4ruQzzzYtGTto8b8
         Zok5KyhBDElQmg3PYEOw/stekcIjohzEg/aFvKFt/QyMs6fg4XC6IZgHVRIixdCSiJAc
         DScDqjJF+nDmIGwnX280/5xxTCIc4bmj91moTR4IV7b4KasIOe5gVFavbQfDbYGkSqRr
         cTH1/ScxYdDX+GLFEc7PFbscGoAu5iO4V331RwBpywhR21vNSLxyRVUfcpAjOG+KsZAb
         0INA==
X-Gm-Message-State: APjAAAWgNgq216pP7+kxe8WKQraxYSRC9NThKL2ZxQNx80Bg3ww2FB3W
        Sm0cQBCIKgi4cS7diZ6jgE0=
X-Google-Smtp-Source: APXvYqy9hEku7DtO7R2fng1pcO+jMDYuPsbmHXCFtysD+UEtqWGH5X00McUguZ4NxTd5J96jR6xUcA==
X-Received: by 2002:a50:9008:: with SMTP id b8mr10293100eda.199.1551582292184;
        Sat, 02 Mar 2019 19:04:52 -0800 (PST)
Received: from archlinux-ryzen ([2a01:4f9:2a:1fae::2])
        by smtp.gmail.com with ESMTPSA id j54sm861755eda.38.2019.03.02.19.04.50
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 02 Mar 2019 19:04:51 -0800 (PST)
Date:   Sat, 2 Mar 2019 20:04:49 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Louis Taylor <louis@kragniz.eu>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, fanc.fnst@cn.fujitsu.com, bhe@redhat.com,
        kirill.shutemov@linux.intel.com, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com, ndesaulniers@google.com,
        jflat@chromium.org
Subject: Re: [PATCH] x86/KASLR: always return a value from process_mem_region
Message-ID: <20190303030449.GA21326@archlinux-ryzen>
References: <20190302184929.28971-1-louis@kragniz.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190302184929.28971-1-louis@kragniz.eu>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 02, 2019 at 06:49:29PM +0000, Louis Taylor wrote:
> When compiling with -Wreturn-type, clang warns:
> 
> arch/x86/boot/compressed/kaslr.c:704:1: warning: control may reach end of
>       non-void function [-Wreturn-type]
> 
> This function's return statement should probably have been placed
> outside the #endif, so move it there
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/360
> Signed-off-by: Louis Taylor <louis@kragniz.eu>

Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>

Thanks for the patch!

> ---
>  arch/x86/boot/compressed/kaslr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
> index fa0332dda9f2..2e53c056ba20 100644
> --- a/arch/x86/boot/compressed/kaslr.c
> +++ b/arch/x86/boot/compressed/kaslr.c
> @@ -697,8 +697,8 @@ static bool process_mem_region(struct mem_vector *region,
>  			return 1;
>  		}
>  	}
> -	return 0;
>  #endif
> +	return 0;
>  }
>  
>  #ifdef CONFIG_EFI
> -- 
> 2.20.1
