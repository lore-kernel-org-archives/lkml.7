Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 161E7C7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 09:47:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7B4822CED
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 09:47:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbfGZJrv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 05:47:51 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:2979 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725815AbfGZJrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 05:47:51 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01422;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0TXqO63E_1564133850;
Received: from JosephdeMacBook-Pro.local(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0TXqO63E_1564133850)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 26 Jul 2019 17:37:30 +0800
Subject: Re: [PATCH 1/3] fs: ocfs2: Fix possible null-pointer dereferences in
 ocfs2_xa_prepare_entry()
To:     Jia-Ju Bai <baijiaju1990@gmail.com>, mark@fasheh.com,
        jlbec@evilplan.org
Cc:     ocfs2-devel@oss.oracle.com, linux-kernel@vger.kernel.org
References: <20190726033655.32253-1-baijiaju1990@gmail.com>
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
Message-ID: <b6aef7d8-9884-7349-bcec-0c8654d1b062@linux.alibaba.com>
Date:   Fri, 26 Jul 2019 17:37:30 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:60.0)
 Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190726033655.32253-1-baijiaju1990@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19/7/26 11:36, Jia-Ju Bai wrote:
> In ocfs2_xa_prepare_entry(), there is an if statement on line 2136 to
> check whether loc->xl_entry is NULL:
>     if (loc->xl_entry)
> 
> When loc->xl_entry is NULL, it is used on line 2158:
>     ocfs2_xa_add_entry(loc, name_hash);
>         loc->xl_entry->xe_name_hash = cpu_to_le32(name_hash);
>         loc->xl_entry->xe_name_offset = cpu_to_le16(loc->xl_size);
> and line 2164:
> 	ocfs2_xa_add_namevalue(loc, xi);
>         loc->xl_entry->xe_value_size = cpu_to_le64(xi->xi_value_len);
>         loc->xl_entry->xe_name_len = xi->xi_name_len;
> 
> Thus, possible null-pointer dereferences may occur.
> 
> To fix these bugs, if loc-xl_entry is NULL, ocfs2_xa_prepare_entry() 
> abnormally returns with -EINVAL.
> 
> These bugs are found by a static analysis tool STCheck written by us.
> 
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
> ---
>  fs/ocfs2/xattr.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ocfs2/xattr.c b/fs/ocfs2/xattr.c
> index 385f3aaa2448..f690502daf3c 100644
> --- a/fs/ocfs2/xattr.c
> +++ b/fs/ocfs2/xattr.c
> @@ -2154,8 +2154,10 @@ static int ocfs2_xa_prepare_entry(struct ocfs2_xa_loc *loc,
>  			}
>  		}
>  		ocfs2_xa_wipe_namevalue(loc);
> -	} else
> -		ocfs2_xa_add_entry(loc, name_hash);
> +	} else {
> +		rc = -EINVAL;
> +		goto out;
> +	}

Since entry not found, so there is nothing to do in
ocfs2_xa_prepare_entry(). We may change it like:

if (!loc->xl_entry) {
	rc = -EINVAL;
	goto out;
}	

if (ocfs2_xa_can_reuse_entry(loc, xi)) {
	......
}
.....


Thanks,
Joseph
>  
>  	/*
>  	 * If we get here, we have a blank entry.  Fill it.  We grow our
> 
