Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13F29C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 17:21:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7B4F20658
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 17:20:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lwi+PHw2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726822AbfKURU6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 12:20:58 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45369 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726279AbfKURU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 12:20:58 -0500
Received: by mail-pg1-f196.google.com with SMTP id k1so1904284pgg.12
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 09:20:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=B9Cd6lsebgbNm4s313iOukfjAkgVHP26MAXbnw9I+ys=;
        b=lwi+PHw2zxipBVCVjR3p0f6wVaizQv25tJnVjtPp9YRV2Yxli9DfKpaiSyNmEHpftc
         n7IvneVZSZroQY+XDIkuwKzSa7l1m9VThgY6uvAHhnsZmCyZNlymdXYRzMvPfiCVr3ft
         PQrtb2P/6tSvAmXY7k3qs8rJk1MPVAYmDAbR0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=B9Cd6lsebgbNm4s313iOukfjAkgVHP26MAXbnw9I+ys=;
        b=F1XsaVfTM6PjOHx5ioC36iyZ5kSFgbyvjPgirKvykI92wcap97SOqqf0xxAGU/e7d3
         l5ozdoBnuHcfzgcbz439Pi+ofSiBA52hPJQYi/ld+lLUVUg5c45UT5Iasiqvj6yRKFJb
         k+F0CMaPV3yHF1ENQ8uXB1GmIlxASadhA/NCGbX+naeZEg0PnWr4SDxIkZv8dXX1tg0f
         rsCpr3zinr2MW8S2vcgrxEI3D7MawyhGEK8EKZZ9X5pl9qDfbS3SxYgVOqWA7VqYQCUz
         H6WUllZapf80H3sTQdg5+cnr+q+Z0fZNKmefA8oNnRdujVtx/JViTJdkyBJY7sXzomGv
         jDZA==
X-Gm-Message-State: APjAAAX8pmloO8CUVTVedWIdRjPRjIkjkuATAHABxq91X52t1WMGhnsD
        u5lSBq9RXUCO/Pr79u75/DSl1g==
X-Google-Smtp-Source: APXvYqxUnj4jBe9FdBCwMAVd2svSeexIFajOtiISPNj6f4rEy9mB/I3hH3YYSNTLO+U5cyWiJBT8ww==
X-Received: by 2002:a63:df09:: with SMTP id u9mr10657407pgg.20.1574356857223;
        Thu, 21 Nov 2019 09:20:57 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id v3sm4017698pfn.129.2019.11.21.09.20.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2019 09:20:56 -0800 (PST)
Date:   Thu, 21 Nov 2019 09:20:55 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc:     Elena Petrova <lenaptr@google.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        kernel-hardening@lists.openwall.com
Subject: Re: [PATCH 1/3] ubsan: Add trap instrumentation option
Message-ID: <201911210917.F672B39C32@keescook>
References: <20191120010636.27368-1-keescook@chromium.org>
 <20191120010636.27368-2-keescook@chromium.org>
 <35fa415f-1dab-b93d-f565-f0754b886d1b@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35fa415f-1dab-b93d-f565-f0754b886d1b@virtuozzo.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 21, 2019 at 03:52:52PM +0300, Andrey Ryabinin wrote:
> On 11/20/19 4:06 AM, Kees Cook wrote:
> 
> 
> > +config UBSAN_TRAP
> > +	bool "On Sanitizer warnings, stop the offending kernel thread"
> 
> That description seems inaccurate and confusing. It's not about kernel threads.
> UBSAN may trigger in any context - kernel thread/user process/interrupts... 
> Probably most of the kernel code runs in the context of user process, so "stop the offending kernel thread"
> doesn't sound right.
> 
> 
> 
> > +	depends on UBSAN
> > +	depends on $(cc-option, -fsanitize-undefined-trap-on-error)
> > +	help
> > +	  Building kernels with Sanitizer features enabled tends to grow
> > +	  the kernel size by over 5%, due to adding all the debugging
> > +	  text on failure paths. To avoid this, Sanitizer instrumentation
> > +	  can just issue a trap. This reduces the kernel size overhead but
> > +	  turns all warnings into full thread-killing exceptions.
> 
> I think we should mention that enabling this option also has a potential to 
> turn some otherwise harmless bugs into more severe problems like lockups, kernel panic etc..
> So the people who enable this would better understand what they signing up for.

Good point about other contexts. I will attempt to clarify and send a
v2.

BTW, which tree should ubsan changes go through? The files are actually
not mentioned by anything in MAINTAINERS. Should the KASAN entry gain
paths to cover ubsan too? Something like:

diff --git a/MAINTAINERS b/MAINTAINERS
index 9dffd64d5e99..585434c013c4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8824,7 +8824,7 @@ S:	Maintained
 F:	Documentation/hwmon/k8temp.rst
 F:	drivers/hwmon/k8temp.c
 
-KASAN
+KERNEL SANITIZERS (KASAN, UBSAN)
 M:	Andrey Ryabinin <aryabinin@virtuozzo.com>
 R:	Alexander Potapenko <glider@google.com>
 R:	Dmitry Vyukov <dvyukov@google.com>
@@ -8834,9 +8834,13 @@ F:	arch/*/include/asm/kasan.h
 F:	arch/*/mm/kasan_init*
 F:	Documentation/dev-tools/kasan.rst
 F:	include/linux/kasan*.h
+F:	lib/Kconfig.ubsan
 F:	lib/test_kasan.c
+F:	lib/test_ubsan.c
+F:	lib/ubsan.c
 F:	mm/kasan/
 F:	scripts/Makefile.kasan
+F:	scripts/Makefile.ubsan
 
 KCONFIG
 M:	Masahiro Yamada <yamada.masahiro@socionext.com>

-- 
Kees Cook
