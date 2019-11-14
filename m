Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CD49C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 07:19:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C9832068F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 07:19:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726750AbfKNHTG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 02:19:06 -0500
Received: from verein.lst.de ([213.95.11.211]:37919 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725838AbfKNHTF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 02:19:05 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2FE8B68AFE; Thu, 14 Nov 2019 08:19:03 +0100 (CET)
Date:   Thu, 14 Nov 2019 08:19:03 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     jhubbard@nvidia.com, Jan Kara <jack@suse.cz>,
        Christoph Hellwig <hch@lst.de>,
        Ira Weiny <ira.weiny@intel.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] mm: Cleanup __put_devmap_managed_page() vs
 ->page_free()
Message-ID: <20191114071903.GA26307@lst.de>
References: <157368992671.2974225.13512647385398246617.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <157368992671.2974225.13512647385398246617.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 13, 2019 at 04:07:22PM -0800, Dan Williams wrote:
>  static int devmap_managed_enable_get(struct dev_pagemap *pgmap)
>  {
> -	if (!pgmap->ops || !pgmap->ops->page_free) {
> +	if (!pgmap->ops || (pgmap->type == MEMORY_DEVICE_PRIVATE
> +				&& !pgmap->ops->page_free)) {

I don't think this check is correct.  You only want the the ops null check
or MEMORY_DEVICE_PRIVATE as well now, i.e.:

	if (pgmap->type == MEMORY_DEVICE_PRIVATE &&
	    (!pgmap->ops || !pgmap->ops->page_free)) {

> @@ -476,10 +471,17 @@ void __put_devmap_managed_page(struct page *page)
>  		 * handled differently or not done at all, so there is no need
>  		 * to clear page->mapping.
>  		 */
> -		if (is_device_private_page(page))
> -			page->mapping = NULL;
> +		if (is_device_private_page(page)) {
> +			/* Clear Active bit in case of parallel mark_page_accessed */

This adds a > 80 char line.  But that whole flow of the function seems
rather odd now.

Why can't we do:

	if (count == 0) {
		__put_page(page);
	} else if (is_device_private_page(page)) {
		__ClearPageActive(page);
		__ClearPageWaiters(page);

		mem_cgroup_uncharge(page);
		page->mapping = NULL;
		page->pgmap->ops->page_free(page);
	} else {
		wake_up_var(&page->_refcount);
	}

(except for the fact that I don't get the point of calling __put_page
on a refcount of zero, but that is separate from this patch).
