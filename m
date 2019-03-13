Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3F9FC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 10:15:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B5492087C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 10:15:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbfCMKP4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 06:15:56 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47258 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725992AbfCMKPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 06:15:55 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2DAFh8h113027
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 06:15:55 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2r6x26wr04-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 06:15:53 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Wed, 13 Mar 2019 10:15:26 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 13 Mar 2019 10:15:23 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2DAFL1d32047184
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Mar 2019 10:15:22 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 913AD52073;
        Wed, 13 Mar 2019 10:15:21 +0000 (GMT)
Received: from [9.152.224.140] (unknown [9.152.224.140])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 1FDA452071;
        Wed, 13 Mar 2019 10:15:21 +0000 (GMT)
Reply-To: pmorel@linux.ibm.com
Subject: Re: [PATCH v4 6/7] s390: ap: Cleanup on removing the AP device
To:     Tony Krowiak <akrowiak@linux.ibm.com>, borntraeger@de.ibm.com
Cc:     alex.williamson@redhat.com, cohuck@redhat.com,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, frankja@linux.ibm.com, pasic@linux.ibm.com,
        david@redhat.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, freude@linux.ibm.com, mimu@linux.ibm.com
References: <1550849400-27152-1-git-send-email-pmorel@linux.ibm.com>
 <1550849400-27152-7-git-send-email-pmorel@linux.ibm.com>
 <3956ad4c-55c9-e42c-4ab2-00ddae05b317@linux.ibm.com>
 <94904df0-42b6-51f8-6440-68722ef5419d@linux.ibm.com>
 <cf148acb-1a07-ffa3-f728-0f6b02aa914d@linux.ibm.com>
From:   Pierre Morel <pmorel@linux.ibm.com>
Date:   Wed, 13 Mar 2019 11:15:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <cf148acb-1a07-ffa3-f728-0f6b02aa914d@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19031310-0016-0000-0000-0000026151EB
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19031310-0017-0000-0000-000032BBFDCB
Message-Id: <85f772b4-0b62-701d-c3e5-e55e88c3fb4e@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-13_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903130075
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/03/2019 22:53, Tony Krowiak wrote:
> On 3/11/19 4:31 AM, Pierre Morel wrote:
>> On 08/03/2019 23:43, Tony Krowiak wrote:
>>> On 2/22/19 10:29 AM, Pierre Morel wrote:
>>>> When the device is remove, we must make sure to
>>>> clear the interruption and reset the AP device.
>>>>
>>>> We also need to clear the CRYCB of the guest.
>>>>
>>>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>>>> ---
>>>>   drivers/s390/crypto/vfio_ap_drv.c     | 35 
>>>> +++++++++++++++++++++++++++++++++++
>>>>   drivers/s390/crypto/vfio_ap_ops.c     |  3 ++-
>>>>   drivers/s390/crypto/vfio_ap_private.h |  3 +++
>>>>   3 files changed, 40 insertions(+), 1 deletion(-)
>>>>

...snip...

>>>> + * vfio_ap_update_crycb
>>>> + * @q: A pointer to the queue being removed
>>>> + *
>>>> + * We clear the APID of the queue, making this queue unusable for 
>>>> the guest.
>>>> + * After this function we can reset the queue without to fear a 
>>>> race with
>>>> + * the guest to access the queue again.
>>>> + * We do not fear race with the host as we still get the devic
>>>> + */
>>>> +static void vfio_ap_update_crycb(struct vfio_ap_queue *q)
>>>> +{
>>>> +    struct ap_matrix_mdev *matrix_mdev = q->matrix_mdev;
>>>> +
>>>> +    if (!matrix_mdev)
>>>> +        return;
>>>> +
> 
> You should probably check whether the APID has been cleared before
> proceeding. Take the case where an AP with multiple queues is removed
> from the configuration via the SE or SCLP. The AP bus is going to invoke
> the vfio_ap_queue_dev_remove() function for each of the queues. The APID
> will get cleared on the first remove, so it is not only unnecessary to
> clear it on subsequent removes, it is kind of nasty to keep resetting
> the masks in the guest's CRYCB (below) each time the remove callback is
> invoked.

This can not happen.
The only way to clear the APM is when the matrix is not associated with KVM.

This case is tested and the masks are not changed.

> 
>>>> +    clear_bit_inv(AP_QID_CARD(q->apqn), matrix_mdev->matrix.apm);
>>>> +
>>>> +    if (!matrix_mdev->kvm)
>>>> +        return;
>>>> +
>>>> +    kvm_arch_crypto_set_masks(matrix_mdev->kvm,
>>>> +                  matrix_mdev->matrix.apm,
>>>> +                  matrix_mdev->matrix.aqm,
>>>> +                  matrix_mdev->matrix.adm);
>>>> +}




-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany

