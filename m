Return-Path: <SRS0=7o0M=UP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC38CC31E50
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 14:04:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8082D2147A
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 14:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560693867;
	bh=LY7XNQ1MkX6aq+GXAjng3ViilTz744KgEok4e+p7Ujc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hV7mrQnkEPqvuqFMjbqj/AZXtCZOrLAV+dJ3N7WX8OI0LRlzapmyl2EKZQURc6y7T
	 5/Qwao7Y7tq/i7IH4SM5+NQgOZ2vgwueKFB5MyFy4nBjmSmfTG7KoCJWqwy26U3Irk
	 O0rR+4ZU3DsbcSFZO1SJ17uKE+8QvhuZMhEok2n8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727370AbfFPOE0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Jun 2019 10:04:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52068 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727251AbfFPOEV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jun 2019 10:04:21 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 55D34368B1;
        Sun, 16 Jun 2019 14:04:21 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-53.brq.redhat.com [10.40.204.53])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 758328CF9E;
        Sun, 16 Jun 2019 14:04:18 +0000 (UTC)
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
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 5/8] perf/x86/rapl: Get rapl_cntr_mask from new probe framework
Date:   Sun, 16 Jun 2019 16:03:55 +0200
Message-Id: <20190616140358.27799-6-jolsa@kernel.org>
In-Reply-To: <20190616140358.27799-1-jolsa@kernel.org>
References: <20190616140358.27799-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Sun, 16 Jun 2019 14:04:21 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We get rapl_cntr_mask from perf_msr_probe call, as a replacement
for current intel_rapl_init_fun::cntr_mask value for each model.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 arch/x86/events/intel/rapl.c | 38 ++----------------------------------
 1 file changed, 2 insertions(+), 36 deletions(-)

diff --git a/arch/x86/events/intel/rapl.c b/arch/x86/events/intel/rapl.c
index fa6d8065db15..417de3fdde61 100644
--- a/arch/x86/events/intel/rapl.c
+++ b/arch/x86/events/intel/rapl.c
@@ -96,33 +96,6 @@ static const char *const rapl_domain_names[NR_RAPL_DOMAINS] __initconst = {
 	"psys",
 };
 
-/* Clients have PP0, PKG */
-#define RAPL_IDX_CLN	(1<<RAPL_IDX_PP0_NRG_STAT|\
-			 1<<RAPL_IDX_PKG_NRG_STAT|\
-			 1<<RAPL_IDX_PP1_NRG_STAT)
-
-/* Servers have PP0, PKG, RAM */
-#define RAPL_IDX_SRV	(1<<RAPL_IDX_PP0_NRG_STAT|\
-			 1<<RAPL_IDX_PKG_NRG_STAT|\
-			 1<<RAPL_IDX_RAM_NRG_STAT)
-
-/* Servers have PP0, PKG, RAM, PP1 */
-#define RAPL_IDX_HSW	(1<<RAPL_IDX_PP0_NRG_STAT|\
-			 1<<RAPL_IDX_PKG_NRG_STAT|\
-			 1<<RAPL_IDX_RAM_NRG_STAT|\
-			 1<<RAPL_IDX_PP1_NRG_STAT)
-
-/* SKL clients have PP0, PKG, RAM, PP1, PSYS */
-#define RAPL_IDX_SKL_CLN (1<<RAPL_IDX_PP0_NRG_STAT|\
-			  1<<RAPL_IDX_PKG_NRG_STAT|\
-			  1<<RAPL_IDX_RAM_NRG_STAT|\
-			  1<<RAPL_IDX_PP1_NRG_STAT|\
-			  1<<RAPL_IDX_PSYS_NRG_STAT)
-
-/* Knights Landing has PKG, RAM */
-#define RAPL_IDX_KNL	(1<<RAPL_IDX_PKG_NRG_STAT|\
-			 1<<RAPL_IDX_RAM_NRG_STAT)
-
 /*
  * event code: LSB 8 bits, passed in attr->config
  * any other bit is reserved
@@ -812,43 +785,36 @@ static int __init init_rapl_pmus(void)
 
 struct intel_rapl_init_fun {
 	bool apply_quirk;
-	int cntr_mask;
 	struct attribute **attrs;
 };
 
 static const struct intel_rapl_init_fun snb_rapl_init __initconst = {
 	.apply_quirk = false,
-	.cntr_mask = RAPL_IDX_CLN,
 	.attrs = rapl_events_cln_attr,
 };
 
 static const struct intel_rapl_init_fun hsx_rapl_init __initconst = {
 	.apply_quirk = true,
-	.cntr_mask = RAPL_IDX_SRV,
 	.attrs = rapl_events_srv_attr,
 };
 
 static const struct intel_rapl_init_fun hsw_rapl_init __initconst = {
 	.apply_quirk = false,
-	.cntr_mask = RAPL_IDX_HSW,
 	.attrs = rapl_events_hsw_attr,
 };
 
 static const struct intel_rapl_init_fun snbep_rapl_init __initconst = {
 	.apply_quirk = false,
-	.cntr_mask = RAPL_IDX_SRV,
 	.attrs = rapl_events_srv_attr,
 };
 
 static const struct intel_rapl_init_fun knl_rapl_init __initconst = {
 	.apply_quirk = true,
-	.cntr_mask = RAPL_IDX_KNL,
 	.attrs = rapl_events_knl_attr,
 };
 
 static const struct intel_rapl_init_fun skl_rapl_init __initconst = {
 	.apply_quirk = false,
-	.cntr_mask = RAPL_IDX_SKL_CLN,
 	.attrs = rapl_events_skl_attr,
 };
 
@@ -979,7 +945,8 @@ static int __init rapl_pmu_init(void)
 		return -ENODEV;
 
 	rm = (struct rapl_model *) id->driver_data;
-	perf_msr_probe(rapl_msrs, PERF_RAPL_MAX, false, (void *) &rm->events);
+	rapl_cntr_mask = perf_msr_probe(rapl_msrs, PERF_RAPL_MAX,
+					false, (void *) &rm->events);
 
 	id = x86_match_cpu(rapl_cpu_match);
 	if (!id)
@@ -987,7 +954,6 @@ static int __init rapl_pmu_init(void)
 
 	rapl_init = (struct intel_rapl_init_fun *)id->driver_data;
 	apply_quirk = rapl_init->apply_quirk;
-	rapl_cntr_mask = rapl_init->cntr_mask;
 	rapl_pmu_events_group.attrs = rapl_init->attrs;
 
 	ret = rapl_check_hw_unit(apply_quirk);
-- 
2.21.0

