Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93B7EC04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 12:10:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69D58268B6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 12:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559304642;
	bh=PF72v+E0CWyNpZdeeiuiQUoyvEXEykC7UFG+lwyKEvQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oJOYVDKVo7HcHqDJWM6EvDYag4Rc3bpJC3/1R0V7ZqT1lNYJ+UMM1VJpSKySiXsEK
	 FGrxZfvrTUi8AK+GVPLhZCtASAVE2bacIqmU1+cCI3KwcPd3W+VUSZJuoItdCtk+Cx
	 49qT7snoBH0OY6NuCMWsnSQ+eP/A89AuPmwFV5uo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727436AbfEaMKl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 08:10:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41280 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727400AbfEaMKj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 08:10:39 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E23D4307D9D0;
        Fri, 31 May 2019 12:10:33 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.136])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 192572F2A9;
        Fri, 31 May 2019 12:10:29 +0000 (UTC)
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
Subject: [PATCH 7/8] perf/x86/rapl: Get attributes from new probe framework
Date:   Fri, 31 May 2019 14:09:57 +0200
Message-Id: <20190531120958.29601-8-jolsa@kernel.org>
In-Reply-To: <20190531120958.29601-1-jolsa@kernel.org>
References: <20190531120958.29601-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Fri, 31 May 2019 12:10:38 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We no longer need model specific attribute arrays,
because we get all this detected in rapl_events_attrs.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 arch/x86/events/intel/rapl.c | 89 ------------------------------------
 1 file changed, 89 deletions(-)

diff --git a/arch/x86/events/intel/rapl.c b/arch/x86/events/intel/rapl.c
index 253c5786a073..d281eae56bb8 100644
--- a/arch/x86/events/intel/rapl.c
+++ b/arch/x86/events/intel/rapl.c
@@ -415,87 +415,6 @@ RAPL_EVENT_ATTR_STR(energy-ram.scale,     rapl_ram_scale, "2.3283064365386962890
 RAPL_EVENT_ATTR_STR(energy-gpu.scale,     rapl_gpu_scale, "2.3283064365386962890625e-10");
 RAPL_EVENT_ATTR_STR(energy-psys.scale,   rapl_psys_scale, "2.3283064365386962890625e-10");
 
-static struct attribute *rapl_events_srv_attr[] = {
-	EVENT_PTR(rapl_cores),
-	EVENT_PTR(rapl_pkg),
-	EVENT_PTR(rapl_ram),
-
-	EVENT_PTR(rapl_cores_unit),
-	EVENT_PTR(rapl_pkg_unit),
-	EVENT_PTR(rapl_ram_unit),
-
-	EVENT_PTR(rapl_cores_scale),
-	EVENT_PTR(rapl_pkg_scale),
-	EVENT_PTR(rapl_ram_scale),
-	NULL,
-};
-
-static struct attribute *rapl_events_cln_attr[] = {
-	EVENT_PTR(rapl_cores),
-	EVENT_PTR(rapl_pkg),
-	EVENT_PTR(rapl_gpu),
-
-	EVENT_PTR(rapl_cores_unit),
-	EVENT_PTR(rapl_pkg_unit),
-	EVENT_PTR(rapl_gpu_unit),
-
-	EVENT_PTR(rapl_cores_scale),
-	EVENT_PTR(rapl_pkg_scale),
-	EVENT_PTR(rapl_gpu_scale),
-	NULL,
-};
-
-static struct attribute *rapl_events_hsw_attr[] = {
-	EVENT_PTR(rapl_cores),
-	EVENT_PTR(rapl_pkg),
-	EVENT_PTR(rapl_gpu),
-	EVENT_PTR(rapl_ram),
-
-	EVENT_PTR(rapl_cores_unit),
-	EVENT_PTR(rapl_pkg_unit),
-	EVENT_PTR(rapl_gpu_unit),
-	EVENT_PTR(rapl_ram_unit),
-
-	EVENT_PTR(rapl_cores_scale),
-	EVENT_PTR(rapl_pkg_scale),
-	EVENT_PTR(rapl_gpu_scale),
-	EVENT_PTR(rapl_ram_scale),
-	NULL,
-};
-
-static struct attribute *rapl_events_skl_attr[] = {
-	EVENT_PTR(rapl_cores),
-	EVENT_PTR(rapl_pkg),
-	EVENT_PTR(rapl_gpu),
-	EVENT_PTR(rapl_ram),
-	EVENT_PTR(rapl_psys),
-
-	EVENT_PTR(rapl_cores_unit),
-	EVENT_PTR(rapl_pkg_unit),
-	EVENT_PTR(rapl_gpu_unit),
-	EVENT_PTR(rapl_ram_unit),
-	EVENT_PTR(rapl_psys_unit),
-
-	EVENT_PTR(rapl_cores_scale),
-	EVENT_PTR(rapl_pkg_scale),
-	EVENT_PTR(rapl_gpu_scale),
-	EVENT_PTR(rapl_ram_scale),
-	EVENT_PTR(rapl_psys_scale),
-	NULL,
-};
-
-static struct attribute *rapl_events_knl_attr[] = {
-	EVENT_PTR(rapl_pkg),
-	EVENT_PTR(rapl_ram),
-
-	EVENT_PTR(rapl_pkg_unit),
-	EVENT_PTR(rapl_ram_unit),
-
-	EVENT_PTR(rapl_pkg_scale),
-	EVENT_PTR(rapl_ram_scale),
-	NULL,
-};
-
 /*
  * There are no default events, but we need to create
  * "events" group (with empty attrs) before updating
@@ -753,37 +672,30 @@ static int __init init_rapl_pmus(void)
 
 struct intel_rapl_init_fun {
 	bool apply_quirk;
-	struct attribute **attrs;
 };
 
 static const struct intel_rapl_init_fun snb_rapl_init __initconst = {
 	.apply_quirk = false,
-	.attrs = rapl_events_cln_attr,
 };
 
 static const struct intel_rapl_init_fun hsx_rapl_init __initconst = {
 	.apply_quirk = true,
-	.attrs = rapl_events_srv_attr,
 };
 
 static const struct intel_rapl_init_fun hsw_rapl_init __initconst = {
 	.apply_quirk = false,
-	.attrs = rapl_events_hsw_attr,
 };
 
 static const struct intel_rapl_init_fun snbep_rapl_init __initconst = {
 	.apply_quirk = false,
-	.attrs = rapl_events_srv_attr,
 };
 
 static const struct intel_rapl_init_fun knl_rapl_init __initconst = {
 	.apply_quirk = true,
-	.attrs = rapl_events_knl_attr,
 };
 
 static const struct intel_rapl_init_fun skl_rapl_init __initconst = {
 	.apply_quirk = false,
-	.attrs = rapl_events_skl_attr,
 };
 
 static const struct x86_cpu_id rapl_cpu_match[] __initconst = {
@@ -920,7 +832,6 @@ static int __init rapl_pmu_init(void)
 
 	rapl_init = (struct intel_rapl_init_fun *)id->driver_data;
 	apply_quirk = rapl_init->apply_quirk;
-	rapl_pmu_events_group.attrs = rapl_init->attrs;
 
 	ret = rapl_check_hw_unit(apply_quirk);
 	if (ret)
-- 
2.21.0

