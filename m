Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF251C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 17:43:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF35D2084C
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 17:43:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PBx4G+Mx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726572AbfDIRnb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 13:43:31 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:38618 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbfDIRna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 13:43:30 -0400
Received: by mail-it1-f196.google.com with SMTP id f22so6365658ita.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2019 10:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XmDVdiKFQMgmOSzJpVqrAD9brTBEs/9kUPJaqAGOqQA=;
        b=PBx4G+MxD3HIInOsM4cCOyXIVWi+68pABdFm69DT3WNEkVAghz854oh/wD4BKFf0IW
         Mpm1/p5gusrAz5KWDPMo55SWKR3JLTIzpZMo+MQ9YHQp69r5zFQ9gt6ao2BOI86IGAzR
         eTJ5vUfKOEFy/14lLd4NH3jUkiUSloTr2VAgDYMcUVMKQ0v+F3QhEQKAqeD0A5tlv/jh
         ENAcEs3nEQ5al163P95TUrZnbNK5adnHukD0mi9wTnG+vo1fYwXORMKFBtNCwNQpjDIL
         PIpkV/ps/EbwwftvDM62ANu020T6xRrpeteErWCce8nXItYoClhYq37o21cWiXhtaNXt
         BChg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XmDVdiKFQMgmOSzJpVqrAD9brTBEs/9kUPJaqAGOqQA=;
        b=QEw55XdkhBYp/nF6KMksJ6ZF9DTaonLW7alr374sQ4j3Qj22zYzyQvUGoHEC2x3Yn0
         ejDJRrU6GRW+PqxRwrmjSV7QDiktiWQsT8uDoGNGd6bb+FMqu5a+lqaJg+jSQ+HRwT8I
         5c142I4waaNUU03EP7TJK6i3tsPRAmHFaxUa7nmD7y9ejZ6iQZaR6CxsPhHb+almwdEK
         jXBiJJ3vDwHgpyrB8AAjoNZGls1MijZ00O0oPWeYejInLg7CIKjat9AlyE22ziaXZI4n
         gvWq19XOnsJw4HzuE6sIq3r0aEuTd4y8a0mcvQPlyJngs7x7kqOYib7oyFbRYvyqGC3q
         KDrQ==
X-Gm-Message-State: APjAAAXX4UNPRH82GDcFOfv1mpejWTI71cswOVe357IqG1L7NgVqFth2
        9L7gHR8MHf7EkUjm9Z1Dw7QrlnHjSdEwL9qDuNmMsQ==
X-Google-Smtp-Source: APXvYqzoKbb4JnE7tTDIPFJmEdNb7IHI72Sgq5wV8sLblh7/ulZaJRgix/Q+mt65nWJPvp5IthxJLFmalx5zPraRlII=
X-Received: by 2002:a02:9042:: with SMTP id y2mr26954930jaf.113.1554831809419;
 Tue, 09 Apr 2019 10:43:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190409135243.12424-1-raphael.gault@arm.com>
In-Reply-To: <20190409135243.12424-1-raphael.gault@arm.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Tue, 9 Apr 2019 10:43:18 -0700
Message-ID: <CAKv+Gu_qGN8SG7ajkF7zAoAJd=qskC1oonmjzsqzZyGb9rYGLA@mail.gmail.com>
Subject: Re: [PATCH 0/6] objtool: Add support for Arm64
To:     Raphael Gault <raphael.gault@arm.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Julien Thierry <julien.thierry@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Apr 2019 at 06:53, Raphael Gault <raphael.gault@arm.com> wrote:
>
> Hi,
>
> As of now, objtool only supports the x86_64 architecture but the
> groundwork has already been done in order to add support for other
> architecture without too much effort.
>
> This series of patches adds support for the arm64 architecture
> based on the Armv8.5 Architecture Reference Manual.
>

I think it makes sense to clarify *why* we want this on arm64. Also,
we should identify things that objtool does today that maybe we don't
want on arm64, rather than buy into all of it by default.

> * Patch 1 adapts the existing code to be able to add support for other
>   architecture.
> * Patch 2 provide implementation of the required function for the arm64
>   architecture.
> * Patch 3 adapts the checking of the stack state for the arm64
>   architecture.
> * Patch 4 & 5 fix some warning objtool raised in some particular
>   functions of ~/arch/arm64/kernel/sleep.S. Patch 4 add a macro to
>   signal that some function should be ignored by objtool.
> * Patch 6 enables stack validation for arm64.
>
> Theses patches should provide support for the main cases and behaviour.
> However a few corner cases are not yet handled by objtool:
>
> * In the `~/arch/arm64/crypto/` directory, I noticed that some plain
>   data are sometimes stored in the `.text` section causing objtool to mistake
>   this for instructions and trying (and failing) to interprete them.  If someone
>   could explain to me why we store data directly in the .text section I would
>   appreciate it.
>

Just for convenience, basically. Not specifying a section at all when
emitting a literal amounts to putting it into .text, and a a bonus, it
is guaranteed to be in range for a ADR instructions (which is not the
case when the code is built into the kernel rather than enabled as a
module)

Due to Spectre I have already updated some of the code so larger
tables are moved into .rodata (since literal data might contain binary
sequences that are usable as spectre gadgets), but some work remains
to be done.

> * In the support for arm32 architecture such as in `~/arch/arm64/kernel/kuser32.S`
>   some A32 instructions are used but such instructions are not understood by
>   objtool causing a warning.
>
> I also have a few unclear points I would like to bring to your
> attention:
>
> * For x86_64, when looking for a symbol relocation with explicit
>   addend, objtool systematically adds a +4 offset to the addend.
>   I don't understand why even if I have a feeling it is related
>   to the type of relacation.
>
> * I currently don't have a clear understanding about how switch-tables
>   are generated on arm64 and how to retrieve them (based on relocations).
>
> Please provide me with any feedback and comments as well on the content
> than the style of these patches.
>
> Thanks,
>
> Raphael
>
> ->
>
> Raphael Gault (6):
>   objtool: Refactor code to make it more suitable for multiple
>     architecture support
>   objtool: arm64: Add required implementation for supporting the aarch64
>     architecture in objtool.
>   objtool: arm64: Adapt the stack frame checks and the section analysis
>     for the arm architecture
>   arm64: assembler: Add macro to annotate asm function having non
>     standard stack-frame.
>   arm64: sleep: Add stack frame setup for __cpu_supsend_enter
>   objtool: arm64: Enable stack validation for arm64
>
>  arch/arm64/Kconfig                            |    1 +
>  arch/arm64/include/asm/assembler.h            |   18 +
>  arch/arm64/kernel/sleep.S                     |    4 +
>  tools/objtool/Build                           |    1 -
>  tools/objtool/arch.h                          |   11 +
>  tools/objtool/arch/arm64/Build                |    6 +
>  tools/objtool/arch/arm64/bit_operations.c     |   65 +
>  tools/objtool/arch/arm64/decode.c             | 2870 +++++++++++++++++
>  .../objtool/arch/arm64/include/arch_special.h |   44 +
>  .../arch/arm64/include/asm/orc_types.h        |  109 +
>  .../arch/arm64/include/bit_operations.h       |   22 +
>  tools/objtool/arch/arm64/include/cfi.h        |   76 +
>  .../objtool/arch/arm64/include/insn_decode.h  |  219 ++
>  tools/objtool/arch/arm64/orc_gen.c            |   40 +
>  tools/objtool/arch/x86/Build                  |    1 +
>  tools/objtool/arch/x86/decode.c               |  111 +
>  tools/objtool/arch/x86/include/arch_special.h |   35 +
>  tools/objtool/{ => arch/x86/include}/cfi.h    |    0
>  tools/objtool/{ => arch/x86}/orc_gen.c        |   10 +-
>  tools/objtool/check.c                         |  209 +-
>  tools/objtool/check.h                         |    1 +
>  tools/objtool/elf.c                           |    3 +-
>  tools/objtool/orc.h                           |    4 +-
>  tools/objtool/special.c                       |   18 +-
>  24 files changed, 3740 insertions(+), 138 deletions(-)
>  create mode 100644 tools/objtool/arch/arm64/Build
>  create mode 100644 tools/objtool/arch/arm64/bit_operations.c
>  create mode 100644 tools/objtool/arch/arm64/decode.c
>  create mode 100644 tools/objtool/arch/arm64/include/arch_special.h
>  create mode 100644 tools/objtool/arch/arm64/include/asm/orc_types.h
>  create mode 100644 tools/objtool/arch/arm64/include/bit_operations.h
>  create mode 100644 tools/objtool/arch/arm64/include/cfi.h
>  create mode 100644 tools/objtool/arch/arm64/include/insn_decode.h
>  create mode 100644 tools/objtool/arch/arm64/orc_gen.c
>  create mode 100644 tools/objtool/arch/x86/include/arch_special.h
>  rename tools/objtool/{ => arch/x86/include}/cfi.h (100%)
>  rename tools/objtool/{ => arch/x86}/orc_gen.c (96%)
>
> --
> 2.17.1
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
