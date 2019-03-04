Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9050C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 19:22:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3F5A2070B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 19:22:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726317AbfCDTWH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 14:22:07 -0500
Received: from mga06.intel.com ([134.134.136.31]:9917 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726038AbfCDTWH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 14:22:07 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Mar 2019 11:22:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,441,1544515200"; 
   d="scan'208";a="148511849"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by fmsmga002.fm.intel.com with ESMTP; 04 Mar 2019 11:22:05 -0800
Date:   Mon, 4 Mar 2019 11:15:12 -0800
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        x86 <x86@kernel.org>, kvm@vger.kernel.org
Subject: Re: [PATCH v4 04/17] x86/split_lock: Align x86_capability to
 unsigned long to avoid split locked access
Message-ID: <20190304191512.GB231946@romley-ivt3.sc.intel.com>
References: <1551494711-213533-1-git-send-email-fenghua.yu@intel.com>
 <1551494711-213533-5-git-send-email-fenghua.yu@intel.com>
 <b9a7e3a6-d89c-9ce7-8909-e09122c93f96@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b9a7e3a6-d89c-9ce7-8909-e09122c93f96@intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 04, 2019 at 10:52:19AM -0800, Dave Hansen wrote:
> On 3/1/19 6:44 PM, Fenghua Yu wrote:
> > diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
> > index 33051436c864..eb8ae701ef65 100644
> > --- a/arch/x86/include/asm/processor.h
> > +++ b/arch/x86/include/asm/processor.h
> > @@ -93,7 +93,9 @@ struct cpuinfo_x86 {
> >  	__u32			extended_cpuid_level;
> >  	/* Maximum supported CPUID level, -1=no CPUID: */
> >  	int			cpuid_level;
> > -	__u32			x86_capability[NCAPINTS + NBUGINTS];
> > +	/* Unsigned long alignment to avoid split lock in atomic bitmap ops */
> > +	__u32			x86_capability[NCAPINTS + NBUGINTS]
> > +				__aligned(sizeof(unsigned long));
> 
> I think this also warrants a comment in the changelog about the
> alignment of 'struct cpuinfo_x86'.

How about add "Depending on the starting address where GCC generates
for data of struct cpuinfo_x86, x86_capability[] may or may not align to
unsigned long...."?

Thanks.

-Fenghua
