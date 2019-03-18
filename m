Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6A81C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 13:12:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A9FD20863
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 13:12:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P3PdHQt7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727507AbfCRNMC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 09:12:02 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41494 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726691AbfCRNMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 09:12:01 -0400
Received: by mail-pg1-f194.google.com with SMTP id k11so11344517pgb.8
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 06:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=epSZyqBe4Y/OKKkFIQZrTHU48PlN6fQS/KXlKAwvNCI=;
        b=P3PdHQt7xFqZZ3OrRYOWBumt+a10yvZZMe1ahnZ2OGcnXfGyJJFIc2Nb8lvZ1eqff4
         2Pf3/a37IMdsjTJvg8yZIdYlXXtA+u9R1nUXlnqxgvTcan5dBu3bKAFJ12vFUq8LYM69
         rXxz45yqcaFS2CRPQ3W1ojfgDx8Sa0oilfDVLK6Yxc/nGYKhB1oOWK505pPCwQSxpwaR
         EFKBroNNEWD6Oe94kwuZEJMakVgDICxInMsHhkEnvuZnJUNaYMUcJsseebsl58Kr62PY
         r4/L9fjQ615HRjni091pU8NN0zsXcHSGyGGzPKRhhr27ZgOiVu1plt9p95gldYBxHQdQ
         /jIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=epSZyqBe4Y/OKKkFIQZrTHU48PlN6fQS/KXlKAwvNCI=;
        b=im5/JIXXMkQwx0idXRMs8F4zevvi0MrN17bszYoFDLncivRsyqKIFDCldOOyesVMOD
         61fC7GonJ1u5zYBorULLdQkm+dWseqlE+dNGeUr+Zx+Wr4qPQYZ3Kw2dssvw5Cocj8c0
         TBG5TXiPE4u6BOxnc/P54D4lcfEadHrFPmGCpC9UAXnqODvfek22VS4+/VA6BRb5R9u2
         CBbpjpBFMKAc4y8/w0l1EVjoaI3i0ppbVcsPzswvCnpEbYPesdGv/mp3Hf/H/CmkbVqA
         LKP7tiRHP5oiaFp0E+pb0ePunxj7kprm5DnjOeqaZWmHEZGHD7CweKwu34wNYOLEQWSW
         3Y1A==
X-Gm-Message-State: APjAAAWb2kW7nsmTF6Jhnz+KI2G+kVn4V68XLmKYY+ec4eBBHfLrjGcB
        0pr7Pl3h7dERHdFKTgf/EmZbf4Wi0TfSzObV4OHfSA==
X-Google-Smtp-Source: APXvYqxkDF5fYpEH3Vs9ly9eilzCAQ4eFXUJCbCmr4F2nw4zNTdJM2I6GFk4D2mim2UUO7TV8sZWRVg+GwdnMP3xaNA=
X-Received: by 2002:a65:6651:: with SMTP id z17mr16746057pgv.95.1552914720458;
 Mon, 18 Mar 2019 06:12:00 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1552679409.git.andreyknvl@google.com> <355e7c0dadaa2bb79d22e0b7aac7e4efc1114d49.1552679409.git.andreyknvl@google.com>
 <20190315161414.4b31fb03@gandalf.local.home>
In-Reply-To: <20190315161414.4b31fb03@gandalf.local.home>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Mon, 18 Mar 2019 14:11:48 +0100
Message-ID: <CAAeHK+w5L+yD-9c94vgX3KcQuzyaKhoDemgGcZ8SJWpc7GhE9g@mail.gmail.com>
Subject: Re: [PATCH v11 10/14] tracing, arm64: untag user pointers in seq_print_user_ip
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>, bpf@vger.kernel.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Evgeniy Stepanov <eugenis@google.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Chintan Pandya <cpandya@codeaurora.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 15, 2019 at 9:14 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Fri, 15 Mar 2019 20:51:34 +0100
> Andrey Konovalov <andreyknvl@google.com> wrote:
>
> > This patch is a part of a series that extends arm64 kernel ABI to allow to
> > pass tagged user pointers (with the top byte set to something else other
> > than 0x00) as syscall arguments.
> >
> > seq_print_user_ip() uses provided user pointers for vma lookups, which
> > can only by done with untagged pointers.
> >
> > Untag user pointers in this function.
> >
> > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> > ---
> >  kernel/trace/trace_output.c |  5 +++--
> >  p                           | 45 +++++++++++++++++++++++++++++++++++++
> >  2 files changed, 48 insertions(+), 2 deletions(-)
> >  create mode 100644 p
> >
> > diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
> > index 54373d93e251..6376bee93c84 100644
> > --- a/kernel/trace/trace_output.c
> > +++ b/kernel/trace/trace_output.c
> > @@ -370,6 +370,7 @@ static int seq_print_user_ip(struct trace_seq *s, struct mm_struct *mm,
> >  {
> >       struct file *file = NULL;
> >       unsigned long vmstart = 0;
> > +     unsigned long untagged_ip = untagged_addr(ip);
> >       int ret = 1;
> >
> >       if (s->full)
> > @@ -379,7 +380,7 @@ static int seq_print_user_ip(struct trace_seq *s, struct mm_struct *mm,
> >               const struct vm_area_struct *vma;
> >
> >               down_read(&mm->mmap_sem);
> > -             vma = find_vma(mm, ip);
> > +             vma = find_vma(mm, untagged_ip);
> >               if (vma) {
> >                       file = vma->vm_file;
> >                       vmstart = vma->vm_start;
> > @@ -388,7 +389,7 @@ static int seq_print_user_ip(struct trace_seq *s, struct mm_struct *mm,
> >                       ret = trace_seq_path(s, &file->f_path);
> >                       if (ret)
> >                               trace_seq_printf(s, "[+0x%lx]",
> > -                                              ip - vmstart);
> > +                                              untagged_ip - vmstart);
> >               }
> >               up_read(&mm->mmap_sem);
> >       }
> > diff --git a/p b/p
> > new file mode 100644
> > index 000000000000..9d6fa5386e55
> > --- /dev/null
> > +++ b/p
> > @@ -0,0 +1,45 @@
> > +commit 1fa6fadf644859e8a6a8ecce258444b49be8c7ee
> > +Author: Andrey Konovalov <andreyknvl@google.com>
> > +Date:   Mon Mar 4 17:20:32 2019 +0100
> > +
> > +    kasan: fix coccinelle warnings in kasan_p*_table
> > +
> > +    kasan_p4d_table, kasan_pmd_table and kasan_pud_table are declared as
> > +    returning bool, but return 0 instead of false, which produces a coccinelle
> > +    warning. Fix it.
> > +
> > +    Fixes: 0207df4fa1a8 ("kernel/memremap, kasan: make ZONE_DEVICE with work with KASAN")
> > +    Reported-by: kbuild test robot <lkp@intel.com>
> > +    Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
>
> Did you mean to append this commit to this patch?

No, did it by mistake. Will remove in v12, thanks for noticing!

>
> -- Steve
>
> > +
> > +diff --git a/mm/kasan/init.c b/mm/kasan/init.c
> > +index 45a1b5e38e1e..fcaa1ca03175 100644
> > +--- a/mm/kasan/init.c
> > ++++ b/mm/kasan/init.c
> > +@@ -42,7 +42,7 @@ static inline bool kasan_p4d_table(pgd_t pgd)
> > + #else
> > + static inline bool kasan_p4d_table(pgd_t pgd)
> > + {
> > +-    return 0;
> > ++    return false;
> > + }
> > + #endif
> > + #if CONFIG_PGTABLE_LEVELS > 3
> > +@@ -54,7 +54,7 @@ static inline bool kasan_pud_table(p4d_t p4d)
> > + #else
> > + static inline bool kasan_pud_table(p4d_t p4d)
> > + {
> > +-    return 0;
> > ++    return false;
> > + }
> > + #endif
> > + #if CONFIG_PGTABLE_LEVELS > 2
> > +@@ -66,7 +66,7 @@ static inline bool kasan_pmd_table(pud_t pud)
> > + #else
> > + static inline bool kasan_pmd_table(pud_t pud)
> > + {
> > +-    return 0;
> > ++    return false;
> > + }
> > + #endif
> > + pte_t kasan_early_shadow_pte[PTRS_PER_PTE] __page_aligned_bss;
>
