Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8E05C43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 11:28:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 991922075C
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 11:28:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="dms0igBi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727542AbfECL2k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 07:28:40 -0400
Received: from terminus.zytor.com ([198.137.202.136]:38227 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726572AbfECL2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 07:28:40 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x43BSLdX2724835
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 3 May 2019 04:28:21 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x43BSLdX2724835
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1556882902;
        bh=BZTgR1dxnLstC7BgNRwTrxpOuxvNd3XMbzBF+gFrCRc=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=dms0igBiOTWtEhkLLbakyAkwenf8y1PKAOaIiHRivrCgHMSMlA/BLNx6HWTlnB7qu
         ZptePo4UvRrvqPBXZSdkOTHPhnfqDosVvM5yyfPYpWO0uUTvDvcJnC1cHlSHazHj9i
         dMKRHOgmZ4nhwHsjuMxAKNQ1XV2eBZHzT1QvAe7IP1+QRr5yyh5Qddq0e2PdAl2dCX
         DvvPA+Xmz76wBthMP51N1ojJCFyXJQk9aVEUVDrHHEn5tuk2BxKM94qQ62yxzLEKGH
         FVOZkyP6FkzgWMlP/dTJ+gvqlfrNbdbNQrjgDKuxCaf+/2rm+7eoD59AU14DPFBTDc
         Sr+dc/LFzziaQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x43BSKBk2724831;
        Fri, 3 May 2019 04:28:20 -0700
Date:   Fri, 3 May 2019 04:28:20 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Nicholas Piggin <tipbot@zytor.com>
Message-ID: <tip-77a5352ba977d2554643e3797e10823d0d03dcf7@git.kernel.org>
Cc:     torvalds@linux-foundation.org, mingo@kernel.org,
        rafael.j.wysocki@intel.com, npiggin@gmail.com, hpa@zytor.com,
        fweisbec@gmail.com, peterz@infradead.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org
Reply-To: npiggin@gmail.com, torvalds@linux-foundation.org,
          mingo@kernel.org, rafael.j.wysocki@intel.com,
          peterz@infradead.org, tglx@linutronix.de,
          linux-kernel@vger.kernel.org, hpa@zytor.com, fweisbec@gmail.com
In-Reply-To: <20190411033448.20842-2-npiggin@gmail.com>
References: <20190411033448.20842-2-npiggin@gmail.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/core: Allow the remote scheduler tick to be
 started on CPU0
Git-Commit-ID: 77a5352ba977d2554643e3797e10823d0d03dcf7
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

Commit-ID:  77a5352ba977d2554643e3797e10823d0d03dcf7
Gitweb:     https://git.kernel.org/tip/77a5352ba977d2554643e3797e10823d0d03dcf7
Author:     Nicholas Piggin <npiggin@gmail.com>
AuthorDate: Thu, 11 Apr 2019 13:34:44 +1000
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Fri, 3 May 2019 12:53:14 +0200

sched/core: Allow the remote scheduler tick to be started on CPU0

This has no effect yet because CPU0 will always be a housekeeping CPU
until a later change.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Frederic Weisbecker <fweisbec@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rafael J . Wysocki <rafael.j.wysocki@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linuxppc-dev@lists.ozlabs.org
Link: https://lkml.kernel.org/r/20190411033448.20842-2-npiggin@gmail.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index de8ab411826c..cef22c5499a8 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5866,7 +5866,7 @@ void __init sched_init_smp(void)
 
 static int __init migration_init(void)
 {
-	sched_rq_cpu_starting(smp_processor_id());
+	sched_cpu_starting(smp_processor_id());
 	return 0;
 }
 early_initcall(migration_init);
