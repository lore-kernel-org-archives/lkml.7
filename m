Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22F57C48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 09:03:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1FB220644
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 09:03:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727055AbfFZJDi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 05:03:38 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:40480 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726963AbfFZJDi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 05:03:38 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 51FC098D895276A11E5E;
        Wed, 26 Jun 2019 17:03:36 +0800 (CST)
Received: from [10.151.23.176] (10.151.23.176) by smtp.huawei.com
 (10.3.19.212) with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 26 Jun
 2019 17:02:57 +0800
Subject: Re: [PATCH RESEND] staging: erofs: return the error value if
 fill_inline_data() fails
To:     Yue Hu <zbestahu@gmail.com>, <yuchao0@huawei.com>,
        <gregkh@linuxfoundation.org>
CC:     <linux-erofs@lists.ozlabs.org>, <devel@driverdev.osuosl.org>,
        <linux-kernel@vger.kernel.org>, <huyue2@yulong.com>,
        Miao Xie <miaoxie@huawei.com>
References: <20190626033038.9456-1-zbestahu@gmail.com>
From:   Gao Xiang <gaoxiang25@huawei.com>
Message-ID: <a503962c-0d06-d186-3230-b208410939b0@huawei.com>
Date:   Wed, 26 Jun 2019 17:02:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20190626033038.9456-1-zbestahu@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.151.23.176]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yue,

On 2019/6/26 11:30, Yue Hu wrote:
> From: Yue Hu <huyue2@yulong.com>
> 
> We should consider the error returned by fill_inline_data() when filling
> last page in fill_inode(). If not getting inode will be successful even
> though last page is bad. That is illogical. Also change -EAGAIN to 0 in
> fill_inline_data() to stand for successful filling.
> 
> Signed-off-by: Yue Hu <huyue2@yulong.com>

ditto, add the tags from other guyes.

Thanks,
Gao Xiang

> ---
>  drivers/staging/erofs/inode.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/erofs/inode.c b/drivers/staging/erofs/inode.c
> index d6e1e16..1433f25 100644
> --- a/drivers/staging/erofs/inode.c
> +++ b/drivers/staging/erofs/inode.c
> @@ -156,7 +156,7 @@ static int fill_inline_data(struct inode *inode, void *data,
>  		inode->i_link = lnk;
>  		set_inode_fast_symlink(inode);
>  	}
> -	return -EAGAIN;
> +	return 0;
>  }
>  
>  static int fill_inode(struct inode *inode, int isdir)
> @@ -223,7 +223,7 @@ static int fill_inode(struct inode *inode, int isdir)
>  		inode->i_mapping->a_ops = &erofs_raw_access_aops;
>  
>  		/* fill last page if inline data is available */
> -		fill_inline_data(inode, data, ofs);
> +		err = fill_inline_data(inode, data, ofs);
>  	}
>  
>  out_unlock:
> 
