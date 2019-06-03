Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7460EC04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 13:30:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B06127DC3
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 13:30:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="wr5p++n+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728672AbfFCNaL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 09:30:11 -0400
Received: from terminus.zytor.com ([198.137.202.136]:43311 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726516AbfFCNaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 09:30:10 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x53DSxJI609720
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 3 Jun 2019 06:28:59 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x53DSxJI609720
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1559568540;
        bh=YtIgHkHPA3A/jVFcLpcLzWmm43DeZfRqyAMLsSpPAAA=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=wr5p++n+662ItOUW2iznlhW/YmjGC8mf/DsTc2RDwSghkfpjzUnT6LjeTyq23mDDv
         gjrSbFxuykK0IQtNuUTMLFdR1debeWWndBvrbYSi8O5KQMBodnITypGfYgeOXWNG1P
         qbJ1oW6Hu+PJpIjKdXQvCrm6wgFydk1fsmQlHBqCW3rap2olNRgWbqtkYqlyDjzosh
         x/EGNZXf/LpkfFrgkYgw1EWa2omNgFx7BQiNrjZiJ4W90Ft1bp6jOgkKfYOD0cg1tf
         Xj0fufGUvh/wM27Z6VepteL0rWlbQF7Gv2fDiVD7k5s07spOyHBXuSLhB0KnazenSu
         2zv8mjoMsMjJQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x53DSxBO609717;
        Mon, 3 Jun 2019 06:28:59 -0700
Date:   Mon, 3 Jun 2019 06:28:59 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-1f157286829c78c0bd8e495951a5c098d88e3d1a@git.kernel.org>
Cc:     acme@kernel.org, peterz@infradead.org,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, gregkh@linuxfoundation.org, hpa@zytor.com,
        tglx@linutronix.de, mingo@kernel.org
Reply-To: mingo@kernel.org, tglx@linutronix.de, hpa@zytor.com,
          gregkh@linuxfoundation.org, namhyung@kernel.org,
          jolsa@kernel.org, alexander.shishkin@linux.intel.com,
          linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
          peterz@infradead.org, acme@kernel.org
In-Reply-To: <20190512155518.21468-7-jolsa@kernel.org>
References: <20190512155518.21468-7-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf/x86: Use update attribute groups for caps
Git-Commit-ID: 1f157286829c78c0bd8e495951a5c098d88e3d1a
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

Commit-ID:  1f157286829c78c0bd8e495951a5c098d88e3d1a
Gitweb:     https://git.kernel.org/tip/1f157286829c78c0bd8e495951a5c098d88e3d1a
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Sun, 12 May 2019 17:55:15 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 3 Jun 2019 11:58:24 +0200

perf/x86: Use update attribute groups for caps

Using the new pmu::update_attrs attribute group for
"caps" directory.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20190512155518.21468-7-jolsa@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/events/core.c       |  8 --------
 arch/x86/events/intel/core.c | 25 ++++++++++++++++++++-----
 arch/x86/events/perf_event.h |  1 -
 3 files changed, 20 insertions(+), 14 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index b831091d4c10..dd0996ba75c3 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -1821,14 +1821,6 @@ static int __init init_hw_perf_events(void)
 
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
index 600e87055ba9..d4002e71a0b8 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4411,6 +4411,12 @@ pebs_is_visible(struct kobject *kobj, struct attribute *attr, int i)
 	return x86_pmu.pebs ? attr->mode : 0;
 }
 
+static umode_t
+lbr_is_visible(struct kobject *kobj, struct attribute *attr, int i)
+{
+	return x86_pmu.lbr_nr ? attr->mode : 0;
+}
+
 static struct attribute_group group_events_td  = {
 	.name = "events",
 };
@@ -4425,10 +4431,23 @@ static struct attribute_group group_events_tsx = {
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
 static const struct attribute_group *attr_update[] = {
 	&group_events_td,
 	&group_events_mem,
 	&group_events_tsx,
+	&group_caps_gen,
+	&group_caps_lbr,
 	NULL,
 };
 
@@ -5055,12 +5074,8 @@ __init int intel_pmu_init(void)
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
index 629b313d8b8b..1da9b6f0b279 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -631,7 +631,6 @@ struct x86_pmu {
 	int		attr_rdpmc_broken;
 	int		attr_rdpmc;
 	struct attribute **format_attrs;
-	struct attribute **caps_attrs;
 
 	ssize_t		(*events_sysfs_show)(char *page, u64 config);
 	const struct attribute_group **attr_update;
