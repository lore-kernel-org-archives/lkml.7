Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20FFEC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:22:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF14920C01
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:22:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D15vBXdr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731106AbfB1PWX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 10:22:23 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:55115 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732623AbfB1PWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 10:22:17 -0500
Received: by mail-it1-f193.google.com with SMTP id w18so15182278itj.4
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 07:22:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qLPZhMmZTi0+O61gU1HCGULwNi52OrAu5hPHt1M13hA=;
        b=D15vBXdrprXI6MU4ZPzwy0y3tRvqtfwNosMfaTUMlnP/VJl8ljiF07q+SuY0mPwVMX
         g1V80bGfib2aCHfqCLdwg/DdE8MGpe37V+vSrPSUKDqrKfximcEA5vc7JgoTuHzqlqIS
         kHpzfvv+L0o/yxkm6ftNgFn6yHxJYC3YmgZojxOuGF/RkOkoT3SijXqEYDZ8sThioUE8
         hl1JsKS1pZfPvyW21Nro+nCruk4qrWocsykmF+eb9AVEgLM07eyFdCoWs3fGugTr8j0r
         5p5CsvOs010uqW5MFY4lK1Rb3hO2H5fh0okF1arz7GcDvynaoUX+HPUZ0PKwguhguRXn
         QRIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qLPZhMmZTi0+O61gU1HCGULwNi52OrAu5hPHt1M13hA=;
        b=G2Ylnhv2czXpIU5nB3vVEdsBoqs9I/wfoQoiiTwBQSY/V1vJycONhxzMYsSrOpIJZE
         OdHIe/jCu6XNfUbOXKJvkt3JvlrPb/dzQPXRZvg3dLKIDro2Jlwdu5Cdhs0ZFUcAX+uy
         so/KRJAG1wHv+POlK3BMxTuPiIaKqZtFS4k1N2dAHSCmOZoPwOrgma02JbO8BuvMd+a6
         KPD3/+GRKq35EsOK6eotHwBMGRoy+oKMitLD+BYHIYDK/rFjiBQOkEjEjoDPLwHAXxVs
         hbNGW6j76WISIQAfNQKxiP233YQ9W6CkYyP/3UkR3ctlQQaM+Ziwmgx+hH/TOD5VNlbh
         AkAA==
X-Gm-Message-State: AHQUAuZcwYlnoYT7Ulgaa+KH5H1CCROyl4+EmtwSkD6QUcZqztJ5jCpa
        0nW5EDou81dLyH3XMrMlCXK7ju+F2JBIA8eH2rqMuw==
X-Google-Smtp-Source: AHgI3IaycDug+8A8KXDg4RIIW7z6De04pSi6eJX6NAWqIhaJFJdvHRROo9KzgY3VCaG/B1ST6Am8JmRcOBZSlBZhrDA=
X-Received: by 2002:a02:a58a:: with SMTP id b10mr4866914jam.82.1551367336221;
 Thu, 28 Feb 2019 07:22:16 -0800 (PST)
MIME-Version: 1.0
References: <20190228145450.289603901@infradead.org> <20190228150152.078767622@infradead.org>
In-Reply-To: <20190228150152.078767622@infradead.org>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 28 Feb 2019 16:22:04 +0100
Message-ID: <CACT4Y+b0WyE5En7BVipZiCMmMaj30kaEu3T68H7+-kVP8gqADA@mail.gmail.com>
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

On Thu, Feb 28, 2019 at 4:05 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> Because __asan_{load,store}{N,1,2,4,8,16}_noabort() get called from
> UACCESS context, and kasan_report() is most definitely _NOT_ safe to
> be called from there, move it into an exception much like BUG/WARN.
>
> *compile tested only*


Please test it by booting KASAN kernel and then loading module
produced by CONFIG_TEST_KASAN=y. There are too many subtle aspects to
rely on "compile tested only", reviewers can't catch all of them
either.


> Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  arch/x86/include/asm/bug.h   |   28 ++++++++++++++--------------
>  arch/x86/include/asm/kasan.h |   15 +++++++++++++++
>  include/asm-generic/bug.h    |    1 +
>  include/linux/kasan.h        |   12 +++++++++---
>  lib/bug.c                    |    9 ++++++++-
>  mm/kasan/generic.c           |    4 ++--
>  mm/kasan/kasan.h             |    2 +-
>  mm/kasan/report.c            |    2 +-
>  8 files changed, 51 insertions(+), 22 deletions(-)
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
> @@ -2,6 +2,8 @@
>  #ifndef _ASM_X86_KASAN_H
>  #define _ASM_X86_KASAN_H
>
> +#include <asm/bug.h>
> +
>  #include <linux/const.h>
>  #define KASAN_SHADOW_OFFSET _AC(CONFIG_KASAN_SHADOW_OFFSET, UL)
>  #define KASAN_SHADOW_SCALE_SHIFT 3
> @@ -26,8 +28,21 @@
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
> +       unsigned long rdi = addr, rsi = size, rdx = is_write, rcx = ip;
> +
> +       _BUG_FLAGS(ASM_UD2, BUGFLAG_KASAN,
> +                  "D" (rdi), "S" (rsi), "d" (rdx), "c" (rcx));

Can BUG return? This should be able to return.
We also have other tools coming (KMSAN/KTSAN) where distinction
between fast path that does nothing and slower-paths are very blurred
and there are dozens of them, I don't think this BUG thunk will be
sustainable. What does BUG do what a normal call can't do?


> +       annotate_reachable();
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
> --- a/mm/kasan/generic.c
> +++ b/mm/kasan/generic.c
> @@ -228,7 +228,7 @@ void __asan_unregister_globals(struct ka
>  EXPORT_SYMBOL(__asan_unregister_globals);
>
>  #define DEFINE_ASAN_LOAD_STORE(size)                                   \
> -       void __asan_load##size(unsigned long addr)                      \
> +       notrace void __asan_load##size(unsigned long addr)              \


We already have:
CFLAGS_REMOVE_generic.o = -pg
Doesn't it imply notrace for all functions?



>         {                                                               \
>                 check_memory_region_inline(addr, size, false, _RET_IP_);\
>         }                                                               \
> @@ -236,7 +236,7 @@ EXPORT_SYMBOL(__asan_unregister_globals)
>         __alias(__asan_load##size)                                      \
>         void __asan_load##size##_noabort(unsigned long);                \
>         EXPORT_SYMBOL(__asan_load##size##_noabort);                     \
> -       void __asan_store##size(unsigned long addr)                     \
> +       notrace void __asan_store##size(unsigned long addr)             \
>         {                                                               \
>                 check_memory_region_inline(addr, size, true, _RET_IP_); \
>         }                                                               \
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
>
>
