Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8649C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 13:23:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F00620700
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 13:23:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729641AbfC2NX2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 09:23:28 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46876 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729524AbfC2NX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 09:23:27 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2TDMtfN040946
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 09:23:26 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2rhk24v2sn-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 09:23:03 -0400
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <akrowiak@linux.ibm.com>;
        Fri, 29 Mar 2019 13:14:55 -0000
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 29 Mar 2019 13:14:52 -0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2TDEnOR11665484
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Mar 2019 13:14:49 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 29F1E28059;
        Fri, 29 Mar 2019 13:14:49 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7BCA528058;
        Fri, 29 Mar 2019 13:14:48 +0000 (GMT)
Received: from [9.80.196.185] (unknown [9.80.196.185])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 29 Mar 2019 13:14:48 +0000 (GMT)
Subject: Re: [PATCH v6 4/7] vfio: ap: register IOMMU VFIO notifier
To:     pmorel@linux.ibm.com, borntraeger@de.ibm.com
Cc:     alex.williamson@redhat.com, cohuck@redhat.com,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, frankja@linux.ibm.com, pasic@linux.ibm.com,
        david@redhat.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, freude@linux.ibm.com, mimu@linux.ibm.com
References: <1553265828-27823-1-git-send-email-pmorel@linux.ibm.com>
 <1553265828-27823-5-git-send-email-pmorel@linux.ibm.com>
 <1731fb82-7877-9018-d12e-fd0e2406ac19@linux.ibm.com>
 <7a4bf9f1-5046-5838-a50d-8402782c880f@linux.ibm.com>
From:   Tony Krowiak <akrowiak@linux.ibm.com>
Date:   Fri, 29 Mar 2019 09:14:48 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <7a4bf9f1-5046-5838-a50d-8402782c880f@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19032913-0064-0000-0000-000003C27663
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010834; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000283; SDB=6.01181366; UDB=6.00618317; IPR=6.00962086;
 MB=3.00026208; MTD=3.00000008; XFM=3.00000015; UTC=2019-03-29 13:14:55
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19032913-0065-0000-0000-00003CE06C02
Message-Id: <9af30e31-e4d8-160e-d7a1-8365185d2933@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-29_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903290097
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/29/19 5:31 AM, Pierre Morel wrote:
> On 28/03/2019 21:46, Tony Krowiak wrote:
>> On 3/22/19 10:43 AM, Pierre Morel wrote:
>>> To be able to use the VFIO interface to facilitate the
>>> mediated device memory pinning/unpinning we need to register
>>> a notifier for IOMMU.
>>>
>>> While we will start to pin one guest page for the interrupt indicator
>>> byte, this is still ok with ballooning as this page will never be
>>> used by the guest virtio-balloon driver.
>>> So the pinned page will never be freed. And even a broken guest does
>>> so, that would not impact the host as the original page is still
>>> in control by vfio.
>>
>> I apologize, but I do not understand what you are saying in the second
>> sentence of the paragraph above. Why will the pinned page never be freed?
> Because it is in use by the guest's kernel as a notification information 
> byte for the original PQAP AQIC.

Your comment says the pinned page will never be free, doesn't it get
freed when the guest is terminated?

> 
>   I understand that the pinned page is under the control of vfio
>> until it is freed, but have no idea what you mean by "and even a broken
>> guest does so"? A broken guest does what? Can you please reword this so
>> it makes more sense?
> 
> A broken guest could free the page used for the NIB. What is obviously 
> wrong.

Then why not simply say a pinned page is under the control of the
vfio driver, so if a broken (malicious?) guest frees the page, it will
not impact the host or something to that effect.

> 
>>
>>>
>>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>>> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
>>> ---
>>>   drivers/s390/crypto/vfio_ap_ops.c     | 38 
>>> +++++++++++++++++++++++++++++++++++
>>>   drivers/s390/crypto/vfio_ap_private.h |  2 ++
>>>   2 files changed, 40 insertions(+)
>>>
>>> diff --git a/drivers/s390/crypto/vfio_ap_ops.c 
>>> b/drivers/s390/crypto/vfio_ap_ops.c
>>> index bdb36e0..3478499 100644
>>> --- a/drivers/s390/crypto/vfio_ap_ops.c
>>> +++ b/drivers/s390/crypto/vfio_ap_ops.c
>>> @@ -787,6 +787,35 @@ static const struct attribute_group 
>>> *vfio_ap_mdev_attr_groups[] = {
>>>       NULL
>>>   };
>>> +/**
>>> + * vfio_ap_mdev_iommu_notifier: IOMMU notifier callback
>>> + *
>>> + * @nb: The notifier block
>>> + * @action: Action to be taken
>>> + * @data: data associated with the request
>>> + *
>>> + * For an UNMAP request, unpin the guest IOVA (the NIB guest address we
>>> + * pinned before). Other requests are ignored.
>>> + *
>>> + */
>>> +static int vfio_ap_mdev_iommu_notifier(struct notifier_block *nb,
>>> +                       unsigned long action, void *data)
>>> +{
>>> +    struct ap_matrix_mdev *matrix_mdev;
>>> +
>>> +    matrix_mdev = container_of(nb, struct ap_matrix_mdev, 
>>> iommu_notifier);
>>> +
>>
>> I don't understand why we registered this notifier. I may be wrong, but
>> AFAIU, this notifier will be invoked only when the VFIO_IOMMU_UNMAP_DMA
>> ioctl is called from userspace. I did an experiment and inserted some
>> printf's to see if this ever gets called and verified it does not. Maybe
>> you have a good reason of which I'm not aware. Can you enlighten me
>> here?
> 
> The vfio_iommu_type1 pin page requires a notifier.
> 
> Regards,
> Pierre
> 

