Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C775C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 18:18:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3227C21743
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 18:18:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DYL+FtPK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390133AbfHHSS3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 14:18:29 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34518 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731038AbfHHSS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 14:18:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=XHC/DXG/AsJJpTqq+/d9d6/Y4cRytjPRBDIPDxq1Cy8=; b=DYL+FtPKnBxAd1YCNMrIj6xkY
        eKutNn+BNnoaI3sMq4H+QMbxmgy9VXDqKFZPqganM0B80hcGGXKzySE46O3LFTkiBDmqvBZh2aOUs
        /iT6efBCnhCEBDnxSyaAb9xiqCJaHm1KkQO8wAY3DUZrlpXceJIRZHphT5Y2dNYWp64JvSCk1OG24
        wVrehRnbwmRLcsrhP4/2LH7SO23gmhofLVJC/Txjkmyyu1SCALyZwAJ089a3NiUww5OuZL/uENZxm
        9+ilgWbtvtjDr2GsbzCWKRlM+mz/Jikh65vgXwbLen0E3jqcn9WG0d9ERZsx/7DnfisQGbbP63wyt
        ZDBzuXLNA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hvmzX-0005jr-2Q; Thu, 08 Aug 2019 18:18:23 +0000
Date:   Thu, 8 Aug 2019 11:18:22 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas@shipmail.org>,
        Jerome Glisse <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Steven Price <steven.price@arm.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] pagewalk: use lockdep_assert_held for locking
 validation
Message-ID: <20190808181822.GK5482@bombadil.infradead.org>
References: <20190808154240.9384-1-hch@lst.de>
 <20190808154240.9384-4-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190808154240.9384-4-hch@lst.de>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 08, 2019 at 06:42:40PM +0300, Christoph Hellwig wrote:
> Use lockdep to check for held locks instead of using home grown
> asserts.
> 
> @@ -319,7 +319,7 @@ int walk_page_range(struct mm_struct *mm, unsigned long start,
>  	if (!walk.mm)
>  		return -EINVAL;
>  
> -	VM_BUG_ON_MM(!rwsem_is_locked(&walk.mm->mmap_sem), walk.mm);
> +	lockdep_assert_held(&walk.mm->mmap_sem);

It occurs to me that this is exactly the pattern that lockdep_pin_lock()
was designed for.  I'm pretty sure things will go badly if any callee
unlocks then relocks the lock.

