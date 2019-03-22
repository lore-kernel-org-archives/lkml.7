Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82D2DC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:04:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E1712075C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:04:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728121AbfCVLEA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:04:00 -0400
Received: from relay.sw.ru ([185.231.240.75]:34636 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727713AbfCVLD7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:03:59 -0400
Received: from [172.16.25.169]
        by relay.sw.ru with esmtp (Exim 4.91)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1h7Hxq-0000lf-FV; Fri, 22 Mar 2019 14:03:54 +0300
Subject: Re: [PATCH net] netlink: fix a memory leak on error path
To:     Chengguang Xu <cgxu519@gmx.com>, davem@davemloft.net
Cc:     keescook@chromium.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190322105845.25046-1-cgxu519@gmx.com>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <2acfd376-7b25-5eeb-2770-413b880bd4d9@virtuozzo.com>
Date:   Fri, 22 Mar 2019 14:03:53 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190322105845.25046-1-cgxu519@gmx.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Chengguang,

On 22.03.2019 13:58, Chengguang Xu wrote:
> In genl_register_family(), when idr_alloc() fails,
> we forget to free family->attrbuf.
> 
> Note, some callers call genl_unregister_family() to clean up
> on error path, it doesn't work because the family is inserted
> to the global list in the nearly last step.
> 
> Fixes: 2ae0f17df1c ("genetlink: use idr to track families").
> Signed-off-by: Chengguang Xu <cgxu519@gmx.com>

have you seen https://patchwork.ozlabs.org/patch/1059834/ ?

Kirill
> ---
>  net/netlink/genetlink.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/net/netlink/genetlink.c b/net/netlink/genetlink.c
> index 25eeb6d2a75a..f0ec068e1d02 100644
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
> --
> 2.20.1
> 
