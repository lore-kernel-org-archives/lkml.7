Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E1B2C4360C
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 01:47:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 599A2222C0
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 01:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570067268;
	bh=rA2qHeyAIoRjAOearyWgCJaWvKzSYQLrgoLXHU1rwEU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NJeVHGTwzoBAcK/QNt7RchKQ7Nh78/eCZFDPtPCXKLEvvF6rembTbodAflpt7UHLf
	 36Mh2d/pg22GXdIsNyMO0Q/kwMCtOWOBaKgx0j5TBf1q9Pez/60ZkoykYeeRXv1oEC
	 Jkm7UmWdqBkSa/5Qm8XPZn9Ce8xB9dfHi2l8b+oc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728139AbfJCBrr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 21:47:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:47792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727523AbfJCBrd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 21:47:33 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4E94522466;
        Thu,  3 Oct 2019 01:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570067253;
        bh=rA2qHeyAIoRjAOearyWgCJaWvKzSYQLrgoLXHU1rwEU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DTt4+70cjd4sdc//+Z90FDHYWfStAzSBnFeKNF0mwnT57iMIoikVeH9s0DCzMEzjP
         u4g3vkXpzCnidbzC4PbYVcchZfHTKo5tx54PK4dwCN8+MEgYbMUfIj41yE9z3EsDGa
         qdNNn/VlU9Q4Ardgcz1t29xnXI6LZPEH53+p3ZQ4=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 9/9] rcu: Suppress levelspread uninitialized messages
Date:   Wed,  2 Oct 2019 18:47:28 -0700
Message-Id: <20191003014728.13496-9-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20191003014710.GA13323@paulmck-ThinkPad-P72>
References: <20191003014710.GA13323@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

New tools bring new warnings, and with v5.3 comes:

kernel/rcu/srcutree.c: warning: 'levelspread[<U aa0>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34

This commit suppresses this warning by initializing the full array
to INT_MIN, which will result in failures should any out-of-bounds
references appear.

Reported-by: Michael Ellerman <mpe@ellerman.id.au>
Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcu.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index aeec70f..ab504fb 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -299,6 +299,8 @@ static inline void rcu_init_levelspread(int *levelspread, const int *levelcnt)
 {
 	int i;
 
+	for (i = 0; i < RCU_NUM_LVLS; i++)
+		levelspread[i] = INT_MIN;
 	if (rcu_fanout_exact) {
 		levelspread[rcu_num_lvls - 1] = rcu_fanout_leaf;
 		for (i = rcu_num_lvls - 2; i >= 0; i--)
-- 
2.9.5

