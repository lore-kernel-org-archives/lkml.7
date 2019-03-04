Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A60ADC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 09:47:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73FF920836
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 09:47:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726430AbfCDJrc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 04:47:32 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54534 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726104AbfCDJrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 04:47:31 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x249iqoh004391
        for <linux-kernel@vger.kernel.org>; Mon, 4 Mar 2019 04:47:30 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2r11649kyc-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2019 04:47:30 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Mon, 4 Mar 2019 09:47:28 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 4 Mar 2019 09:47:26 -0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x249lOHx30670856
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 4 Mar 2019 09:47:24 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7FBFF42045;
        Mon,  4 Mar 2019 09:47:24 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E016942042;
        Mon,  4 Mar 2019 09:47:23 +0000 (GMT)
Received: from [9.152.224.140] (unknown [9.152.224.140])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  4 Mar 2019 09:47:23 +0000 (GMT)
Reply-To: pmorel@linux.ibm.com
Subject: Re: [PATCH v4 5/7] s390: ap: implement PAPQ AQIC interception in
 kernel
To:     Halil Pasic <pasic@linux.ibm.com>
Cc:     borntraeger@de.ibm.com, alex.williamson@redhat.com,
        cohuck@redhat.com, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        frankja@linux.ibm.com, akrowiak@linux.ibm.com, david@redhat.com,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        freude@linux.ibm.com, mimu@linux.ibm.com
References: <1550849400-27152-1-git-send-email-pmorel@linux.ibm.com>
 <1550849400-27152-6-git-send-email-pmorel@linux.ibm.com>
 <20190304025739.17d0f245@oc2783563651>
From:   Pierre Morel <pmorel@linux.ibm.com>
Date:   Mon, 4 Mar 2019 10:47:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190304025739.17d0f245@oc2783563651>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19030409-0008-0000-0000-000002C83C6D
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19030409-0009-0000-0000-000022343DD5
Message-Id: <d7db1c40-3c97-4542-f592-f4b36d0adfa2@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-04_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903040072
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/03/2019 02:57, Halil Pasic wrote:
> On Fri, 22 Feb 2019 16:29:58 +0100
> Pierre Morel <pmorel@linux.ibm.com> wrote:
> 
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
> [..]
>> + */
>> +static void vfio_ap_free_irq(struct vfio_ap_queue *q)
>> +{
>> +	if (!q)
>> +		return;
>> +	if (q->g_pfn)
>> +		vfio_unpin_pages(mdev_dev(q->matrix_mdev->mdev), &q->g_pfn, 1);
>> +	if (q->isc)
>> +		kvm_s390_gisc_unregister(q->matrix_mdev->kvm, q->isc);
> 
> Ain't isc 0 a perfectly legit isc?

Exact, even GIB interface always gives 5 back I should initialize the 
ISC to a bad value like > 7
Will do, thanks.

> 
>> +	q->nib = 0;
>> +	q->isc = 0;
>> +	q->g_pfn = 0;
>> +}
>> +
> [..]
>> @@ -109,10 +131,16 @@ static int vfio_ap_mdev_create(struct kobject *kobj, struct mdev_device *mdev)
>>   static int vfio_ap_mdev_remove(struct mdev_device *mdev)
>>   {
>>   	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
>> +	struct vfio_ap_queue *q, *qtmp;
>>   
>>   	if (matrix_mdev->kvm)
>>   		return -EBUSY;
>>   
>> +	list_for_each_entry_safe(q, qtmp, &matrix_mdev->qlist, list) {
>> +		q->matrix_mdev = NULL;
>> +		vfio_ap_mdev_reset_queue(q);
>> +		list_move(&q->list, &matrix_dev->free_list);
> 
> How about matrix_dev->lock? I guess you should protect free_list with
> it. If not maybe a code comment would help not stumble over this.

Conny already commented that I forgot locks
I need a lock there and in the interception. May be more, I will check.

> 
>> +	}
>>   	mutex_lock(&matrix_dev->lock);
>>   	list_del(&matrix_mdev->node);
>>   	mutex_unlock(&matrix_dev->lock);
> 
> [..]
> 
>> +/**
>> + * vfio_ap_setirq: Enable Interruption for a APQN
>> + *
>> + * @dev: the device associated with the ap_queue
>> + * @q:   the vfio_ap_queue holding AQIC parameters
>> + *
>> + * Pin the NIB saved in *q
>> + * Register the guest ISC to GIB interface and retrieve the
>> + * host ISC to issue the host side PQAP/AQIC
>> + *
>> + * Response.status may be set to following Response Code in case of error:
>> + * - AP_RESPONSE_INVALID_ADDRESS: vfio_pin_pages failed
>> + * - AP_RESPONSE_OTHERWISE_CHANGED: Hypervizor GISA internal error
>> + *
>> + * Otherwise return the ap_queue_status returned by the ap_aqic()
>> + */
>> +static struct ap_queue_status vfio_ap_setirq(struct vfio_ap_queue *q)
>> +{
>> +	struct ap_qirq_ctrl aqic_gisa = {};
>> +	struct ap_queue_status status = {};
>> +	struct kvm_s390_gisa *gisa;
>> +	struct kvm *kvm;
>> +	unsigned long g_pfn, h_nib, h_pfn;
>> +	int ret;
>> +
>> +	kvm = q->matrix_mdev->kvm;
>> +	gisa = kvm->arch.gisa_int.origin;
>> +
>> +	g_pfn = q->nib >> PAGE_SHIFT;
>> +	ret = vfio_pin_pages(mdev_dev(q->matrix_mdev->mdev), &g_pfn, 1,
>> +			     IOMMU_READ | IOMMU_WRITE, &h_pfn);
>> +	switch (ret) {
>> +	case 1:
>> +		break;
>> +	case -EINVAL:
>> +	case -E2BIG:
>> +		status.response_code = AP_RESPONSE_INVALID_ADDRESS;
>> +		/* Fallthrough */
>> +	default:
>> +		return status;
>> +	}
>> +
>> +	h_nib = (h_pfn << PAGE_SHIFT) | (q->nib & ~PAGE_MASK);
>> +	aqic_gisa.gisc = q->isc;
>> +	aqic_gisa.isc = kvm_s390_gisc_register(kvm, q->isc);
>> +	aqic_gisa.ir = 1;
>> +	aqic_gisa.gisa = gisa->next_alert >> 4;
>> +
>> +	status = ap_aqic(q->apqn, aqic_gisa, (void *)h_nib);
>> +	switch (status.response_code) {
>> +	case AP_RESPONSE_NORMAL:
>> +		if (q->g_pfn)
>> +			vfio_unpin_pages(mdev_dev(q->matrix_mdev->mdev),
>> +					 &q->g_pfn, 1);
> 
> Shouldn't you call kvm_s390_gisc_unregister() here.

I should.


> 
>> +		q->g_pfn = g_pfn;
>> +		break;
>> +	case AP_RESPONSE_OTHERWISE_CHANGED:
>> +		vfio_unpin_pages(mdev_dev(q->matrix_mdev->mdev), &g_pfn, 1);
> 
> and here.

too

> 
>> +		break;
>> +	case AP_RESPONSE_INVALID_GISA:
>> +		status.response_code = AP_RESPONSE_INVALID_ADDRESS;
>> +	default:	/* Fall Through */
>> +		pr_warn("%s: apqn %04x: response: %02x\n", __func__, q->apqn,
>> +			status.response_code);
>> +		vfio_ap_free_irq(q);
> 
> This guy won't unpin g_pfn but only q->g_pfn if not zero :/

OK, seems I have to rework this all.
Thanks.

> 
>> +		break;
>> +	}
>> +
>> +	return status;
>> +}
>> +
>> +/**
>> + * handle_pqap: PQAP instruction callback
>> + *
>> + * @vcpu: The vcpu on which we received the PQAP instruction
>> + *
>> + * Get the general register contents to initialize internal variables.
>> + * REG[0]: APQN
>> + * REG[1]: IR and ISC
>> + * REG[2]: NIB
>> + *
>> + * Response.status may be set to following Response Code:
>> + * - AP_RESPONSE_Q_NOT_AVAIL: if the queue is not available
>> + * - AP_RESPONSE_DECONFIGURED: if the queue is not configured
>> + * - AP_RESPONSE_NORMAL (0) : in case of successs
>> + *   Check vfio_ap_setirq() and vfio_ap_clrirq() for other possible
>> RC.
>> + *
>> + * Return 0 if we could handle the request inside KVM.
>> + * otherwise, returns -EOPNOTSUPP to let QEMU handle the fault.
>> + */
>> +static int handle_pqap(struct kvm_vcpu *vcpu)
>> +{
>> +	uint64_t status;
>> +	uint16_t apqn;
>> +	struct vfio_ap_queue *q;
>> +	struct ap_queue_status qstatus = {};
>> +	struct ap_matrix_mdev *matrix_mdev;
>> +
>> +	/* If we do not use the AIV facility just go to userland */
>> +	if (!(vcpu->arch.sie_block->eca & ECA_AIV))
>> +		return -EOPNOTSUPP;
>> +
>> +	apqn = vcpu->run->s.regs.gprs[0] & 0xffff;
>> +	matrix_mdev = vcpu->kvm->arch.crypto.vfio_private;
>> +	if (!matrix_mdev)
>> +		return -EOPNOTSUPP;
>> +	q = vfio_ap_get_queue(apqn, &matrix_mdev->qlist);
> 
> This get is not a 'refcount affecting get' any more...
> 
>> +	if (!q) {
>> +		qstatus.response_code = AP_RESPONSE_Q_NOT_AVAIL;
>> +		goto out;
>> +	}
>> +
>> +	status = vcpu->run->s.regs.gprs[1];
>> +
>> +	/* If IR bit(16) is set we enable the interrupt */
>> +	if ((status >> (63 - 16)) & 0x01) {
>> +		q->isc = status & 0x07;
>> +		q->nib = vcpu->run->s.regs.gprs[2];
> 
> ... and I don't see what should prevent a potential use after free here.

I think this will be corrected when I add the lock I forgot in handle_pqap.


Thanks for the comments,

Regards,
Pierre


-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany

