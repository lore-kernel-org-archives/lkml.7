Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE8C9CA9EBD
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 17:36:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9518E205C9
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 17:36:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g7yYcZwB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387812AbfJYRgK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 13:36:10 -0400
Received: from mail-wr1-f73.google.com ([209.85.221.73]:49220 "EHLO
        mail-wr1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731004AbfJYRgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 13:36:10 -0400
Received: by mail-wr1-f73.google.com with SMTP id v8so1606112wrt.16
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 10:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=a54Lyz1dUJij4mN+2b8ZNnnnXES85iR6NAbg0u1zD48=;
        b=g7yYcZwBc0fOzasupQoByj4GWYn1cT2XqH83gz5vEvEpzE9l9YewiMSnH+BzoJ2K8t
         Y7DeNGbDoI86pFVJEyKW6Ahhxf6F3PuoYkwIdSOo+zyzoprrAOBkrdB+34VUWCZqYr9s
         ysphpxIIuJKxcskwE4J8Attagak2QfQUbPZ91xBegrXPOL2XNZF7N0ajIbpWOj5lXmUX
         K+s9/128KScCZeH6Qm/cpTE6iQ92cNtQ95Z0aulsKB4jKsAd+j6KW51ha/i8FfVBGjYe
         ioWC5+81/YSukSSnBLYt2h7Ut0wUMrry7+MRRo4o8gc+oZagz+hPP1qmnulDfztROM9f
         vGpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=a54Lyz1dUJij4mN+2b8ZNnnnXES85iR6NAbg0u1zD48=;
        b=PYy+Cooa8yiaHbzB285hO6ac/EVDaI2OPFm3lFBi3mOvxJB6vWatq5vM8G1ARTXp++
         H3vJIa910wcl4O0E+l1T27SyMs+8hxN41gDWEmD5C/NbTgIq2VEKMmqSZACdaEAZknd8
         t42JpP9C61UkeDLKS7EFmOj/VlWFt43AN+wIyHLpAx9zJ1LxKbFcPX9l6ZOt5KbsPgND
         xjTVVV7pbDwQqc2ctozl7DscaUS6EfcVhnHKi5l449flojTy6O/R3QSCiO2riG+Z1Eg8
         frIJ3jyDj+arULX8D9LqU3VQuokoDrpkxjDKQMVhiqww4/E4Lyi5CbAG2rwDcmaKsTDc
         4rqw==
X-Gm-Message-State: APjAAAX4cfxckeUXnuhQW5wWktcjefyc4CMILps2eUOxIdJnFM+cprrM
        PkYzoBJjVrVmLQ7W0TW+ZsrbYCLbfA==
X-Google-Smtp-Source: APXvYqxEIhmzGox0X9F3Ie78jWjPVassB3+zoPw2cPWJ0E3xpKpTtHoQpx2ldJS1HzMc9HoMp7NK0fVdKA==
X-Received: by 2002:adf:cc90:: with SMTP id p16mr3813956wrj.377.1572024967195;
 Fri, 25 Oct 2019 10:36:07 -0700 (PDT)
Date:   Fri, 25 Oct 2019 19:35:12 +0200
In-Reply-To: <20191025090113.GH4131@hirez.programming.kicks-ass.net>
Message-Id: <20191025173511.181416-1-elver@google.com>
Mime-Version: 1.0
References: <20191025090113.GH4131@hirez.programming.kicks-ass.net>
X-Mailer: git-send-email 2.24.0.rc0.303.g954a862665-goog
Subject: Re: KCSAN: data-race in __rb_rotate_set_parents / vm_area_dup
From:   Marco Elver <elver@google.com>
To:     peterz@infradead.org
Cc:     aarcange@redhat.com, akpm@linux-foundation.org,
        christian@brauner.io, cyphar@cyphar.com, elena.reshetova@intel.com,
        elver@google.com, guro@fb.com, keescook@chromium.org,
        ldv@altlinux.org, linux-kernel@vger.kernel.org,
        luto@amacapital.net, mhocko@suse.com, mingo@kernel.org,
        syzbot+c034966b0b02f94f7f34@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        viro@zeniv.linux.org.uk, wad@chromium.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 25 Oct 2019, Peter Zijlstra wrote:

> On Thu, Oct 24, 2019 at 08:59:50PM +0200, Marco Elver wrote:
> > On Thu, 24 Oct 2019 at 18:25, Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > On Thu, Oct 24, 2019 at 09:07:08AM -0700, syzbot wrote:
> > > > Hello,
> > > >
> > > > syzbot found the following crash on:
> > > >
> > > > HEAD commit:    05f22368 x86, kcsan: Enable KCSAN for x86
> > > > git tree:       https://github.com/google/ktsan.git kcsan
> > > > console output: https://syzkaller.appspot.com/x/log.txt?x=1060c47b600000
> > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=87d111955f40591f
> > > > dashboard link: https://syzkaller.appspot.com/bug?extid=c034966b0b02f94f7f34
> > > > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > > >
> > > > Unfortunately, I don't have any reproducer for this crash yet.
> > > >
> > > > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > > > Reported-by: syzbot+c034966b0b02f94f7f34@syzkaller.appspotmail.com
> > > >
> > > > ==================================================================
> > > > BUG: KCSAN: data-race in __rb_rotate_set_parents / vm_area_dup
> > > >
> > > > read to 0xffff88811eef53e8 of 200 bytes by task 7738 on cpu 0:
> > > >  vm_area_dup+0x70/0xf0 kernel/fork.c:359
> > > >  __split_vma+0x88/0x350 mm/mmap.c:2678
> > > >  __do_munmap+0xb02/0xb60 mm/mmap.c:2803
> > > >  do_munmap mm/mmap.c:2856 [inline]
> > > >  mmap_region+0x165/0xd50 mm/mmap.c:1749
> > > >  do_mmap+0x6d4/0xba0 mm/mmap.c:1577
> > > >  do_mmap_pgoff include/linux/mm.h:2353 [inline]
> > > >  vm_mmap_pgoff+0x12d/0x190 mm/util.c:496
> > > >  ksys_mmap_pgoff+0x2d8/0x420 mm/mmap.c:1629
> > > >  __do_sys_mmap arch/x86/kernel/sys_x86_64.c:100 [inline]
> > > >  __se_sys_mmap arch/x86/kernel/sys_x86_64.c:91 [inline]
> > > >  __x64_sys_mmap+0x91/0xc0 arch/x86/kernel/sys_x86_64.c:91
> > > >  do_syscall_64+0xcc/0x370 arch/x86/entry/common.c:290
> > > >  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> > > >
> > > > write to 0xffff88811eef5440 of 8 bytes by task 7737 on cpu 1:
> > > >  __rb_rotate_set_parents+0x4d/0xf0 lib/rbtree.c:79
> > > >  __rb_insert lib/rbtree.c:215 [inline]
> > > >  __rb_insert_augmented+0x109/0x370 lib/rbtree.c:459
> > > >  rb_insert_augmented include/linux/rbtree_augmented.h:50 [inline]
> > > >  rb_insert_augmented_cached include/linux/rbtree_augmented.h:60 [inline]
> > > >  vma_interval_tree_insert+0x196/0x230 mm/interval_tree.c:23
> > > >  __vma_link_file+0xd9/0x110 mm/mmap.c:634
> > > >  __vma_adjust+0x1ac/0x12a0 mm/mmap.c:842
> > > >  vma_adjust include/linux/mm.h:2276 [inline]
> > > >  __split_vma+0x208/0x350 mm/mmap.c:2707
> > > >  split_vma+0x73/0xa0 mm/mmap.c:2736
> > > >  mprotect_fixup+0x43f/0x510 mm/mprotect.c:413
> > > >  do_mprotect_pkey+0x3eb/0x660 mm/mprotect.c:553
> > > >  __do_sys_mprotect mm/mprotect.c:578 [inline]
> > > >  __se_sys_mprotect mm/mprotect.c:575 [inline]
> > > >  __x64_sys_mprotect+0x51/0x70 mm/mprotect.c:575
> > > >  do_syscall_64+0xcc/0x370 arch/x86/entry/common.c:290
> > > >  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> > >
> > > What is this thing trying to tell me? That the copy on alloc is racy,
> > > because at that point the object isn't exposed yet.
> > 
> > In vm_area_dup, *orig is being concurrently modified while being
> > copied into *new.
> 
> I'm not sure how it thinks there is concurrency here though;
> __split_vma() *should* be holding mmap_sem for writing.

I tried to independently create a case to report when the race happens
(see patch below). It does crash with my setup, during boot, with a
default config. So I'm very certain that the tool correctly reported
concurrency here.

> But yes, at least all the rb-tree and list crud should be re-initialized
> for the object after copy.

Ok thanks for the clarification.

-- Marco


diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index c4159bcc05d9..641981815f60 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -2379,7 +2379,7 @@ static int __init eventpoll_init(void)
 	 * We can have many thousands of epitems, so prevent this from
 	 * using an extra cache line on 64-bit (and smaller) CPUs
 	 */
-	BUILD_BUG_ON(sizeof(void *) <= 8 && sizeof(struct epitem) > 128);
+//	BUILD_BUG_ON(sizeof(void *) <= 8 && sizeof(struct epitem) > 128);
 
 	/* Allocates slab cache used to allocate "struct epitem" items */
 	epi_cache = kmem_cache_create("eventpoll_epi", sizeof(struct epitem),
diff --git a/include/linux/rbtree.h b/include/linux/rbtree.h
index 1fd61a9af45c..02c33439bbeb 100644
--- a/include/linux/rbtree.h
+++ b/include/linux/rbtree.h
@@ -20,11 +20,14 @@
 #include <linux/kernel.h>
 #include <linux/stddef.h>
 #include <linux/rcupdate.h>
+#include <linux/spinlock.h>
 
 struct rb_node {
 	unsigned long  __rb_parent_color;
 	struct rb_node *rb_right;
 	struct rb_node *rb_left;
+	spinlock_t debug_spinlock;
+	atomic_t race_count;
 } __attribute__((aligned(sizeof(long))));
     /* The alignment might seem pointless, but allegedly CRIS needs it */
 
@@ -71,6 +74,7 @@ static inline void rb_link_node(struct rb_node *node, struct rb_node *parent,
 {
 	node->__rb_parent_color = (unsigned long)parent;
 	node->rb_left = node->rb_right = NULL;
+	spin_lock_init(&node->debug_spinlock);
 
 	*rb_link = node;
 }
@@ -80,6 +84,7 @@ static inline void rb_link_node_rcu(struct rb_node *node, struct rb_node *parent
 {
 	node->__rb_parent_color = (unsigned long)parent;
 	node->rb_left = node->rb_right = NULL;
+	spin_lock_init(&node->debug_spinlock);
 
 	rcu_assign_pointer(*rb_link, node);
 }
diff --git a/kernel/fork.c b/kernel/fork.c
index bcdf53125210..5894bc339875 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -94,6 +94,7 @@
 #include <linux/livepatch.h>
 #include <linux/thread_info.h>
 #include <linux/stackleak.h>
+#include <linux/delay.h>
 
 #include <asm/pgtable.h>
 #include <asm/pgalloc.h>
@@ -356,6 +357,10 @@ struct vm_area_struct *vm_area_dup(struct vm_area_struct *orig)
 	struct vm_area_struct *new = kmem_cache_alloc(vm_area_cachep, GFP_KERNEL);
 
 	if (new) {
+		if (spin_is_locked(&orig->shared.rb.debug_spinlock)) {
+			atomic_inc(&orig->shared.rb.race_count);
+			pr_err("race in %s\n", __func__);
+		}
 		*new = *orig;
 		INIT_LIST_HEAD(&new->anon_vma_chain);
 	}
diff --git a/lib/rbtree.c b/lib/rbtree.c
index abc86c6a3177..89526c90d29f 100644
--- a/lib/rbtree.c
+++ b/lib/rbtree.c
@@ -11,6 +11,7 @@
 
 #include <linux/rbtree_augmented.h>
 #include <linux/export.h>
+#include <linux/delay.h>
 
 /*
  * red-black trees properties:  http://en.wikipedia.org/wiki/Rbtree
@@ -76,6 +77,15 @@ __rb_rotate_set_parents(struct rb_node *old, struct rb_node *new,
 			struct rb_root *root, int color)
 {
 	struct rb_node *parent = rb_parent(old);
+	unsigned long flags;
+	int race_count;
+
+	spin_lock_irqsave(&new->debug_spinlock, flags);
+	race_count = atomic_read(&new->race_count);
+	udelay(100);
+	BUG_ON(race_count != atomic_read(&new->race_count));
+	spin_unlock_irqrestore(&new->debug_spinlock, flags);
+
 	new->__rb_parent_color = old->__rb_parent_color;
 	rb_set_parent_color(old, new, color);
 	__rb_change_child(old, new, parent, root);
