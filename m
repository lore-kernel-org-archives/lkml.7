Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD627C04AB1
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 09:13:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F3B120989
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 09:13:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Be+VDtBe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728659AbfEMJNe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 05:13:34 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34212 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728640AbfEMJNb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 05:13:31 -0400
Received: by mail-pg1-f195.google.com with SMTP id c13so6465673pgt.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 02:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XavEEJR9UTWypsgwd5yo2KavnEoUPRTsn7OTRBW3tRc=;
        b=Be+VDtBeofNsjOKfO70pqCMwr+tIJ2+kG6N+gQ5gUWv3BkN5myq/O2MPNL3WiAxeBE
         RyVA3ACxXw0eL5d7KfchxTAaHwVN4lLknTvHEdIgC+vG43APGGAmmoZbhbGq1YSw7VnM
         dbw9ObK4ZmCquc/s0iv4vOhtIxrSFcR6QEbei/0TCE+Nga4GKR1X5e/t/Q0RxR7jlG5n
         /GU9QWeBbdCLPjRiGmD4bTNl/1apgn6YujccvbjNzMbai+An5Jrootx9QoWj8Fg/ZqQH
         l6HqG2DSTfa8xfewaJX+U4yyOqegqTTsEGBYB7gG97UCUrOo0ND64gRFGnQvfwAI02p6
         K3yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XavEEJR9UTWypsgwd5yo2KavnEoUPRTsn7OTRBW3tRc=;
        b=h+KsiAq/0lu5bWxYOrPBor6ZcqqVZkwn4+SHMIHlW7LAydflfLJuqxJZfCNzRJ1TgZ
         ch2DII/APhsL9jK1PsbRjpCfU98z79afzmJfnFl3HNH1ffTIyvZrc4sM+l1UTC/ggn4y
         Ny1H/RhQXlYuiLK170d11efLpOyy6uSonIjxYafL9FcprNytQLN0mxV/cmmAHHp2NQb0
         BnAUAyjC5x9zbLJEuD3NatWmaZzwio21FsFfDgUD2EdIPDVy2WJ0cjUN2X2+Lj4x9osH
         ZyL6J21InBwRh9DOYccNV//FcuOnV794B0VzLB/FxLfeSYN30Q/IDojSjPUjJeEB+zby
         aeTQ==
X-Gm-Message-State: APjAAAUet3rPjJSwP1Pym3oV2eKoMFqLVF9vG2+8jDtB0vOIGM0fZ69a
        iEwATSaqNWEe7UJtJxJT2D0=
X-Google-Smtp-Source: APXvYqwGBQyA3DVPamIEqpQGXw3qOjLI0YQEymWB8By+gZSMTb/8ghRIZUz9aLJELHIaZWJodNwBYw==
X-Received: by 2002:a63:8b4b:: with SMTP id j72mr29568964pge.318.1557738810531;
        Mon, 13 May 2019 02:13:30 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id n18sm35500837pfi.48.2019.05.13.02.13.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2019 02:13:29 -0700 (PDT)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org
Cc:     bvanassche@acm.org, ming.lei@redhat.com, frederic@kernel.org,
        tglx@linutronix.de, boqun.feng@gmail.com,
        linux-kernel@vger.kernel.org, Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH 04/17] locking/lockdep: Update direct dependency's read-write type if it exists
Date:   Mon, 13 May 2019 17:11:50 +0800
Message-Id: <20190513091203.7299-5-duyuyang@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20190513091203.7299-1-duyuyang@gmail.com>
References: <20190513091203.7299-1-duyuyang@gmail.com>
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
index 0617375..27ca55f 100644
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

