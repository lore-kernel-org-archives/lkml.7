Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 303ABC76191
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 18:56:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F388321901
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 18:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563994583;
	bh=CL99li3UVmISH7DjaEXS6TbDlQTlSL2NsSlbOvu7Pog=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Z8BKgZGP/mwJT8tnBZ4d11JKhMlTbSwflgWCqKAeO6cHyGs3KktHWH7jEeTaQkSCh
	 92WcDF6TDx+0uPNXrk1RBW2FHkMjN0JqvTuVez4r06SZDkgvhsSfkH/s0XaOVJwHGf
	 rVVcwSeamN7OjEGgLJ/N9vLv8Qh7nbFrfdP8CRNk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728783AbfGXS4V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 14:56:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:46586 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727256AbfGXS4V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 14:56:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 377DCAE1B;
        Wed, 24 Jul 2019 18:56:20 +0000 (UTC)
Date:   Wed, 24 Jul 2019 20:56:17 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Christoph Hellwig <hch@lst.de>,
        Ralph Campbell <rcampbell@nvidia.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, nouveau@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Ben Skeggs <bskeggs@redhat.com>
Subject: Re: [PATCH] mm/hmm: replace hmm_update with mmu_notifier_range
Message-ID: <20190724185617.GE6410@dhcp22.suse.cz>
References: <20190723210506.25127-1-rcampbell@nvidia.com>
 <20190724070553.GA2523@lst.de>
 <20190724152858.GB28493@ziepe.ca>
 <20190724175858.GC6410@dhcp22.suse.cz>
 <20190724180837.GF28493@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190724180837.GF28493@ziepe.ca>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 24-07-19 15:08:37, Jason Gunthorpe wrote:
> On Wed, Jul 24, 2019 at 07:58:58PM +0200, Michal Hocko wrote:
[...]
> > Maybe new users have started relying on a new semantic in the meantime,
> > back then, none of the notifier has even started any action in blocking
> > mode on a EAGAIN bailout. Most of them simply did trylock early in the
> > process and bailed out so there was nothing to do for the range_end
> > callback.
> 
> Single notifiers are not the problem. I tried to make this clear in
> the commit message, but lets be more explicit.
> 
> We have *two* notifiers registered to the mm, A and B:
> 
> A invalidate_range_start: (has no blocking)
>     spin_lock()
>     counter++
>     spin_unlock()
> 
> A invalidate_range_end:
>     spin_lock()
>     counter--
>     spin_unlock()
> 
> And this one:
> 
> B invalidate_range_start: (has blocking)
>     if (!try_mutex_lock())
>         return -EAGAIN;
>     counter++
>     mutex_unlock()
> 
> B invalidate_range_end:
>     spin_lock()
>     counter--
>     spin_unlock()
> 
> So now the oom path does:
> 
> invalidate_range_start_non_blocking:
>  for each mn:
>    a->invalidate_range_start
>    b->invalidate_range_start
>    rc = EAGAIN
> 
> Now we SKIP A's invalidate_range_end even though A had no idea this
> would happen has state that needs to be unwound. A is broken.
> 
> B survived just fine.
> 
> A and B *alone* work fine, combined they fail.

But that requires that they share some state, right?

> When the commit was landed you can use KVM as an example of A and RDMA
> ODP as an example of B

Could you point me where those two share the state please? KVM seems to
be using kvm->mmu_notifier_count but I do not know where to look for the
RDMA...
-- 
Michal Hocko
SUSE Labs
