Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A5F1C76194
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 17:23:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CDDF217D4
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 17:23:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="d0NLpEWz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731276AbfGVRXd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 13:23:33 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43984 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731265AbfGVRXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 13:23:33 -0400
Received: by mail-pl1-f193.google.com with SMTP id 4so12489127pld.10
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 10:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FRwdh8exxsdgMPTPXtFJAWsj5j42oG+j8NccmCU/aPQ=;
        b=d0NLpEWzwogS/ThZgEsKfpSO+In9RUmZ10LT5JWbwXE8k/fDSq3mn6CJAVGcJesmGD
         0+CgGu9bTUp/58xXhIMmpApUrvj1y47jxBRgzy0FkZtchdQEyzb5Z3td+CtiCLq8QkwF
         56rU6rd1Lm5oPnYyjae4uU2YoMvuemCyldn3I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FRwdh8exxsdgMPTPXtFJAWsj5j42oG+j8NccmCU/aPQ=;
        b=YGDmgK3xqBrrcoTHxGQXxwy6G0Rx3asTyEVQ82vQQLFNrUsDsMxtEvXERUdpCXaJNa
         dIrekYtJGw5NyAWTrSYIkSUFMbi5PD7AJ7XLSO/6QOURj1lIfKuB333abfjzgi2sEMfL
         s9v4FugUtuOEbAuSwFyqxRYPnEyCu7IwND+OzU7ieGN2BuLQOXsmKLxv1hFcwPSvnrO3
         WUfGBAeGzlN8PAK73Vsbbpw3Ic7kxTvfiiBnUtgbsuVEDMGbtEWOYbYtFBXkN+Q6cXCQ
         +WifKhBGNZs6LXxIaMRn4m5maqyaW2t7yqdcOgbCp1Ol6HYg9K0do8j/IaIRdRek7n00
         zNYA==
X-Gm-Message-State: APjAAAVl05HL6XhxgyzwwWY3OHqh2UoAaTsC3QXfK0vV0MSANc2SKFyE
        cpTbGdR/7HJadkFZUDAJrIybNQ==
X-Google-Smtp-Source: APXvYqxTPc1ftKX0JS8KLEPEzEkS5PPsPWxZ4rqQ/9/ZTuAOhO42HlIKraszJU3ZUd6mJ/6W8QaAAw==
X-Received: by 2002:a17:902:f082:: with SMTP id go2mr79917259plb.25.1563816212503;
        Mon, 22 Jul 2019 10:23:32 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u69sm46464171pgu.77.2019.07.22.10.23.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Jul 2019 10:23:31 -0700 (PDT)
Date:   Mon, 22 Jul 2019 10:23:30 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Alexander Potapenko <glider@google.com>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [RESEND v2] structleak: disable STRUCTLEAK_BYREF in
 combination with KASAN_STACK
Message-ID: <201907221022.4597DDD92@keescook>
References: <20190722114134.3123901-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190722114134.3123901-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2019 at 01:41:20PM +0200, Arnd Bergmann wrote:
> The combination of KASAN_STACK and GCC_PLUGIN_STRUCTLEAK_BYREF
> leads to much larger kernel stack usage, as seen from the warnings
> about functions that now exceed the 2048 byte limit:
> 
> drivers/media/i2c/tvp5150.c:253:1: error: the frame size of 3936 bytes is larger than 2048 bytes
> drivers/media/tuners/r820t.c:1327:1: error: the frame size of 2816 bytes is larger than 2048 bytes
> drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_n.c:16552:1: error: the frame size of 3144 bytes is larger than 2048 bytes [-Werror=frame-larger-than=]
> fs/ocfs2/aops.c:1892:1: error: the frame size of 2088 bytes is larger than 2048 bytes
> fs/ocfs2/dlm/dlmrecovery.c:737:1: error: the frame size of 2088 bytes is larger than 2048 bytes
> fs/ocfs2/namei.c:1677:1: error: the frame size of 2584 bytes is larger than 2048 bytes
> fs/ocfs2/super.c:1186:1: error: the frame size of 2640 bytes is larger than 2048 bytes
> fs/ocfs2/xattr.c:3678:1: error: the frame size of 2176 bytes is larger than 2048 bytes
> net/bluetooth/l2cap_core.c:7056:1: error: the frame size of 2144 bytes is larger than 2048 bytes [-Werror=frame-larger-than=]
> net/bluetooth/l2cap_core.c: In function 'l2cap_recv_frame':
> net/bridge/br_netlink.c:1505:1: error: the frame size of 2448 bytes is larger than 2048 bytes
> net/ieee802154/nl802154.c:548:1: error: the frame size of 2232 bytes is larger than 2048 bytes
> net/wireless/nl80211.c:1726:1: error: the frame size of 2224 bytes is larger than 2048 bytes
> net/wireless/nl80211.c:2357:1: error: the frame size of 4584 bytes is larger than 2048 bytes
> net/wireless/nl80211.c:5108:1: error: the frame size of 2760 bytes is larger than 2048 bytes
> net/wireless/nl80211.c:6472:1: error: the frame size of 2112 bytes is larger than 2048 bytes
> 
> The structleak plugin was previously disabled for CONFIG_COMPILE_TEST,
> but meant we missed some bugs, so this time we should address them.
> 
> The frame size warnings are distracting, and risking a kernel stack
> overflow is generally not beneficial to performance, so it may be best
> to disallow that particular combination. This can be done by turning
> off either one. I picked the dependency in GCC_PLUGIN_STRUCTLEAK_BYREF
> and GCC_PLUGIN_STRUCTLEAK_BYREF_ALL, as this option is designed to
> make uninitialized stack usage less harmful when enabled on its own,
> but it also prevents KASAN from detecting those cases in which it was
> in fact needed.
> 
> KASAN_STACK is currently implied by KASAN on gcc, but could be made a
> user selectable option if we want to allow combining (non-stack) KASAN
> with GCC_PLUGIN_STRUCTLEAK_BYREF.
> 
> Note that it would be possible to specifically address the files that
> print the warning, but presumably the overall stack usage is still
> significantly higher than in other configurations, so this would not
> address the full problem.
> 
> I could not test this with CONFIG_INIT_STACK_ALL, which may or may not
> suffer from a similar problem.
> 
> Fixes: 81a56f6dcd20 ("gcc-plugins: structleak: Generalize to all variable types")
> Acked-by: Kees Cook <keescook@chromium.org>
> Link: https://lore.kernel.org/lkml/20190628123819.2785504-1-arnd@arndb.de/
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> [v2] do it for both GCC_PLUGIN_STRUCTLEAK_BYREF and GCC_PLUGIN_STRUCTLEAK_BYREF_ALL.
> 
> Andrew, can you pick this up in -mm? It looks like nobody else
> wanted it in their trees even though there was agreement on the
> patch itself.

Andrew, if you don't want it, I can take it via my gcc-plugins tree?

-Kees

> ---
>  security/Kconfig.hardening | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/security/Kconfig.hardening b/security/Kconfig.hardening
> index a1ffe2eb4d5f..af4c979b38ee 100644
> --- a/security/Kconfig.hardening
> +++ b/security/Kconfig.hardening
> @@ -61,6 +61,7 @@ choice
>  	config GCC_PLUGIN_STRUCTLEAK_BYREF
>  		bool "zero-init structs passed by reference (strong)"
>  		depends on GCC_PLUGINS
> +		depends on !(KASAN && KASAN_STACK=1)
>  		select GCC_PLUGIN_STRUCTLEAK
>  		help
>  		  Zero-initialize any structures on the stack that may
> @@ -70,9 +71,15 @@ choice
>  		  exposures, like CVE-2017-1000410:
>  		  https://git.kernel.org/linus/06e7e776ca4d3654
>  
> +		  As a side-effect, this keeps a lot of variables on the
> +		  stack that can otherwise be optimized out, so combining
> +		  this with CONFIG_KASAN_STACK can lead to a stack overflow
> +		  and is disallowed.
> +
>  	config GCC_PLUGIN_STRUCTLEAK_BYREF_ALL
>  		bool "zero-init anything passed by reference (very strong)"
>  		depends on GCC_PLUGINS
> +		depends on !(KASAN && KASAN_STACK=1)
>  		select GCC_PLUGIN_STRUCTLEAK
>  		help
>  		  Zero-initialize any stack variables that may be passed
> -- 
> 2.20.0
> 

-- 
Kees Cook
