Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A171FC4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 03:50:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E1D3208CB
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 03:50:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727149AbfF1Dun (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 23:50:43 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:19088 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726748AbfF1Dun (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 23:50:43 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 7CB03DD74085E2E76CE9;
        Fri, 28 Jun 2019 11:50:40 +0800 (CST)
Received: from [10.151.23.176] (10.151.23.176) by smtp.huawei.com
 (10.3.19.206) with Microsoft SMTP Server (TLS) id 14.3.439.0; Fri, 28 Jun
 2019 11:50:30 +0800
Subject: Re: [PATCH] staging: erofs: don't check special inode layout
To:     Yue Hu <zbestahu@gmail.com>, <yuchao0@huawei.com>,
        <gregkh@linuxfoundation.org>
CC:     <linux-erofs@lists.ozlabs.org>, <devel@driverdev.osuosl.org>,
        <linux-kernel@vger.kernel.org>, <huyue2@yulong.com>,
        Miao Xie <miaoxie@huawei.com>
References: <20190628034234.8832-1-zbestahu@gmail.com>
From:   Gao Xiang <gaoxiang25@huawei.com>
Message-ID: <276837dc-b18a-6f20-fc33-d988dff5ae9f@huawei.com>
Date:   Fri, 28 Jun 2019 11:50:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20190628034234.8832-1-zbestahu@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.151.23.176]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yue,

On 2019/6/28 11:42, Yue Hu wrote:
> From: Yue Hu <huyue2@yulong.com>
> 
> Currently, we will check if inode layout is compression or inline if
> the inode is special in fill_inode(). Also set ->i_mapping->a_ops for
> it. That is pointless since the both modes won't be set for special
> inode when creating EROFS filesystem image. So, let's avoid it.
> 
> Signed-off-by: Yue Hu <huyue2@yulong.com>

Have you test this patch with some actual image with legacy mkfs since
new mkfs framework have not supported special inode...

I think that is fine in priciple, however, in case to introduce some potential
issues, I will test this patch later. I will give a Reviewed-by tag after I tested
this patch.

Thanks,
Gao Xiang

> ---
>  drivers/staging/erofs/inode.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/staging/erofs/inode.c b/drivers/staging/erofs/inode.c
> index 1433f25..2fe0f6d 100644
> --- a/drivers/staging/erofs/inode.c
> +++ b/drivers/staging/erofs/inode.c
> @@ -205,6 +205,7 @@ static int fill_inode(struct inode *inode, int isdir)
>  			S_ISFIFO(inode->i_mode) || S_ISSOCK(inode->i_mode)) {
>  			inode->i_op = &erofs_generic_iops;
>  			init_special_inode(inode, inode->i_mode, inode->i_rdev);
> +			goto out_unlock;
>  		} else {
>  			err = -EIO;
>  			goto out_unlock;
> 
