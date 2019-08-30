Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA621C3A59B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 16:28:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC49623405
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 16:28:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="m0ltjgx7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728031AbfH3Q2R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 12:28:17 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45450 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727883AbfH3Q2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 12:28:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=RdPMpAXXBaiQno2G62m49MFypxqlVKUtgB8faAoi/bA=; b=m0ltjgx7t4ynixYMj9EPQrDSd
        gouxhmamQQK46+oauBJCwjtVgtNnrQh3DY23q1oViqIYVv0QTxvU8EoQ2QX088A3jt8it37QT5tav
        +G99U5Hvmr8MWiuaitu6f4u0/16jw6KiM7gZ1aQphmP3iwQ4Ep8Ka7z0Z1hi8dRKhi7TrUA50F4rN
        6tsT6WTOz8bN8V7WcePdcW6dl7pBthWt1CXoQ36kayghdBUUFC2rvbk2mlhO/aFNG+K6fyaE5nxxt
        s8RKesu5J5MzBXL4CN/QjwpPqfrgUu3acD8Zy1p3mVZi/IUFVrm/eTTNm+BVfU3APEHcq1XOQIYIO
        cSh/4TjEA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i3jky-0006Lt-Fu; Fri, 30 Aug 2019 16:28:12 +0000
Date:   Fri, 30 Aug 2019 09:28:12 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Gao Xiang <gaoxiang25@huawei.com>
Cc:     Chao Yu <yuchao0@huawei.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        Joe Perches <joe@perches.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, LKML <linux-kernel@vger.kernel.org>,
        linux-erofs@lists.ozlabs.org, Chao Yu <chao@kernel.org>,
        Miao Xie <miaoxie@huawei.com>, weidu.du@huawei.com,
        Fang Wei <fangwei1@huawei.com>
Subject: Re: [PATCH v3 7/7] erofs: redundant assignment in
 __erofs_get_meta_page()
Message-ID: <20190830162812.GA10694@infradead.org>
References: <20190830032006.GA20217@architecture4>
 <20190830033643.51019-1-gaoxiang25@huawei.com>
 <20190830033643.51019-7-gaoxiang25@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190830033643.51019-7-gaoxiang25@huawei.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -		err = bio_add_page(bio, page, PAGE_SIZE, 0);
> -		if (err != PAGE_SIZE) {
> +		if (bio_add_page(bio, page, PAGE_SIZE, 0) != PAGE_SIZE) {
>  			err = -EFAULT;
>  			goto err_out;
>  		}

This patch looks like an improvement.  But looking at that whole
area just makes me cringe.

Why is there __erofs_get_meta_page with the two weird booleans instead
of a single erofs_get_meta_page that gets and gfp_t for additional
flags and an unsigned int for additional bio op flags.

Why do need ioprio support to start with?  Seeing that in a new
fs look kinda odd.  Do you have benchmarks that show the difference?

That function then calls erofs_grab_bio, which tries to handle a
bio_alloc failure, except that the function will not actually fail
due the mempool backing it.  It also seems like and awfully
huge function to inline.

Why is there __submit_bio which really just obsfucates what is
going on?  Also why is __submit_bio using bio_set_op_attrs instead
of opencode it as the comment right next to it asks you to?

Also I really don't understand why you can't just use read_cache_page
or even read_cache_page_gfp instead of __erofs_get_meta_page.
That function is a whole lot of duplication of functionality shared
by a lot of other file systems.
