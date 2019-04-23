Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A0C3C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 09:08:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65DE220674
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 09:08:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="P7vNHkjX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbfDWJI5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 05:08:57 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:51944 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725888AbfDWJI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 05:08:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=RfXhvFzNh2NmHm6BVWXsN7mAOe1Vtl6T9nfC2Mr+z0A=; b=P7vNHkjXHhku/Hm3TA/2LaUdu
        aBfxwtEddeb3OMvmdoOrErcUUpda2retRHH9XJJ7Z8Dd3AMyEuG1iQNovZa8sGL1R9MA3qqRyr6wP
        cSRN974upjlFDxOZBV1CP6Na2Y5Xwt0OtSFaEKin5Pk5+SJtxeGOIBrdoOTc3EShfpuqTklNIlMqG
        hWoZhh9Gzx9Qb66JbGyaAiIAWkUUG3f4MS2/L/k5DBe1EwTSIq/I9fTcjAOyVDPp+8vM4nG0fG/0N
        e3BdjXXVOvXSTxFZrNbRFYjyRIfYLAAAngDVJduK10G12FlRli5wdwoe69V1GN7vr+Xnz6veuFcRW
        Y8D/koNsg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hIrQ3-0008Qa-2J; Tue, 23 Apr 2019 09:08:51 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7E6BE29B47DCD; Tue, 23 Apr 2019 11:08:49 +0200 (CEST)
Date:   Tue, 23 Apr 2019 11:08:49 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Daniel Drake <drake@endlessm.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org, len.brown@intel.com,
        rafael.j.wysocki@intel.com, linux@endlessm.com
Subject: Re: [PATCH 1/2] x86/tsc: use CPUID.0x16 to calculate missing crystal
 frequency
Message-ID: <20190423090849.GH11158@hirez.programming.kicks-ass.net>
References: <20190422101526.28415-1-drake@endlessm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190422101526.28415-1-drake@endlessm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 22, 2019 at 06:15:25PM +0800, Daniel Drake wrote:
> Additionally, crystal clock frequency for platforms that were missing
> from the list (e.g. SKYLAKE_X) will now be provided.

Well, SKX isn't exactly 'missing'; it would be very good if we can
confirm the new code is still correct under the below mentioned
conditions.

---

commit b511203093489eb1829cb4de86e8214752205ac6
Author: Len Brown <len.brown@intel.com>
Date:   Fri Dec 22 00:27:55 2017 -0500

    x86/tsc: Fix erroneous TSC rate on Skylake Xeon
    
    The INTEL_FAM6_SKYLAKE_X hardcoded crystal_khz value of 25MHZ is
    problematic:
    
     - SKX workstations (with same model # as server variants) use a 24 MHz
       crystal.  This results in a -4.0% time drift rate on SKX workstations.
    
     - SKX servers subject the crystal to an EMI reduction circuit that reduces its
       actual frequency by (approximately) -0.25%.  This results in -1 second per
       10 minute time drift as compared to network time.
    
    This issue can also trigger a timer and power problem, on configurations
    that use the LAPIC timer (versus the TSC deadline timer).  Clock ticks
    scheduled with the LAPIC timer arrive a few usec before the time they are
    expected (according to the slow TSC).  This causes Linux to poll-idle, when
    it should be in an idle power saving state.  The idle and clock code do not
    graciously recover from this error, sometimes resulting in significant
    polling and measurable power impact.
    
    Stop using native_calibrate_tsc() for INTEL_FAM6_SKYLAKE_X.
    native_calibrate_tsc() will return 0, boot will run with tsc_khz = cpu_khz,
    and the TSC refined calibration will update tsc_khz to correct for the
    difference.
    
    [ tglx: Sanitized change log ]
    
    Fixes: 6baf3d61821f ("x86/tsc: Add additional Intel CPU models to the crystal quirk list")
    Signed-off-by: Len Brown <len.brown@intel.com>
    Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
    Cc: peterz@infradead.org
    Cc: Prarit Bhargava <prarit@redhat.com>
    Cc: stable@vger.kernel.org
    Link: https://lkml.kernel.org/r/ff6dcea166e8ff8f2f6a03c17beab2cb436aa779.1513920414.git.len.brown@intel.com

diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index ce4b71119c36..3bf4df7f52d7 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -602,7 +602,6 @@ unsigned long native_calibrate_tsc(void)
 		case INTEL_FAM6_KABYLAKE_DESKTOP:
 			crystal_khz = 24000;	/* 24.0 MHz */
 			break;
-		case INTEL_FAM6_SKYLAKE_X:
 		case INTEL_FAM6_ATOM_DENVERTON:
 			crystal_khz = 25000;	/* 25.0 MHz */
 			break;
