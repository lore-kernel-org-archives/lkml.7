Return-Path: <SRS0=GVTe=2R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C206C2D0C6
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 18:15:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE93120722
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 18:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577470516;
	bh=ehWXxgL2qGAl8OpB2pwYtJRf+xpwsJCv8hYXYxukeQk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=T9l5/Y9m/MZKfcUDsUwgSIacMUnowcbh69L3eK0tDraFTinCK6Xd4E4bcIkwMuete
	 gfzi+6e1pdp5dD/gPEgUJoglm9BKqQYUpUIB/g8Xm/Cm5kZoomv0j1sji78gpc3Hw6
	 N43NpxNDvTyPOHGyHihja7ZTFF6WX3u6Vc/E/kHc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727884AbfL0SPP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Dec 2019 13:15:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:39914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727841AbfL0SPM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Dec 2019 13:15:12 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B8D8B222D9;
        Fri, 27 Dec 2019 18:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577470511;
        bh=ehWXxgL2qGAl8OpB2pwYtJRf+xpwsJCv8hYXYxukeQk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jphNgaIeTx/SSK+3NWOrAcxbQuFwg+61ouHKHC6ZSoMY5vu0te3+9CL8PnNq6Js6J
         Xx88ZDqUyBPkpL5iwWSg6rRSxkMozIZwrtVoUWKNl471N2bmt/BplIhEn0K0TnGV/b
         gcam+z5N16nFHt8ac6o1e1l0+7uNgJAiQnRDKbpM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Vitaly Slobodskoy <vitaly.slobodskoy@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 29/38] perf/x86/intel: Fix PT PMI handling
Date:   Fri, 27 Dec 2019 13:14:26 -0500
Message-Id: <20191227181435.7644-29-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191227181435.7644-1-sashal@kernel.org>
References: <20191227181435.7644-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Shishkin <alexander.shishkin@linux.intel.com>

[ Upstream commit 92ca7da4bdc24d63bb0bcd241c11441ddb63b80a ]

Commit:

  ccbebba4c6bf ("perf/x86/intel/pt: Bypass PT vs. LBR exclusivity if the core supports it")

skips the PT/LBR exclusivity check on CPUs where PT and LBRs coexist, but
also inadvertently skips the active_events bump for PT in that case, which
is a bug. If there aren't any hardware events at the same time as PT, the
PMI handler will ignore PT PMIs, as active_events reads zero in that case,
resulting in the "Uhhuh" spurious NMI warning and PT data loss.

Fix this by always increasing active_events for PT events.

Fixes: ccbebba4c6bf ("perf/x86/intel/pt: Bypass PT vs. LBR exclusivity if the core supports it")
Reported-by: Vitaly Slobodskoy <vitaly.slobodskoy@intel.com>
Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Link: https://lkml.kernel.org/r/20191210105101.77210-1-alexander.shishkin@linux.intel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/events/core.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 1e9f610d36a4..c26cca506f64 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -374,7 +374,7 @@ int x86_add_exclusive(unsigned int what)
 	 * LBR and BTS are still mutually exclusive.
 	 */
 	if (x86_pmu.lbr_pt_coexist && what == x86_lbr_exclusive_pt)
-		return 0;
+		goto out;
 
 	if (!atomic_inc_not_zero(&x86_pmu.lbr_exclusive[what])) {
 		mutex_lock(&pmc_reserve_mutex);
@@ -386,6 +386,7 @@ int x86_add_exclusive(unsigned int what)
 		mutex_unlock(&pmc_reserve_mutex);
 	}
 
+out:
 	atomic_inc(&active_events);
 	return 0;
 
@@ -396,11 +397,15 @@ int x86_add_exclusive(unsigned int what)
 
 void x86_del_exclusive(unsigned int what)
 {
+	atomic_dec(&active_events);
+
+	/*
+	 * See the comment in x86_add_exclusive().
+	 */
 	if (x86_pmu.lbr_pt_coexist && what == x86_lbr_exclusive_pt)
 		return;
 
 	atomic_dec(&x86_pmu.lbr_exclusive[what]);
-	atomic_dec(&active_events);
 }
 
 int x86_setup_perfctr(struct perf_event *event)
-- 
2.20.1

