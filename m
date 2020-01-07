Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68582C33C9B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 20:57:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 487EC20880
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 20:57:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727462AbgAGU5K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 15:57:10 -0500
Received: from mga04.intel.com ([192.55.52.120]:4554 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727408AbgAGU5F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 15:57:05 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Jan 2020 12:57:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,407,1571727600"; 
   d="scan'208";a="211306070"
Received: from yyu32-desk.sc.intel.com ([143.183.136.51])
  by orsmga007.jf.intel.com with ESMTP; 07 Jan 2020 12:57:03 -0800
Message-ID: <9f3c7f106963ce7f8a74fc084f6de5ad2d4380ed.camel@intel.com>
Subject: Re: [tip: x86/fpu] x86/fpu: Deactivate FPU state after failure
 during state load
From:   Yu-cheng Yu <yu-cheng.yu@intel.com>
To:     Andy Lutomirski <luto@amacapital.net>, linux-kernel@vger.kernel.org
Cc:     linux-tip-commits@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
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
Date:   Tue, 07 Jan 2020 12:38:20 -0800
In-Reply-To: <FA0D2929-63D0-4473-A492-42227D7A5D98@amacapital.net>
References: <157840155965.30329.313988118654552721.tip-bot2@tip-bot2>
         <FA0D2929-63D0-4473-A492-42227D7A5D98@amacapital.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-01-07 at 10:41 -1000, Andy Lutomirski wrote:
> > On Jan 7, 2020, at 2:52 AM, tip-bot2 for Sebastian Andrzej Siewior <tip-bot2@linutronix.de> wrote:
> > 
> > ﻿The following commit has been merged into the x86/fpu branch of tip:
> > 
> > Commit-ID:     bbc55341b9c67645d1a5471506370caf7dd4a203
> > Gitweb:        https://git.kernel.org/tip/bbc55341b9c67645d1a5471506370caf7dd4a203
> > Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > AuthorDate:    Fri, 20 Dec 2019 20:59:06 +01:00
> > Committer:     Borislav Petkov <bp@suse.de>
> > CommitterDate: Tue, 07 Jan 2020 13:44:42 +01:00
> > 
> > x86/fpu: Deactivate FPU state after failure during state load
> > 
> > In __fpu__restore_sig(), fpu_fpregs_owner_ctx needs to be reset if the
> > FPU state was not fully restored. Otherwise the following may happen (on
> > the same CPU):
> > 
> >  Task A                     Task B               fpu_fpregs_owner_ctx
> >  *active*                                        A.fpu
> >  __fpu__restore_sig()
> >                             ctx switch           load B.fpu
> >                             *active*             B.fpu
> >  fpregs_lock()
> >  copy_user_to_fpregs_zeroing()
> >    copy_kernel_to_xregs() *modify*
> >    copy_user_to_xregs() *fails*
> >  fpregs_unlock()
> >                            ctx switch            skip loading B.fpu,
> >                            *active*              B.fpu
> > 
> > In the success case, fpu_fpregs_owner_ctx is set to the current task.
> > 
> > In the failure case, the FPU state might have been modified by loading
> > the init state.
> > 
> > In this case, fpu_fpregs_owner_ctx needs to be reset in order to ensure
> > that the FPU state of the following task is loaded from saved state (and
> > not skipped because it was the previous state).
> > 
> > Reset fpu_fpregs_owner_ctx after a failure during restore occurred, to
> > ensure that the FPU state for the next task is always loaded.
> > 
> > The problem was debugged-by Yu-cheng Yu <yu-cheng.yu@intel.com>.
> 
> Wow, __fpu__restore_sig is a mess. We have __copy_from... that is Obviously Incorrect (tm) even though it’s not obviously exploitable. (It’s wrong because the *wrong pointer* is checked with access_ok().). We have a fast path that will execute just enough of the time to make debugging the slow path really annoying. (We should probably delete the fast path.)  There are pagefault_disable() call in there mostly to confuse people. (So we take a fault and sleep — big deal.  We have temporarily corrupt state, but no one will ever read it.  The retry after sleeping will clobber xstate, but lazy save is long gone and this should be fine now.  The real issue is that, if we’re preempted after a successful a successful restore, then the new state will get lost.)
> 
> So either we should delete the fast path or we should make it work reliably and delete the slow path.  And we should get rid of the __copy. And we should have some test cases.
> 
> BTW, how was the bug in here discovered?  It looks like it only affects signal restore failure, which is usually not survivable unless the user program is really trying.

It causes corruption in other tasks, e.g. a non-CET task gets a control-protection fault.

Yu-cheng

