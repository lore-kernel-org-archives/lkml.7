Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A0CFC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 13:58:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A5702087C
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 13:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551794291;
	bh=axca7RM4SN0gehRdBNyzipIsMfpZazaIVF9gG36Q4ys=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=sqYYZRFyJFfe5zQHVqsBGva3oCij8AJxD7fZ2tiRmmsHTjyjEJjXftn26dLy9lShC
	 8uE9rlo2CI9uClxcNoOacHOI1WIImDJ879aG0Gd6jt+RgWlQP+YZx5AiyV+qZeixEU
	 XG/gaaqpBxKUUcsbzqtrZlxZDolirm9fJSKqW0oE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728022AbfCEN6K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 08:58:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:39114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727751AbfCEN6G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 08:58:06 -0500
Received: from devnote (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5DEF420842;
        Tue,  5 Mar 2019 13:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551794286;
        bh=axca7RM4SN0gehRdBNyzipIsMfpZazaIVF9gG36Q4ys=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OAJyOcYgJ44XdEGMl7EtEAsowKWCC/6gLwXmlCmsMDD7I4+ptG4Bvu5PmHWpRpGJ1
         rmvDxarPyhVnwKLuPddRke5xkmPuZyE5QWA43zUBqEUG+Q+8IMiEuFgX2wzOknpvLb
         R93lZ9OB48C4ifYlTKjMzEXVWrkJVhWzzDikwRQM=
Date:   Tue, 5 Mar 2019 22:58:01 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        kernel test robot <lkp@intel.com>,
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
        Joel Fernandes <joel@joelfernandes.org>, yhs@fb.com, lkp@01.org
Subject: Re: [uaccess] 780464aed0:
 WARNING:at_arch/x86/include/asm/uaccess.h:#strnlen_user/0x
Message-Id: <20190305225801.a63ac8712105ab2e673be1bc@kernel.org>
In-Reply-To: <20190305090729.GF32477@hirez.programming.kicks-ass.net>
References: <155136980507.2968.15165201054223875356.stgit@devbox>
        <20190303173954.kliegojbuigqi5tn@inn2.lkp.intel.com>
        <CAHk-=wij8VLupHh1U-fFhFBjin9Fch3mG2_2=aL9h1L+WBvm2g@mail.gmail.com>
        <20190304101434.8429ffffb17813c0e7930130@kernel.org>
        <CAHk-=whYMvevgF4yh7uhQug=Wt1A1Eg7abyM=RCi=bQiqiMBvQ@mail.gmail.com>
        <20190304180610.2d4f6f08d9ad89d6abae3597@kernel.org>
        <CAHk-=wiQM84VsAiw92UWyQZTQxr+F032Gm5BiFBXk7tC+LQohQ@mail.gmail.com>
        <20190305113635.18f80ea3b1f4fca54b9d21e4@kernel.org>
        <20190305090729.GF32477@hirez.programming.kicks-ass.net>
X-Mailer: Sylpheed 3.5.0 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Mar 2019 10:07:29 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> On Tue, Mar 05, 2019 at 11:36:35AM +0900, Masami Hiramatsu wrote:
> > I think the better way to do this is allowing strncpy_from_user()
> O
> > if some conditions are match, like
> > 
> >  - strncpy_from_user() will be able to copy user memory with set_fs(USER_DS)
> >  - strncpy_from_user() can copy kernel memory with set_fs(KERNEL_DS)
> >  - strncpy_from_user() can access unsafe memory in IRQ context if
> >    pagefault is disabled.
> > 
> > This is almost done, except for CONFIG_DEBUG_ATOMIC_SLEEP=y on x86.
> > 
> > So, what about adding a condition to WARN_ON_IN_IRQ() like below
> > instead of introducing user_access_ok() ?
> > 
> > diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
> > index 780f2b42c8ef..ec0f0b74c9ab 100644
> > --- a/arch/x86/include/asm/uaccess.h
> > +++ b/arch/x86/include/asm/uaccess.h
> > @@ -70,7 +70,7 @@ static inline bool __chk_range_not_ok(unsigned long addr, unsigned long size, un
> >  })
> >  
> >  #ifdef CONFIG_DEBUG_ATOMIC_SLEEP
> > -# define WARN_ON_IN_IRQ()      WARN_ON_ONCE(!in_task()) 
> > +# define WARN_ON_IN_IRQ()      WARN_ON_ONCE(pagefault_disabled() && !in_task())
> 
> That doesn't make any kind of sense to me; see faulthandler_disabled().
> IOW. interrupt (and any atomic context really) won't take faults anyway.

Hmm, I thought CONFIG_DEBUG_ATOMIC_SLEEP=y tries to detect that some operations
which can sleep in atomic, like IRQ context, doesn't it?
(note that above should be !pagefault_disabled() anyway) 

So I guessed WARN_ON_IN_IRQ() intended to detect the access_ok() was used
in atomic, because it might follow some copy_from_user() like operation
which can sleep when it hits a pagefault. Is my guess wrong?

If correct, I think if pagefault is disabled, the caller never sleep,
so we don't need to take care of that.

Could you tell me why WARN_ON_ONCE(!in_task()) is needed in access_ok()?

> 
> I dislike that whole KERNEL_DS thing, but obviously that's not something
> that's going away.
> 
> Would something like:
> 
> 	WARN_ON_ONCE(!(in_task || segment_eq(get_fs(), USER_DS)))
> 
> Work? Then we allow KERNEL_DS in task context, but for interrupt and
> others require USER_DS.

But what would this mean? I can't understand why we limit using
access_ok() so strictly and narrow the cases.

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
