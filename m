Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A64FEC2D0BE
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 03:42:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F1942465A
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 03:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575949351;
	bh=PHgTb/RVqf6ABHSGW+fZhTKijJ/W01npBRaDZhWCjIY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zg7PU7isiejz/tnRzOObkZBqbnHdh8/4xXDXFPH9y2GqVClUgZ3g0zl+WmS75ysuH
	 tX2Ion9nN+zqwNeMihdwzI71UJxIEPTYkORK7Hve464KXQUM6VP6toURZ8keQ/FkKg
	 9sa2mCBW4uavaVtVp5+FomBDy4rL6SOZFbuoHWKY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727384AbfLJDma (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 22:42:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:60854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727063AbfLJDm0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 22:42:26 -0500
Received: from paulmck-ThinkPad-P72.home (199-192-87-166.static.wiline.com [199.192.87.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3987A214D8;
        Tue, 10 Dec 2019 03:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575949345;
        bh=PHgTb/RVqf6ABHSGW+fZhTKijJ/W01npBRaDZhWCjIY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=13qQ+ydDBDxSJ9hdsKPHXcjlHGEdHewQxzZ2ja/D7/+YUMKJVXkGzST9gu1VhAyRu
         3U4Buea3V/bptzfZ0hPrRF9o4NAer9UffDz+bfu8cPiaHuv3cVSZrm0Be1tBpgMnie
         2ce1HcJK87vcAym3vl1yDYX4SYCDz3a7fLkXa5BU=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 08/12] rcutorture: Move to dynamic initialization of rcu_fwds
Date:   Mon,  9 Dec 2019 19:42:13 -0800
Message-Id: <20191210034217.405-8-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20191210034119.GA32711@paulmck-ThinkPad-P72>
References: <20191210034119.GA32711@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

In order to add multiple call_rcu() forward-progress kthreads, it will
be necessary to dynamically allocate and initialize.  This commit
therefore moves the initialization from compile time to instead
immediately precede thread-creation time.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index cc88ce9..6f540fe 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1686,11 +1686,7 @@ struct rcu_fwd {
 	unsigned long rcu_launder_gp_seq_start;
 };
 
-struct rcu_fwd rcu_fwds = {
-	.rcu_fwd_lock = __SPIN_LOCK_UNLOCKED(rcu_fwds.rcu_fwd_lock),
-	.rcu_fwd_cb_tail = &rcu_fwds.rcu_fwd_cb_head,
-};
-
+struct rcu_fwd rcu_fwds;
 bool rcu_fwd_emergency_stop;
 
 static void rcu_torture_fwd_cb_hist(struct rcu_fwd *rfp)
@@ -2026,6 +2022,8 @@ static int __init rcu_torture_fwd_prog_init(void)
 		WARN_ON(1); /* Make sure rcutorture notices conflict. */
 		return 0;
 	}
+	spin_lock_init(&rcu_fwds.rcu_fwd_lock);
+	rcu_fwds.rcu_fwd_cb_tail = &rcu_fwds.rcu_fwd_cb_head;
 	if (fwd_progress_holdoff <= 0)
 		fwd_progress_holdoff = 1;
 	if (fwd_progress_div <= 0)
-- 
2.9.5

