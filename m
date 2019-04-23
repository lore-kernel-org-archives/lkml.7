Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F5FBC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 13:19:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2B7620675
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 13:19:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727924AbfDWNTM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 09:19:12 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48450 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726801AbfDWNTM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 09:19:12 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3NDBf7Q067451
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 09:19:10 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2s211j6ush-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 09:19:10 -0400
Received: from localhost
        by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <akrowiak@linux.ibm.com>;
        Tue, 23 Apr 2019 14:19:09 +0100
Received: from b03cxnp08028.gho.boulder.ibm.com (9.17.130.20)
        by e33.co.us.ibm.com (192.168.1.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 23 Apr 2019 14:19:06 +0100
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x3NDJ2AV23789614
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Apr 2019 13:19:02 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5ECD7C6055;
        Tue, 23 Apr 2019 13:19:02 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 49A32C6057;
        Tue, 23 Apr 2019 13:19:01 +0000 (GMT)
Received: from [9.60.75.251] (unknown [9.60.75.251])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 23 Apr 2019 13:19:01 +0000 (GMT)
Subject: Re: [PATCH v2 3/8] s390: vfio-ap: allow assignment of unavailable AP
 resources to mdev device
To:     pmorel@linux.ibm.com, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     freude@linux.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com,
        frankja@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, pasic@linux.ibm.com,
        alex.williamson@redhat.com, kwankhede@nvidia.com
References: <1555796980-27920-1-git-send-email-akrowiak@linux.ibm.com>
 <1555796980-27920-4-git-send-email-akrowiak@linux.ibm.com>
 <2c76d792-00aa-a334-2243-b0f8b91295b2@linux.ibm.com>
From:   Tony Krowiak <akrowiak@linux.ibm.com>
Date:   Tue, 23 Apr 2019 09:19:00 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <2c76d792-00aa-a334-2243-b0f8b91295b2@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19042313-0036-0000-0000-00000AAC0026
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010980; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000285; SDB=6.01193231; UDB=6.00625501; IPR=6.00974051;
 MB=3.00026557; MTD=3.00000008; XFM=3.00000015; UTC=2019-04-23 13:19:08
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19042313-0037-0000-0000-00004B7F2C82
Message-Id: <22607063-1194-8fa6-2941-6acecddc3761@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-23_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904230091
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/23/19 8:46 AM, Pierre Morel wrote:
> On 20/04/2019 23:49, Tony Krowiak wrote:
>> The AP architecture does not preclude assignment of AP resources that are
>> not yet in the AP configuration (i.e., not available or not online).
>> Let's go ahead and implement this facet of the AP architecture for linux
>> guests.
>>
>> Access to AP resources is controlled by bit masks in a guest's SIE
>> state description (i.e., the control block containing the state of a
>> guest). When an AP instruction is executed on the guest, the firmware
>> combines the masks from the guest's SIE state description with the masks
>> from the host by doing a logical bitwise AND of the masks to create what
>> are defined as effective masks. The effective masks determine which AP
>> resources can be accessed by the guest.
>>
>> Effective masking allows the assignment of AP resources to a guest even
>> if the underlying device is not in the AP configuration. If the device
>> subsequently becomes configured, the guest will automatically have access
>> to the associated AP resources (e.g., AP queues).
>>
>> The current implementation does not allow assignment of AP resources to
>> an mdev device if the AP queues identified by the assignment are not
>> bound to the vfio_ap device driver. This patch allows assignment of AP
>> resources to the mdev device even if the AP queues are not bound to the
>> vfio_ap device driver, as long as the AP queues are not reserved by the
>> AP BUS for use by the zcrypt device drivers. If the queues are 
>> subsequently
>> bound to the vfio_ap device driver while a running guest is using the 
>> mdev
>> device, the guest will automatically gain access to the queues. Effective
>> masking prevents access to queues until such time as they become 
>> available.
>>
>> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
>> ---
>>   drivers/s390/crypto/vfio_ap_ops.c | 160 
>> +++++---------------------------------
>>   1 file changed, 18 insertions(+), 142 deletions(-)
>>
>> diff --git a/drivers/s390/crypto/vfio_ap_ops.c 
>> b/drivers/s390/crypto/vfio_ap_ops.c
>> index eae4ee24460a..221491a9ba95 100644
>> --- a/drivers/s390/crypto/vfio_ap_ops.c
>> +++ b/drivers/s390/crypto/vfio_ap_ops.c
>> @@ -113,122 +113,6 @@ static struct attribute_group 
>> *vfio_ap_mdev_type_groups[] = {
>>       NULL,
>>   };
>> -struct vfio_ap_queue_reserved {
>> -    unsigned long *apid;
>> -    unsigned long *apqi;
>> -    bool reserved;
>> -};
>> -
>> -/**
>> - * vfio_ap_has_queue
>> - *
>> - * @dev: an AP queue device
>> - * @data: a struct vfio_ap_queue_reserved reference
>> - *
>> - * Flags whether the AP queue device (@dev) has a queue ID containing 
>> the APQN,
>> - * apid or apqi specified in @data:
>> - *
>> - * - If @data contains both an apid and apqi value, then @data will 
>> be flagged
>> - *   as reserved if the APID and APQI fields for the AP queue device 
>> matches
>> - *
>> - * - If @data contains only an apid value, @data will be flagged as
>> - *   reserved if the APID field in the AP queue device matches
>> - *
>> - * - If @data contains only an apqi value, @data will be flagged as
>> - *   reserved if the APQI field in the AP queue device matches
>> - *
>> - * Returns 0 to indicate the input to function succeeded. Returns 
>> -EINVAL if
>> - * @data does not contain either an apid or apqi.
>> - */
>> -static int vfio_ap_has_queue(struct device *dev, void *data)
>> -{
>> -    struct vfio_ap_queue_reserved *qres = data;
>> -    struct ap_queue *ap_queue = to_ap_queue(dev);
>> -    ap_qid_t qid;
>> -    unsigned long id;
>> -
>> -    if (qres->apid && qres->apqi) {
>> -        qid = AP_MKQID(*qres->apid, *qres->apqi);
>> -        if (qid == ap_queue->qid)
>> -            qres->reserved = true;
>> -    } else if (qres->apid && !qres->apqi) {
>> -        id = AP_QID_CARD(ap_queue->qid);
>> -        if (id == *qres->apid)
>> -            qres->reserved = true;
>> -    } else if (!qres->apid && qres->apqi) {
>> -        id = AP_QID_QUEUE(ap_queue->qid);
>> -        if (id == *qres->apqi)
>> -            qres->reserved = true;
>> -    } else {
>> -        return -EINVAL;
>> -    }
>> -
>> -    return 0;
>> -}
>> -
>> -/**
>> - * vfio_ap_verify_queue_reserved
>> - *
>> - * @matrix_dev: a mediated matrix device
>> - * @apid: an AP adapter ID
>> - * @apqi: an AP queue index
>> - *
>> - * Verifies that the AP queue with @apid/@apqi is reserved by the 
>> VFIO AP device
>> - * driver according to the following rules:
>> - *
>> - * - If both @apid and @apqi are not NULL, then there must be an AP 
>> queue
>> - *   device bound to the vfio_ap driver with the APQN identified by 
>> @apid and
>> - *   @apqi
>> - *
>> - * - If only @apid is not NULL, then there must be an AP queue device 
>> bound
>> - *   to the vfio_ap driver with an APQN containing @apid
>> - *
>> - * - If only @apqi is not NULL, then there must be an AP queue device 
>> bound
>> - *   to the vfio_ap driver with an APQN containing @apqi
>> - *
>> - * Returns 0 if the AP queue is reserved; otherwise, returns 
>> -EADDRNOTAVAIL.
>> - */
>> -static int vfio_ap_verify_queue_reserved(unsigned long *apid,
>> -                     unsigned long *apqi)
>> -{
>> -    int ret;
>> -    struct vfio_ap_queue_reserved qres;
>> -
>> -    qres.apid = apid;
>> -    qres.apqi = apqi;
>> -    qres.reserved = false;
>> -
>> -    ret = driver_for_each_device(&matrix_dev->vfio_ap_drv->driver, NULL,
>> -                     &qres, vfio_ap_has_queue);
>> -    if (ret)
>> -        return ret;
>> -
>> -    if (qres.reserved)
>> -        return 0;
>> -
>> -    return -EADDRNOTAVAIL;
>> -}
>> -
>> -static int
>> -vfio_ap_mdev_verify_queues_reserved_for_apid(struct ap_matrix_mdev 
>> *matrix_mdev,
>> -                         unsigned long apid)
> 
> You suppress this function but it is still in use in 
> assign_adapter_store...

Right you are. I must have been removed in a subsequent patch, because
this code was compiled and tested. It should have been removed here
though.

> 
> 
>> -{
>> -    int ret;
>> -    unsigned long apqi;
>> -    unsigned long nbits = matrix_mdev->matrix.aqm_max + 1;
>> -
>> -    if (find_first_bit_inv(matrix_mdev->matrix.aqm, nbits) >= nbits)
>> -        return vfio_ap_verify_queue_reserved(&apid, NULL);
>> -
>> -    for_each_set_bit_inv(apqi, matrix_mdev->matrix.aqm, nbits) {
>> -        ret = vfio_ap_verify_queue_reserved(&apid, &apqi);
>> -        if (ret)
>> -            return ret;
>> -    }
>> -
>> -    return 0;
>> -}
>> -
>>   /**
>>    * vfio_ap_mdev_verify_no_sharing
>>    *
>> @@ -359,9 +243,17 @@ static ssize_t assign_adapter_store(struct device 
>> *dev,
>>       set_bit_inv(apid, matrix_mdev->matrix.apm);
>> +    ret = ap_apqn_in_matrix_owned_by_def_drv(matrix_mdev->matrix.apm,
>> +                         matrix_mdev->matrix.aqm);
>> +
>> +    /* If any APQN is owned by a default driver */
>> +    ret = (ret == 1) ? -EADDRNOTAVAIL : ret;
>> +    if (ret)
>> +        goto error;
>> +
>>       ret = vfio_ap_mdev_verify_no_sharing(matrix_mdev);
>>       if (ret)
>> -        goto share_err;
>> +        goto error;
>>       if (matrix_mdev->shadow_crycb)
>>           set_bit_inv(apid, matrix_mdev->shadow_crycb->apm);
>> @@ -369,7 +261,7 @@ static ssize_t assign_adapter_store(struct device 
>> *dev,
>>       ret = count;
>>       goto done;
>> -share_err:
>> +error:
>>       clear_bit_inv(apid, matrix_mdev->matrix.apm);
>>   done:
>>       mutex_unlock(&matrix_dev->lock);
>> @@ -426,26 +318,6 @@ static ssize_t unassign_adapter_store(struct 
>> device *dev,
>>   }
>>   static DEVICE_ATTR_WO(unassign_adapter);
>> -static int
>> -vfio_ap_mdev_verify_queues_reserved_for_apqi(struct ap_matrix_mdev 
>> *matrix_mdev,
>> -                         unsigned long apqi)
>> -{
>> -    int ret;
>> -    unsigned long apid;
>> -    unsigned long nbits = matrix_mdev->matrix.apm_max + 1;
>> -
>> -    if (find_first_bit_inv(matrix_mdev->matrix.apm, nbits) >= nbits)
>> -        return vfio_ap_verify_queue_reserved(NULL, &apqi);
>> -
>> -    for_each_set_bit_inv(apid, matrix_mdev->matrix.apm, nbits) {
>> -        ret = vfio_ap_verify_queue_reserved(&apid, &apqi);
>> -        if (ret)
>> -            return ret;
>> -    }
>> -
>> -    return 0;
>> -}
>> -
>>   /**
>>    * assign_domain_store
>>    *
>> @@ -500,12 +372,16 @@ static ssize_t assign_domain_store(struct device 
>> *dev,
>>       mutex_lock(&matrix_dev->lock);
>> -    ret = vfio_ap_mdev_verify_queues_reserved_for_apqi(matrix_mdev, 
>> apqi);
>> -    if (ret)
>> -        goto done;
>> -
>>       set_bit_inv(apqi, matrix_mdev->matrix.aqm);
>> +    ret = ap_apqn_in_matrix_owned_by_def_drv(matrix_mdev->matrix.apm,
>> +                         matrix_mdev->matrix.aqm);
>> +
>> +    /* If any APQN is owned by a default driver */
>> +    ret = (ret == 1) ? -EADDRNOTAVAIL : ret;
>> +    if (ret)
>> +        goto error;
> 
> forget to add the error label ?

Apparently I did. I'm not sure what happened here since I compiled
and tested the code. I must have messed something up when formatting
the patches.

> 
>> +
>>       ret = vfio_ap_mdev_verify_no_sharing(matrix_mdev);
>>       if (ret)
>>           goto share_err;
>>
> 
> 

