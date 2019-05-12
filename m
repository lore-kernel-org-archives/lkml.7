Return-Path: <SRS0=t4ha=TM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A5B0C04A6B
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 15:55:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D6CE21882
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 15:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557676539;
	bh=6j8bXfR6sZtRzvSFgJn3enxF5KObDW/98+nDk03Dueg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dfMRjFwIITcAKviFu+MD5OCbVF/0Ht6rcJvDpQTuA9F+E1OYoqwBSQ64BSua4kab9
	 rsHJHt6gSTUeuXIZLsG4XWi+REqfjJBBxX13k0BWxGKQj/W6t8LbLP+X6lCqHhfDSC
	 AkiNZMQIiuKkMhaXxkE+uopUjE/lgm1x960JwcL4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727087AbfELPzi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 May 2019 11:55:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41150 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727048AbfELPzg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 May 2019 11:55:36 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 082B43092663;
        Sun, 12 May 2019 15:55:36 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-30.brq.redhat.com [10.40.204.30])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0F8B35C26D;
        Sun, 12 May 2019 15:55:33 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andi Kleen <ak@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 6/9] perf/x86: Use update attribute groups for caps
Date:   Sun, 12 May 2019 17:55:15 +0200
Message-Id: <20190512155518.21468-7-jolsa@kernel.org>
In-Reply-To: <20190512155518.21468-1-jolsa@kernel.org>
References: <20190512155518.21468-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Sun, 12 May 2019 15:55:36 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using the new pmu::update_attrs attribute group for
"caps" directory.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 arch/x86/events/core.c       |  8 --------
 arch/x86/events/intel/core.c | 25 ++++++++++++++++++++-----
 arch/x86/events/perf_event.h |  1 -
 3 files changed, 20 insertions(+), 14 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index a7aa72afcc7f..7f1bb5fd1fc4 100644
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
index fd7d36611e22..fff73623cf80 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4402,6 +4402,12 @@ pebs_is_visible(struct kobject *kobj, struct attribute *attr, int i)
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
@@ -4416,10 +4422,23 @@ static struct attribute_group group_events_tsx = {
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
 
@@ -5046,12 +5065,8 @@ __init int intel_pmu_init(void)
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

