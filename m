Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B317CC7618F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 19:49:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94709214AF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 19:49:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391476AbfGXTtC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 15:49:02 -0400
Received: from verein.lst.de ([213.95.11.211]:53836 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391456AbfGXTs5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 15:48:57 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id E520F68B20; Wed, 24 Jul 2019 21:48:55 +0200 (CEST)
Date:   Wed, 24 Jul 2019 21:48:55 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Michal Hocko <mhocko@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Ralph Campbell <rcampbell@nvidia.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, nouveau@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Ben Skeggs <bskeggs@redhat.com>
Subject: Re: [PATCH] mm/hmm: replace hmm_update with mmu_notifier_range
Message-ID: <20190724194855.GA15029@lst.de>
References: <20190723210506.25127-1-rcampbell@nvidia.com> <20190724070553.GA2523@lst.de> <20190724152858.GB28493@ziepe.ca> <20190724175858.GC6410@dhcp22.suse.cz> <20190724180837.GF28493@ziepe.ca> <20190724185617.GE6410@dhcp22.suse.cz> <20190724185910.GF6410@dhcp22.suse.cz> <20190724192155.GG28493@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190724192155.GG28493@ziepe.ca>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 24, 2019 at 04:21:55PM -0300, Jason Gunthorpe wrote:
> If we change the register to keep the hlist sorted by address then we
> can do a targetted 'undo' of past starts terminated by address
> less-than comparison of the first failing struct mmu_notifier.
> 
> It relies on the fact that rcu is only used to remove items, the list
> adds are all protected by mm locks, and the number of mmu notifiers is
> very small.
> 
> This seems workable and does not need more driver review/update...
> 
> However, hmm's implementation still needs more fixing.

Can we take one step back, please?  The only reason why drivers
implement both ->invalidate_range_start and ->invalidate_range_end and
expect them to be called paired is to keep some form of counter of
active invalidation "sections".  So instead of doctoring around
undo schemes the only sane answer is to take such a counter into the
core VM code instead of having each driver struggle with it.
