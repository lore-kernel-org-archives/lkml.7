Return-Path: <SRS0=HJxx=ZB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CF55C43331
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Nov 2019 20:52:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE95421848
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Nov 2019 20:52:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbfKIUwa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Nov 2019 15:52:30 -0500
Received: from gentwo.org ([3.19.106.255]:39100 "EHLO gentwo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726383AbfKIUwa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Nov 2019 15:52:30 -0500
Received: by gentwo.org (Postfix, from userid 1002)
        id 9CEE23EC14; Sat,  9 Nov 2019 20:52:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.org (Postfix) with ESMTP id 9A0DA3E886;
        Sat,  9 Nov 2019 20:52:29 +0000 (UTC)
Date:   Sat, 9 Nov 2019 20:52:29 +0000 (UTC)
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@www.lameter.com
To:     Yu Zhao <yuzhao@google.com>
cc:     Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v4 2/2] mm: avoid slub allocation while holding
 list_lock
In-Reply-To: <20191108193958.205102-2-yuzhao@google.com>
Message-ID: <alpine.DEB.2.21.1911092024560.9034@www.lameter.com>
References: <20190914000743.182739-1-yuzhao@google.com> <20191108193958.205102-1-yuzhao@google.com> <20191108193958.205102-2-yuzhao@google.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Nov 2019, Yu Zhao wrote:

> If we are already under list_lock, don't call kmalloc(). Otherwise we
> will run into deadlock because kmalloc() also tries to grab the same
> lock.

How did this happen? The kmalloc needs to be always done before the
list_lock is taken.

> Fixing the problem by using a static bitmap instead.
>
>   WARNING: possible recursive locking detected
>   --------------------------------------------
>   mount-encrypted/4921 is trying to acquire lock:
>   (&(&n->list_lock)->rlock){-.-.}, at: ___slab_alloc+0x104/0x437
>
>   but task is already holding lock:
>   (&(&n->list_lock)->rlock){-.-.}, at: __kmem_cache_shutdown+0x81/0x3cb
>
>   other info that might help us debug this:
>    Possible unsafe locking scenario:
>
>          CPU0
>          ----
>     lock(&(&n->list_lock)->rlock);
>     lock(&(&n->list_lock)->rlock);
>
>    *** DEADLOCK ***


Ahh. list_slab_objects() in shutdown?

There is a much easier fix for this:



[FIX] slub: Remove kmalloc under list_lock from list_slab_objects()

list_slab_objects() is called when a slab is destroyed and there are objects still left
to list the objects in the syslog. This is a pretty rare event.

And there it seems we take the list_lock and call kmalloc while holding that lock.

Perform the allocation in free_partial() before the list_lock is taken.

Fixes: bbd7d57bfe852d9788bae5fb171c7edb4021d8ac ("slub: Potential stack overflow")
Signed-off-by: Christoph Lameter <cl@linux.com>

Index: linux/mm/slub.c
===================================================================
--- linux.orig/mm/slub.c	2019-10-15 13:54:57.032655296 +0000
+++ linux/mm/slub.c	2019-11-09 20:43:52.374187381 +0000
@@ -3690,14 +3690,11 @@ error:
 }

 static void list_slab_objects(struct kmem_cache *s, struct page *page,
-							const char *text)
+					const char *text, unsigned long *map)
 {
 #ifdef CONFIG_SLUB_DEBUG
 	void *addr = page_address(page);
 	void *p;
-	unsigned long *map = bitmap_zalloc(page->objects, GFP_ATOMIC);
-	if (!map)
-		return;
 	slab_err(s, page, text, s->name);
 	slab_lock(page);

@@ -3723,6 +3720,10 @@ static void free_partial(struct kmem_cac
 {
 	LIST_HEAD(discard);
 	struct page *page, *h;
+	unsigned long *map = bitmap_alloc(oo_objects(s->max), GFP_KERNEL);
+
+	if (!map)
+		return;

 	BUG_ON(irqs_disabled());
 	spin_lock_irq(&n->list_lock);
@@ -3732,7 +3733,8 @@ static void free_partial(struct kmem_cac
 			list_add(&page->slab_list, &discard);
 		} else {
 			list_slab_objects(s, page,
-			"Objects remaining in %s on __kmem_cache_shutdown()");
+			"Objects remaining in %s on __kmem_cache_shutdown()",
+			map);
 		}
 	}
 	spin_unlock_irq(&n->list_lock);
