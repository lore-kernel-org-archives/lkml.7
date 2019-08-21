Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 902A1C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 20:18:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 693CE22CF7
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 20:18:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730184AbfHUUSr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 16:18:47 -0400
Received: from mga04.intel.com ([192.55.52.120]:54478 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729078AbfHUUSq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 16:18:46 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Aug 2019 13:18:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,412,1559545200"; 
   d="scan'208";a="186344345"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.68])
  by FMSMGA003.fm.intel.com with ESMTP; 21 Aug 2019 13:18:46 -0700
Date:   Wed, 21 Aug 2019 13:18:46 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Rahul Tanwar <rahul.tanwar@linux.intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "hpa@zytor.com" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "Shevchenko, Andriy" <andriy.shevchenko@intel.com>,
        "alan@linux.intel.com" <alan@linux.intel.com>,
        "ricardo.neri-calderon@linux.intel.com" 
        <ricardo.neri-calderon@linux.intel.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Wu, Qiming" <qi-ming.wu@intel.com>,
        "Kim, Cheol Yong" <cheol.yong.kim@intel.com>,
        "Tanwar, Rahul" <rahul.tanwar@intel.com>
Subject: Re: [PATCH v2 2/3] x86/cpu: Add new Intel Atom CPU model name
Message-ID: <20190821201845.GA29589@agluck-desk2.amr.corp.intel.com>
References: <cover.1565940653.git.rahul.tanwar@linux.intel.com>
 <83345984845d24b6ce97a32bef21cd0bbdffc86d.1565940653.git.rahul.tanwar@linux.intel.com>
 <20190820122233.GN2332@hirez.programming.kicks-ass.net>
 <1D9AE27C-D412-412D-8FE8-51B625A7CC98@intel.com>
 <20190820145735.GW2332@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190820145735.GW2332@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 20, 2019 at 04:57:35PM +0200, Peter Zijlstra wrote:
> On Tue, Aug 20, 2019 at 12:48:05PM +0000, Luck, Tony wrote:
> > 
> > >> +#define INTEL_FAM6_ATOM_AIRMONT_NP    0x75 /* Lightning Mountain */
> > > 
> > > What's _NP ?
> > 
> > Network Processor. But that is too narrow a descriptor. This is going to be used in
> > other areas besides networking. 
> > 
> > I’m contemplating calling it AIRMONT2
> 
> What would describe the special sause that warranted a new SOC? If this
> thing is marketed as 'Network Processor' then I suppose we can actually
> use it, esp. if we're going to see this more, like the MID thing -- that
> lived for a while over multiple uarchs.

The reasons for allocating a new model number are a mystery.
I've seen cases where I thought we'd get a new numnber for sure,
but then just bumped the stepping. I've also seen us allocate a
new number when it didn't look needed (to me, from my OS perspective).

As I mentioned above, there are some folks internally that think
NP == Network Processor is too narrow a pigeonhole for this CPU.

But _NPAOS (Network Processor And Other Stuff) doesn't sound helpful.

> Note that for the big cores we added the NNPI thing, which was for
> Neural Network Processing something.

I'm sure that we will invent all sorts of strings for the "OPTDIFF"
part of the name (many of which will only be used once or twice).

Rationale for "AIRMONT2" is that this is derived from Airmont. So
you'd expect many model specific bits of code to do the same for
this as they did for plain AIRMONT. But in a few corner cases there
will be separate code.

Perhaps I need to update the rubric that I just added to the
head on intel-family.h to say that the MICROARCH element may
be followed by an optional number to differentiate SOCs that
use essentially the same core, but have different model numbers
because of SOC differences outside of the core.

-Tony
