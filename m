Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74D18C00454
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 22:35:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49A8F2173E
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 22:35:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U9H2iZuC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731266AbfLLWfz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 17:35:55 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48159 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731185AbfLLWfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 17:35:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576190149;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=EuPXKDpDvC3X6ZUxjIoFABcIaGVwFbUHhAHdmyaKBeU=;
        b=U9H2iZuCja4K8N4NQddkGiMrD1KSyOfa/W+j/iYB4qam+/dGF9bD6sqrdk1/n5gsjGptdH
        GQoeSQptr2wF9sa+r131FKQO1scdaFzYy6YhB6oUBLl6K1V2eMwxjDNQK5yAKLpP99XiDy
        1baS+P0Fy/l5AY2Y8mV/P5ajEBks2vY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-129-XQa478YNPo6it-3T2JPhLA-1; Thu, 12 Dec 2019 17:35:45 -0500
X-MC-Unique: XQa478YNPo6it-3T2JPhLA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 52C278017DF;
        Thu, 12 Dec 2019 22:35:44 +0000 (UTC)
Received: from llong.com (dhcp-17-59.bos.redhat.com [10.18.17.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9897260BF3;
        Thu, 12 Dec 2019 22:35:43 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH 3/5] locking/lockdep: Track number of zapped lock chains
Date:   Thu, 12 Dec 2019 17:35:23 -0500
Message-Id: <20191212223525.1652-4-longman@redhat.com>
In-Reply-To: <20191212223525.1652-1-longman@redhat.com>
References: <20191212223525.1652-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new counter nr_zapped_lock_chains to track the number lock chains
that have been removed.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/locking/lockdep.c           | 2 ++
 kernel/locking/lockdep_internals.h | 1 +
 kernel/locking/lockdep_proc.c      | 2 ++
 3 files changed, 5 insertions(+)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index d03503b348f1..b543bcc5ff50 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -2625,6 +2625,7 @@ check_prevs_add(struct task_struct *curr, struct held_lock *next)
 struct lock_chain lock_chains[MAX_LOCKDEP_CHAINS];
 static DECLARE_BITMAP(lock_chains_in_use, MAX_LOCKDEP_CHAINS);
 static u16 chain_hlocks[MAX_LOCKDEP_CHAIN_HLOCKS];
+unsigned long nr_zapped_lock_chains;
 unsigned int nr_chain_hlocks;
 unsigned int nr_leaked_chain_hlocks;
 
@@ -4797,6 +4798,7 @@ static void remove_class_from_lock_chain(struct pending_free *pf,
 	 */
 	hlist_del_rcu(&chain->entry);
 	__set_bit(chain - lock_chains, pf->lock_chains_being_freed);
+	nr_zapped_lock_chains++;
 #endif
 }
 
diff --git a/kernel/locking/lockdep_internals.h b/kernel/locking/lockdep_internals.h
index b6ec9595ae88..4c23ab7d27c2 100644
--- a/kernel/locking/lockdep_internals.h
+++ b/kernel/locking/lockdep_internals.h
@@ -125,6 +125,7 @@ struct lock_class *lock_chain_get_class(struct lock_chain *chain, int i);
 
 extern unsigned long nr_lock_classes;
 extern unsigned long nr_zapped_classes;
+extern unsigned long nr_zapped_lock_chains;
 extern unsigned long nr_list_entries;
 long lockdep_next_lockchain(long i);
 unsigned long lock_chain_count(void);
diff --git a/kernel/locking/lockdep_proc.c b/kernel/locking/lockdep_proc.c
index aab524530115..65a1b96238ef 100644
--- a/kernel/locking/lockdep_proc.c
+++ b/kernel/locking/lockdep_proc.c
@@ -345,6 +345,8 @@ static int lockdep_stats_show(struct seq_file *m, void *v)
 	seq_puts(m, "\n");
 	seq_printf(m, " zapped classes:                %11lu\n",
 			nr_zapped_classes);
+	seq_printf(m, " zapped lock chains:            %11lu\n",
+			nr_zapped_lock_chains);
 	seq_printf(m, " leaked chain hlocks:           %11u\n",
 			nr_leaked_chain_hlocks);
 	return 0;
-- 
2.18.1

