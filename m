Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FFD2C31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 13:26:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EFE32133D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 13:26:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728063AbfFNN03 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 09:26:29 -0400
Received: from mga17.intel.com ([192.55.52.151]:23651 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727737AbfFNN03 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 09:26:29 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jun 2019 06:26:28 -0700
X-ExtLoop1: 1
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by orsmga006.jf.intel.com with ESMTP; 14 Jun 2019 06:26:27 -0700
Date:   Fri, 14 Jun 2019 06:17:02 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, H Peter Anvin <hpa@zytor.com>,
        Christopherson Sean J <sean.j.christopherson@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [RFC PATCH 2/3] x86/cpufeatures: Combine word 11 and 12 into new
 scattered features word 11
Message-ID: <20190614131701.GA198207@romley-ivt3.sc.intel.com>
References: <1560459064-195037-1-git-send-email-fenghua.yu@intel.com>
 <1560459064-195037-3-git-send-email-fenghua.yu@intel.com>
 <20190614114410.GD2586@zn.tnic>
 <20190614122749.GE2586@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190614122749.GE2586@zn.tnic>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 14, 2019 at 02:27:50PM +0200, Borislav Petkov wrote:
> On Fri, Jun 14, 2019 at 01:44:10PM +0200, Borislav Petkov wrote:
> > On Thu, Jun 13, 2019 at 01:51:03PM -0700, Fenghua Yu wrote:
> > > It's a waste for the four X86_FEATURE_CQM_* features to occupy two
> > > pure feature bits words. To better utilize feature words, re-define
> > > word 11 to host scattered features and move the four X86_FEATURE_CQM_*
> > > features into word 11. More scattered features can be added in word 11
> > > in the future.
> > > 
> > > KVM doesn't support resctrl now. So it's safe to move the
> > > X86_FEATURE_CQM_* features to scattered features word 11 for KVM.
> > > 
> > > Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> > 
> > ...
> > 
> > > diff --git a/arch/x86/kvm/cpuid.h b/arch/x86/kvm/cpuid.h
> > > index 9a327d5b6d1f..d78a61408243 100644
> > > --- a/arch/x86/kvm/cpuid.h
> > > +++ b/arch/x86/kvm/cpuid.h
> > > @@ -47,8 +47,6 @@ static const struct cpuid_reg reverse_cpuid[] = {
> > >  	[CPUID_8000_0001_ECX] = {0x80000001, 0, CPUID_ECX},
> > >  	[CPUID_7_0_EBX]       = {         7, 0, CPUID_EBX},
> > >  	[CPUID_D_1_EAX]       = {       0xd, 1, CPUID_EAX},
> > > -	[CPUID_F_0_EDX]       = {       0xf, 0, CPUID_EDX},
> > > -	[CPUID_F_1_EDX]       = {       0xf, 1, CPUID_EDX},
> > 
> > I think you're going to have to change those to:
> > 
> >         [CPUID_LNX_4]         = {         0, 0, 0},
> >         [CPUID_7_1_EAX]       = {         7, 1, CPUID_EAX },
> > 
> > instead of removing them because kvm is basically hardcoding the feature
> > words and then bitches when array elements in the middle get removed:
> 
> Alternatively - and what I think is the better solution - would be to
> remove those BUILD_BUG_ONs in x86_feature_cpuid and filter out the
> Linux-defined leafs dynamically. This way the array won't have holes in
> it.

Maybe adding a dummy slot in cpuid_leafs in patch 0002 to avoid the
compilation errors?

Those KVM BUILD_BUG_ON() want to find out any empty leaf in
reverse_cpuid (and also cpuid_leafs).

The patch 0002 actually creates such empty leaf 12 in cpuid_leafs. So
CPUID_7_EDX=17 instead of NCAPINTS-1=18 in cpuid_leafs. It's not
desired.

After applying patch 0003, the hole is filled in and there is no
compilation error from the KVM BUILD_BUG_ON() checks. So the compilation
errors only happens in bisect.

diff --git a/arch/x86/include/asm/cpufeature.h b/arch/x86/include/asm/cpufeature.h
index 526619906305..403f70c2e431 100644
--- a/arch/x86/include/asm/cpufeature.h
+++ b/arch/x86/include/asm/cpufeature.h
@@ -23,6 +23,7 @@ enum cpuid_leafs
        CPUID_7_0_EBX,
        CPUID_D_1_EAX,
        CPUID_LNX_4,
+       CPUID_DUMMY,
        CPUID_8000_0008_EBX,
        CPUID_6_EAX,
        CPUID_8000_000A_EDX,

Is it OK to add the above patch to the patch 0002 to solve the
compilation errors? If it's ok, I will explain in commit message why add
CPUID_DUMMY.

Thanks.

-Fenghua
