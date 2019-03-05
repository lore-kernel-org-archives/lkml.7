Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF0F0C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 15:18:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C05A52087C
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 15:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551799098;
	bh=wOUquXm9gpv0TOxJKPQvY2wkA5/USc7lFJmXyQtma0A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=FwDifZKdtWiwzCQ6iFa6iQXZVqxVNq8OeIlpO2vYMuxhfXbdGYvNYxpiE9ZZF5xC5
	 /Nl7wpdTabj3iSNpB+/+WohIH3/zMq1axbqxMJyZ0UtF/DoJCoic1oIIdyIOaYqRBa
	 P4rA1xkxWrzq3IVODqlLD5bEQwGGxZq1/YLTtX44=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728689AbfCEPSR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 10:18:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:40974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727114AbfCEPSR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 10:18:17 -0500
Received: from devnote (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 22F2920848;
        Tue,  5 Mar 2019 15:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551799095;
        bh=wOUquXm9gpv0TOxJKPQvY2wkA5/USc7lFJmXyQtma0A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cl3g1kYHSzeKeX5Jg/5jvFh5H9MS6wZWE4NjQyxObCyJuUoZOP7Co2BBe3dQyHCRo
         Bdwf9QCzll9D/OqbOzZ5NF8E945Nnx87YgkwS7piFLTGQt5WLLkT4zzA4X3TiFF5oP
         FowaI9V8yP3KlYzwG4snBNTVYC+PzwVHlOJuIflo=
Date:   Wed, 6 Mar 2019 00:18:11 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     g@hirez.programming.kicks-ass.net,
        Linus Torvalds <torvalds@linux-foundation.org>,
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
Message-Id: <20190306001811.c7cf77cb26b9d816a7561e7b@kernel.org>
In-Reply-To: <20190305145306.GL32477@hirez.programming.kicks-ass.net>
References: <155136980507.2968.15165201054223875356.stgit@devbox>
        <20190303173954.kliegojbuigqi5tn@inn2.lkp.intel.com>
        <CAHk-=wij8VLupHh1U-fFhFBjin9Fch3mG2_2=aL9h1L+WBvm2g@mail.gmail.com>
        <20190304101434.8429ffffb17813c0e7930130@kernel.org>
        <CAHk-=whYMvevgF4yh7uhQug=Wt1A1Eg7abyM=RCi=bQiqiMBvQ@mail.gmail.com>
        <20190304180610.2d4f6f08d9ad89d6abae3597@kernel.org>
        <CAHk-=wiQM84VsAiw92UWyQZTQxr+F032Gm5BiFBXk7tC+LQohQ@mail.gmail.com>
        <20190305113635.18f80ea3b1f4fca54b9d21e4@kernel.org>
        <20190305090729.GF32477@hirez.programming.kicks-ass.net>
        <20190305225801.a63ac8712105ab2e673be1bc@kernel.org>
        <20190305145306.GL32477@hirez.programming.kicks-ass.net>
X-Mailer: Sylpheed 3.5.0 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Mar 2019 15:53:06 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> On Tue, Mar 05, 2019 at 10:58:01PM +0900, Masami Hiramatsu wrote:
> 
> > Could you tell me why WARN_ON_ONCE(!in_task()) is needed in access_ok()?
> 
> That came from here:
> 
>   lkml.kernel.org/r/20190225145240.GB32534@hirez.programming.kicks-ass.net
> 
> Because in-irq usage is dodgy, since we don't actually know what mm or
> ds it loaded.

Yes, I would like to allow it only if setting pagefault-disable correctly.
(and setting ds too, it is good to me)

> 
> > > I dislike that whole KERNEL_DS thing, but obviously that's not something
> > > that's going away.
> > > 
> > > Would something like:
> > > 
> > > 	WARN_ON_ONCE(!(in_task || segment_eq(get_fs(), USER_DS)))
> > > 
> > > Work? Then we allow KERNEL_DS in task context, but for interrupt and
> > > others require USER_DS.
> > 
> > But what would this mean? I can't understand why we limit using
> > access_ok() so strictly and narrow the cases.
> 
> Because it's been a source of bugs. Any sanity checking we can put in
> seems like a good thing at this point.

Hmm, I see yours is strict, fit with current code, but complicated rule.

 - strncpy_from_user() can access user memory with set_fs(USER_DS) 
   in task context

 - strncpy_from_user() can access kernel memory with set_fs(KERNEL_DS) 
   in task context

 - strncpy_from_user() can access user memory in IRQ context if
   pagefault is disabled and with set_fs(USER_DS). (but pagefault-disabled
   is not verified)

 - strncpy_from_user() never allowed to access kernel memory in IRQ context,
   even if pagefault is disabled and with set_fs(KERNEL_DS).


And mine is simple.

 - strncpy_from_user() can access user memory with set_fs(USER_DS)
   in task context

 - strncpy_from_user() can access kernel memory with set_fs(KERNEL_DS)
   in task context

 - strncpy_from_user() can access user/kernel memory (depends on DS)
   in IRQ context if pagefault is disabled. (both verified)


Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
