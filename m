Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBF3CC31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 17:50:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9176920896
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 17:50:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729108AbfFLRuh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 13:50:37 -0400
Received: from mga09.intel.com ([134.134.136.24]:17070 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725764AbfFLRuh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 13:50:37 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Jun 2019 10:50:36 -0700
X-ExtLoop1: 1
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by orsmga005.jf.intel.com with ESMTP; 12 Jun 2019 10:50:35 -0700
Date:   Wed, 12 Jun 2019 10:41:13 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, H Peter Anvin <hpa@zytor.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [RFC PATCH] x86/cpufeatures: Enumerate new AVX512 bfloat16
 instructions
Message-ID: <20190612174112.GG180343@romley-ivt3.sc.intel.com>
References: <1560186158-174788-1-git-send-email-fenghua.yu@intel.com>
 <20190610192026.GI5488@zn.tnic>
 <20190611181920.GC180343@romley-ivt3.sc.intel.com>
 <20190611194701.GJ31772@zn.tnic>
 <20190611222822.GD180343@romley-ivt3.sc.intel.com>
 <3E5A0FA7E9CA944F9D5414FEC6C712209D8F4253@ORSMSX106.amr.corp.intel.com>
 <20190612035908.GB32652@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190612035908.GB32652@zn.tnic>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 12, 2019 at 05:59:08AM +0200, Borislav Petkov wrote:
> On Wed, Jun 12, 2019 at 03:29:57AM +0000, Yu, Fenghua wrote:
> > My bad. I studied a bit more and found the patch #1 is not needed.
> 
> Why, I think you were spot-on:
> 
> "And the two variables are ONLY used in resctrl monitoring
> configuration. There is no need to store them in cpuinfo_x86 on each
> CPU."
> 
> That was a real overkill to put them in cpuinfo_x86. The information
> needed should simply be read out in rdt_get_mon_l3_config() and that's
> it - no need to global values to store them.
> 
> Now removing them should be in a separate patch so that review is easy.
> 
> Or am I missing an aspect?

x86_init_cache_qos() fnds the minimum number of rmid on all CPUs and
store it in boot_cpu_data.

If removing the two variables from cpuinfo_x86 and getting number of
rmid and occupancy scale in rdt_get_mon_l3_config() directly from
CPUID on the current CPU, we need to assume all CPUs have the same
number of rmid.

Is this a right assumption?

After think again, it might be a right assumption after all. AFAICT, each
Intel platform that supports resctrl has the same number of rmid on all
CPUs and there is no plan to have a resctrl platform that has different
numbers of rmid on CPUs.

So Ok, I will write the patch #1 that removes the two variables from
cpuinfo_x86 and gets the info directly from CPUID in rdt_get_mon_l3_config().

Thanks.

-Fenghua
