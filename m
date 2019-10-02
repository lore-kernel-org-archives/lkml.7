Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3405BC35280
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 16:47:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F083721D81
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 16:47:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727895AbfJBQrd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 12:47:33 -0400
Received: from mga06.intel.com ([134.134.136.31]:60016 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726267AbfJBQrc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 12:47:32 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Oct 2019 09:47:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,249,1566889200"; 
   d="scan'208";a="203652629"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.41])
  by orsmga002.jf.intel.com with ESMTP; 02 Oct 2019 09:47:30 -0700
Date:   Wed, 2 Oct 2019 09:47:30 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Zhenzhong Duan <zhenzhong.duan@oracle.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim Krcmar <rkrcmar@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH 1/3] KVM: X86: Add "nopvspin" parameter to disable PV
 spinlocks
Message-ID: <20191002164730.GA9615@linux.intel.com>
References: <1569759666-26904-1-git-send-email-zhenzhong.duan@oracle.com>
 <1569759666-26904-2-git-send-email-zhenzhong.duan@oracle.com>
 <87pnjh3i6i.fsf@vitty.brq.redhat.com>
 <aae59646-be5f-6455-a033-ed29861107ce@oracle.com>
 <87eezw3lna.fsf@vitty.brq.redhat.com>
 <fdd14f28-74e9-5cf9-2f5a-09c884c55110@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fdd14f28-74e9-5cf9-2f5a-09c884c55110@oracle.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 01, 2019 at 05:47:00PM +0800, Zhenzhong Duan wrote:
> 
> On 2019/10/1 16:39, Vitaly Kuznetsov wrote:
> >Zhenzhong Duan<zhenzhong.duan@oracle.com>  writes:
> >
> >>On 2019/9/30 23:41, Vitaly Kuznetsov wrote:
> >>>Zhenzhong Duan<zhenzhong.duan@oracle.com>   writes:
> >>>
> >>>>There are cases where a guest tries to switch spinlocks to bare metal
> >>>>behavior (e.g. by setting "xen_nopvspin" on XEN platform and
> >>>>"hv_nopvspin" on HYPER_V).
> >>>>
> >>>>That feature is missed on KVM, add a new parameter "nopvspin" to disable
> >>>>PV spinlocks for KVM guest.
> >>>>
> >>>>This new parameter is also intended to replace "xen_nopvspin" and
> >>>>"hv_nopvspin" in the future.
> >>>Any reason to not do it right now? We will probably need to have compat
> >>>code to support xen_nopvspin/hv_nopvspin too but emit a 'is deprecated'
> >>>warning.
> >>Sorry the description isn't clear, I'll fix it.
> >>
> >>I did the compat work in the other two patches.
> >>[PATCH 2/3] xen: Mark "xen_nopvspin" parameter obsolete and map it to "nopvspin"
> >>[PATCH 3/3] x86/hyperv: Mark "hv_nopvspin" parameter obsolete and map it to "nopvspin"
> >>
> >For some reason I got CCed only on the first one and moreover,
> 
> The three patches have different maintainers/reviewers by get_maintainer.pl, I added
> "Cc: maintainers/reviewers" to each patch then git-sendemail picked them automaticly.
> I meaned to not disturb maintainers with the field they aren't in charge of. It looks
> I'm wrong.
> 
> So what's the correct way dealing with this? Should I send the whole patchset to all
> the maintainers/reviewers related to all the patches?

There's no one right answer to that question, folks have different
preferences.  My general rule of thumb is to cc everyone on all patches
unless the series is obnoxiously large *and* isolated to a specific part
of the kernel.  The idea being that people are more likely to be annoyed
if they can't find all patches in a relatively small series (this case)
than they are about receiving a mail or two that they don't care about.

At a minimum I would cc everyone involved on the cover letter, and cc the
relevant mailing lists on all patches.  Sending everyone the cover letter
provides people a quick overview of the patches they didn't receive, as
well as a starting point if they want to find those patches.  Cc'ing the
mailing list(s) can make it even easier to find the patches.  The cover
letter is also a good place to explain why you didn't cc everyone on all
patches (or vice versa).

Also, the cover letter should have the shortlog and overall diffstats.
'git format-patch --cover-letter' will do the work for you.
