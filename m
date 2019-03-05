Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D3A0C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 00:06:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DD0E206B8
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 00:06:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbfCEAGo convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 19:06:44 -0500
Received: from tyo161.gate.nec.co.jp ([114.179.232.161]:36509 "EHLO
        tyo161.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726095AbfCEAGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 19:06:43 -0500
Received: from mailgate02.nec.co.jp ([114.179.233.122])
        by tyo161.gate.nec.co.jp (8.15.1/8.15.1) with ESMTPS id x2505DvQ001559
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 5 Mar 2019 09:05:13 +0900
Received: from mailsv01.nec.co.jp (mailgate-v.nec.co.jp [10.204.236.94])
        by mailgate02.nec.co.jp (8.15.1/8.15.1) with ESMTP id x2505D98029259;
        Tue, 5 Mar 2019 09:05:13 +0900
Received: from mail02.kamome.nec.co.jp (mail02.kamome.nec.co.jp [10.25.43.5])
        by mailsv01.nec.co.jp (8.15.1/8.15.1) with ESMTP id x2504r7K005945;
        Tue, 5 Mar 2019 09:05:13 +0900
Received: from bpxc99gp.gisp.nec.co.jp ([10.38.151.149] [10.38.151.149]) by mail03.kamome.nec.co.jp with ESMTP id BT-MMP-3007610; Tue, 5 Mar 2019 09:04:01 +0900
Received: from BPXM23GP.gisp.nec.co.jp ([10.38.151.215]) by
 BPXC21GP.gisp.nec.co.jp ([10.38.151.149]) with mapi id 14.03.0319.002; Tue, 5
 Mar 2019 09:04:00 +0900
From:   Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Jing Xiangfeng <jingxiangfeng@huawei.com>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
        "hughd@google.com" <hughd@google.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "Andrea Arcangeli" <aarcange@redhat.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] mm/hugetlb: Fix unsigned overflow in
 __nr_hugepages_store_common()
Thread-Topic: [PATCH v4] mm/hugetlb: Fix unsigned overflow in
 __nr_hugepages_store_common()
Thread-Index: AQHUzKNmJ08QFadITkadXECqBzMSPaXvQTOAgADisACAABkvAIAAEDUAgAB2wwCAAEK9AIAA3REAgAAzZACAABhSgIAJbiwA
Date:   Tue, 5 Mar 2019 00:03:59 +0000
Message-ID: <20190305000402.GA4698@hori.linux.bs1.fc.nec.co.jp>
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
In-Reply-To: <086c4a4b-a37d-f144-00c0-d9a4062cc5fe@oracle.com>
Accept-Language: en-US, ja-JP
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.34.125.96]
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <853429AEAD48A04F86B60F723266BFD0@gisp.nec.co.jp>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 26, 2019 at 04:03:23PM -0800, Mike Kravetz wrote:
> On 2/26/19 2:36 PM, Andrew Morton wrote:
...
> >>
> >> +	} else {
> >>  		/*
> >> -		 * per node hstate attribute: adjust count to global,
> >> -		 * but restrict alloc/free to the specified node.
> >> +		 * Node specific request, but we could not allocate
> >> +		 * node mask.  Pass in ALL nodes, and clear nid.
> >>  		 */
> > 
> > Ditto here, somewhat.

# I missed this part when reviewing yesterday for some reason, sorry.

> 
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

Simply returning on allocation failure looks better to me.
As you mentioned below, current behavior for this 'else' case is not
helpful for anyone.

Thanks,
Naoya Horiguchi

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
> -- 
> Mike Kravetz
> 
