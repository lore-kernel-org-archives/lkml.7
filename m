Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2199EC0650E
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 01:14:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E871621850
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 01:14:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727395AbfGEBOn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 21:14:43 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:62487 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726024AbfGEBOn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 21:14:43 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0TW2lgUv_1562289279;
Received: from JosephdeMacBook-Pro.local(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0TW2lgUv_1562289279)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 05 Jul 2019 09:14:40 +0800
Subject: Re: [PATCH v2 31/35] ocfs2: Use kmemdup rather than duplicating its
 implementation
To:     Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>,
        ocfs2-devel@oss.oracle.com, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
References: <20190703163147.881-1-huangfq.daxian@gmail.com>
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
Message-ID: <edc1407f-f45c-a6ce-e836-5e93947106bd@linux.alibaba.com>
Date:   Fri, 5 Jul 2019 09:14:39 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:60.0)
 Gecko/20100101 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190703163147.881-1-huangfq.daxian@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19/7/4 00:31, Fuqian Huang wrote:
> kmemdup is introduced to duplicate a region of memory in a neat way.
> Rather than kmalloc/kzalloc + memcpy, which the programmer needs to
> write the size twice (sometimes lead to mistakes), kmemdup improves
> readability, leads to smaller code and also reduce the chances of mistakes.
> Suggestion to use kmemdup rather than using kmalloc/kzalloc + memcpy.
> 
> Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>

Looks good.
Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>

> ---
> Changes in v2:
>   - Fix a typo in commit message (memset -> memcpy)
> 
>  fs/ocfs2/alloc.c      | 8 +++-----
>  fs/ocfs2/localalloc.c | 6 ++----
>  2 files changed, 5 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/ocfs2/alloc.c b/fs/ocfs2/alloc.c
> index d1348fc4ca6d..d4911d70c326 100644
> --- a/fs/ocfs2/alloc.c
> +++ b/fs/ocfs2/alloc.c
> @@ -6191,17 +6191,15 @@ int ocfs2_begin_truncate_log_recovery(struct ocfs2_super *osb,
>  	if (le16_to_cpu(tl->tl_used)) {
>  		trace_ocfs2_truncate_log_recovery_num(le16_to_cpu(tl->tl_used));
>  
> -		*tl_copy = kmalloc(tl_bh->b_size, GFP_KERNEL);
> +		/* Assuming the write-out below goes well, this copy
> +		 * will be passed back to recovery for processing. */
> +		*tl_copy = kmemdup(tl_bh->b_data, tl_bh->b_size, GFP_KERNEL);
>  		if (!(*tl_copy)) {
>  			status = -ENOMEM;
>  			mlog_errno(status);
>  			goto bail;
>  		}
>  
> -		/* Assuming the write-out below goes well, this copy
> -		 * will be passed back to recovery for processing. */
> -		memcpy(*tl_copy, tl_bh->b_data, tl_bh->b_size);
> -
>  		/* All we need to do to clear the truncate log is set
>  		 * tl_used. */
>  		tl->tl_used = 0;
> diff --git a/fs/ocfs2/localalloc.c b/fs/ocfs2/localalloc.c
> index f03674afbd30..158e5af767fd 100644
> --- a/fs/ocfs2/localalloc.c
> +++ b/fs/ocfs2/localalloc.c
> @@ -424,12 +424,11 @@ void ocfs2_shutdown_local_alloc(struct ocfs2_super *osb)
>  	bh = osb->local_alloc_bh;
>  	alloc = (struct ocfs2_dinode *) bh->b_data;
>  
> -	alloc_copy = kmalloc(bh->b_size, GFP_NOFS);
> +	alloc_copy = kmemdup(alloc, bh->b_size, GFP_NOFS);
>  	if (!alloc_copy) {
>  		status = -ENOMEM;
>  		goto out_commit;
>  	}
> -	memcpy(alloc_copy, alloc, bh->b_size);
>  
>  	status = ocfs2_journal_access_di(handle, INODE_CACHE(local_alloc_inode),
>  					 bh, OCFS2_JOURNAL_ACCESS_WRITE);
> @@ -1272,13 +1271,12 @@ static int ocfs2_local_alloc_slide_window(struct ocfs2_super *osb,
>  	 * local alloc shutdown won't try to double free main bitmap
>  	 * bits. Make a copy so the sync function knows which bits to
>  	 * free. */
> -	alloc_copy = kmalloc(osb->local_alloc_bh->b_size, GFP_NOFS);
> +	alloc_copy = kmemdup(alloc, osb->local_alloc_bh->b_size, GFP_NOFS);
>  	if (!alloc_copy) {
>  		status = -ENOMEM;
>  		mlog_errno(status);
>  		goto bail;
>  	}
> -	memcpy(alloc_copy, alloc, osb->local_alloc_bh->b_size);
>  
>  	status = ocfs2_journal_access_di(handle,
>  					 INODE_CACHE(local_alloc_inode),
> 
