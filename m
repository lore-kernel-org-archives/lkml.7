Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C34E4C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 09:36:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D92E2087E
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 09:36:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733301AbfCAJf7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 04:35:59 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44838 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1733133AbfCAJf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 04:35:58 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x219T7Z0114306
        for <linux-kernel@vger.kernel.org>; Fri, 1 Mar 2019 04:35:57 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qy1tk9bwt-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2019 04:35:57 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Fri, 1 Mar 2019 09:35:54 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 1 Mar 2019 09:35:51 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x219ZnF627525144
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 1 Mar 2019 09:35:49 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 75ECB11C054;
        Fri,  1 Mar 2019 09:35:49 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E329711C04A;
        Fri,  1 Mar 2019 09:35:48 +0000 (GMT)
Received: from [9.152.224.140] (unknown [9.152.224.140])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  1 Mar 2019 09:35:48 +0000 (GMT)
Reply-To: pmorel@linux.ibm.com
Subject: Re: [PATCH v4 5/7] s390: ap: implement PAPQ AQIC interception in
 kernel
To:     Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     alex.williamson@redhat.com, cohuck@redhat.com,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, frankja@linux.ibm.com, akrowiak@linux.ibm.com,
        pasic@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, freude@linux.ibm.com, mimu@linux.ibm.com
References: <1550849400-27152-1-git-send-email-pmorel@linux.ibm.com>
 <1550849400-27152-6-git-send-email-pmorel@linux.ibm.com>
 <a7be3d71-6392-4ff3-5bd5-60429b8a61c0@de.ibm.com>
From:   Pierre Morel <pmorel@linux.ibm.com>
Date:   Fri, 1 Mar 2019 10:35:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <a7be3d71-6392-4ff3-5bd5-60429b8a61c0@de.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19030109-0008-0000-0000-000002C66DFC
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19030109-0009-0000-0000-00002232C2C3
Message-Id: <44146ea5-8bdf-e986-6e6d-9cbfc104ba37@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-01_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903010066
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/02/2019 21:20, Christian Borntraeger wrote:
> 
> 
> On 22.02.2019 16:29, Pierre Morel wrote:
>> We register the AP PQAP instruction hook during the open
>> of the mediated device. And unregister it on release.
>>
>> In the AP PQAP instruction hook, if we receive a demand to
>> enable IRQs,
>> - we retrieve the vfio_ap_queue based on the APQN we receive
>>    in REG1,
>> - we retrieve the page of the guest address, (NIB), from
>>    register REG2
>> - we the mediated device to use the VFIO pinning infratrsucture
>>    to pin the page of the guest address,
>> - we retrieve the pointer to KVM to register the guest ISC
>>    and retrieve the host ISC
>> - finaly we activate GISA
>>
>> If we receive a demand to disable IRQs,
>> - we deactivate GISA
>> - unregister from the GIB
>> - unping the NIB
>>
>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>> ---
>>   arch/s390/include/asm/kvm_host.h      |   1 +
>>   drivers/s390/crypto/ap_bus.h          |   1 +
>>   drivers/s390/crypto/vfio_ap_ops.c     | 199 +++++++++++++++++++++++++++++++++-
>>   drivers/s390/crypto/vfio_ap_private.h |   1 +
>>   4 files changed, 199 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
>> index 49cc8b0..5f3bb8c 100644
>> --- a/arch/s390/include/asm/kvm_host.h
>> +++ b/arch/s390/include/asm/kvm_host.h
>> @@ -720,6 +720,7 @@ struct kvm_s390_cpu_model {
>>   struct kvm_s390_crypto {
>>   	struct kvm_s390_crypto_cb *crycb;
>>   	int (*pqap_hook)(struct kvm_vcpu *vcpu);
>> +	void *vfio_private;
>>   	__u32 crycbd;
>>   	__u8 aes_kw;
>>   	__u8 dea_kw;
>> diff --git a/drivers/s390/crypto/ap_bus.h b/drivers/s390/crypto/ap_bus.h
>> index bfc66e4..323f2aa 100644
>> --- a/drivers/s390/crypto/ap_bus.h
>> +++ b/drivers/s390/crypto/ap_bus.h
>> @@ -43,6 +43,7 @@ static inline int ap_test_bit(unsigned int *ptr, unsigned int nr)
>>   #define AP_RESPONSE_BUSY		0x05
>>   #define AP_RESPONSE_INVALID_ADDRESS	0x06
>>   #define AP_RESPONSE_OTHERWISE_CHANGED	0x07
>> +#define AP_RESPONSE_INVALID_GISA	0x08
>>   #define AP_RESPONSE_Q_FULL		0x10
>>   #define AP_RESPONSE_NO_PENDING_REPLY	0x10
>>   #define AP_RESPONSE_INDEX_TOO_BIG	0x11
>> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
>> index 1b5130a..0196065 100644
>> --- a/drivers/s390/crypto/vfio_ap_ops.c
>> +++ b/drivers/s390/crypto/vfio_ap_ops.c
>> @@ -43,7 +43,7 @@ struct vfio_ap_queue *vfio_ap_get_queue(int apqn, struct list_head *l)
>>   	return NULL;
>>   }
>>   
>> -static int vfio_ap_mdev_reset_queue(struct vfio_ap_queue *q)
>> +int vfio_ap_mdev_reset_queue(struct vfio_ap_queue *q)
>>   {
>>   	struct ap_queue_status status;
>>   	int retry = 20;
>> @@ -75,6 +75,27 @@ static int vfio_ap_mdev_reset_queue(struct vfio_ap_queue *q)
>>   	return -EBUSY;
>>   }
>>   
>> +/**
>> + * vfio_ap_free_irq:
>> + * @q: The vfio_ap_queue
>> + *
>> + * Unpin the guest NIB
>> + * Unregister the ISC from the GIB alert
>> + * Clear the vfio_ap_queue intern fields
>> + */
>> +static void vfio_ap_free_irq(struct vfio_ap_queue *q)
>> +{
>> +	if (!q)
>> +		return;
>> +	if (q->g_pfn)
>> +		vfio_unpin_pages(mdev_dev(q->matrix_mdev->mdev), &q->g_pfn, 1);
>> +	if (q->isc)
>> +		kvm_s390_gisc_unregister(q->matrix_mdev->kvm, q->isc);
>> +	q->nib = 0;
>> +	q->isc = 0;
>> +	q->g_pfn = 0;
>> +}
> 
> Pierre, unless there is some magic, I think we need to free the gisa stuff before kvm exit.
> 
> Imagine a malicious userspace that setups everything fine, but then closes all kvm file
> descriptors but not the vfio file descriptor. This might result in random access to the
> memory that contained the gisa potentially resulting in random memory overwrites.
> 
> the problem is that kvm_destroy_vm calls kvm_arch_destroy_vm(kvm) before it calls
> kvm_destroy_devices(kvm); So we already free the gisa before we do the unregister call.
> 
> What about calling kvm_get_kvm/put from some of the callbacks in the right places.
> 
> Debugging random memory overwrites is a PITA, so we either should document why I cannot
> happen (even with malicious userspace) or simply fix the refcounting.
> 

OK, understood.
I think we can do something simple by using kvm_get/kvm_put, as you 
suggested, in the vfio KVM notifier to ensure the order of the calls and 
also unregister the GISA at this moment.
I will investigate in this direction.

Thanks
Pierre




-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany

