Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ACB6C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 15:18:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F92A21479
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 15:18:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HGJfCy21"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391395AbfIMPSI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 11:18:08 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50106 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388354AbfIMPSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 11:18:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=fxdx8ELT74pyYGT61OLGflIw6z6NXtnHEx3y22zF9/I=; b=HGJfCy214Ht+AD4xBmFC2EHL/h
        RGMiZnEGOa0ZkY+vilO/vwXrwlw5aVSIvlxTJlhfy35kx2Hk/aCz/fPXBIfh0u4xiRil59kS16WqN
        CY+c/HDv6hZES8flPhraJi79Tpz9SEavFg1fZFXMRI5mwNNJdUBiCFJFQIYl1DqSJWaXVqwotLrkI
        660Dzqxfp3iTpjh7kUAAzqrFPM72+Z6LiD0P9chN7sJkU1s05NXxtGy9NxaZYefRN/RG1jJscJbE4
        6htV+dd2KCxAB9XypgpTU4/6FN8Ci4QOP9ZyPmtmR7pOb2QB5fu/qm4PQs4IiI5fEeSy3ft9D+awP
        t+Sl2VEQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1i8nKl-0006KN-Pf; Fri, 13 Sep 2019 15:18:03 +0000
Date:   Fri, 13 Sep 2019 08:18:03 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Thomas =?iso-8859-1?Q?Hellstr=F6m_=28VMware=29?= 
        <thomas_os@shipmail.org>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-mm@kvack.org, pv-drivers@vmware.com,
        linux-graphics-maintainer@vmware.com,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        Minchan Kim <minchan@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Huang Ying <ying.huang@intel.com>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [RFC PATCH 3/7] drm/ttm: TTM fault handler helpers
Message-ID: <20190913151803.GO29434@bombadil.infradead.org>
References: <20190913093213.27254-1-thomas_os@shipmail.org>
 <20190913093213.27254-4-thomas_os@shipmail.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190913093213.27254-4-thomas_os@shipmail.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 13, 2019 at 11:32:09AM +0200, Thomas Hellström (VMware) wrote:
> +vm_fault_t ttm_bo_vm_fault_reserved(struct vm_fault *vmf,
> +				    pgprot_t prot,
> +				    pgoff_t num_prefault)
> +{
> +	struct vm_area_struct *vma = vmf->vma;
> +	struct vm_area_struct cvma = *vma;
> +	struct ttm_buffer_object *bo = (struct ttm_buffer_object *)
> +	    vma->vm_private_data;

It's a void *.  There's no need to cast it.

	struct ttm_buffer_object *bo = vma->vm_private_data;

conveys exactly the same information to both the reader and the compiler,
except it's all on one line instead of split over two.

