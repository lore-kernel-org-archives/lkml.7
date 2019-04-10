Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F5E9C10F0E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 01:07:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED2632084B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 01:07:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbfDJBG7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 21:06:59 -0400
Received: from mga05.intel.com ([192.55.52.43]:8982 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726538AbfDJBG7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 21:06:59 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Apr 2019 18:06:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,331,1549958400"; 
   d="scan'208";a="314554832"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga005.jf.intel.com with ESMTP; 09 Apr 2019 18:06:57 -0700
Date:   Tue, 9 Apr 2019 18:05:48 -0700
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@suse.de>,
        Ashok Raj <ashok.raj@intel.com>,
        Andi Kleen <andi.kleen@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Ricardo Neri <ricardo.neri@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Tony Luck <tony.luck@intel.com>,
        Clemens Ladisch <clemens@ladisch.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Nayna Jain <nayna@linux.ibm.com>
Subject: Re: [RFC PATCH v2 11/14] x86/watchdog/hardlockup: Add an HPET-based
 hardlockup detector
Message-ID: <20190410010548.GA10062@ranerica-svr.sc.intel.com>
References: <1551283518-18922-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
 <1551283518-18922-12-git-send-email-ricardo.neri-calderon@linux.intel.com>
 <20190409110340.GS4038@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190409110340.GS4038@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 09, 2019 at 01:03:40PM +0200, Peter Zijlstra wrote:
> On Wed, Feb 27, 2019 at 08:05:15AM -0800, Ricardo Neri wrote:
> > diff --git a/arch/x86/include/asm/hpet.h b/arch/x86/include/asm/hpet.h
> > index 4d559e0c746f..15dc3b576496 100644
> > --- a/arch/x86/include/asm/hpet.h
> > +++ b/arch/x86/include/asm/hpet.h
> > @@ -123,12 +123,24 @@ struct hpet_hld_data {
> >  	u32		num;
> >  	u32		flags;
> >  	u64		ticks_per_second;
> > +	u32		handling_cpu;
> > +	struct cpumask	cpu_monitored_mask;
> > +	struct msi_msg	msi_msg;
> >  };
> 
> Please don't use struct cpumask unless you absolutely have to.
> 
> The above is better written as:
> 
> 
> 	struct hpet_hld_data {
> 		...
> 		unsigned long cpumask[0];
> 	};
> 
> and allocated using:
> 
> 	struct hpet_hld_data *hhd = kzalloc(sizeof(struct hpet_hld_data) + cpumask_size());
> 
> and used as:
> 
> 	to_cpumask(hhd->cpumask);

Thanks for your feedback, Peter!

Sure. I will make this change.

Thanks and BR,
Ricardo
