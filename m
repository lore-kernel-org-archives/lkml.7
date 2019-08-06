Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3D91C433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 07:32:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA068218BC
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 07:32:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Eu966wVx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732070AbfHFHcI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 03:32:08 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50466 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731576AbfHFHcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 03:32:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=oTs2cY0AP7Gt6Axj3jnR38Lz4Y8u331s1JOYlARdadg=; b=Eu966wVxtPDyAfxY4T5b9Mvp/
        HDR0erbGAZXz2AqGAeOdEK/K2XQOlQyLFVaKfbHmskzMRogWsRVFf0LnYCUZq9AyhET+H+vM1RZHr
        vCIiWCAJvnK6MTZkjamjsUOj585w67g30jU0Fwujx4PC8+7jHBrOW8snLwJTpHWqf6Cz2oB2pmaSV
        DX1j6EYOG6XABnCRU/Kfrtx9XGQW6pUOuOCOGY/1B7Aih8on8ATF7J5BeSOzis45yUKB+8NzOAT7r
        PS2vzt0MgWhrIfmutdWvIPkCihF4U8wHpmdjG+LLRa31zeTy96L3iN6r75nZ7ec6uQzrCErOoz8KS
        v3FL8ONsQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hutww-0006vs-OK; Tue, 06 Aug 2019 07:32:02 +0000
Date:   Tue, 6 Aug 2019 00:32:02 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Eric Auger <eric.auger@redhat.com>
Cc:     eric.auger.pro@gmail.com, joro@8bytes.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        dwmw2@infradead.org, shameerali.kolothum.thodi@huawei.com,
        alex.williamson@redhat.com, robin.murphy@arm.com, hch@infradead.org
Subject: Re: [PATCH v2] iommu: revisit iommu_insert_resv_region()
 implementation
Message-ID: <20190806073202.GA26575@infradead.org>
References: <20190801155946.20645-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190801155946.20645-1-eric.auger@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A couple nitpicks below:

On Thu, Aug 01, 2019 at 05:59:46PM +0200, Eric Auger wrote:
> - * The new element is sorted by address with respect to the other
> - * regions of the same type. In case it overlaps with another
> - * region of the same type, regions are merged. In case it
> - * overlaps with another region of different type, regions are
> - * not merged.
> + * Elements are sorted by start address and overlapping segments
> + * of the same type are merged.
>   */
> +int iommu_insert_resv_region(struct iommu_resv_region *new,
> +			     struct list_head *regions)
>  {
> +	struct iommu_resv_region *iter, *tmp, *nr, *top;
> +	struct list_head stack;
> +	bool added = false;
>  
> +	INIT_LIST_HEAD(&stack);

Nit: you could just use

	LIST_HEAD(&stack);

to declare and initialize the variable in a single line.

> +	nr = iommu_alloc_resv_region(new->start, new->length,
> +				     new->prot, new->type);
> +	if (!nr)
>  		return -ENOMEM;
>  
> +	/* First add the new elt based on start address sorting */

/elt/element/ ?

> +	list_for_each_entry(iter, regions, list) {
> +		if (nr->start < iter->start) {
> +			list_add_tail(&nr->list, &iter->list);
> +			added = true;
> +			break;
> +		} else if (nr->start == iter->start && nr->type <= iter->type) {
> +			list_add_tail(&nr->list, &iter->list);
> +			added = true;
> +			break;
> +		}

Nit:  no need for an else after a a break.  But then again  both
branches look identical, so why don't you just merge them:

		if (nr->start < iter->start ||
		    (nr->start == iter->start && nr->type <= iter->type)) {
			list_add_tail(&nr->list, &iter->list);
			added = true;
			break;

	}

> +	if (!added)
> +		list_add_tail(&nr->list, regions);

Probably down to preference, but I'd just use a goto to jump past the
list_add and save the added variable.

> +	/* Merge overlapping segments of type nr->type, if any */
> +	list_for_each_entry_safe(iter, tmp, regions, list) {
> +		phys_addr_t top_end, iter_end = iter->start + iter->length - 1;
> +		bool found = false;
> +
> +		/* no merge needed on elements of different types than @nr */
> +		if (iter->type != nr->type) {
> +			list_move_tail(&iter->list, &stack);
> +			continue;
> +		}
> +
> +		/* look for the last stack element of same type as @iter */
> +		list_for_each_entry_reverse(top, &stack, list)
> +			if (top->type == iter->type) {
> +				found = true;
> +				break;
> +			}
> +		if (!found) {

Same here.

> +			list_move_tail(&iter->list, &stack);
> +			continue;
> +		}
> +
> +		top_end = top->start + top->length - 1;
> +
> +		if (iter->start > top_end + 1) {
> +			list_move_tail(&iter->list, &stack);
> +		} else {
> +			top->length = max(top_end, iter_end) - top->start + 1;
> +			list_del(&iter->list);
> +			kfree(iter);
> +		}

I wonder if the body of the outer list_for_each_entry_safe loop would
be a bit nicer in a helper, but again that is probably just down to
personal preference.
