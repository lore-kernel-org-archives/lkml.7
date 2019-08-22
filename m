Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FBD8C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 10:27:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2259C233A2
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 10:27:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eVlrAYfd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387601AbfHVK1A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 06:27:00 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56016 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732978AbfHVK07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 06:26:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=DotA4iLQHzv00Y2V/yoKvVtA73fz51KfKrhIQUWvQ/A=; b=eVlrAYfdcJG6+boQHJJ67V4KC9
        QbHlfleONMxWazMENqrju+gkrvwQLKEz4QjyGgdQGgpHf8jEQXlHo4zRC76zDN3CEw8MlAGvtVfHx
        nXCCrySC8KOMw/dx4+ur5Hsh41NaRdWf8zPEO2ZGmBsWq2Zbaq3FFRljQgMxjF9hwmuHIbJInd1SC
        4EW2tUZqsG0Dn0OBEg+jRNaThJ6Cf4r+kfd2xkDyMDzE1xSghN6eLY2LtQE9eYsGpcbe6HsK4DFri
        SgKJ6OznuE7hxelqdcSlVojJywGHj5XPhCZMSr0rafQ54vGsqmaMHA7JARfChK82Zp8VFr05M8CsV
        +gd8V1lg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i0kIu-0008DM-Nt; Thu, 22 Aug 2019 10:26:52 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9003B30780C;
        Thu, 22 Aug 2019 12:26:18 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 6DF1720BD78F0; Thu, 22 Aug 2019 12:26:50 +0200 (CEST)
Message-Id: <20190822102411.393701010@infradead.org>
User-Agent: quilt/0.65
Date:   Thu, 22 Aug 2019 12:23:11 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, x86@kernel.org,
        Dave Hansen <dave.hansen@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>
Subject: [PATCH 5/5] x86/intel: Add common OPTDIFFs
References: <20190822102306.109718810@infradead.org>
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


