Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFD7BC3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 14:23:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE6682080F
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 14:23:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726619AbfH1OXn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 10:23:43 -0400
Received: from mga12.intel.com ([192.55.52.136]:63432 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726368AbfH1OXn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 10:23:43 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Aug 2019 07:23:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,441,1559545200"; 
   d="scan'208";a="210181730"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.41])
  by fmsmga002.fm.intel.com with ESMTP; 28 Aug 2019 07:23:40 -0700
Date:   Wed, 28 Aug 2019 07:23:40 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Jan Dakinevich <jan.dakinevich@virtuozzo.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Denis Lunev <den@virtuozzo.com>,
        Roman Kagan <rkagan@virtuozzo.com>,
        Denis Plotnikov <dplotnikov@virtuozzo.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Yi Wang <wang.yi59@zte.com.cn>, Peng Hao <peng.hao2@zte.com.cn>
Subject: Re: [PATCH 3/3] KVM: x86: always stop emulation on page fault
Message-ID: <20190828142340.GA21651@linux.intel.com>
References: <1566911210-30059-1-git-send-email-jan.dakinevich@virtuozzo.com>
 <1566911210-30059-4-git-send-email-jan.dakinevich@virtuozzo.com>
 <20190827145030.GC27459@linux.intel.com>
 <20190828131948.cb67f97cab502b9f5f63b1b8@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190828131948.cb67f97cab502b9f5f63b1b8@virtuozzo.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 28, 2019 at 10:19:51AM +0000, Jan Dakinevich wrote:
> On Tue, 27 Aug 2019 07:50:30 -0700
> Sean Christopherson <sean.j.christopherson@intel.com> wrote:
> > Yikes, this patch and the previous have quite the sordid history.
> > 
> > 
> > The non-void return from inject_emulated_exception() was added by commit
> > 
> >   ef54bcfeea6c ("KVM: x86: skip writeback on injection of nested exception")
> > 
> > for the purpose of skipping writeback.  At the time, the above blob in the
> > decode flow didn't exist.
> > 
> > 
> > Decode exception handling was added by commit
> > 
> >   6ea6e84309ca ("KVM: x86: inject exceptions produced by x86_decode_insn")
> > 
> > but it was dead code even then.  The patch discussion[1] even point out that
> > it was dead code, i.e. the change probably should have been reverted.
> > 
> > 
> > Peng Hao and Yi Wang later ran into what appears to be the same bug you're
> > hitting[2][3], and even had patches temporarily queued[4][5], but the
> > patches never made it to mainline as they broke kvm-unit-tests.  Fun side
> > note, Radim even pointed out[4] the bug fixed by patch 1/3.
> > 
> > So, the patches look correct, but there's the open question of why the
> > hypercall test was failing for Paolo.  
> 
> Sorry, I'm little confused. Could you please, point me which test or tests 
> were broken? I've just run kvm-unit-test and I see same results with and 
> without my changes.
> 
> > I've tried to reproduce the #DF to
> > no avail.

Aha!  The #DF occurs if patch 2/3, but not patch 3/3, is applied, and the
VMware backdoor is enabled.  The backdoor is off by default, which is why
only Paolo was seeing the #DF.

To handle the VMware backdoor, KVM intercepts #GP faults, which includes
the non-canonical #GP from the hypercall unit test.  With only patch 2/3
applied, x86_emulate_instruction() injects a #GP for the non-canonical RIP
but returns EMULATE_FAIL instead of EMULATE_DONE.   EMULATE_FAIL causes
handle_exception_nmi() (or gp_interception() for SVM) to re-inject the
original #GP because it thinks emulation failed due to a non-VMware opcode.

Applying patch 3/3 resolves the issue as x86_emulate_instruction() returns
EMULATE_DONE after injecting the #GP.


TL;DR:

Swap the order of patches and everything should be hunky dory.  Please
rebase to the latest kvm/queue, which has an equivalent to patch 1/3.
