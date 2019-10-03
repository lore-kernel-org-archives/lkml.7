Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BA37C47404
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 01:33:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0264B222C9
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 01:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570066389;
	bh=p+sP9pdBpS3cdIiTHoO76QDdUeVk+jdXrDWm8n37ulk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Rdj9lFPZSXz7XK3BtDCqbutP/MVvcOijfk1yElgZw2fO1hiKVDx2HBJu5rTryjtFl
	 TsM4vDeA8sGW+M3qhejMP7eYIgEGo4jU7MSBtBcyxsdnM8jvZC2laLpUBTO7z+A2AS
	 GEecU0DYWljr9PnehRDbhTY6xryEokO+cDkIL7vI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728039AbfJCBdI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 21:33:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:42346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725951AbfJCBdI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 21:33:08 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 32AE2222BE;
        Thu,  3 Oct 2019 01:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570066387;
        bh=p+sP9pdBpS3cdIiTHoO76QDdUeVk+jdXrDWm8n37ulk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eMkDsf4UiL1ocrjHY96+Z3VK/Ai/mHOJGDPkLk32U379Fx7gfkFw0QUKWbZ8Mv0FZ
         UE2JdidEq5OABU2U82njA3MtDpXoWWHjokVG4VwzZab3IdTsTg1+DZrxz/RREmTUPs
         E40BhTvgx7jqfZi9lrkXjHQcseFrgaLjqFB/yFeU=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        Ethan Hansen <1ethanhansen@gmail.com>,
        "Paul E . McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH tip/core/rcu 1/8] rcu: Remove unused function hlist_bl_del_init_rcu()
Date:   Wed,  2 Oct 2019 18:32:58 -0700
Message-Id: <20191003013305.12854-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20191003013243.GA12705@paulmck-ThinkPad-P72>
References: <20191003013243.GA12705@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ethan Hansen <1ethanhansen@gmail.com>

The function hlist_bl_del_init_rcu() is declared in rculist_bl.h,
but never used.  This commit therefore removes it.

Signed-off-by: Ethan Hansen <1ethanhansen@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 include/linux/rculist_bl.h | 28 ----------------------------
 1 file changed, 28 deletions(-)

diff --git a/include/linux/rculist_bl.h b/include/linux/rculist_bl.h
index 66e73ec..0b952d0 100644
--- a/include/linux/rculist_bl.h
+++ b/include/linux/rculist_bl.h
@@ -25,34 +25,6 @@ static inline struct hlist_bl_node *hlist_bl_first_rcu(struct hlist_bl_head *h)
 }
 
 /**
- * hlist_bl_del_init_rcu - deletes entry from hash list with re-initialization
- * @n: the element to delete from the hash list.
- *
- * Note: hlist_bl_unhashed() on the node returns true after this. It is
- * useful for RCU based read lockfree traversal if the writer side
- * must know if the list entry is still hashed or already unhashed.
- *
- * In particular, it means that we can not poison the forward pointers
- * that may still be used for walking the hash list and we can only
- * zero the pprev pointer so list_unhashed() will return true after
- * this.
- *
- * The caller must take whatever precautions are necessary (such as
- * holding appropriate locks) to avoid racing with another
- * list-mutation primitive, such as hlist_bl_add_head_rcu() or
- * hlist_bl_del_rcu(), running on this same list.  However, it is
- * perfectly legal to run concurrently with the _rcu list-traversal
- * primitives, such as hlist_bl_for_each_entry_rcu().
- */
-static inline void hlist_bl_del_init_rcu(struct hlist_bl_node *n)
-{
-	if (!hlist_bl_unhashed(n)) {
-		__hlist_bl_del(n);
-		n->pprev = NULL;
-	}
-}
-
-/**
  * hlist_bl_del_rcu - deletes entry from hash list without re-initialization
  * @n: the element to delete from the hash list.
  *
-- 
2.9.5

