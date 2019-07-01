Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D0CAC0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 17:13:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D24CA21721
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 17:13:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="buAojMM4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728537AbfGARNX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 13:13:23 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:4261 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726840AbfGARNW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 13:13:22 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d1a3f350001>; Mon, 01 Jul 2019 10:13:25 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 01 Jul 2019 10:13:21 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 01 Jul 2019 10:13:21 -0700
Received: from [10.24.70.16] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 1 Jul
 2019 17:13:19 +0000
Subject: Re: [PATCH v2] mdev: Send uevents around parent device registration
To:     Alex Williamson <alex.williamson@redhat.com>, <cohuck@redhat.com>
CC:     <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <156199271955.1646.13321360197612813634.stgit@gimli.home>
X-Nvconfidentiality: public
From:   Kirti Wankhede <kwankhede@nvidia.com>
Message-ID: <08597ab4-cc37-3973-8927-f1bc430f6185@nvidia.com>
Date:   Mon, 1 Jul 2019 22:43:10 +0530
MIME-Version: 1.0
In-Reply-To: <156199271955.1646.13321360197612813634.stgit@gimli.home>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1562001205; bh=0lQwhe1HpiNpeWtAVtJVyaJWhoLA1XtQt05bVEOWBik=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=buAojMM4bUC1AwNXGNxq2pfeUu3nBRvD9hvUtsuiOw8AQW6p4wEimtn2xmmKNe0Ml
         1/1YPBvz/V2Z6FSrLiCl58gYCDExQXXnqDA1oZLypnhiBoJ/V8qXqj8Aa+GwGRXvTw
         sx5e3BwpDLQ1sftAYwcs2r1aEC/5fl1PGyPMKvk8J6+fongHgfKgGZ36D0Lhg52b3S
         Yx7QQ/PMQNX9KNnoqZMdG4XXtAWA8xW69ZpWjzeUppW78gprAXfUv0X7N6GKWy8abR
         V8PLaTUA12EIreJWTD0fmQqh/QjaVBCrtEXmtUxLPJ9y/eGt4Grbz8DcaH1jbgsso/
         Gx++K//Lck7gg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/1/2019 8:24 PM, Alex Williamson wrote:
> This allows udev to trigger rules when a parent device is registered
> or unregistered from mdev.
> 
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> ---
> 
> v2: Don't remove the dev_info(), Kirti requested they stay and
>     removing them is only tangential to the goal of this change.
> 

Thanks.


>  drivers/vfio/mdev/mdev_core.c |    8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/vfio/mdev/mdev_core.c b/drivers/vfio/mdev/mdev_core.c
> index ae23151442cb..7fb268136c62 100644
> --- a/drivers/vfio/mdev/mdev_core.c
> +++ b/drivers/vfio/mdev/mdev_core.c
> @@ -146,6 +146,8 @@ int mdev_register_device(struct device *dev, const struct mdev_parent_ops *ops)
>  {
>  	int ret;
>  	struct mdev_parent *parent;
> +	char *env_string = "MDEV_STATE=registered";
> +	char *envp[] = { env_string, NULL };
>  
>  	/* check for mandatory ops */
>  	if (!ops || !ops->create || !ops->remove || !ops->supported_type_groups)
> @@ -197,6 +199,8 @@ int mdev_register_device(struct device *dev, const struct mdev_parent_ops *ops)
>  	mutex_unlock(&parent_list_lock);
>  
>  	dev_info(dev, "MDEV: Registered\n");
> +	kobject_uevent_env(&dev->kobj, KOBJ_CHANGE, envp);
> +
>  	return 0;
>  
>  add_dev_err:
> @@ -220,6 +224,8 @@ EXPORT_SYMBOL(mdev_register_device);
>  void mdev_unregister_device(struct device *dev)
>  {
>  	struct mdev_parent *parent;
> +	char *env_string = "MDEV_STATE=unregistered";
> +	char *envp[] = { env_string, NULL };
>  
>  	mutex_lock(&parent_list_lock);
>  	parent = __find_parent_device(dev);
> @@ -243,6 +249,8 @@ void mdev_unregister_device(struct device *dev)
>  	up_write(&parent->unreg_sem);
>  
>  	mdev_put_parent(parent);
> +
> +	kobject_uevent_env(&dev->kobj, KOBJ_CHANGE, envp);

mdev_put_parent() calls put_device(dev). If this is the last instance
holding device, then on put_device(dev) dev would get freed.

This event should be before mdev_put_parent()

Thanks,
Kirti

>  }
>  EXPORT_SYMBOL(mdev_unregister_device);
>  
> 
