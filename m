Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D4F2C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 13:30:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F119A27EC7
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 13:30:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="AQ5CrqXS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728689AbfFCNam (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 09:30:42 -0400
Received: from terminus.zytor.com ([198.137.202.136]:40269 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726516AbfFCNak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 09:30:40 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x53DUSfU610066
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 3 Jun 2019 06:30:28 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x53DUSfU610066
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1559568628;
        bh=kqqgcIEe9TBckp/rBU3xR7G1MShwxAgAy2c9krmZhP0=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=AQ5CrqXSbbJTNAgH8aYkb/KHvA6ey5lPf4OzSEYPxyH0jyd0smKqr/QPS1fjIVrgv
         rsxAPEZTs/0K63nTHcWTsSFeGWWqxi3+2aDFfnky+N4RzZFiQ9weqfKut8Uw0umO+C
         rhPxEIbtdIe5dbxHmoKeVDP//NLNVmBkIL5N1hotphhv91d76ewe2wN72szCBfUek8
         gumFjiPZkQgt2rRN/mrdYZhIKGewAtomZfgwelePH6CUOubNzIwLqomORNLCuILkHJ
         7sfsVNB3iMUkSBfRZCqC/pIZnemblua3X+mgmwZNidsZesvFFUh8z+JhFYI4KW+FB7
         Vqty8NrNhJoog==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x53DURek610060;
        Mon, 3 Jun 2019 06:30:27 -0700
Date:   Mon, 3 Jun 2019 06:30:27 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-b657688069a24c3c81b6de22e0e57e1785d9211f@git.kernel.org>
Cc:     hpa@zytor.com, torvalds@linux-foundation.org, acme@kernel.org,
        tglx@linutronix.de, gregkh@linuxfoundation.org,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        peterz@infradead.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org, namhyung@kernel.org
Reply-To: linux-kernel@vger.kernel.org, namhyung@kernel.org,
          mingo@kernel.org, tglx@linutronix.de, acme@kernel.org,
          peterz@infradead.org, alexander.shishkin@linux.intel.com,
          gregkh@linuxfoundation.org, jolsa@kernel.org,
          torvalds@linux-foundation.org, hpa@zytor.com
In-Reply-To: <20190512155518.21468-9-jolsa@kernel.org>
References: <20190512155518.21468-9-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf/x86/intel: Use update attributes for skylake
 format
Git-Commit-ID: b657688069a24c3c81b6de22e0e57e1785d9211f
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

Commit-ID:  b657688069a24c3c81b6de22e0e57e1785d9211f
Gitweb:     https://git.kernel.org/tip/b657688069a24c3c81b6de22e0e57e1785d9211f
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Sun, 12 May 2019 17:55:17 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 3 Jun 2019 11:58:26 +0200

perf/x86/intel: Use update attributes for skylake format

Using the new pmu::update_attrs attribute group for
skylake specific format attributes.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20190512155518.21468-9-jolsa@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/events/intel/core.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index de4779f44737..3bc967be7c7b 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4453,6 +4453,11 @@ static struct attribute_group group_format_extra = {
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
@@ -4460,6 +4465,7 @@ static const struct attribute_group *attr_update[] = {
 	&group_caps_gen,
 	&group_caps_lbr,
 	&group_format_extra,
+	&group_format_extra_skl,
 	NULL,
 };
 
@@ -4467,11 +4473,11 @@ static struct attribute *empty_attrs;
 
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
@@ -4959,8 +4965,7 @@ __init int intel_pmu_init(void)
 		x86_pmu.get_event_constraints = hsw_get_event_constraints;
 		extra_attr = boot_cpu_has(X86_FEATURE_RTM) ?
 			hsw_format_attr : nhm_format_attr;
-		extra_attr = merge_attr(extra_attr, skl_format_attr);
-		to_free = extra_attr;
+		extra_skl_attr = skl_format_attr;
 		td_attr  = hsw_events_attrs;
 		mem_attr = hsw_mem_events_attrs;
 		tsx_attr = hsw_tsx_events_attrs;
@@ -4998,7 +5003,7 @@ __init int intel_pmu_init(void)
 		x86_pmu.get_event_constraints = icl_get_event_constraints;
 		extra_attr = boot_cpu_has(X86_FEATURE_RTM) ?
 			hsw_format_attr : nhm_format_attr;
-		extra_attr = merge_attr(extra_attr, skl_format_attr);
+		extra_skl_attr = skl_format_attr;
 		mem_attr = icl_events_attrs;
 		tsx_attr = icl_tsx_events_attrs;
 		x86_pmu.rtm_abort_event = X86_CONFIG(.event=0xca, .umask=0x02);
@@ -5033,6 +5038,7 @@ __init int intel_pmu_init(void)
 	group_events_mem.attrs = mem_attr;
 	group_events_tsx.attrs = tsx_attr;
 	group_format_extra.attrs = extra_attr;
+	group_format_extra_skl.attrs = extra_skl_attr;
 
 	x86_pmu.attr_update = attr_update;
 
@@ -5113,7 +5119,6 @@ __init int intel_pmu_init(void)
 	if (x86_pmu.counter_freezing)
 		x86_pmu.handle_irq = intel_pmu_handle_irq_v4;
 
-	kfree(to_free);
 	return 0;
 }
 
