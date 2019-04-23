Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 087FEC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 11:13:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEB4521773
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 11:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556017985;
	bh=BTKwJGRiLwmfknCOhXghpVYELn82P8euKZJJkKKHcRw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=K5Gx1WmUhUA8UbrVLBTZUWdn3+0RCyTapm81M2KCM/pcaNUGd6U56J+B+EAIs0Gpf
	 o6g1SLYu/bWNu327pMhPznu3fGEAQejPAlaazXPqs8pJuIPbdBXlBCFHSskIq5IA6u
	 0ByLLF3W+5fbKhs32z8Z+Izv9ACA2+D93W2c8I78=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727582AbfDWLNE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 07:13:04 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53178 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726033AbfDWLNE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 07:13:04 -0400
Received: by mail-wm1-f65.google.com with SMTP id j13so2569313wmh.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 04:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TLUlRuZbFhVJGmiQnB4jF8cMu6m612S38kK/ExgJkJM=;
        b=AWlAfAj7JN/Ih+xJJW0uh47OEdvTFog+3OZs6Y6vsIxAMTs10cFoR6CARSmYccLKSN
         kyWPPBNXwvrFnYUQaBPNKHhIw+5dhrPnVQnRRP5DF5FnYpRc/iZoNBmFLPKZtdLflmXq
         qbGaP3ZSCvC2MndH4n/C/gHJpMr2xf4wn8GLH394yL8pCN+WwdvmqPtdSxe8MRiW6Bq6
         MB9aGdIDXGucWL2wi+eth0L4VpdyWYmaWiLZvj/180wQSGHHg9cHrjfkwhcI5NCUxGR0
         9cu6XKwW/MAGRfIaMCYpk7nEEL5NQCgBmRcsSaFNWlH0+iilVItNYgzzIuX/vRL0qpqn
         pZVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=TLUlRuZbFhVJGmiQnB4jF8cMu6m612S38kK/ExgJkJM=;
        b=TFbcLfBII9pQfZRrrBEsMuYsVyN6NAKO9JgejrmUyePurSErHMZ8MrsTcN9NEwpbll
         7I2nL2cxI9emKb0cUdDomyG7sdS4sl8ywfBlu1DTE1hIuP/+cUwOag3Vc4U9TEhgTbM8
         CfiPVDDp/0Yqr1tSXILH5cFJQ+4COMo6/i1tuc22rJeVN3L4O0AhcWad9voLMnHNxx28
         A1mtYbA1c4zbCRsebW01sd/B96uimV3Xq+FvPhWOMSi45L2PfS3/DqCl5S9mqZ86C/8C
         8EL+Si7jSTceg5ayHVmV9mIf9tUB+/yI7f9BDIw//xkdLpw/wQK1oAmVGKlc+lShsVJT
         gNQA==
X-Gm-Message-State: APjAAAXMbU6dZEAiGfH9mrrkBYyuuo0THZLJ1PtX1QERn1IhoTCH3S3U
        Sskqpt3XPKOUB58wFFlWKis=
X-Google-Smtp-Source: APXvYqwUCYxJnQC9ZM5W8sBiA94NqNnkt8ERcuBi4/zvRqXuNU8+Do02pg2sdvXDi4M40aoz8Xuy4A==
X-Received: by 2002:a1c:21c1:: with SMTP id h184mr1951768wmh.128.1556017981935;
        Tue, 23 Apr 2019 04:13:01 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id i17sm15196597wrs.44.2019.04.23.04.13.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Apr 2019 04:13:01 -0700 (PDT)
Date:   Tue, 23 Apr 2019 13:12:58 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] x86_64: uninline TASK_SIZE
Message-ID: <20190423111258.GA23410@gmail.com>
References: <20190421160600.GA31092@avx2>
 <20190421182842.GD35603@gmail.com>
 <8B42CD57-9343-4234-A96D-80337BFFDF0E@zytor.com>
 <20190421211007.GA30444@avx2>
 <20190422103449.GA75723@gmail.com>
 <BFD71398-0BDC-4045-91E9-C70A22FF6E73@amacapital.net>
 <20190422220948.GB26031@avx2>
 <CALCETrWqPStQqv2xCJZLzsqTE-9L9U08CMApWyKD1zwjrrH4ow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrWqPStQqv2xCJZLzsqTE-9L9U08CMApWyKD1zwjrrH4ow@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Andy Lutomirski <luto@kernel.org> wrote:

> > Saving 2KB on a defconfig is quite a lot.
> 
> Saving 2kB of text by adding 8 bytes to thread_info seems rather
> dubious to me.  You only need 256 tasks before you lose.  My
> not-particularly-loaded laptop has 865 tasks right now.

I was suggesting current->task_size or thread_info->task_size as a way to 
100% avoid the function call overhead. Worth a tiny amount of RAM - even 
with 1 million tasks it's only 4MB of RAM. ;-)

Some TASK_SIZE users are prominent syscalls: mmap(), 

> As a general principle, the mere existence of TIF_ADDR32 is a bug. The 
> value of that flag is *wrong* under the 32-bit variant of CRIU. How 
> about instead making some more progress toward getting rid of dubious 
> TASK_SIZE users?  I'm working on a little series to get rid of most of 
> them.  Meanwhile: it sure looks like a large fraction of the users are 
> confused as to whether TASK_SIZE is the highest user address or the 
> lowest non-user address.

I really like that, replacing TASK_SIZE with *nothing* would be even 
faster.

In fact instead of just reducing its usage I'd suggest removing TASK_SIZE 
altogether and renaming TASK_SIZE_MAX back to TASK_SIZE, or something 
like that - the confusion from the deceptively macro-ish naming of 
TASK_SIZE is real.

The original commit of making TASK_SIZE dynamic on the task's compat flag 
was done in:

  84929801e14d: [PATCH] x86_64: TASK_SIZE fixes for compatibility mode processes

Here's the justification given:

    Appended patch will setup compatibility mode TASK_SIZE properly.  This will
    fix atleast three known bugs that can be encountered while running
    compatibility mode apps.
    
    a) A malicious 32bit app can have an elf section at 0xffffe000.  During
       exec of this app, we will have a memory leak as insert_vm_struct() is
       not checking for return value in syscall32_setup_pages() and thus not
       freeing the vma allocated for the vsyscall page.  And instead of exec
       failing (as it has addresses > TASK_SIZE), we were allowing it to
       succeed previously.
    
    b) With a 32bit app, hugetlb_get_unmapped_area/arch_get_unmapped_area
       may return addresses beyond 32bits, ultimately causing corruption
       because of wrap-around and resulting in SEGFAULT, instead of returning
       ENOMEM.
    
    c) 32bit app doing this below mmap will now fail.
    
      mmap((void *)(0xFFFFE000UL), 0x10000UL, PROT_READ|PROT_WRITE,
            MAP_FIXED|MAP_PRIVATE|MAP_ANON, 0, 0);

I believe a) is addressed by getting rid of the vsyscall page - but it 
might also not be a current problem because the vsyscall page has its own 
gate-vma now.

b) shouldn't be an issue if the mmap allocator correctly treats the 
compat bit - this doesn't require generic TASK_SIZE variations though, as 
the mmap allocator is already specific to arch/x86/.

c) is a variant of a) I believe, which should be fixed by now.

I just looked through some of the current TASK_SIZE users, and *ALL* of 
them seem dubious to me, with the exception of the mmap allocators. In 
fact some of them seem to be active bugs:

kernel/:

 - PR_SET_MM_MAP, PR_SET_MM_MAP_SIZE, prctl_set_mm() et al. Ugh, what a 
   nasty prctl()! But besides that, the TASK_SIZE restriction to the ABI 
   looks questionable: if we offer this CRIU functionality then why 
   should it be impossible for a 32-bit CRIU task to switch to 64-bit?

 - kernel/events/core.c: TASK_SIZE_MAX should be a fine filter here, in 
   fact it's probably *wrong* to restrict the profiling data here just 
   because the task happens to be in 32-bit compat mode.

 - kernel/rseq.c: is this TASK_SIZE restriction even required, wouldn't 
   TASK_SIZE_MAX be sufficient?

mm/:

 - GUP's get_get_area() et al looks really weird - why do we special-case 
   vsyscalls:

      - Can we get rid of the vsyscall page in modern kernels?

      - I don't think anyone runs those ancient glibc versions with a 
        fresh kernel anymore - can we start generating a WARN()ing 
        perhaps to see whether there's any complaints?

      - Or at least pretend it doesn't exist in terms of a GUP target page?

 - mm/kasan/generic_report.c:get_wild_bug_type() - this can use 
   TASK_SIZE_MAX just fine IMHO.

 - mm/mempolicy.c:mpol_shared_policy_init() - unsure, but I suspect we 
   can just create the pseudo-vma with a TASK_SIZE_MAX vm_end just fine.

 - mm/mlock.c:mlockall() - I believe it could be considered an outright 
   *bug* if there any pages outside the 32-bit area and don't get mlocked 
   by mlockall, just because this is a compat task. Especially with the 
   CRIU prctl() having 64-bit vmas outside the 32-bit mappings is a real 
   possibility, right? I.e. TASK_SIZE_MAX would be the right solution 
   here.

To turn the argument around: beyond the memory allocators, which includes 
the mmap and huge-mmap variants plus the SysV shmem allocator, can we 
list all the places that absolutely *rely* on TASK_SIZE being TIF_ADDR32 
restricted on compat tasks? I couldn't find any.

So I concur 100% that most TASK_SIZE uses are questionable. In fact think 
84929801e14d was a mistake, and we should effectively revert it 
carefully, by:

 - First by moving almost all TASK_SIZE users over to TASK_SIZE_MAX, 
   analyzing and justifying the impact case by case.

 - Then making the mmap allocators compat compatible (ha) without relying 
   on TASK_SIZE.

 - Renaming TASK_SIZE back to TASK_SIZE_MAX and getting rid of the 
   TASK_SIZE and TASK_SIZE_MAX differentiation.

Or am I missing some complication?

Thanks,

	Ingo
