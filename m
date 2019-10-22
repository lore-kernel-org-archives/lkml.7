Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D365CA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 19:12:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38332218AE
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 19:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571771553;
	bh=c352t9a37W5iZ6QoYbS1JdFxmkNCiGi48vP+/8QJvW4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=D0hmmFFqZsWWx3hlNX3LRP3pIOhLhZzzGMukqQrUsjM6UV1m2lFJfpKz5r3wQHlB9
	 yePs9KNgZ5HtgvkA2PSoHsWlnJu5D4eBhnLeBG1D/9CpAA7WpXV7m8eXzr2q0UwsvF
	 eUyVf8zEpHGhzUtI8NmqUbRjrQZJkb+Ikd3M04qA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733004AbfJVTMc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 15:12:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:43538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732903AbfJVTM3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 15:12:29 -0400
Received: from localhost.localdomain (rrcs-50-75-166-42.nys.biz.rr.com [50.75.166.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E1A4521D81;
        Tue, 22 Oct 2019 19:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571771548;
        bh=c352t9a37W5iZ6QoYbS1JdFxmkNCiGi48vP+/8QJvW4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ietizg4mUds30r5O4A4J+Bp5G/ZLJ5XbMtd5So8K55enMBKbNOcUbvqKS9Wm7AqeZ
         nq1d2JW4rk9RdrqiB7AoaNsv4o26kshE0NqC+GcPcOfsp6Hg2oq042xGZJ7Od+fJcT
         qkSF05XSStsT+H5BHnc4OcVoBm5L3+4eCM7DhPKA=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        linux-afs@lists.infradead.org
Subject: [PATCH tip/core/rcu 05/10] fs/afs: Replace rcu_swap_protected() with rcu_replace()
Date:   Tue, 22 Oct 2019 12:12:10 -0700
Message-Id: <20191022191215.25781-5-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20191022191136.GA25627@paulmck-ThinkPad-P72>
References: <20191022191136.GA25627@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit replaces the use of rcu_swap_protected() with the more
intuitively appealing rcu_replace() as a step towards removing
rcu_swap_protected().

Link: https://lore.kernel.org/lkml/CAHk-=wiAsJLw1egFEE=Z7-GGtM6wcvtyytXZA1+BHqta4gg6Hw@mail.gmail.com/
Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
[ paulmck: From rcu_replace() to rcu_replace_pointer() per Ingo Molnar. ]
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Acked-by: David Howells <dhowells@redhat.com>
Cc: <linux-afs@lists.infradead.org>
Cc: <linux-kernel@vger.kernel.org>
---
 fs/afs/vl_list.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/afs/vl_list.c b/fs/afs/vl_list.c
index 21eb0c0..8fea54e 100644
--- a/fs/afs/vl_list.c
+++ b/fs/afs/vl_list.c
@@ -279,8 +279,8 @@ struct afs_vlserver_list *afs_extract_vlserver_list(struct afs_cell *cell,
 			struct afs_addr_list *old = addrs;
 
 			write_lock(&server->lock);
-			rcu_swap_protected(server->addresses, old,
-					   lockdep_is_held(&server->lock));
+			old = rcu_replace_pointer(server->addresses, old,
+						  lockdep_is_held(&server->lock));
 			write_unlock(&server->lock);
 			afs_put_addrlist(old);
 		}
-- 
2.9.5

