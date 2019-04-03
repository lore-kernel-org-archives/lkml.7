Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF45CC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 08:42:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AAF320830
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 08:42:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729026AbfDCIm5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 04:42:57 -0400
Received: from terminus.zytor.com ([198.137.202.136]:52375 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725857AbfDCIm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 04:42:57 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x338gj8M1775769
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 3 Apr 2019 01:42:45 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x338giwN1775766;
        Wed, 3 Apr 2019 01:42:44 -0700
Date:   Wed, 3 Apr 2019 01:42:44 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Valdis Kletnieks <tipbot@zytor.com>
Message-ID: <tip-d18bf4229b1772e91c0c36772737c01cf9726720@git.kernel.org>
Cc:     hpa@zytor.com, linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@kernel.org, tglx@linutronix.de,
        torvalds@linux-foundation.org, valdis.kletnieks@vt.edu
Reply-To: tglx@linutronix.de, valdis.kletnieks@vt.edu,
          torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
          hpa@zytor.com, mingo@kernel.org, peterz@infradead.org
In-Reply-To: <28974.1552377997@turing-police>
References: <28974.1552377997@turing-police>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf/core: Make perf_swevent_init_cpu() static
Git-Commit-ID: d18bf4229b1772e91c0c36772737c01cf9726720
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

Commit-ID:  d18bf4229b1772e91c0c36772737c01cf9726720
Gitweb:     https://git.kernel.org/tip/d18bf4229b1772e91c0c36772737c01cf9726720
Author:     Valdis Kletnieks <valdis.kletnieks@vt.edu>
AuthorDate: Tue, 12 Mar 2019 04:06:37 -0400
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 3 Apr 2019 09:52:34 +0200

perf/core: Make perf_swevent_init_cpu() static

'make W=1' causes GCC to complain:

  kernel/events/core.c:11877:6: warning: no previous prototype for 'perf_swevent_init_cpu' [-Wmissing-prototypes]

It's not referenced anywhere else, make it static.

Signed-off-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/28974.1552377997@turing-police
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/events/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 72d06e302e99..dfc4bab0b02b 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -11878,7 +11878,7 @@ static void __init perf_event_init_all_cpus(void)
 	}
 }
 
-void perf_swevent_init_cpu(unsigned int cpu)
+static void perf_swevent_init_cpu(unsigned int cpu)
 {
 	struct swevent_htable *swhash = &per_cpu(swevent_htable, cpu);
 
