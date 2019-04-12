Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7E50C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 15:06:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A92942083E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 15:06:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qSwN+5q7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726870AbfDLPGt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 11:06:49 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53742 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726777AbfDLPGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 11:06:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=gt85otHoopD1zQt54wlfP+581azjYrMWqZTo5GZEOzY=; b=qSwN+5q7T3thCOSGbfeLvX33b9
        BVUtIdmvxA4ZRgjOJUgzjREV93IeD+n6CM26sXwRM5JzUqQ1iW5sOI4ZC4T4WP/OHuvddVW9JkRsP
        afPtFkVrbbLdnBjA4moVg3+5WSX4+RkiT02a2XmeAU+XekvSuC1YrLnLDPrYeGuwbMC/ir41L5L16
        M40Dlpz1uoRM65//GlMIiWlT3GE04B6cBj4Ajc3IXG5fJh8CrwYHpXlgE1+8EYsRThT6FspP+N1RK
        Tay9Nn7jnZj1pRwezpCU0M94srrR8flPM95Q0QuzMNLbposA0CsKnsxWnRJjC98cRgjowxOrzChhj
        H0iQOflw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hExlB-0001hL-Cz; Fri, 12 Apr 2019 15:06:33 +0000
Date:   Fri, 12 Apr 2019 08:06:33 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Gao Xiang <gaoxiang25@huawei.com>
Cc:     Chao Yu <yuchao0@huawei.com>, Ming Lei <ming.lei@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, LKML <linux-kernel@vger.kernel.org>,
        linux-erofs@lists.ozlabs.org, Chao Yu <chao@kernel.org>,
        Miao Xie <miaoxie@huawei.com>, weidu.du@huawei.com,
        Fang Wei <fangwei1@huawei.com>
Subject: Re: [PATCH] staging: erofs: fix unexpected out-of-bound data access
Message-ID: <20190412150633.GA20776@infradead.org>
References: <20190411105555.133551-1-gaoxiang25@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190411105555.133551-1-gaoxiang25@huawei.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +++ b/drivers/staging/erofs/data.c
> @@ -304,7 +304,7 @@ static inline struct bio *erofs_read_raw_page(struct bio *bio,
>  	*last_block = current_block;
>  
>  	/* shift in advance in case of it followed by too many gaps */
> -	if (unlikely(bio->bi_vcnt >= bio->bi_max_vecs)) {
> +	if (bio->bi_iter.bi_size >= bio->bi_max_vecs * PAGE_SIZE) {

This is still a very odd check.  bi_max_vecs * PAGE_SIZE is rather
arbitrary… and more importantly bi_max_vecs is not really a public
field, in fact this is the only place every using it outside the
core block layer.

I think the logic in this function should be reworked to what we
do elsewhere in the kernel, that is just add to the bio until
bio_add_page fails, in which case you submit the bio and start
a new one.  Then once you are done with your operation just submit
the bio.  Which unless I'm missing something is what the code does,
except for the goto loop obsfucation that is trying to hide it.

So why not something like:


diff --git a/drivers/staging/erofs/data.c b/drivers/staging/erofs/data.c
index 0714061ba888..122714e19079 100644
--- a/drivers/staging/erofs/data.c
+++ b/drivers/staging/erofs/data.c
@@ -296,20 +296,9 @@ static inline struct bio *erofs_read_raw_page(struct bio *bio,
 		}
 	}
 
-	err = bio_add_page(bio, page, PAGE_SIZE, 0);
-	/* out of the extent or bio is full */
-	if (err < PAGE_SIZE)
+	if (bio_add_page(bio, page, PAGE_SIZE, 0) != PAGE_SIZE)
 		goto submit_bio_retry;
-
 	*last_block = current_block;
-
-	/* shift in advance in case of it followed by too many gaps */
-	if (unlikely(bio->bi_vcnt >= bio->bi_max_vecs)) {
-		/* err should reassign to 0 after submitting */
-		err = 0;
-		goto submit_bio_out;
-	}
-
 	return bio;
 
 err_out:
@@ -323,9 +312,7 @@ static inline struct bio *erofs_read_raw_page(struct bio *bio,
 
 	/* if updated manually, continuous pages has a gap */
 	if (bio)
-submit_bio_out:
 		__submit_bio(bio, REQ_OP_READ, 0);
-
 	return unlikely(err) ? ERR_PTR(err) : NULL;
 }
 
@@ -387,8 +374,7 @@ static int erofs_raw_access_readpages(struct file *filp,
 	}
 	DBG_BUGON(!list_empty(pages));
 
-	/* the rare case (end in gaps) */
-	if (unlikely(bio))
+	if (bio)
 		__submit_bio(bio, REQ_OP_READ, 0);
 	return 0;
 }

>  		/* err should reassign to 0 after submitting */
>  		err = 0;
>  		goto submit_bio_out;
> -- 
> 2.17.1
> 
---end quoted text---
