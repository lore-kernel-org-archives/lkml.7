Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE2DFC48BD4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 08:24:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84518215EA
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 08:24:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="gJWM3Dnm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730155AbfFYIY2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 04:24:28 -0400
Received: from terminus.zytor.com ([198.137.202.136]:49379 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726702AbfFYIY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 04:24:27 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5P8OGvc3529573
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 25 Jun 2019 01:24:17 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5P8OGvc3529573
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561451057;
        bh=7Hd2w97hwTtHuSlyNX6Z8LZNLBlxfFfzTOr2rVUFCZw=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=gJWM3DnmpjREuN7P5Vap/PI5L80fXmvFVU6+I0iOvjmwAbHg2cx7p/lumulpCK0Hg
         6avMAnuA9L+2jGddSqQflmsBfd36i9ReOti58ddD6+4tcIZcaAKRypLIjvhwPNWmD9
         ZmWXK2Wop09xbogQcq2TyrGzGHPo2PUqJ/fu0RyMoq0SIIucwhqhvdTF+xMIlppdlm
         x4xPrTZdIZoZdA6coSh4QpcwQ1uOnSJBt9la9iCTmBwJanMHVq1MQIrYW3CNEPCoBO
         AzOgn9D+kcMrS7b0uH5ZRB1Gf+pVBme7iKtVVaI+m8071NNjR7E5O2U704FEI6chZD
         IxR4hoe8Iu1iA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5P8OGSR3529570;
        Tue, 25 Jun 2019 01:24:16 -0700
Date:   Tue, 25 Jun 2019 01:24:16 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Pavel Begunkov <tipbot@zytor.com>
Message-ID: <tip-016190a4b5824df2d5bb97951a04dd3629973671@git.kernel.org>
Cc:     torvalds@linux-foundation.org, peterz@infradead.org,
        tglx@linutronix.de, hpa@zytor.com, linux-kernel@vger.kernel.org,
        mingo@kernel.org, asml.silence@gmail.com
Reply-To: mingo@kernel.org, asml.silence@gmail.com,
          linux-kernel@vger.kernel.org, peterz@infradead.org,
          tglx@linutronix.de, hpa@zytor.com, torvalds@linux-foundation.org
In-Reply-To: <43ffea6ee2152b90dedf962eac851609e4197218.1560256112.git.asml.silence@gmail.com>
References: <43ffea6ee2152b90dedf962eac851609e4197218.1560256112.git.asml.silence@gmail.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/wait: Deduplicate code with do-while
Git-Commit-ID: 016190a4b5824df2d5bb97951a04dd3629973671
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

Commit-ID:  016190a4b5824df2d5bb97951a04dd3629973671
Gitweb:     https://git.kernel.org/tip/016190a4b5824df2d5bb97951a04dd3629973671
Author:     Pavel Begunkov <asml.silence@gmail.com>
AuthorDate: Tue, 11 Jun 2019 15:29:07 +0300
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 24 Jun 2019 19:23:40 +0200

sched/wait: Deduplicate code with do-while

Statements in the loop's body and before it are identical.
Use do-while to not repeat it.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/43ffea6ee2152b90dedf962eac851609e4197218.1560256112.git.asml.silence@gmail.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/wait.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/wait.c b/kernel/sched/wait.c
index fa0f9adfb752..c1e566a114ca 100644
--- a/kernel/sched/wait.c
+++ b/kernel/sched/wait.c
@@ -118,16 +118,12 @@ static void __wake_up_common_lock(struct wait_queue_head *wq_head, unsigned int
 	bookmark.func = NULL;
 	INIT_LIST_HEAD(&bookmark.entry);
 
-	spin_lock_irqsave(&wq_head->lock, flags);
-	nr_exclusive = __wake_up_common(wq_head, mode, nr_exclusive, wake_flags, key, &bookmark);
-	spin_unlock_irqrestore(&wq_head->lock, flags);
-
-	while (bookmark.flags & WQ_FLAG_BOOKMARK) {
+	do {
 		spin_lock_irqsave(&wq_head->lock, flags);
 		nr_exclusive = __wake_up_common(wq_head, mode, nr_exclusive,
 						wake_flags, key, &bookmark);
 		spin_unlock_irqrestore(&wq_head->lock, flags);
-	}
+	} while (bookmark.flags & WQ_FLAG_BOOKMARK);
 }
 
 /**
