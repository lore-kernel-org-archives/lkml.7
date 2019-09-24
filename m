Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DEFFC432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 18:24:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 567C320872
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 18:24:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hDAG+fyg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436652AbfIXSYW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 14:24:22 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37560 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbfIXSYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 14:24:22 -0400
Received: by mail-wr1-f68.google.com with SMTP id i1so3034372wro.4
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2019 11:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MSPNIfVZ4qS2yiCyrNpDMkC8ARL2yEmGuRN2Uobibs4=;
        b=hDAG+fygPFLvisfhSNqz6offVn1OcZxP9BHw8d+ejAE+gqvYL/uiBTUjeiu5Qr1RiP
         LXlFjV1vQtjmeBTRaMT2/4X+3rBRn9PkntmG2CKvx/gkdCiwky85+jf9rrFdow/5oVAU
         ffkT9+fiMxDFDY+xeRImLj9tQ3FxhMpZtezPL7wvuhDTJNM6bG3P82fInL3fFKwADweE
         48iNkcQUY090M+m8/vr6Lf7EkiO8fT5gvjaA6jvb9L4i7z7l7PIYpY4a9qub8tgCgNUD
         GteWtSO7GEyxI6noxB5AlCsP65EdefLorzZmTQ2/W9BrH4PIE63Hy5YlgbbcxfEI9jJ0
         GxSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MSPNIfVZ4qS2yiCyrNpDMkC8ARL2yEmGuRN2Uobibs4=;
        b=aGz49df5i35mcWviW/a5btJYybiZpHww3UUebXGprudJw1Ad1kuU9kvU8XsBLNVGQ4
         6n21S/28iF2TiC462CipWTNkbHuTchtZEVQfgZstJTFYHvIRnJnNcivOLu4J2hDcCZ8E
         0s0p/c0OJzD4KfXcgteSvHTVIVo6yI+Vetm2i1AHv0uHUbyx0flyaDFalFuTdNGn5IRj
         2Dc0Mscor5HMOgmp/2igPM6DRKFNTf6WiygzIIoHYpk6bUN/+SHPbpN3UFDA6j2uPru8
         pS8OZ5oPm7juF2Q9NqmuVBzhRauTBgeUPxcJwdtVJ69+M+egtL3JzM1d7jIcFgoy5zvh
         NrxA==
X-Gm-Message-State: APjAAAUim0UhmRQnT+mKM/tuqE8LmIszZIBs8KKcJgxYSjH20AksXY8g
        fDie2B8G+euZdGh5f9kF5Jo=
X-Google-Smtp-Source: APXvYqxVjr15bD4U54bCTIgfc+3quSvxnuMRMQATx7zR3uuQvbpRSF3W1ecPbFRPJcyjR6Mv4xZmFQ==
X-Received: by 2002:adf:f212:: with SMTP id p18mr3993285wro.340.1569349459716;
        Tue, 24 Sep 2019 11:24:19 -0700 (PDT)
Received: from archlinux-threadripper ([2a01:4f8:222:2f1b::2])
        by smtp.gmail.com with ESMTPSA id b186sm1519974wmd.16.2019.09.24.11.24.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2019 11:24:19 -0700 (PDT)
Date:   Tue, 24 Sep 2019 11:24:17 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        clang-built-linux@googlegroups.com,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86, realmode: explicitly set ENTRY in linker script
Message-ID: <20190924182417.GA2714282@archlinux-threadripper>
References: <20190923222403.22956-1-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190923222403.22956-1-ndesaulniers@google.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 23, 2019 at 03:24:02PM -0700, 'Nick Desaulniers' via Clang Built Linux wrote:
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
>  arch/x86/realmode/rm/realmode.lds.S | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/x86/realmode/rm/realmode.lds.S b/arch/x86/realmode/rm/realmode.lds.S
> index 3bb980800c58..2034f5f79bff 100644
> --- a/arch/x86/realmode/rm/realmode.lds.S
> +++ b/arch/x86/realmode/rm/realmode.lds.S
> @@ -11,6 +11,7 @@
>  
>  OUTPUT_FORMAT("elf32-i386")
>  OUTPUT_ARCH(i386)
> +ENTRY(0x1000)
>  
>  SECTIONS
>  {
> -- 
> 2.23.0.351.gc4317032e6-goog
> 

This appears to break ld.bfd?

ld:arch/x86/realmode/rm/realmode.lds:131: syntax error
make[5]: *** [../arch/x86/realmode/rm/Makefile:54: arch/x86/realmode/rm/realmode.elf] Error 1
make[4]: *** [../arch/x86/realmode/Makefile:20: arch/x86/realmode/rm/realmode.bin] Error 2
make[3]: *** [../scripts/Makefile.build:509: arch/x86/realmode] Error 2

Cheers,
Nathan
