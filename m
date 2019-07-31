Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8609BC41514
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 09:06:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CDF0208C3
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 09:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564564017;
	bh=MJVPGw+WNNAbTwYU58W0WuGORWLiQxMEq7DGkp8uDEw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=nfHOK5QecJTfNtXKlyTNo2dyGVhwWTgSpEHafT6VvJKWPoGkiHO4kFeABR8a2EJdl
	 HAMp5oRcDZK0IEF2o1VS5gVMyRWX1nu6huwbX2CZh2GWaubwy7xiD3dPRPVLkDHE37
	 CFJbCY5viUGd4/rJgB6ioI/+Ufc/Of+cWR5hzWYE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728373AbfGaJG4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 05:06:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:40264 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726707AbfGaJGz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 05:06:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 90E14ABE9;
        Wed, 31 Jul 2019 09:06:54 +0000 (UTC)
Date:   Wed, 31 Jul 2019 11:06:53 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Qian Cai <cai@lca.pw>
Subject: Re: [PATCH v2] mm: kmemleak: Use mempool allocations for kmemleak
 objects
Message-ID: <20190731090653.GD9330@dhcp22.suse.cz>
References: <20190727132334.9184-1-catalin.marinas@arm.com>
 <20190730125743.113e59a9c449847d7f6ae7c3@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190730125743.113e59a9c449847d7f6ae7c3@linux-foundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 30-07-19 12:57:43, Andrew Morton wrote:
> On Sat, 27 Jul 2019 14:23:33 +0100 Catalin Marinas <catalin.marinas@arm.com> wrote:
> 
> > Add mempool allocations for struct kmemleak_object and
> > kmemleak_scan_area as slightly more resilient than kmem_cache_alloc()
> > under memory pressure. Additionally, mask out all the gfp flags passed
> > to kmemleak other than GFP_KERNEL|GFP_ATOMIC.
> > 
> > A boot-time tuning parameter (kmemleak.mempool) is added to allow a
> > different minimum pool size (defaulting to NR_CPUS * 4).
> 
> Why would anyone ever want to alter this?  Is there some particular
> misbehaviour which this will improve?  If so, what is it?

I do agree with Andrew here. Can we simply go with no tunning for now
and only add it based on some real life reports that the auto-tuning is
not sufficient?

-- 
Michal Hocko
SUSE Labs
