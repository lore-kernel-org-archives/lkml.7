Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86E8EC3A589
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 18:30:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F9312063F
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 18:30:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732153AbfHOSa4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 14:30:56 -0400
Received: from mga09.intel.com ([134.134.136.24]:34636 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730405AbfHOSa4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 14:30:56 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Aug 2019 11:30:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,389,1559545200"; 
   d="scan'208";a="178539743"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.68])
  by fmsmga007.fm.intel.com with ESMTP; 15 Aug 2019 11:30:55 -0700
Date:   Thu, 15 Aug 2019 11:30:55 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS, x86/CPU: Tony Luck will maintain
 asm/intel-family.h
Message-ID: <20190815183055.GA6847@agluck-desk2.amr.corp.intel.com>
References: <20190814234030.30817-1-tony.luck@intel.com>
 <20190815075822.GC15313@zn.tnic>
 <20190815172159.GA4935@agluck-desk2.amr.corp.intel.com>
 <20190815175455.GJ15313@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190815175455.GJ15313@zn.tnic>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 15, 2019 at 07:54:55PM +0200, Borislav Petkov wrote:
> On Thu, Aug 15, 2019 at 10:21:59AM -0700, Luck, Tony wrote:
> > Like this?
> 
> Actually, I was thinking you'd put it above the defines in the file
> intel-family.h itself so that *everyone* who wants to add a model, sees
> it first and while that explanation below is very nice...

V2 ... ugh ... C doesn't do well with nested comments, so the example
has issues.  I chose to use a C++ style comment (as they are not as
verboten in Linux as they used to be).

Another option would be to put the instructions inside #if 0 ... #endif
but that seems less than ideal.

Any other ideas?

-Tony

From 84624a3410a3ba03c3acb13e54b1292c3ca64b8c Mon Sep 17 00:00:00 2001
From: Tony Luck <tony.luck@intel.com>
Date: Thu, 15 Aug 2019 11:16:24 -0700
Subject: [PATCH] x86/cpu: Explain Intel model naming convention

Dave Hansen spelled out the rules in an e-mail:

 https://lkml.kernel.org/r/91eefbe4-e32b-d762-be4d-672ff915db47@intel.com

Copy those right into the <asm/intel-family.h> file to
make it easy for people to find them.

Suggested-by: Borislav Petkov <bp@alien8.de>
Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/include/asm/intel-family.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/x86/include/asm/intel-family.h b/arch/x86/include/asm/intel-family.h
index 0278aa66ef62..87443df77eee 100644
--- a/arch/x86/include/asm/intel-family.h
+++ b/arch/x86/include/asm/intel-family.h
@@ -11,6 +11,21 @@
  * While adding a new CPUID for a new microarchitecture, add a new
  * group to keep logically sorted out in chronological order. Within
  * that group keep the CPUID for the variants sorted by model number.
+ *
+ * HOWTO Build an INTEL_FAM6_ definition:
+ * 
+ * 1. Start with INTEL_FAM6_
+ * 2. If not Core-family, add a note about it, like "ATOM".  There are only
+ *    two options for this (Xeon Phi and Atom).  It is exceedingly unlikely
+ *    that you are adding a cpu which needs a new option here.
+ * 3. Add the processor microarchitecture, not the platform name
+ * 4. Add a short differentiator if necessary.  Add an _X to differentiate
+ *    Server from Client.
+ * 5. Add an optional comment with the platform name(s)
+ * 
+ * It should end up looking like this:
+ * 
+ * INTEL_FAM6_<ATOM?>_<MICROARCH>_<SHORT...> // Platform Name(s)
  */
 
 #define INTEL_FAM6_CORE_YONAH		0x0E
-- 
2.20.1

