Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D007DC04AB4
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 08:00:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98ED12087B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 08:00:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UmDK7P1c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbfEPIAk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 04:00:40 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:35191 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726363AbfEPIAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 04:00:38 -0400
Received: by mail-pl1-f196.google.com with SMTP id g5so1226061plt.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 01:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dAMmc7aoYddwHSlZW8s+pblkl2pIVX4wSW1WP4SKMaI=;
        b=UmDK7P1cGRmOnov4hbQLQb1o32YXcFED9N0iCdKcU47i1fBRaGSGQ3jI1zeV5dlaDW
         O42f5qefuY1dZRk9hmOYmPrYVasWEumHH0ZMp8p681HYJw9/q4LqbHWBV9qFxc6jvWuy
         +5RtAaY4xfPkavNC8hKDNB2qHtiOD8iO6ObGamp4ibR9yJ9nqWtjclLCo+TMVmeH+Y4a
         pjJ7hZtYPlvxcXDTCaLb3ZGlirGpAKQAKUNqH7NU+5H1jIO7UPO7jacWF935Taj751fp
         SjreD873P3ylkKTjFgY8yKhRKamhaXsAcVfGAqDGOvYO9LRdO1kgz+qref5qbUvJ8Qsm
         obLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dAMmc7aoYddwHSlZW8s+pblkl2pIVX4wSW1WP4SKMaI=;
        b=iXo3nZ8AgeeaWxReExlpJrX/k5TxE+XRrgnUozXT9XBg5F9oCEUYsGA5czcR95pfVC
         /pSi+4HgeKSYsWEptpI0JLv9vH9NnMZTHTtuqAHFrmKNvMnaXKnWiWCIQcWfZobr0fBb
         s6mTde6hLSOVw1uR6rukJX8wnE0Nj53987SMKdnefGkjSkNwNj3Kny+JxZryCJrcpLZd
         T8ObQMjRyhmtwUwBMHLWZtlb/R1kGc9ecOn26mcnOndIGBayWId9TNC6c5tjhhXccHxl
         laAU5kaFb4ktlrgYEA7yDcBlp3Mg01ljSXA74pNQn6zSV74H2mxHWSq/EO4cdR71X+Vh
         VVsw==
X-Gm-Message-State: APjAAAWnKuUs7ygEqhX/uIrhSiyIpsRaPdvXmNN/Io7cr0A5GtLXOmki
        TpMCWVcC64rWXj7Fg1Yz6hw=
X-Google-Smtp-Source: APXvYqza68R1nppujUP2wDTtVo9ZcSl5U3gii6jQgCFXnHFiuRRuvFJBxWV77d+6NFHKrTeKke3DYg==
X-Received: by 2002:a17:902:4503:: with SMTP id m3mr48107284pld.97.1557993638380;
        Thu, 16 May 2019 01:00:38 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id p7sm2051471pgb.92.2019.05.16.01.00.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 May 2019 01:00:37 -0700 (PDT)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org
Cc:     bvanassche@acm.org, ming.lei@redhat.com, frederic@kernel.org,
        tglx@linutronix.de, boqun.feng@gmail.com, paulmck@linux.ibm.com,
        linux-kernel@vger.kernel.org, Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH v2 04/17] locking/lockdep: Update direct dependency's read-write type if it exists
Date:   Thu, 16 May 2019 16:00:02 +0800
Message-Id: <20190516080015.16033-5-duyuyang@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20190516080015.16033-1-duyuyang@gmail.com>
References: <20190516080015.16033-1-duyuyang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When adding a dependency, if the dependency exists - be it direct or
indirect - the dependency's read-write type may be updated.

We can keep all different-typed dependencies, but for simplicity we just
"upgrade" lock types if possible, making them more exlusive (in the order:
recursive read -> read -> write.

For indirect dependency, we do the redundancy check only when it has no
read locks (i.e., write-lock ended dependency); this makes the redundancy
check less complicated, which matters only when CONFIG_LOCKDEP_SMALL.

Signed-off-by: Yuyang Du <duyuyang@gmail.com>
---
 kernel/locking/lockdep.c | 61 ++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 57 insertions(+), 4 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 595dc94..1f1cb21 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -1734,6 +1734,16 @@ static inline int get_lock_type2(struct lock_list *lock)
 	return lock->lock_type[1];
 }
 
+static inline void set_lock_type1(struct lock_list *lock, int read)
+{
+	lock->lock_type[0] = (u16)read;
+}
+
+static inline void set_lock_type2(struct lock_list *lock, int read)
+{
+	lock->lock_type[1] = (u16)read;
+}
+
 /*
  * Check that the dependency graph starting at <src> can lead to
  * <target> or not. Print an error and return 0 if it does.
@@ -1814,6 +1824,32 @@ static inline int get_lock_type2(struct lock_list *lock)
 	ret = check_path(hlock_class(target), &src_entry, &target_entry);
 
 	if (!ret) {
+		struct lock_list *parent;
+
+		/*
+		 * Do this indirect dependency has the same type as the
+		 * direct dependency?
+		 *
+		 * Actually, we keep the more exclusive lock type
+		 * between the indirect and direct dependencies by
+		 * "upgrading" the indirect dependency's lock type if
+		 * needed, and then consider this redundant.
+		 */
+
+		/* Target end lock type: */
+		if (target->read < get_lock_type2(target_entry))
+			set_lock_type2(target_entry, target->read)
+
+		/* Source end lock type: */
+		parent = find_next_dep_in_path(&src_entry, target_entry);
+		if (!parent) {
+			DEBUG_LOCKS_WARN_ON(1);
+			return 0;
+		}
+
+		if (src->read < get_lock_type1(parent))
+			set_lock_type1(parent, src->read)
+
 		debug_atomic_inc(nr_redundant);
 		ret = 2;
 	} else if (ret < 0)
@@ -2479,6 +2515,17 @@ static inline void inc_chains(void)
 	 */
 	list_for_each_entry(entry, &hlock_class(prev)->locks_after, entry) {
 		if (entry->class == hlock_class(next)) {
+			/*
+			 * For direct dependency, smaller type value
+			 * generally means more exlusive; we keep the
+			 * more exlusive ones, in other words, we
+			 * "upgrade" the dependency if we can.
+			 */
+			if (prev->read < get_lock_type1(entry))
+				set_lock_type1(entry, prev->read);
+			if (next->read < get_lock_type2(entry))
+				set_lock_type2(entry, next->read);
+
 			if (distance == 1)
 				entry->distance = 1;
 			return 1;
@@ -2487,11 +2534,17 @@ static inline void inc_chains(void)
 
 #ifdef CONFIG_LOCKDEP_SMALL
 	/*
-	 * Is the <prev> -> <next> link redundant?
+	 * Only when this dependency has no read lock/locks (i.e.,
+	 * write-write dependency), we do redundancy check.
 	 */
-	ret = check_redundant(prev, next);
-	if (ret != 1)
-		return ret;
+	if (!get_dep_type(prev, next)) {
+		/*
+		 * Is the <prev> -> <next> link redundant?
+		 */
+		ret = check_redundant(prev, next);
+		if (ret != 1)
+			return ret;
+	}
 #endif
 
 	if (!trace->nr_entries && !save_trace(trace))
-- 
1.8.3.1

