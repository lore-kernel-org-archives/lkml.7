Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFA77C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 13:06:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A945E2173C
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 13:06:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbfC1NGz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 09:06:55 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37658 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725948AbfC1NGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 09:06:55 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2SCwqK8085341
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 09:06:54 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2rgx0qtmx8-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 09:06:53 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Thu, 28 Mar 2019 13:06:51 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 28 Mar 2019 13:06:49 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2SD6l8N14155890
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Mar 2019 13:06:47 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8F8A4A405B;
        Thu, 28 Mar 2019 13:06:47 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EE0B6A4054;
        Thu, 28 Mar 2019 13:06:46 +0000 (GMT)
Received: from [9.152.224.145] (unknown [9.152.224.145])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 28 Mar 2019 13:06:46 +0000 (GMT)
Reply-To: pmorel@linux.ibm.com
Subject: Re: [PATCH v6 2/7] s390: ap: new vfio_ap_queue structure
To:     Tony Krowiak <akrowiak@linux.ibm.com>, borntraeger@de.ibm.com
Cc:     alex.williamson@redhat.com, cohuck@redhat.com,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, frankja@linux.ibm.com, pasic@linux.ibm.com,
        david@redhat.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, freude@linux.ibm.com, mimu@linux.ibm.com
References: <1553265828-27823-1-git-send-email-pmorel@linux.ibm.com>
 <1553265828-27823-3-git-send-email-pmorel@linux.ibm.com>
 <169eec34-6397-3150-27df-9985c9e711b8@linux.ibm.com>
From:   Pierre Morel <pmorel@linux.ibm.com>
Date:   Thu, 28 Mar 2019 14:06:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <169eec34-6397-3150-27df-9985c9e711b8@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19032813-4275-0000-0000-000003209149
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19032813-4276-0000-0000-0000382F2F04
Message-Id: <1b64ad7b-2a7c-b604-1adb-af400e7be516@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-28_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903280091
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/03/2019 21:45, Tony Krowiak wrote:
> On 3/22/19 10:43 AM, Pierre Morel wrote:
>> The AP interruptions are assigned on a queue basis and
>> the GISA structure is handled on a VM basis, so that
>> we need to add a structure we can retrieve from both side
> 
> s/side/sides/
OK

> 
>> holding the information we need to handle PQAP/AQIC interception
>> and setup the GISA.
> 
> s/setup/set up/

OK

...snip...

>> +
>> +static int vfio_ap_mdev_reset_queue(struct vfio_ap_queue *q)
>> +{
>> +    struct ap_queue_status status;
>> +    int retry = 1;
>> +
>> +    do {
>> +        status = ap_zapq(q->apqn);
>> +        switch (status.response_code) {
>> +        case AP_RESPONSE_NORMAL:
>> +            return 0;
>> +        case AP_RESPONSE_RESET_IN_PROGRESS:
>> +        case AP_RESPONSE_BUSY:
>> +            msleep(20);
>> +            break;
>> +        default:
>> +            /* things are really broken, give up */
> 
> I'm not sure things are necessarily broken. We could end up here if
> the AP is removed from the configuration via the SE or SCLP Deconfigure
> Adjunct Processor command.

OK, but note that it is your original comment I just moved the function 
here ;)

> 
>> +            return -EIO;
>> +        }
>> +    } while (retry--);
>> +
>> +    return -EBUSY;
>> +}
>> +
>>   static void vfio_ap_matrix_init(struct ap_config_info *info,
>>                   struct ap_matrix *matrix)
>>   {
>> @@ -45,6 +107,7 @@ static int vfio_ap_mdev_create(struct kobject 
>> *kobj, struct mdev_device *mdev)
>>           return -ENOMEM;
>>       }
>> +    INIT_LIST_HEAD(&matrix_mdev->qlist);
>>       vfio_ap_matrix_init(&matrix_dev->info, &matrix_mdev->matrix);
>>       mdev_set_drvdata(mdev, matrix_mdev);
>>       mutex_lock(&matrix_dev->lock);
>> @@ -113,162 +176,189 @@ static struct attribute_group 
>> *vfio_ap_mdev_type_groups[] = {
>>       NULL,
>>   };
>> -struct vfio_ap_queue_reserved {
>> -    unsigned long *apid;
>> -    unsigned long *apqi;
>> -    bool reserved;
>> -};
>> +static void vfio_ap_free_queue(int apqn, struct ap_matrix_mdev 
>> *matrix_mdev)
>> +{
>> +    struct vfio_ap_queue *q;
>> +
>> +    q = vfio_ap_get_queue(apqn, &matrix_mdev->qlist);
>> +    if (!q)
>> +        return;
>> +    q->matrix_mdev = NULL;
>> +    vfio_ap_mdev_reset_queue(q);
> 
> I'm wondering if it's necessary to reset the queue here. The only time
> a queue is used is when a guest using the mdev device is started. When
> that guest is terminated, the fd for the mdev device is closed and the
> mdev device's release callback is invoked. The release callback resets
> the queues assigned to the mdev device. Is it really necessary to
> reset the queue again when it is unassigned even if there would have
> been no subsequent activity?

Yes, it is necessary, the queue can be re-assigned to another guest later.
Release will only be called when unbinding the queue from the driver.

> 
>> +    list_move(&q->list, &matrix_dev->free_list);
>> +}

...snip...

>> +    for_each_set_bit_inv(apid, matrix_mdev->matrix.apm, AP_DEVICES) {
>> +        apqn = AP_MKQID(apid, apqi);
>> +        q = vfio_ap_find_queue(apqn);
>> +        if (!q) {
>> +            ret = -EADDRNOTAVAIL;
>> +            goto rewind;
>> +        }
>> +        if (q->matrix_mdev) {
> 
> If somebody assigns the same domain a second time, the assignment will
> fail because the matrix_mdev will already have been associated with the
> queue. I don't think it is appropriate to fail the assignment if the

It is usual to report a failure in the case the operation requested has 
already be done.
But we can do as you want. Any other opinion?

> q->matrix_mdev is the same as the input matrix_mdev. This should be
> changed to:
> 
>      if (q->matrix_mdev != matrix_mdev)

You surely want to say: add this, not change to this. ;)

> 

Thanks for commenting,

Regards,
Pierre


-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany

