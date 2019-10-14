Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28546ECE587
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 09:12:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F05FC20854
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 09:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571044368;
	bh=Lk/P8XMouIXUljGjzkFNXunhbSH4Zc3ZxMvXEYiBSs8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=nIxfQbEhZ/f78ETPMCcDm5RoN2Llaon/OF85Zrq5lIT2mMnbm6/Ee22kLASRpA6Rx
	 QPSKeVRYO+Df9VXHV82GKtgXWvhYKmvhufPqGw34h1rZH+Vw4/7VCisIy/r7b7o02m
	 CVqGEG41JlyCYbr6Bx51EYWp/NNf+pW4mfx+FLQ0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730720AbfJNJMq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 05:12:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:38106 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730656AbfJNJMq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 05:12:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 716A7B8EF;
        Mon, 14 Oct 2019 09:12:44 +0000 (UTC)
Date:   Mon, 14 Oct 2019 11:12:43 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Pan Zhang <zhangpan26@huawei.com>
Cc:     akpm@linux-foundation.org, vbabka@suse.cz, rientjes@google.com,
        jgg@ziepe.ca, aarcange@redhat.com, yang.shi@linux.alibaba.com,
        zhongjiang@huawei.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Cristopher Lameter <cl@linux.com>
Subject: Re: [PATCH] mm: mempolicy: fix the absence of the last bit of
 nodemask
Message-ID: <20191014091243.GD317@dhcp22.suse.cz>
References: <1570882789-20579-1-git-send-email-zhangpan26@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1570882789-20579-1-git-send-email-zhangpan26@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Cc Christopher - th initial emails is http://lkml.kernel.org/r/1570882789-20579-1-git-send-email-zhangpan26@huawei.com]

On Sat 12-10-19 20:19:48, Pan Zhang wrote:
>     When I want to use set_mempolicy to get the memory from each node on the numa machine,
>     and the MPOL_INTERLEAVE flag seems to achieve this goal.
>     However, during the test, it was found that the use result of node was unbalanced.
>     The memory was allocated evenly from the nodes except the last node,
>     which obviously did not match the expectations.
> 
>     You can test as follows:
> 1.  Create a file that needs to be mmap ped:
>     dd if=/dev/zero of=./test count=1024 bs=1M

This will already poppulate the page cache and if it fits into memory
(which seems to be the case in your example output) then your mmap later
will not allocate any new memory.

I suspect that using numactl --interleave 0,1 dd if=/dev/zero of=./test count=1024 bs=1M

will produce an output much closer to your expectation. Right?

[...]
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index 4ae967b..a23509f 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -1328,9 +1328,11 @@ static int get_nodes(nodemask_t *nodes, const unsigned long __user *nmask,
>  	unsigned long nlongs;
>  	unsigned long endmask;
>  
> -	--maxnode;
>  	nodes_clear(*nodes);
> -	if (maxnode == 0 || !nmask)
> +	/*
> +	 * If the user specified only one node, no need to set nodemask
> +	 */
> +	if (maxnode - 1 == 0 || !nmask)
>  		return 0;
>  	if (maxnode > PAGE_SIZE*BITS_PER_BYTE)
>  		return -EINVAL;

I am afraid this is a wrong fix. It is really hard to grasp the code but my
understanding is that the caller is supposed to provide maxnode larger
than than the nodemask. So if you want 2 nodes then maxnode should be 3.
Have a look at the libnuma (which is a reference implementation)

static void setpol(int policy, struct bitmask *bmp)
{
	if (set_mempolicy(policy, bmp->maskp, bmp->size + 1) < 0)
		numa_error("set_mempolicy");
}

The semantic is quite awkward but it is that way for years.
-- 
Michal Hocko
SUSE Labs
