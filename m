Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEFCCC10F0B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 07:45:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D3A22183E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 07:45:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GoLXHT0W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388218AbfDRHpi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 03:45:38 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:39991 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728074AbfDRHph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 03:45:37 -0400
Received: by mail-vs1-f67.google.com with SMTP id f22so663269vso.7
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 00:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IVzHmXRqIoHomywgqAqb9JQdOxfcYsfsLDDKG5NiUPs=;
        b=GoLXHT0Wp02nqf3Yl0uJh8Hs9C93SMrJT26BjOERdLWwC6r1PQvnCSKbaXFVlbBn47
         tT97BpPB+z7apCEEjjit9SbOJ29njjA6wldiv1hA5Tzv+oUKtVQFPceZPE0cmuJdZGH1
         ztV3okKSL2gkLcd8/+4HiHVvJXEbeyWWPELPc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IVzHmXRqIoHomywgqAqb9JQdOxfcYsfsLDDKG5NiUPs=;
        b=iZVTFqlzljrVChwNNf7Tcfp+xD81RZhWtpwEr+W7pkwghHgl+UNkzYUjShqdE8tXsF
         ldjHtSMCLakPpuzH6zTtKuQWyLVuo54nk7RQEz3RgiuBpq6u8YdYdANE2G10lefwPO3f
         pc/zsc3Xe1C4sC1iIRM5WXU7+3WNgNlydiefb6zaScFkqN61UyrDEcxGuyDC535fLdDS
         RjDthIdEGg4AgMmZUx6NbvE9DmZnC4XhYroXDR9PFbJDf9BesKyRSPXIhrfqFCVUgC/W
         5eYSeFu3pgAkzz4wNbhaRrhJ3/9KQAKsU/XHfnI8rULJZcrRquTNE6bl5hmQwXnqW8YC
         HIDw==
X-Gm-Message-State: APjAAAUrHAVHAXDrj6RFRkPcuj2AqIE4MSkPb0RKMcb2x2x3BB4donMN
        hmCSCI8DARPGppL0vKni8O6ro7ZO4dM=
X-Google-Smtp-Source: APXvYqxLa4cew9Z5nO8FQjbwXSldmjTIucshCQZOI6JOfqREW4qio9v2vEtKB7+texO0u8BhRZXMOw==
X-Received: by 2002:a67:844d:: with SMTP id g74mr52079013vsd.40.1555573535092;
        Thu, 18 Apr 2019 00:45:35 -0700 (PDT)
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com. [209.85.221.181])
        by smtp.gmail.com with ESMTPSA id o126sm367467vke.55.2019.04.18.00.45.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Apr 2019 00:45:34 -0700 (PDT)
Received: by mail-vk1-f181.google.com with SMTP id s63so264920vkg.10
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 00:45:33 -0700 (PDT)
X-Received: by 2002:a1f:7245:: with SMTP id n66mr38481298vkc.40.1555573533181;
 Thu, 18 Apr 2019 00:45:33 -0700 (PDT)
MIME-Version: 1.0
References: <1462963502-11636-1-git-send-email-hecmargi@upv.es>
In-Reply-To: <1462963502-11636-1-git-send-email-hecmargi@upv.es>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 18 Apr 2019 02:45:22 -0500
X-Gmail-Original-Message-ID: <CAGXu5jLZ-DgTfokLTqUHOUphO4C1FwHgYDLTA1oB9HBHnH-a1Q@mail.gmail.com>
Message-ID: <CAGXu5jLZ-DgTfokLTqUHOUphO4C1FwHgYDLTA1oB9HBHnH-a1Q@mail.gmail.com>
Subject: Re: [PATCH] x86_64: Disabling read-implies-exec when the stack is executable
To:     Hector Marco-Gisbert <hecmargi@upv.es>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        Brian Gerst <brgerst@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@suse.de>,
        Huaitong Han <huaitong.han@intel.com>,
        Ismael Ripoll Ripoll <iripoll@upv.es>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Andi Kleen <ak@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2016 at 5:45 AM Hector Marco-Gisbert <hecmargi@upv.es> wrote:
>
> The READ_IMPLIES_EXEC personality was removed in 2005 for 64-bit processes,
> (commit a3cc2546a54361b86b73557df5b85c4fc3fc27c3 form history.git).
>
> But it's still possible to have all readable areas with EXEC permissions by
> setting the stack as executable in 64-bit ELF executables (also in 32-bit).
>
> This is because the macro elf_read_implies_exec() does not distinguish
> between 32 and 64-bit executables: when the stack is executable then the
> read-implies-exec personality is set (enabled) to the process.
>
> We think that this is not a desirable behaviour, maybe read-implies-exec
> could be used via personality but not by setting the stack as executable in
> the ELF.
>
> For x86_64 processes, is there any reason to disable read-implies-exec
> personality and at the same time enable it when the stack is executable ?
>
> With this patch it's no longer possible to enable the read-implies-exec on
> the process by setting the stack as executable in the PT_GNU_STACK on
> x86_64 executables.
>
> Regarding 32-bits processes, is there any reason to enable
> read-implies-exec by setting the stack as executable instead of using the
> personality on X86_32 or when emulating IA32 on X86_64 ?
>
> If not, I could re-send the patch which removes this possibility.
>
>
> Signed-off-by: Hector Marco-Gisbert <hecmargi@upv.es>
> Acked-by: Ismael Ripoll Ripoll <iripoll@upv.es>
> ---
>  arch/x86/include/asm/elf.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/include/asm/elf.h b/arch/x86/include/asm/elf.h
> index 15340e3..87fd15e 100644
> --- a/arch/x86/include/asm/elf.h
> +++ b/arch/x86/include/asm/elf.h
> @@ -271,8 +271,8 @@ extern int force_personality32;
>   * An executable for which elf_read_implies_exec() returns TRUE will
>   * have the READ_IMPLIES_EXEC personality flag set automatically.
>   */
> -#define elf_read_implies_exec(ex, executable_stack)    \
> -       (executable_stack != EXSTACK_DISABLE_X)
> +#define elf_read_implies_exec(ex, executable_stack) \
> +       (mmap_is_ia32() ? (executable_stack != EXSTACK_DISABLE_X) : 0)
>
>  struct task_struct;
>
> --
> 1.9.1
>

*thread necromancy*

I'd still like to see this get landed. READ_IMPLIES_EXEC is way too
powerful (it impacts, for example, mmap() regions of device driver
memory, forcing drivers to not be able to disallow VM_EXEC[1]).

The only case it could break is on an AMD K8 (Athlon only, I assume?),
which seems unlikely to have a modern kernel run on it. If there is
still concern, then we could just test against the NX CPU feature:

diff --git a/arch/x86/include/asm/elf.h b/arch/x86/include/asm/elf.h
index 69c0f892e310..367cd36259a4 100644
--- a/arch/x86/include/asm/elf.h
+++ b/arch/x86/include/asm/elf.h
@@ -280,10 +280,12 @@ extern u32 elf_hwcap2;

 /*
  * An executable for which elf_read_implies_exec() returns TRUE will
- * have the READ_IMPLIES_EXEC personality flag set automatically.
+ * have the READ_IMPLIES_EXEC personality flag set automatically when
+ * a CPU did not support NX or is using a 32-bit memory layout.
  */
-#define elf_read_implies_exec(ex, executable_stack)    \
-       (executable_stack != EXSTACK_DISABLE_X)
+#define elf_read_implies_exec(ex, executable_stack)            \
+       (mmap_is_ia32() || !(__supported_pte_mask & _PAGE_NX) ? \
+               (executable_stack != EXSTACK_DISABLE_X) : 0)

 struct task_struct;


Additionally, I think architectures that always had NX (arm64) should
entirely remove their elf_read_implies_exec() macro (defaulting to the
removal of the stack-marking-based READ_IMPLIES_EXEC enabling):

diff --git a/arch/arm64/include/asm/elf.h b/arch/arm64/include/asm/elf.h
index 6adc1a90e7e6..87c2dd468eea 100644
--- a/arch/arm64/include/asm/elf.h
+++ b/arch/arm64/include/asm/elf.h
@@ -107,8 +107,6 @@
  */
 #define elf_check_arch(x)              ((x)->e_machine == EM_AARCH64)

-#define elf_read_implies_exec(ex,stk)  (stk != EXSTACK_DISABLE_X)
-
 #define CORE_DUMP_USE_REGSET
 #define ELF_EXEC_PAGESIZE      PAGE_SIZE


Thoughts?

-Kees

[1] https://lkml.kernel.org/r/20190418055759.GA3155@mellanox.com

--
Kees Cook
