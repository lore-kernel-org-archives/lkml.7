Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8174C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 13:04:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85803233FF
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 13:04:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbfH1NEU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 09:04:20 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47109 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726829AbfH1NER (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 09:04:17 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i2xcF-0003gZ-UP; Wed, 28 Aug 2019 15:04:00 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 87D721C07D2;
        Wed, 28 Aug 2019 15:03:59 +0200 (CEST)
Date:   Wed, 28 Aug 2019 13:03:59 -0000
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/intel: Add common OPTDIFFs
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Tony Luck <tony.luck@intel.com>, x86@kernel.org,
        Dave Hansen <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20190827195122.731530141@infradead.org>
References: <20190827195122.731530141@infradead.org>
MIME-Version: 1.0
Message-ID: <156699743938.803.7550804819762120552.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     a3d8c0d13bdedf84fe74259f6949b2cdffd80e55
Gitweb:        https://git.kernel.org/tip/a3d8c0d13bdedf84fe74259f6949b2cdffd80e55
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 27 Aug 2019 21:48:25 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 28 Aug 2019 11:29:32 +02:00

x86/intel: Add common OPTDIFFs

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Cc: x86@kernel.org
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Borislav Petkov <bp@alien8.de>
Link: https://lkml.kernel.org/r/20190827195122.731530141@infradead.org
---
 arch/x86/include/asm/intel-family.h | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/intel-family.h b/arch/x86/include/asm/intel-family.h
index 76dc9ab..5c05b2d 100644
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
