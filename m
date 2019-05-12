Return-Path: <SRS0=t4ha=TM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24401C04A6B
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 15:55:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB1E92173B
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 15:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557676547;
	bh=0PvX95/5/S58zwOQ0+MNO6hR/CPgiUtBLjZdueufYBE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Cngh5JizHC8zt4/uCgmVbA7h/6yoFD4OckJBDkcHSE7tBrZ0YLCA94VcESYQTee9/
	 ehJwiljhRdiMIcR1Ev76ZtcWkZ7KMTL+UQ5/DrPRAscdfqvp8aljhBUfCgFWSJ1Jkg
	 eJzVAR6Pif/J80qQDgfLPQWXA/su53S38N8+R2Ck=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727130AbfELPzp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 May 2019 11:55:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48736 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727115AbfELPzn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 May 2019 11:55:43 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0AF2B308A946;
        Sun, 12 May 2019 15:55:43 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-30.brq.redhat.com [10.40.204.30])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1326B5C26D;
        Sun, 12 May 2019 15:55:40 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andi Kleen <ak@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 9/9] perf/x86: Use update attribute groups for default attributes
Date:   Sun, 12 May 2019 17:55:18 +0200
Message-Id: <20190512155518.21468-10-jolsa@kernel.org>
In-Reply-To: <20190512155518.21468-1-jolsa@kernel.org>
References: <20190512155518.21468-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Sun, 12 May 2019 15:55:43 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using the new pmu::update_attrs attribute group for default
attributes - freeze_on_smi, allow_tsx_force_abort.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 arch/x86/events/core.c       | 34 ----------------------------------
 arch/x86/events/intel/core.c |  9 +++++----
 arch/x86/events/perf_event.h |  3 ---
 3 files changed, 5 insertions(+), 41 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 7f1bb5fd1fc4..ce26da2ef11e 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -1618,32 +1618,6 @@ static struct attribute_group x86_pmu_format_group __ro_after_init = {
 	.attrs = NULL,
 };
 
-/* Merge two pointer arrays */
-__init struct attribute **merge_attr(struct attribute **a, struct attribute **b)
-{
-	struct attribute **new;
-	int j, i;
-
-	for (j = 0; a && a[j]; j++)
-		;
-	for (i = 0; b && b[i]; i++)
-		j++;
-	j++;
-
-	new = kmalloc_array(j, sizeof(struct attribute *), GFP_KERNEL);
-	if (!new)
-		return NULL;
-
-	j = 0;
-	for (i = 0; a && a[i]; i++)
-		new[j++] = a[i];
-	for (i = 0; b && b[i]; i++)
-		new[j++] = b[i];
-	new[j] = NULL;
-
-	return new;
-}
-
 ssize_t events_sysfs_show(struct device *dev, struct device_attribute *attr, char *page)
 {
 	struct perf_pmu_events_attr *pmu_attr = \
@@ -1824,14 +1798,6 @@ static int __init init_hw_perf_events(void)
 	if (!x86_pmu.events_sysfs_show)
 		x86_pmu_events_group.attrs = &empty_attrs;
 
-	if (x86_pmu.attrs) {
-		struct attribute **tmp;
-
-		tmp = merge_attr(x86_pmu_attr_group.attrs, x86_pmu.attrs);
-		if (!WARN_ON(!tmp))
-			x86_pmu_attr_group.attrs = tmp;
-	}
-
 	pmu.attr_update = x86_pmu.attr_update;
 
 	pr_info("... version:                %d\n",     x86_pmu.version);
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 7db858c3bbec..e721be25abfb 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3888,8 +3888,6 @@ static __initconst const struct x86_pmu core_pmu = {
 	.check_period		= intel_pmu_check_period,
 };
 
-static struct attribute *intel_pmu_attrs[];
-
 static __initconst const struct x86_pmu intel_pmu = {
 	.name			= "Intel",
 	.handle_irq		= intel_pmu_handle_irq,
@@ -3921,8 +3919,6 @@ static __initconst const struct x86_pmu intel_pmu = {
 	.format_attrs		= intel_arch3_formats_attr,
 	.events_sysfs_show	= intel_event_sysfs_show,
 
-	.attrs			= intel_pmu_attrs,
-
 	.cpu_prepare		= intel_pmu_cpu_prepare,
 	.cpu_starting		= intel_pmu_cpu_starting,
 	.cpu_dying		= intel_pmu_cpu_dying,
@@ -4449,6 +4445,10 @@ static struct attribute_group group_format_extra_skl = {
 	.is_visible = exra_is_visible,
 };
 
+static struct attribute_group group_default = {
+	.attrs = intel_pmu_attrs,
+};
+
 static const struct attribute_group *attr_update[] = {
 	&group_events_td,
 	&group_events_mem,
@@ -4457,6 +4457,7 @@ static const struct attribute_group *attr_update[] = {
 	&group_caps_lbr,
 	&group_format_extra,
 	&group_format_extra_skl,
+	&group_default,
 	NULL,
 };
 
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 1e3a7d74ea49..7ae2912f16de 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -636,7 +636,6 @@ struct x86_pmu {
 	const struct attribute_group **attr_update;
 
 	unsigned long	attr_freeze_on_smi;
-	struct attribute **attrs;
 
 	/*
 	 * CPU Hotplug hooks
@@ -903,8 +902,6 @@ static inline void set_linear_ip(struct pt_regs *regs, unsigned long ip)
 ssize_t x86_event_sysfs_show(char *page, u64 config, u64 event);
 ssize_t intel_event_sysfs_show(char *page, u64 config);
 
-struct attribute **merge_attr(struct attribute **a, struct attribute **b);
-
 ssize_t events_sysfs_show(struct device *dev, struct device_attribute *attr,
 			  char *page);
 ssize_t events_ht_sysfs_show(struct device *dev, struct device_attribute *attr,
-- 
2.20.1

