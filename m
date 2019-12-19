Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9959C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 17:58:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE03220716
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 17:58:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbfLSR6v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 12:58:51 -0500
Received: from mga17.intel.com ([192.55.52.151]:4392 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726840AbfLSR6v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 12:58:51 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Dec 2019 09:58:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,332,1571727600"; 
   d="scan'208";a="213075151"
Received: from yyu32-desk.sc.intel.com ([143.183.136.51])
  by fmsmga007.fm.intel.com with ESMTP; 19 Dec 2019 09:58:50 -0800
Message-ID: <1607597639a6c6255127fef07704ee9193e33166.camel@intel.com>
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
Date:   Thu, 19 Dec 2019 09:40:06 -0800
In-Reply-To: <20191219171635.phdsfkvsyazwaq7s@linutronix.de>
References: <20191212210855.19260-1-yu-cheng.yu@intel.com>
         <20191212210855.19260-4-yu-cheng.yu@intel.com>
         <20191218155449.sk4gjabtynh67jqb@linutronix.de>
         <587463c4e5fa82dff8748e5f753890ac390e993e.camel@intel.com>
         <20191219142217.axgpqlb7zzluoxnf@linutronix.de>
         <19a94f88f1bc66bb81dbf5dd72083d03ca5090e9.camel@intel.com>
         <20191219171635.phdsfkvsyazwaq7s@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-12-19 at 18:16 +0100, Sebastian Andrzej Siewior wrote:
> On 2019-12-19 08:44:08 [-0800], Yu-cheng Yu wrote:
> > Yes, this works.  But then everywhere that calls copy_*_to_xregs_*() etc. needs to be checked.
> > Are there other alternatives?
> 
> I don't like the big hammer approach of your very much. It might make
> all it "correct" but then it might lead to more "invalids" then needed.
> It also required to export the symbol which I would like to avoid.

Copying to registers invalids current fpregs context.  It might not cause
extra register loading, because registers are in fact already invalidated
and any task owning the context needs to reload anyway.  Setting
fpu_fpregs_owner_ctx is only to let the rest of the kernel know the
fact that already happened.

But, I agree with you the patch does look biggish.

> 
> So if this patch works for you and you don't find anything else where it
> falls apart then I will audit tomorrow all callers which got the
> "invalidator" added and check for that angle.

Yes, that works for me.  Also, most of these call sites are under fpregs_lock(),
and we could use __cpu_invalidate_fpregs_state().

I was also thinking maybe add warnings when any new code re-introduces the issue,
but not sure where to add that.  Do you think that is needed?

Thanks,
Yu-cheng

