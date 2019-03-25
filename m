Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E866FC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 19:18:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC9DF20854
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 19:18:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="gxcalig/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730199AbfCYTSe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 15:18:34 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:17004 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729959AbfCYTSa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 15:18:30 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c9929880000>; Mon, 25 Mar 2019 12:18:32 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 25 Mar 2019 12:18:29 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 25 Mar 2019 12:18:29 -0700
Received: from [10.24.70.95] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 25 Mar
 2019 19:18:27 +0000
Subject: Re: [PATCH 5/8] vfio/mdev: Avoid masking error code to EBUSY
To:     Parav Pandit <parav@mellanox.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>
References: <1553296835-37522-1-git-send-email-parav@mellanox.com>
 <1553296835-37522-6-git-send-email-parav@mellanox.com>
X-Nvconfidentiality: public
From:   Kirti Wankhede <kwankhede@nvidia.com>
Message-ID: <6f990e18-296c-cd33-df2b-c5c4bad7a740@nvidia.com>
Date:   Tue, 26 Mar 2019 00:48:21 +0530
MIME-Version: 1.0
In-Reply-To: <1553296835-37522-6-git-send-email-parav@mellanox.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1553541512; bh=NBU/R4E0m2oOnZMOnx4PUm24c8qtBPSovCyH2Uo1Els=;
        h=X-PGP-Universal:Subject:To:References:X-Nvconfidentiality:From:
         Message-ID:Date:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=gxcalig/HCaFRZ1N1OTvgklZ2IYMeDXn6nscHYmyr0wnYDBXs+mvMBQNZbbl9iTbN
         c42K4pJH3bsIl+Z3b6ga8auLVjyqv1U0fF7eeWUpS/6Q74EhyOS5ysG55ztvOtSOfi
         Tc9QR+Npj1PcFFSSesQn4i5sihmx+/iU3wTxa2TnutmvJ4e6mZLyHYlUmk2sPcXGwZ
         Rtxf6Ussuiy57cnNGG7BXZF2EysRtlYnkRaX0wQhKc7OHxjvh3yqxQ6cSDWV9YfCyt
         6IjJqph/cIusYoQeLLPTlAD972GUdXp0SqbPyuu0t+AI6/j+OSheFZDen+frnPvk/g
         1ebxQUmWEGDYA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/23/2019 4:50 AM, Parav Pandit wrote:
> Instead of masking return error to -EBUSY, return actual error
> returned by the driver.
> 
> Signed-off-by: Parav Pandit <parav@mellanox.com>
> ---
>  drivers/vfio/mdev/mdev_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/vfio/mdev/mdev_core.c b/drivers/vfio/mdev/mdev_core.c
> index 3d91f62..ab05464 100644
> --- a/drivers/vfio/mdev/mdev_core.c
> +++ b/drivers/vfio/mdev/mdev_core.c
> @@ -142,7 +142,7 @@ static int mdev_device_remove_ops(struct mdev_device *mdev, bool force_remove)
>  	 */
>  	ret = parent->ops->remove(mdev);
>  	if (ret && !force_remove)
> -		return -EBUSY;
> +		return ret;
>  
>  	sysfs_remove_groups(&mdev->dev.kobj, parent->ops->mdev_attr_groups);
>  	return 0;
> 

Intentionally returned -EBUSY here. If VMM or userspace application is
using this mdev device, vendor driver can return error. In that case
sysfs interface should see -EBUSY error indicating device is still active.

Thanks,
Kirti
