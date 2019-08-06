Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5EF1C31E40
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 10:58:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9832C216B7
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 10:58:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732671AbfHFK61 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 06:58:27 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:5385 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730877AbfHFK61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 06:58:27 -0400
X-IronPort-AV: E=Sophos;i="5.64,353,1559520000"; 
   d="scan'208";a="691286792"
Received: from sea3-co-svc-lb6-vlan2.sea.amazon.com (HELO email-inbound-relay-2b-4ff6265a.us-west-2.amazon.com) ([10.47.22.34])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 06 Aug 2019 10:58:23 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2b-4ff6265a.us-west-2.amazon.com (Postfix) with ESMTPS id 6EC1FA27C0;
        Tue,  6 Aug 2019 10:58:23 +0000 (UTC)
Received: from EX13D16UEA003.ant.amazon.com (10.43.61.183) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 6 Aug 2019 10:58:23 +0000
Received: from EX13MTAUEA001.ant.amazon.com (10.43.61.82) by
 EX13D16UEA003.ant.amazon.com (10.43.61.183) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 6 Aug 2019 10:58:22 +0000
Received: from localhost (172.23.204.141) by mail-relay.amazon.com
 (10.43.61.243) with Microsoft SMTP Server id 15.0.1367.3 via Frontend
 Transport; Tue, 6 Aug 2019 10:58:22 +0000
Date:   Tue, 6 Aug 2019 10:58:22 +0000
From:   Balbir Singh <sblbir@amzn.com>
To:     Wei Yang <richardw.yang@linux.intel.com>
CC:     <akpm@linux-foundation.org>, <mhocko@suse.com>, <vbabka@suse.cz>,
        <kirill.shutemov@linux.intel.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm/mmap.c: refine data locality of find_vma_prev
Message-ID: <20190806105822.GA25354@dev-dsk-sblbir-2a-88e651b2.us-west-2.amazon.com>
References: <20190806081123.22334-1-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190806081123.22334-1-richardw.yang@linux.intel.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 06, 2019 at 04:11:23PM +0800, Wei Yang wrote:
> When addr is out of the range of the whole rb_tree, pprev will points to
> the biggest node. find_vma_prev gets is by going through the right most
> node of the tree.
> 
> Since only the last node is the one it is looking for, it is not
> necessary to assign pprev to those middle stage nodes. By assigning
> pprev to the last node directly, it tries to improve the function
> locality a little.
> 
> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
> ---
>  mm/mmap.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 7e8c3e8ae75f..284bc7e51f9c 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -2271,11 +2271,10 @@ find_vma_prev(struct mm_struct *mm, unsigned long addr,
>  		*pprev = vma->vm_prev;
>  	} else {
>  		struct rb_node *rb_node = mm->mm_rb.rb_node;
> -		*pprev = NULL;
> -		while (rb_node) {
> -			*pprev = rb_entry(rb_node, struct vm_area_struct, vm_rb);
> +		while (rb_node && rb_node->rb_right)
>  			rb_node = rb_node->rb_right;
> -		}
> +		*pprev = rb_node ? NULL
> +			 : rb_entry(rb_node, struct vm_area_struct, vm_rb);

Can rb_node ever be NULL? assuming mm->mm_rb.rb_node is not NULL when we
enter here

Balbir Singh

