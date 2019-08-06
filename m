Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93448C433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 09:29:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 700962147A
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 09:29:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732470AbfHFJ3y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 05:29:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:46788 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726713AbfHFJ3x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 05:29:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DB23AAE6F;
        Tue,  6 Aug 2019 09:29:52 +0000 (UTC)
Subject: Re: [PATCH] mm/mmap.c: refine data locality of find_vma_prev
To:     Wei Yang <richardw.yang@linux.intel.com>,
        akpm@linux-foundation.org, mhocko@suse.com,
        kirill.shutemov@linux.intel.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20190806081123.22334-1-richardw.yang@linux.intel.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <3e57ba64-732b-d5be-1ad6-eecc731ef405@suse.cz>
Date:   Tue, 6 Aug 2019 11:29:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190806081123.22334-1-richardw.yang@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/6/19 10:11 AM, Wei Yang wrote:
> When addr is out of the range of the whole rb_tree, pprev will points to
> the biggest node. find_vma_prev gets is by going through the right most

s/biggest/last/ ? or right-most?

> node of the tree.
> 
> Since only the last node is the one it is looking for, it is not
> necessary to assign pprev to those middle stage nodes. By assigning
> pprev to the last node directly, it tries to improve the function
> locality a little.

In the end, it will always write to the cacheline of pprev. The caller has most
likely have it on stack, so it's already hot, and there's no other CPU stealing
it. So I don't understand where the improved locality comes from. The compiler
can also optimize the patched code so the assembly is identical to the previous
code, or vice versa. Did you check for differences?

The previous code is somewhat more obvious to me, so unless I'm missing
something, readability and less churn suggests to not change.

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
>  	}
>  	return vma;
>  }
> 

