Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 656C3C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 18:17:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A07D21773
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 18:17:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="B0UsyfwR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730023AbfCYSRo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 14:17:44 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:14025 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726217AbfCYSRn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 14:17:43 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c991b4a0000>; Mon, 25 Mar 2019 11:17:46 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 25 Mar 2019 11:17:43 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 25 Mar 2019 11:17:43 -0700
Received: from [10.24.70.95] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 25 Mar
 2019 18:17:39 +0000
Subject: Re: [PATCH 1/8] vfio/mdev: Fix to not do put_device on
 device_register failure
To:     Parav Pandit <parav@mellanox.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>
References: <1553296835-37522-1-git-send-email-parav@mellanox.com>
 <1553296835-37522-2-git-send-email-parav@mellanox.com>
X-Nvconfidentiality: public
From:   Kirti Wankhede <kwankhede@nvidia.com>
Message-ID: <2c096714-74cd-48ff-496f-b3919990e3e5@nvidia.com>
Date:   Mon, 25 Mar 2019 23:47:30 +0530
MIME-Version: 1.0
In-Reply-To: <1553296835-37522-2-git-send-email-parav@mellanox.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1553537866; bh=n8aOmaum8O5EURR1+dIqqyVtEbw7F9E4JKC/95mTe5A=;
        h=X-PGP-Universal:Subject:To:References:X-Nvconfidentiality:From:
         Message-ID:Date:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=B0UsyfwRhFq9SY0IogYxRthIxWcvu/aEryy4VwaMa1UlppxnOWmhFgylufA1dfCKa
         xDG7utLpMO4033vto5XxIZovm7gKQf1Pea7XY4ri92ZA1qzi1BwonrYdHv1ERDoMBo
         3lFDdQgvKPmK89t/iruu6JL86+gkkcP1/BSnKbi6wszi+2EysxaAr03efqec5Izsuu
         iBb51uBWs0/Z7D4K6b6TVR3Ev0FVSUyTJ22OAQ+kJiSPVqSgbBxRlnSpqDYyTYvhAE
         x+qFxLP+ZNXypObDc7wjP3ZLqY8AGwptnyc0p1WgBEOMlZZdUdJfzB70h5nAiMqJtD
         z/lNlZBk2KkIg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/23/2019 4:50 AM, Parav Pandit wrote:
> device_register() performs put_device() if device_add() fails.
> This balances with device_initialize().
> 
> mdev core performing put_device() when device_register() fails,
> is an error that puts already released device again.
> Therefore, don't put the device on error.
> 

device_add() on all errors doesn't call put_device(dev). It releases
reference to its parent, put_device(parent), but not the device itself,
put_device(dev).

Thanks,
Kirti


> Fixes: 7b96953bc640 ("vfio: Mediated device Core driver")
> Signed-off-by: Parav Pandit <parav@mellanox.com>
> ---
>  drivers/vfio/mdev/mdev_core.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/vfio/mdev/mdev_core.c b/drivers/vfio/mdev/mdev_core.c
> index 0212f0e..3e5880a 100644
> --- a/drivers/vfio/mdev/mdev_core.c
> +++ b/drivers/vfio/mdev/mdev_core.c
> @@ -318,10 +318,8 @@ int mdev_device_create(struct kobject *kobj, struct device *dev, uuid_le uuid)
>  	dev_set_name(&mdev->dev, "%pUl", uuid.b);
>  
>  	ret = device_register(&mdev->dev);
> -	if (ret) {
> -		put_device(&mdev->dev);
> +	if (ret)
>  		goto mdev_fail;
> -	}
>  
>  	ret = mdev_device_create_ops(kobj, mdev);
>  	if (ret)
> 
