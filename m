Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19169C00319
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 08:22:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD4C320842
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 08:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551774169;
	bh=Xyq8EGBEULgsSRBn/tVhdClVUK+CL2ExTD94fLkdPak=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=i94mFmfU3POsWArDLUbEpevusOVfXcsggM/9+PKBWvi8UKzTIqP/1Sqgn3GVMAlDV
	 wEY8lD8+RjubRkJ+PXvUrwNGUV9JGiQEA1HRwp07QjFKmYjVt0F7XqypOrF2ozrtIK
	 Lsfax4omP7cyai3qH61Ix6yOscYE1dzV5Krkr5wY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727146AbfCEIWs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 03:22:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:46512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726995AbfCEIWr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 03:22:47 -0500
Received: from devnote (p218086-mobac01.tokyo.ocn.ne.jp [153.233.209.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C3BC9206DD;
        Tue,  5 Mar 2019 08:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551774166;
        bh=Xyq8EGBEULgsSRBn/tVhdClVUK+CL2ExTD94fLkdPak=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=n3J2auzM3LFuPtNXAm77yrAK/EbBlgYHNj6uZi0AOnpJBn9kGkPEG5LWkSzU9nqtM
         7U8w+llYVrnH0HBq58dOK0AgaPMunB1dru06roHSNgpire1VmgsoNZJIFYJCb/wHiW
         BJ51cFeLl6TNgEuSeVpUQErtunewzFKGiStNGw1s=
Date:   Tue, 5 Mar 2019 17:22:41 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
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
Message-Id: <20190305172241.2eef39c6ca74d09120bbbcad@kernel.org>
In-Reply-To: <20190305113635.18f80ea3b1f4fca54b9d21e4@kernel.org>
References: <155136980507.2968.15165201054223875356.stgit@devbox>
        <20190303173954.kliegojbuigqi5tn@inn2.lkp.intel.com>
        <CAHk-=wij8VLupHh1U-fFhFBjin9Fch3mG2_2=aL9h1L+WBvm2g@mail.gmail.com>
        <20190304101434.8429ffffb17813c0e7930130@kernel.org>
        <CAHk-=whYMvevgF4yh7uhQug=Wt1A1Eg7abyM=RCi=bQiqiMBvQ@mail.gmail.com>
        <20190304180610.2d4f6f08d9ad89d6abae3597@kernel.org>
        <CAHk-=wiQM84VsAiw92UWyQZTQxr+F032Gm5BiFBXk7tC+LQohQ@mail.gmail.com>
        <20190305113635.18f80ea3b1f4fca54b9d21e4@kernel.org>
X-Mailer: Sylpheed 3.5.0 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Mar 2019 11:36:35 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> On Mon, 4 Mar 2019 10:59:22 -0800
> Linus Torvalds <torvalds@linux-foundation.org> wrote:
> 
> I think the better way to do this is allowing strncpy_from_user()
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

Oops, I meant !pagefault_disabled() && !in_task().

>  #else
>  # define WARN_ON_IN_IRQ()
>  #endif
> 
> Of course we have to move pagefault_disabled() macro in somewhere better place.

And I think we don't need it. anyway the macro is referenced via linux/uaccess.h.

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
