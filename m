Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1CCEC5B57D
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 02:15:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6CCF21873
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 02:15:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iiyk7YEy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727375AbfGCCPL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 22:15:11 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:38384 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbfGCCPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 22:15:11 -0400
Received: by mail-yb1-f194.google.com with SMTP id j199so413076ybg.5
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 19:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z4kMOk/YYzNxvAMqof3qlRcj1ufp2J+QyDPgodF1yYw=;
        b=iiyk7YEyFrfAkR7pTRXiVD380NzL8vxQaZ5+hcIAoDw8iJj34N1vSqKt3RjK7FLWK8
         sAr5CPS96YlWyP4DXsI+bThnor8HI1cGdNCE7pqsLVNRUwGFPRYlU+oUgkeA+xLLaOsI
         /j5mjzgdAAm9CP2keT5PwNmCW0T8wLsJJfI9xkjsHIL2JkM0Y2fuLQ7Y4Z/njqMRsClD
         xSatZ0GZukQYYbdL3LJdwWQ4hqgm41WmnVlbCQmBs8x7CCCZfH7HadMOT/o8wgBzh6bR
         o7IehN1cuVpQEJOQoXYwQDulFpOtqzsz6u+NDEPDNUpj7Pb8Wquk9+klhVAdKul9kcOm
         ZGQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z4kMOk/YYzNxvAMqof3qlRcj1ufp2J+QyDPgodF1yYw=;
        b=cmr6NJwT4pgpXXr1kI5P5hZkvFOvwHyHn3GtDaHE6y8AGD+wNzn/iE41t2kLiT3HNr
         8ejHKcwMScaTLa/z2qM/Ih0Nos1fWPVNsI5MLUjyLin82xTBpfbGoS2hFvTL3LIcP2hN
         rvyM+cnvBqYyMKEXruGOflhiE31aEBHlUTEao5ENl6KpVBt5fBTgqSB31MqqF6iSzvs/
         /I6j8NS7Jha10dsZ8NUdIe6fxiMCLY+2Y37ayVYKTN28HvhXomRXzCqVexVkHXSh5U5n
         9HH8+9brZrjdugnytnJZmNo6jXC346sk9508FTeNNvNtmAbvDiXGHphoi3o36RUxyXgR
         5aSA==
X-Gm-Message-State: APjAAAWiukWdHKx9zQ7kWDhKlZaHvs8Mbbmy/Q1V1/DwlJHdfN3GzTIz
        mbr5/QNhWEaLAFXaDj5jbWNAwlpRhgnQDjbe5o1NFA==
X-Google-Smtp-Source: APXvYqx7+iYUlqDRuTHGsvqA9MgRxUZb/kkMYyWX2diA7ofyI42/WUrm/i42jjWqEXZ17jaHNf0hU48mcQ9DI9HFo5Y=
X-Received: by 2002:a25:8109:: with SMTP id o9mr19519413ybk.132.1562120109299;
 Tue, 02 Jul 2019 19:15:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190702075819.34787-1-walken@google.com> <20190702075819.34787-3-walken@google.com>
 <20190702160913.ptg4p2jyb6ih43hb@linux-r8p5>
In-Reply-To: <20190702160913.ptg4p2jyb6ih43hb@linux-r8p5>
From:   Michel Lespinasse <walken@google.com>
Date:   Tue, 2 Jul 2019 19:14:55 -0700
Message-ID: <CANN689HVDJXKEwB80yPAVwvRwnV4HfiucQVAho=dupKM_iKozw@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] augmented rbtree: add new RB_DECLARE_CALLBACKS_MAX macro
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 2, 2019 at 9:09 AM Davidlohr Bueso <dave@stgolabs.net> wrote:
>
> On Tue, 02 Jul 2019, Michel Lespinasse wrote:
>
> >diff --git a/arch/x86/mm/pat_rbtree.c b/arch/x86/mm/pat_rbtree.c
> >index fa16036fa592..2afad8e869fc 100644
> >--- a/arch/x86/mm/pat_rbtree.c
> >+++ b/arch/x86/mm/pat_rbtree.c
> >@@ -54,23 +54,10 @@ static u64 get_subtree_max_end(struct rb_node *node)
> >       return ret;
> > }
> >
> >-static u64 compute_subtree_max_end(struct memtype *data)
> >-{
> >-      u64 max_end = data->end, child_max_end;
> >-
> >-      child_max_end = get_subtree_max_end(data->rb.rb_right);
> >-      if (child_max_end > max_end)
> >-              max_end = child_max_end;
> >-
> >-      child_max_end = get_subtree_max_end(data->rb.rb_left);
> >-      if (child_max_end > max_end)
> >-              max_end = child_max_end;
> >-
> >-      return max_end;
> >-}
> >+#define NODE_END(node) ((node)->end)
> >
> >-RB_DECLARE_CALLBACKS(static, memtype_rb_augment_cb, struct memtype, rb,
> >-                   u64, subtree_max_end, compute_subtree_max_end)
> >+RB_DECLARE_CALLBACKS_MAX(struct memtype, rb, u64, subtree_max_end, NODE_END,
> >+                       static, memtype_rb_augment_cb)
>
> (unrelated to this patch)
>
> So fyi I've recently been looking at having the whole pat_rbtree use the (generic)
> interval tree api, which would mean less code and more optimized. Of course,
> unfortunately they aren't 100% compatible. Fundamentally the concept of overlaps
> are different (pat_rbtree is does not consider overlap when 'node->start == end' -
> same for the test to the right of the node). Thus for example interval_tree_iter_first()
> won't necessarily return the same node as memtype_rb_lowest_match(). Similarly,
> inserting a node with key collisions will have differences wrt what path to take;
> equal 'start' in pat will go to the left, interval_tree to the right. All this,
> I suspect, is inherited from how pat used to work with rbtree+list.
>
> So generic ones cannot be used and if we just use INTERVAL_TREE_DEFINE template for
> pat and add the ad-hoc code does not make sense wrt cleanup, nor do we get the
> optimizations. We could of course, add them manually (by using cached rbtrees, for
> example) and forget about interval_tree altogether; just seems a shame.

Ehhh, I have my own list of gripes about interval tree (I'm
responsible for some of these too):

- The majority of interval tree users (though either the
interval_tree.h or the interval_tree_generic.h API) do not store any
overlapping intervals, and as such they really don't have any reason
to use an augmented rbtree in the first place. This seems to be true
for at least drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c,
drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c, drivers/gpu/drm/drm_mm.c,
drivers/gpu/drm/radeon/radeon_mn.c,
drivers/infiniband/hw/usnic/usnic_uiom_interval_tree.c, and probably
(not 100% sure) also drivers/infiniband/hw/hfi1/mmu_rb.c and
drivers/vhost/vhost.c. I think the reason they do that is because they
like to have the auto-generated insert / remove / iter functions
rather than writing their own as they would have to do through the
base rbtree API. Not necessarily a huge problem but it is annoying
when working on inteval tree to consider that the data structure is
not optimal for most of its users.

- The intervals are represented as [start, last], where most
everything else in the kernel uses [start, end[ (with last == end -
1). The reason it was done that way was for stabbing queries - I
thought these would be nicer to represent as a [stab, stab] interval
rather than [stab, stab+1[. But, things didn't turn out that way
because of huge pages, and we end up with stabbing queries in the
[stab, stab + page_size - 1] format, at which point we could just as
easily go for [stab, stab + page_size[ representation. Having looked
into it, my understanding is that *all* current users of the interval
tree API would be better served if the intervals were represented as
[start, end[ like everywhere else in the kernel.

- interval_tree_generic.h refers to interval_tree.h as being the
generic one. I think this is quite confusing. To me
interval_tree_generic is the generic implementation (it works with any
scalar ITTYPE), and interval_tree.h is the specialized version (it
works with unsigned long keys only). Fun fact, interval_tree.[c,h] was
initially only meant as sample / test code - I thought everyone would
use the generic version. Not a big deal, it's probably better for
everyone to use the specialized version when applicable (unless they
don't really need overlapping intervals in the first place, but that's
a separate gripe).

- I don't like that interval tree API forces rb_leftmost caching on
its users. I'm not sure what was the use case that motivated it, but I
don' think it's a relevant optimization for most users - I can only
see a benefit if people are frequently calling the iter_first function
with a search interval that is to the left of the leftmost entry, and
that doesn't seem to be relevant to the general case (in the general
case, maintaining leftmost has a O(1) cost and its benefit is only
expected to show up in 1/N cases, ....)

Going back to your specific pat_rbtree.c comment, I think using
interval trees could still work. The issue with end is the typical one
([start, last] vs [start, end[) which can be worked around by
adjusting the end by 1 (still hate having to do that though). The
issue with insertion order may possibly not matter, as
memtype_rb_check_conflict verifies that any overlapping ranges will
have the same configured memory type. So maybe the order doesn't
matter in the end ??? Not 100% sure about that one.

Do you have any comments on the above gripes and do you think they
would be worth addressing ?

-- 
Michel "Walken" Lespinasse
A program is never fully debugged until the last user dies.
