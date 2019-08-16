Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F46AC3A59D
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 21:01:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30D3D21721
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 21:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565989261;
	bh=KfBZ36B394sYe7mkkVCgZdVU+aXcwatWWBVhiPlhweY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=OhmoN9Go7xDAzl9fJWTQ6h6Zq3U2xPnnLXebbB9BgQNHq2o8Vs9+1XYnWa0IIWOnO
	 kuGt44EjhzUHOBpmII/er3c/qYTKPYP1RJ79DTOtweEKQS7Jc8xtP7nYM/lo+PvX+b
	 TVUIVHGGzk+XfzsGGMKrGDGwFmbKADSDR6uF3L/o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727822AbfHPVBA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 17:01:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:48330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727548AbfHPVA7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 17:00:59 -0400
Received: from localhost.localdomain (c-73-223-200-170.hsd1.ca.comcast.net [73.223.200.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 63B872133F;
        Fri, 16 Aug 2019 21:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565989258;
        bh=KfBZ36B394sYe7mkkVCgZdVU+aXcwatWWBVhiPlhweY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VlfOwai9UGWDt96zOxfmiJOjMKL4/lmTbJ7PqIEIxnyMIOfLWuddL1N3iELB68ZwV
         49+0YjcPaM+mIQShOMVbqE8qsPT2r00wphg3FQZt2qwvyLZ/Yx6Q/DttOKk3Qqky2X
         fWUsSZZOIVwzkbcSzs9cbFq2jWb0fV/fhH1SNQ88=
Date:   Fri, 16 Aug 2019 14:00:57 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Bharata B Rao <bharata@linux.ibm.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org
Subject: Re: [PATCH 4/4] memremap: provide a not device managed
 memremap_pages
Message-Id: <20190816140057.c1ab8b41b9bfff65b7ea83ba@linux-foundation.org>
In-Reply-To: <20190816065434.2129-5-hch@lst.de>
References: <20190816065434.2129-1-hch@lst.de>
        <20190816065434.2129-5-hch@lst.de>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Aug 2019 08:54:34 +0200 Christoph Hellwig <hch@lst.de> wrote:

> The kvmppc ultravisor code wants a device private memory pool that is
> system wide and not attached to a device.  Instead of faking up one
> provide a low-level memremap_pages for it.  Note that this function is
> not exported, and doesn't have a cleanup routine associated with it to
> discourage use from more driver like users.

Confused. Which function is "not exported"?

> +EXPORT_SYMBOL_GPL(memunmap_pages);
> +EXPORT_SYMBOL_GPL(memremap_pages);
>  EXPORT_SYMBOL_GPL(devm_memremap_pages);

