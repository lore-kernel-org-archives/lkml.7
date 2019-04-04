Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0E41C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:23:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E5AC20693
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:23:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388191AbfDDJW7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:22:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:35664 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387934AbfDDJPo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:15:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4AA13ADC4;
        Thu,  4 Apr 2019 09:15:43 +0000 (UTC)
From:   Vlastimil Babka <vbabka@suse.cz>
To:     linux-mm@kvack.org
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        linux-kernel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>
Subject: [RFC 0/2] add static key for slub_debug
Date:   Thu,  4 Apr 2019 11:15:29 +0200
Message-Id: <20190404091531.9815-1-vbabka@suse.cz>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I looked a bit at SLUB debugging capabilities and first thing I noticed is
there's no static key guarding the runtime enablement as is common for similar
debugging functionalities, so here's a RFC to add it. Can be further improved
if there's interest.

It's true that in the alloc fast path the debugging check overhead is AFAICS
amortized by the per-cpu cache, i.e. when the allocation is from there, no
debugging functionality is performed. IMHO that's kinda a weakness, especially
for SLAB_STORE_USER, so I might also look at doing something about it, and then
the static key might be more critical for overhead reduction.

In the freeing fast path I quickly checked the stats and it seems that in
do_slab_free(), the "if (likely(page == c->page))" is not as likely as it
declares, as in the majority of cases, freeing doesn't happen on the object
that belongs to the page currently cached. So the advantage of a static key in
slow path __slab_free() should be more useful immediately.

Vlastimil Babka (2):
  mm, slub: introduce static key for slub_debug
  mm, slub: add missing kmem_cache_debug() checks

 mm/slub.c | 31 +++++++++++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

-- 
2.21.0

