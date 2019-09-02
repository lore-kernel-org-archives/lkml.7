Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 720E2C3A59E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 10:06:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 473D8217D7
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 10:06:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730522AbfIBKGx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 06:06:53 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:2317 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729741AbfIBKGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 06:06:53 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0Tb8bwnz_1567418808;
Received: from JosephdeMacBook-Pro.local(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0Tb8bwnz_1567418808)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 02 Sep 2019 18:06:49 +0800
Subject: Re: [PATCH][V2] ocfs2: remove deadcode on variable tmp_oh check
To:     Colin King <colin.king@canonical.com>,
        Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>, ocfs2-devel@oss.oracle.com,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190902093434.27739-1-colin.king@canonical.com>
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
Message-ID: <3ea5b370-8373-8ea7-9c2b-49218fcd0fd4@linux.alibaba.com>
Date:   Mon, 2 Sep 2019 18:06:47 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:60.0)
 Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190902093434.27739-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19/9/2 17:34, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> At the end of ocfs2_inode_lock_tracker tmp_oh is true because an
> earlier check on tmp_oh being false returns out of the function.
> Since tmp_oh is true, the function will always return 1 so remove
> the redundant check and return of 0.
> 
> Also update description in comment, return -EINVAL and not -1.
> 
> Addresses-Coverity: ("Logically dead code")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>
> ---
> 
> V2: Fix typo of function name in description.
>     Update description in comment as noted by Joseph Qi
> 
> ---
>  fs/ocfs2/dlmglue.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ocfs2/dlmglue.c b/fs/ocfs2/dlmglue.c
> index ad594fef2ab0..640eee2bb903 100644
> --- a/fs/ocfs2/dlmglue.c
> +++ b/fs/ocfs2/dlmglue.c
> @@ -2626,7 +2626,8 @@ void ocfs2_inode_unlock(struct inode *inode,
>   *
>   * return < 0 on error, return == 0 if there's no lock holder on the stack
>   * before this call, return == 1 if this call would be a recursive locking.
> - * return == -1 if this lock attempt will cause an upgrade which is forbidden.
> + * return == -EINVAL if this lock attempt will cause an upgrade which is
> + * forbidden.
>   *
>   * When taking lock levels into account,we face some different situations.
>   *
> @@ -2712,7 +2713,7 @@ int ocfs2_inode_lock_tracker(struct inode *inode,
>  			return status;
>  		}
>  	}
> -	return tmp_oh ? 1 : 0;
> +	return 1;
>  }
>  
>  void ocfs2_inode_unlock_tracker(struct inode *inode,
> 
