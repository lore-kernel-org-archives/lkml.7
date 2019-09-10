Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61B5DC3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 06:45:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FB9320872
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 06:45:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404269AbfIJGpR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 02:45:17 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:40381 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729634AbfIJGpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 02:45:17 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0TbzFNKA_1568097903;
Received: from JosephdeMacBook-Pro.local(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0TbzFNKA_1568097903)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 10 Sep 2019 14:45:03 +0800
Subject: Re: [PATCH] ocfs2: Fix passing zero to 'PTR_ERR' warning
To:     Ding Xiang <dingxiang@cmss.chinamobile.com>, mark@fasheh.com,
        jlbec@evilplan.org, Andrew Morton <akpm@linux-foundation.org>
Cc:     ocfs2-devel@oss.oracle.com, linux-kernel@vger.kernel.org
References: <1568023466-1486-1-git-send-email-dingxiang@cmss.chinamobile.com>
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
Message-ID: <1dee278b-6c96-eec2-ce76-fe6e07c6e20f@linux.alibaba.com>
Date:   Tue, 10 Sep 2019 14:45:03 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:60.0)
 Gecko/20100101 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1568023466-1486-1-git-send-email-dingxiang@cmss.chinamobile.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 19/9/9 18:04, Ding Xiang wrote:
> Fix a static code checker warning:
> fs/ocfs2/acl.c:331
> 	ocfs2_acl_chmod() warn: passing zero to 'PTR_ERR'
> 
> Fixes: 5ee0fbd50fd ("ocfs2: revert using ocfs2_acl_chmod to avoid inode cluster lock hang")
> Signed-off-by: Ding Xiang <dingxiang@cmss.chinamobile.com>

Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>
> ---
>  fs/ocfs2/acl.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ocfs2/acl.c b/fs/ocfs2/acl.c
> index 3e7da39..bb981ec 100644
> --- a/fs/ocfs2/acl.c
> +++ b/fs/ocfs2/acl.c
> @@ -327,8 +327,8 @@ int ocfs2_acl_chmod(struct inode *inode, struct buffer_head *bh)
>  	down_read(&OCFS2_I(inode)->ip_xattr_sem);
>  	acl = ocfs2_get_acl_nolock(inode, ACL_TYPE_ACCESS, bh);
>  	up_read(&OCFS2_I(inode)->ip_xattr_sem);
> -	if (IS_ERR(acl) || !acl)
> -		return PTR_ERR(acl);
> +	if (IS_ERR_OR_NULL(acl))
> +		return PTR_ERR_OR_ZERO(acl);
>  	ret = __posix_acl_chmod(&acl, GFP_KERNEL, inode->i_mode);
>  	if (ret)
>  		return ret;
> 
