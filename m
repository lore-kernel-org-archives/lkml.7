Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 637E4C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 14:47:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30E812083D
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 14:47:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727711AbfCSOrO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 10:47:14 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41846 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727382AbfCSOrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 10:47:13 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2JEjibk091131
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 10:47:12 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2rb2fn82am-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 10:47:11 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Tue, 19 Mar 2019 14:47:04 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 19 Mar 2019 14:47:02 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2JEl5FN26738746
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 19 Mar 2019 14:47:06 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DFA79AE051;
        Tue, 19 Mar 2019 14:47:05 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4BD8BAE045;
        Tue, 19 Mar 2019 14:47:05 +0000 (GMT)
Received: from [9.145.41.62] (unknown [9.145.41.62])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 19 Mar 2019 14:47:05 +0000 (GMT)
Reply-To: pmorel@linux.ibm.com
Subject: Re: [PATCH v5 4/7] s390: ap: setup relation betwen KVM and mediated
 device
From:   Pierre Morel <pmorel@linux.ibm.com>
To:     Halil Pasic <pasic@linux.ibm.com>
Cc:     borntraeger@de.ibm.com, alex.williamson@redhat.com,
        cohuck@redhat.com, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        frankja@linux.ibm.com, akrowiak@linux.ibm.com, david@redhat.com,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        freude@linux.ibm.com, mimu@linux.ibm.com
References: <1552493104-30510-1-git-send-email-pmorel@linux.ibm.com>
 <1552493104-30510-5-git-send-email-pmorel@linux.ibm.com>
 <20190315191557.6c8d7668@oc2783563651>
 <7c199329-0e82-ff61-46b7-78237a0f01ce@linux.ibm.com>
 <20190319125425.0cf5324e@oc2783563651>
 <2c459ebe-2b37-72bc-1ede-b196e54dc78d@linux.ibm.com>
Date:   Tue, 19 Mar 2019 15:47:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <2c459ebe-2b37-72bc-1ede-b196e54dc78d@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19031914-0020-0000-0000-000003253088
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19031914-0021-0000-0000-000021774A65
Message-Id: <dc32eea1-31c9-790e-f012-71259e51cb8c@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-19_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903190109
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/03/2019 15:23, Pierre Morel wrote:
> On 19/03/2019 12:54, Halil Pasic wrote:
>> On Tue, 19 Mar 2019 10:38:42 +0100
>> Pierre Morel <pmorel@linux.ibm.com> wrote:
>>
>>> On 15/03/2019 19:15, Halil Pasic wrote:
>>>> On Wed, 13 Mar 2019 17:05:01 +0100
>>>> Pierre Morel <pmorel@linux.ibm.com> wrote:
>>>>
>>>>> When the mediated device is open we setup the relation with KVM 
>>>>> unset it
>>>>> when the mediated device is released.
>>>>>
>>>>> We ensure KVM is present on opening of the mediated device.
>>>>>
>>>>> We ensure that KVM survives the mediated device, and establish a 
>>>>> direct
>>>>
>>>> survives?
>>>
>>> what alternative do you prefer?
>>>
>>
>> Increase kvm's refcount to ensure the guest is alive when the
>> ap_matrix_mdev is active. An ap mp_matrix becomes active with
>> a successful open() and ceases to be active with a release().
> 
> Right, it is mdev usage not mdev.
> 
>>
>> Your sentence was materially wrong as the mdev is allowed to outlive
>> the KVM. BTW survive tends to have an 'in spite of' note to it, which
>> outlive does not. vfio-ap is, I hope, not a calamity that threatens
>> the life of KVM ;). https://en.oxforddictionaries.com/definition/survive
> 
> Thanks, your description is much better.
> 
>>
>>>>
>>>>> link from KVM to the mediated device to simplify the relationship.
>>>>>
>>>>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>>>>> ---
>>>
>>> ...snip...
>>>
>>>>>    static int vfio_ap_mdev_group_notifier(struct notifier_block *nb,
>>>>>                           unsigned long action, void *data)
>>>>>    {
>>>>> -    int ret;
>>>>>        struct ap_matrix_mdev *matrix_mdev;
>>>>>        if (action != VFIO_GROUP_NOTIFY_SET_KVM)
>>>>>            return NOTIFY_OK;
>>>>>        matrix_mdev = container_of(nb, struct ap_matrix_mdev, 
>>>>> group_notifier);
>>>>> -
>>>>> -    if (!data) {
>>>>> -        matrix_mdev->kvm = NULL;
>>>>> -        return NOTIFY_OK;
>>>>> -    }
>>>>> -
>>>>> -    ret = vfio_ap_mdev_set_kvm(matrix_mdev, data);
>>>>> -    if (ret)
>>>>> -        return NOTIFY_DONE;
>>>>> -
>>>>> -    /* If there is no CRYCB pointer, then we can't copy the masks */
>>>>> -    if (!matrix_mdev->kvm->arch.crypto.crycbd)
>>>>> -        return NOTIFY_DONE;
>>>>> -
>>>>> -    kvm_arch_crypto_set_masks(matrix_mdev->kvm, 
>>>>> matrix_mdev->matrix.apm,
>>>>> -                  matrix_mdev->matrix.aqm,
>>>>> -                  matrix_mdev->matrix.adm);
>>>>> +    matrix_mdev->kvm = data;
>>>>>        return NOTIFY_OK;
>>>>>    }
>>>>> @@ -888,6 +873,12 @@ static int vfio_ap_mdev_open(struct 
>>>>> mdev_device *mdev)
>>>>>        if (ret)
>>>>>            goto err_group;
>>>>> +    /* We do not support opening the mediated device without KVM */
>>>>> +    if (!matrix_mdev->kvm) {
>>>>> +        ret = -ENODEV;
>>>>> +        goto err_group;
>>>>> +    }
>>>>> +
>>>>>        matrix_mdev->iommu_notifier.notifier_call = 
>>>>> vfio_ap_mdev_iommu_notifier;
>>>>>        events = VFIO_IOMMU_NOTIFY_DMA_UNMAP;
>>>>> @@ -896,8 +887,15 @@ static int vfio_ap_mdev_open(struct 
>>>>> mdev_device *mdev)
>>>>>        if (ret)
>>>>>            goto err_iommu;
>>>>> +    ret = vfio_ap_mdev_set_kvm(matrix_mdev);
>>>>
>>>> At this point the matrix_mdev->kvm ain't guaranteed to be valid 
>>>> IMHO. Or
>>>> am I wrong? If I'm right kvm_get_kvm(matrix_mdev->kvm) could be too 
>>>> late.
>>>
>>> What about the if (!matrix_mdev->kvm) 10 lines above ?
>>>
>>
>> That check is not sufficient.
>>
>> You should do the kvm_get_kvm() in vfio_ap_mdev_group_notifier(). VFIO
>> must ensure that the kvm pointer you get is valid, in a sense that it
>> points to a valid struct kvm and the kvm object is alive, while you are
>> in the callback. But not beyond.
>>
>> If another thread were to decrement the refcount of the kvm object you
>> would end up with matrix_mdev->kvm pointing to an object that has already
>> died.
>>
>> Does my analysis make sense to you?
> 
> Yes thanks the explication is good, it would have been worth to get it 
> the first time.
> 
>>
>>>>
>>>>> +    if (ret)
>>>>> +        goto err_kvm;
>>>>> +
>>>>>        return 0;
>>>>> +err_kvm:
>>>>> +    vfio_unregister_notifier(mdev_dev(mdev), VFIO_IOMMU_NOTIFY,
>>>>> +                 &matrix_mdev->iommu_notifier);
>>>>>    err_iommu:
>>>>>        vfio_unregister_notifier(mdev_dev(mdev), VFIO_GROUP_NOTIFY,
>>>>>                     &matrix_mdev->group_notifier);
>>>>> @@ -906,19 +904,33 @@ static int vfio_ap_mdev_open(struct 
>>>>> mdev_device *mdev)
>>>>>        return ret;
>>>>>    }
>>>>> -static void vfio_ap_mdev_release(struct mdev_device *mdev)
>>>>> +static int vfio_ap_mdev_unset_kvm(struct ap_matrix_mdev *matrix_mdev)
>>>>>    {
>>>>> -    struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
>>>>> +    struct kvm *kvm = matrix_mdev->kvm;
>>>>>        if (matrix_mdev->kvm)
>>>>>            kvm_arch_crypto_clear_masks(matrix_mdev->kvm);
>>>>
>>>> This still conditional?
>>>
>>> Yes, nothing to clear if there is no KVM.
>>>
>>
>> Since we have ensured the open only works if there is a KVM at that
>> point in time, and we have taken a reference to KVM, I would expect
>> KVM can not go away before we give up our reference.
> 
> Right.

Right but based on the assumption we do a kvm_get_kvm() during open.

But now we will do it inside the notifier, so the logic is to do a 
kvm_put_kvm in the notifier too.
This is important because userland will ask us to release the KVM/VFIO 
link through this notifier.
So I will have to rework this part where KVM==NULL in the notifier too.

Regards,
Pierre


-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany

