Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4477AC3A59B
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 17:22:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22F6520578
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 17:22:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732213AbfHORWB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 13:22:01 -0400
Received: from mga14.intel.com ([192.55.52.115]:16225 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732171AbfHORWA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 13:22:00 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Aug 2019 10:21:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,389,1559545200"; 
   d="scan'208";a="178523176"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.68])
  by fmsmga007.fm.intel.com with ESMTP; 15 Aug 2019 10:21:59 -0700
Date:   Thu, 15 Aug 2019 10:21:59 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS, x86/CPU: Tony Luck will maintain
 asm/intel-family.h
Message-ID: <20190815172159.GA4935@agluck-desk2.amr.corp.intel.com>
References: <20190814234030.30817-1-tony.luck@intel.com>
 <20190815075822.GC15313@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190815075822.GC15313@zn.tnic>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 15, 2019 at 09:58:22AM +0200, Borislav Petkov wrote:
> On Wed, Aug 14, 2019 at 04:40:30PM -0700, Tony Luck wrote:
> > There are a few different subsystems in the kernel that depend on
> > model specific behaviour (perf, EDAC, power, ...). Easier for just
> > one person to have the task to get new model numbers included instead
> > of having these groups trip over each other to do it.
> > 
> > Signed-off-by: Tony Luck <tony.luck@intel.com>
> > ---
> >  MAINTAINERS | 6 ++++++
> >  1 file changed, 6 insertions(+)
> 
> Applied, thanks.
> 
> As a first order of business, pls sum up the naming scheme convention
> you guys are going to adhere to so that it is clear to everybody:
> 
> https://lkml.kernel.org/r/91eefbe4-e32b-d762-be4d-672ff915db47@intel.com
> 
> in a patch form. :)


Like this?

From 364e337ec2008442a8a77cf919fbf499b297b3f4 Mon Sep 17 00:00:00 2001
From: Tony Luck <tony.luck@intel.com>
Date: Thu, 15 Aug 2019 10:04:18 -0700
Subject: [PATCH] Documentation: x86: Explain Intel model naming convention

This was written in an e-mail by Dave Hansen, but not everybody
reads the entire LKML archive before posting a patch.

https://lkml.kernel.org/r/91eefbe4-e32b-d762-be4d-672ff915db47@intel.com

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 Documentation/x86/index.rst            |  1 +
 Documentation/x86/intel-cpu-models.rst | 37 ++++++++++++++++++++++++++
 2 files changed, 38 insertions(+)
 create mode 100644 Documentation/x86/intel-cpu-models.rst

diff --git a/Documentation/x86/index.rst b/Documentation/x86/index.rst
index af64c4bb4447..6ba9e9cc5938 100644
--- a/Documentation/x86/index.rst
+++ b/Documentation/x86/index.rst
@@ -19,6 +19,7 @@ x86-specific Documentation
    tlb
    mtrr
    pat
+   intel-cpu-models
    intel_mpx
    intel-iommu
    intel_txt
diff --git a/Documentation/x86/intel-cpu-models.rst b/Documentation/x86/intel-cpu-models.rst
new file mode 100644
index 000000000000..75b5267a5354
--- /dev/null
+++ b/Documentation/x86/intel-cpu-models.rst
@@ -0,0 +1,37 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=======================
+Intel CPU model numbers
+=======================
+
+The CPU model number on a running system can be found by executing
+the CPUID(EAX=0) instruction to find the vendor, family, model
+and stepping.  The model number is found by concatenating two bit
+fields from the EAX return value. Bits 19:16 (extended model number)
+and 7:4 (model number).
+
+Inside the Linux kernel the vendor, family, model and stepping are
+stored in the cpuinfo_x86 structure. Model specific code typically
+uses x86_match_cpu() to determine if it is running on any of some
+list of CPU models.
+
+There are several subsystems that need model specific handling on
+Intel CPUs. For code legibility it is better to assign names for
+the various model numbers in the include file <asm/intel-family.h>
+
+Currently all interesting Intel CPU models are in family 6.
+
+HOWTO Build an INTEL_FAM6_ definition:
+
+1. Start with INTEL_FAM6_
+2. If not Core-family, add a note about it, like "ATOM".  There are only
+   two options for this (Xeon Phi and Atom).  It is exceedingly unlikely
+   that you are adding a cpu which needs a new option here.
+3. Add the processor microarchitecture, not the platform name
+4. Add a short differentiator if necessary.  Add an _X to differentiate
+   Server from Client.
+5. Add an optional comment with the platform name(s)
+
+It should end up looking like this:
+
+INTEL_FAM6_<ATOM?>_<MICROARCH>_<SHORT...> /* Platform Name */
-- 
2.20.1

