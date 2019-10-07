Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A9EEECE58C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 19:57:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F48A2084D
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 19:57:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="igfx0QTx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728992AbfJGT54 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 15:57:56 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33861 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728289AbfJGT5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 15:57:55 -0400
Received: by mail-pl1-f193.google.com with SMTP id k7so7385436pll.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 12:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Np1dLtH5+g3q/AtVMCx0wuJ5qYDTOY/aAWm/xM3OOGk=;
        b=igfx0QTx4y7VtszEETGCiZTm0y8asHQ6eEmdFVoL9g7fTrfLKBZRgwM+W2Wi/xCSgM
         cgkiRO0/0Uq6DR4AYrvB3a4grZXb+G3Ae9lAwi3zPBHqxQH9Ny3/FlttwAumHsF1AkDv
         966mLZmZlFON8x2mdvKdWNvciTbw+z01GLPpjdvk0l/nhTppD25EMEKxBaRRkJ32QOe2
         ERpDe5pDlfrc5LWWn5JnaBJg23OmIcm8hhR5hA4iU8QbOzvOKdTyjDm33Qc4aEENcGZO
         ftGSPOULiR3Sg1j+BRW4wxD3TEZQo/WU0mZFVEG6gSTWyN7npB0gD0U0j/dnewmLGNn9
         2qIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Np1dLtH5+g3q/AtVMCx0wuJ5qYDTOY/aAWm/xM3OOGk=;
        b=J+c4Z26MX7F6OfKIOQZMAKeT2TRRItBqeV/KccRf6VW9YVbiwkmG3WPaBlaApWgP1+
         cS7nulI63xI87PhsvBq+AoUzLAiyQsNXGGCLiZYximMrwP7o+bh+F7kkhsEHiwnUjgVy
         g7Z3+2g+0pm693v+Rs5w2nzNa5UCWvkiAjfabCs1O0q40ETrhJqjKM+GJ2jO5qEb49o0
         rHoeC73HNQ3KvJOCWBScTAa+OiP6VMrqvSuG52+Z+/+6e2+j2XfTQYFAecpjlWq06txA
         kcixm250lCFDedFM79e8IhjmFZehygKeG1h/ED9gjry/4XHov+ID62Lj0ULU3kA8QA+u
         s29g==
X-Gm-Message-State: APjAAAXETLNctADMRQ+3XFgXOAcvEomVdbquGuByeWWRqaVq71T0HDan
        UzwMFF3DPIcsGP5tmx3EjbVDufpm59xKPZezUCKpfQ==
X-Google-Smtp-Source: APXvYqwjh9Ggk/TxjNMMJIdTEz1W+GeMmNwhISVOmVSoKHUUfzPo/86Tlx5bba6VaWqXbiPA2cXo3oL9YXmixvNCoW4=
X-Received: by 2002:a17:902:820e:: with SMTP id x14mr30841969pln.223.1570478274285;
 Mon, 07 Oct 2019 12:57:54 -0700 (PDT)
MIME-Version: 1.0
References: <20191007192129.104336-1-samitolvanen@google.com>
In-Reply-To: <20191007192129.104336-1-samitolvanen@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 7 Oct 2019 12:57:42 -0700
Message-ID: <CAKwvOd=hjxJYhU=C4wqkKKnLwuQjjL=wPAh6uBj-M8r8AtDdFA@mail.gmail.com>
Subject: Re: [PATCH] x86/cpu/vmware: use the full form of inl in VMWARE_PORT
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Thomas Hellstrom <thellstrom@vmware.com>, pv-drivers@vmware.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Kees Cook <keescook@chromium.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        virtualization@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 7, 2019 at 12:21 PM 'Sami Tolvanen' via Clang Built Linux
<clang-built-linux@googlegroups.com> wrote:
>
> LLVM's assembler doesn't accept the short form inl (%%dx) instruction,
> but instead insists on the output register to be explicitly specified:
>
>   <inline asm>:1:7: error: invalid operand for instruction
>           inl (%dx)
>              ^
>   LLVM ERROR: Error parsing inline asm
>
> Use the full form of the instruction to fix the build.
>
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

Thanks Sami, this looks like it addresses:
Link: https://github.com/ClangBuiltLinux/linux/issues/734
Looks like GAS' testsuite has some cases where the second operand is
indeed implicitly %eax if unspecified. (This should still be fixed in
Clang).
Just to triple check that they're equivalent:
$ cat inl.s
  inl (%dx)
  inl (%dx), %eax
$ as inl.s
$ objdump -d a.out

a.out:     file format elf64-x86-64


Disassembly of section .text:

0000000000000000 <.text>:
   0: ed                    in     (%dx),%eax
   1: ed                    in     (%dx),%eax

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  arch/x86/kernel/cpu/vmware.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/x86/kernel/cpu/vmware.c b/arch/x86/kernel/cpu/vmware.c
> index 9735139cfdf8..46d732696c1c 100644
> --- a/arch/x86/kernel/cpu/vmware.c
> +++ b/arch/x86/kernel/cpu/vmware.c
> @@ -49,7 +49,7 @@
>  #define VMWARE_CMD_VCPU_RESERVED 31
>
>  #define VMWARE_PORT(cmd, eax, ebx, ecx, edx)                           \
> -       __asm__("inl (%%dx)" :                                          \
> +       __asm__("inl (%%dx), %%eax" :                                   \
>                 "=a"(eax), "=c"(ecx), "=d"(edx), "=b"(ebx) :            \
>                 "a"(VMWARE_HYPERVISOR_MAGIC),                           \
>                 "c"(VMWARE_CMD_##cmd),                                  \

-- 
Thanks,
~Nick Desaulniers
