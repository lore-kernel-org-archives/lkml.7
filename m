Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3EC3C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 16:20:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B18DA2189D
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 16:20:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SyLK87fO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727626AbfH2QUm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 12:20:42 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39538 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727161AbfH2QUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 12:20:42 -0400
Received: by mail-pl1-f194.google.com with SMTP id az1so828325plb.6
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 09:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=E3LStifNgUuLd+VD32Zb5UxmVS77q41aK/xZU55AQsc=;
        b=SyLK87fO1ebVPt2hXv3GQL+Xzd5c8H5Pg5xXjlLWi4ihwftGmSSWTVJSAkg6v4qXPo
         xJeHsl+/+0ZSUriKAqzMWRg1OsqL2byhA4XaXvZXIctLo4OnTJxHgSZ8gx1YYz8TPihb
         Wfb5qrh5jsbzisBe0vir695rN/aRXHCq0k4UI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=E3LStifNgUuLd+VD32Zb5UxmVS77q41aK/xZU55AQsc=;
        b=jf0LColG7X/s0lFuIbz9hZorR5/YffLH3c9wX17KjyhWWuHkeTVE7hQjXD4X1GeKP7
         3Qx5iiXgA3wUH7Rjx51NxLKLx//xCMgnzzfq2buz6DJUWGG+k511wX9Bn+3eZOhZvF4B
         G0nL1vy5HW2pPLo09+p8axYo93UdXDvMejP6nxzD6HGznxFlrpdw0b4BcBJ5PjQNwzFB
         XXmNC7uw4d3U+OkmGph2ZsAWFyzeKrJXGYgO8lK2V0ftCOyMbqrH3Zb2ZNC71/4tP/zi
         Ye3SrihlbJ/8OlikBPGjRBrtPQWRLj8Mu8mpi+siQ90EKFxNyEB8sHlwnN/LxQsIcT5T
         ar6g==
X-Gm-Message-State: APjAAAXGr3GqQ9aq4831ldVMP1KT6JeBJ7YGnF3faL4DUWqZ7HzL4ytS
        euvkMOUTL4T3WGkYLMAffQIXSw==
X-Google-Smtp-Source: APXvYqwleG6EymW65DUzWthhf5rXPA5DDgri7wDXOjOC5MovzTOlHopdNSCr5aARJSPQDlerA0ahAQ==
X-Received: by 2002:a17:902:6687:: with SMTP id e7mr10999063plk.211.1567095641909;
        Thu, 29 Aug 2019 09:20:41 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id l31sm3066505pgm.63.2019.08.29.09.20.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Aug 2019 09:20:40 -0700 (PDT)
Date:   Thu, 29 Aug 2019 09:20:38 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>, Stefan Agner <stefan@agner.ch>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH] ARM: Emit __gnu_mcount_nc when using Clang 10.0.0 or
 newer
Message-ID: <20190829162038.GC70797@google.com>
References: <20190829062635.45609-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190829062635.45609-1-natechancellor@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 28, 2019 at 11:26:35PM -0700, Nathan Chancellor wrote:
> Currently, multi_v7_defconfig + CONFIG_FUNCTION_TRACER fails to build
> with clang:
> 
> arm-linux-gnueabi-ld: kernel/softirq.o: in function `_local_bh_enable':
> softirq.c:(.text+0x504): undefined reference to `mcount'
> arm-linux-gnueabi-ld: kernel/softirq.o: in function `__local_bh_enable_ip':
> softirq.c:(.text+0x58c): undefined reference to `mcount'
> arm-linux-gnueabi-ld: kernel/softirq.o: in function `do_softirq':
> softirq.c:(.text+0x6c8): undefined reference to `mcount'
> arm-linux-gnueabi-ld: kernel/softirq.o: in function `irq_enter':
> softirq.c:(.text+0x75c): undefined reference to `mcount'
> arm-linux-gnueabi-ld: kernel/softirq.o: in function `irq_exit':
> softirq.c:(.text+0x840): undefined reference to `mcount'
> arm-linux-gnueabi-ld: kernel/softirq.o:softirq.c:(.text+0xa50): more undefined references to `mcount' follow
> 
> clang can emit a working mcount symbol, __gnu_mcount_nc, when
> '-meabi gnu' is passed to it. Until r369147 in LLVM, this was
> broken and caused the kernel not to boot because the calling
> convention was not correct. Now that it is fixed, add this to
> the command line when clang is 10.0.0 or newer so everything
> works properly.
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/35
> Link: https://bugs.llvm.org/show_bug.cgi?id=33845
> Link: https://github.com/llvm/llvm-project/commit/16fa8b09702378bacfa3d07081afe6b353b99e60
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  arch/arm/Makefile | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm/Makefile b/arch/arm/Makefile
> index c3624ca6c0bc..7b5a26a866fc 100644
> --- a/arch/arm/Makefile
> +++ b/arch/arm/Makefile
> @@ -112,6 +112,12 @@ ifeq ($(CONFIG_ARM_UNWIND),y)
>  CFLAGS_ABI	+=-funwind-tables
>  endif
>  
> +ifeq ($(CONFIG_CC_IS_CLANG),y)
> +ifeq ($(shell test $(CONFIG_CLANG_VERSION) -ge 100000; echo $$?),0)
> +CFLAGS_ABI	+=-meabi gnu
> +endif
> +endif

Is this also correct/needed when CONFIG_AEABI is not set?
