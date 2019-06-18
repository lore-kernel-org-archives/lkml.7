Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEA93C31E5E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 22:48:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A003620863
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 22:48:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730994AbfFRWs6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 18:48:58 -0400
Received: from mga18.intel.com ([134.134.136.126]:12916 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730176AbfFRWs6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 18:48:58 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Jun 2019 15:48:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,390,1557212400"; 
   d="scan'208";a="160196365"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmsmga008.fm.intel.com with ESMTP; 18 Jun 2019 15:48:56 -0700
Date:   Tue, 18 Jun 2019 15:48:35 -0700
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@suse.de>,
        Ashok Raj <ashok.raj@intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Andi Kleen <andi.kleen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
        Stephane Eranian <eranian@google.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        Ricardo Neri <ricardo.neri@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Tony Luck <tony.luck@intel.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [RFC PATCH v4 04/21] x86/hpet: Add hpet_set_comparator() for
 periodic and one-shot modes
Message-ID: <20190618224835.GF30488@ranerica-svr.sc.intel.com>
References: <1558660583-28561-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
 <1558660583-28561-5-git-send-email-ricardo.neri-calderon@linux.intel.com>
 <alpine.DEB.2.21.1906142010230.1760@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1906142010230.1760@nanos.tec.linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 14, 2019 at 08:17:14PM +0200, Thomas Gleixner wrote:
> On Thu, 23 May 2019, Ricardo Neri wrote:
> > +/**
> > + * hpet_set_comparator() - Helper function for setting comparator register
> > + * @num:	The timer ID
> > + * @cmp:	The value to be written to the comparator/accumulator
> > + * @period:	The value to be written to the period (0 = oneshot mode)
> > + *
> > + * Helper function for updating comparator, accumulator and period values.
> > + *
> > + * In periodic mode, HPET needs HPET_TN_SETVAL to be set before writing
> > + * to the Tn_CMP to update the accumulator. Then, HPET needs a second
> > + * write (with HPET_TN_SETVAL cleared) to Tn_CMP to set the period.
> > + * The HPET_TN_SETVAL bit is automatically cleared after the first write.
> > + *
> > + * For one-shot mode, HPET_TN_SETVAL does not need to be set.
> > + *
> > + * See the following documents:
> > + *   - Intel IA-PC HPET (High Precision Event Timers) Specification
> > + *   - AMD-8111 HyperTransport I/O Hub Data Sheet, Publication # 24674
> > + */
> > +void hpet_set_comparator(int num, unsigned int cmp, unsigned int period)
> > +{
> > +	if (period) {
> > +		unsigned int v = hpet_readl(HPET_Tn_CFG(num));
> > +
> > +		hpet_writel(v | HPET_TN_SETVAL, HPET_Tn_CFG(num));
> > +	}
> > +
> > +	hpet_writel(cmp, HPET_Tn_CMP(num));
> > +
> > +	if (!period)
> > +		return;
> 
> TBH, I hate this conditional handling. What's wrong with two functions?

There is probably nothing wrong with two functions. I can split it into
hpet_set_comparator_periodic() and hpet_set_comparator(). Perhaps the
latter is not needed as it would be a one-line function; you have
suggested earlier to avoid such small functions.
> 
> > +
> > +	/*
> > +	 * This delay is seldom used: never in one-shot mode and in periodic
> > +	 * only when reprogramming the timer.
> > +	 */
> > +	udelay(1);
> > +	hpet_writel(period, HPET_Tn_CMP(num));
> > +}
> > +EXPORT_SYMBOL_GPL(hpet_set_comparator);
> 
> Why is this exported? Which module user needs this?

It is not used anywhere else. I will remove this export.

Thanks and BR,

Ricardo
