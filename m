Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00984C4646B
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 22:22:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C604620663
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 22:22:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727428AbfFXWWH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 18:22:07 -0400
Received: from mga02.intel.com ([134.134.136.20]:2527 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726321AbfFXWWH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 18:22:07 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Jun 2019 15:22:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,413,1557212400"; 
   d="scan'208";a="161734930"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by fmsmga008.fm.intel.com with ESMTP; 24 Jun 2019 15:22:05 -0700
Date:   Mon, 24 Jun 2019 15:12:24 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ashok Raj <ashok.raj@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [PATCH v5 2/5] x86/umwait: Initialize umwait control values
Message-ID: <20190624221224.GA245468@romley-ivt3.sc.intel.com>
References: <1560994438-235698-1-git-send-email-fenghua.yu@intel.com>
 <1560994438-235698-3-git-send-email-fenghua.yu@intel.com>
 <alpine.DEB.2.21.1906232038421.32342@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1906232038421.32342@nanos.tec.linutronix.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 24, 2019 at 12:39:05AM +0200, Thomas Gleixner wrote:
> On Wed, 19 Jun 2019, Fenghua Yu wrote:
> >  
> > +#define MSR_IA32_UMWAIT_CONTROL			0xe1
> > +#define MSR_IA32_UMWAIT_CONTROL_C02_DISABLED	BIT(0)
> > +#define MSR_IA32_UMWAIT_CONTROL_MAX_TIME	0xfffffffc
> 
> Errm, no! That's not maxtime, that's the time field mask in the
> MSR. Throughout the code you use that as a mask, which is not really
> obvious.
> 
> > +	(((max_time) & MSR_IA32_UMWAIT_CONTROL_MAX_TIME) |		\
> 
> and later on:
> 
> 	if (max_time & ~MSR_IA32_UMWAIT_CONTROL_MAX_TIME)
> 
> What? How is anyone supposed to understand that?
> 
> 	if (max_time & ~MSR_IA32_UMWAIT_CONTROL_TIME_MASK)
> 
> makes it entirely clear that the value is not allowed to have any bits
> outside of the mask set.
> 
> > +
> > +#define UMWAIT_C02_ENABLED	(0 & MSR_IA32_UMWAIT_CONTROL_C02_DISABLED)
> 
> The AND is there for maximal confusion of the reader?
> 
> > +/*
> > + * On resume, set up IA32_UMWAIT_CONTROL MSR on BP which is the only active
> > + * CPU at this time. Setting up the MSR on APs when they are re-added later
> > + * using CPU hotplug.
> > + * The MSR on BP is supposed not to be changed during suspend and thus it's
> > + * unnecessary to set it again during resume from suspend. But at this point
> > + * we don't know resume is from suspend or hibernation. To simplify the
> > + * situation, just set up the MSR on resume from suspend.
> 
> We also do not trust any firmware by default whatever it is supposed to do.

Thank you very much for pointing out and fixing all the issues and merging
the patches into the tip tree!

I test the tip tree and everything works fine.

-Fenghua


