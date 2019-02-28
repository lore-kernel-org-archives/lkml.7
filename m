Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90091C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 13:48:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 679C720830
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 13:48:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731378AbfB1Nr6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 08:47:58 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:4186 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731009AbfB1Nr6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 08:47:58 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 41A53B7BAD661069E165;
        Thu, 28 Feb 2019 21:47:55 +0800 (CST)
Received: from [127.0.0.1] (10.177.31.96) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.408.0; Thu, 28 Feb 2019
 21:47:51 +0800
Subject: Re: [PATCH v2 -next] appletalk: use remove_proc_subtree to simplify
 procfs code
To:     <davem@davemloft.net>, <joe@perches.com>,
        <gregkh@linuxfoundation.org>
References: <20190228013158.7972-1-yuehaibing@huawei.com>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
From:   YueHaibing <yuehaibing@huawei.com>
Message-ID: <c0bf4928-9dbe-ebfb-d09b-8f8941f33f81@huawei.com>
Date:   Thu, 28 Feb 2019 21:47:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20190228013158.7972-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pls igore this, will resend a new serials with another patch.

On 2019/2/28 9:31, Yue Haibing wrote:
> From: YueHaibing <yuehaibing@huawei.com>
> 
> Use remove_proc_subtree to remove the whole subtree
> on cleanup.Also do some cleanup.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  net/appletalk/atalk_proc.c | 56 ++++++++++++++--------------------------------
>  1 file changed, 17 insertions(+), 39 deletions(-)
> 
> diff --git a/net/appletalk/atalk_proc.c b/net/appletalk/atalk_proc.c
> index 8006295..398b767 100644
> --- a/net/appletalk/atalk_proc.c
> +++ b/net/appletalk/atalk_proc.c
> @@ -210,56 +210,34 @@ static const struct seq_operations atalk_seq_socket_ops = {
>  	.show   = atalk_seq_socket_show,
>  };
>  
> -static struct proc_dir_entry *atalk_proc_dir;
> -
>  int __init atalk_proc_init(void)
>  {
> -	struct proc_dir_entry *p;
> -	int rc = -ENOMEM;
> +	if (!proc_mkdir("atalk", init_net.proc_net))
> +		return -ENOMEM;
>  
> -	atalk_proc_dir = proc_mkdir("atalk", init_net.proc_net);
> -	if (!atalk_proc_dir)
> +	if (!proc_create_seq("atalk/interface", 0444, init_net.proc_net,
> +			    &atalk_seq_interface_ops))
>  		goto out;
>  
> -	p = proc_create_seq("interface", 0444, atalk_proc_dir,
> -			&atalk_seq_interface_ops);
> -	if (!p)
> -		goto out_interface;
> -
> -	p = proc_create_seq("route", 0444, atalk_proc_dir,
> -			&atalk_seq_route_ops);
> -	if (!p)
> -		goto out_route;
> +	if (!proc_create_seq("atalk/route", 0444, init_net.proc_net,
> +			    &atalk_seq_route_ops))
> +		goto out;
>  
> -	p = proc_create_seq("socket", 0444, atalk_proc_dir,
> -			&atalk_seq_socket_ops);
> -	if (!p)
> -		goto out_socket;
> +	if (!proc_create_seq("atalk/socket", 0444, init_net.proc_net,
> +			    &atalk_seq_socket_ops))
> +		goto out;
>  
> -	p = proc_create_seq_private("arp", 0444, atalk_proc_dir, &aarp_seq_ops,
> -			sizeof(struct aarp_iter_state), NULL);
> -	if (!p)
> -		goto out_arp;
> +	if (!proc_create_seq_private("atalk/arp", 0444, init_net.proc_net,
> +				     &aarp_seq_ops,
> +				     sizeof(struct aarp_iter_state), NULL))
> +		goto out;
>  
> -	rc = 0;
>  out:
> -	return rc;
> -out_arp:
> -	remove_proc_entry("socket", atalk_proc_dir);
> -out_socket:
> -	remove_proc_entry("route", atalk_proc_dir);
> -out_route:
> -	remove_proc_entry("interface", atalk_proc_dir);
> -out_interface:
> -	remove_proc_entry("atalk", init_net.proc_net);
> -	goto out;
> +	remove_proc_subtree("atalk", init_net.proc_net);
> +	return -ENOMEM;
>  }
>  
>  void __exit atalk_proc_exit(void)
>  {
> -	remove_proc_entry("interface", atalk_proc_dir);
> -	remove_proc_entry("route", atalk_proc_dir);
> -	remove_proc_entry("socket", atalk_proc_dir);
> -	remove_proc_entry("arp", atalk_proc_dir);
> -	remove_proc_entry("atalk", init_net.proc_net);
> +	remove_proc_subtree("atalk", init_net.proc_net);
>  }
> 

