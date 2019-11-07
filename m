Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42CA1C5DF61
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 08:41:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09AE221D79
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 08:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573116103;
	bh=cnNuZRR8DoPDx3o+OOaW3QVXbueVz64PaaO3YLqoiOc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=j5jvfrB7p56HgZqSyYg7hRBdz2RqnBz227oMcMSI24FekiZoc+t1Eh+31G0GgtIKW
	 KarZhktYCarBCa62RwJr36Ey9EyRH7ymfISMSxGqCsrjh7icWHkazWVLSR7gn3IpZ3
	 hgv9uyD23nS+2RaHeX77iquAfGkh2j0iYJxJgWNQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733284AbfKGIll (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 03:41:41 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35973 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727300AbfKGIll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 03:41:41 -0500
Received: by mail-wr1-f66.google.com with SMTP id r10so2018325wrx.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 00:41:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xbyWc/DJqLH4rqqAp0MPTBp+HavJqMmW+l0ePiVYXRc=;
        b=FJ/dlMqTBdGUlwcQQtsZ/GU+lGszdgjvMukf+332caSNe5ELewYypqhFfDFRP08pCo
         33ETmXAfmC/SdiZgGOOvCkYn13BarlP8EHSvTddmFd/cGMRtkqOYCrHMnEVC7vEpIT9Z
         vPWbI5dO2zx1V2Sm1H3EQYY7jrPaG3G4lP+ML9LMA8KMGfd6pOmIB6CwyTsqI92AHxB6
         eaiSOm57BaUnn4adhGQEJ1ZTZtpygJ+y67zGT5ckt5GaTE1T1ynCbd2MTYfhz2VM9l6B
         X5HKq5rLyCDepYGQ4wqoko+3GsekLX/z2F7VlwLCRXXvUHEQ7U2DptOmeYG6dRSdhK1N
         VNhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=xbyWc/DJqLH4rqqAp0MPTBp+HavJqMmW+l0ePiVYXRc=;
        b=Z6n2T17t9RwtOP+ja/3LMRGA/zEOhuU7UPp6SxNAliIeoYp4BSpL17oHC7uxU0ccrF
         5rmOB1oMwHkPDFhVdcb82dBayyBOBztvGTvi5OgQenou46iwAUhyiZwkP9y7u6vX/zns
         UMVozv0LJaV+2YeVaoVmx9MVt10qMQYcu2gERrPjPISeQ8fnG1MOlOgtTJrTYdtVkGeC
         zDBEloy6xwgrponMbOlwaiXk801FDm/hGA2Q+mzxYIK3m8hlZNrS3zoOYotRgfFZMPSK
         t9X59QLuctv7BE0tqnxvNdK5kdjFs04znQl3WyHqW73N96ROUCeWy1ls0g2QaP6ymnvj
         t3cg==
X-Gm-Message-State: APjAAAWdJ0NPFAllk1PhJPKlELfQHQmr0i1ukqeLdhC03pJqY3bT3VCP
        yUFfBWErE4GfkhvEZ1xwGhY=
X-Google-Smtp-Source: APXvYqyRB8BHQr01igd27EvGS6zZoSs6jzXGiAzz29Pf9cWMQaYIDjxdKsFbVE05RAcaojky8CpOQg==
X-Received: by 2002:adf:ec4b:: with SMTP id w11mr1609520wrn.243.1573116099293;
        Thu, 07 Nov 2019 00:41:39 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id a8sm1309533wme.11.2019.11.07.00.41.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 00:41:38 -0800 (PST)
Date:   Thu, 7 Nov 2019 09:41:36 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <darren@dvhart.com>,
        Yi Wang <wang.yi59@zte.com.cn>,
        Yang Tao <yang.tao172@zte.com.cn>,
        Oleg Nesterov <oleg@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        Carlos O'Donell <carlos@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [patch 00/12] futex: Cure robust/PI futex exit races
Message-ID: <20191107084136.GH30739@gmail.com>
References: <20191106215534.241796846@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191106215534.241796846@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Thomas Gleixner <tglx@linutronix.de> wrote:

> This series addresses a couple of robust/PI futex exit races:
> 
>  1) The unlock races debugged and fixed by Yi and Yang
> 
>     These races are really subtle and I'm still puzzled how to trigger them
>     reliably enough to decode them.
> 
>     The basic issue is that:
> 
>     A) An unlocking task can be killed between clearing the user space
>        futex value and calling futex(FUTEX_WAKE).
> 
>     B) A woken up waiter can be killed before it can acquire the futex
>        after returning to user space.
> 
>     In both cases the futex value is 0 and due to that the robust list exit
>     code refuses to wake up waiters as the futex is not owned by the
>     exiting task. As a consequence all other waiters might be blocked
>     forever.
> 
>  2) Oleg provided a test case which causes an infinite loop in the
>     futex_lock_pi() code.
> 
>     The problem there is that an exiting task might be preempted by a
>     waiter in a state which makes the waiter busy wait for the exiting task
>     to complete the robust/PI exit cleanup code.
> 
>     That's obviously impossible when the waiter has higher priority than
>     the exiting task and both are pinned on the same CPU resulting in a
>     live lock.
> 
> #1 is a straight forward and simple fix 
> 
>     The solution Yi and Yang provided looks solid and in the worst case
>     causes a spurious wakeup of a waiter which is nothing to worry about
>     as all waiter code has to be prepared for that anyway.
> 
> #2 is more complex
> 
>    In the current implementation there is no way to block until the exiting
>    task has finished the cleanup.
> 
>    To fix this there is quite some code reshuffling required which at the
>    same time is a valuable cleanup.
> 
>    The final solution is to guard the futex exit handling with a per task
>    mutex and make the waiter block on that mutex until the exiting task has
>    the cleanup completed.
> 
>    Details why a simpler solution is not feasible can be found here:
> 
>    https://lore.kernel.org/r/20191105152728.GA5666@redhat.com
> 
>    Ignore my confusion of fork vs. vfork at the beginning of the thread.
>    Futexes do that to human brains. :)
> 
> The following series addresses both issues.
> 
> Patch 1 is a slightly polished version of the original Yi and Yang
> submission. It is included for completeness sake and because it
> creates conflicts with the larger surgery which fixes issue #2. 
> 
> Aside of that a few eyeballs more on that subtlety are definitely not
> a bad thing especially as this has a user space component in it.
> 
> The rest of the series addresses issue #2 which is more or less a kernel
> only problem, but extra eyeballs are appreciated.
> 
> I'm certainly not proud about the solution for #2 but it's the best I could
> come up with without violating the user/kernel state consistency
> constraints.

I really like the whole series - this is how it should have been 
implemented originally, but the exit scenarios 'looked' so simple so it 
was just open-coded ... Mea culpa. :-)

As to ->futex_exit_mutex: that's really just a consequence of the ABI, 
and a lot cleaner than all the previous pretense that these exit ops are 
atomic - which they fundamentally aren't.

Haven't tested the series beyond build coverage, but the high level 
principles behind the whole series look very sound to me:

Reviewed-by: Ingo Molnar <mingo@kernel.org>

Thanks,

	Ingo
