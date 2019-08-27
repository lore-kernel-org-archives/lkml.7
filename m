Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1BEDC3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 19:52:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EC2D20674
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 19:52:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Jk34QD+k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731389AbfH0TwR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 15:52:17 -0400
Received: from merlin.infradead.org ([205.233.59.134]:40496 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731304AbfH0TwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 15:52:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=DotA4iLQHzv00Y2V/yoKvVtA73fz51KfKrhIQUWvQ/A=; b=Jk34QD+kplnhZpigYMK5cBC1i7
        dhGf0sq5AcLhRXy2QBPuFIjNu5tpr0TAeGY+6iRa5GS9qZhE4XAsx2FC/jyX4BGM4Y/Yo1DHbIcbt
        rq2FXrtcpFaHcAoKBWNNm9NWgpSKQzYpewUuFMFKdG+VPjfWPr9l12eYYz/s7i/kyN98yoJ+g6gxI
        khKkw4SmpvmIe+8rYERHkUtR2zJ3ssXSXzi7FyWxVA7/rtfPGygwiWDi+nPsHvECGoYsNnLB6FkT1
        +fZPeZ8LFT0GHO+GnIsRlAGp4VYYz/HPX8uGrR4hL/tpt5Of4gRizyptBQ/gE83eRv22I0ceC0b8x
        Dq1hypvQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i2hVT-0007JS-CN; Tue, 27 Aug 2019 19:51:55 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4CA58307822;
        Tue, 27 Aug 2019 21:51:17 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 013D8203CEC0B; Tue, 27 Aug 2019 21:51:50 +0200 (CEST)
Message-Id: <20190827195122.731530141@infradead.org>
User-Agent: quilt/0.65
Date:   Tue, 27 Aug 2019 21:48:25 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, x86@kernel.org,
        Dave Hansen <dave.hansen@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>
Subject: [PATCH -v2 5/5] x86/intel: Add common OPTDIFFs
References: <20190827194820.378516765@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: x86@kernel.org
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tony Luck <tony.luck@intel.com>
---
 arch/x86/include/asm/intel-family.h |   21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

--- a/arch/x86/include/asm/intel-family.h
+++ b/arch/x86/include/asm/intel-family.h
@@ -5,9 +5,6 @@
 /*
  * "Big Core" Processors (Branded as Core, Xeon, etc...)
  *
- * The "_X" parts are generally the EP and EX Xeons, or the
- * "Extreme" ones, like Broadwell-E, or Atom microserver.
- *
  * While adding a new CPUID for a new microarchitecture, add a new
  * group to keep logically sorted out in chronological order. Within
  * that group keep the CPUID for the variants sorted by model number.
@@ -21,9 +18,19 @@
  * MICROARCH	Is the code name for the micro-architecture for this core.
  *		N.B. Not the platform name.
  * OPTDIFF	If needed, a short string to differentiate by market segment.
- *		Exact strings here will vary over time. _DESKTOP, _MOBILE, and
- *		_X (short for Xeon server) should be used when they are
- *		appropriate.
+ *
+ *		Common OPTDIFFs:
+ *
+ *			- regular client parts
+ *		_L	- regular mobile parts
+ *		_G	- parts with extra graphics on
+ *		_X	- regular server parts
+ *		_D	- micro server parts
+ *
+ *		Historical OPTDIFFs:
+ *
+ *		_EP	- 2 socket server parts
+ *		_EX	- 4+ socket server parts
  *
  * The #define line may optionally include a comment including platform names.
  */
@@ -91,6 +98,8 @@
 
 #define INTEL_FAM6_ATOM_GOLDMONT	0x5C /* Apollo Lake */
 #define INTEL_FAM6_ATOM_GOLDMONT_D	0x5F /* Denverton */
+
+/* Note: the micro-architecture is "Goldmont Plus" */
 #define INTEL_FAM6_ATOM_GOLDMONT_PLUS	0x7A /* Gemini Lake */
 
 #define INTEL_FAM6_ATOM_TREMONT_D	0x86 /* Jacobsville */


