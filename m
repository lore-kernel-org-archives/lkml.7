Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73447C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 02:36:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 327FD206DD
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 02:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551753403;
	bh=fnEmIxO0df2CXXRyp3kGEvmaWJeqJywJD9ea1lSVh9s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=Cw0p4W28MPFuBWyIJuUaU3+vyNMa9mVVy2w41bsgVAJHOOBu2HE+wRLUjGRW+0Eb9
	 EYDozTRgA3SSvEWpWj8YNoZ9+A6z7p+Uob59b3MPWEK6OTaEuUZOTsKw7wlK8uWiqZ
	 0BWj/X9Bge3+Zk4ES/HJeAM1eGSNzj6djXCFTqCQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbfCECgl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 21:36:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:59148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726553AbfCECgl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 21:36:41 -0500
Received: from devbox (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B844206B6;
        Tue,  5 Mar 2019 02:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551753399;
        bh=fnEmIxO0df2CXXRyp3kGEvmaWJeqJywJD9ea1lSVh9s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ctaOPdT3kExF461S6L5/lvhGp5sPaPZcQG14s+vYtacL5bakTS3/kBJgFfldG4wFp
         DaKFQMJ+iqNq4E2SluwhiMmaShOf5fYkREbAteqteey/CQDe4oWeozEdFa4BppnH0j
         wTAvf1I8i9h/GTaVNXdfNOvNvv4kO8u/k/e4tsl0=
Date:   Tue, 5 Mar 2019 11:36:35 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     kernel test robot <lkp@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Shuah Khan <shuah@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Changbin Du <changbin.du@gmail.com>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Nadav Amit <namit@vmware.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Joel Fernandes <joel@joelfernandes.org>, yhs@fb.com, lkp@01.org
Subject: Re: [uaccess] 780464aed0:
 WARNING:at_arch/x86/include/asm/uaccess.h:#strnlen_user/0x
Message-Id: <20190305113635.18f80ea3b1f4fca54b9d21e4@kernel.org>
In-Reply-To: <CAHk-=wiQM84VsAiw92UWyQZTQxr+F032Gm5BiFBXk7tC+LQohQ@mail.gmail.com>
References: <155136980507.2968.15165201054223875356.stgit@devbox>
        <20190303173954.kliegojbuigqi5tn@inn2.lkp.intel.com>
        <CAHk-=wij8VLupHh1U-fFhFBjin9Fch3mG2_2=aL9h1L+WBvm2g@mail.gmail.com>
        <20190304101434.8429ffffb17813c0e7930130@kernel.org>
        <CAHk-=whYMvevgF4yh7uhQug=Wt1A1Eg7abyM=RCi=bQiqiMBvQ@mail.gmail.com>
        <20190304180610.2d4f6f08d9ad89d6abae3597@kernel.org>
        <CAHk-=wiQM84VsAiw92UWyQZTQxr+F032Gm5BiFBXk7tC+LQohQ@mail.gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Mar 2019 10:59:22 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Mon, Mar 4, 2019 at 1:06 AM Masami Hiramatsu <mhiramat@kernel.org> wrote:
> >
> > On Sun, 3 Mar 2019 18:37:59 -0800
> > Linus Torvalds <torvalds@linux-foundation.org> wrote:
> > > We've had this before. We've gotten rid of the actual "use system
> > > calls", but we still have some of the init sequence in particular just
> > > calling the wrappers instead.
> >
> > Are those safe if we are in init sequence?
> 
> Yes, they are, it runs with set_fs(KERNEL_DS).
> 
> But the patches made that now complain about copying from non-user
> space, even though it's fine.
> 
> Basically, "strncpy_from_user()" shouldn't use "user_access_ok()",
> since it actually can take a kernel address (with set_fs()).

OK, so strncpy_from_user() or any other copy_from_user() should be
available for copying kernel memory if set_fs(KERNEL_DS).

> Your "unsafe" version for tracing that actually sets "set_fs(USER_DS)"
> is thje only thing that should use that helper.

I see, it ensures it is accessing user-memory.

> 
> > > And yes, ksys_mount() takes __user pointers.
> > >
> > > It would be a lot better to use "do_mount()", which is the interface
> > > that takes actual "char *" pointers.
> >
> > Unfortunately, it still takes a __user pointer.
> 
> Ahh, yes, the name remains in user space.
> 
> Besides, I'm sure you'd just hit other cases instead where people use
> set_fs() and copy strings.

Yeah, under init/ I saw such cases.

> 
> > So what we need is
> >
> > long do_mount(const char *dev_name, struct path *dir_path,
> >                 const char *type_page, unsigned long flags, void *data_page)
> >
> > or introduce kern_do_mount()?
> 
> It's actually fairly painful. Particularly because of that "void *data_page".

Yeah, that is what I've hit while testing :-(

> 
> Your second email with "Would this work?" helper function _wopuldn't_
> work correctly, exactly because you passed in a regular string to the
> data page.
> 
> Also, I don't want to see code that replaces the unconditional "copy
> path from user space" with a conditional "do we have path in kernel
> space".

Yes, that's just a hack :)

> 
> So together with the whole "uyou'll hit other peoblems anyway", I
> don't think this is a good approach.
> 
> I think you simply need to have a separate "unsafe_strncpy()"
> function, and not change the existing "strncpy_from_user()".

Would you mean implementing yet another "strncpy_from_user without
pagefault"? 
What we changed here is just use user_access_ok() instead access_ok() 
in user_access_begin() because access_ok() may cause false-positive
warning if we use it in IRQ.

I think the better way to do this is allowing strncpy_from_user()
if some conditions are match, like

 - strncpy_from_user() will be able to copy user memory with set_fs(USER_DS)
 - strncpy_from_user() can copy kernel memory with set_fs(KERNEL_DS)
 - strncpy_from_user() can access unsafe memory in IRQ context if
   pagefault is disabled.

This is almost done, except for CONFIG_DEBUG_ATOMIC_SLEEP=y on x86.

So, what about adding a condition to WARN_ON_IN_IRQ() like below
instead of introducing user_access_ok() ?

diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
index 780f2b42c8ef..ec0f0b74c9ab 100644
--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -70,7 +70,7 @@ static inline bool __chk_range_not_ok(unsigned long addr, unsigned long size, un
 })
 
 #ifdef CONFIG_DEBUG_ATOMIC_SLEEP
-# define WARN_ON_IN_IRQ()      WARN_ON_ONCE(!in_task())
+# define WARN_ON_IN_IRQ()      WARN_ON_ONCE(pagefault_disabled() && !in_task())
 #else
 # define WARN_ON_IN_IRQ()
 #endif

Of course we have to move pagefault_disabled() macro in somewhere better place.

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
