Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D104C31E40
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 03:40:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF931206C1
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 03:40:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="piRoiynO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727220AbfHMDkE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 23:40:04 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47134 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726556AbfHMDkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 23:40:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=MeYDkUsLDE3HJKNLmJURvhZjxxlPNj8tQNSu9T9NQrI=; b=piRoiynOO/vnH67Q8hGEt6NTH
        CurQbOM0OiL/kEpT3Iubz1ie8OIA6InO4taHmxSep4Fsz2ElZQcdwRLGGV3COvyZHpp3GHXULPHQ1
        MgYyNrX8srPbkUAJ1ItoIrungP5j+2UcMzQ6gNfIVPonHw0fc+cNRyeD7qZQzKWbKlAkr7nhdp+/9
        oE682wegj+bhNxc0u3fIq1Y2Qyy0vCJmyzpXRq72EQMGxCMWN2RPJRaP104hxiLGO5s6ebh+M0W0L
        LwYooE5BMSqLXHTeVXL+GhCs8JwZFTW7Qksq/G01tpIRUG3iEiifP5Vf5eGAqUwNhwD9bb9zvTTY+
        KtF/8Rq6A==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hxNfC-0006Zg-RK; Tue, 13 Aug 2019 03:39:58 +0000
Date:   Mon, 12 Aug 2019 20:39:58 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Wei Yang <richardw.yang@linux.intel.com>
Cc:     akpm@linux-foundation.org, mgorman@techsingularity.net,
        vbabka@suse.cz, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/mmap.c: rb_parent is not necessary in __vma_link_list
Message-ID: <20190813033958.GB5307@bombadil.infradead.org>
References: <20190813032656.16625-1-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190813032656.16625-1-richardw.yang@linux.intel.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 13, 2019 at 11:26:56AM +0800, Wei Yang wrote:
> Now we use rb_parent to get next, while this is not necessary.
> 
> When prev is NULL, this means vma should be the first element in the
> list. Then next should be current first one (mm->mmap), no matter
> whether we have parent or not.
> 
> After removing it, the code shows the beauty of symmetry.

Uhh ... did you test this?

> @@ -273,12 +273,8 @@ void __vma_link_list(struct mm_struct *mm, struct vm_area_struct *vma,
>  		next = prev->vm_next;
>  		prev->vm_next = vma;
>  	} else {
> +		next = mm->mmap;
>  		mm->mmap = vma;
> -		if (rb_parent)
> -			next = rb_entry(rb_parent,
> -					struct vm_area_struct, vm_rb);
> -		else
> -			next = NULL;
>  	}

The full context is:

        if (prev) {
                next = prev->vm_next;
                prev->vm_next = vma;
        } else {
                mm->mmap = vma;
                if (rb_parent)
                        next = rb_entry(rb_parent,
                                        struct vm_area_struct, vm_rb);
                else
                        next = NULL;
        }

Let's imagine we have a small tree with three ranges in it.

A: 5-7
B: 8-10
C: 11-13

I would imagine an rbtree for this case has B at the top with A
to its left and B to its right.

Now we're going to add range D at 3-4.  'next' should clearly be range A.
It will have NULL prev.  Your code is going to make 'B' next, not A.
Right?
