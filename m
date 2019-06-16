Return-Path: <SRS0=7o0M=UP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A84DEC31E54
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 14:04:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DB9F216FD
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 14:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560693871;
	bh=61coOJ5tNkBpoMX9TiRs4gBmr73nsMmJYi0gEDTYdbc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RDsvBm1vwershk+GtcOTrhDaKjfetjbynecx12izS5KH/u4jJGwrK5ICD9GWqu2u0
	 E1t8MuQ/bMlYZrzkSR4Cypy7eNLwOprUG4nDqCrhcziYs9IP4YM6BLBLl0PROvZxim
	 IIMwJdX+Yme7G5PHSx3JSK+qLgySJ3MjJFPxXWq0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727411AbfFPOEa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Jun 2019 10:04:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34654 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727388AbfFPOE2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jun 2019 10:04:28 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E4EDF99C4B;
        Sun, 16 Jun 2019 14:04:27 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-53.brq.redhat.com [10.40.204.53])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1CC638F6E9;
        Sun, 16 Jun 2019 14:04:24 +0000 (UTC)
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
Date:   Sun, 16 Jun 2019 16:03:57 +0200
Message-Id: <20190616140358.27799-8-jolsa@kernel.org>
In-Reply-To: <20190616140358.27799-1-jolsa@kernel.org>
References: <20190616140358.27799-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Sun, 16 Jun 2019 14:04:28 +0000 (UTC)
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
index 709a749a4ada..e4c4ff870845 100644
--- a/arch/x86/events/intel/rapl.c
+++ b/arch/x86/events/intel/rapl.c
@@ -416,87 +416,6 @@ RAPL_EVENT_ATTR_STR(energy-ram.scale,     rapl_ram_scale, "2.3283064365386962890
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
@@ -754,37 +673,30 @@ static int __init init_rapl_pmus(void)
 
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
@@ -923,7 +835,6 @@ static int __init rapl_pmu_init(void)
 
 	rapl_init = (struct intel_rapl_init_fun *)id->driver_data;
 	apply_quirk = rapl_init->apply_quirk;
-	rapl_pmu_events_group.attrs = rapl_init->attrs;
 
 	ret = rapl_check_hw_unit(apply_quirk);
 	if (ret)
-- 
2.21.0

