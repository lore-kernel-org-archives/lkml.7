Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B1E6C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 18:40:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14F80206BF
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 18:40:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730834AbfH0Skn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 14:40:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:9957 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728312AbfH0Skn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 14:40:43 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 847888980EA;
        Tue, 27 Aug 2019 18:40:42 +0000 (UTC)
Received: from x1.home (ovpn-116-99.phx2.redhat.com [10.3.116.99])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2F3521001B01;
        Tue, 27 Aug 2019 18:40:41 +0000 (UTC)
Date:   Tue, 27 Aug 2019 12:40:41 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Ben Luo <luoben@linux.alibaba.com>
Cc:     cohuck@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vfio/type1: avoid redundant PageReserved checking
Message-ID: <20190827124041.4f986005@x1.home>
In-Reply-To: <3e892a6bdaa069a6e79c50208bd01cab8c9588ac.1566910119.git.luoben@linux.alibaba.com>
References: <3e892a6bdaa069a6e79c50208bd01cab8c9588ac.1566910119.git.luoben@linux.alibaba.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.67]); Tue, 27 Aug 2019 18:40:42 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Aug 2019 20:49:48 +0800
Ben Luo <luoben@linux.alibaba.com> wrote:

> currently, if the page is not a tail of compound page, it will be
> checked twice for the same thing.
> 
> Signed-off-by: Ben Luo <luoben@linux.alibaba.com>
> ---
>  drivers/vfio/vfio_iommu_type1.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> index 054391f..cbe0d88 100644
> --- a/drivers/vfio/vfio_iommu_type1.c
> +++ b/drivers/vfio/vfio_iommu_type1.c
> @@ -291,11 +291,10 @@ static int vfio_lock_acct(struct vfio_dma *dma, long npage, bool async)
>  static bool is_invalid_reserved_pfn(unsigned long pfn)
>  {
>  	if (pfn_valid(pfn)) {
> -		bool reserved;
>  		struct page *tail = pfn_to_page(pfn);
>  		struct page *head = compound_head(tail);
> -		reserved = !!(PageReserved(head));
>  		if (head != tail) {
> +			bool reserved = !!(PageReserved(head));
>  			/*
>  			 * "head" is not a dangling pointer
>  			 * (compound_head takes care of that)
> @@ -310,7 +309,7 @@ static bool is_invalid_reserved_pfn(unsigned long pfn)
>  			if (PageTail(tail))
>  				return reserved;
>  		}
> -		return PageReserved(tail);
> +		return !!(PageReserved(tail));
>  	}
>  
>  	return true;

Logic seems fine to me, though I'd actually prefer to get rid of the !!
in the first use than duplicate it at the second use.  Thanks,

Alex
