Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12584C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 15:07:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAA592067D
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 15:07:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405670AbfIFPHc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 11:07:32 -0400
Received: from mga02.intel.com ([134.134.136.20]:1619 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730480AbfIFPHb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 11:07:31 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Sep 2019 08:07:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,473,1559545200"; 
   d="scan'208";a="267388494"
Received: from spandruv-mobl3.jf.intel.com ([10.251.22.142])
  by orsmga001.jf.intel.com with ESMTP; 06 Sep 2019 08:07:30 -0700
Message-ID: <b8c7bd1204f7b4f75a5bccec4d7c41b1225928f7.camel@linux.intel.com>
Subject: Re: [PATCH 2/2] tools/power/x86/intel-speed-select: Display core
 count for bucket
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@intel.com>,
        Prarit Bhargava <prarit@redhat.com>
Cc:     darcari@redhat.com, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Date:   Fri, 06 Sep 2019 08:07:29 -0700
In-Reply-To: <6b576770a4bbe6c24ea524083dec5a16bf3c9e94.camel@linux.intel.com>
References: <20190905233748.6822-1-srinivas.pandruvada@linux.intel.com>
         <20190905233748.6822-2-srinivas.pandruvada@linux.intel.com>
         <780a3faf-9e44-64f4-a354-bdee39af3af5@redhat.com>
         <20190906134655.GU2680@smile.fi.intel.com>
         <6b576770a4bbe6c24ea524083dec5a16bf3c9e94.camel@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-3.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-09-06 at 07:50 -0700, Srinivas Pandruvada wrote:
> On Fri, 2019-09-06 at 16:46 +0300, Andy Shevchenko wrote:
> > On Fri, Sep 06, 2019 at 05:39:54AM -0400, Prarit Bhargava wrote:
> > > On 9/5/19 7:37 PM, Srinivas Pandruvada wrote:
> > > > Read the bucket and core count relationship via MSR and display
> > > > when displaying turbo ratio limits.
> > > > +	ret = isst_send_msr_command(cpu, 0x1ae, 0,
> > > > buckets_info);
> > > 
> > > ^^^ you can get rid of the magic number 0x1ae by doing (sorry for
> > > the cut-and-paste)
> > > 
> > > diff --git a/tools/power/x86/intel-speed-select/Makefile
> > > b/tools/power/x86/intel
> > > index 12c6939dca2a..087d802ad844 100644
> > > --- a/tools/power/x86/intel-speed-select/Makefile
> > > +++ b/tools/power/x86/intel-speed-select/Makefile
> > > @@ -15,6 +15,8 @@ endif
> > >  MAKEFLAGS += -r
> > > 
> > >  override CFLAGS += -O2 -Wall -g -D_GNU_SOURCE -I$(OUTPUT)include
> > > +override CFLAGS += -I../../../include
> > > +override CFLAGS +=
> > > -DMSRHEADER='"../../../../arch/x86/include/asm/msr-index.h"'
> 
> No, we can't use msr_index.
This comment was meant for use of /dev/cpu/X/msr not msr_index.
I didn't want to bring in dependency on msr-index.h for couple of 2
MSRs and the names in msr-index.h doesn't really reflect the actual
processing, they are doing. For example MSR_TURBO_RATIO_LIMIT1 for
0x1ae. The definition of 0x1AE is different on cpu model 0x55 and
beyond.

> 
> > 
> > I guess it can be done in more neat way.
> > 
> > > As I've been looking at this code I have been wondering why
> > > didn't
> > > you just use
> > > the standard /dev/cpu/X/msr interface that other x86 power
> > > utilities (turbostat,
> > > x86_energy_perf_policy) use?  Implementing msr_read() is trivial
> > > (warning
> > > untested and uncompiled code)
> 
> No. We can't. The MSR interface is disabled on several distribution
> and
> platforms with secured boot. So some special MSRs are only allowed
> via
> this IOCTL interface.
> 
> Thanks,
> Srinivas
> 
> 
> > 
> > Actually good point!
> > 

