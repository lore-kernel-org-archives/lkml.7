Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D54B6C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 22:14:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A0692082E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 22:14:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Qo+s7jN1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbfDJWOn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 18:14:43 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40724 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbfDJWOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 18:14:42 -0400
Received: by mail-pg1-f193.google.com with SMTP id d31so2364485pgl.7
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 15:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uJDWQsEPXS4yDep7NTP0l/HJ1ALL+TiNXczz1789qPs=;
        b=Qo+s7jN1bYH9SLxUdHShxvySnyBKCJTooYUXGPVF8JTL+OfHljseT2ZorY4/ebyUin
         xGqp4YemRIAP2HKolm8onqlSzyUZBuKKb3+ITwQMxkh8+no6D5kviUNynSLIMr3WM2dC
         m2eEYm2cSbtutlyZOXTms0onJbEtv3fdCNJ3hciAz70RxDZS/uwZOA8cg8HW7q4yM0ZO
         Q68x2b3dtz7CGfxu6VYp/ubA5VZJ5C7Zh53SvALy5DtAaczfarbBG3QVjzJoZnhVvjxD
         xKMkRs9U2BKEFBVYdf61RNxh8wvY2OhYDCjWcPFURXn1Z8VlNezS36A1oh7QzB1qnoca
         diMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uJDWQsEPXS4yDep7NTP0l/HJ1ALL+TiNXczz1789qPs=;
        b=SDUL1v4+1QBmRcmk3AN9IankipGPK+TPj/8uHTr3XhQBwCFAbkLwtrt33R5Eqh4oPN
         k1L1WcmRycx9C7NhgdE9elWSrieelVW8E5EHWCzE6cGNWpVt9blyZikCS5Ut4wKprREI
         amOXJEas/XJVq+j9bGAJ99s5bKzreYZfE7WoVoxh2JCyYQoO8Lne5WLq42Jwfv/JdkH7
         /HDFvxYUPjTlVVHtsIlhQOZ/XbXdKaJm8Xh4B4ZEjzNfoO/aJY0Oz6FJjbxU2eG8eKr4
         IzdaO+JXH/nuAC8OTpzI2FSxzEJTn8fmcdpADTUIDfRnKazqTzmsgIhs4ckoyO7WQt4L
         De6g==
X-Gm-Message-State: APjAAAUkr3fXwdXllmJueuY+AB9EX+P2y/+rvYToGxI/2dYJVVV/LKsr
        429fCitjIPxWXhVy55SItLsFvDp3V1eWjfEDqko6QQ==
X-Google-Smtp-Source: APXvYqw53pzHP7Cn2ObTNhVABSD1Cw4tzrvdvhyxx78QZVs8GbA0iIQMLi00mhN3x1/eQa/lxRA4MqU5MD/rBICTVBw=
X-Received: by 2002:a62:14d7:: with SMTP id 206mr45075168pfu.162.1554934481373;
 Wed, 10 Apr 2019 15:14:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190410201300.3528984-1-arnd@arndb.de> <20190410201300.3528984-2-arnd@arndb.de>
In-Reply-To: <20190410201300.3528984-2-arnd@arndb.de>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 10 Apr 2019 15:14:30 -0700
Message-ID: <CAKwvOdk-tfsZRVaOr8Suv5C146F-w3jUA-Rx0n2OxkVy+L8tCg@mail.gmail.com>
Subject: Re: [PATCH 2/2] s390: boot, purgatory: pass $(CLANG_FLAGS) where needed
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Philipp Rudo <prudo@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2019 at 1:13 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> The purgatory and boot Makefiles do not inherit the original cflags,
> so clang falls back to the default target architecture when building it,
> typically this would be x86 when cross-compiling.
>
> Add $(CLANG_FLAGS) everywhere so we pass the correct --target=s390x-linux
> option when cross-compiling.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/s390/Makefile           | 5 +++--
>  arch/s390/purgatory/Makefile | 1 +
>  2 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/arch/s390/Makefile b/arch/s390/Makefile
> index 9c079a506325..443990791099 100644
> --- a/arch/s390/Makefile
> +++ b/arch/s390/Makefile
> @@ -17,12 +17,13 @@ KBUILD_CFLAGS_MODULE += -fPIC
>  KBUILD_AFLAGS  += -m64
>  KBUILD_CFLAGS  += -m64
>  aflags_dwarf   := -Wa,-gdwarf-2
> -KBUILD_AFLAGS_DECOMPRESSOR := -m64 -D__ASSEMBLY__
> +KBUILD_AFLAGS_DECOMPRESSOR := $(CLANG_FLAGS) -m64 -D__ASSEMBLY__
>  KBUILD_AFLAGS_DECOMPRESSOR += $(if $(CONFIG_DEBUG_INFO),$(aflags_dwarf))
> -KBUILD_CFLAGS_DECOMPRESSOR := -m64 -O2
> +KBUILD_CFLAGS_DECOMPRESSOR := $(CLANG_FLAGS) -m64 -O2
>  KBUILD_CFLAGS_DECOMPRESSOR += -DDISABLE_BRANCH_PROFILING -D__NO_FORTIFY
>  KBUILD_CFLAGS_DECOMPRESSOR += -fno-delete-null-pointer-checks -msoft-float
>  KBUILD_CFLAGS_DECOMPRESSOR += -fno-asynchronous-unwind-tables

Thanks for the respin with Nathan's suggestion.

> +KBUILD_CFLAGS_DECOMPRESSOR += $(call cc-disable-warning,pointer-sign)

What's up with this ^ ?  Seems like the top level sets it (without
cc-disable-warning :( ), but then KBUILD_CFLAGS_DECOMPRESSOR discards
it.  Does Clang actually flag code in this arch (that GCC doesn't)?

>  KBUILD_CFLAGS_DECOMPRESSOR += $(call cc-option,-ffreestanding)
>  KBUILD_CFLAGS_DECOMPRESSOR += $(if $(CONFIG_DEBUG_INFO),-g)
>  KBUILD_CFLAGS_DECOMPRESSOR += $(if $(CONFIG_DEBUG_INFO_DWARF4), $(call cc-option, -gdwarf-4,))
> diff --git a/arch/s390/purgatory/Makefile b/arch/s390/purgatory/Makefile
> index ce6a3f75065b..ecd0b3847fef 100644
> --- a/arch/s390/purgatory/Makefile
> +++ b/arch/s390/purgatory/Makefile
> @@ -22,6 +22,7 @@ KBUILD_CFLAGS := -fno-strict-aliasing -Wall -Wstrict-prototypes
>  KBUILD_CFLAGS += -Wno-pointer-sign -Wno-sign-compare
>  KBUILD_CFLAGS += -fno-zero-initialized-in-bss -fno-builtin -ffreestanding
>  KBUILD_CFLAGS += -c -MD -Os -m64 -msoft-float -fno-common
> +KBUILD_CFLAGS += $(CLANG_FLAGS)
>  KBUILD_CFLAGS += $(call cc-option,-fno-PIE)
>  KBUILD_AFLAGS := $(filter-out -DCC_USING_EXPOLINE,$(KBUILD_AFLAGS))
>
> --
> 2.20.0
>


-- 
Thanks,
~Nick Desaulniers
