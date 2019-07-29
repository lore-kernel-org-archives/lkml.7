Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 941B3C76186
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:26:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63CBF216C8
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564428362;
	bh=gAAXZVb4sqR+WEAU9rVh6bY0RZbiYUM1aZ4gQ/M1Fgk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ovLs5mLlXGFzi0sHsYZMPuzPhBO069XPeB4iznp5tyemKCPcH7CspIytCBi/Ry1AJ
	 qOnvZsFT/Sytsv19N9az2ZKO6e8URJeqC8vZ6glFtAaXoTGw2W/1e9V9C+b66pNorn
	 AIXH6fX60BLpqFTLXLl2n+ilr+Yu8vahpfxeaLU8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388323AbfG2T0B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 15:26:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:38366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388304AbfG2TZ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 15:25:59 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2520521655;
        Mon, 29 Jul 2019 19:25:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564428358;
        bh=gAAXZVb4sqR+WEAU9rVh6bY0RZbiYUM1aZ4gQ/M1Fgk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hKXnhj4ohATaAtXGqhq0KcB3nIHOmYDskINnAbQ/zD0DWhzPwNxTxEQSqGLMlJ2KR
         6bEZ/shrvvHd7MHUZ3yr1N2bbaaugtSw+J8zbfhCaoxRH25phWLW8WQLVx2wnk6Cvd
         dOzTVeF/GxM/mmZSRzLQWKuRIMS/CsGby9mhULbo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Waiman Long <longman@redhat.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 049/293] rcu: Force inlining of rcu_read_lock()
Date:   Mon, 29 Jul 2019 21:19:00 +0200
Message-Id: <20190729190827.141825109@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190729190820.321094988@linuxfoundation.org>
References: <20190729190820.321094988@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 6da9f775175e516fc7229ceaa9b54f8f56aa7924 ]

When debugging options are turned on, the rcu_read_lock() function
might not be inlined. This results in lockdep's print_lock() function
printing "rcu_read_lock+0x0/0x70" instead of rcu_read_lock()'s caller.
For example:

[   10.579995] =============================
[   10.584033] WARNING: suspicious RCU usage
[   10.588074] 4.18.0.memcg_v2+ #1 Not tainted
[   10.593162] -----------------------------
[   10.597203] include/linux/rcupdate.h:281 Illegal context switch in
RCU read-side critical section!
[   10.606220]
[   10.606220] other info that might help us debug this:
[   10.606220]
[   10.614280]
[   10.614280] rcu_scheduler_active = 2, debug_locks = 1
[   10.620853] 3 locks held by systemd/1:
[   10.624632]  #0: (____ptrval____) (&type->i_mutex_dir_key#5){.+.+}, at: lookup_slow+0x42/0x70
[   10.633232]  #1: (____ptrval____) (rcu_read_lock){....}, at: rcu_read_lock+0x0/0x70
[   10.640954]  #2: (____ptrval____) (rcu_read_lock){....}, at: rcu_read_lock+0x0/0x70

These "rcu_read_lock+0x0/0x70" strings are not providing any useful
information.  This commit therefore forces inlining of the rcu_read_lock()
function so that rcu_read_lock()'s caller is instead shown.

Signed-off-by: Waiman Long <longman@redhat.com>
Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/rcupdate.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index f960c85cd9ec..8d570190e9b4 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -622,7 +622,7 @@ static inline void rcu_preempt_sleep_check(void) { }
  * read-side critical sections may be preempted and they may also block, but
  * only when acquiring spinlocks that are subject to priority inheritance.
  */
-static inline void rcu_read_lock(void)
+static __always_inline void rcu_read_lock(void)
 {
 	__rcu_read_lock();
 	__acquire(RCU);
-- 
2.20.1



