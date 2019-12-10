Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 769D5C2D0B1
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 04:07:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B9D5208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 04:07:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575950866;
	bh=AIlYt7FH70CT7CO7G2+IY2nMcziboljsxBgveRaGOfo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hl5SPtsjRYFIwOqm9JePIUTRskvczv9WdZDIKZDvbk7Zc5IWRdI+6TnTRbqw9dQw6
	 gUSkAhnSl+XBmhpaikfbd7TfZjfb8SjifVNEx4ha/cTDdyeT4y6nZ4+3k4a75dFG3H
	 bRr9eDtClpCY6JD6mBM1DM0GLZOhbGRv2u5f/Hqw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbfLJEHp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 23:07:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:43218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726619AbfLJEHo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 23:07:44 -0500
Received: from paulmck-ThinkPad-P72.home (199-192-87-166.static.wiline.com [199.192.87.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C0442071E;
        Tue, 10 Dec 2019 04:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575950864;
        bh=AIlYt7FH70CT7CO7G2+IY2nMcziboljsxBgveRaGOfo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KvSsBoCE7Nt71AlMOHPYTXFKAbGP36a2kGuo6AbualIANkjhXvugeaRMcrhVUmXkE
         IXvMzE9UnHGQlJjkaYvPs1bZhSb/mBEFip7zXkV/5wtjge2/o1ENhVFOXGyY+YM6wA
         4YJ5R2DDxx6ZyXOLguA1pa203aMH9bGwwNNG3mc8=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Shane M Seymour <shane.seymour@hpe.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: [PATCH tip/core/rcu 01/12] rcu: Remove rcu_swap_protected()
Date:   Mon,  9 Dec 2019 20:07:30 -0800
Message-Id: <20191210040741.2943-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20191210040714.GA2715@paulmck-ThinkPad-P72>
References: <20191210040714.GA2715@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

Now that the calls to rcu_swap_protected() have been replaced by
rcu_replace_pointer(), this commit removes rcu_swap_protected().

Link: https://lore.kernel.org/lkml/CAHk-=wiAsJLw1egFEE=Z7-GGtM6wcvtyytXZA1+BHqta4gg6Hw@mail.gmail.com/
Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Shane M Seymour <shane.seymour@hpe.com>
Cc: Martin K. Petersen <martin.petersen@oracle.com>
---
 include/linux/rcupdate.h | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 0b75063..fe47024 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -401,22 +401,6 @@ do {									      \
 })
 
 /**
- * rcu_swap_protected() - swap an RCU and a regular pointer
- * @rcu_ptr: RCU pointer
- * @ptr: regular pointer
- * @c: the conditions under which the dereference will take place
- *
- * Perform swap(@rcu_ptr, @ptr) where @rcu_ptr is an RCU-annotated pointer and
- * @c is the argument that is passed to the rcu_dereference_protected() call
- * used to read that pointer.
- */
-#define rcu_swap_protected(rcu_ptr, ptr, c) do {			\
-	typeof(ptr) __tmp = rcu_dereference_protected((rcu_ptr), (c));	\
-	rcu_assign_pointer((rcu_ptr), (ptr));				\
-	(ptr) = __tmp;							\
-} while (0)
-
-/**
  * rcu_access_pointer() - fetch RCU pointer with no dereferencing
  * @p: The pointer to read
  *
-- 
2.9.5

