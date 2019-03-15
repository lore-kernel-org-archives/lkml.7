Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21049C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 11:29:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC19021871
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 11:29:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728729AbfCOL3a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 07:29:30 -0400
Received: from terminus.zytor.com ([198.137.202.136]:41909 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726503AbfCOL3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 07:29:30 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x2FBT7WM1550573
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 15 Mar 2019 04:29:08 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x2FBT7r41550570;
        Fri, 15 Mar 2019 04:29:07 -0700
Date:   Fri, 15 Mar 2019 04:29:07 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Peter Zijlstra <tipbot@zytor.com>
Message-ID: <tip-ede271b059463731cbd6dffe55ffd70d7dbe8392@git.kernel.org>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org,
        peterz@infradead.org, hpa@zytor.com, tglx@linutronix.de,
        nelson.dsouza@intel.com, tonyj@suse.com
Reply-To: linux-kernel@vger.kernel.org, hpa@zytor.com,
          nelson.dsouza@intel.com, tglx@linutronix.de, tonyj@suse.com,
          peterz@infradead.org, mingo@kernel.org
In-Reply-To: <20190314130705.441549378@infradead.org>
References: <20190314130705.441549378@infradead.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf/x86/intel: Fix memory corruption
Git-Commit-ID: ede271b059463731cbd6dffe55ffd70d7dbe8392
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

Commit-ID:  ede271b059463731cbd6dffe55ffd70d7dbe8392
Gitweb:     https://git.kernel.org/tip/ede271b059463731cbd6dffe55ffd70d7dbe8392
Author:     Peter Zijlstra <peterz@infradead.org>
AuthorDate: Thu, 14 Mar 2019 14:01:14 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 15 Mar 2019 12:22:51 +0100

perf/x86/intel: Fix memory corruption

Through:

  validate_event()
    x86_pmu.get_event_constraints(.idx=-1)
      tfa_get_event_constraints()
        dyn_constraint()

cpuc->constraint_list[-1] is used, which is an obvious out-of-bound access.

In this case, simply skip the TFA constraint code, there is no event
constraint with just PMC3, therefore the code will never result in the
empty set.

Fixes: 400816f60c54 ("perf/x86/intel: Implement support for TSX Force Abort")
Reported-by: Tony Jones <tonyj@suse.com>
Reported-by: "DSouza, Nelson" <nelson.dsouza@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Tony Jones <tonyj@suse.com>
Tested-by: "DSouza, Nelson" <nelson.dsouza@intel.com>
Cc: eranian@google.com
Cc: jolsa@redhat.com
Cc: stable@kernel.org
Link: https://lkml.kernel.org/r/20190314130705.441549378@infradead.org

---
 arch/x86/events/intel/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 35102ecdfc8d..92dfeb343a6a 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3410,7 +3410,7 @@ tfa_get_event_constraints(struct cpu_hw_events *cpuc, int idx,
 	/*
 	 * Without TFA we must not use PMC3.
 	 */
-	if (!allow_tsx_force_abort && test_bit(3, c->idxmsk)) {
+	if (!allow_tsx_force_abort && test_bit(3, c->idxmsk) && idx >= 0) {
 		c = dyn_constraint(cpuc, c, idx);
 		c->idxmsk64 &= ~(1ULL << 3);
 		c->weight--;
