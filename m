Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBD64C43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 01:33:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF7BF20675
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 01:33:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728481AbfLEBdZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 20:33:25 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:7634 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728098AbfLEBdZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 20:33:25 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 83A93A039167D4FE9EDB;
        Thu,  5 Dec 2019 09:33:23 +0800 (CST)
Received: from [127.0.0.1] (10.133.219.224) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.439.0; Thu, 5 Dec 2019
 09:33:19 +0800
Subject: Re: [PATCH] UBI: fix use after free in ubi_remove_volume()
From:   Hou Tao <houtao1@huawei.com>
To:     Wen Yang <wenyang@linux.alibaba.com>,
        Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <xlpang@linux.alibaba.com>
References: <20191130093317.31352-1-wenyang@linux.alibaba.com>
 <65b49705-e28c-e077-c0de-c5167e34d1c5@huawei.com>
Message-ID: <58208ceb-4d72-c4a1-8a2b-9e38854e3672@huawei.com>
Date:   Thu, 5 Dec 2019 09:33:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <65b49705-e28c-e077-c0de-c5167e34d1c5@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.133.219.224]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2019/12/3 21:13, Hou Tao wrote:
> Reviewed-by: Hou Tao <houtao1@huawei.com>
> 
Sorry for my early conclusion.

The reference of ubi_volume had already been increased in ubi_open_volume()
in ubi_cdev_ioctl(), so this reference dropped in ubi_remove_volume() will not
be the last one, and there will no use-after-free problem.

Regards,
Tao

> On 2019/11/30 17:33, Wen Yang wrote:
>> We can't use "vol" after it has been freed.
>>
>> Fixes: 493cfaeaa0c9 ("mtd: utilize new cdev_device_add helper function")
>> Signed-off-by: Wen Yang <wenyang@linux.alibaba.com>
>> Cc: Richard Weinberger <richard@nod.at>
>> Cc: Miquel Raynal <miquel.raynal@bootlin.com>
>> Cc: Vignesh Raghavendra <vigneshr@ti.com>
>> Cc: linux-mtd@lists.infradead.org
>> Cc: linux-kernel@vger.kernel.org
>> ---
>>  drivers/mtd/ubi/vmt.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/mtd/ubi/vmt.c b/drivers/mtd/ubi/vmt.c
>> index 139ee13..8ff1478 100644
>> --- a/drivers/mtd/ubi/vmt.c
>> +++ b/drivers/mtd/ubi/vmt.c
>> @@ -375,7 +375,6 @@ int ubi_remove_volume(struct ubi_volume_desc *desc, int no_vtbl)
>>  	}
>>  
>>  	cdev_device_del(&vol->cdev, &vol->dev);
>> -	put_device(&vol->dev);
>>  
>>  	spin_lock(&ubi->volumes_lock);
>>  	ubi->rsvd_pebs -= reserved_pebs;
>> @@ -388,6 +387,8 @@ int ubi_remove_volume(struct ubi_volume_desc *desc, int no_vtbl)
>>  	if (!no_vtbl)
>>  		self_check_volumes(ubi);
>>  
>> +	put_device(&vol->dev);
>> +
>>  	return 0;
>>  
>>  out_err:
>>
> 
> 
> ______________________________________________________
> Linux MTD discussion mailing list
> http://lists.infradead.org/mailman/listinfo/linux-mtd/
> 
> 

