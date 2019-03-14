Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34D2FC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 15:49:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FF492184E
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 15:49:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726938AbfCNPtS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 11:49:18 -0400
Received: from charybdis-ext.suse.de ([195.135.221.2]:1693 "EHLO suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726157AbfCNPtR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 11:49:17 -0400
Received: by suse.de (Postfix, from userid 1000)
        id 66755457F; Thu, 14 Mar 2019 16:49:10 +0100 (CET)
Date:   Thu, 14 Mar 2019 16:49:10 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     David Hildenbrand <david@redhat.com>
Cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Julien Grall <julien.grall@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Nadav Amit <namit@vmware.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        akpm@linux-foundation.org, linux-mm@kvack.org
Subject: Re: [PATCH v1] xen/balloon: Fix mapping PG_offline pages to user
 space
Message-ID: <20190314154907.wcwh5ricj6v7p23v@d104.suse.de>
References: <20190314154025.21128-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190314154025.21128-1-david@redhat.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 14, 2019 at 04:40:25PM +0100, David Hildenbrand wrote:
> @@ -646,6 +647,7 @@ void free_xenballooned_pages(int nr_pages, struct page **pages)
>  
>  	for (i = 0; i < nr_pages; i++) {
>  		if (pages[i])
> +			__SetPageOffline(pages[i]);
>  			balloon_append(pages[i]);

didn't you forget {} there? ;-)

>  	}
>  
> -- 
> 2.17.2
> 

-- 
Oscar Salvador
SUSE L3
