Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7262FC468BD
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 17:16:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C6D020652
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 17:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560100606;
	bh=uKTfa6R6jqALUJK7DVdLFLmpqOvs9h8n51zlZNuQ5r4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tGUzySgRJQjLGN4MiqpwLo9zZt9yxv79E6seCisH6VToQEw/IlVlxQN6/zgOYumSw
	 acxMagDAyAuNf/ePWxdFoQopJgdlAPJlH/2pdY2EEuo7SxvL48v2lG0+CNT/cOLGdd
	 xrZkl9Y1Zq9ELUJrw9sZZbZIUnn6Ex4cxp0SOXcA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387402AbfFIRQp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 13:16:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:53990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731609AbfFIQwz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 12:52:55 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 13A19206BB;
        Sun,  9 Jun 2019 16:52:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560099174;
        bh=uKTfa6R6jqALUJK7DVdLFLmpqOvs9h8n51zlZNuQ5r4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=02L7KotOYJ6qL/MhaUGQ/M87pUX1Zgkj5HJx+QNLJpvRcrHAHi00T4cWMUnsDSwUf
         fGz/rKCTd8HNrcEylylg7Fy2iD8lMfu/FeV1DUetWmogAESUkrUWQHVkn154R//UTo
         izz6AI4LRdf/90ydmnjPBaQCGLaO/ZUOjgjhzHJY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.9 37/83] powerpc/perf: Fix MMCRA corruption by bhrb_filter
Date:   Sun,  9 Jun 2019 18:42:07 +0200
Message-Id: <20190609164130.962220286@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190609164127.843327870@linuxfoundation.org>
References: <20190609164127.843327870@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ravi Bangoria <ravi.bangoria@linux.ibm.com>

commit 3202e35ec1c8fc19cea24253ff83edf702a60a02 upstream.

Consider a scenario where user creates two events:

  1st event:
    attr.sample_type |= PERF_SAMPLE_BRANCH_STACK;
    attr.branch_sample_type = PERF_SAMPLE_BRANCH_ANY;
    fd = perf_event_open(attr, 0, 1, -1, 0);

  This sets cpuhw->bhrb_filter to 0 and returns valid fd.

  2nd event:
    attr.sample_type |= PERF_SAMPLE_BRANCH_STACK;
    attr.branch_sample_type = PERF_SAMPLE_BRANCH_CALL;
    fd = perf_event_open(attr, 0, 1, -1, 0);

  It overrides cpuhw->bhrb_filter to -1 and returns with error.

Now if power_pmu_enable() gets called by any path other than
power_pmu_add(), ppmu->config_bhrb(-1) will set MMCRA to -1.

Fixes: 3925f46bb590 ("powerpc/perf: Enable branch stack sampling framework")
Cc: stable@vger.kernel.org # v3.10+
Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Reviewed-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/perf/core-book3s.c |    6 ++++--
 arch/powerpc/perf/power8-pmu.c  |    3 +++
 arch/powerpc/perf/power9-pmu.c  |    3 +++
 3 files changed, 10 insertions(+), 2 deletions(-)

--- a/arch/powerpc/perf/core-book3s.c
+++ b/arch/powerpc/perf/core-book3s.c
@@ -1800,6 +1800,7 @@ static int power_pmu_event_init(struct p
 	int n;
 	int err;
 	struct cpu_hw_events *cpuhw;
+	u64 bhrb_filter;
 
 	if (!ppmu)
 		return -ENOENT;
@@ -1896,13 +1897,14 @@ static int power_pmu_event_init(struct p
 	err = power_check_constraints(cpuhw, events, cflags, n + 1);
 
 	if (has_branch_stack(event)) {
-		cpuhw->bhrb_filter = ppmu->bhrb_filter_map(
+		bhrb_filter = ppmu->bhrb_filter_map(
 					event->attr.branch_sample_type);
 
-		if (cpuhw->bhrb_filter == -1) {
+		if (bhrb_filter == -1) {
 			put_cpu_var(cpu_hw_events);
 			return -EOPNOTSUPP;
 		}
+		cpuhw->bhrb_filter = bhrb_filter;
 	}
 
 	put_cpu_var(cpu_hw_events);
--- a/arch/powerpc/perf/power8-pmu.c
+++ b/arch/powerpc/perf/power8-pmu.c
@@ -29,6 +29,7 @@ enum {
 #define	POWER8_MMCRA_IFM1		0x0000000040000000UL
 #define	POWER8_MMCRA_IFM2		0x0000000080000000UL
 #define	POWER8_MMCRA_IFM3		0x00000000C0000000UL
+#define	POWER8_MMCRA_BHRB_MASK		0x00000000C0000000UL
 
 /* Table of alternatives, sorted by column 0 */
 static const unsigned int event_alternatives[][MAX_ALT] = {
@@ -262,6 +263,8 @@ static u64 power8_bhrb_filter_map(u64 br
 
 static void power8_config_bhrb(u64 pmu_bhrb_filter)
 {
+	pmu_bhrb_filter &= POWER8_MMCRA_BHRB_MASK;
+
 	/* Enable BHRB filter in PMU */
 	mtspr(SPRN_MMCRA, (mfspr(SPRN_MMCRA) | pmu_bhrb_filter));
 }
--- a/arch/powerpc/perf/power9-pmu.c
+++ b/arch/powerpc/perf/power9-pmu.c
@@ -30,6 +30,7 @@ enum {
 #define POWER9_MMCRA_IFM1		0x0000000040000000UL
 #define POWER9_MMCRA_IFM2		0x0000000080000000UL
 #define POWER9_MMCRA_IFM3		0x00000000C0000000UL
+#define POWER9_MMCRA_BHRB_MASK		0x00000000C0000000UL
 
 GENERIC_EVENT_ATTR(cpu-cycles,			PM_CYC);
 GENERIC_EVENT_ATTR(stalled-cycles-frontend,	PM_ICT_NOSLOT_CYC);
@@ -177,6 +178,8 @@ static u64 power9_bhrb_filter_map(u64 br
 
 static void power9_config_bhrb(u64 pmu_bhrb_filter)
 {
+	pmu_bhrb_filter &= POWER9_MMCRA_BHRB_MASK;
+
 	/* Enable BHRB filter in PMU */
 	mtspr(SPRN_MMCRA, (mfspr(SPRN_MMCRA) | pmu_bhrb_filter));
 }


