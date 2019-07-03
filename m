Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8861C06513
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 20:29:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89B54218A0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 20:29:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727263AbfGCU3A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 16:29:00 -0400
Received: from verein.lst.de ([213.95.11.211]:54906 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727246AbfGCU3A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 16:29:00 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id BA28168B05; Wed,  3 Jul 2019 22:28:57 +0200 (CEST)
Date:   Wed, 3 Jul 2019 22:28:57 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ralph Campbell <rcampbell@nvidia.com>
Subject: Re: [PATCH 1/5] mm: return valid info from hmm_range_unregister
Message-ID: <20190703202857.GA15690@lst.de>
References: <20190703184502.16234-1-hch@lst.de> <20190703184502.16234-2-hch@lst.de> <20190703190045.GN18688@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190703190045.GN18688@mellanox.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 03, 2019 at 07:00:50PM +0000, Jason Gunthorpe wrote:
> I don't think the API should be encouraging some shortcut here..
> 
> We can't do the above pattern because the old hmm_vma API didn't allow
> it, which is presumably a reason why it is obsolete.
> 
> I'd rather see drivers move to a consistent pattern so we can then
> easily hoist the seqcount lock scheme into some common mmu notifier
> code, as discussed.

So you don't like the version in amdgpu_ttm_tt_get_user_pages_done in
linux-next either?

I can remove this and just move hmm_vma_range_done to nouveau instead.
Let me know if you have other comments before I resend.  Note that
I'll probably be offline Thu-Sun this week.
