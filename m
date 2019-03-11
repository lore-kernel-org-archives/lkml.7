Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20606C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 01:46:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBC8D207E0
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 01:46:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbfCKBqA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 21:46:00 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4663 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726687AbfCKBqA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 21:46:00 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id D3B70222B6386507C390;
        Mon, 11 Mar 2019 09:45:54 +0800 (CST)
Received: from [127.0.0.1] (10.177.31.96) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.408.0; Mon, 11 Mar 2019
 09:45:48 +0800
Subject: Re: [PATCH v2] appletalk: Correctly check return value of
 register_snap_client
To:     <davem@davemloft.net>, <joe@perches.com>,
        <gregkh@linuxfoundation.org>
References: <20190307022216.22464-1-yuehaibing@huawei.com>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
From:   YueHaibing <yuehaibing@huawei.com>
Message-ID: <9c5dfaa3-074d-5056-2d34-2de639f300cc@huawei.com>
Date:   Mon, 11 Mar 2019 09:45:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20190307022216.22464-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

Is there something need do for this patch? Pls let me know.

I saw the patchwork status labled to  'Not Applicable'

https://patchwork.ozlabs.org/patch/1052624/


On 2019/3/7 10:22, Yue Haibing wrote:
> From: YueHaibing <yuehaibing@huawei.com>
> 
> register_snap_client may return NULL, all the callers
> check it, but only print a warning. This will result in
> NULL pointer dereference in unregister_snap_client and other
> places.
> 
> It has always been used like this since v2.6
> 
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
> v2: fix aarp_dl leak
> ---
>  include/linux/atalk.h |  2 +-
>  net/appletalk/aarp.c  | 13 ++++++++++---
>  net/appletalk/ddp.c   | 20 ++++++++++++--------
>  3 files changed, 23 insertions(+), 12 deletions(-)
> 
> diff --git a/include/linux/atalk.h b/include/linux/atalk.h
> index 5a90f28..0e5265a 100644
> --- a/include/linux/atalk.h
> +++ b/include/linux/atalk.h
> @@ -108,7 +108,7 @@ static __inline__ struct elapaarp *aarp_hdr(struct sk_buff *skb)
>  #define AARP_RESOLVE_TIME	(10 * HZ)
>  
>  extern struct datalink_proto *ddp_dl, *aarp_dl;
> -extern void aarp_proto_init(void);
> +extern int aarp_proto_init(void);
>  
>  /* Inter module exports */
>  
> diff --git a/net/appletalk/aarp.c b/net/appletalk/aarp.c
> index 49a16ce..d11372d 100644
> --- a/net/appletalk/aarp.c
> +++ b/net/appletalk/aarp.c
> @@ -879,15 +879,22 @@ static struct notifier_block aarp_notifier = {
>  
>  static unsigned char aarp_snap_id[] = { 0x00, 0x00, 0x00, 0x80, 0xF3 };
>  
> -void __init aarp_proto_init(void)
> +int __init aarp_proto_init(void)
>  {
> +	int rc;
> +
>  	aarp_dl = register_snap_client(aarp_snap_id, aarp_rcv);
> -	if (!aarp_dl)
> +	if (!aarp_dl) {
>  		printk(KERN_CRIT "Unable to register AARP with SNAP.\n");
> +		return -ENOMEM;
> +	}
>  	timer_setup(&aarp_timer, aarp_expire_timeout, 0);
>  	aarp_timer.expires  = jiffies + sysctl_aarp_expiry_time;
>  	add_timer(&aarp_timer);
> -	register_netdevice_notifier(&aarp_notifier);
> +	rc = register_netdevice_notifier(&aarp_notifier);
> +	if (rc)
> +		unregister_snap_client(aarp_dl);
> +	return rc;
>  }
>  
>  /* Remove the AARP entries associated with a device. */
> diff --git a/net/appletalk/ddp.c b/net/appletalk/ddp.c
> index 795fbc6..709d254 100644
> --- a/net/appletalk/ddp.c
> +++ b/net/appletalk/ddp.c
> @@ -1904,9 +1904,6 @@ static unsigned char ddp_snap_id[] = { 0x08, 0x00, 0x07, 0x80, 0x9B };
>  EXPORT_SYMBOL(atrtr_get_dev);
>  EXPORT_SYMBOL(atalk_find_dev_addr);
>  
> -static const char atalk_err_snap[] __initconst =
> -	KERN_CRIT "Unable to register DDP with SNAP.\n";
> -
>  /* Called by proto.c on kernel start up */
>  static int __init atalk_init(void)
>  {
> @@ -1921,17 +1918,22 @@ static int __init atalk_init(void)
>  		goto out_proto;
>  
>  	ddp_dl = register_snap_client(ddp_snap_id, atalk_rcv);
> -	if (!ddp_dl)
> -		printk(atalk_err_snap);
> +	if (!ddp_dl) {
> +		pr_crit("Unable to register DDP with SNAP.\n");
> +		goto out_sock;
> +	}
>  
>  	dev_add_pack(&ltalk_packet_type);
>  	dev_add_pack(&ppptalk_packet_type);
>  
>  	rc = register_netdevice_notifier(&ddp_notifier);
>  	if (rc)
> -		goto out_sock;
> +		goto out_snap;
> +
> +	rc = aarp_proto_init();
> +	if (rc)
> +		goto out_dev;
>  
> -	aarp_proto_init();
>  	rc = atalk_proc_init();
>  	if (rc)
>  		goto out_aarp;
> @@ -1945,11 +1947,13 @@ static int __init atalk_init(void)
>  	atalk_proc_exit();
>  out_aarp:
>  	aarp_cleanup_module();
> +out_dev:
>  	unregister_netdevice_notifier(&ddp_notifier);
> -out_sock:
> +out_snap:
>  	dev_remove_pack(&ppptalk_packet_type);
>  	dev_remove_pack(&ltalk_packet_type);
>  	unregister_snap_client(ddp_dl);
> +out_sock:
>  	sock_unregister(PF_APPLETALK);
>  out_proto:
>  	proto_unregister(&ddp_proto);
> 

