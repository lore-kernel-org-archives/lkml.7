Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4EEFC43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 20:51:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D05F2082E
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 20:51:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727527AbfLTUvW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 15:51:22 -0500
Received: from mga01.intel.com ([192.55.52.88]:12377 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727422AbfLTUvV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 15:51:21 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Dec 2019 12:51:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,337,1571727600"; 
   d="scan'208";a="210926531"
Received: from yyu32-desk.sc.intel.com ([143.183.136.51])
  by orsmga008.jf.intel.com with ESMTP; 20 Dec 2019 12:51:20 -0800
Message-ID: <a8d84a2b611f3aba6be9db72c19baf5f479aa80d.camel@intel.com>
Subject: Re: [PATCH v2 3/3] x86/fpu/xstate: Invalidate fpregs when
 __fpu_restore_sig() fails
From:   Yu-cheng Yu <yu-cheng.yu@intel.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Rik van Riel <riel@surriel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Date:   Fri, 20 Dec 2019 12:32:36 -0800
In-Reply-To: <20191220201621.riyrptl5vwdukztc@linutronix.de>
References: <20191212210855.19260-1-yu-cheng.yu@intel.com>
         <20191212210855.19260-4-yu-cheng.yu@intel.com>
         <20191218155449.sk4gjabtynh67jqb@linutronix.de>
         <587463c4e5fa82dff8748e5f753890ac390e993e.camel@intel.com>
         <20191219142217.axgpqlb7zzluoxnf@linutronix.de>
         <19a94f88f1bc66bb81dbf5dd72083d03ca5090e9.camel@intel.com>
         <20191219171635.phdsfkvsyazwaq7s@linutronix.de>
         <1607597639a6c6255127fef07704ee9193e33166.camel@intel.com>
         <20191220201621.riyrptl5vwdukztc@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-12-20 at 21:16 +0100, Sebastian Andrzej Siewior wrote:
> [...]
> Now that I looked at it:
> All kernel loads don't fail. If they fail we end up in the handler and
> restore to init-state. So no need to reset `fpu_fpregs_owner_ctx' in this
> case. The variable is actually set to task's FPU state so resetting is
> not required.

Agree.

> fpu__save() invokes copy_kernel_to_fpregs() (on older boxes) and by
> resetting `fpu_fpregs_owner_ctx' we would load it twice (in fpu__save()
> and on return to userland).

That is true.

> So far I can tell, the only problematic case is the signal code because
> here the state restore *may* fail and we *may* do it in two steps. The
> error happens only if both `may' are true.
> 
> > > So if this patch works for you and you don't find anything else where it
> > > falls apart then I will audit tomorrow all callers which got the
> > > "invalidator" added and check for that angle.
> > 
> > Yes, that works for me.  Also, most of these call sites are under fpregs_lock(),
> > and we could use __cpu_invalidate_fpregs_state().
> > I was also thinking maybe add warnings when any new code re-introduces the issue,
> > but not sure where to add that.  Do you think that is needed?
> 
> I was thinking about it. So the `read-FPU-state' function must be
> invoked within the fpregs_lock() section. This could be easily
> enforced. At fpregs_unlock() time `fpu_fpregs_owner_ctx' must be NULL or
> pointing to task's FPU.
> My brain is fried for today so I'm sure if this is a sane approach. But
> it might be a start.

I will also think about it.  Thanks!

Yu-cheng

