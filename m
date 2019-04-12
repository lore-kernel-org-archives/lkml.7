Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69109C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 15:10:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34F7A2083E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 15:10:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LpMi21LX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbfDLPKN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 11:10:13 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53896 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726624AbfDLPKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 11:10:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=j1q7X6NhbEhLCOEdRNq18QipghdlQelDKQwUtZKxsIY=; b=LpMi21LXoKD2d7IA9vIfwCrxzP
        356U2r7Gouk03R4Kff9JRy/cWb4nqTA4CM97uJW5y6WSbcBsraGpgHNJWs/h9SNt1Whts2o9HRhil
        ug97rdAhPpyiJ40BN+r+C1Tww3LK7RdEQMq+1HN0AyUZYaj/eKgqd2bss6mNcsG+MTP+1FlkZoqxy
        ETV6PdF2PutL7UQ5+rBBJbX0V/yu79NV6Ioh0t81ywYl9DqYALqZ0UMsJHnJiWSjpIiUZxPir/rlh
        +vfatDmMlLH0VURQgoUgN82o8eJ/Vi4E0418vIx+vj4XyKv/jSVul2k1Y0v333KpMYAlPWwdbDX2V
        kVwjt6ow==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hExoZ-0002GO-LA; Fri, 12 Apr 2019 15:10:03 +0000
Date:   Fri, 12 Apr 2019 08:10:03 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Gao Xiang <gaoxiang25@huawei.com>
Cc:     Chao Yu <yuchao0@huawei.com>, Ming Lei <ming.lei@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, LKML <linux-kernel@vger.kernel.org>,
        linux-erofs@lists.ozlabs.org, Chao Yu <chao@kernel.org>,
        Miao Xie <miaoxie@huawei.com>, weidu.du@huawei.com,
        Fang Wei <fangwei1@huawei.com>
Subject: Re: [PATCH] staging: erofs: fix unexpected out-of-bound data access
Message-ID: <20190412151003.GA6990@infradead.org>
References: <20190411105555.133551-1-gaoxiang25@huawei.com>
 <20190412150633.GA20776@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190412150633.GA20776@infradead.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 12, 2019 at 08:06:33AM -0700, Christoph Hellwig wrote:
> > +++ b/drivers/staging/erofs/data.c
> > @@ -304,7 +304,7 @@ static inline struct bio *erofs_read_raw_page(struct bio *bio,
> >  	*last_block = current_block;
> >  
> >  	/* shift in advance in case of it followed by too many gaps */
> > -	if (unlikely(bio->bi_vcnt >= bio->bi_max_vecs)) {
> > +	if (bio->bi_iter.bi_size >= bio->bi_max_vecs * PAGE_SIZE) {
> 
> This is still a very odd check.  bi_max_vecs * PAGE_SIZE is rather
> arbitrary… and more importantly bi_max_vecs is not really a public
> field, in fact this is the only place every using it outside the
> core block layer.
> 
> I think the logic in this function should be reworked to what we
> do elsewhere in the kernel, that is just add to the bio until
> bio_add_page fails, in which case you submit the bio and start
> a new one.  Then once you are done with your operation just submit
> the bio.  Which unless I'm missing something is what the code does,
> except for the goto loop obsfucation that is trying to hide it.
> 
> So why not something like:

And looking at this a little more - I think you should drop the
erofs raw ops entirely.  The iomap-based readpage and readpages
from fs/iomap.c should serve your needs just fine without all that
duplication.  The only thing missing is the cleancache calls,
which could easily be added.
