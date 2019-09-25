Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 240C4C432C1
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 10:20:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 321A921D7C
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 10:20:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="dNO2X37U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389442AbfIYKUn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 06:20:43 -0400
Received: from mail.skyhub.de ([5.9.137.197]:51640 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728483AbfIYKUn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 06:20:43 -0400
Received: from zn.tnic (p200300EC2F0BA10005B38B137F30EC85.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:a100:5b3:8b13:7f30:ec85])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 055581EC08B1;
        Wed, 25 Sep 2019 12:20:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1569406841;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=+GlOX/u6f/9D2FLStZCA+6bXQBeQJozAN6rEZmPgIBQ=;
        b=dNO2X37UgNIlxZpREqMfpYzf3753Wuuw3GVfgfx+QitOjCovQzU1Tm6dG5BZHhXkpO2q7F
        8ZMw8EU6r3uf6xJP8S1pHMPQBx4XgrdQJqGbvmZC8h1ImXeei5K8hycSsrGwsByE0I2A1W
        BEQKshlZ6NQYMQV6YQFNwIrdLwyW6to=
Date:   Wed, 25 Sep 2019 12:20:41 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Nick Desaulniers <ndesaulniers@google.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Jarkko Sakkinen <jarkko.sakkinen@intel.com>
Cc:     tglx@linutronix.de, mingo@redhat.com,
        clang-built-linux@googlegroups.com, x86@kernel.org,
        Tri Vo <trong@android.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Rob Herring <robh@kernel.org>,
        George Rimar <grimar@accesssoftek.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] x86, realmode: explicitly set entry via command line
Message-ID: <20190925102041.GB3891@zn.tnic>
References: <CAKwvOdmFqPSyeKn-0th_ca9B3QU63G__kEJ=X0tfjhE+1_p=FQ@mail.gmail.com>
 <20190924193310.132104-1-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190924193310.132104-1-ndesaulniers@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ some more people who did the unified realmode thing.

On Tue, Sep 24, 2019 at 12:33:08PM -0700, Nick Desaulniers wrote:
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

So looking at arch/x86/realmode/rm/realmode.lds.S: what's stopping
people from adding more sections before the first

. = ALIGN(PAGE_SIZE);

which, with enough bytes to go above the first 4K, would cause that
alignment to go to 0x2000 and then your hardcoded address would be
wrong, all of a sudden.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
