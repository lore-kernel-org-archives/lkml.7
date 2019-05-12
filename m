Return-Path: <SRS0=t4ha=TM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E6E1C04A6B
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 15:55:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F1562173B
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 15:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557676544;
	bh=RfSMSyy1CAw5Nx98J83ZXNuVbeefzJxjCagnJoG+gAw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fpY7bXfwkzhRG1iw+0S9AGhyED3e4EAOZzdMsBvJ0KUMHrg4M5njWFRJxi4DZO6dk
	 riilAM0uj6oASGFSC5CQYLRS/80uepuNfZg0NDWzvBdZfh9H8ZVvx1ZlX/3m5LF3+y
	 RVAYSkl+ubPnsJm/KirwuljS3dKOIzmulYs7Rjkc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727117AbfELPzn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 May 2019 11:55:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58086 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727048AbfELPzl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 May 2019 11:55:41 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AD7F63082A24;
        Sun, 12 May 2019 15:55:40 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-30.brq.redhat.com [10.40.204.30])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B50F15C26D;
        Sun, 12 May 2019 15:55:38 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andi Kleen <ak@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 8/9] perf/x86/intel: Use update attributes for skylake format
Date:   Sun, 12 May 2019 17:55:17 +0200
Message-Id: <20190512155518.21468-9-jolsa@kernel.org>
In-Reply-To: <20190512155518.21468-1-jolsa@kernel.org>
References: <20190512155518.21468-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Sun, 12 May 2019 15:55:40 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using the new pmu::update_attrs attribute group for
skylake specific format attributes.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 arch/x86/events/intel/core.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 524b390a2c26..7db858c3bbec 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4444,6 +4444,11 @@ static struct attribute_group group_format_extra = {
 	.is_visible = exra_is_visible,
 };
 
+static struct attribute_group group_format_extra_skl = {
+	.name       = "format",
+	.is_visible = exra_is_visible,
+};
+
 static const struct attribute_group *attr_update[] = {
 	&group_events_td,
 	&group_events_mem,
@@ -4451,6 +4456,7 @@ static const struct attribute_group *attr_update[] = {
 	&group_caps_gen,
 	&group_caps_lbr,
 	&group_format_extra,
+	&group_format_extra_skl,
 	NULL,
 };
 
@@ -4458,11 +4464,11 @@ static struct attribute *empty_attrs;
 
 __init int intel_pmu_init(void)
 {
+	struct attribute **extra_skl_attr = &empty_attrs;
 	struct attribute **extra_attr = &empty_attrs;
 	struct attribute **td_attr    = &empty_attrs;
 	struct attribute **mem_attr   = &empty_attrs;
 	struct attribute **tsx_attr   = &empty_attrs;
-	struct attribute **to_free = NULL;
 	union cpuid10_edx edx;
 	union cpuid10_eax eax;
 	union cpuid10_ebx ebx;
@@ -4950,8 +4956,7 @@ __init int intel_pmu_init(void)
 		x86_pmu.get_event_constraints = hsw_get_event_constraints;
 		extra_attr = boot_cpu_has(X86_FEATURE_RTM) ?
 			hsw_format_attr : nhm_format_attr;
-		extra_attr = merge_attr(extra_attr, skl_format_attr);
-		to_free = extra_attr;
+		extra_skl_attr = skl_format_attr;
 		td_attr  = hsw_events_attrs;
 		mem_attr = hsw_mem_events_attrs;
 		tsx_attr = hsw_tsx_events_attrs;
@@ -4989,7 +4994,7 @@ __init int intel_pmu_init(void)
 		x86_pmu.get_event_constraints = icl_get_event_constraints;
 		extra_attr = boot_cpu_has(X86_FEATURE_RTM) ?
 			hsw_format_attr : nhm_format_attr;
-		extra_attr = merge_attr(extra_attr, skl_format_attr);
+		extra_skl_attr = skl_format_attr;
 		mem_attr = icl_events_attrs;
 		tsx_attr = icl_tsx_events_attrs;
 		x86_pmu.rtm_abort_event = X86_CONFIG(.event=0xca, .umask=0x02);
@@ -5024,6 +5029,7 @@ __init int intel_pmu_init(void)
 	group_events_mem.attrs = mem_attr;
 	group_events_tsx.attrs = tsx_attr;
 	group_format_extra.attrs = extra_attr;
+	group_format_extra_skl.attrs = extra_skl_attr;
 
 	x86_pmu.attr_update = attr_update;
 
@@ -5104,7 +5110,6 @@ __init int intel_pmu_init(void)
 	if (x86_pmu.counter_freezing)
 		x86_pmu.handle_irq = intel_pmu_handle_irq_v4;
 
-	kfree(to_free);
 	return 0;
 }
 
-- 
2.20.1

