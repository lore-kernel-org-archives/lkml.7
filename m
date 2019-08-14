Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C65CAC433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 00:07:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C51E206C2
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 00:07:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbfHNAG0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 20:06:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:59556 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726102AbfHNAGZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 20:06:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B7E88ACC6;
        Wed, 14 Aug 2019 00:06:23 +0000 (UTC)
Date:   Tue, 13 Aug 2019 17:06:16 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Michel Lespinasse <walken@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] augmented rbtree: add new
 RB_DECLARE_CALLBACKS_MAX macro
Message-ID: <20190814000616.sd4mxwsewhqqz6ra@linux-r8p5>
References: <20190702075819.34787-1-walken@google.com>
 <20190702075819.34787-3-walken@google.com>
 <20190702160913.ptg4p2jyb6ih43hb@linux-r8p5>
 <CANN689HVDJXKEwB80yPAVwvRwnV4HfiucQVAho=dupKM_iKozw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CANN689HVDJXKEwB80yPAVwvRwnV4HfiucQVAho=dupKM_iKozw@mail.gmail.com>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 02 Jul 2019, Michel Lespinasse wrote:
>Ehhh, I have my own list of gripes about interval tree (I'm
>responsible for some of these too):

Sorry just getting back to this.

>
>- The majority of interval tree users (though either the
>interval_tree.h or the interval_tree_generic.h API) do not store any
>overlapping intervals, and as such they really don't have any reason
>to use an augmented rbtree in the first place. This seems to be true
>for at least drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c,
>drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c, drivers/gpu/drm/drm_mm.c,
>drivers/gpu/drm/radeon/radeon_mn.c,
>drivers/infiniband/hw/usnic/usnic_uiom_interval_tree.c, and probably
>(not 100% sure) also drivers/infiniband/hw/hfi1/mmu_rb.c and
>drivers/vhost/vhost.c. I think the reason they do that is because they
>like to have the auto-generated insert / remove / iter functions
>rather than writing their own as they would have to do through the
>base rbtree API. Not necessarily a huge problem but it is annoying
>when working on inteval tree to consider that the data structure is
>not optimal for most of its users.

I think the patch I sent earlier will add to your unhappiness.

>
>- The intervals are represented as [start, last], where most
>everything else in the kernel uses [start, end[ (with last == end -
>1). The reason it was done that way was for stabbing queries - I
>thought these would be nicer to represent as a [stab, stab] interval
>rather than [stab, stab+1[. But, things didn't turn out that way
>because of huge pages, and we end up with stabbing queries in the
>[stab, stab + page_size - 1] format, at which point we could just as
>easily go for [stab, stab + page_size[ representation. Having looked
>into it, my understanding is that *all* current users of the interval
>tree API would be better served if the intervals were represented as
>[start, end[ like everywhere else in the kernel.
>
>- interval_tree_generic.h refers to interval_tree.h as being the
>generic one. I think this is quite confusing. To me
>interval_tree_generic is the generic implementation (it works with any
>scalar ITTYPE), and interval_tree.h is the specialized version (it
>works with unsigned long keys only). Fun fact, interval_tree.[c,h] was
>initially only meant as sample / test code - I thought everyone would
>use the generic version. Not a big deal, it's probably better for
>everyone to use the specialized version when applicable (unless they
>don't really need overlapping intervals in the first place, but that's
>a separate gripe).
>
>- I don't like that interval tree API forces rb_leftmost caching on
>its users. I'm not sure what was the use case that motivated it, but I
>don' think it's a relevant optimization for most users - I can only
>see a benefit if people are frequently calling the iter_first function
>with a search interval that is to the left of the leftmost entry, and
>that doesn't seem to be relevant to the general case (in the general
>case, maintaining leftmost has a O(1) cost and its benefit is only
>expected to show up in 1/N cases, ....)

Right, so this was done originally for optimizing range locking which
needed to do the iter_first a lot. fwiw pat_rbtree tree could also use
it before insertion. While I did not examine the other users of interval_tree,
I considered it overall worthwhile having; it comes at pretty
much no cost and the extra footprint has not been a problem so far for
users.

>
>Going back to your specific pat_rbtree.c comment, I think using
>interval trees could still work. The issue with end is the typical one
>([start, last] vs [start, end[) which can be worked around by
>adjusting the end by 1 (still hate having to do that though). The
>issue with insertion order may possibly not matter, as
>memtype_rb_check_conflict verifies that any overlapping ranges will
>have the same configured memory type. So maybe the order doesn't
>matter in the end ??? Not 100% sure about that one.

I've sent out a patch.

Thanks,
Davidlohr


