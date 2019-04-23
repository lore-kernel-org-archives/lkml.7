Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC540C282DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 13:29:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6B4120685
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 13:29:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728055AbfDWN3D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 09:29:03 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48946 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727919AbfDWN3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 09:29:01 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3ND9tjd113016
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 09:29:00 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2s221nvvj9-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 09:28:59 -0400
Received: from localhost
        by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <akrowiak@linux.ibm.com>;
        Tue, 23 Apr 2019 14:28:59 +0100
Received: from b03cxnp08025.gho.boulder.ibm.com (9.17.130.17)
        by e31.co.us.ibm.com (192.168.1.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 23 Apr 2019 14:28:55 +0100
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x3NDSqYG25493540
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Apr 2019 13:28:52 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 01077C605A;
        Tue, 23 Apr 2019 13:28:52 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BFC19C6057;
        Tue, 23 Apr 2019 13:28:50 +0000 (GMT)
Received: from [9.60.75.251] (unknown [9.60.75.251])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 23 Apr 2019 13:28:50 +0000 (GMT)
Subject: Re: [PATCH v2 5/8] s390: vfio-ap: wait for queue empty on queue reset
To:     pmorel@linux.ibm.com, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     freude@linux.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com,
        frankja@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, pasic@linux.ibm.com,
        alex.williamson@redhat.com, kwankhede@nvidia.com
References: <1555796980-27920-1-git-send-email-akrowiak@linux.ibm.com>
 <1555796980-27920-6-git-send-email-akrowiak@linux.ibm.com>
 <9a23da6d-89a8-227d-b756-6e002b0199e3@linux.ibm.com>
From:   Tony Krowiak <akrowiak@linux.ibm.com>
Date:   Tue, 23 Apr 2019 09:28:50 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <9a23da6d-89a8-227d-b756-6e002b0199e3@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19042313-8235-0000-0000-00000E8405AC
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010981; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000285; SDB=6.01193234; UDB=6.00625503; IPR=6.00974054;
 MB=3.00026557; MTD=3.00000008; XFM=3.00000015; UTC=2019-04-23 13:28:58
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19042313-8236-0000-0000-000045422748
Message-Id: <7772aff2-6db3-3215-4aef-e6ee3bb5c00a@linux.ibm.com>
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

On 4/23/19 8:50 AM, Pierre Morel wrote:
> On 20/04/2019 23:49, Tony Krowiak wrote:
>> Refactors the AP queue reset function to wait until the queue is empty
>> after the PQAP(ZAPQ) instruction is executed to zero out the queue as
>> required by the AP architecture.
>>
>> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
>> ---
>>   drivers/s390/crypto/vfio_ap_ops.c | 35 
>> ++++++++++++++++++++++++++++++++---
>>   1 file changed, 32 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/s390/crypto/vfio_ap_ops.c 
>> b/drivers/s390/crypto/vfio_ap_ops.c
>> index 091804317c5e..31ce30ee784d 100644
>> --- a/drivers/s390/crypto/vfio_ap_ops.c
>> +++ b/drivers/s390/crypto/vfio_ap_ops.c
>> @@ -744,15 +744,44 @@ static int vfio_ap_mdev_group_notifier(struct 
>> notifier_block *nb,
>>       return NOTIFY_OK;
>>   }
>> -static int vfio_ap_mdev_reset_queue(unsigned int apid, unsigned int 
>> apqi,
>> -                    unsigned int retry)
>> +static void vfio_ap_mdev_wait_for_qempty(unsigned long apid, unsigned 
>> long apqi)
>>   {
>>       struct ap_queue_status status;
>> +    ap_qid_t qid = AP_MKQID(apid, apqi);
>> +    int retry = 5;
>> +
>> +    do {
>> +        status = ap_tapq(qid, NULL);
>> +        switch (status.response_code) {
>> +        case AP_RESPONSE_NORMAL:
>> +            if (status.queue_empty)
>> +                return;
>> +            msleep(20);
>> +            break;
>> +        case AP_RESPONSE_RESET_IN_PROGRESS:
>> +        case AP_RESPONSE_BUSY:
>> +            msleep(20);
>> +            break;
>> +        default:
>> +            pr_warn("%s: tapq err %02x: 0x%04x may not be empty\n",
>> +                __func__, status.response_code, q->apqn);
> 
> q is not defined. use qid ?

You are right, it is not.

> 
> 
>> +            return;
>> +        }
>> +    } while (--retry);
>> +}
>> +
>> +int vfio_ap_mdev_reset_queue(unsigned int apid, unsigned int apqi)
>> +{
>> +    struct ap_queue_status status;
>> +    int retry = 5;
>>       do {
>>           status = ap_zapq(AP_MKQID(apid, apqi));
>>           switch (status.response_code) {
>>           case AP_RESPONSE_NORMAL:
>> +            vfio_ap_mdev_wait_for_qempty(apid, apqi);
>> +            return 0;
>> +        case AP_RESPONSE_DECONFIGURED:
>>               return 0;
>>           case AP_RESPONSE_RESET_IN_PROGRESS:
>>           case AP_RESPONSE_BUSY:
>> @@ -778,7 +807,7 @@ static int vfio_ap_mdev_reset_queues(struct 
>> mdev_device *mdev)
>>                    matrix_mdev->matrix.apm_max + 1) {
>>           for_each_set_bit_inv(apqi, matrix_mdev->matrix.aqm,
>>                        matrix_mdev->matrix.aqm_max + 1) {
>> -            ret = vfio_ap_mdev_reset_queue(apid, apqi, 1);
>> +            ret = vfio_ap_mdev_reset_queue(apid, apqi);
>>               /*
>>                * Regardless whether a queue turns out to be busy, or
>>                * is not operational, we need to continue resetting
>>
> 
> 

