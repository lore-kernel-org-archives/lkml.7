Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0990C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:36:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1833205F4
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:36:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PN5mE7Vj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732413AbfDDJgX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:36:23 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49872 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730246AbfDDJgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:36:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=3XMO5fAxYesEEl2T8e3cy18NYVGQAhk14IiAJL4eKX8=; b=PN5mE7Vj+O4lcxwP2JWoOxUFy
        UDUZB/habKGEkMt3rl+AeJhZHm2mSmAwJpZvP3v1LebQva3rnidQgFk4cQUZwm3wAorMiEJTgNmqO
        WPWxMVR1+ykPzr/tiKsweS3X9h0bTmwL2u5TZkOgp5n5dQL4n/aQFtolzTi1vwpQAj9dj0YBC/nMP
        s+bIi76YKOsMDx6pY3eXEjhpU8HM3yN1plem9vpe8REG8lpqRy2Tp7Ij/5K6V8HBOulP2hJsYUStY
        XYVfo8cD22ipLY7OkhLLTsF0zhjIZ/Y15E8o2VF/Nis6M/rqJYIF5VqwQEchAvj0bDx6X0BoezoEH
        hhKEUDnRg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hByn0-0004Vj-Dj; Thu, 04 Apr 2019 09:36:06 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BFD3A2038C23E; Thu,  4 Apr 2019 11:36:04 +0200 (CEST)
Date:   Thu, 4 Apr 2019 11:36:04 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Will Deacon <will.deacon@arm.com>,
        Waiman Long <longman@redhat.com>, shenghui <shhuiw@foxmail.com>
Subject: Re: [PATCH v2] locking/lockdep: Zap lock classes even with lock
 debugging disabled
Message-ID: <20190404093604.GT4038@hirez.programming.kicks-ass.net>
References: <20190403233552.124673-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190403233552.124673-1-bvanassche@acm.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 03, 2019 at 04:35:52PM -0700, Bart Van Assche wrote:
> Commit a0b0fd53e1e6 ("locking/lockdep: Free lock classes that are no longer
> in use") changed the behavior of lockdep_free_key_range() from
> unconditionally zapping lock classes into only zapping lock classes if
> debug_lock == true. Not zapping lock classes if debug_lock == false leaves
> dangling pointers in several lockdep datastructures, e.g. lock_class::name
> in the all_lock_classes list. The shell command "cat /proc/lockdep" causes
> the kernel to iterate the all_lock_classes list. Hence the "unable to
> handle kernel paging request" issue that Shenghui encountered by running
> cat /proc/lockdep. Since the new behavior can cause cat /proc/lockdep to
> crash, restore the pre-v5.1 behavior.
> 
> This patch avoids that cat /proc/lockdep triggers the following crash
> with debug_lock == false:
> 
> BUG: unable to handle kernel paging request at fffffbfff40ca448
> PGD 13bfde067 P4D 13bfde067 PUD 13bf7a067 PMD 1167d3067 PTE 0
> Oops: 0000 [#1] PREEMPT SMP KASAN
> CPU: 4 PID: 4529 Comm: cat Tainted: G    B   W  O      5.1.0-rc1-dbg+ #4
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
> RIP: 0010:__asan_load1+0x28/0x50
> Call Trace:
>  string+0xac/0x180
>  vsnprintf+0x23e/0x820
>  seq_vprintf+0x82/0xc0
>  seq_printf+0x92/0xb0
>  print_name+0x34/0xb0
>  l_show+0x184/0x200
>  seq_read+0x59e/0x6c0
>  proc_reg_read+0x11f/0x170
>  __vfs_read+0x4d/0x90
>  vfs_read+0xc5/0x1f0
>  ksys_read+0xab/0x130
>  __x64_sys_read+0x43/0x50
>  do_syscall_64+0x71/0x210
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> 
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Waiman Long <longman@redhat.com>
> Cc: shenghui <shhuiw@foxmail.com>
> Reported-by: shenghui <shhuiw@foxmail.com>
> Fixes: a0b0fd53e1e6 ("locking/lockdep: Free lock classes that are no longer in use") # v5.1-rc1.
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>

Thanks!
