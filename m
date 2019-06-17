Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38980C31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 14:37:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A45E2084A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 14:37:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="pDFORBCX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728380AbfFQOh0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 10:37:26 -0400
Received: from terminus.zytor.com ([198.137.202.136]:39777 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbfFQOh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 10:37:26 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5HEaFoQ3458597
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 17 Jun 2019 07:36:16 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5HEaFoQ3458597
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1560782176;
        bh=WZOVt5Al31fQSyk2wq6cOcPSLYFOYjKmjGllZ4BcJ/c=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=pDFORBCXS9NxxDXBlk4NVnJL0qbkVD8Ud4t/5jCrocixOTDtJzmN2impaItrEQqXn
         VGeSj5Rd7vrZrBCfzU/emhmMWxCweM+C9JU2wJ+s3BuJT9RdgovWcEKStO74S3LsgL
         K6N528N318GGeH9q+vU6nBzPu8ZIXcFEYVpuP1zx2J5/pMRHI3eH9EJoygkB+AoWP8
         JMr2CZUm9q2KIVcAjpFqkR/swmGKZebi2PoQEIz6k5q/6qvD2tk3ovnZKPWB+cmheR
         Y1Qm+vgeN/3SdNTOwtQn80jSc25icr3N/Xpygcr4sTXmIO5QAE3tTFO8xVqq4HT+6M
         F5mk5WiabxE0Q==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5HEaFCv3458594;
        Mon, 17 Jun 2019 07:36:15 -0700
Date:   Mon, 17 Jun 2019 07:36:15 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Kan Liang <tipbot@zytor.com>
Message-ID: <tip-543ac280b3576c0009e8c0fcd4d6bfc9978d7bd0@git.kernel.org>
Cc:     mingo@kernel.org, peterz@infradead.org,
        torvalds@linux-foundation.org, kan.liang@linux.intel.com,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, hpa@zytor.com
Reply-To: hpa@zytor.com, tglx@linutronix.de, linux-kernel@vger.kernel.org,
          kan.liang@linux.intel.com, torvalds@linux-foundation.org,
          peterz@infradead.org, mingo@kernel.org
In-Reply-To: <1556672028-119221-2-git-send-email-kan.liang@linux.intel.com>
References: <1556672028-119221-2-git-send-email-kan.liang@linux.intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf/x86/intel/uncore: Handle invalid event coding
 for free-running counter
Git-Commit-ID: 543ac280b3576c0009e8c0fcd4d6bfc9978d7bd0
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

Commit-ID:  543ac280b3576c0009e8c0fcd4d6bfc9978d7bd0
Gitweb:     https://git.kernel.org/tip/543ac280b3576c0009e8c0fcd4d6bfc9978d7bd0
Author:     Kan Liang <kan.liang@linux.intel.com>
AuthorDate: Tue, 30 Apr 2019 17:53:43 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 17 Jun 2019 12:36:17 +0200

perf/x86/intel/uncore: Handle invalid event coding for free-running counter

Counting with invalid event coding for free-running counter may cause
OOPs, e.g. uncore_iio_free_running_0/event=1/.

Current code only validate the event with free-running event format,
event=0xff,umask=0xXY. Non-free-running event format never be checked
for the PMU with free-running counters.

Add generic hw_config() to check and reject the invalid event coding
for free-running PMU.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: acme@kernel.org
Cc: eranian@google.com
Fixes: 0f519f0352e3 ("perf/x86/intel/uncore: Support IIO free-running counters on SKX")
Link: https://lkml.kernel.org/r/1556672028-119221-2-git-send-email-kan.liang@linux.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/events/intel/uncore.h       | 10 ++++++++++
 arch/x86/events/intel/uncore_snbep.c |  1 +
 2 files changed, 11 insertions(+)

diff --git a/arch/x86/events/intel/uncore.h b/arch/x86/events/intel/uncore.h
index 33aba2504cb1..b3cad2b65766 100644
--- a/arch/x86/events/intel/uncore.h
+++ b/arch/x86/events/intel/uncore.h
@@ -419,6 +419,16 @@ static inline bool is_freerunning_event(struct perf_event *event)
 	       (((cfg >> 8) & 0xff) >= UNCORE_FREERUNNING_UMASK_START);
 }
 
+/* Check and reject invalid config */
+static inline int uncore_freerunning_hw_config(struct intel_uncore_box *box,
+					       struct perf_event *event)
+{
+	if (is_freerunning_event(event))
+		return 0;
+
+	return -EINVAL;
+}
+
 static inline void uncore_disable_box(struct intel_uncore_box *box)
 {
 	if (box->pmu->type->ops->disable_box)
diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index bbe89bc589f9..fdb1a57ee1e5 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -3585,6 +3585,7 @@ static struct uncore_event_desc skx_uncore_iio_freerunning_events[] = {
 
 static struct intel_uncore_ops skx_uncore_iio_freerunning_ops = {
 	.read_counter		= uncore_msr_read_counter,
+	.hw_config		= uncore_freerunning_hw_config,
 };
 
 static struct attribute *skx_uncore_iio_freerunning_formats_attr[] = {
