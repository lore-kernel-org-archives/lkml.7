Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C888BC282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 17:24:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4071206ED
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 17:24:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388081AbgAIRYP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 12:24:15 -0500
Received: from mga01.intel.com ([192.55.52.88]:20953 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728444AbgAIRYP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 12:24:15 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Jan 2020 09:24:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,414,1571727600"; 
   d="scan'208";a="421848697"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.69])
  by fmsmga005.fm.intel.com with ESMTP; 09 Jan 2020 09:24:14 -0800
Date:   Thu, 9 Jan 2020 09:24:14 -0800
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     David Laight <David.Laight@ACULAB.COM>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] KVM: x86/mmu: Fix a benign Bitwise vs. Logical OR mixup
Message-ID: <20200109172414.GB15001@linux.intel.com>
References: <20200108001859.25254-1-sean.j.christopherson@intel.com>
 <c716f793e22e4885a3dee3c91f93e517@AcuMS.aculab.com>
 <20200109152629.GA25610@rani.riverdale.lan>
 <20200109163624.GA15001@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200109163624.GA15001@linux.intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 09, 2020 at 08:36:24AM -0800, Sean Christopherson wrote:
> On Thu, Jan 09, 2020 at 10:26:30AM -0500, Arvind Sankar wrote:
> > On Thu, Jan 09, 2020 at 02:13:48PM +0000, David Laight wrote:
> > > From: Sean Christopherson
> > > > Sent: 08 January 2020 00:19
> > > > 
> > > > Use a Logical OR in __is_rsvd_bits_set() to combine the two reserved bit
> > > > checks, which are obviously intended to be logical statements.  Switching
> > > > to a Logical OR is functionally a nop, but allows the compiler to better
> > > > optimize the checks.
> > > > 
> > > > Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> > > > ---
> > > >  arch/x86/kvm/mmu/mmu.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 
> > > > diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> > > > index 7269130ea5e2..72e845709027 100644
> > > > --- a/arch/x86/kvm/mmu/mmu.c
> > > > +++ b/arch/x86/kvm/mmu/mmu.c
> > > > @@ -3970,7 +3970,7 @@ __is_rsvd_bits_set(struct rsvd_bits_validate *rsvd_check, u64 pte, int level)
> > > >  {
> > > >  	int bit7 = (pte >> 7) & 1, low6 = pte & 0x3f;
> > > > 
> > > > -	return (pte & rsvd_check->rsvd_bits_mask[bit7][level-1]) |
> > > > +	return (pte & rsvd_check->rsvd_bits_mask[bit7][level-1]) ||
> > > >  		((rsvd_check->bad_mt_xwr & (1ull << low6)) != 0);
> > > 
> > > Are you sure this isn't deliberate?
> > > The best code almost certainly comes from also removing the '!= 0'.
> 
> The '!= 0' is truly superfluous, removing it doesn't affect code
> generation.

Actually, it's not completely superfluous.  Functionally the code is
identical, but ordered slightly differently for whatever reason.
