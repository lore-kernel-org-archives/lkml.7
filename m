Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 537C4C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 18:27:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F0E72087C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 18:27:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="gLFFnyHs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730052AbfCYS1I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 14:27:08 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:16840 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728912AbfCYS1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 14:27:08 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c991d7a0000>; Mon, 25 Mar 2019 11:27:06 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 25 Mar 2019 11:27:07 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 25 Mar 2019 11:27:07 -0700
Received: from [10.24.70.95] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 25 Mar
 2019 18:27:05 +0000
Subject: Re: [PATCH 2/8] vfio/mdev: Avoid release parent reference during
 error path
To:     Parav Pandit <parav@mellanox.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>
References: <1553296835-37522-1-git-send-email-parav@mellanox.com>
 <1553296835-37522-3-git-send-email-parav@mellanox.com>
X-Nvconfidentiality: public
From:   Kirti Wankhede <kwankhede@nvidia.com>
Message-ID: <7c51995d-a318-62bf-dbb3-34ed8296fd82@nvidia.com>
Date:   Mon, 25 Mar 2019 23:57:01 +0530
MIME-Version: 1.0
In-Reply-To: <1553296835-37522-3-git-send-email-parav@mellanox.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL103.nvidia.com (172.20.187.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1553538426; bh=/RaSzi5HmunhU5z9wobat/McGDt5iVfwrtUXtRu8Mbs=;
        h=X-PGP-Universal:Subject:To:References:X-Nvconfidentiality:From:
         Message-ID:Date:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=gLFFnyHsYctONpw+JE+dHB+cZ4hpXefqATk/wHnyaNI5As/YLqXNHVqWedK1tYZsH
         PffLm8XjNKccH6ohM6Tw93PYx/RO5S5k2k3kJMU21x/v+vOAAxdFjnlQLp6CHRFjZw
         aBwk2K67bnUWx1Zz+5GZM71H3H3pdXxbPhSciMQkaJlbpxJ+N0kMP2mt54GevETCmK
         PRsRVmJGvH8o8Ud+PBjsOVCjpOBc9T/Qro7NsWfNH4YQtxzcncD2rInTnRaYbkFtgs
         vIYSB/F3gSpD2yfmfBGEL0j1n7/uulp0K9ARdl47u55LrndKwNX9PNHmFIdwzJEb9i
         IQsZZxoM3hAjw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/23/2019 4:50 AM, Parav Pandit wrote:
> During mdev parent registration in mdev_register_device(),
> if parent device is duplicate, it releases the reference of existing
> parent device.
> This is incorrect. Existing parent device should not be touched.
> 
> Fixes: 7b96953bc640 ("vfio: Mediated device Core driver")
> Signed-off-by: Parav Pandit <parav@mellanox.com>
> ---
>  drivers/vfio/mdev/mdev_core.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/vfio/mdev/mdev_core.c b/drivers/vfio/mdev/mdev_core.c
> index 3e5880a..4f213e4d 100644
> --- a/drivers/vfio/mdev/mdev_core.c
> +++ b/drivers/vfio/mdev/mdev_core.c
> @@ -182,6 +182,7 @@ int mdev_register_device(struct device *dev, const struct mdev_parent_ops *ops)
>  	/* Check for duplicate */
>  	parent = __find_parent_device(dev);
>  	if (parent) {
> +		parent = NULL;
>  		ret = -EEXIST;
>  		goto add_dev_err;
>  	}
> 

Agreed. Thanks for fixing this.

Reviewed By: Kirti Wankhede <kwankhede@nvidia.com>

Thanks,
Kirti
