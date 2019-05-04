Return-Path: <SRS0=6aFo=TE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DBB9C43219
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 12:52:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6100E206A3
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 12:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556974353;
	bh=crwCRa0uJD+gJFHRfkRB0Gj090IJmW/sLuxqZJKA6Oo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cgZmB9ZWfS2esF8BWF7vWqtDVOTSiBA7m3oBhzUIQhAa4CQzxVW2Hwhm2ZboUqVYu
	 +jummgyaWrGdvsRUESqJtcYclcrbFbjCMR8MwMoUgljU01nhA0Q+9NKm02IZd6U8nR
	 PMNVB8rwB4J5SPwuJF2nj0/ScWHRl3EDhKDCzr5k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727434AbfEDMw2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 May 2019 08:52:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59298 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727335AbfEDMwW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 May 2019 08:52:22 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 79DBF3082E06;
        Sat,  4 May 2019 12:52:21 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.48])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D1B6F5C298;
        Sat,  4 May 2019 12:52:19 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 6/8] perf/x86: Use update attribute groups for caps
Date:   Sat,  4 May 2019 14:52:05 +0200
Message-Id: <20190504125207.24662-7-jolsa@kernel.org>
In-Reply-To: <20190504125207.24662-1-jolsa@kernel.org>
References: <20190504125207.24662-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Sat, 04 May 2019 12:52:21 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using the new pmu::update_attrs attribute group for
"caps" directory.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 arch/x86/events/core.c       |  8 -------
 arch/x86/events/intel/core.c | 44 ++++++++++++++++++++++++++++--------
 arch/x86/events/perf_event.h |  1 -
 3 files changed, 34 insertions(+), 19 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 1889e45e6742..b7e907b5c4ea 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -1820,14 +1820,6 @@ static int __init init_hw_perf_events(void)
 
 	x86_pmu_format_group.attrs = x86_pmu.format_attrs;
 
-	if (x86_pmu.caps_attrs) {
-		struct attribute **tmp;
-
-		tmp = merge_attr(x86_pmu_caps_group.attrs, x86_pmu.caps_attrs);
-		if (!WARN_ON(!tmp))
-			x86_pmu_caps_group.attrs = tmp;
-	}
-
 	if (!x86_pmu.events_sysfs_show)
 		x86_pmu_events_group.attrs = &empty_attrs;
 
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 354396da90a8..235d06e2aac5 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4402,6 +4402,18 @@ pebs_is_visible(struct kobject *kobj, struct attribute *attr, int i)
 	return x86_pmu.pebs ? attr->mode : 0;
 }
 
+static umode_t
+lbr_is_visible(struct kobject *kobj, struct attribute *attr, int i)
+{
+	return x86_pmu.lbr_nr ? attr->mode : 0;
+}
+
+static umode_t
+exra_is_visible(struct kobject *kobj, struct attribute *attr, int i)
+{
+	return x86_pmu.version >= 2 ? attr->mode : 0;
+}
+
 static struct attribute_group group_events_td  = {
 	.name = "events",
 };
@@ -4416,13 +4428,33 @@ static struct attribute_group group_events_tsx = {
 	.is_visible = tsx_is_visible,
 };
 
+static struct attribute_group group_caps_gen = {
+	.name  = "caps",
+	.attrs = intel_pmu_caps_attrs,
+};
+
+static struct attribute_group group_caps_lbr = {
+	.name       = "caps",
+	.attrs	    = lbr_attrs,
+	.is_visible = lbr_is_visible,
+};
+
+static struct attribute_group group_format_extra = {
+	.name       = "format",
+	.is_visible = exra_is_visible,
+};
+
 static const struct attribute_group *attr_update[] = {
 	&group_events_td,
 	&group_events_mem,
 	&group_events_tsx,
+	&group_caps_gen,
+	&group_caps_lbr,
+	&group_format_extra,
 	NULL,
 };
 
+
 __init int intel_pmu_init(void)
 {
 	struct attribute **extra_attr = NULL;
@@ -4986,15 +5018,11 @@ __init int intel_pmu_init(void)
 
 	snprintf(pmu_name_str, sizeof(pmu_name_str), "%s", name);
 
-	if (version >= 2 && extra_attr) {
-		x86_pmu.format_attrs = merge_attr(intel_arch3_formats_attr,
-						  extra_attr);
-		WARN_ON(!x86_pmu.format_attrs);
-	}
 
 	group_events_td.attrs  = td_attr;
 	group_events_mem.attrs = mem_attr;
 	group_events_tsx.attrs = tsx_attr;
+	group_format_extra.attrs = extra_attr;
 
 	x86_pmu.attr_update = attr_update;
 
@@ -5044,12 +5072,8 @@ __init int intel_pmu_init(void)
 			x86_pmu.lbr_nr = 0;
 	}
 
-	x86_pmu.caps_attrs = intel_pmu_caps_attrs;
-
-	if (x86_pmu.lbr_nr) {
-		x86_pmu.caps_attrs = merge_attr(x86_pmu.caps_attrs, lbr_attrs);
+	if (x86_pmu.lbr_nr)
 		pr_cont("%d-deep LBR, ", x86_pmu.lbr_nr);
-	}
 
 	/*
 	 * Access extra MSR may cause #GP under certain circumstances.
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 7dd91607b5fa..1e3a7d74ea49 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -631,7 +631,6 @@ struct x86_pmu {
 	int		attr_rdpmc_broken;
 	int		attr_rdpmc;
 	struct attribute **format_attrs;
-	struct attribute **caps_attrs;
 
 	ssize_t		(*events_sysfs_show)(char *page, u64 config);
 	const struct attribute_group **attr_update;
-- 
2.20.1

