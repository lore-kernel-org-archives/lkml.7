Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB02AC43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 18:25:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4EB920836
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 18:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575915942;
	bh=7lZhBALm50HN15SBV5fFrjzT8kipUFrgnVFKe9+PyI0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=pWa4Q9LnwDzw1YnxD9l7E29HSFkz+mKpK4tCD2YCJQKSPLNLzgJC76ITlOGjVbfiR
	 q0kTR21SImFUdLh7INyQ6Ne8AdHEXnDmw4+bBXu4CfOUwykB7k5WpkXX1cMCMujFCW
	 CNGaiVCrql6exOIIepoCSA0+lKIj2v2d8esZIumE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbfLISZl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 13:25:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:34500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726354AbfLISZl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 13:25:41 -0500
Received: from localhost (unknown [5.29.147.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D1962077B;
        Mon,  9 Dec 2019 18:25:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575915940;
        bh=7lZhBALm50HN15SBV5fFrjzT8kipUFrgnVFKe9+PyI0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u+Pyb/iDy+kPaQAzVaYes4E8svDMq84BeCg+ARHzAIP9AimybpRCbpl3GIhqqlnhb
         nHRW6EL6Sj0en0v8UklM/YoDdwplAkX2ZB3da/fTEuX4GNNfaXoyoJUg2ngdGv5VyV
         IcQcqp+sgvQ1CkUy50V7aC6F8twkZajXYu2URhMs=
Date:   Mon, 9 Dec 2019 20:25:36 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Christoph Hellwig <hch@infradead.org>,
        Ira Weiny <ira.weiny@intel.com>, linux-rdma@vger.kernel.org,
        linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 1/2] mm/gup: allow FOLL_FORCE for get_user_pages_fast()
Message-ID: <20191209182536.GC67461@unreal>
References: <20191204213603.464373-1-jhubbard@nvidia.com>
 <20191204213603.464373-2-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191204213603.464373-2-jhubbard@nvidia.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 04, 2019 at 01:36:02PM -0800, John Hubbard wrote:
> Commit 817be129e6f2 ("mm: validate get_user_pages_fast flags") allowed
> only FOLL_WRITE and FOLL_LONGTERM to be passed to get_user_pages_fast().
> This, combined with the fact that get_user_pages_fast() falls back to
> "slow gup", which *does* accept FOLL_FORCE, leads to an odd situation:
> if you need FOLL_FORCE, you cannot call get_user_pages_fast().
>
> There does not appear to be any reason for filtering out FOLL_FORCE.
> There is nothing in the _fast() implementation that requires that we
> avoid writing to the pages. So it appears to have been an oversight.
>
> Fix by allowing FOLL_FORCE to be set for get_user_pages_fast().
>
> Fixes: 817be129e6f2 ("mm: validate get_user_pages_fast flags")
> Cc: Christoph Hellwig <hch@lst.de>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---
>  mm/gup.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>

Thanks,
Reviewed-by: Leon Romanovsky <leonro@mellanox.com>
