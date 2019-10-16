Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF5C5FA3728
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 11:49:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A38B0218DE
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 11:49:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389792AbfJPLtn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 07:49:43 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49888 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728404AbfJPLtm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 07:49:42 -0400
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iKhnz-00040t-47; Wed, 16 Oct 2019 13:49:27 +0200
Date:   Wed, 16 Oct 2019 13:49:26 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Paolo Bonzini <pbonzini@redhat.com>
cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Radim Krcmar <rkrcmar@redhat.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        x86 <x86@kernel.org>, kvm@vger.kernel.org
Subject: Re: [PATCH v9 09/17] x86/split_lock: Handle #AC exception for split
 lock
In-Reply-To: <57f40083-9063-5d41-f06d-fa1ae4c78ec6@redhat.com>
Message-ID: <alpine.DEB.2.21.1910161244060.2046@nanos.tec.linutronix.de>
References: <1560897679-228028-1-git-send-email-fenghua.yu@intel.com> <1560897679-228028-10-git-send-email-fenghua.yu@intel.com> <alpine.DEB.2.21.1906262209590.32342@nanos.tec.linutronix.de> <20190626203637.GC245468@romley-ivt3.sc.intel.com>
 <alpine.DEB.2.21.1906262338220.32342@nanos.tec.linutronix.de> <20190925180931.GG31852@linux.intel.com> <3ec328dc-2763-9da5-28d6-e28970262c58@redhat.com> <alpine.DEB.2.21.1910161142560.2046@nanos.tec.linutronix.de>
 <57f40083-9063-5d41-f06d-fa1ae4c78ec6@redhat.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Oct 2019, Paolo Bonzini wrote:
> On 16/10/19 11:47, Thomas Gleixner wrote:
> > On Wed, 16 Oct 2019, Paolo Bonzini wrote:
> >> Just never advertise split-lock
> >> detection to guests.  If the host has enabled split-lock detection,
> >> trap #AC and forward it to the host handler---which would disable
> >> split lock detection globally and reenter the guest.
> > 
> > Which completely defeats the purpose.
> 
> Yes it does.  But Sean's proposal, as I understand it, leads to the
> guest receiving #AC when it wasn't expecting one.  So for an old guest,
> as soon as the guest kernel happens to do a split lock, it gets an
> unexpected #AC and crashes and burns.  And then, after much googling and
> gnashing of teeth, people proceed to disable split lock detection.

I don't think that this was what he suggested/intended.

> In all of these cases, the common final result is that split-lock
> detection is disabled on the host.  So might as well go with the
> simplest one and not pretend to virtualize something that (without core
> scheduling) is obviously not virtualizable.

You are completely ignoring any argument here and just leave it behind your
signature (instead of trimming your reply).

> > 1) Sane guest
> > 
> > Guest kernel has #AC handler and you basically prevent it from
> > detecting malicious user space and killing it. You also prevent #AC
> > detection in the guest kernel which limits debugability.

That's a perfectly fine situation. Host has #AC enabled and exposes the
availability of #AC to the guest. Guest kernel has a proper handler and
does the right thing. So the host _CAN_ forward #AC to the guest and let it
deal with it. For that to work you need to expose the MSR so you know the
guest state in the host.

Your lazy 'solution' just renders #AC completely useless even for
debugging.

> > 2) Malicious guest
> > 
> > Trigger #AC to disable the host detection and then carry out the DoS 
> > attack.

With your proposal you render #AC useless even on hosts which have SMT
disabled, which is just wrong. There are enough good reasons to disable
SMT.

I agree that with SMT enabled the situation is truly bad, but we surely can
be smarter than just disabling it globally unconditionally and forever.

Plus we want a knob which treats guests triggering #AC in the same way as
we treat user space, i.e. kill them with SIGBUS.

Thanks,

	tglx
