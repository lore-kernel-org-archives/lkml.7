Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0F8CC0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 20:04:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E1ED20663
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 20:04:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ct2xqmpi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726866AbfGAUEY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 16:04:24 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:33273 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726668AbfGAUEY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 16:04:24 -0400
Received: by mail-ed1-f68.google.com with SMTP id i11so25042610edq.0;
        Mon, 01 Jul 2019 13:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0CNlL2851Davn61YeptnodzyoCmUGyYI2pFnwzHbujc=;
        b=Ct2xqmpiDioDNvC1/rWVs5RKGxNlA1Hmo3t3hT0xj9LJ96i2zqnT4UsuZCzysmoxoW
         AR1UCtkeOXGkbgcfapHvXIyzl2kJVrWuDXVexpjvQEjx0omgJdiH4nMB/5MQdyCq2yRo
         Jr2Jwf2uW0/aa923alAGrd4w/DcGShRggcBCPPcNS7c2J3+FHR+ZvIpENvzHWwf07c30
         CMOyL2OM+RQnUNp+lc88PPBkfLkDhA6o4/qTJuPalVbukNJ4K+bI9WVSnabMuddVeo1O
         WzwL+xJ/9NXuPJXRbLDtoyxLTF/MmB30uOTw8uyw8PnPFrGpyh53nuKEvQZ69Jp+GE6p
         U/pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0CNlL2851Davn61YeptnodzyoCmUGyYI2pFnwzHbujc=;
        b=uOob0xppoAvyyxzFVEIuYMRTlQ2Jc7EELea4HuuuKfQBMjXtKVaojLSS1DyIu7nx9T
         jWEbTCQWe0g4oiv6JIX4nvb4mRJ3hz01DAmAJznYRtkQGzNzSKxEJToFT1MFhqk7WF9X
         sb92Gs7NkSd5w5FqPPkO2iqvv8clxJV8XUiennO+qHbxOEiPro/XLwYCfBa1OYZ39TQ+
         0Iyngxy5RDfjMAo4nE4dQ7wNG9TbgQbWoce6Q4cAknL+bSkHtvMzXZ/O82olAjEl8o3R
         4SiQTO3lN7/epTM0u/x5fSKDCFthEo9oia0uBAyThASoByhpdiiqsFzrphxPhXpGyJcL
         CTtQ==
X-Gm-Message-State: APjAAAUdtrQ+cC+RLrmcn4jBHSpCEI769ytxvBa1x/Mk1RD74OlUd7S2
        Ut0C4BOuMdZg5Df5S/NQdU4=
X-Google-Smtp-Source: APXvYqynmODX3+4y9DBQ6o12oB8g4QKxrkK8depi9Ok2HREdfQFM+i27KmEnVK2HWmioyZvBE6H43A==
X-Received: by 2002:a17:907:2091:: with SMTP id pv17mr24937125ejb.152.1562011461601;
        Mon, 01 Jul 2019 13:04:21 -0700 (PDT)
Received: from archlinux-epyc ([2a01:4f9:2b:2b15::2])
        by smtp.gmail.com with ESMTPSA id v47sm4058590edc.80.2019.07.01.13.04.20
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 01 Jul 2019 13:04:20 -0700 (PDT)
Date:   Mon, 1 Jul 2019 13:04:18 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Greg KH <greg@kroah.com>, Arnd Bergmann <arnd@arndb.de>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: Re: linux-next: manual merge of the char-misc tree with the
 driver-core tree
Message-ID: <20190701200418.GA72724@archlinux-epyc>
References: <20190701190940.7f23ac15@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="yrj/dFKFPuw6o+aM"
Content-Disposition: inline
In-Reply-To: <20190701190940.7f23ac15@canb.auug.org.au>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 01, 2019 at 07:09:40PM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the char-misc tree got a conflict in:
> 
>   drivers/hwtracing/coresight/of_coresight.c
> 
> between commit:
> 
>   418e3ea157ef ("bus_find_device: Unify the match callback with class_find_device")
> 
> from the driver-core tree and commits:
> 
>   22aa495a6477 ("coresight: Rename of_coresight to coresight-platform")
>   20961aea982e ("coresight: platform: Use fwnode handle for device search")
> 
> from the char-misc tree.
> 
> I fixed it up (I removed the file and added the following merge fix patch)
> and can carry the fix as necessary. This is now fixed as far as linux-next
> is concerned, but any non trivial conflicts should be mentioned to your
> upstream maintainer when your tree is submitted for merging.  You may
> also want to consider cooperating with the maintainer of the conflicting
> tree to minimise any particularly complex conflicts.
> 
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Mon, 1 Jul 2019 19:07:20 +1000
> Subject: [PATCH] coresight: fix for "bus_find_device: Unify the match callback
>  with class_find_device"
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  drivers/hwtracing/coresight/coresight-platform.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-platform.c b/drivers/hwtracing/coresight/coresight-platform.c
> index 3c5ceda8db24..fc67f6ae0b3e 100644
> --- a/drivers/hwtracing/coresight/coresight-platform.c
> +++ b/drivers/hwtracing/coresight/coresight-platform.c
> @@ -37,7 +37,7 @@ static int coresight_alloc_conns(struct device *dev,
>  	return 0;
>  }
>  
> -int coresight_device_fwnode_match(struct device *dev, void *fwnode)
> +int coresight_device_fwnode_match(struct device *dev, const void *fwnode)
>  {
>  	return dev_fwnode(dev) == fwnode;
>  }
> -- 
> 2.20.1
> 
> -- 
> Cheers,
> Stephen Rothwell

Hi Stephen and Michael,

It looks like a similar fix is needed for the vhost tree because of
commit edcd69ab9a32 ("iommu: Add virtio-iommu driver") interacting with
commit 92ce7e83b4e5 ("driver_find_device: Unify the match function with
class_find_device()") in the driver-core tree (my patch is attached).

Cheers,
Nathan

--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-iommu-virtio-Constify-data-parameter-in-viommu_match.patch"

From 347a1bbeb8ba757648ceeed1839df101417a3d9f Mon Sep 17 00:00:00 2001
From: Nathan Chancellor <natechancellor@gmail.com>
Date: Mon, 1 Jul 2019 12:54:28 -0700
Subject: [PATCH] iommu/virtio: Constify data parameter in viommu_match_node

After commit 92ce7e83b4e5 ("driver_find_device: Unify the match
function with class_find_device()") in the driver-core tree.

Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/iommu/virtio-iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index 4620dd221ffd..433f4d2ee956 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -839,7 +839,7 @@ static void viommu_put_resv_regions(struct device *dev, struct list_head *head)
 static struct iommu_ops viommu_ops;
 static struct virtio_driver virtio_iommu_drv;
 
-static int viommu_match_node(struct device *dev, void *data)
+static int viommu_match_node(struct device *dev, const void *data)
 {
 	return dev->parent->fwnode == data;
 }
-- 
2.22.0


--yrj/dFKFPuw6o+aM--
