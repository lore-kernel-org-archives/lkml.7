Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAF57C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 09:26:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94655218A2
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 09:26:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728079AbfCUJ05 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 05:26:57 -0400
Received: from relay.sw.ru ([185.231.240.75]:41488 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727903AbfCUJ04 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 05:26:56 -0400
Received: from [172.16.25.169]
        by relay.sw.ru with esmtp (Exim 4.91)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1h6tyM-0004BL-Rv; Thu, 21 Mar 2019 12:26:50 +0300
Subject: Re: [PATCH] genetlink: Fix a memory leak on error path
To:     Yue Haibing <yuehaibing@huawei.com>, davem@davemloft.net,
        keescook@chromium.org
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20190321070250.20128-1-yuehaibing@huawei.com>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <3b722948-bbca-327e-d5c9-989f0d78cf6c@virtuozzo.com>
Date:   Thu, 21 Mar 2019 12:26:50 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190321070250.20128-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.03.2019 10:02, Yue Haibing wrote:
> From: YueHaibing <yuehaibing@huawei.com>
> 
> In genl_register_family(), when idr_alloc() fails,
> we forget to free the memory we possibly allocate for
> family->attrbuf.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Fixes: 2ae0f17df1cd ("genetlink: use idr to track families")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Reviewed-by: Kirill Tkhai <ktkhai@virtuozzo.com>

> ---
>  net/netlink/genetlink.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/net/netlink/genetlink.c b/net/netlink/genetlink.c
> index 25eeb6d..f0ec068 100644
> --- a/net/netlink/genetlink.c
> +++ b/net/netlink/genetlink.c
> @@ -366,7 +366,7 @@ int genl_register_family(struct genl_family *family)
>  			       start, end + 1, GFP_KERNEL);
>  	if (family->id < 0) {
>  		err = family->id;
> -		goto errout_locked;
> +		goto errout_free;
>  	}
>  
>  	err = genl_validate_assign_mc_groups(family);
> @@ -385,6 +385,7 @@ int genl_register_family(struct genl_family *family)
>  
>  errout_remove:
>  	idr_remove(&genl_fam_idr, family->id);
> +errout_free:
>  	kfree(family->attrbuf);
>  errout_locked:
>  	genl_unlock_all();
> 
