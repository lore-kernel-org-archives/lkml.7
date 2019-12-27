Return-Path: <SRS0=GVTe=2R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0C01C2D0C6
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 17:46:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B52BC206CB
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 17:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577468802;
	bh=9qcvowxmEQncxH6EJpnreHVGbP7op9XJu/sacMFNzTc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vRT1waHfMZw05m+/izoOMc7izdpK3zR7z7Fga5/I5Oarq+4tU//pJmPbwesH8Mv2d
	 +P4ij8+sn1r4llcOTXdGh46zcBJLX7am4+xg++SSlnn8WFjQaf89u58H6JOpasgd+G
	 kxDOKqMTI+CEPPYWf6lvwU5p+yse4mgvqaHcPvlM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728774AbfL0Rql (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Dec 2019 12:46:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:43650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728245AbfL0RpK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Dec 2019 12:45:10 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4CA9A20740;
        Fri, 27 Dec 2019 17:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577468710;
        bh=9qcvowxmEQncxH6EJpnreHVGbP7op9XJu/sacMFNzTc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P9YNgbuLzSoU4qqVgjrkuY+rPa+yNWhC8z/B1PJ4YHznWp4XhDUCMdaFSpSfB/pO9
         TjlMmSuDXUs1U9NYvpFKH5/hAWYHvO1c+zUgLKihm1D9MeFl60j7mN+AK9nnRZIIS7
         Jp/8419sMK5FGovKmgdXI8WhgUdrln4TtMTgv2QA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Vitaly Slobodskoy <vitaly.slobodskoy@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 65/84] perf/x86/intel: Fix PT PMI handling
Date:   Fri, 27 Dec 2019 12:43:33 -0500
Message-Id: <20191227174352.6264-65-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191227174352.6264-1-sashal@kernel.org>
References: <20191227174352.6264-1-sashal@kernel.org>
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
index c9625bff4328..429389489eed 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -375,7 +375,7 @@ int x86_add_exclusive(unsigned int what)
 	 * LBR and BTS are still mutually exclusive.
 	 */
 	if (x86_pmu.lbr_pt_coexist && what == x86_lbr_exclusive_pt)
-		return 0;
+		goto out;
 
 	if (!atomic_inc_not_zero(&x86_pmu.lbr_exclusive[what])) {
 		mutex_lock(&pmc_reserve_mutex);
@@ -387,6 +387,7 @@ int x86_add_exclusive(unsigned int what)
 		mutex_unlock(&pmc_reserve_mutex);
 	}
 
+out:
 	atomic_inc(&active_events);
 	return 0;
 
@@ -397,11 +398,15 @@ int x86_add_exclusive(unsigned int what)
 
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

