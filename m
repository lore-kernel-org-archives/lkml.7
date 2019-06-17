Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3303DC31E44
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 08:44:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 111B62080A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 08:44:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727598AbfFQIod (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 04:44:33 -0400
Received: from mga18.intel.com ([134.134.136.126]:31449 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725971AbfFQIod (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 04:44:33 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Jun 2019 01:44:32 -0700
X-ExtLoop1: 1
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by orsmga007.jf.intel.com with ESMTP; 17 Jun 2019 01:44:32 -0700
Date:   Mon, 17 Jun 2019 01:35:02 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, H Peter Anvin <hpa@zytor.com>,
        Christopherson Sean J <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim Krcmar <rkrcmar@redhat.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        x86 <x86@kernel.org>, Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH 1/3] x86/resctrl: Get max rmid and occupancy scale
 directly from CPUID instead of cpuinfo_x86
Message-ID: <20190617083502.GD214090@romley-ivt3.sc.intel.com>
References: <1560705250-211820-1-git-send-email-fenghua.yu@intel.com>
 <1560705250-211820-2-git-send-email-fenghua.yu@intel.com>
 <alpine.DEB.2.21.1906162141301.1760@nanos.tec.linutronix.de>
 <20190617031808.GA214090@romley-ivt3.sc.intel.com>
 <20190617075214.GB27127@zn.tnic>
 <20190617080909.GC214090@romley-ivt3.sc.intel.com>
 <20190617083048.GE27127@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190617083048.GE27127@zn.tnic>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 17, 2019 at 10:30:48AM +0200, Borislav Petkov wrote:
> On Mon, Jun 17, 2019 at 01:09:09AM -0700, Fenghua Yu wrote:
> > I just keep the code a bit uniform around the calling area where
> > a few functions are called. So get_cqm_info() makes the code a bit more
> > readable.
> > 
> >         init_scattered_cpuid_features(c);
> >         init_speculation_control(c);
> > +       get_cqm_info(c);
> > 
> >         /*
> >          * Clear/Set all flags overridden by options, after probe.
> >          * This needs to happen each time we re-probe, which may happen
> >          * several times during CPU initialization.
> >          */
> >         apply_forced_caps(c);
> > }
> > 
> > Maybe not? If the function is not good, I can directly put the code here?
> 
> If you want to have it cleaner, make that a separate patch and say so in
> the commit message. Patches should do one logical thing and not mix up
> different changes which makes review harder.

So in patch 0001, move the code of getting CQM info from before
calling init_scattered_cpuid_features(c) to after calling the function.

Then in patch 0002, carve out the code of getting CQM info into a
helper function get_cqm_info(c) for cleaner code.

Is this OK? Or the patch 0002 is unnecessary?

Thanks.

-Fenghua
