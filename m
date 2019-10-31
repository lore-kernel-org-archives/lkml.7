Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B133CA9EC3
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 11:58:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEFBD21734
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 11:58:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727533AbfJaL6N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 07:58:13 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55291 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726945AbfJaLzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 07:55:07 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iQ92d-0002x9-Nu; Thu, 31 Oct 2019 12:55:03 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id D5DF91C0070;
        Thu, 31 Oct 2019 12:54:59 +0100 (CET)
Date:   Thu, 31 Oct 2019 11:54:59 -0000
From:   "tip-bot2 for Ethan Hansen" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Remove unused function hlist_bl_del_init_rcu()
Cc:     Ethan Hansen <1ethanhansen@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <157252289950.29376.4828245605504588132.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     8e6af017f4b1da9cdd2b55ce83853df8e167b4d3
Gitweb:        https://git.kernel.org/tip/8e6af017f4b1da9cdd2b55ce83853df8e167b4d3
Author:        Ethan Hansen <1ethanhansen@gmail.com>
AuthorDate:    Fri, 02 Aug 2019 13:37:58 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Wed, 30 Oct 2019 08:32:07 -07:00

rcu: Remove unused function hlist_bl_del_init_rcu()

The function hlist_bl_del_init_rcu() is declared in rculist_bl.h,
but never used.  This commit therefore removes it.

Signed-off-by: Ethan Hansen <1ethanhansen@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
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
