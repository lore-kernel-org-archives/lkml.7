Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D9F3C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 12:20:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F96D22DA8
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 12:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566303654;
	bh=G5xwXtXC6eKSccjeQBgi5kYARnoflqjoRRwzQum4r2E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jL0ZosGGkhK42l2ezprptP2LKgv+q8WQgro/CghPQhLrweTiIjDmComcce6KrcpMz
	 +leIij8SsyD+uyNuNwIqQ4A5dF4Is+x488f+oQ0Di4TBzXaq3n0n/oVxcCzibLUUI7
	 Icc+NhxLUcq2PhYNldEtnY5znsCL3JrADcoVyOKM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729298AbfHTMUx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 08:20:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:60338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727006AbfHTMUx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 08:20:53 -0400
Received: from localhost (lfbn-ncy-1-174-150.w83-194.abo.wanadoo.fr [83.194.254.150])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C54EA22CE3;
        Tue, 20 Aug 2019 12:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566303652;
        bh=G5xwXtXC6eKSccjeQBgi5kYARnoflqjoRRwzQum4r2E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U98zb5kYCZL5UIJpBwBFu63Pis+PAk6FYfIHxPHQ7bMubLguLBKzwRjH9xyn8a7ub
         O99g9etExoI5qQGDYngsmJx6OtZHGEHFkz5Ko/D0r2BoUrU51ZKGt5v56z45rXcEKI
         1HO405m3sW5FZLLB//ihdQMIiP0oA9Pg1Hs7TOfw=
Date:   Tue, 20 Aug 2019 14:20:50 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: Re: [patch 01/44] posix-timers: Cleanup forward declarations and
 includes
Message-ID: <20190820122049.GB2093@lenoir>
References: <20190819143141.221906747@linutronix.de>
 <20190819143801.472005793@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190819143801.472005793@linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 19, 2019 at 04:31:42PM +0200, Thomas Gleixner wrote:
>  - Rename struct siginfo to kernel_siginfo

That's fine because struct siginfo isn't actually used in that
header, right?

>  - Add a forward declaration for task_struct and remove sched.h include
>  - Remove timex.h include as it is not needed
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  include/linux/posix-timers.h |    5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> --- a/include/linux/posix-timers.h
> +++ b/include/linux/posix-timers.h
> @@ -4,11 +4,10 @@
>  
>  #include <linux/spinlock.h>
>  #include <linux/list.h>
> -#include <linux/sched.h>
> -#include <linux/timex.h>
>  #include <linux/alarmtimer.h>
>  
> -struct siginfo;
> +struct kernel_siginfo;
> +struct task_struct;
>  
>  struct cpu_timer_list {
>  	struct list_head entry;
> 
> 
