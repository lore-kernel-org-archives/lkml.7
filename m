Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D888C432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 19:37:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 620F4214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 19:37:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SktUiaLd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437151AbfIXThm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 15:37:42 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42627 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730848AbfIXThm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 15:37:42 -0400
Received: by mail-pf1-f194.google.com with SMTP id q12so1942375pff.9
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2019 12:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=861g/thnt5QkfvdcsmgCyLRARPkFspYG3nF0aXDzCWA=;
        b=SktUiaLd9F5Jf3iByUjAf+GkoVnW2XX4kdsqmEIhB2IhVb+pTZBPocC80KxizMaerH
         Ri+d71iDRduEmMDXKUC68B09OZAsksiEbIUj4lMd9EXi+N8TJOMH9L0fl5BfTe3Dl1gq
         CYB4HfNt7QJFPOJ8NhX5koF97r3twWDnQeevbEcdoHpIt14PN4ko34550JfqmCrJ5ENN
         3sGlc85bZsBMQaN8vWMXHB758I9xafnIGBasVn1oX8skJzlW7HDGOEpf4elcTbcKtsTo
         j3NL84EmAZc70ZDKvPjIcvI/ase8sZqWUAb0AUZwGlhXYpGrcORIO+plEOfVYeANVnwI
         6+QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=861g/thnt5QkfvdcsmgCyLRARPkFspYG3nF0aXDzCWA=;
        b=miv7CVgjSEZfiR6s/9Vsmrgs4lcWD7vUigj82OR3kbuMeIAAXfE9b1yLtcgs8ccnCb
         r/Yqfg67iQ8J2fNJ8V674366Xaqz8EeNnU9lghUJdW/dJm/Y5ZL3ulS8K0w4JqVoR7nz
         c71IeeNW5wiGfOcoaM/0nntwKcHCVGtE9dzXIYMOY384e064KytZ3+r7U7G8dOvx0Afx
         smoTwv14mRdnat4XtAYH6bSES0Z/GSdMUM9bGffWMW/fJOiPxQTnSxgFsMkFT3ScRWXK
         xU7CcYe0HRWW+Yjb35aR2xsXtkkKXrucfC88Kq3BXt+dqRggxhs1SCmub/AvrGtjxYrL
         vf/w==
X-Gm-Message-State: APjAAAUU/iDtnA/QM8DZcCn0r0mtkrx20M8Lg08LoSdBTUDG/Zmz1ntW
        iTkFnIhuq4iQIrxJP1YlCprBShWUrMmGPTCRsi5gtw==
X-Google-Smtp-Source: APXvYqx2VLE/eblOPChlvUvwmwZbJMDq48hIcoLWVKYN/QofXMt9O6X4xo8a/Ckegi4UzAmVo8TycOrKxZ47bAGOHzg=
X-Received: by 2002:a17:90a:ff18:: with SMTP id ce24mr1747977pjb.123.1569353861100;
 Tue, 24 Sep 2019 12:37:41 -0700 (PDT)
MIME-Version: 1.0
References: <CAKwvOdmFqPSyeKn-0th_ca9B3QU63G__kEJ=X0tfjhE+1_p=FQ@mail.gmail.com>
 <20190924193310.132104-1-ndesaulniers@google.com>
In-Reply-To: <20190924193310.132104-1-ndesaulniers@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 24 Sep 2019 12:37:30 -0700
Message-ID: <CAKwvOdnesgP8uVv3x9Ywqy0U24d_V9G-ovD5y__xJKB+t==6hg@mail.gmail.com>
Subject: Re: [PATCH v2] x86, realmode: explicitly set entry via command line
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
Cc:     clang-built-linux <clang-built-linux@googlegroups.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Tri Vo <trong@android.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Rob Herring <robh@kernel.org>,
        George Rimar <grimar@accesssoftek.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Sedat Dilek <sedat.dilek@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 24, 2019 at 12:33 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> Linking with ld.lld via $ make LD=ld.lld produces the warning:
> ld.lld: warning: cannot find entry symbol _start; defaulting to 0x1000
>
> Linking with ld.bfd shows the default entry is 0x1000:
> $ readelf -h arch/x86/realmode/rm/realmode.elf | grep Entry
>   Entry point address:               0x1000
>
> While ld.lld is being pedantic, just set the entry point explicitly,
> instead of depending on the implicit default.
>
> Link: https://github.com/ClangBuiltLinux/linux/issues/216
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>

I meant to pick up Sedat's reported by tag:
Reported-by: Sedat Dilek <sedat.dilek@gmail.com>

> ---
> Changes V1 -> V2:
> * Use command line flag, rather than linker script, as ld.bfd produces a
>   syntax error for `ENTRY(0x1000)` but is happy with `-e 0x1000`
>
>  arch/x86/realmode/rm/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/x86/realmode/rm/Makefile b/arch/x86/realmode/rm/Makefile
> index f60501a384f9..338a00c5257f 100644
> --- a/arch/x86/realmode/rm/Makefile
> +++ b/arch/x86/realmode/rm/Makefile
> @@ -46,7 +46,7 @@ $(obj)/pasyms.h: $(REALMODE_OBJS) FORCE
>  targets += realmode.lds
>  $(obj)/realmode.lds: $(obj)/pasyms.h
>
> -LDFLAGS_realmode.elf := -m elf_i386 --emit-relocs -T
> +LDFLAGS_realmode.elf := -m elf_i386 --emit-relocs -e 0x1000 -T
>  CPPFLAGS_realmode.lds += -P -C -I$(objtree)/$(obj)
>
>  targets += realmode.elf
> --
> 2.23.0.351.gc4317032e6-goog
>


-- 
Thanks,
~Nick Desaulniers
