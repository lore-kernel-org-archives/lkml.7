Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4C43C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 14:00:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8515D208C3
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 14:00:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="r2Scdq0O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726231AbfJJOAN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 10:00:13 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:42654 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbfJJOAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 10:00:12 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9ADxAdc030650;
        Thu, 10 Oct 2019 13:59:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=y2rwgqYe3SSkpJw3Li2BKZl3YZdi4e5AxSucpXkNttE=;
 b=r2Scdq0O81IUeVM2Vrbg6flWFlrDp9xiA8Cg3BHA2FiB+MI6I2jZDY6BMIfpBUr0oHj/
 T2riF3Crl8QJABAOcQJZDarh+uIHm9ScYc8KKb9BK9YYAVegdUbrcTwzb6R40WA3jmOQ
 9J6me2Az2DnpZ34QLy4HFKTjbKUtYeb6w7R5LqrkQJf72QcXHN+uhKdCzhRP/zipGCCH
 uX31eRL/U5gT6sTdMR1V227LEktBj5Ry64m+07TafQbHDuKhMl29BIc3dhgSAgugbbbO
 lb31EiT4XBzXjOSm1nzgqq6XAuVydzKEaPfcf0h/RnKUX1Oxr2fKFKJCwIVU3KpekNj2 HQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2vektru3n8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Oct 2019 13:59:55 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9ADwXlS153156;
        Thu, 10 Oct 2019 13:59:55 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2vh8k2wrmv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Oct 2019 13:59:54 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x9ADxivY031341;
        Thu, 10 Oct 2019 13:59:44 GMT
Received: from bostrovs-us.us.oracle.com (/10.152.32.65)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 10 Oct 2019 06:59:44 -0700
Subject: Re: [PATCH v2] xen: Stop abusing DT of_dma_configure API
To:     Oleksandr Andrushchenko <Oleksandr_Andrushchenko@epam.com>,
        Rob Herring <robh@kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Julien Grall <julien.grall@arm.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Christoph Hellwig <hch@lst.de>
References: <20191008194155.4810-1-robh@kernel.org>
 <fd2f61bb-1ff8-f90b-9514-e662db2ff19f@epam.com>
From:   Boris Ostrovsky <boris.ostrovsky@oracle.com>
Openpgp: preference=signencrypt
Autocrypt: addr=boris.ostrovsky@oracle.com; prefer-encrypt=mutual; keydata=
 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
 Jg6OxFYd01z+a+oL
Message-ID: <362d1eac-e352-d8de-1b6f-586acc0007ce@oracle.com>
Date:   Thu, 10 Oct 2019 09:59:26 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <fd2f61bb-1ff8-f90b-9514-e662db2ff19f@epam.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9405 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910100132
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9405 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910100132
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/9/19 7:42 AM, Oleksandr Andrushchenko wrote:
> On 10/8/19 10:41 PM, Rob Herring wrote:
>> As the removed comments say, these aren't DT based devices.
>> of_dma_configure() is going to stop allowing a NULL DT node and calling
>> it will no longer work.
>>
>> The comment is also now out of date as of commit 9ab91e7c5c51 ("arm64:
>> default to the direct mapping in get_arch_dma_ops"). Direct mapping
>> is now the default rather than dma_dummy_ops.
>>
>> According to Stefano and Oleksandr, the only other part needed is
>> setting the DMA masks and there's no reason to restrict the masks to
>> 32-bits. So set the masks to 64 bits.
>>
>> Cc: Robin Murphy <robin.murphy@arm.com>
>> Cc: Julien Grall <julien.grall@arm.com>
>> Cc: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
>> Cc: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
>> Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
>> Cc: Juergen Gross <jgross@suse.com>
>> Cc: Stefano Stabellini <sstabellini@kernel.org>
>> Cc: Christoph Hellwig <hch@lst.de>
>> Cc: xen-devel@lists.xenproject.org
>> Signed-off-by: Rob Herring <robh@kernel.org>
> Acked-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>


Is this going to go via drm tree or should I pick it up for Xen tree?

-boris



>
> Unfortunately I cannot test this patch with real HW running Xen:
> I am still on 4.14 kernel which is dictated by the board's BSP and
> it is not possible to have more recent one at the moment.
> So, I hope the patch will work as intended.
>
> Thank you,
> Oleksandr
>> ---
>> v2:
>>   - Setup dma masks
>>   - Also fix xen_drm_front.c
>>   
>> This can now be applied to the Xen tree independent of the coming
>> of_dma_configure() changes.
>>
>> Rob
>>
>>   drivers/gpu/drm/xen/xen_drm_front.c | 12 ++----------
>>   drivers/xen/gntdev.c                | 13 ++-----------
>>   2 files changed, 4 insertions(+), 21 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/xen/xen_drm_front.c b/drivers/gpu/drm/xen/xen_drm_front.c
>> index ba1828acd8c9..4be49c1aef51 100644
>> --- a/drivers/gpu/drm/xen/xen_drm_front.c
>> +++ b/drivers/gpu/drm/xen/xen_drm_front.c
>> @@ -718,17 +718,9 @@ static int xen_drv_probe(struct xenbus_device *xb_dev,
>>   	struct device *dev = &xb_dev->dev;
>>   	int ret;
>>   
>> -	/*
>> -	 * The device is not spawn from a device tree, so arch_setup_dma_ops
>> -	 * is not called, thus leaving the device with dummy DMA ops.
>> -	 * This makes the device return error on PRIME buffer import, which
>> -	 * is not correct: to fix this call of_dma_configure() with a NULL
>> -	 * node to set default DMA ops.
>> -	 */
>> -	dev->coherent_dma_mask = DMA_BIT_MASK(32);
>> -	ret = of_dma_configure(dev, NULL, true);
>> +	ret = dma_coerce_mask_and_coherent(dev, DMA_BIT_MASK(64));
>>   	if (ret < 0) {
>> -		DRM_ERROR("Cannot setup DMA ops, ret %d", ret);
>> +		DRM_ERROR("Cannot setup DMA mask, ret %d", ret);
>>   		return ret;
>>   	}
>>   
>> diff --git a/drivers/xen/gntdev.c b/drivers/xen/gntdev.c
>> index a446a7221e13..81401f386c9c 100644
>> --- a/drivers/xen/gntdev.c
>> +++ b/drivers/xen/gntdev.c
>> @@ -22,6 +22,7 @@
>>   
>>   #define pr_fmt(fmt) "xen:" KBUILD_MODNAME ": " fmt
>>   
>> +#include <linux/dma-mapping.h>
>>   #include <linux/module.h>
>>   #include <linux/kernel.h>
>>   #include <linux/init.h>
>> @@ -34,9 +35,6 @@
>>   #include <linux/slab.h>
>>   #include <linux/highmem.h>
>>   #include <linux/refcount.h>
>> -#ifdef CONFIG_XEN_GRANT_DMA_ALLOC
>> -#include <linux/of_device.h>
>> -#endif
>>   
>>   #include <xen/xen.h>
>>   #include <xen/grant_table.h>
>> @@ -625,14 +623,7 @@ static int gntdev_open(struct inode *inode, struct file *flip)
>>   	flip->private_data = priv;
>>   #ifdef CONFIG_XEN_GRANT_DMA_ALLOC
>>   	priv->dma_dev = gntdev_miscdev.this_device;
>> -
>> -	/*
>> -	 * The device is not spawn from a device tree, so arch_setup_dma_ops
>> -	 * is not called, thus leaving the device with dummy DMA ops.
>> -	 * Fix this by calling of_dma_configure() with a NULL node to set
>> -	 * default DMA ops.
>> -	 */
>> -	of_dma_configure(priv->dma_dev, NULL, true);
>> +	dma_coerce_mask_and_coherent(priv->dma_dev, DMA_BIT_MASK(64));
>>   #endif
>>   	pr_debug("priv %p\n", priv);
>>   

