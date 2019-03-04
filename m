Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B80BC10F03
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 13:48:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3401A2075B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 13:48:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbfCDNsO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 08:48:14 -0500
Received: from charybdis-ext.suse.de ([195.135.221.2]:59719 "EHLO suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726243AbfCDNsN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 08:48:13 -0500
Received: by suse.de (Postfix, from userid 1000)
        id 7704E446F; Mon,  4 Mar 2019 14:48:12 +0100 (CET)
Date:   Mon, 4 Mar 2019 14:48:12 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Jing Xiangfeng <jingxiangfeng@huawei.com>, mhocko@kernel.org,
        hughd@google.com, linux-mm@kvack.org, n-horiguchi@ah.jp.nec.com,
        Andrea Arcangeli <aarcange@redhat.com>,
        kirill.shutemov@linux.intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] mm/hugetlb: Fix unsigned overflow in
 __nr_hugepages_store_common()
Message-ID: <20190304134809.2aprjskb6z6gv6c5@d104.suse.de>
References: <388cbbf5-7086-1d04-4c49-049021504b9d@oracle.com>
 <alpine.DEB.2.21.1902241913000.34632@chino.kir.corp.google.com>
 <8c167be7-06fa-a8c0-8ee7-0bfad41eaba2@oracle.com>
 <13400ee2-3d3b-e5d6-2d78-a770820417de@oracle.com>
 <alpine.DEB.2.21.1902251116180.167839@chino.kir.corp.google.com>
 <5C74A2DA.1030304@huawei.com>
 <alpine.DEB.2.21.1902252220310.40851@chino.kir.corp.google.com>
 <e2bded2f-40ca-c308-5525-0a21777ed221@oracle.com>
 <20190226143620.c6af15c7c897d3362b191e36@linux-foundation.org>
 <086c4a4b-a37d-f144-00c0-d9a4062cc5fe@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <086c4a4b-a37d-f144-00c0-d9a4062cc5fe@oracle.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 26, 2019 at 04:03:23PM -0800, Mike Kravetz wrote:
> I was just going to update the comments and send you a new patch, but
> but your comment got me thinking about this situation.  I did not really
> change the way this code operates.  As a reminder, the original code is like:
> 
> NODEMASK_ALLOC(nodemask_t, nodes_allowed, GFP_KERNEL | __GFP_NORETRY);
> 
> if (nid == NUMA_NO_NODE) {
> 	/* do something */
> } else if (nodes_allowed) {
> 	/* do something else */
> } else {
> 	nodes_allowed = &node_states[N_MEMORY];
> }
> 
> So, the only way we get to that final else if if we can not allocate
> a node mask (kmalloc a few words).  Right?  I wonder why we should
> even try to continue in this case.  Why not just return right there?
> 
> The specified count value is either a request to increase number of
> huge pages or decrease.  If we can't allocate a few words, we certainly
> are not going to find memory to create huge pages.  There 'might' be
> surplus pages which can be converted to permanent pages.  But remember
> this is a 'node specific' request and we can't allocate a mask to pass
> down to the conversion routines.  So, chances are good we would operate
> on the wrong node.  The same goes for a request to 'free' huge pages.
> Since, we can't allocate a node mask we are likely to free them from
> the wrong node.
> 
> Unless my reasoning above is incorrect, I think that final else block
> in __nr_hugepages_store_common() is wrong.
> 
> Any additional thoughts?

Could not we kill the NODEMASK_ALLOC there?
__nr_hugepages_store_common() should be called from a rather shallow stack,
and unless I am wrong, the maximum value we can get for a nodemask_t is 128bytes
(1024 NUMA nodes).

-- 
Oscar Salvador
SUSE L3
