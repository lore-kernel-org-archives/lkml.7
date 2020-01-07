Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13208C33C9B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:12:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E437820880
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:12:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730155AbgAGVMD convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 16:12:03 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:47030 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730123AbgAGVLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 16:11:36 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1iow8U-0000TK-GS; Tue, 07 Jan 2020 22:11:34 +0100
Date:   Tue, 7 Jan 2020 22:11:34 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Borislav Petkov <bp@suse.de>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jann Horn <jannh@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Rik van Riel <riel@surriel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>, x86-ml <x86@kernel.org>
Subject: Re: [tip: x86/fpu] x86/fpu: Deactivate FPU state after failure
 during state load
Message-ID: <20200107211134.tckhc5knkthmjsj6@linutronix.de>
References: <157840155965.30329.313988118654552721.tip-bot2@tip-bot2>
 <FA0D2929-63D0-4473-A492-42227D7A5D98@amacapital.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <FA0D2929-63D0-4473-A492-42227D7A5D98@amacapital.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-01-07 10:41:52 [-1000], Andy Lutomirski wrote:
> Wow, __fpu__restore_sig is a mess. We have __copy_from... that is
> Obviously Incorrect (tm) even though it’s not obviously exploitable.
> (It’s wrong because the *wrong pointer* is checked with access_ok().).
> We have a fast path that will execute just enough of the time to make
> debugging the slow path really annoying. (We should probably delete
> the fast path.)  There are pagefault_disable() call in there mostly to
> confuse people. (So we take a fault and sleep — big deal.  We have
> temporarily corrupt state, but no one will ever read it.  The retry
> after sleeping will clobber xstate, but lazy save is long gone and
> this should be fine now.  The real issue is that, if we’re preempted
> after a successful a successful restore, then the new state will get
> lost.)

There is preempt_disable() as part of FPU locking since we can't change
the content of the FPU registers (CPU's or within task's state) and get
interrupted by task preemption. With disabled preemption we can't take a
page fault.

We need to load the page from userland which may fault. The context
switch saves _current_ FPU state only if TIF_NEED_FPU_LOAD is cleared.
This needs to happen atomic.

The fast path may fail if stack is not faulted-in (custom stack,
madvise(,, MADV_DONTNEED))

> So either we should delete the fast path or we should make it work
> reliably and delete the slow path.  And we should get rid of the
> __copy. And we should have some test cases.

without the fastpath the average case is too slow.
People-complained-about-this-slow. That is why we ended up with the
fastpath in the last revision of the series.

The go people contirbuted a testcase. Maybe I should hack up it up so
that we trigger each path and post since it obviously did not happen.
Boris, do you remember why we did not include their testcase yet?
 
> BTW, how was the bug in here discovered?  It looks like it only
> affects signal restore failure, which is usually not survivable unless
> the user program is really trying.

The glibc test suite.

Sebastian
