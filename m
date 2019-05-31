Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A5FEC04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 12:10:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 141662688A
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 12:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559304640;
	bh=QOa5XDYIvbJmFBZm0DF5o2wr8N1RX+7jp1RtAS9YlnM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eMp7xje6S6fTSahDcRsDS0k2js9ilKfnjKJS+N50cmuah0Qi+b7za3Supc5p+dQLw
	 IXWh10wnACzVoBhWbM+o1YHj7+ErSy9vv5SQ+RigjdRXcHnoePHJP2ZrRYK9shYqfv
	 j2irVXQBBmNzhgXIlRHf+6OA86nNdbndTNdNiY2o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727413AbfEaMKj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 08:10:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46767 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727376AbfEaMKh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 08:10:37 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9CEFF780EA;
        Fri, 31 May 2019 12:10:26 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.136])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C01F37C586;
        Fri, 31 May 2019 12:10:23 +0000 (UTC)
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
Date:   Fri, 31 May 2019 14:09:55 +0200
Message-Id: <20190531120958.29601-6-jolsa@kernel.org>
In-Reply-To: <20190531120958.29601-1-jolsa@kernel.org>
References: <20190531120958.29601-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Fri, 31 May 2019 12:10:36 +0000 (UTC)
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
index c0f15b63f395..86f00f896ee2 100644
--- a/arch/x86/events/intel/rapl.c
+++ b/arch/x86/events/intel/rapl.c
@@ -95,33 +95,6 @@ static const char *const rapl_domain_names[NR_RAPL_DOMAINS] __initconst = {
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
@@ -811,43 +784,36 @@ static int __init init_rapl_pmus(void)
 
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
 
@@ -976,7 +942,8 @@ static int __init rapl_pmu_init(void)
 		return -ENODEV;
 
 	rm = (struct rapl_model *) id->driver_data;
-	perf_msr_probe(rapl_msrs, PERF_RAPL_MAX, false, (void *) &rm->events);
+	rapl_cntr_mask = perf_msr_probe(rapl_msrs, PERF_RAPL_MAX,
+					false, (void *) &rm->events);
 
 	id = x86_match_cpu(rapl_cpu_match);
 	if (!id)
@@ -984,7 +951,6 @@ static int __init rapl_pmu_init(void)
 
 	rapl_init = (struct intel_rapl_init_fun *)id->driver_data;
 	apply_quirk = rapl_init->apply_quirk;
-	rapl_cntr_mask = rapl_init->cntr_mask;
 	rapl_pmu_events_group.attrs = rapl_init->attrs;
 
 	ret = rapl_check_hw_unit(apply_quirk);
-- 
2.21.0

