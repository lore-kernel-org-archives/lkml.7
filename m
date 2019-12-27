Return-Path: <SRS0=GVTe=2R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49845C2D0DD
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 18:04:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 280EB21775
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 18:04:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="ASV7Z7+/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728824AbfL0SEF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Dec 2019 13:04:05 -0500
Received: from sv2-smtprelay2.synopsys.com ([149.117.73.133]:38874 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727805AbfL0SEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Dec 2019 13:04:00 -0500
Received: from mailhost.synopsys.com (mdc-mailhost2.synopsys.com [10.225.0.210])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 209E442CED;
        Fri, 27 Dec 2019 18:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1577469839; bh=Hes0n05dCzlQLemBmu3FmAF+1sPDQGmnFX0t0kYnTls=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ASV7Z7+/bOTCx7iaXWb8kPRRMQDHN2iF8A+EXxt8yQe455/l85/eYsGGdM6y9xq7P
         Khj+fsn70hej3Cnzc7fpw/KC1sFBrd8hrsMKCsXP3WeUP3wWoo++0hHlrd6Cjaqnci
         sW1HVG88AC6BhS1g8z2JN71Su/lPbeC+bW++pglfEPS+zlvU3/r2SAtSURIgWBmC9N
         8YPRz7rRfqwwNR1PPmX5RW6kJjjAcaVY5pPqSuKSIm2CeevuvxUJFaDYxKVDkXFGGT
         +21PJnTVCJe58+ALzkZ+8BqkvRl1H8UsjXlUduvSuXZEV6zVjf8rXxxguV2iUAhovV
         RwLAGsbMvLGEQ==
Received: from paltsev-e7480.internal.synopsys.com (unknown [10.121.8.65])
        by mailhost.synopsys.com (Postfix) with ESMTP id 6B1CBA0067;
        Fri, 27 Dec 2019 18:03:56 +0000 (UTC)
From:   Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To:     linux-snps-arc@lists.infradead.org,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Subject: [PATCH 2/5] ARC: add helpers to sanitize config options
Date:   Fri, 27 Dec 2019 21:03:44 +0300
Message-Id: <20191227180347.3579-3-Eugeniy.Paltsev@synopsys.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191227180347.3579-1-Eugeniy.Paltsev@synopsys.com>
References: <20191227180347.3579-1-Eugeniy.Paltsev@synopsys.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We'll use this macro in coming patches extensively.

Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
---
 arch/arc/kernel/setup.c | 29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/arch/arc/kernel/setup.c b/arch/arc/kernel/setup.c
index 7ee89dc61f6e..edb55b6ee278 100644
--- a/arch/arc/kernel/setup.c
+++ b/arch/arc/kernel/setup.c
@@ -389,11 +389,23 @@ static char *arc_extn_mumbojumbo(int cpu_id, char *buf, int len)
 	return buf;
 }
 
+static void chk_opt_strict(char *opt_name, bool hw_exists, bool opt_ena)
+{
+	if (hw_exists && !opt_ena)
+		pr_warn(" ! Enable %s for working apps\n", opt_name);
+	else if (!hw_exists && opt_ena)
+		panic("Disable %s, hardware NOT present\n", opt_name);
+}
+
+#define CHK_OPT_STRICT(opt_name, hw_exists)				\
+({									\
+	chk_opt_strict(#opt_name, hw_exists, IS_ENABLED(opt_name));	\
+})
+
 static void arc_chk_core_config(void)
 {
 	struct cpuinfo_arc *cpu = &cpuinfo_arc700[smp_processor_id()];
-	int saved = 0, present = 0;
-	char *opt_nm = NULL;
+	int present = 0;
 
 	if (!cpu->extn.timer0)
 		panic("Timer0 is not present!\n");
@@ -425,23 +437,14 @@ static void arc_chk_core_config(void)
 	 */
 
 	if (is_isa_arcompact()) {
-		opt_nm = "CONFIG_ARC_FPU_SAVE_RESTORE";
-		saved = IS_ENABLED(CONFIG_ARC_FPU_SAVE_RESTORE);
-
 		/* only DPDP checked since SP has no arch visible regs */
 		present = cpu->extn.fpu_dp;
+		CHK_OPT_STRICT(CONFIG_ARC_FPU_SAVE_RESTORE, present);
 	} else {
-		opt_nm = "CONFIG_ARC_HAS_ACCL_REGS";
-		saved = IS_ENABLED(CONFIG_ARC_HAS_ACCL_REGS);
-
 		/* Accumulator Low:High pair (r58:59) present if DSP MPY or FPU */
 		present = cpu->extn_mpy.dsp | cpu->extn.fpu_sp | cpu->extn.fpu_dp;
+		CHK_OPT_STRICT(CONFIG_ARC_HAS_ACCL_REGS, present);
 	}
-
-	if (present && !saved)
-		pr_warn("Enable %s for working apps\n", opt_nm);
-	else if (!present && saved)
-		panic("Disable %s, hardware NOT present\n", opt_nm);
 }
 
 /*
-- 
2.21.0

