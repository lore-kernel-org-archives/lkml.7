Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8911C2D0CD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 12:39:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 893A124685
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 12:39:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728247AbfLQMj5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 07:39:57 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:55235 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727975AbfLQMj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 07:39:57 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1ihC8l-0001o6-L9; Tue, 17 Dec 2019 13:39:51 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id F35531C2A3E;
        Tue, 17 Dec 2019 13:39:50 +0100 (CET)
Date:   Tue, 17 Dec 2019 12:39:50 -0000
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/x86: Fix potential out-of-bounds access
Cc:     Meelis Roos <mroos@linux.ee>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <157658639085.30329.2905901089064836333.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     1e69a0efc0bd0e02b8327e7186fbb4a81878ea0b
Gitweb:        https://git.kernel.org/tip/1e69a0efc0bd0e02b8327e7186fbb4a81878ea0b
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 06 Dec 2019 12:50:16 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 17 Dec 2019 13:32:46 +01:00

perf/x86: Fix potential out-of-bounds access

UBSAN reported out-of-bound accesses for x86_pmu.event_map(), it's
arguments should be < x86_pmu.max_events. Make sure all users observe
this constraint.

Reported-by: Meelis Roos <mroos@linux.ee>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Meelis Roos <mroos@linux.ee>
---
 arch/x86/events/core.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 9a89d98..84fe1be 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -1642,9 +1642,12 @@ static struct attribute_group x86_pmu_format_group __ro_after_init = {
 
 ssize_t events_sysfs_show(struct device *dev, struct device_attribute *attr, char *page)
 {
-	struct perf_pmu_events_attr *pmu_attr = \
+	struct perf_pmu_events_attr *pmu_attr =
 		container_of(attr, struct perf_pmu_events_attr, attr);
-	u64 config = x86_pmu.event_map(pmu_attr->id);
+	u64 config = 0;
+
+	if (pmu_attr->id < x86_pmu.max_events)
+		config = x86_pmu.event_map(pmu_attr->id);
 
 	/* string trumps id */
 	if (pmu_attr->event_str)
@@ -1713,6 +1716,9 @@ is_visible(struct kobject *kobj, struct attribute *attr, int idx)
 {
 	struct perf_pmu_events_attr *pmu_attr;
 
+	if (idx >= x86_pmu.max_events)
+		return 0;
+
 	pmu_attr = container_of(attr, struct perf_pmu_events_attr, attr.attr);
 	/* str trumps id */
 	return pmu_attr->event_str || x86_pmu.event_map(idx) ? attr->mode : 0;
