Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30B3EC3A5A4
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 02:06:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 089822184D
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 02:06:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729213AbfIBCGq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Sep 2019 22:06:46 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:60508 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727517AbfIBCGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Sep 2019 22:06:45 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04391;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0Tb34iG4_1567390001;
Received: from JosephdeMacBook-Pro.local(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0Tb34iG4_1567390001)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 02 Sep 2019 10:06:42 +0800
Subject: Re: [PATCH] ocfs2: remove deadcode on variable tmp_oh check
To:     Colin King <colin.king@canonical.com>,
        Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>, ocfs2-devel@oss.oracle.com,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190830111621.8929-1-colin.king@canonical.com>
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
Message-ID: <37278619-3d48-4287-28d2-c5bc5af1d90f@linux.alibaba.com>
Date:   Mon, 2 Sep 2019 10:06:41 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:60.0)
 Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190830111621.8929-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19/8/30 19:16, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> At the end of cfs2_inode_lock_tracker tmp_oh is true because an

s/cfs2_inode_lock_tracker/ocfs2_inode_lock_tracker/
BTW, could you please correct the following description of this
function as well?
"return == -1 if this lock attempt will cause an upgrade which is forbidden."
In fact, it returns -EINVAL.

Thanks,
Joseph

> earlier check on tmp_oh being false returns out of the function.
> Since tmp_oh is true, the function will always return 1 so remove
> the redundant check and return of 0.
> 
> Addresses-Coverity: ("Logically dead code")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  fs/ocfs2/dlmglue.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ocfs2/dlmglue.c b/fs/ocfs2/dlmglue.c
> index ad594fef2ab0..ff0cf851c9e6 100644
> --- a/fs/ocfs2/dlmglue.c
> +++ b/fs/ocfs2/dlmglue.c
> @@ -2712,7 +2712,7 @@ int ocfs2_inode_lock_tracker(struct inode *inode,
>  			return status;
>  		}
>  	}
> -	return tmp_oh ? 1 : 0;
> +	return 1;
>  }
>  
>  void ocfs2_inode_unlock_tracker(struct inode *inode,
> 
