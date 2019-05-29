Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97C23C04AB3
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 06:18:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48F2D208CB
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 06:18:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KeAxAjEg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726076AbfE2GSD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 02:18:03 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59078 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725879AbfE2GSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 02:18:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=SlJAo9Q1H6Y1MH1l1DawZNFwXZmoCdx0nahsUu/QeN8=; b=KeAxAjEgLFUtRPQwovBoJEqbz
        T8+FcjyGQDM8krZaFZlhjfc7W7jJ9IQ74reJcgB0/lUZhIUdXr5ry+Ph0Mnlo9E7lsCkAv6kYQ3Vs
        d6+TWy4glZBYzl7yH580tMbPr0aevty1Y/hEjy67y8Aj4xeGWlonCh3ip8ZwSsBTbvV8JgNfYqSd/
        INZHesRyjDqzul7h4oWVE6lZwXZvoWFjdPUyhvAFktttue138Ps6N14Kzam1JDtylR8OUcUQoI6NG
        +NYxHjquKzeCbWZ9Eu1c4B4/0PPZy5klFa61/CeULI1b06knxKlZcYF2rAwGHuGjmJDRP+x3CrglZ
        EbMtIDnEA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hVruP-00089b-4I; Wed, 29 May 2019 06:17:57 +0000
Date:   Tue, 28 May 2019 23:17:56 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Eric Auger <eric.auger@redhat.com>
Cc:     eric.auger.pro@gmail.com, joro@8bytes.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        dwmw2@infradead.org, robin.murphy@arm.com,
        jean-philippe.brucker@arm.com, alex.williamson@redhat.com
Subject: Re: [PATCH v5 1/7] iommu: Fix a leak in iommu_insert_resv_region
Message-ID: <20190529061756.GB26055@infradead.org>
References: <20190528115025.17194-1-eric.auger@redhat.com>
 <20190528115025.17194-2-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190528115025.17194-2-eric.auger@redhat.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>  		} else if ((start >= a) && (end <= b)) {
>  			if (new->type == type)
> -				goto done;
> +				return 0;
>  			else
>  				pos = pos->next;

Please remove the pointless else after the return statement.

>  		} else {
>  			if (new->type == type) {
>  				phys_addr_t new_start = min(a, start);
>  				phys_addr_t new_end = max(b, end);
> +				int ret;
>  
>  				list_del(&entry->list);
>  				entry->start = new_start;
>  				entry->length = new_end - new_start + 1;
> -				iommu_insert_resv_region(entry, regions);
> +				ret = iommu_insert_resv_region(entry, regions);
> +				kfree(entry);
> +				return ret;
>  			} else {
>  				pos = pos->next;
>  			}

Same here.
