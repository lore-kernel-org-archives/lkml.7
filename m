Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1904C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 21:54:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFD3B2077B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 21:54:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727238AbfCLVyG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 17:54:06 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53838 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726388AbfCLVyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 17:54:05 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2CLnL0Z108588
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 17:54:04 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2r6j8x0pr5-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 17:54:04 -0400
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <akrowiak@linux.ibm.com>;
        Tue, 12 Mar 2019 21:54:03 -0000
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
        by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 12 Mar 2019 21:53:59 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2CLrunv17694870
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Mar 2019 21:53:56 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 26A0FB2064;
        Tue, 12 Mar 2019 21:53:56 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D12DEB2067;
        Tue, 12 Mar 2019 21:53:55 +0000 (GMT)
Received: from [9.60.75.235] (unknown [9.60.75.235])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 12 Mar 2019 21:53:55 +0000 (GMT)
Subject: Re: [PATCH v4 6/7] s390: ap: Cleanup on removing the AP device
To:     pmorel@linux.ibm.com, borntraeger@de.ibm.com
Cc:     alex.williamson@redhat.com, cohuck@redhat.com,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, frankja@linux.ibm.com, pasic@linux.ibm.com,
        david@redhat.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, freude@linux.ibm.com, mimu@linux.ibm.com
References: <1550849400-27152-1-git-send-email-pmorel@linux.ibm.com>
 <1550849400-27152-7-git-send-email-pmorel@linux.ibm.com>
 <3956ad4c-55c9-e42c-4ab2-00ddae05b317@linux.ibm.com>
 <94904df0-42b6-51f8-6440-68722ef5419d@linux.ibm.com>
From:   Tony Krowiak <akrowiak@linux.ibm.com>
Date:   Tue, 12 Mar 2019 17:53:55 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <94904df0-42b6-51f8-6440-68722ef5419d@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19031221-0072-0000-0000-00000409C2F8
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010746; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000281; SDB=6.01173467; UDB=6.00613537; IPR=6.00954127;
 MB=3.00025953; MTD=3.00000008; XFM=3.00000015; UTC=2019-03-12 21:54:01
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19031221-0073-0000-0000-00004B77A920
Message-Id: <cf148acb-1a07-ffa3-f728-0f6b02aa914d@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-12_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903120144
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/11/19 4:31 AM, Pierre Morel wrote:
> On 08/03/2019 23:43, Tony Krowiak wrote:
>> On 2/22/19 10:29 AM, Pierre Morel wrote:
>>> When the device is remove, we must make sure to
>>> clear the interruption and reset the AP device.
>>>
>>> We also need to clear the CRYCB of the guest.
>>>
>>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>>> ---
>>>   drivers/s390/crypto/vfio_ap_drv.c     | 35 
>>> +++++++++++++++++++++++++++++++++++
>>>   drivers/s390/crypto/vfio_ap_ops.c     |  3 ++-
>>>   drivers/s390/crypto/vfio_ap_private.h |  3 +++
>>>   3 files changed, 40 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/s390/crypto/vfio_ap_drv.c 
>>> b/drivers/s390/crypto/vfio_ap_drv.c
>>> index eca0ffc..e5d91ff 100644
>>> --- a/drivers/s390/crypto/vfio_ap_drv.c
>>> +++ b/drivers/s390/crypto/vfio_ap_drv.c
>>> @@ -5,6 +5,7 @@
>>>    * Copyright IBM Corp. 2018
>>>    *
>>>    * Author(s): Tony Krowiak <akrowiak@linux.ibm.com>
>>> + *          Pierre Morel <pmorel@linux.ibm.com>
>>>    */
>>>   #include <linux/module.h>
>>> @@ -12,6 +13,8 @@
>>>   #include <linux/slab.h>
>>>   #include <linux/string.h>
>>>   #include <asm/facility.h>
>>> +#include <linux/bitops.h>
>>> +#include <linux/kvm_host.h>
>>>   #include "vfio_ap_private.h"
>>>   #define VFIO_AP_ROOT_NAME "vfio_ap"
>>> @@ -61,6 +64,33 @@ static int vfio_ap_queue_dev_probe(struct 
>>> ap_device *apdev)
>>>   }
>>>   /**
>>> + * vfio_ap_update_crycb
>>> + * @q: A pointer to the queue being removed
>>> + *
>>> + * We clear the APID of the queue, making this queue unusable for 
>>> the guest.
>>> + * After this function we can reset the queue without to fear a race 
>>> with
>>> + * the guest to access the queue again.
>>> + * We do not fear race with the host as we still get the device.
>>> + */
>>> +static void vfio_ap_update_crycb(struct vfio_ap_queue *q)
>>> +{
>>> +    struct ap_matrix_mdev *matrix_mdev = q->matrix_mdev;
>>> +
>>> +    if (!matrix_mdev)
>>> +        return;
>>> +

You should probably check whether the APID has been cleared before
proceeding. Take the case where an AP with multiple queues is removed
from the configuration via the SE or SCLP. The AP bus is going to invoke
the vfio_ap_queue_dev_remove() function for each of the queues. The APID
will get cleared on the first remove, so it is not only unnecessary to
clear it on subsequent removes, it is kind of nasty to keep resetting
the masks in the guest's CRYCB (below) each time the remove callback is
invoked.

>>> +    clear_bit_inv(AP_QID_CARD(q->apqn), matrix_mdev->matrix.apm);
>>> +
>>> +    if (!matrix_mdev->kvm)
>>> +        return;
>>> +
>>> +    kvm_arch_crypto_set_masks(matrix_mdev->kvm,
>>> +                  matrix_mdev->matrix.apm,
>>> +                  matrix_mdev->matrix.aqm,
>>> +                  matrix_mdev->matrix.adm);
>>> +}
>>> +
>>> +/**
>>>    * vfio_ap_queue_dev_remove:
>>>    *
>>>    * Free the associated vfio_ap_queue structure
>>> @@ -70,6 +100,11 @@ static void vfio_ap_queue_dev_remove(struct 
>>> ap_device *apdev)
>>>       struct vfio_ap_queue *q;
>>>       q = dev_get_drvdata(&apdev->device);
>>> +    if (!q)
>>> +        return;
>>> +
>>> +    vfio_ap_update_crycb(q);
>>> +    vfio_ap_mdev_reset_queue(q);
>>
>> Since the bit corresponding to the APID is cleared in the
>> vfio_ap_update_crycb() above, shouldn't all queues on that
>> card also be reset?
> 
> I do not think so.
> The remove function will be called in a loop for all queues by the bus.
> No need to clear all queues.
> 
> 
>>
>>>       list_del(&q->list);
>>>       kfree(q);
>>>   }
>>> diff --git a/drivers/s390/crypto/vfio_ap_ops.c 
>>> b/drivers/s390/crypto/vfio_ap_ops.c
>>> index 0196065..5b9bb33 100644
>>> --- a/drivers/s390/crypto/vfio_ap_ops.c
>>> +++ b/drivers/s390/crypto/vfio_ap_ops.c
>>> @@ -59,6 +59,7 @@ int vfio_ap_mdev_reset_queue(struct vfio_ap_queue *q)
>>>               if (retry <= 0)
>>>                   pr_warn("%s: queue 0x%04x not empty\n",
>>>                       __func__, q->apqn);
>>> +            vfio_ap_free_irq(q);
>>
>> Shouldn't this be done for the response codes that terminate this loop
>> such as those caught by the default case?
> 
> I do not think so, the error code is returned and the caller may want to 
> reset the queue again.
> I think that doing the free inside the call to reset is not right.
> I will investigate in this direction.
> 
> Regards,
> Pierre
> 

