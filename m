Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DA70C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 01:33:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2877820700
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 01:33:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727558AbfCVBdQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 21:33:16 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:34378 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727397AbfCVBdP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 21:33:15 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id DC447D9B7003816B4A18;
        Fri, 22 Mar 2019 09:33:06 +0800 (CST)
Received: from [127.0.0.1] (10.177.96.203) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.408.0; Fri, 22 Mar 2019
 09:33:01 +0800
Subject: Re: [RFC PATCH v2] scsi: fix oops in scsi_uninit_cmd()
To:     Bart Van Assche <bvanassche@acm.org>, <martin.petersen@oracle.com>,
        <jejb@linux.vnet.ibm.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <hare@suse.com>, <hch@lst.de>, <tom.leiming@gmail.com>
References: <20190316020905.14962-1-yanaijie@huawei.com>
 <1553193542.65329.119.camel@acm.org>
From:   Jason Yan <yanaijie@huawei.com>
Message-ID: <eb0051ca-2676-e6b8-0362-8a89f01e58ec@huawei.com>
Date:   Fri, 22 Mar 2019 09:33:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <1553193542.65329.119.camel@acm.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.177.96.203]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2019/3/22 2:39, Bart Van Assche wrote:
> On Sat, 2019-03-16 at 10:09 +0800, Jason Yan wrote:
>> If we remove the scsi disk when running io with fio, oops occured with
>> the following condition.
>>
>> [scsi_eh_0]                              [fio]
>> scsi_end_request
>>    ->blk_update_request
>>      ->end_bio(io returned to userspace)
>>                                           close
>>                                             ->sd_release
>>                                                ->scsi_disk_put
>>                                                   ->scsi_disk_release
>>                                                       ->disk->private_data = NULL;
>>
>>    ->scsi_mq_uninit_cmd
>>      ->scsi_uninit_cmd
>>        ->scsi_cmd_to_driver
>>      ->drv is NULL, Oops
>>
>> There is a small window between blk_update_request() and
>> scsi_mq_uninit_cmd() that scsi disk may have been released. This will
>> cause a oops like below:
>>
>> Unable to handle kernel NULL pointer dereference at virtual address
>> 0000000000000000
>> s/sync.c:67, func=xfer, error=In[11347.116050] Mem abort info:
>> put/output error
>> [11347.121598]   ESR = 0x96000006
>> [11347.126200]   Exception class = DABT (current EL), IL = 32 bits
>> [11347.132117]   SET = 0, FnV = 0
>> [11347.135170]   EA = 0, S1PTW = 0
>> [11347.138308] Data abort info:
>> [11347.141186]   ISV = 0, ISS = 0x00000006
>> [11347.145019]   CM = 0, WnR = 0
>> [11347.147977] user pgtable: 4k pages, 48-bit VAs, pgdp =
>> 00000000a67aece2
>> [11347.154591] [0000000000000000] pgd=0000002f90774003,
>> pud=0000002fab098003, pmd=0000000000000000
>> [11347.163304] Internal error: Oops: 96000006 [#1] PREEMPT SMP
>> [11347.168870] Modules linked in: hisi_sas_v3_hw hisi_sas_main libsas
>> [11347.175044] CPU: 56 PID: 4294 Comm: scsi_eh_2 Not tainted
>> 4.19.0-g8052059-dirty #2
>> [11347.182600] Hardware name: Huawei D06/D06, BIOS Hisilicon D06 UEFI
>> RC0 - B601 (V6.01) 11/08/2018
>> [11347.191370] pstate: a0c00009 (NzCv daif 㰃繐ε흾㯗
> 
> Please verify whether the following patch is a valid alternative for your patch:
> 

Thanks Bart, I will verify it later.

> diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
> index ed34bfbc3844..745ffdda1bc1 100644
> --- a/drivers/scsi/sd.c
> +++ b/drivers/scsi/sd.c
> @@ -1408,6 +1408,7 @@ static void sd_release(struct gendisk *disk, fmode_t mode)
>   {
>   	struct scsi_disk *sdkp = scsi_disk(disk);
>   	struct scsi_device *sdev = sdkp->device;
> +	struct request_queue *q = sdkp->disk->queue;
>   
>   	SCSI_LOG_HLQUEUE(3, sd_printk(KERN_INFO, sdkp, "sd_release\n"));
>   
> @@ -1417,9 +1418,12 @@ static void sd_release(struct gendisk *disk, fmode_t mode)
>   	}
>   
>   	/*
> -	 * XXX and what if there are packets in flight and this close()
> -	 * XXX is followed by a "rmmod sd_mod"?
> +	 * Wait until any requests that are in progress have completed.
> +	 * This is necessary to avoid that e.g. scsi_end_request() crashes
> +	 * due to scsi_disk_relase() clearing the disk->private_data pointer.
>   	 */
> +	blk_mq_freeze_queue(q);
> +	blk_mq_unfreeze_queue(q);
>   
>   	scsi_disk_put(sdkp);
>   }
> 
> Thanks,
> 
> Bart.
> 
> .
> 

