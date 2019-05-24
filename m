Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65399C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 11:16:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41B1F21773
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 11:16:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390784AbfEXLQe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 07:16:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60340 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390410AbfEXLQd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 07:16:33 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7488D309266A;
        Fri, 24 May 2019 11:16:33 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-20.pek2.redhat.com [10.72.12.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B711517243;
        Fri, 24 May 2019 11:16:23 +0000 (UTC)
Subject: Re: [PATCH] scsi: smartpqi: properly set both the DMA mask and the
 coherent DMA mask in pqi_pci_init()
To:     Don.Brace@microchip.com, Thomas.Lendacky@amd.com,
        linux-kernel@vger.kernel.org
Cc:     don.brace@microsemi.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        esc.storagedev@microsemi.com, dyoung@redhat.com
References: <20190523055212.23568-1-lijiang@redhat.com>
 <c5d45523-43f5-d2fd-01ac-85f285146ecd@amd.com>
 <SN6PR11MB2767D4410415F0B03BFE900DE1010@SN6PR11MB2767.namprd11.prod.outlook.com>
From:   lijiang <lijiang@redhat.com>
Message-ID: <cea857c8-12db-d10c-124a-fd68cdcdc202@redhat.com>
Date:   Fri, 24 May 2019 19:16:17 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <SN6PR11MB2767D4410415F0B03BFE900DE1010@SN6PR11MB2767.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Fri, 24 May 2019 11:16:33 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2019年05月24日 06:55, Don.Brace@microchip.com 写道:
> -----Original Message-----
> From: linux-scsi-owner@vger.kernel.org [mailto:linux-scsi-owner@vger.kernel.org] On Behalf Of Lendacky, Thomas
> Sent: Thursday, May 23, 2019 9:45 AM
> To: Lianbo Jiang <lijiang@redhat.com>; linux-kernel@vger.kernel.org
> Cc: don.brace@microsemi.com; jejb@linux.ibm.com; martin.petersen@oracle.com; linux-scsi@vger.kernel.org; esc.storagedev@microsemi.com; dyoung@redhat.com
> Subject: Re: [PATCH] scsi: smartpqi: properly set both the DMA mask and the coherent DMA mask in pqi_pci_init()
> 
> On 5/23/19 12:52 AM, Lianbo Jiang wrote:
>> When SME is enabled, the smartpqi driver won't work on the HP DL385
>> G10 machine, which causes the failure of kernel boot because it fails 
>> to allocate pqi error buffer. Please refer to the kernel log:
>> ....
>> [    9.431749] usbcore: registered new interface driver uas
>> [    9.441524] Microsemi PQI Driver (v1.1.4-130)
>> [    9.442956] i40e 0000:04:00.0: fw 6.70.48768 api 1.7 nvm 10.2.5
>> [    9.447237] smartpqi 0000:23:00.0: Microsemi Smart Family Controller found
>>          Starting dracut initqueue hook...
>> [  OK  ] Started Show Plymouth Boot Scre[    9.471654] Broadcom NetXtreme-C/E driver bnxt_en v1.9.1
>> en.
>> [  OK  ] Started Forward Password Requests to Plymouth Directory Watch.
>> [[0;[    9.487108] smartpqi 0000:23:00.0: failed to allocate PQI error buffer
>> ....
>> [  139.050544] dracut-initqueue[949]: Warning: dracut-initqueue 
>> timeout - starting timeout scripts [  139.589779] 
>> dracut-initqueue[949]: Warning: dracut-initqueue timeout - starting 
>> timeout scripts
>>
>> For correct operation, lets call the dma_set_mask_and_coherent() to 
>> properly set the mask for both streaming and coherent, in order to 
>> inform the kernel about the devices DMA addressing capabilities.
> 
> You should probably expand on this a bit...  Basically, the fact that the coherent DMA mask value wasn't set caused the driver to fall back to SWIOTLB when SME is active.

Thank you, Tom.

> I'm not sure if the failure was from running out of SWIOTLB or exceeding the maximum allocation size for SWIOTLB
If so, it should print some messages like "swiotlb buffer is full", but i did not get such a log.

> I believe the fix is proper, but I'll let the driver owner comment on that.
> 
> Thanks,
> Tom
> 
> Acked-by: Don Brace <don.brace@microsemi.com>
> Tested-by: Don Brace <don.brace@microsemi.com>
> 
> Please add the extra description suggested by Thomas.
> 
OK, i will add Tom's description to patch log and post again.

Thank you, Don.

Lianbo
> 
>>
>> Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
>> ---
>>  drivers/scsi/smartpqi/smartpqi_init.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/scsi/smartpqi/smartpqi_init.c 
>> b/drivers/scsi/smartpqi/smartpqi_init.c
>> index c26cac819f9e..8b1fde6c7dab 100644
>> --- a/drivers/scsi/smartpqi/smartpqi_init.c
>> +++ b/drivers/scsi/smartpqi/smartpqi_init.c
>> @@ -7282,7 +7282,7 @@ static int pqi_pci_init(struct pqi_ctrl_info *ctrl_info)
>>         else
>>                 mask = DMA_BIT_MASK(32);
>>
>> -       rc = dma_set_mask(&ctrl_info->pci_dev->dev, mask);
>> +       rc = dma_set_mask_and_coherent(&ctrl_info->pci_dev->dev, 
>> + mask);
>>         if (rc) {
>>                 dev_err(&ctrl_info->pci_dev->dev, "failed to set DMA mask\n");
>>                 goto disable_device;
>> --
>> 2.17.1
>>
