Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D9B7C06510
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 16:09:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40CC6206A3
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 16:09:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbfGBQJW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 12:09:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:40922 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725996AbfGBQJV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 12:09:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8B031AE5C;
        Tue,  2 Jul 2019 16:09:20 +0000 (UTC)
Date:   Tue, 2 Jul 2019 09:09:13 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Michel Lespinasse <walken@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] augmented rbtree: add new
 RB_DECLARE_CALLBACKS_MAX macro
Message-ID: <20190702160913.ptg4p2jyb6ih43hb@linux-r8p5>
References: <20190702075819.34787-1-walken@google.com>
 <20190702075819.34787-3-walken@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190702075819.34787-3-walken@google.com>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 02 Jul 2019, Michel Lespinasse wrote:

>diff --git a/arch/x86/mm/pat_rbtree.c b/arch/x86/mm/pat_rbtree.c
>index fa16036fa592..2afad8e869fc 100644
>--- a/arch/x86/mm/pat_rbtree.c
>+++ b/arch/x86/mm/pat_rbtree.c
>@@ -54,23 +54,10 @@ static u64 get_subtree_max_end(struct rb_node *node)
> 	return ret;
> }
>
>-static u64 compute_subtree_max_end(struct memtype *data)
>-{
>-	u64 max_end = data->end, child_max_end;
>-
>-	child_max_end = get_subtree_max_end(data->rb.rb_right);
>-	if (child_max_end > max_end)
>-		max_end = child_max_end;
>-
>-	child_max_end = get_subtree_max_end(data->rb.rb_left);
>-	if (child_max_end > max_end)
>-		max_end = child_max_end;
>-
>-	return max_end;
>-}
>+#define NODE_END(node) ((node)->end)
>
>-RB_DECLARE_CALLBACKS(static, memtype_rb_augment_cb, struct memtype, rb,
>-		     u64, subtree_max_end, compute_subtree_max_end)
>+RB_DECLARE_CALLBACKS_MAX(struct memtype, rb, u64, subtree_max_end, NODE_END,
>+			 static, memtype_rb_augment_cb)

(unrelated to this patch)

So fyi I've recently been looking at having the whole pat_rbtree use the (generic)
interval tree api, which would mean less code and more optimized. Of course,
unfortunately they aren't 100% compatible. Fundamentally the concept of overlaps
are different (pat_rbtree is does not consider overlap when 'node->start == end' -
same for the test to the right of the node). Thus for example interval_tree_iter_first()
won't necessarily return the same node as memtype_rb_lowest_match(). Similarly,
inserting a node with key collisions will have differences wrt what path to take;
equal 'start' in pat will go to the left, interval_tree to the right. All this,
I suspect, is inherited from how pat used to work with rbtree+list.

So generic ones cannot be used and if we just use INTERVAL_TREE_DEFINE template for
pat and add the ad-hoc code does not make sense wrt cleanup, nor do we get the
optimizations. We could of course, add them manually (by using cached rbtrees, for
example) and forget about interval_tree altogether; just seems a shame.

Thanks,
Davidlohr
