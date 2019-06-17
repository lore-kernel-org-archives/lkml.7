Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64846C31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 14:41:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3612720833
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 14:41:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="oCimyAht"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728427AbfFQOlA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 10:41:00 -0400
Received: from terminus.zytor.com ([198.137.202.136]:59537 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726331AbfFQOlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 10:41:00 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5HEeUWE3459597
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 17 Jun 2019 07:40:30 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5HEeUWE3459597
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1560782431;
        bh=eAJM4htAFO/RzIZtoc04Np59pK7nqAeE+SyVMIhV1bA=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=oCimyAhtQgeTeyRJ3OdeiczNQ37txvhWIku0cOm+wFGbqN0O8zyEbM3Z1hU3muNdI
         PQ36tze5T7dXYSL9jhwDTZF5LEqQjbkhM6ebx3zqvBmfPsfE9RZSBIkOChSKN/U8tI
         RnPcI+mfQo+t3wCv55Ec5XrDZfYRa6RPhFaKEQ+2BBzTGMe7DfioMtH0iDG3USExUD
         ePwTsktTavTKso8EhZaozKBFLTSlL7IOQyfPSI9PsH1HZkwmNltm9X/vW7UwTkAlsx
         tLgPMbZ8LoY59XO61AfzRwaXtxoUWTGt2d2qbM3/QiXTv4InYbP+2sQYB5nPrbM22q
         y5KpRB0mJ4hrw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5HEeUVx3459594;
        Mon, 17 Jun 2019 07:40:30 -0700
Date:   Mon, 17 Jun 2019 07:40:30 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-b7c9b3927337b43b3c854064b9c17b84cb7ef0dc@git.kernel.org>
Cc:     namhyung@kernel.org, hpa@zytor.com, torvalds@linux-foundation.org,
        jolsa@redhat.com, alexander.shishkin@linux.intel.com,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, mingo@kernel.org, acme@kernel.org,
        tglx@linutronix.de, jolsa@kernel.org
Reply-To: namhyung@kernel.org, torvalds@linux-foundation.org,
          hpa@zytor.com, linux-kernel@vger.kernel.org,
          alexander.shishkin@linux.intel.com, gregkh@linuxfoundation.org,
          acme@kernel.org, jolsa@redhat.com, peterz@infradead.org,
          mingo@kernel.org, jolsa@kernel.org, tglx@linutronix.de
In-Reply-To: <20190524132152.GB26617@krava>
References: <20190524132152.GB26617@krava>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf/x86/intel: Use ->is_visible callback for
 default group
Git-Commit-ID: b7c9b3927337b43b3c854064b9c17b84cb7ef0dc
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

Commit-ID:  b7c9b3927337b43b3c854064b9c17b84cb7ef0dc
Gitweb:     https://git.kernel.org/tip/b7c9b3927337b43b3c854064b9c17b84cb7ef0dc
Author:     Jiri Olsa <jolsa@redhat.com>
AuthorDate: Fri, 24 May 2019 15:21:52 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 17 Jun 2019 12:36:23 +0200

perf/x86/intel: Use ->is_visible callback for default group

It's preffered to use group's ->is_visible callback, so
we do not need to use condition attribute assignment.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20190524132152.GB26617@krava
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/events/intel/core.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 4377bf6a6f82..5e6ae481dee7 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4391,7 +4391,7 @@ static DEVICE_ATTR(allow_tsx_force_abort, 0644,
 
 static struct attribute *intel_pmu_attrs[] = {
 	&dev_attr_freeze_on_smi.attr,
-	NULL, /* &dev_attr_allow_tsx_force_abort.attr.attr */
+	&dev_attr_allow_tsx_force_abort.attr,
 	NULL,
 };
 
@@ -4419,6 +4419,15 @@ exra_is_visible(struct kobject *kobj, struct attribute *attr, int i)
 	return x86_pmu.version >= 2 ? attr->mode : 0;
 }
 
+static umode_t
+default_is_visible(struct kobject *kobj, struct attribute *attr, int i)
+{
+	if (attr == &dev_attr_allow_tsx_force_abort.attr)
+		return x86_pmu.flags & PMU_FL_TFA ? attr->mode : 0;
+
+	return attr->mode;
+}
+
 static struct attribute_group group_events_td  = {
 	.name = "events",
 };
@@ -4455,7 +4464,8 @@ static struct attribute_group group_format_extra_skl = {
 };
 
 static struct attribute_group group_default = {
-	.attrs = intel_pmu_attrs,
+	.attrs      = intel_pmu_attrs,
+	.is_visible = default_is_visible,
 };
 
 static const struct attribute_group *attr_update[] = {
@@ -4979,7 +4989,6 @@ __init int intel_pmu_init(void)
 			x86_pmu.get_event_constraints = tfa_get_event_constraints;
 			x86_pmu.enable_all = intel_tfa_pmu_enable_all;
 			x86_pmu.commit_scheduling = intel_tfa_commit_scheduling;
-			intel_pmu_attrs[1] = &dev_attr_allow_tsx_force_abort.attr;
 		}
 
 		pr_cont("Skylake events, ");
