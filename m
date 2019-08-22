Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0156FC3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 20:35:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC9D123401
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 20:35:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393294AbfHVUfp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 16:35:45 -0400
Received: from mga01.intel.com ([192.55.52.88]:17846 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387798AbfHVUfp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 16:35:45 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Aug 2019 13:35:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,418,1559545200"; 
   d="scan'208";a="208307620"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.68])
  by fmsmga002.fm.intel.com with ESMTP; 22 Aug 2019 13:35:43 -0700
Date:   Thu, 22 Aug 2019 13:35:44 -0700
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
Subject: [PATCH] x86/cpu: Add new Airmont variant to Intel family
Message-ID: <20190822203544.GA10229@agluck-desk2.amr.corp.intel.com>
References: <cover.1565940653.git.rahul.tanwar@linux.intel.com>
 <83345984845d24b6ce97a32bef21cd0bbdffc86d.1565940653.git.rahul.tanwar@linux.intel.com>
 <20190820122233.GN2332@hirez.programming.kicks-ass.net>
 <1D9AE27C-D412-412D-8FE8-51B625A7CC98@intel.com>
 <20190820145735.GW2332@hirez.programming.kicks-ass.net>
 <20190821201845.GA29589@agluck-desk2.amr.corp.intel.com>
 <20190822102955.GS2369@hirez.programming.kicks-ass.net>
 <20190822185347.GA8933@agluck-desk2.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190822185347.GA8933@agluck-desk2.amr.corp.intel.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 22, 2019 at 11:53:47AM -0700, Luck, Tony wrote:
> On Thu, Aug 22, 2019 at 12:29:55PM +0200, Peter Zijlstra wrote:
> > On Wed, Aug 21, 2019 at 01:18:46PM -0700, Luck, Tony wrote:
> > > On Tue, Aug 20, 2019 at 04:57:35PM +0200, Peter Zijlstra wrote:
> > 
> > > As I mentioned above, there are some folks internally that think
> > > NP == Network Processor is too narrow a pigeonhole for this CPU.
> > > 
> > > But _NPAOS (Network Processor And Other Stuff) doesn't sound helpful.
> > 
> > So what is 'other stuff'; is there really no general term that describes
> > well what's been done to this SoC; or is it secret and we're in a catch
> > 22 here?
> 
> Since CPU model number is one of the early bits of disclosure
> in order to get support upstream in time for launch, safe to
> assume that some products will not want to advertise everything
> that far ahead.
> 
> > > > Note that for the big cores we added the NNPI thing, which was for
> > > > Neural Network Processing something.
> > > 
> > > I'm sure that we will invent all sorts of strings for the "OPTDIFF"
> > > part of the name (many of which will only be used once or twice).
> > 
> > That's a bit sad; because as shown by the patches just send out; there
> > really isn't _that_ much variation right now.
> > 
> > Anyway, lets just give the thing a name; _NP whatever, and we can
> > rename it if needed.
> 
> Your other patch series shows that you aren't afraid
> of a little churn. So sure, we can go with _NP for now
> and fix it up later.  It's not like some OEM is going
> to make a CPU selection based on the #define name that
> we gave it in Linux :-)

From: Tony Luck <tony.luck@intel.com>

One of the use cases for this processor is as a network
processor. So give it an "_NP" tag for now. Could be changed
later if it turns out to group with some other tag.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/include/asm/intel-family.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/include/asm/intel-family.h b/arch/x86/include/asm/intel-family.h
index 5c05b2d389c3..23ed388a3a56 100644
--- a/arch/x86/include/asm/intel-family.h
+++ b/arch/x86/include/asm/intel-family.h
@@ -95,6 +95,7 @@
 
 #define INTEL_FAM6_ATOM_AIRMONT		0x4C /* Cherry Trail, Braswell */
 #define INTEL_FAM6_ATOM_AIRMONT_MID	0x5A /* Moorefield */
+#define INTEL_FAM6_ATOM_AIRMONT_NP	0x75 /* Lightning Mountain */
 
 #define INTEL_FAM6_ATOM_GOLDMONT	0x5C /* Apollo Lake */
 #define INTEL_FAM6_ATOM_GOLDMONT_D	0x5F /* Denverton */
-- 
2.20.1

