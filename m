Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CDD3C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 14:56:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1DAF22D6D
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 14:56:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729746AbfICO4z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 10:56:55 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:14901 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729083AbfICO4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 10:56:54 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R991e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01422;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0TbGzX5B_1567522590;
Received: from JosephdeMacBook-Pro.local(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0TbGzX5B_1567522590)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 03 Sep 2019 22:56:31 +0800
Subject: Re: [PATCH] ocfs2: Delete unnecessary checks before brelse()
To:     Markus Elfring <Markus.Elfring@web.de>, ocfs2-devel@oss.oracle.com,
        Joel Becker <jlbec@evilplan.org>, Mark Fasheh <mark@fasheh.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Jia-Ju Bai <baijiaju1990@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
References: <55cde320-394b-f985-56ce-1a2abea782aa@web.de>
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
Message-ID: <153d9e24-d79d-1ba6-da5f-824ec9d8070a@linux.alibaba.com>
Date:   Tue, 3 Sep 2019 22:56:30 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:60.0)
 Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <55cde320-394b-f985-56ce-1a2abea782aa@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19/9/3 22:40, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Tue, 3 Sep 2019 16:33:32 +0200
> 
> The brelse() function tests whether its argument is NULL
> and then returns immediately.
> Thus the tests around the shown calls are not needed.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>
> ---
>  fs/ocfs2/dlmglue.c    | 7 ++-----
>  fs/ocfs2/extent_map.c | 3 +--
>  2 files changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/ocfs2/dlmglue.c b/fs/ocfs2/dlmglue.c
> index ad594fef2ab0..6e774c5ea13b 100644
> --- a/fs/ocfs2/dlmglue.c
> +++ b/fs/ocfs2/dlmglue.c
> @@ -2508,9 +2508,7 @@ int ocfs2_inode_lock_full_nested(struct inode *inode,
>  			ocfs2_inode_unlock(inode, ex);
>  	}
> 
> -	if (local_bh)
> -		brelse(local_bh);
> -
> +	brelse(local_bh);
>  	return status;
>  }
> 
> @@ -2593,8 +2591,7 @@ int ocfs2_inode_lock_atime(struct inode *inode,
>  		*level = 1;
>  		if (ocfs2_should_update_atime(inode, vfsmnt))
>  			ocfs2_update_inode_atime(inode, bh);
> -		if (bh)
> -			brelse(bh);
> +		brelse(bh);
>  	} else
>  		*level = 0;
> 
> diff --git a/fs/ocfs2/extent_map.c b/fs/ocfs2/extent_map.c
> index e66a249fe07c..e3e2d1b2af51 100644
> --- a/fs/ocfs2/extent_map.c
> +++ b/fs/ocfs2/extent_map.c
> @@ -590,8 +590,7 @@ int ocfs2_xattr_get_clusters(struct inode *inode, u32 v_cluster,
>  			*extent_flags = rec->e_flags;
>  	}
>  out:
> -	if (eb_bh)
> -		brelse(eb_bh);
> +	brelse(eb_bh);
>  	return ret;
>  }
> 
> --
> 2.23.0
> 
