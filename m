Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2A60C76192
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 03:24:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B7AC2053B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 03:24:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563420255;
	bh=HTMTVcyI4ODRSZYSR5Zt8vuz0PIAJWXWe2GIrXjEO7A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1kN6UIvxYAus71Ty5xs0+xDh87diu5vqk6lwOsBGJS9CrsiPAFgq4YCF5zGfqgMDo
	 4h7WEUpZYeBMAS5mtVSHDeDOY4FyVCFRpZQ1mS9D+LqoxJi0dLW9Om5XFpTklUKGsL
	 4R5qa2PO7yFNnbn/6Tsx61krHklAucne3+r+0bJo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390437AbfGRDYO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 23:24:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:38898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390417AbfGRDHV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 23:07:21 -0400
Received: from localhost (115.42.148.210.bf.2iij.net [210.148.42.115])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D08921841;
        Thu, 18 Jul 2019 03:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563419241;
        bh=HTMTVcyI4ODRSZYSR5Zt8vuz0PIAJWXWe2GIrXjEO7A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zUKgjymwDDLUaNkD0XBwUNHBslJioD1XLVbCxx4Sx0fi/Ia7AtgnLUOUIG5QwRxR2
         PbSK9VHAJavDkEhNHSp2WjorQwwHwvtJWv0HS34wxzArx60ruIGalOHO2QB/gYrl8O
         59p4UDDs4Z/wL5aCK+OlTZZA8FpFba/Ey3cvC2P4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>,
        Young Xiao <92siuyang@gmail.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Stephane Eranian <eranian@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 10/47] perf/core: Fix perf_sample_regs_user() mm check
Date:   Thu, 18 Jul 2019 12:01:24 +0900
Message-Id: <20190718030049.458927533@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190718030045.780672747@linuxfoundation.org>
References: <20190718030045.780672747@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 085ebfe937d7a7a5df1729f35a12d6d655fea68c ]

perf_sample_regs_user() uses 'current->mm' to test for the presence of
userspace, but this is insufficient, consider use_mm().

A better test is: '!(current->flags & PF_KTHREAD)', exec() clears
PF_KTHREAD after it sets the new ->mm but before it drops to userspace
for the first time.

Possibly obsoletes: bf05fc25f268 ("powerpc/perf: Fix oops when kthread execs user process")

Reported-by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Reported-by: Young Xiao <92siuyang@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Will Deacon <will.deacon@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Frederic Weisbecker <fweisbec@gmail.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Fixes: 4018994f3d87 ("perf: Add ability to attach user level registers dump to sample")
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/events/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 171b83ebed4a..3b61ff40bfe2 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -5906,7 +5906,7 @@ static void perf_sample_regs_user(struct perf_regs *regs_user,
 	if (user_mode(regs)) {
 		regs_user->abi = perf_reg_abi(current);
 		regs_user->regs = regs;
-	} else if (current->mm) {
+	} else if (!(current->flags & PF_KTHREAD)) {
 		perf_get_regs_user(regs_user, regs, regs_user_copy);
 	} else {
 		regs_user->abi = PERF_SAMPLE_REGS_ABI_NONE;
-- 
2.20.1



