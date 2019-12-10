Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90E49C2D0BE
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 04:20:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6721B207FF
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 04:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575951607;
	bh=60TWbVZvPpG1ib1VuHaIdYqZtF8KM+53W/JTp64RGLI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Y8S0sWM4/JfRT+ABlA86/h4TmYnbGROplszOgfPeUO419xfZNfnhqRtK7TR6Onx6I
	 gmcHQ7DmVIt48YkNAlsRE1PuMa3d3k8vzRoUI4FX2JqY4oPobRzoLpzSixzh7G2TVl
	 6M4ig5i+74mX2loyQAOFiIrwx8DCziLDb4fgpWIE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727024AbfLJEUG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 23:20:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:46948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726619AbfLJEUF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 23:20:05 -0500
Received: from paulmck-ThinkPad-P72.home (199-192-87-166.static.wiline.com [199.192.87.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 76E692077B;
        Tue, 10 Dec 2019 04:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575951605;
        bh=60TWbVZvPpG1ib1VuHaIdYqZtF8KM+53W/JTp64RGLI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PXrnYCv1HH3lcSUNG/sKrh34xyfDQ74uPRXHSNmR0H+9g7phceZkADABqLVLYFc6n
         mp+4Y9lP2yZHcJOU0Wm9msr5qkCWKGIc6swPquuCm5T9+gp50ut4dm8kIazEmDSy8O
         rjYLS2snLmqa/sbaENA37loj17C30TFBKfeU7LKY=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 1/9] rculist: Describe variadic macro argument in a Sphinx-compatible way
Date:   Mon,  9 Dec 2019 20:19:54 -0800
Message-Id: <20191210042002.3490-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20191210041938.GA3367@paulmck-ThinkPad-P72>
References: <20191210041938.GA3367@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jonathan Neuschäfer <j.neuschaefer@gmx.net>

Without this patch, Sphinx shows "variable arguments" as the description
of the cond argument, rather than the intended description, and prints
the following warnings:

./include/linux/rculist.h:374: warning: Excess function parameter 'cond' description in 'list_for_each_entry_rcu'
./include/linux/rculist.h:651: warning: Excess function parameter 'cond' description in 'hlist_for_each_entry_rcu'

Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
Acked-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/rculist.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/rculist.h b/include/linux/rculist.h
index 4158b72..61c6728a 100644
--- a/include/linux/rculist.h
+++ b/include/linux/rculist.h
@@ -361,7 +361,7 @@ static inline void list_splice_tail_init_rcu(struct list_head *list,
  * @pos:	the type * to use as a loop cursor.
  * @head:	the head for your list.
  * @member:	the name of the list_head within the struct.
- * @cond:	optional lockdep expression if called from non-RCU protection.
+ * @cond...:	optional lockdep expression if called from non-RCU protection.
  *
  * This list-traversal primitive may safely run concurrently with
  * the _rcu list-mutation primitives such as list_add_rcu()
@@ -636,7 +636,7 @@ static inline void hlist_add_behind_rcu(struct hlist_node *n,
  * @pos:	the type * to use as a loop cursor.
  * @head:	the head for your list.
  * @member:	the name of the hlist_node within the struct.
- * @cond:	optional lockdep expression if called from non-RCU protection.
+ * @cond...:	optional lockdep expression if called from non-RCU protection.
  *
  * This list-traversal primitive may safely run concurrently with
  * the _rcu list-mutation primitives such as hlist_add_head_rcu()
-- 
2.9.5

