Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC97AC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 10:35:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5CF62148E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 10:35:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qiGkyiUa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbfDCKfs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 06:35:48 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45468 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726640AbfDCKfs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 06:35:48 -0400
Received: by mail-pl1-f196.google.com with SMTP id bf11so7811813plb.12
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 03:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7kyVaeZ09oiwf3o0HdCgg0CF7GVakTI0C5s61URlI1Q=;
        b=qiGkyiUa06UqWyQysVW2dLfLQso1KqChJP2k6YbeIoleIz16WN4M6AVbRyUWR/9GTm
         fQBbP3ldBCEA+8jsWQ2pBVJYwPpOSTReo7FI8ziwr/ksNGeVKxle0KpB12djSx9MPRpV
         w3XSk49iJiq+mvWEQgwqw2G3p9pM5XlmDENweWS1rxv9CQwE3GHQGJsUcK2HYJF4mr0f
         9UpOeqyha7LmJsu5lcUrgxuPfrAlVP93Q9/0px6AfD4jQaVQNQs9IWNj3t1XrwOFUiEI
         9xiuL36mCpwRf6K8AHS5bVmLqFSXrF79wmZjf9OojBmZQwe/3WIUqhAOqI6WwLL8MHa0
         vMsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7kyVaeZ09oiwf3o0HdCgg0CF7GVakTI0C5s61URlI1Q=;
        b=bDcaO5GMQ0wNGlRhhJVgNM35QVX9EO2Ym86xljBpj54TW40272+ma2LBn57nhO5/LQ
         cBkOxO9PW7ECaLkTvOmLipAJqKqBOrgfK/xO1ro2xeEisDnm1/ZstdFINZ2w6PKcLjCO
         qstu66QL6aOMNgLha9HAgV0boZEw/j8zI7jZNA5yCwyA7bX4l+VuESijaLlzpFP3x967
         BJqHOd3qoElwn9/D7yhBzZVOOt7lzbVi4LpcUYBXykUQtUJlwFcZcUJJjqp3h31HlOdk
         ZaHLIkiWuLJW+lTW4Agfwij6sWspPPZUzBx6HkUssI9mNEc3ogr5y5n8uvPc+ZUxyNMi
         ssZQ==
X-Gm-Message-State: APjAAAW3KRdPwciWKR8CdXLdfJaVQ99qu4PZvUrQ/5q7wEfk1J9YUuHB
        FJiZ9+WbxP7qhMTplKBJ2ki9+UCJV2Ixh6g+Ral7CA==
X-Google-Smtp-Source: APXvYqxhFeCxvd329a9vJ0SCzhG7YUI/NzHgPU1SMYR5ohrx03NmyA0nIVskcIZQQWZkRGLxOpF9zuJyQb1DCtmhV4s=
X-Received: by 2002:a17:902:31a4:: with SMTP id x33mr39557568plb.24.1554287746868;
 Wed, 03 Apr 2019 03:35:46 -0700 (PDT)
MIME-Version: 1.0
References: <1554280344-10741-1-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1554280344-10741-1-git-send-email-yamada.masahiro@socionext.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 3 Apr 2019 17:35:35 +0700
Message-ID: <CAKwvOdkrMB-pvjhuFXPCb-v-6nRkRcm+y5iApNcJHiTd=bdeaw@mail.gmail.com>
Subject: Re: [PATCH] sparc: vdso: add FORCE to the build rule of %.so
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

$ grep -r 'call if_changed,' -B

shows a few more FWIW:

drivers/scsi/Makefile
drivers/gpu/drm/radeon/Makefile
arch/c6x/boot/Makefile
arch/arm64/kernel/vdso/Makefile
arch/x86/entry/vdso/Makefile
arch/x86/entry/syscalls/Makefile
arch/powerpc/platforms/cell/spufs/Makefile
arch/powerpc/kernel/syscalls/Makefile
arch/alpha/kernel/syscalls/Makefile
arch/sparc/boot/Makefile
arch/sparc/kernel/syscalls/Makefile
arch/mips/kernel/syscalls/Makefile
arch/h8300/boot/Makefile
arch/nios2/boot/Makefile
arch/ia64/kernel/syscalls/Makefile
arch/microblaze/boot/dts/Makefile
arch/microblaze/kernel/syscalls/Makefile
arch/csky/boot/Makefile
arch/xtensa/kernel/syscalls/Makefile
arch/sh/boot/Makefile
arch/sh/kernel/syscalls/Makefile
arch/parisc/boot/compressed/Makefile
arch/parisc/kernel/syscalls/Makefile
arch/m68k/kernel/syscalls/Makefile


On Wed, Apr 3, 2019 at 3:32 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> $(call if_changed,...) must have FORCE as a prerequisite.

According to Documentation/kbuild/makefiles.txt#L1064:
```
Note: It is a typical mistake to forget the FORCE prerequisite.
```

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
>
>  arch/sparc/vdso/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/sparc/vdso/Makefile b/arch/sparc/vdso/Makefile
> index 74e97f7..83c4b46 100644
> --- a/arch/sparc/vdso/Makefile
> +++ b/arch/sparc/vdso/Makefile
> @@ -68,7 +68,7 @@ CFLAGS_REMOVE_vdso-note.o = -pg
>  CFLAGS_REMOVE_vclock_gettime.o = -pg
>
>  $(obj)/%.so: OBJCOPYFLAGS := -S
> -$(obj)/%.so: $(obj)/%.so.dbg
> +$(obj)/%.so: $(obj)/%.so.dbg FORCE
>         $(call if_changed,objcopy)
>
>  CPPFLAGS_vdso32.lds = $(CPPFLAGS_vdso.lds)
> --
> 2.7.4
>


-- 
Thanks,
~Nick Desaulniers
