Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31A75C31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 14:36:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 077412084A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 14:36:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="N9cRKrnx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728255AbfFQOgD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 10:36:03 -0400
Received: from terminus.zytor.com ([198.137.202.136]:33859 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725983AbfFQOgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 10:36:03 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5HEYqdr3458117
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 17 Jun 2019 07:34:52 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5HEYqdr3458117
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1560782092;
        bh=05KeCClXwy5E8ZTl4HM3IIhdTtCoZfeUo2GUiZQ+odE=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=N9cRKrnx6SZfawlM9xXRkxNmABBMxGnKY6E3zDV6W869lBRhZ54PizwtwI95KxWW1
         GuLO3rggqWuAAlk4pL31UCbdKkaLyTG1+Kt92wk/wpMIJDSFG5J65XA3i6JnSPlvKf
         LZUptD1iBaIfbGrylSwAnijKduhOpP7mclezxX4kUUWG2uRrBaxGvUx9aGtKLN4O2S
         QKNw8zSYWUnIuMNUk/QxPJ2m/Jjn95qgk2vUDgk4gNBdQF+8ArFC7/Qw5RPMpZNyIQ
         lUPxTXXwuMG8zQPhLDVnDzARGlEsNkA5MDGE4pjINn30ERIzEiYnZ1CgVm/zk2YXjK
         9kdfBQS3/j7YQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5HEYpXF3458114;
        Mon, 17 Jun 2019 07:34:51 -0700
Date:   Mon, 17 Jun 2019 07:34:51 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Kan Liang <tipbot@zytor.com>
Message-ID: <tip-2a538fda82824a7722e296be656bb5d11d91a9cb@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        torvalds@linux-foundation.org, hpa@zytor.com, peterz@infradead.org,
        tglx@linutronix.de, kan.liang@linux.intel.com
Reply-To: kan.liang@linux.intel.com, peterz@infradead.org,
          tglx@linutronix.de, linux-kernel@vger.kernel.org, hpa@zytor.com,
          mingo@kernel.org, torvalds@linux-foundation.org
In-Reply-To: <20190603134122.13853-3-kan.liang@linux.intel.com>
References: <20190603134122.13853-3-kan.liang@linux.intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf/x86/intel: Add Icelake desktop CPUID
Git-Commit-ID: 2a538fda82824a7722e296be656bb5d11d91a9cb
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  2a538fda82824a7722e296be656bb5d11d91a9cb
Gitweb:     https://git.kernel.org/tip/2a538fda82824a7722e296be656bb5d11d91a9cb
Author:     Kan Liang <kan.liang@linux.intel.com>
AuthorDate: Mon, 3 Jun 2019 06:41:22 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 17 Jun 2019 12:36:14 +0200

perf/x86/intel: Add Icelake desktop CPUID

Add new Icelake desktop CPUID for RAPL, CSTATE and UNCORE.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: bp@alien8.de
Cc: qiuxu.zhuo@intel.com
Cc: rui.zhang@intel.com
Cc: tony.luck@intel.com
Link: https://lkml.kernel.org/r/20190603134122.13853-3-kan.liang@linux.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/events/intel/cstate.c | 1 +
 arch/x86/events/intel/rapl.c   | 1 +
 arch/x86/events/intel/uncore.c | 1 +
 3 files changed, 3 insertions(+)

diff --git a/arch/x86/events/intel/cstate.c b/arch/x86/events/intel/cstate.c
index 267d7f8e12ab..e1caa0b49d63 100644
--- a/arch/x86/events/intel/cstate.c
+++ b/arch/x86/events/intel/cstate.c
@@ -580,6 +580,7 @@ static const struct x86_cpu_id intel_cstates_match[] __initconst = {
 	X86_CSTATES_MODEL(INTEL_FAM6_ATOM_GOLDMONT_PLUS, glm_cstates),
 
 	X86_CSTATES_MODEL(INTEL_FAM6_ICELAKE_MOBILE, snb_cstates),
+	X86_CSTATES_MODEL(INTEL_FAM6_ICELAKE_DESKTOP, snb_cstates),
 	{ },
 };
 MODULE_DEVICE_TABLE(x86cpu, intel_cstates_match);
diff --git a/arch/x86/events/intel/rapl.c b/arch/x86/events/intel/rapl.c
index 8c7ecde3ba70..798135419a62 100644
--- a/arch/x86/events/intel/rapl.c
+++ b/arch/x86/events/intel/rapl.c
@@ -778,6 +778,7 @@ static const struct x86_cpu_id rapl_cpu_match[] __initconst = {
 	X86_RAPL_MODEL_MATCH(INTEL_FAM6_ATOM_GOLDMONT_PLUS, hsw_rapl_init),
 
 	X86_RAPL_MODEL_MATCH(INTEL_FAM6_ICELAKE_MOBILE,  skl_rapl_init),
+	X86_RAPL_MODEL_MATCH(INTEL_FAM6_ICELAKE_DESKTOP, skl_rapl_init),
 	{},
 };
 
diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index 6094c8db949d..d37bb2c657b0 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -1403,6 +1403,7 @@ static const struct x86_cpu_id intel_uncore_match[] __initconst = {
 	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_KABYLAKE_DESKTOP, skl_uncore_init),
 	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_ICELAKE_MOBILE, icl_uncore_init),
 	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_ICELAKE_NNPI, icl_uncore_init),
+	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_ICELAKE_DESKTOP, icl_uncore_init),
 	{},
 };
 
