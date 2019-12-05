Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E4A7C43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 17:45:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F44024249
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 17:45:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730232AbfLERpk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 12:45:40 -0500
Received: from mx2.suse.de ([195.135.220.15]:37878 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729396AbfLERpk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 12:45:40 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 334FEB0E6;
        Thu,  5 Dec 2019 17:45:37 +0000 (UTC)
Date:   Thu, 5 Dec 2019 09:41:08 -0800
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Schmid, Carsten" <Carsten_Schmid@mentor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        walken@google.com
Subject: Re: Crash in fair scheduler
Message-ID: <20191205174108.5qhbdeh25vhhc44u@linux-p48b>
References: <1575364273836.74450@mentor.com>
 <20191203103046.GJ2827@hirez.programming.kicks-ass.net>
 <656260cf50684c11a3122aca88dde0cb@SVR-IES-MBX-03.mgc.mentorg.com>
 <20191203140153.GP2844@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20191203140153.GP2844@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 03 Dec 2019, Peter Zijlstra wrote:

>On Tue, Dec 03, 2019 at 10:51:46AM +0000, Schmid, Carsten wrote:
>
>> > > struct sched_entity *__pick_first_entity(struct cfs_rq *cfs_rq)
>> > > {
>> > >	struct rb_node *left = rb_first_cached(&cfs_rq->tasks_timeline);
>> > >
>> > >	if (!left)
>> > >		return NULL; <<<<<<<<<< the case
>> > >
>> > >	return rb_entry(left, struct sched_entity, run_node);
>> > > }
>> >
>> > This the problem, for some reason the rbtree code got that rb_leftmost
>> > thing wrecked.
>> >
>> Any known issue on rbtree code regarding this?
>
>I don't recall ever having seen this before. :/ Adding Davidlohr and
>Michel who've poked at the rbtree code 'recently'.

Yeah I had never seen this either, and would expect the world to fall
appart if leftmost is buggy (much less a one time occurance), but the
following certainly raises a red flag:

    &cfs_rq->tasks_timeline->rb_leftmost
  tasks_timeline = {
    rb_root = {
      rb_node = 0xffff99a9502e0d10
    },
    rb_leftmost = 0x0
  },

>
>> > > Is this a corner case nobody thought of or do we have cfs_rq data that is
>> > unexpected in it's content?
>> >
>> > No, the rbtree is corrupt. Your tree has a single node (which matches
>> > with nr_running), but for some reason it thinks rb_leftmost is NULL.
>> > This is wrong, if the tree is non-empty, it must have a leftmost
>> > element.
>> Is there a chance to find the left-most element in the core dump?
>
>If there is only one entry in the tree, then that must also be the
>leftmost entry. See your own later question :-)
>
>> Maybe i can dig deeper to find the root c ause then.
>> Does any of the structs/data in this context point to some memory
>> where i can continue to search?
>
>There are only two places where rb_leftmost are updated,
>rb_insert_color_cached() and rb_erase_cached() (the scheduler does not
>use rb_replace_nod_cached).
>
>We can 'forget' to set leftmost on insertion if @leftmost is somehow
>false, and we can eroneously clear leftmost on erase if rb_next()
>malfunctions.
>
>No clues on which of those two cases happened.

For a bug in insertion I'm certainly not seeing it: we only call
insert into tasks_timeline in __enqueue_entity()... this is the standard
way of using the api, and cannot see how leftmost would become false
unless we take at least one path to the right while going down the tree.

For the erase case, this is more involved than insertion (rb_next()),
but this has not changed in years.

Fwiw, there have been three flavors of the leftmost pointer caching:

The first is the one the scheduler used by itself.

The second is when we moved the logic into the rbtree cached api.
bfb068892d3 (sched/fair: replace cfs_rq->rb_leftmost)

The third was the recent simplifications and cleanups from Michel,
which took out the caching checks into rbtree.h, instead of it being
passed down to the internal functions that actually do the insert/delete.
9f973cb3808 (lib/rbtree: avoid generating code twice for the cached versions)

Specifically looking at 4.14.86, it is using the bfb068892d3 changes.

Note how all three use the same logic to replace the rb_leftmost pointer.

>
>> Where should rb_leftmost point to if only one node is in the tree?
>> To the node itself?
>
>Exatly.
>
>
>I suppose one approach is to add code to both __enqueue_entity() and
>__dequeue_entity() that compares ->rb_leftmost to the result of
>rb_first(). That'd incur some overhead but it'd double check the logic.

We could benefit from improved debugging in rbtrees, not only the cached
flavor. Perhaps we can start with the following -- this would at least
let us know if the case where the tree is non-empty and leftmost is nil
was hit, whether in the scheduler or another user...

Thanks,
Davidlohr

diff --git a/include/linux/rbtree.h b/include/linux/rbtree.h
index 1fd61a9af45c..b4b4df3ad0fc 100644
--- a/include/linux/rbtree.h
+++ b/include/linux/rbtree.h
@@ -130,7 +130,28 @@ struct rb_root_cached {
 #define RB_ROOT_CACHED (struct rb_root_cached) { {NULL, }, NULL }

 /* Same as rb_first(), but O(1) */
-#define rb_first_cached(root) (root)->rb_leftmost
+#define __rb_first_cached(root) (root)->rb_leftmost
+
+#ifndef CONFIG_RBTREE_DEBUG
+# define rb_first_cached(root) __rb_first_cached(root)
+# define rbtree_cached_debug(root) do { } while(0)
+
+#else
+static inline struct rb_node *rb_first_cached(struct rb_root_cached *root)
+{
+	struct rb_node *leftmost = __rb_first_cached(root);
+
+	WARN_ON(leftmost != rb_first(&root->rb_root));
+	return leftmost;
+}
+
+#define rbtree_cached_debug(root)					\
+do {									\
+	WARN_ON(rb_first(&(root)->rb_root) != __rb_first_cached((root)));	\
+	WARN_ON(!RB_EMPTY_ROOT(&(root)->rb_root) && !__rb_first_cached((root))); \
+	WARN_ON(RB_EMPTY_ROOT(&(root)->rb_root) && __rb_first_cached((root))); \
+} while (0)
+#endif /* CONFIG_RBTREE_DEBUG */

 static inline void rb_insert_color_cached(struct rb_node *node,
					  struct rb_root_cached *root,
@@ -139,6 +160,8 @@ static inline void rb_insert_color_cached(struct rb_node *node,
	if (leftmost)
		root->rb_leftmost = node;
	rb_insert_color(node, &root->rb_root);
+
+	rbtree_cached_debug(root);
 }

 static inline void rb_erase_cached(struct rb_node *node,
@@ -147,6 +170,8 @@ static inline void rb_erase_cached(struct rb_node *node,
	if (root->rb_leftmost == node)
		root->rb_leftmost = rb_next(node);
	rb_erase(node, &root->rb_root);
+
+	rbtree_cached_debug(root);
 }

 static inline void rb_replace_node_cached(struct rb_node *victim,
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 2f6fb96405af..62ab9f978bc6 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1727,6 +1727,16 @@ config BACKTRACE_SELF_TEST

	  Say N if you are unsure.

+config RBTREE_DEBUG
+	bool "Red-Black tree sanity tests"
+	depends on DEBUG_KERNEL
+	help
+	  This option enables runtime sanity checks on all variants
+	  of the rbtree library. Doing so can cause significant overhead,
+	  so only enable it in non-production environments.
+
+	  Say N if you are unsure.
+
 config RBTREE_TEST
	tristate "Red-Black tree test"
	depends on DEBUG_KERNEL
