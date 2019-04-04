Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B501C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 15:57:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC7652082E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 15:57:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="SUh6lLJr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728683AbfDDP5Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 11:57:25 -0400
Received: from a9-112.smtp-out.amazonses.com ([54.240.9.112]:52628 "EHLO
        a9-112.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726888AbfDDP5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 11:57:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1554393444;
        h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type:Feedback-ID;
        bh=RuMz4Toeop1wxCt6X2zIK+G7Ftq7sJ4nnRup7oWLd6w=;
        b=SUh6lLJrm4vec3E2SFmgWkGVRSs+fQeW9viK/c0l5DTGNw1mokz/ZXG+cWUx+GcS
        VdamHeX5Ew672CyFv5BEEO1VcQ/dKjT3lLcGTd4srAa+lw8gXVVMT4UuSZyF3sdOz+5
        fjuOhF88OcO3A9Tz0MOJWTyiC6l/+IqwI7TKccj4=
Date:   Thu, 4 Apr 2019 15:57:24 +0000
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To:     Vlastimil Babka <vbabka@suse.cz>
cc:     linux-mm@kvack.org, Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC 0/2] add static key for slub_debug
In-Reply-To: <20190404091531.9815-1-vbabka@suse.cz>
Message-ID: <01000169e911ae41-0abde43e-18e8-442b-b289-e796c461f0b1-000000@email.amazonses.com>
References: <20190404091531.9815-1-vbabka@suse.cz>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-SES-Outgoing: 2019.04.04-54.240.9.112
Feedback-ID: 1.us-east-1.fQZZZ0Xtj2+TD7V5apTT/NrT6QKuPgzCT/IC7XYgDKI=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Apr 2019, Vlastimil Babka wrote:

> I looked a bit at SLUB debugging capabilities and first thing I noticed is
> there's no static key guarding the runtime enablement as is common for similar
> debugging functionalities, so here's a RFC to add it. Can be further improved
> if there's interest.

Well the runtime enablement is per slab cache and static keys are global.

Adding static key adds code to the critical paths. Since the flags for a
kmem_cache have to be inspected anyways there may not be that much of a
benefit.

> It's true that in the alloc fast path the debugging check overhead is AFAICS
> amortized by the per-cpu cache, i.e. when the allocation is from there, no
> debugging functionality is performed. IMHO that's kinda a weakness, especially
> for SLAB_STORE_USER, so I might also look at doing something about it, and then
> the static key might be more critical for overhead reduction.

Moving debugging out of the per cpu fastpath allows that fastpath to be
much simpler and faster.

SLAB_STORE_USER is mostly used only for debugging in which case we are
less concerned with performance.

If you want to use SLAB_STORE_USER in the fastpath then we have to do some
major redesign there.

> In the freeing fast path I quickly checked the stats and it seems that in
> do_slab_free(), the "if (likely(page == c->page))" is not as likely as it
> declares, as in the majority of cases, freeing doesn't happen on the object
> that belongs to the page currently cached. So the advantage of a static key in
> slow path __slab_free() should be more useful immediately.

Right. The freeing logic is actuall a weakness in terms of performance for
SLUB due to the need to operate on a per page queue immediately.
