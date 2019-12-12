Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82390C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 22:35:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D76D21556
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 22:35:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i0rBpsmI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731174AbfLLWfs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 17:35:48 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:35067 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730784AbfLLWfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 17:35:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576190147;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=fkogw9fCK3fQnXbyNstM260Fvpl0EOyfpQuQ+DAojAQ=;
        b=i0rBpsmI4hql7Ytn1FvTJVneFOcmOk5S4c3JgPxYU4OAYaD7SoQNtuSVwU1bRzm6j/PCh6
        5jtgmJ/7lmywl2HoznNY8v/TVWZcKBCS5x0T9UD9+N4F4u8sfNCiNHN3VQ5GCS1FQVFMC3
        N0/di3qZZOO6VYyRGuz2nm6lfa/du9o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-147-sZNZe5xfOdys4Q5XufQdcw-1; Thu, 12 Dec 2019 17:35:43 -0500
X-MC-Unique: sZNZe5xfOdys4Q5XufQdcw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9FA9E477;
        Thu, 12 Dec 2019 22:35:42 +0000 (UTC)
Received: from llong.com (dhcp-17-59.bos.redhat.com [10.18.17.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EA68660C05;
        Thu, 12 Dec 2019 22:35:41 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH 1/5] locking/lockdep: Track number of zapped classes
Date:   Thu, 12 Dec 2019 17:35:21 -0500
Message-Id: <20191212223525.1652-2-longman@redhat.com>
In-Reply-To: <20191212223525.1652-1-longman@redhat.com>
References: <20191212223525.1652-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The whole point of the lockdep dynamic key patch is to allow unused
locks to be removed from the lockdep data buffers so that existing
buffer space can be reused. However, there is no way to find out how
many unused locks are zapped and so we don't know if the zapping process
is working properly.

Add a new nr_zapped_classes variable to track that and show it in
/proc/lockdep_stats if it is non-zero.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/locking/lockdep.c           | 2 ++
 kernel/locking/lockdep_internals.h | 1 +
 kernel/locking/lockdep_proc.c      | 9 +++++++++
 3 files changed, 12 insertions(+)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 32282e7112d3..c8d0374101b0 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -147,6 +147,7 @@ static DECLARE_BITMAP(list_entries_in_use, MAX_LOCKDEP_ENTRIES);
 #define KEYHASH_SIZE		(1UL << KEYHASH_BITS)
 static struct hlist_head lock_keys_hash[KEYHASH_SIZE];
 unsigned long nr_lock_classes;
+unsigned long nr_zapped_classes;
 #ifndef CONFIG_DEBUG_LOCKDEP
 static
 #endif
@@ -4875,6 +4876,7 @@ static void zap_class(struct pending_free *pf, struct lock_class *class)
 	}
 
 	remove_class_from_lock_chains(pf, class);
+	nr_zapped_classes++;
 }
 
 static void reinit_class(struct lock_class *class)
diff --git a/kernel/locking/lockdep_internals.h b/kernel/locking/lockdep_internals.h
index 18d85aebbb57..a31d16fd3c43 100644
--- a/kernel/locking/lockdep_internals.h
+++ b/kernel/locking/lockdep_internals.h
@@ -124,6 +124,7 @@ extern const char *__get_key_name(const struct lockdep_subclass_key *key,
 struct lock_class *lock_chain_get_class(struct lock_chain *chain, int i);
 
 extern unsigned long nr_lock_classes;
+extern unsigned long nr_zapped_classes;
 extern unsigned long nr_list_entries;
 long lockdep_next_lockchain(long i);
 unsigned long lock_chain_count(void);
diff --git a/kernel/locking/lockdep_proc.c b/kernel/locking/lockdep_proc.c
index 9bb6d2497b04..82579fd7469f 100644
--- a/kernel/locking/lockdep_proc.c
+++ b/kernel/locking/lockdep_proc.c
@@ -336,6 +336,15 @@ static int lockdep_stats_show(struct seq_file *m, void *v)
 	seq_printf(m, " debug_locks:                   %11u\n",
 			debug_locks);
 
+	/*
+	 * Zappped classes and lockdep data buffers reuse statistics.
+	 */
+	if (!nr_zapped_classes)
+		return 0;
+
+	seq_puts(m, "\n");
+	seq_printf(m, " zapped classes:                %11lu\n",
+			nr_zapped_classes);
 	return 0;
 }
 
-- 
2.18.1

