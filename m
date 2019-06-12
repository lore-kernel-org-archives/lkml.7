Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA64BC31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 17:13:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9D5C215EA
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 17:13:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392141AbfFLRN2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 13:13:28 -0400
Received: from mga12.intel.com ([192.55.52.136]:14682 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390335AbfFLRN2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 13:13:28 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Jun 2019 10:13:27 -0700
X-ExtLoop1: 1
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by fmsmga008.fm.intel.com with ESMTP; 12 Jun 2019 10:13:27 -0700
Date:   Wed, 12 Jun 2019 10:04:04 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, H Peter Anvin <hpa@zytor.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [RFC PATCH] x86/cpufeatures: Enumerate new AVX512 bfloat16
 instructions
Message-ID: <20190612170404.GF180343@romley-ivt3.sc.intel.com>
References: <1560186158-174788-1-git-send-email-fenghua.yu@intel.com>
 <20190610192026.GI5488@zn.tnic>
 <20190611181920.GC180343@romley-ivt3.sc.intel.com>
 <20190611194701.GJ31772@zn.tnic>
 <20190612033259.GE180343@romley-ivt3.sc.intel.com>
 <20190612040259.GC32652@zn.tnic>
 <20190612141049.GA20308@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190612141049.GA20308@linux.intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 12, 2019 at 07:10:49AM -0700, Sean Christopherson wrote:
> On Wed, Jun 12, 2019 at 06:02:59AM +0200, Borislav Petkov wrote:
> > On Tue, Jun 11, 2019 at 08:32:59PM -0700, Fenghua Yu wrote:
> > > Currently KVM doesn't simulate scattered features (the ones in CPUID_LNX_*
> > > in cpuid_leafs) as reverse_cpuid[] doesn't contain CPUID_LNX_*.
> > 
> > 43500e6f294d ("x86/cpufeatures: Remove get_scattered_cpuid_leaf()")
> > 
> > > After the X86_FEATURES_CQM_* features are changed to scattered features,
> > > they will not be simulated by KVM any more as CPUID_F_0_EDX and CPUID_F_1_EDX
> > > are removed.
> > 
> > Does KVM even support resctrl? I doubt only exporting a couple of CPUID
> > bits into the guest is enough...
> 
> KVM doesn't support resctrl.  Moving X86_FEATURES_CQM_* to a scattered
> leaf won't affect KVM.
> 
> > > Should patch #1 simulate X86_FEATURE_CQM_* in KVM? Or let KVM guys handle
> > > the scattered features?
> > 
> > Right, the scattered thing was removed as KVM didn't need it,
> > apparently, see above.
> 
> Let KVM people deal with it, in the unlikely event someone adds resctrl
> support to KVM.

Thank you for your insight, Boris and Sean!

-Fenghua
