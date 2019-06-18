Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA403C31E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 18:32:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 898D52080A
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 18:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560882733;
	bh=mx2GBaMPKIm/2tPzzP3cV12VlarSbBD4n4fTN+91FW0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=DiLzXWGcKryOWJQPYL9Vw2uLO2l7Q68mwVXENvV8MfjPFt7TAFOBEykdnMLspDbdu
	 Iq2BqLHOY6/Of7LCcCnHh4F+/zV8qlNV9S/X7jLaFpxkzVg32WtweBW7SCbI9/doPh
	 m2y+oDNf5WcJSxgZq/mvZlkyMtMI8M/+1ActSvr4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730219AbfFRScL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 14:32:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:49448 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729922AbfFRScL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 14:32:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E7E15AF56;
        Tue, 18 Jun 2019 18:32:09 +0000 (UTC)
Date:   Tue, 18 Jun 2019 20:32:08 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Roman Gushchin <guro@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        linux-api@vger.kernel.org
Subject: Re: [PATCH] mm, memcg: Report number of memcg caches in slabinfo
Message-ID: <20190618183208.GK3318@dhcp22.suse.cz>
References: <20190617142149.5245-1-longman@redhat.com>
 <20190617143842.GC1492@dhcp22.suse.cz>
 <9e165eae-e354-04c4-6362-0f80fe819469@redhat.com>
 <20190618123750.GG3318@dhcp22.suse.cz>
 <dee4dee2-1f4f-a7c9-0014-dca54b991377@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dee4dee2-1f4f-a7c9-0014-dca54b991377@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 18-06-19 12:59:24, Waiman Long wrote:
> On 6/18/19 8:37 AM, Michal Hocko wrote:
[...]
> > Is this useful enough to put into slabinfo? Doesn't this sound more like
> > a debugfs kinda a thing?
> 
> I guess it is probably more on the debug side of things. I add it to
> slabinfo as the data is readily available. It will be much more work if
> we need to export the data via debugfs.
> 
> We are seeing the kmem_cache slab growing continuously overtime when
> running a container-based workloads. Roman's kmem_cache reparenting
> patch will hopefully solve a major part of the problem, but we still
> need a way to confirm that by looking at how many memcg kmem_caches are
> associated with each root kmem_cache.

I am not disputing usefulness. Dead memcgs are showing up as a problem
for a longer time and having a more debugging information is definitely
useful. I am just not really sure that /proc/slabinfo is the proper
vehicle for that information. It might be just easier to stick it there
but that is not the best justification for adding something we will have
to maintain for ever. Not to mention that the number of dead memcgs
might not be enough to debug further when we can easily end up needing
to provide more in something less "carved in stone" kinda interface like
debugfs.

-- 
Michal Hocko
SUSE Labs
