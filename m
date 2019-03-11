Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7834C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 08:31:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 968B120643
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 08:31:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727248AbfCKIbK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 04:31:10 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42564 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727220AbfCKIbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 04:31:09 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2B8TFYi047695
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 04:31:08 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2r5h29yeg9-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 04:31:08 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Mon, 11 Mar 2019 08:31:05 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 11 Mar 2019 08:31:03 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2B8V1iF32571432
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Mar 2019 08:31:01 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 55BE45205F;
        Mon, 11 Mar 2019 08:31:01 +0000 (GMT)
Received: from [9.145.177.223] (unknown [9.145.177.223])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id BE47D5204E;
        Mon, 11 Mar 2019 08:31:00 +0000 (GMT)
Reply-To: pmorel@linux.ibm.com
Subject: Re: [PATCH v4 6/7] s390: ap: Cleanup on removing the AP device
To:     Tony Krowiak <akrowiak@linux.ibm.com>, borntraeger@de.ibm.com
Cc:     alex.williamson@redhat.com, cohuck@redhat.com,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, frankja@linux.ibm.com, pasic@linux.ibm.com,
        david@redhat.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, freude@linux.ibm.com, mimu@linux.ibm.com
References: <1550849400-27152-1-git-send-email-pmorel@linux.ibm.com>
 <1550849400-27152-7-git-send-email-pmorel@linux.ibm.com>
 <3956ad4c-55c9-e42c-4ab2-00ddae05b317@linux.ibm.com>
From:   Pierre Morel <pmorel@linux.ibm.com>
Date:   Mon, 11 Mar 2019 09:31:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <3956ad4c-55c9-e42c-4ab2-00ddae05b317@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19031108-0020-0000-0000-0000032125D4
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19031108-0021-0000-0000-000021734847
Message-Id: <94904df0-42b6-51f8-6440-68722ef5419d@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-11_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903110065
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/03/2019 23:43, Tony Krowiak wrote:
> On 2/22/19 10:29 AM, Pierre Morel wrote:
>> When the device is remove, we must make sure to
>> clear the interruption and reset the AP device.
>>
>> We also need to clear the CRYCB of the guest.
>>
>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>> ---
>>   drivers/s390/crypto/vfio_ap_drv.c     | 35 
>> +++++++++++++++++++++++++++++++++++
>>   drivers/s390/crypto/vfio_ap_ops.c     |  3 ++-
>>   drivers/s390/crypto/vfio_ap_private.h |  3 +++
>>   3 files changed, 40 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/s390/crypto/vfio_ap_drv.c 
>> b/drivers/s390/crypto/vfio_ap_drv.c
>> index eca0ffc..e5d91ff 100644
>> --- a/drivers/s390/crypto/vfio_ap_drv.c
>> +++ b/drivers/s390/crypto/vfio_ap_drv.c
>> @@ -5,6 +5,7 @@
>>    * Copyright IBM Corp. 2018
>>    *
>>    * Author(s): Tony Krowiak <akrowiak@linux.ibm.com>
>> + *          Pierre Morel <pmorel@linux.ibm.com>
>>    */
>>   #include <linux/module.h>
>> @@ -12,6 +13,8 @@
>>   #include <linux/slab.h>
>>   #include <linux/string.h>
>>   #include <asm/facility.h>
>> +#include <linux/bitops.h>
>> +#include <linux/kvm_host.h>
>>   #include "vfio_ap_private.h"
>>   #define VFIO_AP_ROOT_NAME "vfio_ap"
>> @@ -61,6 +64,33 @@ static int vfio_ap_queue_dev_probe(struct ap_device 
>> *apdev)
>>   }
>>   /**
>> + * vfio_ap_update_crycb
>> + * @q: A pointer to the queue being removed
>> + *
>> + * We clear the APID of the queue, making this queue unusable for the 
>> guest.
>> + * After this function we can reset the queue without to fear a race 
>> with
>> + * the guest to access the queue again.
>> + * We do not fear race with the host as we still get the device.
>> + */
>> +static void vfio_ap_update_crycb(struct vfio_ap_queue *q)
>> +{
>> +    struct ap_matrix_mdev *matrix_mdev = q->matrix_mdev;
>> +
>> +    if (!matrix_mdev)
>> +        return;
>> +
>> +    clear_bit_inv(AP_QID_CARD(q->apqn), matrix_mdev->matrix.apm);
>> +
>> +    if (!matrix_mdev->kvm)
>> +        return;
>> +
>> +    kvm_arch_crypto_set_masks(matrix_mdev->kvm,
>> +                  matrix_mdev->matrix.apm,
>> +                  matrix_mdev->matrix.aqm,
>> +                  matrix_mdev->matrix.adm);
>> +}
>> +
>> +/**
>>    * vfio_ap_queue_dev_remove:
>>    *
>>    * Free the associated vfio_ap_queue structure
>> @@ -70,6 +100,11 @@ static void vfio_ap_queue_dev_remove(struct 
>> ap_device *apdev)
>>       struct vfio_ap_queue *q;
>>       q = dev_get_drvdata(&apdev->device);
>> +    if (!q)
>> +        return;
>> +
>> +    vfio_ap_update_crycb(q);
>> +    vfio_ap_mdev_reset_queue(q);
> 
> Since the bit corresponding to the APID is cleared in the
> vfio_ap_update_crycb() above, shouldn't all queues on that
> card also be reset?

I do not think so.
The remove function will be called in a loop for all queues by the bus.
No need to clear all queues.


> 
>>       list_del(&q->list);
>>       kfree(q);
>>   }
>> diff --git a/drivers/s390/crypto/vfio_ap_ops.c 
>> b/drivers/s390/crypto/vfio_ap_ops.c
>> index 0196065..5b9bb33 100644
>> --- a/drivers/s390/crypto/vfio_ap_ops.c
>> +++ b/drivers/s390/crypto/vfio_ap_ops.c
>> @@ -59,6 +59,7 @@ int vfio_ap_mdev_reset_queue(struct vfio_ap_queue *q)
>>               if (retry <= 0)
>>                   pr_warn("%s: queue 0x%04x not empty\n",
>>                       __func__, q->apqn);
>> +            vfio_ap_free_irq(q);
> 
> Shouldn't this be done for the response codes that terminate this loop
> such as those caught by the default case?

I do not think so, the error code is returned and the caller may want to 
reset the queue again.
I think that doing the free inside the call to reset is not right.
I will investigate in this direction.

Regards,
Pierre

-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany

