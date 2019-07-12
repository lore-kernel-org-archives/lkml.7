Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D010C742BD
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 14:51:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2CD52080A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 14:51:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727183AbfGLOvB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 10:51:01 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:37994 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726664AbfGLOvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 10:51:01 -0400
Received: by mail-qt1-f194.google.com with SMTP id n11so8339869qtl.5
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2019 07:51:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oH1fo+W6QvW3TDYAOS3VNfR52O9ab9tANtdOaHmm3OY=;
        b=hLPghAEGrcDsJ3KMnX2cb2Ly55SJ/ZNy3fhIUsc6t3ACkFdAuvRfkAe8SUxbZXZU8c
         fCX48D9tDM1Hbkr7fdjshyWKWSx3xYaqv53wPE8lE8bB5/hPrjjmwqajcEjnWnng1l0W
         1f+RIBgZDN78L1AtVAMMSBxUkJ29Tj6ceXjhw5E92J+cwhRoAmYAuuvO4/X00KSvdDP7
         MK4mis4H47VgHCZAm4FHZ1o5Vq+FxWrBmReTY9rqPyBT1VPFbr3M6KnTxcpQP6WrLmk4
         tB0lL2AvCm0f+5AZgr8UiL3oIU8jgNkAMej647nCfL3gP16M6/CBkEgyEPD7QI6srA3T
         Yf2Q==
X-Gm-Message-State: APjAAAVo7S6e8ywiKhGnEkq7kDYWrpcjZR+IZWVMg5mnP/jnILM8Qkm3
        +u6Mo3bPEaVUUfteCiQZK9Vi1J/BfkkLrFRN9a0=
X-Google-Smtp-Source: APXvYqyN3byscQG9xRVYhfc4ZggmHx+5pAzvEKE4tdJsPcnHN2RUVnZ2N8qUfEa7fU4E4sSEIYj+FU/R1Cs2D+UXyWE=
X-Received: by 2002:ac8:5311:: with SMTP id t17mr6508885qtn.304.1562943059631;
 Fri, 12 Jul 2019 07:50:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190703081119.209976-1-arnd@arndb.de> <20190711174949.dc74310efd1fd3c8bd4ea276@linux-foundation.org>
 <CAK8P3a2ZRw9B=X76yL-bRzC+01z6VaHDzPAhQQw7V9MXtkp+Jg@mail.gmail.com> <20190712075438.GA88904@archlinux-threadripper>
In-Reply-To: <20190712075438.GA88904@archlinux-threadripper>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 12 Jul 2019 16:50:42 +0200
Message-ID: <CAK8P3a09LpFYKcfJB0izCwQVAm0Bkvx_MUi8qvTORshUUp=5+w@mail.gmail.com>
Subject: Re: [PATCH] waitqueue: fix clang -Wuninitialized warnings
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 12, 2019 at 9:54 AM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> On Fri, Jul 12, 2019 at 09:45:06AM +0200, Arnd Bergmann wrote:
> > On Fri, Jul 12, 2019 at 2:49 AM Andrew Morton <akpm@linux-foundation.org> wrote:
> > > On Wed,  3 Jul 2019 10:10:55 +0200 Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > > <scratches head>
> > >
> > > Surely clang is being extraordinarily dumb here?
> > >
> > > DECLARE_WAIT_QUEUE_HEAD_ONSTACK() is effectively doing
> > >
> > >         struct wait_queue_head name = ({ __init_waitqueue_head(&name) ; name; })
> > >
> > > which is perfectly legitimate!  clang has no business assuming that
> > > __init_waitqueue_head() will do any reads from the pointer which it was
> > > passed, nor can clang assume that __init_waitqueue_head() leaves any of
> > > *name uninitialized.
> > >
> > > Does it also warn if code does this?
> > >
> > >         struct wait_queue_head name;
> > >         __init_waitqueue_head(&name);
> > >         name = name;
> > >
> > > which is equivalent, isn't it?
> >
> > No, it does not warn for this.
> >
> > I've tried a few more variants here: https://godbolt.org/z/ykSX0r
> >
> > What I think is going on here is a result of clang and gcc fundamentally
> > treating -Wuninitialized warnings differently. gcc tries to make the warnings
> > as helpful as possible, but given the NP-complete nature of this problem
> > it won't always get it right, and it traditionally allowed this syntax as a
> > workaround.
> >
> > int f(void)
> > {
> >     int i = i; // tell gcc not to warn
> >     return i;
> > }
> >
> > clang apparently implements the warnings in a way that is as
> > completely predictable (and won't warn in cases that it
> > doesn't completely understand), but decided as a result that the
> > gcc 'int i = i' syntax is bogus and it always warns about a variable
> > used in its own declaration that is later referenced, without looking
> > at whether the declaration does initialize it or not.
> >
> > > The proposed solution is, effectively, to open-code
> > > __init_waitqueue_head() at each DECLARE_WAIT_QUEUE_HEAD_ONSTACK()
> > > callsite.  That's pretty unpleasant and calls for an explanatory
> > > comment at the __WAIT_QUEUE_HEAD_INIT_ONSTACK() definition site as well
> > > as a cautionary comment at the __init_waitqueue_head() definition so we
> > > can keep the two versions in sync as code evolves.
> >
> > Yes, makes sense.
> >
> > > Hopefully clang will soon be hit with the cluebat (yes?) and this
> > > change becomes obsolete in the quite short term.  Surely 6-12 months
> > > from now nobody will be using the uncluebatted version of clang on
> > > contemporary kernel sources so we get to remove this nastiness again.
> > > Which makes me wonder whether we should merge it at all.
> >
> > Would it make you feel better to keep the current code but have an alternative
> > version guarded with e.g. "#if defined(__clang__ && (__clang_major__ <= 9)"?
> >
> > While it is probably a good idea to fix clang here, this is one of the last
> > issues that causes a significant difference between gcc and clang in build
> > testing with kernelci:
> > https://kernelci.org/build/next/branch/master/kernel/next-20190709/
> > I'm trying to get all the warnings fixed there so we can spot build-time
> > regressions more easily.
> >
> >       Arnd
>
> I'm just spitballing here since I am about to go to sleep but could we
> do something like you did for bee20031772a ("disable -Wattribute-alias
> warning for SYSCALL_DEFINEx()") and disable the warning in
> DECLARE_WAIT_QUEUE_HEAD_ONSTACK only since we know it is not going to
> be a problem? That way, if/when Clang is fixed, we can just have the
> warning be disabled for older versions?

I managed to get that to work, but there are two problems:

- the __diag_ignore() infrastructure was never added for clang, so
  I ended up copying a lot from gcc. There is probably a nicer way
  to do this, but that would require a larger rework
- adding __diag_pop() between two variable declarations is seen as
  a statement that causes a warning with both gcc and clang,
  so I had to turn that warning off as well for all compilers, and at that
  point it gets rather ugly in the macro.

       Arnd

diff --git a/include/linux/compiler-clang.h b/include/linux/compiler-clang.h
index 333a6695a918..0d30c0489ad7 100644
--- a/include/linux/compiler-clang.h
+++ b/include/linux/compiler-clang.h
@@ -42,3 +42,31 @@
  * compilers, like ICC.
  */
 #define barrier() __asm__ __volatile__("" : : : "memory")
+
+/*
+ * Turn individual warnings and errors on and off locally, depending
+ * on version.
+ */
+#define __diag_clang(version, severity, s) \
+       __diag_clang_ ## version(__diag_clang_ ## severity s)
+
+/* Severity used in pragma directives */
+#define __diag_clang_ignore    ignored
+#define __diag_clang_warn      warning
+#define __diag_clang_error     error
+
+#define __diag_str1(s)         #s
+#define __diag_str(s)          __diag_str1(s)
+#define __diag(s)              _Pragma(__diag_str(clang diagnostic s))
+
+#if __clang_major__ >= 8
+#define __diag_clang_8(s)              __diag(s)
+#else
+#define __diag_clang_8(s)
+#endif
+
+#if __clang_major__ >= 9
+#define __diag_clang_9(s)              __diag(s)
+#else
+#define __diag_clang_9(s)
+#endif
diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
index e8579412ad21..c5f8d9ae0530 100644
--- a/include/linux/compiler-gcc.h
+++ b/include/linux/compiler-gcc.h
@@ -165,8 +165,16 @@
 #define __diag_str(s)          __diag_str1(s)
 #define __diag(s)              _Pragma(__diag_str(GCC diagnostic s))

+#if GCC_VERSION >= 40006
+#define __diag_GCC_4_6(s)      __diag(s)
+#else
+#define __diag_GCC_4_6(s)
+#endif
+
 #if GCC_VERSION >= 80000
 #define __diag_GCC_8(s)                __diag(s)
 #else
 #define __diag_GCC_8(s)
 #endif
+
+#define __diag_clang(s...)
diff --git a/include/linux/wait.h b/include/linux/wait.h
index ddb959641709..0e33fe589f49 100644
--- a/include/linux/wait.h
+++ b/include/linux/wait.h
@@ -71,7 +71,12 @@ extern void __init_waitqueue_head(struct
wait_queue_head *wq_head, const char *n
 # define __WAIT_QUEUE_HEAD_INIT_ONSTACK(name) \
        ({ init_waitqueue_head(&name); name; })
 # define DECLARE_WAIT_QUEUE_HEAD_ONSTACK(name) \
-       struct wait_queue_head name = __WAIT_QUEUE_HEAD_INIT_ONSTACK(name)
+       __diag_push();                  \
+       __diag_ignore(clang, 8, "-Wuninitialized",
"https://godbolt.org/z/ykSX0r");     \
+       __diag_ignore(clang, 8, "-Wdeclaration-after-statement", "for
__diag_pop");     \
+       __diag_ignore(GCC, 4_6, "-Wdeclaration-after-statement", "for
__diag_pop");     \
+       struct wait_queue_head name = __WAIT_QUEUE_HEAD_INIT_ONSTACK(name); \
+       __diag_pop()
 #else
 # define DECLARE_WAIT_QUEUE_HEAD_ONSTACK(name) DECLARE_WAIT_QUEUE_HEAD(name)
 #endif
