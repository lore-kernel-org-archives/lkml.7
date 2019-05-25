Return-Path: <SRS0=wu79=TZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC319C282E5
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 08:45:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B1572133D
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 08:45:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbfEYIpz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 May 2019 04:45:55 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:44474 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726376AbfEYIpz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 May 2019 04:45:55 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1hUSJH-0001zt-6b; Sat, 25 May 2019 10:45:47 +0200
Date:   Sat, 25 May 2019 10:45:46 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Borislav Petkov <bp@suse.de>,
        Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] mm/gup: continue VM_FAULT_RETRY processing event for
 pre-faults
Message-ID: <20190525084546.fap2wkefepeia22f@linutronix.de>
References: <1557844195-18882-1-git-send-email-rppt@linux.ibm.com>
 <20190522122113.a2edc8aba32f0fad189bae21@linux-foundation.org>
 <20190522194322.5k52docwgp5zkdcj@linutronix.de>
 <alpine.LSU.2.11.1905241429460.1141@eggly.anvils>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.11.1905241429460.1141@eggly.anvils>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-05-24 15:22:51 [-0700], Hugh Dickins wrote:
> I've now run a couple of hours of load successfully with Mike's patch
> to GUP, no problem; but whatever the merits of that patch in general,
> I agree with Andrew that fault_in_pages_writeable() seems altogether
> more appropriate for copy_fpstate_to_sigframe(), and have now run a
> couple of hours of load successfully with this instead (rewrite to taste):

so this patch instead of Mike's GUP patch fixes the issue you observed?
Is this just a taste question or limitation of the function in general?

I'm asking because it has been suggested and is used in MPX code (in the
signal path but .mmap) and I'm not aware of any limitation. But as I
wrote earlier to akpm, if the MM folks suggest to use this instead I am
happy to switch.

> --- 5.2-rc1/arch/x86/kernel/fpu/signal.c
> +++ linux/arch/x86/kernel/fpu/signal.c
> @@ -3,6 +3,7 @@
>   * FPU signal frame handling routines.
>   */
>  
> +#include <linux/pagemap.h>
>  #include <linux/compat.h>
>  #include <linux/cpu.h>
>  
> @@ -189,15 +190,7 @@ retry:
>  	fpregs_unlock();
>  
>  	if (ret) {
> -		int aligned_size;
> -		int nr_pages;
> -
> -		aligned_size = offset_in_page(buf_fx) + fpu_user_xstate_size;
> -		nr_pages = DIV_ROUND_UP(aligned_size, PAGE_SIZE);
> -
> -		ret = get_user_pages_unlocked((unsigned long)buf_fx, nr_pages,
> -					      NULL, FOLL_WRITE);
> -		if (ret == nr_pages)
> +		if (!fault_in_pages_writeable(buf_fx, fpu_user_xstate_size))
>  			goto retry;
>  		return -EFAULT;
>  	}
> 
> (I did wonder whether there needs to be an access_ok() check on buf_fx;
> but if so, then I think it would already have been needed before the
> earlier copy_fpregs_to_sigframe(); but I didn't get deep enough into
> that to be sure, nor into whether access_ok() check on buf covers buf_fx.)

There is an access_ok() at the begin of copy_fpregs_to_sigframe(). The
memory is allocated from user's stack and there is (later) an
access_ok() for the whole region (which can be more than the memory used
by the FPU code).

> Hugh

Sebastian
