Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59818C4321A
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:45:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F08F208CB
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556329513;
	bh=XHIOOXPxbsTYFyu9RF455RQuy5R/xjFiNMEGbESQVXU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hjV3Ynzb2HD5L8w4ixH8N/8cBUFrtrotrjc8GUysHqvdmzxBlnAU5jGXiwSz5IBb/
	 NVKF1f5g/4mAP+Xe+ihJEHQhbcl7rI6xlKvAjnS0KLXLkqNmqM0Eyng0po5CpxFOTc
	 iN81scpqyNB2fD+RYeLq91f9LOtm5DD6FWrm1u8M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728938AbfD0BoI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 21:44:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:48398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728530AbfD0BoE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 21:44:04 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 740DD2166E;
        Sat, 27 Apr 2019 01:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556329443;
        bh=XHIOOXPxbsTYFyu9RF455RQuy5R/xjFiNMEGbESQVXU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JobfkEJOSKBWgjCd93vH1Ef77ePwI/EfAolbRi4AoWUT+hCYWjRMlXODTWyuCzhyz
         nTTLTR9QlzRXuc53FDXy9wne8bYsfsvvA5xXJ7HqpClF0k9IHd5PMF57PxSseXEZqE
         Pvr8UUPo3RQNVT0sDKSw8eMQPYX86DZJfAsT6Qio=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vince Weaver <vincent.weaver@maine.edu>, kan.liang@intel.com,
        Ingo Molnar <mingo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.4 5/9] perf/x86/intel: Fix handling of wakeup_events for multi-entry PEBS
Date:   Fri, 26 Apr 2019 21:43:50 -0400
Message-Id: <20190427014356.8940-5-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190427014356.8940-1-sashal@kernel.org>
References: <20190427014356.8940-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephane Eranian <eranian@google.com>

[ Upstream commit 583feb08e7f7ac9d533b446882eb3a54737a6dbb ]

When an event is programmed with attr.wakeup_events=N (N>0), it means
the caller is interested in getting a user level notification after
N samples have been recorded in the kernel sampling buffer.

With precise events on Intel processors, the kernel uses PEBS.
The kernel tries minimize sampling overhead by verifying
if the event configuration is compatible with multi-entry PEBS mode.
If so, the kernel is notified only when the buffer has reached its threshold.
Other PEBS operates in single-entry mode, the kenrel is notified for each
PEBS sample.

The problem is that the current implementation look at frequency
mode and event sample_type but ignores the wakeup_events field. Thus,
it may not be possible to receive a notification after each precise event.

This patch fixes this problem by disabling multi-entry PEBS if wakeup_events
is non-zero.

Signed-off-by: Stephane Eranian <eranian@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vince Weaver <vincent.weaver@maine.edu>
Cc: kan.liang@intel.com
Link: https://lkml.kernel.org/r/20190306195048.189514-1-eranian@google.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kernel/cpu/perf_event_intel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/perf_event_intel.c b/arch/x86/kernel/cpu/perf_event_intel.c
index 7b79c80ce029..325ed90511cf 100644
--- a/arch/x86/kernel/cpu/perf_event_intel.c
+++ b/arch/x86/kernel/cpu/perf_event_intel.c
@@ -2513,7 +2513,7 @@ static int intel_pmu_hw_config(struct perf_event *event)
 		return ret;
 
 	if (event->attr.precise_ip) {
-		if (!event->attr.freq) {
+		if (!(event->attr.freq || event->attr.wakeup_events)) {
 			event->hw.flags |= PERF_X86_EVENT_AUTO_RELOAD;
 			if (!(event->attr.sample_type &
 			      ~intel_pmu_free_running_flags(event)))
-- 
2.19.1

