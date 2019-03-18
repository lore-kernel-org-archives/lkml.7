Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E1A7C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 18:21:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D7AB2175B
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 18:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552933308;
	bh=yfzhQBzyDYiWEzLkO8IL5CQPrH5Bw0jryqfAKMEQtLY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VD5aKkdzLy7ogMAe7pEs8frGUUrWoXlYiXXKDNMEbbjWd8aiyqgaqU5NBFt7/ZHWn
	 vgIuzqG5FzfldLhOzrZZJ8w3zHsDl+U1fwOQKduzHWuEODNHM9XfB0L9cLDg6WgVnV
	 wyyKDOBZ9ro+aUB//ZZtv851CkI45QIKUhm8LYOE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727642AbfCRSVq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 14:21:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38974 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727603AbfCRSVm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 14:21:42 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EAD27308219E;
        Mon, 18 Mar 2019 18:21:41 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.124])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7D224600D4;
        Mon, 18 Mar 2019 18:21:39 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Peter Zijlstra <a.p.zijlstra@chello.nl>,
        "Liang, Kan" <kan.liang@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Andy Lutomirski <luto@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Vince Weaver <vincent.weaver@maine.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 8/8] perf/x86/rapl: Get quirk state from new probe framework
Date:   Mon, 18 Mar 2019 19:21:16 +0100
Message-Id: <20190318182116.17388-9-jolsa@kernel.org>
In-Reply-To: <20190318182116.17388-1-jolsa@kernel.org>
References: <20190318182116.17388-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Mon, 18 Mar 2019 18:21:42 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Getting the apply_quirk bool from new rapl_model_match array.

And because apply_quirk was the last remaining piece of data
in rapl_cpu_match, replacing it with rapl_model_match as device
table.

The switch to new perf_msr_probe detection API is done.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 arch/x86/events/intel/rapl.c | 78 ++----------------------------------
 1 file changed, 3 insertions(+), 75 deletions(-)

diff --git a/arch/x86/events/intel/rapl.c b/arch/x86/events/intel/rapl.c
index 065c2a8f8f9c..9e14a856e529 100644
--- a/arch/x86/events/intel/rapl.c
+++ b/arch/x86/events/intel/rapl.c
@@ -626,72 +626,6 @@ static int __init init_rapl_pmus(void)
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
-	{},
-};
-
-MODULE_DEVICE_TABLE(x86cpu, rapl_cpu_match);
-
 static struct rapl_model model_snb = {
 	.events		= BIT(PERF_RAPL_PP0) |
 			  BIT(PERF_RAPL_PKG) |
@@ -763,6 +697,8 @@ static const struct x86_cpu_id rapl_model_match[] __initconst = {
 	{},
 };
 
+MODULE_DEVICE_TABLE(x86cpu, rapl_model_match);
+
 static struct attribute *rapl_events_attrs[PERF_RAPL_MAX*3 + 1] = {
 	NULL,
 };
@@ -770,9 +706,7 @@ static struct attribute *rapl_events_attrs[PERF_RAPL_MAX*3 + 1] = {
 static int __init rapl_pmu_init(void)
 {
 	const struct x86_cpu_id *id;
-	struct intel_rapl_init_fun *rapl_init;
 	struct rapl_model *rm;
-	bool apply_quirk;
 	int ret;
 
 	id = x86_match_cpu(rapl_model_match);
@@ -783,15 +717,9 @@ static int __init rapl_pmu_init(void)
 	rapl_cntr_mask = perf_msr_probe(rapl_msrs, PERF_RAPL_MAX,
 					rapl_events_attrs, (void *) &rm->events);
 
-	id = x86_match_cpu(rapl_cpu_match);
-	if (!id)
-		return -ENODEV;
-
-	rapl_init = (struct intel_rapl_init_fun *)id->driver_data;
-	apply_quirk = rapl_init->apply_quirk;
 	rapl_pmu_events_group.attrs = rapl_events_attrs;
 
-	ret = rapl_check_hw_unit(apply_quirk);
+	ret = rapl_check_hw_unit(rm->apply_quirk);
 	if (ret)
 		return ret;
 
-- 
2.17.2

