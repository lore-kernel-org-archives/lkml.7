Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63167C31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 18:01:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 468AA2183E
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 18:01:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727637AbfFNSB6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 14:01:58 -0400
Received: from mga02.intel.com ([134.134.136.20]:54810 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726801AbfFNSB4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 14:01:56 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jun 2019 10:59:25 -0700
X-ExtLoop1: 1
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by orsmga006.jf.intel.com with ESMTP; 14 Jun 2019 10:59:24 -0700
Date:   Fri, 14 Jun 2019 10:49:59 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, H Peter Anvin <hpa@zytor.com>,
        Christopherson Sean J <sean.j.christopherson@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [RFC PATCH 1/3] x86/resctrl: Get max rmid and occupancy scale
 directly from CPUID instead of cpuinfo_x86
Message-ID: <20190614174959.GF198207@romley-ivt3.sc.intel.com>
References: <1560459064-195037-1-git-send-email-fenghua.yu@intel.com>
 <1560459064-195037-2-git-send-email-fenghua.yu@intel.com>
 <20190614111633.GC2586@zn.tnic>
 <20190614165528.GE198207@romley-ivt3.sc.intel.com>
 <20190614174701.GN2586@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190614174701.GN2586@zn.tnic>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 14, 2019 at 07:47:01PM +0200, Borislav Petkov wrote:
> On Fri, Jun 14, 2019 at 09:55:28AM -0700, Fenghua Yu wrote:
> > When this function is called, X86_FEATURE_CQM_LLC must be supported and
> > one of X86_FEATURE_CQM_OCCUP_LLC, X86_FEATURE_CQM_MBM_LOCAL, and
> > X86_FEATURE_CQM_MBM_TOTAL must be supported. Otherwise,
> > get_rdt_mon_resource() is returned before calling rdt_get_mon_l3_config().
> > 
> > So CPUID.f.0 and CPUID.f.1 must be readable and return meaningful
> > data without testing the features.
> 
> How's that?
> 
> static void __init get_cqm_info(struct rdt_resource *r)
> {
>         u32 eax, ebx, ecx, edx;
> 
>         /*
>          * At this point, CQM LLC and one of occupancy, MBM total, and
>          * MBM local monitoring features must be supported.
>          */
>         cpuid_count(0xf, 1, &eax, &ebx, &ecx, &edx);
> 
>         if (rdt_mon_features & QOS_L3_OCCUP_EVENT_ID)
>                 r->num_rmid = ecx + 1;
>         else
>                 /*
>                  * Fallback maximum range (zero-based) of RMID within
>                  * this physical processor of all types, in subleaf 0,
>                  * EBX.
>                  */
>                 r->num_rmid = cpuid_ebx(0xf) + 1;
> 
>         if (rdt_mon_features & (QOS_L3_MBM_TOTAL_EVENT_ID |
>                                 QOS_L3_MBM_LOCAL_EVENT_ID))
>                 r->mon_scale = ebx;
> 	else
>                 r->mon_scale = -1;
> }

This is much better and cleaner! I will copy your code to patch 0001
in the next version.

Thanks.

-Fenghua
