Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C373C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 09:31:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 166852082F
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 09:31:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728685AbfC2JbS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 05:31:18 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55664 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727083AbfC2JbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 05:31:17 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2T9PUTX041035
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 05:31:16 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2rhek9765j-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 05:31:15 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Fri, 29 Mar 2019 09:31:13 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 29 Mar 2019 09:31:11 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2T9V9WY61407254
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Mar 2019 09:31:09 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 69CEC11C054;
        Fri, 29 Mar 2019 09:31:09 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E51D811C058;
        Fri, 29 Mar 2019 09:31:08 +0000 (GMT)
Received: from [9.152.222.62] (unknown [9.152.222.62])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 29 Mar 2019 09:31:08 +0000 (GMT)
Reply-To: pmorel@linux.ibm.com
Subject: Re: [PATCH v6 4/7] vfio: ap: register IOMMU VFIO notifier
To:     Tony Krowiak <akrowiak@linux.ibm.com>, borntraeger@de.ibm.com
Cc:     alex.williamson@redhat.com, cohuck@redhat.com,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, frankja@linux.ibm.com, pasic@linux.ibm.com,
        david@redhat.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, freude@linux.ibm.com, mimu@linux.ibm.com
References: <1553265828-27823-1-git-send-email-pmorel@linux.ibm.com>
 <1553265828-27823-5-git-send-email-pmorel@linux.ibm.com>
 <1731fb82-7877-9018-d12e-fd0e2406ac19@linux.ibm.com>
From:   Pierre Morel <pmorel@linux.ibm.com>
Date:   Fri, 29 Mar 2019 10:31:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <1731fb82-7877-9018-d12e-fd0e2406ac19@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19032909-0028-0000-0000-00000359EC9A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19032909-0029-0000-0000-00002418B0AF
Message-Id: <7a4bf9f1-5046-5838-a50d-8402782c880f@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-29_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903290069
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/03/2019 21:46, Tony Krowiak wrote:
> On 3/22/19 10:43 AM, Pierre Morel wrote:
>> To be able to use the VFIO interface to facilitate the
>> mediated device memory pinning/unpinning we need to register
>> a notifier for IOMMU.
>>
>> While we will start to pin one guest page for the interrupt indicator
>> byte, this is still ok with ballooning as this page will never be
>> used by the guest virtio-balloon driver.
>> So the pinned page will never be freed. And even a broken guest does
>> so, that would not impact the host as the original page is still
>> in control by vfio.
> 
> I apologize, but I do not understand what you are saying in the second
> sentence of the paragraph above. Why will the pinned page never be 
> freed?
Because it is in use by the guest's kernel as a notification information 
byte for the original PQAP AQIC.

  I understand that the pinned page is under the control of vfio
> until it is freed, but have no idea what you mean by "and even a broken
> guest does so"? A broken guest does what? Can you please reword this so
> it makes more sense?

A broken guest could free the page used for the NIB. What is obviously 
wrong.

> 
>>
>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
>> ---
>>   drivers/s390/crypto/vfio_ap_ops.c     | 38 
>> +++++++++++++++++++++++++++++++++++
>>   drivers/s390/crypto/vfio_ap_private.h |  2 ++
>>   2 files changed, 40 insertions(+)
>>
>> diff --git a/drivers/s390/crypto/vfio_ap_ops.c 
>> b/drivers/s390/crypto/vfio_ap_ops.c
>> index bdb36e0..3478499 100644
>> --- a/drivers/s390/crypto/vfio_ap_ops.c
>> +++ b/drivers/s390/crypto/vfio_ap_ops.c
>> @@ -787,6 +787,35 @@ static const struct attribute_group 
>> *vfio_ap_mdev_attr_groups[] = {
>>       NULL
>>   };
>> +/**
>> + * vfio_ap_mdev_iommu_notifier: IOMMU notifier callback
>> + *
>> + * @nb: The notifier block
>> + * @action: Action to be taken
>> + * @data: data associated with the request
>> + *
>> + * For an UNMAP request, unpin the guest IOVA (the NIB guest address we
>> + * pinned before). Other requests are ignored.
>> + *
>> + */
>> +static int vfio_ap_mdev_iommu_notifier(struct notifier_block *nb,
>> +                       unsigned long action, void *data)
>> +{
>> +    struct ap_matrix_mdev *matrix_mdev;
>> +
>> +    matrix_mdev = container_of(nb, struct ap_matrix_mdev, 
>> iommu_notifier);
>> +
> 
> I don't understand why we registered this notifier. I may be wrong, but
> AFAIU, this notifier will be invoked only when the VFIO_IOMMU_UNMAP_DMA
> ioctl is called from userspace. I did an experiment and inserted some
> printf's to see if this ever gets called and verified it does not. Maybe
> you have a good reason of which I'm not aware. Can you enlighten me
> here?

The vfio_iommu_type1 pin page requires a notifier.

Regards,
Pierre

-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany

