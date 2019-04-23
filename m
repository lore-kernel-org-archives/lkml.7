Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36C1BC10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 14:53:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDA3A21738
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 14:53:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727690AbfDWOxr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 10:53:47 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60678 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726421AbfDWOxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 10:53:47 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3NEhnnc136685
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 10:53:46 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2s22fpf4qf-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 10:53:45 -0400
Received: from localhost
        by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <akrowiak@linux.ibm.com>;
        Tue, 23 Apr 2019 15:53:45 +0100
Received: from b03cxnp08028.gho.boulder.ibm.com (9.17.130.20)
        by e33.co.us.ibm.com (192.168.1.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 23 Apr 2019 15:53:42 +0100
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x3NErctY25165938
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Apr 2019 14:53:38 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AB047C6057;
        Tue, 23 Apr 2019 14:53:38 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 927C0C6055;
        Tue, 23 Apr 2019 14:53:37 +0000 (GMT)
Received: from [9.60.75.251] (unknown [9.60.75.251])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 23 Apr 2019 14:53:37 +0000 (GMT)
Subject: Re: [PATCH v2 7/8] s390: vfio-ap: handle bind and unbind of AP queue
 device
To:     pmorel@linux.ibm.com, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     freude@linux.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com,
        frankja@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, pasic@linux.ibm.com,
        alex.williamson@redhat.com, kwankhede@nvidia.com
References: <1555796980-27920-1-git-send-email-akrowiak@linux.ibm.com>
 <1555796980-27920-8-git-send-email-akrowiak@linux.ibm.com>
 <bf7ecaa0-a38c-9052-81e0-673ade8bc4d9@linux.ibm.com>
From:   Tony Krowiak <akrowiak@linux.ibm.com>
Date:   Tue, 23 Apr 2019 10:53:37 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <bf7ecaa0-a38c-9052-81e0-673ade8bc4d9@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19042314-0036-0000-0000-00000AAC0915
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010981; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000285; SDB=6.01193262; UDB=6.00625520; IPR=6.00974082;
 MB=3.00026559; MTD=3.00000008; XFM=3.00000015; UTC=2019-04-23 14:53:44
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19042314-0037-0000-0000-00004B7F640B
Message-Id: <5e4b9cd8-6ac3-eb07-b2fd-02254b6e7cf8@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-23_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904230100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/23/19 9:38 AM, Pierre Morel wrote:
> On 20/04/2019 23:49, Tony Krowiak wrote:
>> There is an implied guarantee that when an AP queue device is bound to a
>> device driver, that driver will have exclusive control over the device.
>> When an AP queue device is unbound from the vfio_ap driver while the
>> queue is in use by a guest and subsquently bound to a zcrypt driver, the
>> guarantee that the zcrypt driver has exclusive control of the queue
>> device will be violated. Likewise, when an AP queue device is bound to
>> the vfio_ap device driver and its APQN is assigned to an mdev device in
>> use by a guest, the expectation is that the guest will have access to
>> the queue.
>>
>> The purpose of this patch is to ensure three things:
>>
>> 1. When an AP queue device in use by a guest is unbound, the guest shall
>>     no longer access the queue. Due to the limitations of the
>>     architecture, access to a single queue can not be denied to a guest,
>>     so access to the AP card to which the queue is connected will be
>>     denied to the guest.
>>
>> 2. When an AP queue device with an APQN assigned to an mdev device is
>>     bound to the vfio_ap driver while the mdev device is in use by a 
>> guest,
>>     the guest shall be granted access to the queue.
>>
>> 3. When a guest is started, each APQN assigned to the guest's mdev device
>>     must be owned by the vfio_ap driver.
>>
>> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
>> ---
>>   drivers/s390/crypto/vfio_ap_drv.c     | 16 ++++++-
>>   drivers/s390/crypto/vfio_ap_ops.c     | 82 
>> ++++++++++++++++++++++++++++++++++-
>>   drivers/s390/crypto/vfio_ap_private.h |  2 +
>>   3 files changed, 97 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/s390/crypto/vfio_ap_drv.c 
>> b/drivers/s390/crypto/vfio_ap_drv.c
>> index e9824c35c34f..0f5dafddf5b1 100644
>> --- a/drivers/s390/crypto/vfio_ap_drv.c
>> +++ b/drivers/s390/crypto/vfio_ap_drv.c
>> @@ -42,12 +42,26 @@ MODULE_DEVICE_TABLE(vfio_ap, ap_queue_ids);
>>   static int vfio_ap_queue_dev_probe(struct ap_device *apdev)
>>   {
>> +    struct ap_queue *apq = to_ap_queue(&apdev->device);
>> +    unsigned long apid = AP_QID_CARD(apq->qid);
>> +    unsigned long apqi = AP_QID_QUEUE(apq->qid);
>> +
>> +    mutex_lock(&matrix_dev->lock);
>> +    vfio_ap_mdev_probe_queue(apid, apqi);
>> +    mutex_unlock(&matrix_dev->lock);
>> +
>>       return 0;
>>   }
>>   static void vfio_ap_queue_dev_remove(struct ap_device *apdev)
>>   {
>> -    /* Nothing to do yet */
>> +    struct ap_queue *apq = to_ap_queue(&apdev->device);
>> +    unsigned long apid = AP_QID_CARD(apq->qid);
>> +    unsigned long apqi = AP_QID_QUEUE(apq->qid);
>> +
>> +    mutex_lock(&matrix_dev->lock);
>> +    vfio_ap_mdev_remove_queue(apid, apqi);
>> +    mutex_unlock(&matrix_dev->lock);
>>   }
>>   static void vfio_ap_matrix_dev_release(struct device *dev)
>> diff --git a/drivers/s390/crypto/vfio_ap_ops.c 
>> b/drivers/s390/crypto/vfio_ap_ops.c
>> index 31ce30ee784d..3f9506516545 100644
>> --- a/drivers/s390/crypto/vfio_ap_ops.c
>> +++ b/drivers/s390/crypto/vfio_ap_ops.c
>> @@ -763,8 +763,8 @@ static void vfio_ap_mdev_wait_for_qempty(unsigned 
>> long apid, unsigned long apqi)
>>               msleep(20);
>>               break;
>>           default:
>> -            pr_warn("%s: tapq err %02x: 0x%04x may not be empty\n",
>> -                __func__, status.response_code, q->apqn);
>> +            pr_warn("%s: tapq err %02x: %02lx%04lx may not be empty\n",
>> +                __func__, status.response_code, apid, apqi);
>>               return;
>>           }
>>       } while (--retry);
>> @@ -823,6 +823,14 @@ static int vfio_ap_mdev_reset_queues(struct 
>> mdev_device *mdev)
>>   static int vfio_ap_mdev_create_shadow_crycb(struct ap_matrix_mdev 
>> *matrix_mdev)
>>   {
>> +    /*
>> +     * If an AP resource is not owned by the vfio_ap driver - e.g., 
>> it was
>> +     * unbound from the driver while still assigned to the mdev device
>> +     */
>> +    if (ap_apqn_in_matrix_owned_by_def_drv(matrix_mdev->matrix.apm,
>> +                           matrix_mdev->matrix.aqm))
>> +        return -EADDRNOTAVAIL;
>> +
>>       matrix_mdev->shadow_crycb = 
>> kzalloc(sizeof(*matrix_mdev->shadow_crycb),
>>                           GFP_KERNEL);
>>       if (!matrix_mdev->shadow_crycb)
>> @@ -847,6 +855,18 @@ static int vfio_ap_mdev_open(struct mdev_device 
>> *mdev)
>>       if (!try_module_get(THIS_MODULE))
>>           return -ENODEV;
>> +    ret = ap_apqn_in_matrix_owned_by_def_drv(matrix_mdev->matrix.apm,
>> +                         matrix_mdev->matrix.aqm);
>> +
>> +    /*
>> +     * If any APQN is owned by a default driver, it can not be used 
>> by the
>> +     * guest. This can happen if a queue is unbound from the vfio_ap
>> +     * driver but not unassigned from the mdev device.
>> +     */
>> +    ret = (ret == 1) ? -EADDRNOTAVAIL : ret;
>> +    if (ret)
>> +        return ret;
>> +
>>       matrix_mdev->group_notifier.notifier_call = 
>> vfio_ap_mdev_group_notifier;
>>       events = VFIO_GROUP_NOTIFY_SET_KVM;
>> @@ -938,3 +958,61 @@ void vfio_ap_mdev_unregister(void)
>>   {
>>       mdev_unregister_device(&matrix_dev->device);
>>   }
>> +
>> +static struct ap_matrix_mdev *vfio_ap_mdev_find_matrix_mdev(unsigned 
>> long apid,
>> +                                unsigned long apqi)
>> +{
>> +    struct ap_matrix_mdev *matrix_mdev;
>> +
>> +    list_for_each_entry(matrix_mdev, &matrix_dev->mdev_list, node) {
>> +        if (test_bit_inv(apid, matrix_mdev->matrix.apm) &&
>> +            test_bit_inv(apqi, matrix_mdev->matrix.aqm))
>> +            return matrix_mdev;
>> +    }
>> +
>> +    return NULL;
>> +}
>> +
>> +void vfio_ap_mdev_remove_queue(unsigned long apid, unsigned long apqi)
>> +{
>> +    struct ap_matrix_mdev *matrix_mdev;
>> +
>> +    matrix_mdev = vfio_ap_mdev_find_matrix_mdev(apid, apqi);
>> +
>> +    /*
>> +     * If the queue is assigned to the mdev device and the mdev device
>> +     * is in use by a guest
>> +     */
>> +    if (matrix_mdev && matrix_mdev->kvm) {
>> +        /*
>> +         * Unplug the adapter from the guest but don't unassign it
>> +         * from the mdev device
>> +         */
>> +        clear_bit_inv(apid, matrix_mdev->shadow_crycb->apm);
>> +        vfio_ap_mdev_update_crycb(matrix_mdev);
>> +    }
>> +
>> +    vfio_ap_mdev_reset_queue(apid, apqi);
>> +}
>> +
>> +void vfio_ap_mdev_probe_queue(unsigned long apid, unsigned long apqi)
>> +{
>> +    struct ap_matrix_mdev *matrix_mdev;
>> +
>> +    matrix_mdev = vfio_ap_mdev_find_matrix_mdev(apid, apqi);
>> +
>> +    /*
>> +     * If the queue is assigned to the mdev device and the mdev device
>> +     * is in use by a guest
>> +     */
>> +    if (matrix_mdev && matrix_mdev->kvm) {
>> +        /* Plug the adapter into the guest */
>> +        set_bit_inv(apid, matrix_mdev->shadow_crycb->apm);
> 
> Before you set the bit in the shadow...

yes

> 
>> +
>> +        /* Make sure the queue is also plugged in to the guest */
> 
> I Think we must take care in the use of queues and domains to avoid 
> being confusing.

Duly noted.

> 
>> +        if (!test_bit_inv(apqi, matrix_mdev->shadow_crycb->aqm))
>> +            set_bit_inv(apqi, matrix_mdev->shadow_crycb->aqm);
>> +
>> +        vfio_ap_mdev_update_crycb(matrix_mdev);
> 
> ...and you update the real CRYCB,
> 
> don't you need to verify that all ap queues which verify APID and any 
> already pre-existing APQI are bound to the driver?
> 
> Same for pre-existing APID if you set the APQI.

Since I last responded to your comment, I've been doing some testing
and discovered some scenarios that need to be considered. There is
definitely some additional checking that needs to be done here. It is
not necessary to verify all queues are bound to the vfio_ap driver, but
it we must assure that no queues are reserved for use
by the zcrypt drivers (i.e., APQN set in the apmask/aqmask).

> 
> 
>> +    }
>> +}
>> diff --git a/drivers/s390/crypto/vfio_ap_private.h 
>> b/drivers/s390/crypto/vfio_ap_private.h
>> index e8457aa61976..00eaae3b853f 100644
>> --- a/drivers/s390/crypto/vfio_ap_private.h
>> +++ b/drivers/s390/crypto/vfio_ap_private.h
>> @@ -87,5 +87,7 @@ struct ap_matrix_mdev {
>>   extern int vfio_ap_mdev_register(void);
>>   extern void vfio_ap_mdev_unregister(void);
>> +void vfio_ap_mdev_remove_queue(unsigned long apid, unsigned long apqi);
>> +void vfio_ap_mdev_probe_queue(unsigned long apid, unsigned long apqi);
>>   #endif /* _VFIO_AP_PRIVATE_H_ */
>>
> 
> 

