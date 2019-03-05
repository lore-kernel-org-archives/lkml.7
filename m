Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0247CC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 09:07:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5CCE20848
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 09:07:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CbUxnz9M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727131AbfCEJH5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 04:07:57 -0500
Received: from merlin.infradead.org ([205.233.59.134]:57682 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbfCEJH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 04:07:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=C69eDiEB7D7z/Vfa3n3d0LLxb19gtv1PyelxonksJgM=; b=CbUxnz9MRTtTfVa9HAJx7lw16
        aJFVa5nyrfIag8anKepyvAPcFlobSUXERVYdH0ereoEUZUqdM218m/WdkO7Za0mD4kjg+aP9fwKGZ
        0nULNYPzQl1Z5IPUaRuwwLcMdPLwNxeTCjOcvzggxkdsNg0205IZnST2eAmrjq1vpoGZeRhFp5jEt
        X6zKQrwX2t9ghpR0euHVp8sVtykC9RzxygsdXdKdNSqEAN06k9jq/ERwbZ+KJITISc6KBxdh2jNYR
        wdbNYjMcO7cwXQpYvW8gW6j/CtHPZdkrtFjLisxi4HkxBuc8tRCCECGFAKsvShX9XmHBoETyvgRST
        paWoOkayg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h162u-0004KK-61; Tue, 05 Mar 2019 09:07:32 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A376D29B17DEE; Tue,  5 Mar 2019 10:07:29 +0100 (CET)
Date:   Tue, 5 Mar 2019 10:07:29 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
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
Message-ID: <20190305090729.GF32477@hirez.programming.kicks-ass.net>
References: <155136980507.2968.15165201054223875356.stgit@devbox>
 <20190303173954.kliegojbuigqi5tn@inn2.lkp.intel.com>
 <CAHk-=wij8VLupHh1U-fFhFBjin9Fch3mG2_2=aL9h1L+WBvm2g@mail.gmail.com>
 <20190304101434.8429ffffb17813c0e7930130@kernel.org>
 <CAHk-=whYMvevgF4yh7uhQug=Wt1A1Eg7abyM=RCi=bQiqiMBvQ@mail.gmail.com>
 <20190304180610.2d4f6f08d9ad89d6abae3597@kernel.org>
 <CAHk-=wiQM84VsAiw92UWyQZTQxr+F032Gm5BiFBXk7tC+LQohQ@mail.gmail.com>
 <20190305113635.18f80ea3b1f4fca54b9d21e4@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190305113635.18f80ea3b1f4fca54b9d21e4@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 05, 2019 at 11:36:35AM +0900, Masami Hiramatsu wrote:
> I think the better way to do this is allowing strncpy_from_user()
O
> if some conditions are match, like
> 
>  - strncpy_from_user() will be able to copy user memory with set_fs(USER_DS)
>  - strncpy_from_user() can copy kernel memory with set_fs(KERNEL_DS)
>  - strncpy_from_user() can access unsafe memory in IRQ context if
>    pagefault is disabled.
> 
> This is almost done, except for CONFIG_DEBUG_ATOMIC_SLEEP=y on x86.
> 
> So, what about adding a condition to WARN_ON_IN_IRQ() like below
> instead of introducing user_access_ok() ?
> 
> diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
> index 780f2b42c8ef..ec0f0b74c9ab 100644
> --- a/arch/x86/include/asm/uaccess.h
> +++ b/arch/x86/include/asm/uaccess.h
> @@ -70,7 +70,7 @@ static inline bool __chk_range_not_ok(unsigned long addr, unsigned long size, un
>  })
>  
>  #ifdef CONFIG_DEBUG_ATOMIC_SLEEP
> -# define WARN_ON_IN_IRQ()      WARN_ON_ONCE(!in_task())
> +# define WARN_ON_IN_IRQ()      WARN_ON_ONCE(pagefault_disabled() && !in_task())

That doesn't make any kind of sense to me; see faulthandler_disabled().
IOW. interrupt (and any atomic context really) won't take faults anyway.

I dislike that whole KERNEL_DS thing, but obviously that's not something
that's going away.

Would something like:

	WARN_ON_ONCE(!(in_task || segment_eq(get_fs(), USER_DS)))

Work? Then we allow KERNEL_DS in task context, but for interrupt and
others require USER_DS.
