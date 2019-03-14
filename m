Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53040C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 15:49:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B72020811
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 15:49:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbfCNPtV convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 11:49:21 -0400
Received: from prv1-mh.provo.novell.com ([137.65.248.33]:58889 "EHLO
        prv1-mh.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbfCNPtT (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:11:1>);
        Thu, 14 Mar 2019 11:49:19 -0400
Received: from INET-PRV1-MTA by prv1-mh.provo.novell.com
        with Novell_GroupWise; Thu, 14 Mar 2019 09:49:17 -0600
Message-Id: <5C8A77FD020000780021EC87@prv1-mh.provo.novell.com>
X-Mailer: Novell GroupWise Internet Agent 18.1.0 
Date:   Thu, 14 Mar 2019 09:49:17 -0600
From:   "Jan Beulich" <JBeulich@suse.com>
To:     "David Hildenbrand" <david@redhat.com>
Cc:     "Julien Grall" <julien.grall@arm.com>,
        "Andrew Cooper" <andrew.cooper3@citrix.com>,
        "Matthew Wilcox" <willy@infradead.org>,
        "Stefano Stabellini" <sstabellini@kernel.org>,
        <linux-mm@kvack.org>, <akpm@linux-foundation.org>,
        "xen-devel" <xen-devel@lists.xenproject.org>,
        "Boris Ostrovsky" <boris.ostrovsky@oracle.com>,
        "Juergen Gross" <jgross@suse.com>, <linux-kernel@vger.kernel.org>,
        "Nadav Amit" <namit@vmware.com>
Subject: Re: [Xen-devel] [PATCH v1] xen/balloon: Fix mapping PG_offline
 pages to user space
References: <20190314154025.21128-1-david@redhat.com>
In-Reply-To: <20190314154025.21128-1-david@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>> On 14.03.19 at 16:40, <david@redhat.com> wrote:
> --- a/drivers/xen/balloon.c
> +++ b/drivers/xen/balloon.c
> @@ -604,6 +604,7 @@ int alloc_xenballooned_pages(int nr_pages, struct page **pages)
>  	while (pgno < nr_pages) {
>  		page = balloon_retrieve(true);
>  		if (page) {
> +			__ClearPageOffline(page);
>  			pages[pgno++] = page;

While this one's fine, ...

> @@ -646,6 +647,7 @@ void free_xenballooned_pages(int nr_pages, struct page **pages)
>  
>  	for (i = 0; i < nr_pages; i++) {
>  		if (pages[i])
> +			__SetPageOffline(pages[i]);
>  			balloon_append(pages[i]);
>  	}

... I think you want to add a pair of braces here.

Jan


