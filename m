Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C9D9C7618F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 20:33:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E825E206DD
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 20:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564000393;
	bh=ybmtv7sVvNmwCWnKX2DmpwYfuWT0vtmWIUGJ0zeLnyw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jKM8WQlkl/4o224Y05rltPx3rydUlKO+iY9TySGGko9KdTp8lGKBP8WLtPCi6wPCG
	 utCYvIOFg/7+FRNY+VZMV74cnfmRyKUMwdXb11xCFWSr9Dq/wl3gxovb9YK/3qnOsY
	 NQ15+P/LnqK8TjahK6mAFHLkPhZwjJjirvVYHJuE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388180AbfGXT2K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 15:28:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:46186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727408AbfGXT2G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 15:28:06 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F0FA0229F3;
        Wed, 24 Jul 2019 19:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563996485;
        bh=ybmtv7sVvNmwCWnKX2DmpwYfuWT0vtmWIUGJ0zeLnyw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vtpvvk7TG2Jftz1DQZD4uldiFZ/t2rxow0dDyP/l1rfOxYf2uWcWtWe8eWXSE53z3
         5q8tmTVANnN824w9JdVzBrFog5psyi1CObKQMw555qmeCLpauy3DSCRxBXHZQKQuRx
         FoPsm4amoFysTnsQj8WxuKrVVkhJ4DI01Esexz3w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>, acme@kernel.org,
        eranian@google.com, Ingo Molnar <mingo@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.2 112/413] perf/x86/intel/uncore: Handle invalid event coding for free-running counter
Date:   Wed, 24 Jul 2019 21:16:43 +0200
Message-Id: <20190724191743.345792119@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190724191735.096702571@linuxfoundation.org>
References: <20190724191735.096702571@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 543ac280b3576c0009e8c0fcd4d6bfc9978d7bd0 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/events/intel/uncore.h       | 10 ++++++++++
 arch/x86/events/intel/uncore_snbep.c |  1 +
 2 files changed, 11 insertions(+)

diff --git a/arch/x86/events/intel/uncore.h b/arch/x86/events/intel/uncore.h
index 79eb2e21e4f0..28499e39679f 100644
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
index b10e04387f38..8e4e8e423839 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -3585,6 +3585,7 @@ static struct uncore_event_desc skx_uncore_iio_freerunning_events[] = {
 
 static struct intel_uncore_ops skx_uncore_iio_freerunning_ops = {
 	.read_counter		= uncore_msr_read_counter,
+	.hw_config		= uncore_freerunning_hw_config,
 };
 
 static struct attribute *skx_uncore_iio_freerunning_formats_attr[] = {
-- 
2.20.1



