Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 889B8C43215
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:36:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5725E22475
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:36:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sLzVARmE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730784AbfKTNgX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 08:36:23 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:60530 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728030AbfKTNgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 08:36:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ASV72BtEnHrv84BRXW5a2+dfpvX/DGvN865BSbTnC5M=; b=sLzVARmESmasT9OLC/FvJfLZg
        x5Ne1HzkRQoVZ5riSzdqex1nLzlsPOiJ9wsUggRvffCKPRjAFniqub/8tK9FHAxZX8F34sYm46A8Q
        ExwKP3IJLoKkVyxkTg83hSVq0p32sOVis+4s3VEwVp2LXCFBijeVCsmk6jCqAn8aSZa2nsdaZYkj9
        ZlToeUPrFqZhQRQYIAeSHQJBvaNpdb/reQ+IxIajNZ1401lXUaSX/i+o3bC1GlaDbgEtHs9o6Bmi0
        9IdpWAHOqZHf8Dw+FjWKifGcPmnujjsCwYeyrPRRwCQmJT8Ef2ERNkV+s6NjagbDjIVz9QR5GD3tj
        7kYKNmLzg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iXQ9b-0001rw-GT; Wed, 20 Nov 2019 13:36:19 +0000
Date:   Wed, 20 Nov 2019 05:36:19 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     ira.weiny@intel.com
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] mm: Clean up filemap_write_and_wait()
Message-ID: <20191120133619.GR20752@bombadil.infradead.org>
References: <20191120062334.24687-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191120062334.24687-1-ira.weiny@intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 19, 2019 at 10:23:34PM -0800, ira.weiny@intel.com wrote:
> At some point filemap_write_and_wait() and
> filemap_write_and_wait_range() got the exact same implementation with
> the exception of the range being specified in *_range()
> 
> Similar to other functions in fs.h which call
> *_range(..., 0, LLONG_MAX), change filemap_write_and_wait() to be a
> static inline which calls filemap_write_and_wait_range()
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
