Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2275C48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 09:02:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7C03205ED
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 09:02:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbfFZJC2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 05:02:28 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:60818 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726077AbfFZJC2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 05:02:28 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 0E69C55CB5DA6BC2821E;
        Wed, 26 Jun 2019 17:02:23 +0800 (CST)
Received: from [10.151.23.176] (10.151.23.176) by smtp.huawei.com
 (10.3.19.208) with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 26 Jun
 2019 17:02:17 +0800
Subject: Re: [PATCH RESEND] staging: erofs: remove unsupported ->datamode
 check in fill_inline_data()
To:     Yue Hu <zbestahu@gmail.com>
CC:     <yuchao0@huawei.com>, <gregkh@linuxfoundation.org>,
        <linux-erofs@lists.ozlabs.org>, <devel@driverdev.osuosl.org>,
        <linux-kernel@vger.kernel.org>, <huyue2@yulong.com>
References: <20190626032831.7252-1-zbestahu@gmail.com>
From:   Gao Xiang <gaoxiang25@huawei.com>
Message-ID: <038b00d7-fa67-fa86-1b74-b3f58a3788f6@huawei.com>
Date:   Wed, 26 Jun 2019 17:02:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20190626032831.7252-1-zbestahu@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.151.23.176]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yue,

On 2019/6/26 11:28, Yue Hu wrote:
> From: Yue Hu <huyue2@yulong.com>
> 
> Already check if ->datamode is supported in read_inode(), no need to check
> again in the next fill_inline_data() only called by fill_inode().
> 
> Signed-off-by: Yue Hu <huyue2@yulong.com>

You should add all the 'Reviewed-by' / 'Acked-by' / ... tags from other guyes
to the following versions when you resend your patches.

Thanks,
Gao Xiang

> ---
>  drivers/staging/erofs/inode.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/staging/erofs/inode.c b/drivers/staging/erofs/inode.c
> index e51348f..d6e1e16 100644
> --- a/drivers/staging/erofs/inode.c
> +++ b/drivers/staging/erofs/inode.c
> @@ -129,8 +129,6 @@ static int fill_inline_data(struct inode *inode, void *data,
>  	struct erofs_sb_info *sbi = EROFS_I_SB(inode);
>  	const int mode = vi->datamode;
>  
> -	DBG_BUGON(mode >= EROFS_INODE_LAYOUT_MAX);
> -
>  	/* should be inode inline C */
>  	if (mode != EROFS_INODE_LAYOUT_INLINE)
>  		return 0;
> 
