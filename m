Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02080C7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 09:39:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0E85229F9
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 09:39:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726180AbfGZJjl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 05:39:41 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:42905 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725903AbfGZJjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 05:39:41 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R841e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07486;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0TXq-pnk_1564133977;
Received: from JosephdeMacBook-Pro.local(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0TXq-pnk_1564133977)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 26 Jul 2019 17:39:38 +0800
Subject: Re: [PATCH 3/3] fs: ocfs2: Fix a possible null-pointer dereference in
 ocfs2_info_scan_inode_alloc()
To:     Jia-Ju Bai <baijiaju1990@gmail.com>, mark@fasheh.com,
        jlbec@evilplan.org
Cc:     ocfs2-devel@oss.oracle.com, linux-kernel@vger.kernel.org
References: <20190726033717.32359-1-baijiaju1990@gmail.com>
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
Message-ID: <3db34626-a87f-9de8-6f9c-e4a35f863cd6@linux.alibaba.com>
Date:   Fri, 26 Jul 2019 17:39:37 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:60.0)
 Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190726033717.32359-1-baijiaju1990@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19/7/26 11:37, Jia-Ju Bai wrote:
> In ocfs2_info_scan_inode_alloc(), there is an if statement on line 283
> to check whether inode_alloc is NULL:
>     if (inode_alloc)
> 
> When inode_alloc is NULL, it is used on line 287:
>     ocfs2_inode_lock(inode_alloc, &bh, 0);
>         ocfs2_inode_lock_full_nested(inode, ...)
>             struct ocfs2_super *osb = OCFS2_SB(inode->i_sb);
> 
> Thus, a possible null-pointer dereference may occur.
> 
> To fix this bug, inode_alloc is checked on line 286.
> 
> This bug is found by a static analysis tool STCheck written by us.       
> 
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>

Looks good.
Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>
> ---
>  fs/ocfs2/ioctl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ocfs2/ioctl.c b/fs/ocfs2/ioctl.c
> index d6f7b299eb23..efeea208fdeb 100644
> --- a/fs/ocfs2/ioctl.c
> +++ b/fs/ocfs2/ioctl.c
> @@ -283,7 +283,7 @@ static int ocfs2_info_scan_inode_alloc(struct ocfs2_super *osb,
>  	if (inode_alloc)
>  		inode_lock(inode_alloc);
>  
> -	if (o2info_coherent(&fi->ifi_req)) {
> +	if (inode_alloc && o2info_coherent(&fi->ifi_req)) {
>  		status = ocfs2_inode_lock(inode_alloc, &bh, 0);
>  		if (status < 0) {
>  			mlog_errno(status);
> 
