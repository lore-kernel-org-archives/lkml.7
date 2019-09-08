Return-Path: <SRS0=sd1o=XD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33FF2C4332F
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 14:13:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 142B0214DB
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 14:13:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728992AbfIHONx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Sep 2019 10:13:53 -0400
Received: from mga06.intel.com ([134.134.136.31]:46904 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725921AbfIHONx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Sep 2019 10:13:53 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Sep 2019 07:13:52 -0700
X-IronPort-AV: E=Sophos;i="5.64,481,1559545200"; 
   d="scan'208";a="195932756"
Received: from spandruv-mobl.amr.corp.intel.com ([10.252.4.36])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Sep 2019 07:13:49 -0700
Message-ID: <4a2489611fedaaa60bdd54aafbe0e24b005995cc.camel@linux.intel.com>
Subject: Re: [PATCH 2/2] tools/power/x86/intel-speed-select: Display core
 count for bucket
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Prarit Bhargava <prarit@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@intel.com>,
        David Arcari <darcari@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Date:   Sun, 08 Sep 2019 07:13:47 -0700
In-Reply-To: <533a8c7c-d309-9b65-d973-120ae3e9f8b4@redhat.com>
References: <20190905233748.6822-1-srinivas.pandruvada@linux.intel.com>
         <20190905233748.6822-2-srinivas.pandruvada@linux.intel.com>
         <780a3faf-9e44-64f4-a354-bdee39af3af5@redhat.com>
         <20190906134655.GU2680@smile.fi.intel.com>
         <6b576770a4bbe6c24ea524083dec5a16bf3c9e94.camel@linux.intel.com>
         <b8c7bd1204f7b4f75a5bccec4d7c41b1225928f7.camel@linux.intel.com>
         <CAHp75Vc9xMPW38Toh2jKv9YYYNV16837aAcXKMP6WaM-L8zcSQ@mail.gmail.com>
         <533a8c7c-d309-9b65-d973-120ae3e9f8b4@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2019-09-08 at 05:46 -0400, Prarit Bhargava wrote:
> 
> On 9/7/19 2:18 PM, Andy Shevchenko wrote:
> > On Fri, Sep 6, 2019 at 10:47 PM Srinivas Pandruvada
> > <srinivas.pandruvada@linux.intel.com> wrote:
> > > 
> > > On Fri, 2019-09-06 at 07:50 -0700, Srinivas Pandruvada wrote:
> > > > On Fri, 2019-09-06 at 16:46 +0300, Andy Shevchenko wrote:
> > > > > On Fri, Sep 06, 2019 at 05:39:54AM -0400, Prarit Bhargava
> > > > > wrote:
> > > > > > On 9/5/19 7:37 PM, Srinivas Pandruvada wrote:
> > > > > > > Read the bucket and core count relationship via MSR and
> > > > > > > display
> > > > > > > when displaying turbo ratio limits.
> > > > > > > +       ret = isst_send_msr_command(cpu, 0x1ae, 0,
> > > > > > > buckets_info);
> > > > > > 
> > > > > > ^^^ you can get rid of the magic number 0x1ae by doing
> > > > > > (sorry for
> > > > > > the cut-and-paste)
> > > > > > 
> > > > > > diff --git a/tools/power/x86/intel-speed-select/Makefile
> > > > > > b/tools/power/x86/intel
> > > > > > index 12c6939dca2a..087d802ad844 100644
> > > > > > --- a/tools/power/x86/intel-speed-select/Makefile
> > > > > > +++ b/tools/power/x86/intel-speed-select/Makefile
> > > > > > @@ -15,6 +15,8 @@ endif
> > > > > >  MAKEFLAGS += -r
> > > > > > 
> > > > > >  override CFLAGS += -O2 -Wall -g -D_GNU_SOURCE
> > > > > > -I$(OUTPUT)include
> > > > > > +override CFLAGS += -I../../../include
> > > > > > +override CFLAGS +=
> > > > > > -DMSRHEADER='"../../../../arch/x86/include/asm/msr-
> > > > > > index.h"'
> > > > 
> > > > No, we can't use msr_index.
> > > 
> > > This comment was meant for use of /dev/cpu/X/msr not msr_index.
> > > I didn't want to bring in dependency on msr-index.h for couple of
> > > 2
> > > MSRs and the names in msr-index.h doesn't really reflect the
> > > actual
> > > processing, they are doing. For example MSR_TURBO_RATIO_LIMIT1
> > > for
> > > 0x1ae. The definition of 0x1AE is different on cpu model 0x55 and
> > > beyond.
> > > 
> > > > 
> > 
> > It seems not applicable on top of tools patch series I had applied
> > before.
> > 
> > > > > 
> > > > > I guess it can be done in more neat way.
> > > > > 
> > > > > > As I've been looking at this code I have been wondering why
> > > > > > didn't
> > > > > > you just use
> > > > > > the standard /dev/cpu/X/msr interface that other x86 power
> > > > > > utilities (turbostat,
> > > > > > x86_energy_perf_policy) use?  Implementing msr_read() is
> > > > > > trivial
> > > > > > (warning
> > > > > > untested and uncompiled code)
> > > > 
> > > > No. We can't. The MSR interface is disabled on several
> > > > distribution
> > > > and
> > > > platforms with secured boot. So some special MSRs are only
> > > > allowed
> > > > via
> > > > this IOCTL interface.
> > > > 
> 
> Which distros don't have /dev/cpu/X/msr ?
Google "UEFI Secure Boot" 
The patch for kernel lock down was from RedHat, which restricted MSRs!

> 
> None of other Intel tools have this restriction (or requirement
> depending on
> your point of view).  Why is intel-speed-select special that we have
> to
> jump through hoops?

Not sure why you call jumping hoops here. You are comparing debug tools
with run time service from kernel for Intel speed select.

This is not about tool. This tool is giving example how user spaces can
control SST features through a kernel interface which should work with
any distribution including home grown distros. And this interface is
not for testing like turbostat or similar. So if any orchestration
software can send same message as this tool and able to control SST
features whether there is MSR access is there or not.

Also you are missing feature for save/restore state after
suspend/resume.



> 
> P.
> 
> > > > Thanks,
> > > > Srinivas
> > > > 
> > > > 
> > > > > 
> > > > > Actually good point!
> > > > > 
> > 
> > 

