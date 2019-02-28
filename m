Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04E99C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 08:48:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5101205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 08:48:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731433AbfB1Isw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 03:48:52 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47296 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726038AbfB1Isw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 03:48:52 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1S8mnDX028963
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 03:48:50 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qxbk3aftc-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 03:48:50 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Thu, 28 Feb 2019 08:48:45 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 28 Feb 2019 08:48:42 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x1S8me9h37027886
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 28 Feb 2019 08:48:40 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 814CDA4040;
        Thu, 28 Feb 2019 08:48:40 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AB0C3A404D;
        Thu, 28 Feb 2019 08:48:39 +0000 (GMT)
Received: from [9.152.224.140] (unknown [9.152.224.140])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 28 Feb 2019 08:48:39 +0000 (GMT)
Reply-To: pmorel@linux.ibm.com
Subject: Re: [PATCH v4 4/7] vfio: ap: register IOMMU VFIO notifier
To:     Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     alex.williamson@redhat.com, cohuck@redhat.com,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, frankja@linux.ibm.com, akrowiak@linux.ibm.com,
        pasic@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, freude@linux.ibm.com, mimu@linux.ibm.com
References: <1550849400-27152-1-git-send-email-pmorel@linux.ibm.com>
 <1550849400-27152-5-git-send-email-pmorel@linux.ibm.com>
 <d90f4746-887f-2d9c-df37-c834f22e85fd@de.ibm.com>
From:   Pierre Morel <pmorel@linux.ibm.com>
Date:   Thu, 28 Feb 2019 09:48:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <d90f4746-887f-2d9c-df37-c834f22e85fd@de.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19022808-0008-0000-0000-000002C5EF6A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19022808-0009-0000-0000-000022323FFD
Message-Id: <f13769d5-26a4-c1fa-0858-e4a1acef7bb9@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-28_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902280063
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/02/2019 09:23, Christian Borntraeger wrote:
> On 22.02.2019 16:29, Pierre Morel wrote:
>> To be able to use the VFIO interface to facilitate the
>> mediated device memory pining/unpining we need to register
>> a notifier for IOMMU.
> 
> You might want to add that while we start to pin one guest page for the
> interrupt indicator byte in the next patch, this is still ok with ballooning
> as this page will never be used by the guest virtio-balloon driver. So the
> pinned page will never be freed. And even a broken guest does so, that would
> not impact the host as the original page is still in control by vfio.
> 

Thanks, I ll do.

Regards,
Pierre

>>
>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>> ---
>>   drivers/s390/crypto/vfio_ap_ops.c     | 53 ++++++++++++++++++++++++++++++++---
>>   drivers/s390/crypto/vfio_ap_private.h |  2 ++
>>   2 files changed, 51 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
>> index 172d6eb..1b5130a 100644
>> --- a/drivers/s390/crypto/vfio_ap_ops.c
>> +++ b/drivers/s390/crypto/vfio_ap_ops.c
>> @@ -748,6 +748,36 @@ static const struct attribute_group *vfio_ap_mdev_attr_groups[] = {
>>   };
>>   
>>   /**
>> + * vfio_ap_mdev_iommu_notifier: IOMMU notifier callback
>> + *
>> + * @nb: The notifier block
>> + * @action: Action to be taken (VFIO_IOMMU_NOTIFY_DMA_UNMAP)
>> + * @data: the specific unmap structure for vfio_iommu_type1
>> + *
>> + * Unpins the guest IOVA. (The NIB guest address we pinned before).
>> + * Return NOTIFY_OK after unpining on a UNMAP request.
>> + * otherwise, returns NOTIFY_DONE .
>> + */
>> +static int vfio_ap_mdev_iommu_notifier(struct notifier_block *nb,
>> +				       unsigned long action, void *data)
>> +{
>> +	struct ap_matrix_mdev *matrix_mdev;
>> +
>> +	matrix_mdev = container_of(nb, struct ap_matrix_mdev, iommu_notifier);
>> +
>> +	if (action == VFIO_IOMMU_NOTIFY_DMA_UNMAP) {
>> +		struct vfio_iommu_type1_dma_unmap *unmap = data;
>> +		unsigned long g_pfn = unmap->iova >> PAGE_SHIFT;
>> +
>> +		vfio_unpin_pages(mdev_dev(matrix_mdev->mdev), &g_pfn, 1);
>> +		return NOTIFY_OK;
>> +	}
>> +
>> +	return NOTIFY_DONE;
>> +}
>> +
>> +
>> +/**
>>    * vfio_ap_mdev_set_kvm
>>    *
>>    * @matrix_mdev: a mediated matrix device
>> @@ -846,12 +876,25 @@ static int vfio_ap_mdev_open(struct mdev_device *mdev)
>>   
>>   	ret = vfio_register_notifier(mdev_dev(mdev), VFIO_GROUP_NOTIFY,
>>   				     &events, &matrix_mdev->group_notifier);
>> -	if (ret) {
>> -		module_put(THIS_MODULE);
>> -		return ret;
>> -	}
>> +	if (ret)
>> +		goto err_group;
>> +
>> +	matrix_mdev->iommu_notifier.notifier_call = vfio_ap_mdev_iommu_notifier;
>> +	events = VFIO_IOMMU_NOTIFY_DMA_UNMAP;
>> +
>> +	ret = vfio_register_notifier(mdev_dev(mdev), VFIO_IOMMU_NOTIFY,
>> +				     &events, &matrix_mdev->iommu_notifier);
>> +	if (ret)
>> +		goto err_iommu;
>>   
>>   	return 0;
>> +
>> +err_iommu:
>> +	vfio_unregister_notifier(mdev_dev(mdev), VFIO_GROUP_NOTIFY,
>> +				 &matrix_mdev->group_notifier);
>> +err_group:
>> +	module_put(THIS_MODULE);
>> +	return ret;
>>   }
>>   
>>   static void vfio_ap_mdev_release(struct mdev_device *mdev)
>> @@ -864,6 +907,8 @@ static void vfio_ap_mdev_release(struct mdev_device *mdev)
>>   	vfio_ap_mdev_reset_queues(mdev);
>>   	vfio_unregister_notifier(mdev_dev(mdev), VFIO_GROUP_NOTIFY,
>>   				 &matrix_mdev->group_notifier);
>> +	vfio_unregister_notifier(mdev_dev(mdev), VFIO_IOMMU_NOTIFY,
>> +				 &matrix_mdev->iommu_notifier);
>>   	matrix_mdev->kvm = NULL;
>>   	module_put(THIS_MODULE);
>>   }
>> diff --git a/drivers/s390/crypto/vfio_ap_private.h b/drivers/s390/crypto/vfio_ap_private.h
>> index 2760178..e535735 100644
>> --- a/drivers/s390/crypto/vfio_ap_private.h
>> +++ b/drivers/s390/crypto/vfio_ap_private.h
>> @@ -81,8 +81,10 @@ struct ap_matrix_mdev {
>>   	struct list_head node;
>>   	struct ap_matrix matrix;
>>   	struct notifier_block group_notifier;
>> +	struct notifier_block iommu_notifier;
>>   	struct kvm *kvm;
>>   	struct list_head qlist;
>> +	struct mdev_device *mdev;
>>   };
>>   
>>   extern int vfio_ap_mdev_register(void);
>>


-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany

