Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64AC0C48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 08:43:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 247CE21655
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 08:43:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Zzy14xB8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730775AbfFYIng (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 04:43:36 -0400
Received: from terminus.zytor.com ([198.137.202.136]:49145 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726587AbfFYIng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 04:43:36 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5P8h6DF3533420
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 25 Jun 2019 01:43:06 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5P8h6DF3533420
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561452187;
        bh=EamL9E631aAVBfN1QquNpEsc5C/dG2lJbDaicsK+/GA=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=Zzy14xB8Z5A3qlK3obJ16TnE43QDbtxP2hQ5ymSetUnyXg+xMCCg9jA9pLuY7j3Wz
         qjUANNpyQ999PGedA1LxdSXsOmj1JDUh+fmDMSlTY/Vk9yFTvE1BMdq2fRVcmqBLCn
         crAA9dsDxs0PelGy9NRWk2v/nIWL8/pigkSvPBn5vIB9nFJm59xA+w5eE4kqfzmPDE
         MSVv6dCuqTNw/XvjjTy9kEXQ783yxgSy00SOw2NJe6DAQCJG7eoyF2CWx0ALM/cMn7
         osY9zfRccUmzGPQGc/+nYADKfa9Xa+1pq3uXp7EXZ1grN7o+qH74GmGzEnYAH9hqUq
         RXVKiBLmK5lRA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5P8h5863533417;
        Tue, 25 Jun 2019 01:43:05 -0700
Date:   Tue, 25 Jun 2019 01:43:05 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-637d97b53cdded02da55d0a25cda6fd6af3bd042@git.kernel.org>
Cc:     peterz@infradead.org, luto@kernel.org, acme@redhat.com,
        bp@alien8.de, acme@kernel.org, kan.liang@linux.intel.com,
        mingo@kernel.org, hpa@zytor.com, vincent.weaver@maine.edu,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        eranian@google.com, gregkh@linuxfoundation.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        tglx@linutronix.de, namhyung@kernel.org, jolsa@kernel.org
Reply-To: kan.liang@linux.intel.com, acme@kernel.org, bp@alien8.de,
          acme@redhat.com, luto@kernel.org, peterz@infradead.org,
          namhyung@kernel.org, jolsa@kernel.org,
          alexander.shishkin@linux.intel.com, eranian@google.com,
          gregkh@linuxfoundation.org, torvalds@linux-foundation.org,
          jolsa@redhat.com, tglx@linutronix.de,
          linux-kernel@vger.kernel.org, vincent.weaver@maine.edu,
          mingo@kernel.org, hpa@zytor.com
In-Reply-To: <20190616140358.27799-9-jolsa@kernel.org>
References: <20190616140358.27799-9-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf/x86/rapl: Get quirk state from new probe
 framework
Git-Commit-ID: 637d97b53cdded02da55d0a25cda6fd6af3bd042
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

Commit-ID:  637d97b53cdded02da55d0a25cda6fd6af3bd042
Gitweb:     https://git.kernel.org/tip/637d97b53cdded02da55d0a25cda6fd6af3bd042
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Sun, 16 Jun 2019 16:03:58 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 24 Jun 2019 19:28:36 +0200

perf/x86/rapl: Get quirk state from new probe framework

Getting the apply_quirk bool from new rapl_model_match array.

And because apply_quirk was the last remaining piece of data
in rapl_cpu_match, replacing it with rapl_model_match as device
table.

The switch to new perf_msr_probe detection API is done.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Kan <kan.liang@linux.intel.com>
Cc: Liang
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vince Weaver <vincent.weaver@maine.edu>
Link: https://lkml.kernel.org/r/20190616140358.27799-9-jolsa@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/events/intel/rapl.c | 82 ++------------------------------------------
 1 file changed, 3 insertions(+), 79 deletions(-)

diff --git a/arch/x86/events/intel/rapl.c b/arch/x86/events/intel/rapl.c
index 460196c02bae..64ab51ffdf06 100644
--- a/arch/x86/events/intel/rapl.c
+++ b/arch/x86/events/intel/rapl.c
@@ -671,75 +671,6 @@ static int __init init_rapl_pmus(void)
 #define X86_RAPL_MODEL_MATCH(model, init)	\
 	{ X86_VENDOR_INTEL, 6, model, X86_FEATURE_ANY, (unsigned long)&init }
 
-struct intel_rapl_init_fun {
-	bool apply_quirk;
-};
-
-static const struct intel_rapl_init_fun snb_rapl_init __initconst = {
-	.apply_quirk = false,
-};
-
-static const struct intel_rapl_init_fun hsx_rapl_init __initconst = {
-	.apply_quirk = true,
-};
-
-static const struct intel_rapl_init_fun hsw_rapl_init __initconst = {
-	.apply_quirk = false,
-};
-
-static const struct intel_rapl_init_fun snbep_rapl_init __initconst = {
-	.apply_quirk = false,
-};
-
-static const struct intel_rapl_init_fun knl_rapl_init __initconst = {
-	.apply_quirk = true,
-};
-
-static const struct intel_rapl_init_fun skl_rapl_init __initconst = {
-	.apply_quirk = false,
-};
-
-static const struct x86_cpu_id rapl_cpu_match[] __initconst = {
-	X86_RAPL_MODEL_MATCH(INTEL_FAM6_SANDYBRIDGE,   snb_rapl_init),
-	X86_RAPL_MODEL_MATCH(INTEL_FAM6_SANDYBRIDGE_X, snbep_rapl_init),
-
-	X86_RAPL_MODEL_MATCH(INTEL_FAM6_IVYBRIDGE,   snb_rapl_init),
-	X86_RAPL_MODEL_MATCH(INTEL_FAM6_IVYBRIDGE_X, snbep_rapl_init),
-
-	X86_RAPL_MODEL_MATCH(INTEL_FAM6_HASWELL_CORE, hsw_rapl_init),
-	X86_RAPL_MODEL_MATCH(INTEL_FAM6_HASWELL_X,    hsx_rapl_init),
-	X86_RAPL_MODEL_MATCH(INTEL_FAM6_HASWELL_ULT,  hsw_rapl_init),
-	X86_RAPL_MODEL_MATCH(INTEL_FAM6_HASWELL_GT3E, hsw_rapl_init),
-
-	X86_RAPL_MODEL_MATCH(INTEL_FAM6_BROADWELL_CORE,   hsw_rapl_init),
-	X86_RAPL_MODEL_MATCH(INTEL_FAM6_BROADWELL_GT3E,   hsw_rapl_init),
-	X86_RAPL_MODEL_MATCH(INTEL_FAM6_BROADWELL_X,	  hsx_rapl_init),
-	X86_RAPL_MODEL_MATCH(INTEL_FAM6_BROADWELL_XEON_D, hsx_rapl_init),
-
-	X86_RAPL_MODEL_MATCH(INTEL_FAM6_XEON_PHI_KNL, knl_rapl_init),
-	X86_RAPL_MODEL_MATCH(INTEL_FAM6_XEON_PHI_KNM, knl_rapl_init),
-
-	X86_RAPL_MODEL_MATCH(INTEL_FAM6_SKYLAKE_MOBILE,  skl_rapl_init),
-	X86_RAPL_MODEL_MATCH(INTEL_FAM6_SKYLAKE_DESKTOP, skl_rapl_init),
-	X86_RAPL_MODEL_MATCH(INTEL_FAM6_SKYLAKE_X,	 hsx_rapl_init),
-
-	X86_RAPL_MODEL_MATCH(INTEL_FAM6_KABYLAKE_MOBILE,  skl_rapl_init),
-	X86_RAPL_MODEL_MATCH(INTEL_FAM6_KABYLAKE_DESKTOP, skl_rapl_init),
-
-	X86_RAPL_MODEL_MATCH(INTEL_FAM6_CANNONLAKE_MOBILE,  skl_rapl_init),
-
-	X86_RAPL_MODEL_MATCH(INTEL_FAM6_ATOM_GOLDMONT, hsw_rapl_init),
-	X86_RAPL_MODEL_MATCH(INTEL_FAM6_ATOM_GOLDMONT_X, hsw_rapl_init),
-
-	X86_RAPL_MODEL_MATCH(INTEL_FAM6_ATOM_GOLDMONT_PLUS, hsw_rapl_init),
-
-	X86_RAPL_MODEL_MATCH(INTEL_FAM6_ICELAKE_MOBILE,  skl_rapl_init),
-	X86_RAPL_MODEL_MATCH(INTEL_FAM6_ICELAKE_DESKTOP, skl_rapl_init),
-	{},
-};
-
-MODULE_DEVICE_TABLE(x86cpu, rapl_cpu_match);
-
 static struct rapl_model model_snb = {
 	.events		= BIT(PERF_RAPL_PP0) |
 			  BIT(PERF_RAPL_PKG) |
@@ -813,12 +744,12 @@ static const struct x86_cpu_id rapl_model_match[] __initconst = {
 	{},
 };
 
+MODULE_DEVICE_TABLE(x86cpu, rapl_model_match);
+
 static int __init rapl_pmu_init(void)
 {
 	const struct x86_cpu_id *id;
-	struct intel_rapl_init_fun *rapl_init;
 	struct rapl_model *rm;
-	bool apply_quirk;
 	int ret;
 
 	id = x86_match_cpu(rapl_model_match);
@@ -829,14 +760,7 @@ static int __init rapl_pmu_init(void)
 	rapl_cntr_mask = perf_msr_probe(rapl_msrs, PERF_RAPL_MAX,
 					false, (void *) &rm->events);
 
-	id = x86_match_cpu(rapl_cpu_match);
-	if (!id)
-		return -ENODEV;
-
-	rapl_init = (struct intel_rapl_init_fun *)id->driver_data;
-	apply_quirk = rapl_init->apply_quirk;
-
-	ret = rapl_check_hw_unit(apply_quirk);
+	ret = rapl_check_hw_unit(rm->apply_quirk);
 	if (ret)
 		return ret;
 
