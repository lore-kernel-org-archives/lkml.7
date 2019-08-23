Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1230EC3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 09:16:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D610E233A0
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 09:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566551803;
	bh=ig1oY3Gk4hujplrVFJKMzN7PnrvQFo36iRWo+iWWqkQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=OISXnafjXBWC1W04f9CZqRh7uK8kU83pitIbgvXT1VHRRlBO4wk8VEhrvfkJ9RKSg
	 hDUdsEKeEWfFWZ2kofeq7rpwEnmq0PqfmNZmT5oCo7u+ToYWi0KrISW1M1Q0DBOgP/
	 c3OuSVUH58yK2iTfHfV7HBdTrlZMOykLG/YX7q8U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727431AbfHWJQn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 05:16:43 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36871 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727388AbfHWJQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 05:16:42 -0400
Received: by mail-wm1-f67.google.com with SMTP id d16so8388234wme.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2019 02:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Odks+ErX+hIA4ewl4ttjOOGrZDWZFdEEcirN8+AeNs8=;
        b=rhTX/afIXQTAHpDwoa5MH7lj/6sJJ1gqoaiSZucVEKf5iVZW+MCxJfUQd8YBiqJY6x
         at3m/4xcqEmwV505gX4IQuA0Qfr5mMbRP+PXP4Ct9Qnfr0WTqvLQihp2djuqtf5zRa1D
         XucR9eKWKKwYGZfLHfTC3YaWaePxCu3kQsdkn0vlHXLLoHKTg+50G/GV6+ScGEL3+dmQ
         sZQakmPtlqoP0ZYwL/XHJE90Ml360yN5nSlDW8wxG2bCXtzI9TbIGDZ04J9I9sdeKvhN
         ZMhGTa8l0cxfYl2GJup4Y4J7Ws/6qiuVbMuFybJ5EHMlwRyAGgm/OUz2ay+VUmIzZsa3
         AZYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Odks+ErX+hIA4ewl4ttjOOGrZDWZFdEEcirN8+AeNs8=;
        b=H9iIKUhFs9bS0ycBVHGGRBr9BoH/O2IfQJvdEolt3AWHABDHTs2E5Ata66iXdDtFAB
         qiKLXVXoEbzpiTZyJk/SeykNSj6184hg7ESFx1iU2nrhRwRL27tJ+Y6uhqX3RyYdh2J0
         Lbdhy2pufBBt1PjBONo/7pcyIkFrDyO6awU+aQx0/ErkekeC/whf34MCuyVRFhld5oqs
         MTVZ3NwCKfuU7qfxK6gT9kUiN/B1KaItgWdvzJHSFupqUUkvCdWbV/LwotIdxeAvL3Ns
         ogbNj7+vr8eDQAZe15uGOAgk5Z2OjNsB+QRvd5ugKv6/Pdxfvv2kKiHQhv80HAEVxptM
         suoA==
X-Gm-Message-State: APjAAAXklEvYHMCzzr0/4dnwkHx8pt4qd+fWnN5PfAKS/YsZjib+wstQ
        +4Nbvk/qNzzqKTcvB0PQz6o=
X-Google-Smtp-Source: APXvYqyC7WAZZ/iuT3W5IPij2we/v5r/wuqbKvnMdDKnNwdKb5zahmj0rDxv1+irC+6iZLaVVBnxRw==
X-Received: by 2002:a1c:3d89:: with SMTP id k131mr3698839wma.24.1566551799445;
        Fri, 23 Aug 2019 02:16:39 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id n9sm2466186wrx.76.2019.08.23.02.16.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2019 02:16:38 -0700 (PDT)
Date:   Fri, 23 Aug 2019 11:16:36 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        syzbot <syzbot+8ab2d0f39fb79fe6ca40@syzkaller.appspotmail.com>
Subject: Re: [PATCH] /dev/mem: Bail out upon SIGKILL when reading memory.
Message-ID: <20190823091636.GA10064@gmail.com>
References: <1566338811-4464-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <CAHk-=wjFsF6zmcDaBdpYEvCWiq=x7_NuQWEm=OinZ9TuQd4ZZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjFsF6zmcDaBdpYEvCWiq=x7_NuQWEm=OinZ9TuQd4ZZQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Tue, Aug 20, 2019 at 3:07 PM Tetsuo Handa
> <penguin-kernel@i-love.sakura.ne.jp> wrote:
> >
> > syzbot found that a thread can stall for minutes inside read_mem()
> > after that thread was killed by SIGKILL [1]. Reading 2GB at one read()
> > is legal, but delaying termination of killed thread for minutes is bad.
> 
> Side note: we might even just allow regular signals to interrupt
> /dev/mem reads. We already do that for /dev/zero, and the risk of
> breaking something is likely fairly low since nothing should use that
> thing anyway.
> 
> Also, if it takes minutes to delay killing things, that implies that
> we're probably still faulting in pages for the read_mem(). Which
> points to another possible thing we could do in general: just don't
> bother to handle page faults when a fatal signal is pending.
> 
> That situation might happen for other random cases too, and is not
> limited to /dev/mem. So maybe it's worth trying? Does that essentially
> fix the /dev/mem read case too in practice?
> 
> COMPLETELY untested patch attached, it may or may not make a
> difference (and it may or may not work at all ;)
> 
>                 Linus

>  arch/x86/mm/fault.c | 15 ++++++++++++---
>  mm/memory.c         |  5 +++++
>  2 files changed, 17 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
> index 9ceacd1156db..d6c029a6cb90 100644
> --- a/arch/x86/mm/fault.c
> +++ b/arch/x86/mm/fault.c
> @@ -1033,8 +1033,15 @@ static noinline void
>  mm_fault_error(struct pt_regs *regs, unsigned long error_code,
>  	       unsigned long address, vm_fault_t fault)
>  {
> -	if (fatal_signal_pending(current) && !(error_code & X86_PF_USER)) {
> -		no_context(regs, error_code, address, 0, 0);
> +	/*
> +	 * If we already have a fatal signal, don't bother adding
> +	 * a new one. If it's a kernel access, just make it fail,
> +	 * and if it's a user access just return to let the process
> +	 * die.
> +	 */
> +	if (fatal_signal_pending(current)) {
> +		if (!(error_code & X86_PF_USER))
> +			no_context(regs, error_code, address, 0, 0);

Since the 'signal' parameter to no_context() is 0, will there be another 
signal generated? I don't think so - so the comment looks wrong to me, 
unless I'm missing something.

Other than that, what we are skipping here if a KILL signal is pending is 
the printout of oops information if the fault is a kernel one.

Not sure that's a good idea in general: carefully timing a KILL signal 
would allow the 'stealth probing' of otherwise oops generating addresses? 
Arguably it would only be a marginally useful facility to any attacker, 
but it doesn't feel right to me to skip the printing of bad faults if 
they occur.

I.e. I'm not sure this hunk is necessary or even a good idea.



>  		return;
>  	}
>  
> @@ -1389,7 +1396,8 @@ void do_user_addr_fault(struct pt_regs *regs,
>  			return;
>  		}
>  retry:
> -		down_read(&mm->mmap_sem);
> +		if (down_read_killable(&mm->mmap_sem))
> +			goto fatal_signal;
>  	} else {
>  		/*
>  		 * The above down_read_trylock() might have succeeded in
> @@ -1455,6 +1463,7 @@ void do_user_addr_fault(struct pt_regs *regs,
>  				goto retry;
>  		}
>  
> +fatal_signal:
>  		/* User mode? Just return to handle the fatal exception */
>  		if (flags & FAULT_FLAG_USER)
>  			return;
> diff --git a/mm/memory.c b/mm/memory.c
> index e2bb51b6242e..7ad62f96b08e 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -3988,6 +3988,11 @@ vm_fault_t handle_mm_fault(struct vm_area_struct *vma, unsigned long address,
>  					    flags & FAULT_FLAG_REMOTE))
>  		return VM_FAULT_SIGSEGV;
>  
> +	if (flags & FAULT_FLAG_KILLABLE) {
> +		if (fatal_signal_pending(current))
> +			return VM_FAULT_SIGSEGV;
> +	}
> +
>  	/*
>  	 * Enable the memcg OOM handling for faults triggered in user
>  	 * space.  Kernel faults are handled more gracefully.

This part looks good to me, assuming someone tests it and it solves the 
bug :-)

Acked-by: Ingo Molnar <mingo@kernel.org>

Thanks,

	Ingo
