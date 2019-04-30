Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8107C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 14:57:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2F0C20651
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 14:57:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727829AbfD3O50 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 10:57:26 -0400
Received: from mga14.intel.com ([192.55.52.115]:53087 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726053AbfD3O50 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 10:57:26 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Apr 2019 07:57:25 -0700
X-ExtLoop1: 1
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.181])
  by orsmga002.jf.intel.com with ESMTP; 30 Apr 2019 07:57:24 -0700
Date:   Tue, 30 Apr 2019 07:57:24 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Perr Zhang <strongbox8@zoho.com>, pbonzini@redhat.com,
        rkrcmar@redhat.com, tglx@linutronix.de, stable@vger.kernel.org,
        mingo@redhat.com, x86@kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: x86: revert the order of calls in kvm_fast_pio()
Message-ID: <20190430145724.GA32170@linux.intel.com>
References: <20190430142423.3393-1-strongbox8@zoho.com>
 <20190430143201.GH2589@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190430143201.GH2589@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 30, 2019 at 04:32:01PM +0200, Peter Zijlstra wrote:
> On Tue, Apr 30, 2019 at 10:24:23PM +0800, Perr Zhang wrote:
> > In commit 45def77ebf79, the order of function calls in kvm_fast_pio()
> > was changed. This causes that the vm(XP,and also XP's iso img) failed
> > to boot. This doesn't happen with win10 or ubuntu.
> > 
> > After revert the order, the vm(XP) succeedes to boot. In addition, the
> > change of calls's order of kvm_fast_pio() in commit 45def77ebf79 has no
> > obvious reason.

There are three reasons explicitly listed in the changelog:

    Updating %rip prior to executing to userspace has several drawbacks:
    
      - Userspace sees the wrong %rip on the exit, e.g. if PIO emulation
        fails it will likely yell about the wrong address.
      - Single step exits to userspace for are effectively dropped as
        KVM_EXIT_DEBUG is overwritten with KVM_EXIT_IO.
      - Behavior of PIO emulation is different depending on whether it
        goes down the fast path or the slow path.

> 
> This Changelog fails to explain why the order is important and equally
> fails to inform the future reader of that code. So this very same thing
> will happen again in 6 months time or thereabout.

There's a more precise fix submitted for this bug[1].  In theory v2
already went out, but I still don't see it posted to the KVM list.
Either the KVM list or my mail client is being weird.

[1] https://patchwork.kernel.org/patch/10919849/
