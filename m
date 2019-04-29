Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E0A2C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 18:42:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F08A215EA
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 18:42:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="PCrqZWr8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729174AbfD2Smh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 14:42:37 -0400
Received: from terminus.zytor.com ([198.137.202.136]:60477 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729118AbfD2Smf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 14:42:35 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3TIf53W1028632
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 29 Apr 2019 11:41:05 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x3TIf53W1028632
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1556563267;
        bh=1Q7r99KBxFTq17xBMrVhzbCQTu0dKoguuwzOklQxXFs=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=PCrqZWr8YlyUVbeMwEv9rrYzQMUDlt+5q8eZdHXx0+qLwqpCSAjgI56L1A+M1wZXQ
         GJuYp9ndHIDCI7HWTLeGvejFLEwcBXnc2l4rJ4iJXv5jJD78med80lV5jXUl4NKWgZ
         hhFxsROSPuprEYNIuUTzh1++oD5iO3AkaeLsh5teGTBOTQKCI5pEzM9WeKKifxJH1G
         fyB/0hQoIj0B2x5qP4FQJjWgIWFXZgjV29y07XWROsgSRrTkAOAMm/A0rRnFVMeMeo
         MPhpPszP4uT8O+uf+roqqn/hE91ROO+6FrN5IwQ5pwEMSoJBQAh/0pJBc3ExMVFQMm
         Skllu1e/brxzg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3TIf5N31028628;
        Mon, 29 Apr 2019 11:41:05 -0700
Date:   Mon, 29 Apr 2019 11:41:05 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-be9c52ed84eb0949fed3d4140e35ea70eecb02a2@git.kernel.org>
Cc:     akpm@linux-foundation.org, agk@redhat.com, jthumshirn@suse.de,
        airlied@linux.ie, mbenes@suse.cz, cl@linux.com, dvyukov@google.com,
        penberg@kernel.org, robin.murphy@arm.com, tglx@linutronix.de,
        adobriyan@gmail.com, m.szyprowski@samsung.com, rostedt@goodmis.org,
        akinobu.mita@gmail.com, mingo@kernel.org, daniel@ffwll.ch,
        rppt@linux.vnet.ibm.com, luto@kernel.org, glider@google.com,
        dsterba@suse.com, clm@fb.com, josef@toxicpanda.com,
        joonas.lahtinen@linux.intel.com, maarten.lankhorst@linux.intel.com,
        tom.zanussi@linux.intel.com, snitzer@redhat.com,
        linux-kernel@vger.kernel.org, hpa@zytor.com, jpoimboe@redhat.com,
        aryabinin@virtuozzo.com, catalin.marinas@arm.com,
        jani.nikula@linux.intel.com, rientjes@google.com,
        rodrigo.vivi@intel.com, hch@lst.de
Reply-To: dsterba@suse.com, clm@fb.com, josef@toxicpanda.com,
          maarten.lankhorst@linux.intel.com, snitzer@redhat.com,
          tom.zanussi@linux.intel.com, joonas.lahtinen@linux.intel.com,
          linux-kernel@vger.kernel.org, hpa@zytor.com, jpoimboe@redhat.com,
          catalin.marinas@arm.com, aryabinin@virtuozzo.com,
          rientjes@google.com, jani.nikula@linux.intel.com,
          rodrigo.vivi@intel.com, hch@lst.de, akpm@linux-foundation.org,
          agk@redhat.com, jthumshirn@suse.de, cl@linux.com, mbenes@suse.cz,
          airlied@linux.ie, penberg@kernel.org, dvyukov@google.com,
          adobriyan@gmail.com, robin.murphy@arm.com, tglx@linutronix.de,
          akinobu.mita@gmail.com, rostedt@goodmis.org,
          m.szyprowski@samsung.com, mingo@kernel.org, daniel@ffwll.ch,
          rppt@linux.vnet.ibm.com, luto@kernel.org, glider@google.com
In-Reply-To: <20190425094802.533968922@linutronix.de>
References: <20190425094802.533968922@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:core/stacktrace] dm persistent data: Simplify stack trace
 handling
Git-Commit-ID: be9c52ed84eb0949fed3d4140e35ea70eecb02a2
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  be9c52ed84eb0949fed3d4140e35ea70eecb02a2
Gitweb:     https://git.kernel.org/tip/be9c52ed84eb0949fed3d4140e35ea70eecb02a2
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Thu, 25 Apr 2019 11:45:08 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Mon, 29 Apr 2019 12:37:52 +0200

dm persistent data: Simplify stack trace handling

Replace the indirection through struct stack_trace with an invocation of
the storage array based interface. This results in less storage space and
indirection.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: dm-devel@redhat.com
Cc: Mike Snitzer <snitzer@redhat.com>
Cc: Alasdair Kergon <agk@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Alexander Potapenko <glider@google.com>
Cc: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Christoph Lameter <cl@linux.com>
Cc: Pekka Enberg <penberg@kernel.org>
Cc: linux-mm@kvack.org
Cc: David Rientjes <rientjes@google.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: kasan-dev@googlegroups.com
Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc: Akinobu Mita <akinobu.mita@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: iommu@lists.linux-foundation.org
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
Cc: David Sterba <dsterba@suse.com>
Cc: Chris Mason <clm@fb.com>
Cc: Josef Bacik <josef@toxicpanda.com>
Cc: linux-btrfs@vger.kernel.org
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: intel-gfx@lists.freedesktop.org
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: dri-devel@lists.freedesktop.org
Cc: David Airlie <airlied@linux.ie>
Cc: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Tom Zanussi <tom.zanussi@linux.intel.com>
Cc: Miroslav Benes <mbenes@suse.cz>
Cc: linux-arch@vger.kernel.org
Link: https://lkml.kernel.org/r/20190425094802.533968922@linutronix.de

---
 drivers/md/persistent-data/dm-block-manager.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/md/persistent-data/dm-block-manager.c b/drivers/md/persistent-data/dm-block-manager.c
index 3972232b8037..749ec268d957 100644
--- a/drivers/md/persistent-data/dm-block-manager.c
+++ b/drivers/md/persistent-data/dm-block-manager.c
@@ -35,7 +35,10 @@
 #define MAX_HOLDERS 4
 #define MAX_STACK 10
 
-typedef unsigned long stack_entries[MAX_STACK];
+struct stack_store {
+	unsigned int	nr_entries;
+	unsigned long	entries[MAX_STACK];
+};
 
 struct block_lock {
 	spinlock_t lock;
@@ -44,8 +47,7 @@ struct block_lock {
 	struct task_struct *holders[MAX_HOLDERS];
 
 #ifdef CONFIG_DM_DEBUG_BLOCK_STACK_TRACING
-	struct stack_trace traces[MAX_HOLDERS];
-	stack_entries entries[MAX_HOLDERS];
+	struct stack_store traces[MAX_HOLDERS];
 #endif
 };
 
@@ -73,7 +75,7 @@ static void __add_holder(struct block_lock *lock, struct task_struct *task)
 {
 	unsigned h = __find_holder(lock, NULL);
 #ifdef CONFIG_DM_DEBUG_BLOCK_STACK_TRACING
-	struct stack_trace *t;
+	struct stack_store *t;
 #endif
 
 	get_task_struct(task);
@@ -81,11 +83,7 @@ static void __add_holder(struct block_lock *lock, struct task_struct *task)
 
 #ifdef CONFIG_DM_DEBUG_BLOCK_STACK_TRACING
 	t = lock->traces + h;
-	t->nr_entries = 0;
-	t->max_entries = MAX_STACK;
-	t->entries = lock->entries[h];
-	t->skip = 2;
-	save_stack_trace(t);
+	t->nr_entries = stack_trace_save(t->entries, MAX_STACK, 2);
 #endif
 }
 
@@ -106,7 +104,8 @@ static int __check_holder(struct block_lock *lock)
 			DMERR("recursive lock detected in metadata");
 #ifdef CONFIG_DM_DEBUG_BLOCK_STACK_TRACING
 			DMERR("previously held here:");
-			print_stack_trace(lock->traces + i, 4);
+			stack_trace_print(lock->traces[i].entries,
+					  lock->traces[i].nr_entries, 4);
 
 			DMERR("subsequent acquisition attempted here:");
 			dump_stack();
