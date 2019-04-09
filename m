Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E30DBC10F13
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 02:04:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B649B213F2
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 02:04:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbfDICEi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 22:04:38 -0400
Received: from mga12.intel.com ([192.55.52.136]:17179 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726133AbfDICEh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 22:04:37 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Apr 2019 19:04:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,327,1549958400"; 
   d="scan'208";a="221741789"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga001.jf.intel.com with ESMTP; 08 Apr 2019 19:04:36 -0700
Date:   Mon, 8 Apr 2019 19:03:27 -0700
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@suse.de>,
        Ashok Raj <ashok.raj@intel.com>,
        Andi Kleen <andi.kleen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Ricardo Neri <ricardo.neri@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Tony Luck <tony.luck@intel.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [RFC PATCH v2 02/14] x86/hpet: Expose more functions to read and
 write registers
Message-ID: <20190409020327.GA7039@ranerica-svr.sc.intel.com>
References: <1551283518-18922-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
 <1551283518-18922-3-git-send-email-ricardo.neri-calderon@linux.intel.com>
 <alpine.DEB.2.21.1903262156070.1789@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1903262156070.1789@nanos.tec.linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2019 at 10:00:24PM +0100, Thomas Gleixner wrote:
> On Wed, 27 Feb 2019, Ricardo Neri wrote:
> >  struct irq_data;
> > @@ -109,6 +114,11 @@ extern void hpet_unregister_irq_handler(rtc_irq_handler handler);
> >  static inline int hpet_enable(void) { return 0; }
> >  static inline int is_hpet_enabled(void) { return 0; }
> >  #define hpet_readl(a) 0
> > +#define hpet_writel(d, a)
> 
> What for?
> 
> > +#ifdef CONFIG_X86_64
> > +#define hpet_readq(a) 0
> > +#define hpet_writeq(d, a)
> > +#endif
> 
> Ditto.
> 
> There are no users outside of HPET and your new HPET watchdog code for
> those. And both are not compiled when CONFIG_HPET=n.

I'll remove these unneeded defintions.
> 
> The only reason to have the hpet_readl() define, which btw. should be an
> inline, is to avoid massive ifdeffery in the TSC calibration code.

May I ask what is the problem with the #define hpet_readl()? Commit
bfc0f5947afa("x86: merge tsc calibration") changed it from inline to
#define. Should I change it back?

Thanks and BR,
Ricardo
