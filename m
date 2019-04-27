Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D742BC43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:43:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABB18216C4
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556329423;
	bh=J8vC0Lmws0rOVsDQHj+4NlZYsvk5fAlA6JXOh9D+obI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BpeFL+StTebibXOfhhHz2dJiaLvcRV1iB/j90N+jJPQOGpq3dM8LGShmA0xpnLw4Y
	 lHEFXNH/yGSfGnjL9UoaaiWwK/VzAzYuFZiTO5c3gbzJH7DmypSRJS1IEPtKcuQVHO
	 SBWfKxF9A9UU1QffXP5S85M0ns8ZI5gsQ26ymb34=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728835AbfD0Bnm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 21:43:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:47848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727609AbfD0Bnj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 21:43:39 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 56381208CB;
        Sat, 27 Apr 2019 01:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556329418;
        bh=J8vC0Lmws0rOVsDQHj+4NlZYsvk5fAlA6JXOh9D+obI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cm3u5l4JXB1xUEn3Uqnc4Ut6Wmiat6Ji3rNQZVA7IiEW9r67pt0bmxwenYc8S6cyF
         2aFLxVQV4a54ZgwZjltlgl43xMZLRuBvHtJHXR5qj8uGMItgle2nduFzFMqYmmWVEc
         Jwsc8vmxvcJ/3tLF8aS9eNBjLLzGFS6xNBOa3Zn8=
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
Subject: [PATCH AUTOSEL 4.9 08/16] perf/x86/intel: Fix handling of wakeup_events for multi-entry PEBS
Date:   Fri, 26 Apr 2019 21:43:16 -0400
Message-Id: <20190427014325.8704-8-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190427014325.8704-1-sashal@kernel.org>
References: <20190427014325.8704-1-sashal@kernel.org>
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
 arch/x86/events/intel/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 098ab775135f..a30829052a00 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2867,7 +2867,7 @@ static int intel_pmu_hw_config(struct perf_event *event)
 		return ret;
 
 	if (event->attr.precise_ip) {
-		if (!event->attr.freq) {
+		if (!(event->attr.freq || event->attr.wakeup_events)) {
 			event->hw.flags |= PERF_X86_EVENT_AUTO_RELOAD;
 			if (!(event->attr.sample_type &
 			      ~intel_pmu_free_running_flags(event)))
-- 
2.19.1

