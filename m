Return-Path: <SRS0=o7UO=TL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6014C04AB1
	for <linux-kernel@archiver.kernel.org>; Sat, 11 May 2019 13:18:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63CC02184C
	for <linux-kernel@archiver.kernel.org>; Sat, 11 May 2019 13:18:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728603AbfEKNSy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 May 2019 09:18:54 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:35474 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726319AbfEKNSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 May 2019 09:18:54 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1hPRtp-0003S1-S0; Sat, 11 May 2019 13:18:49 +0000
From:   Colin King <colin.king@canonical.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] sched: remove redundant assignment to variable utime
Date:   Sat, 11 May 2019 14:18:49 +0100
Message-Id: <20190511131849.4513-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The variable utime is being assigned a value however this is never
read and later it is being reassigned to a new value. The assignment
is redundant and hence can be removed.

Addresses-Coverity: ("Unused Value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 kernel/sched/cputime.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index ba4a143bdcf3..ad647711ffb8 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -616,10 +616,8 @@ void cputime_adjust(struct task_cputime *curr, struct prev_cputime *prev,
 	 * Once a task gets some ticks, the monotonicy code at 'update:'
 	 * will ensure things converge to the observed ratio.
 	 */
-	if (stime == 0) {
-		utime = rtime;
+	if (stime == 0)
 		goto update;
-	}
 
 	if (utime == 0) {
 		stime = rtime;
-- 
2.20.1

