Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02E88C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 15:06:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD5D020851
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 15:06:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fAvXFlAh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388305AbfCAPGb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 10:06:31 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:37084 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727951AbfCAPGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 10:06:31 -0500
Received: by mail-io1-f65.google.com with SMTP id v10so19802295iop.4
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2019 07:06:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E7SzZYvL6xrWB1nquVF6Inb+7CO/YTXgCeirxt8iQPo=;
        b=fAvXFlAhtpYE2amEiiHM0udyWCPl4gSkpMhP61MCzMQF/7UZa8qp3xKrz5a1WDkafP
         FCko3tDiFO4VeQZ/PXELw7/Gro7fIxYyplPvu7O3cGI0gC6eKfwT5W7lhorxjMfGyFLi
         Rup1qypFzFeSYBLjyPiaVdDcNGNjBlniX+3svUmb37ncNuemNf4sQg3rxIYl07tZYOZc
         f/7I+0Qf+IsWu1NWbjj2YhKihs4QNlI03G+NR6B+Xfu5xJtcQOts0E5/TdtdXLWjzX05
         hOZONmLOjc9Bdk3nT5K2JhG1RJmhQ/zI9ucdtgmVJLHSj9G1B7mHsmKzFmFHmK2o6MA5
         GIKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E7SzZYvL6xrWB1nquVF6Inb+7CO/YTXgCeirxt8iQPo=;
        b=q3CZYU0r/a6pM5ICGHi212eQqNAIRWOEqXo6Cbj1OyvhSNrGglQM3+xN9QiBzjPEJ/
         5GBpGxQx3cWVzDzqenDObKdstArzmmc7OHrJAeYqlvGGE8oOgAqUjD+z41AQIYHU1COt
         T+rlEScaaUlwjM4RXVsoXFuyz/6ay1pdy6fh9i8PhrqHWbyatM7dL9dkHJ1P/HjauMEw
         85khoiePe4SHMqdOBlq/H/6qEVfFj5Teh83P6xXnWRLyxgkRVLpP5X9iQR1DeDyl73YG
         paIwXRUVzF8zjJr0LDYvz+hAR2vfMPEEkhYa4M+ZG3pM6fB2UjZeldmuNNijmI8+9g4s
         1QSw==
X-Gm-Message-State: APjAAAV0PxTOj2vePETEtcEysCXUuLIfCWGuJ0S8iw1iaYTcCsw7aijj
        XbGc2+VZLvTbP+WX+v1D3CLr3JrWu0Y/BAvE1lJ9/g==
X-Google-Smtp-Source: APXvYqzOTx2zlPae+NbBxhVmFbsCfcqIPwZeyk69kvyGTUUu+RhLAwSC/3hKy/j5Voyp6PSl2eQMZZX0IYiHDekAqzo=
X-Received: by 2002:a6b:6b18:: with SMTP id g24mr2507775ioc.282.1551452789844;
 Fri, 01 Mar 2019 07:06:29 -0800 (PST)
MIME-Version: 1.0
References: <20190228145450.289603901@infradead.org> <20190228150152.078767622@infradead.org>
 <CACT4Y+b0WyE5En7BVipZiCMmMaj30kaEu3T68H7+-kVP8gqADA@mail.gmail.com> <20190301144556.GY32477@hirez.programming.kicks-ass.net>
In-Reply-To: <20190301144556.GY32477@hirez.programming.kicks-ass.net>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 1 Mar 2019 16:06:17 +0100
Message-ID: <CACT4Y+ZyXAJiKtzoWxY-u7e9HaL7iM9tnFXnFZd7Hdy4uHEOyA@mail.gmail.com>
Subject: Re: [PATCH 1/8] kasan,x86: Frob kasan_report() in an exception
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Ingo Molnar <mingo@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>, valentin.schneider@arm.com,
        Brian Gerst <brgerst@gmail.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 1, 2019 at 3:46 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, Feb 28, 2019 at 04:22:04PM +0100, Dmitry Vyukov wrote:
> > On Thu, Feb 28, 2019 at 4:05 PM Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > Because __asan_{load,store}{N,1,2,4,8,16}_noabort() get called from
> > > UACCESS context, and kasan_report() is most definitely _NOT_ safe to
> > > be called from there, move it into an exception much like BUG/WARN.
> > >
> > > *compile tested only*
> >
> >
> > Please test it by booting KASAN kernel and then loading module
> > produced by CONFIG_TEST_KASAN=y. There are too many subtle aspects to
> > rely on "compile tested only", reviewers can't catch all of them
> > either.
>
> The below boots and survives test_kasan.
>
> I'll now try that annotation you preferred. But I think this is a pretty
> neat hack :-)

Yes, it's "neat" but it's also a "hack" :)

It involves asm, hardware exceptions, UD2 instructions. It also seems
to use arch-dependent code in arch-independent files: there is no RSI
on other arches, does this compile on non-x86? I understand you are
pretty comfortable with such code, but all else being equal normal C
code is preferable.
And it's not that we gain much due to this, we are merely working
around things. We tried to use UD2 for asan reports, but we emitted it
into the generated code where it had a chance of speeding up things
which could potentially justify hacks. But even there the final
decision was to go with normal calls.


> ---
> Subject: kasan,x86: Frob kasan_report() in an exception
> From: Peter Zijlstra <peterz@infradead.org>
> Date: Thu Feb 28 15:52:03 CET 2019
>
> Because __asan_{load,store}{N,1,2,4,8,16}_noabort() get called from
> UACCESS context, and kasan_report() is most definitely _NOT_ safe to
> be called from there, move it into an exception much like BUg/WARN.
>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  arch/x86/include/asm/bug.h   |   28 ++++++++++++++--------------
>  arch/x86/include/asm/kasan.h |   17 +++++++++++++++++
>  include/asm-generic/bug.h    |    1 +
>  include/linux/kasan.h        |   12 +++++++++---
>  lib/bug.c                    |    9 ++++++++-
>  mm/kasan/kasan.h             |    2 +-
>  mm/kasan/report.c            |    2 +-
>  7 files changed, 51 insertions(+), 20 deletions(-)
>
> --- a/arch/x86/include/asm/bug.h
> +++ b/arch/x86/include/asm/bug.h
> @@ -30,33 +30,33 @@
>
>  #ifdef CONFIG_DEBUG_BUGVERBOSE
>
> -#define _BUG_FLAGS(ins, flags)                                         \
> +#define _BUG_FLAGS(ins, flags, ...)                                    \
>  do {                                                                   \
>         asm volatile("1:\t" ins "\n"                                    \
>                      ".pushsection __bug_table,\"aw\"\n"                \
> -                    "2:\t" __BUG_REL(1b) "\t# bug_entry::bug_addr\n"   \
> -                    "\t"  __BUG_REL(%c0) "\t# bug_entry::file\n"       \
> -                    "\t.word %c1"        "\t# bug_entry::line\n"       \
> -                    "\t.word %c2"        "\t# bug_entry::flags\n"      \
> -                    "\t.org 2b+%c3\n"                                  \
> +                    "2:\t" __BUG_REL(1b)      "\t# bug_entry::bug_addr\n" \
> +                    "\t"  __BUG_REL(%c[file]) "\t# bug_entry::file\n"  \
> +                    "\t.word %c[line]"        "\t# bug_entry::line\n"  \
> +                    "\t.word %c[flag]"        "\t# bug_entry::flags\n" \
> +                    "\t.org 2b+%c[size]\n"                             \
>                      ".popsection"                                      \
> -                    : : "i" (__FILE__), "i" (__LINE__),                \
> -                        "i" (flags),                                   \
> -                        "i" (sizeof(struct bug_entry)));               \
> +                    : : [file] "i" (__FILE__), [line] "i" (__LINE__),  \
> +                        [flag] "i" (flags),                            \
> +                        [size] "i" (sizeof(struct bug_entry)), ##__VA_ARGS__); \
>  } while (0)
>
>  #else /* !CONFIG_DEBUG_BUGVERBOSE */
>
> -#define _BUG_FLAGS(ins, flags)                                         \
> +#define _BUG_FLAGS(ins, flags, ...)                                    \
>  do {                                                                   \
>         asm volatile("1:\t" ins "\n"                                    \
>                      ".pushsection __bug_table,\"aw\"\n"                \
>                      "2:\t" __BUG_REL(1b) "\t# bug_entry::bug_addr\n"   \
> -                    "\t.word %c0"        "\t# bug_entry::flags\n"      \
> -                    "\t.org 2b+%c1\n"                                  \
> +                    "\t.word %c[flag]"   "\t# bug_entry::flags\n"      \
> +                    "\t.org 2b+%c[size]\n"                             \
>                      ".popsection"                                      \
> -                    : : "i" (flags),                                   \
> -                        "i" (sizeof(struct bug_entry)));               \
> +                    : : [flag] "i" (flags),                            \
> +                        [size] "i" (sizeof(struct bug_entry)), ##__VA_ARGS__); \
>  } while (0)
>
>  #endif /* CONFIG_DEBUG_BUGVERBOSE */
> --- a/arch/x86/include/asm/kasan.h
> +++ b/arch/x86/include/asm/kasan.h
> @@ -2,7 +2,10 @@
>  #ifndef _ASM_X86_KASAN_H
>  #define _ASM_X86_KASAN_H
>
> +#include <asm/bug.h>
> +
>  #include <linux/const.h>
> +#include <linux/sched.h>
>  #define KASAN_SHADOW_OFFSET _AC(CONFIG_KASAN_SHADOW_OFFSET, UL)
>  #define KASAN_SHADOW_SCALE_SHIFT 3
>
> @@ -26,8 +29,22 @@
>  #ifndef __ASSEMBLY__
>
>  #ifdef CONFIG_KASAN
> +
>  void __init kasan_early_init(void);
>  void __init kasan_init(void);
> +
> +static __always_inline void
> +kasan_report(unsigned long addr, size_t size, bool is_write, unsigned long ip)
> +{
> +       if (!current->kasan_depth) {
> +               unsigned long rdi = addr, rsi = size, rdx = is_write, rcx = ip;
> +               _BUG_FLAGS(ASM_UD2, BUGFLAG_KASAN,
> +                               "D" (rdi), "S" (rsi), "d" (rdx), "c" (rcx));
> +               annotate_reachable();
> +       }
> +}
> +#define kasan_report kasan_report
> +
>  #else
>  static inline void kasan_early_init(void) { }
>  static inline void kasan_init(void) { }
> --- a/include/asm-generic/bug.h
> +++ b/include/asm-generic/bug.h
> @@ -10,6 +10,7 @@
>  #define BUGFLAG_WARNING                (1 << 0)
>  #define BUGFLAG_ONCE           (1 << 1)
>  #define BUGFLAG_DONE           (1 << 2)
> +#define BUGFLAG_KASAN          (1 << 3)
>  #define BUGFLAG_TAINT(taint)   ((taint) << 8)
>  #define BUG_GET_TAINT(bug)     ((bug)->flags >> 8)
>  #endif
> --- a/include/linux/kasan.h
> +++ b/include/linux/kasan.h
> @@ -83,6 +83,9 @@ size_t kasan_metadata_size(struct kmem_c
>  bool kasan_save_enable_multi_shot(void);
>  void kasan_restore_multi_shot(bool enabled);
>
> +void __kasan_report(unsigned long addr, size_t size,
> +               bool is_write, unsigned long ip);
> +
>  #else /* CONFIG_KASAN */
>
>  static inline void kasan_unpoison_shadow(const void *address, size_t size) {}
> @@ -153,8 +156,14 @@ static inline void kasan_remove_zero_sha
>  static inline void kasan_unpoison_slab(const void *ptr) { }
>  static inline size_t kasan_metadata_size(struct kmem_cache *cache) { return 0; }
>
> +static inline void __kasan_report(unsigned long addr, size_t size, bool is_write, unsigned long ip) { }
> +
>  #endif /* CONFIG_KASAN */
>
> +#ifndef kasan_report
> +#define kasan_report(addr, size, is_write, ip) __kasan_report(addr, size, is_write, ip)
> +#endif
> +
>  #ifdef CONFIG_KASAN_GENERIC
>
>  #define KASAN_SHADOW_INIT 0
> @@ -177,9 +186,6 @@ void kasan_init_tags(void);
>
>  void *kasan_reset_tag(const void *addr);
>
> -void kasan_report(unsigned long addr, size_t size,
> -               bool is_write, unsigned long ip);
> -
>  #else /* CONFIG_KASAN_SW_TAGS */
>
>  static inline void kasan_init_tags(void) { }
> --- a/lib/bug.c
> +++ b/lib/bug.c
> @@ -47,6 +47,7 @@
>  #include <linux/bug.h>
>  #include <linux/sched.h>
>  #include <linux/rculist.h>
> +#include <linux/kasan.h>
>
>  extern struct bug_entry __start___bug_table[], __stop___bug_table[];
>
> @@ -144,7 +145,7 @@ enum bug_trap_type report_bug(unsigned l
>  {
>         struct bug_entry *bug;
>         const char *file;
> -       unsigned line, warning, once, done;
> +       unsigned line, warning, once, done, kasan;
>
>         if (!is_valid_bugaddr(bugaddr))
>                 return BUG_TRAP_TYPE_NONE;
> @@ -167,6 +168,7 @@ enum bug_trap_type report_bug(unsigned l
>                 line = bug->line;
>  #endif
>                 warning = (bug->flags & BUGFLAG_WARNING) != 0;
> +               kasan = (bug->flags & BUGFLAG_KASAN) != 0;
>                 once = (bug->flags & BUGFLAG_ONCE) != 0;
>                 done = (bug->flags & BUGFLAG_DONE) != 0;
>
> @@ -188,6 +190,11 @@ enum bug_trap_type report_bug(unsigned l
>                 return BUG_TRAP_TYPE_WARN;
>         }
>
> +       if (kasan) {
> +               __kasan_report(regs->di, regs->si, regs->dx, regs->cx);
> +               return BUG_TRAP_TYPE_WARN;
> +       }
> +
>         printk(KERN_DEFAULT CUT_HERE);
>
>         if (file)
> --- a/mm/kasan/kasan.h
> +++ b/mm/kasan/kasan.h
> @@ -130,7 +130,7 @@ void check_memory_region(unsigned long a
>  void *find_first_bad_addr(void *addr, size_t size);
>  const char *get_bug_type(struct kasan_access_info *info);
>
> -void kasan_report(unsigned long addr, size_t size,
> +void __kasan_report(unsigned long addr, size_t size,
>                 bool is_write, unsigned long ip);
>  void kasan_report_invalid_free(void *object, unsigned long ip);
>
> --- a/mm/kasan/report.c
> +++ b/mm/kasan/report.c
> @@ -281,7 +281,7 @@ void kasan_report_invalid_free(void *obj
>         end_report(&flags);
>  }
>
> -void kasan_report(unsigned long addr, size_t size,
> +void __kasan_report(unsigned long addr, size_t size,
>                 bool is_write, unsigned long ip)
>  {
>         struct kasan_access_info info;
