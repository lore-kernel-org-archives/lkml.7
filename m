Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C451BC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 12:53:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C223204EC
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 12:53:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbfC1Mxe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 08:53:34 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48770 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725948AbfC1Mxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 08:53:33 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2SCnshW173442
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 08:53:32 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2rgwyej2wh-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 08:53:31 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Thu, 28 Mar 2019 12:53:30 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 28 Mar 2019 12:53:28 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2SCrQpV33095790
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Mar 2019 12:53:26 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 97AEBA405C;
        Thu, 28 Mar 2019 12:53:26 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2BDEAA4065;
        Thu, 28 Mar 2019 12:53:26 +0000 (GMT)
Received: from [9.152.224.145] (unknown [9.152.224.145])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 28 Mar 2019 12:53:26 +0000 (GMT)
Reply-To: pmorel@linux.ibm.com
Subject: Re: [PATCH v6 2/7] s390: ap: new vfio_ap_queue structure
To:     Harald Freudenberger <freude@linux.ibm.com>,
        Tony Krowiak <akrowiak@linux.ibm.com>, borntraeger@de.ibm.com
Cc:     alex.williamson@redhat.com, cohuck@redhat.com,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, frankja@linux.ibm.com, pasic@linux.ibm.com,
        david@redhat.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, mimu@linux.ibm.com
References: <1553265828-27823-1-git-send-email-pmorel@linux.ibm.com>
 <1553265828-27823-3-git-send-email-pmorel@linux.ibm.com>
 <169eec34-6397-3150-27df-9985c9e711b8@linux.ibm.com>
 <bf728b35-a610-d343-6ec1-5397025a86cb@linux.ibm.com>
From:   Pierre Morel <pmorel@linux.ibm.com>
Date:   Thu, 28 Mar 2019 13:53:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <bf728b35-a610-d343-6ec1-5397025a86cb@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19032812-4275-0000-0000-000003208FFC
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19032812-4276-0000-0000-0000382F2DA5
Message-Id: <d40af924-cd5d-18ae-5fe4-88763e429f7f@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-28_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903280090
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/03/2019 12:00, Harald Freudenberger wrote:
> On 26.03.19 21:45, Tony Krowiak wrote:
>> On 3/22/19 10:43 AM, Pierre Morel wrote:
>>> The AP interruptions are assigned on a queue basis and

...snip...

>>> +static void vfio_ap_free_queue(int apqn, struct ap_matrix_mdev *matrix_mdev)
>>> +{
>>> +    struct vfio_ap_queue *q;
>>> +
>>> +    q = vfio_ap_get_queue(apqn, &matrix_mdev->qlist);
>>> +    if (!q)
>>> +        return;
>>> +    q->matrix_mdev = NULL;
>>> +    vfio_ap_mdev_reset_queue(q);
>>
>> I'm wondering if it's necessary to reset the queue here. The only time
>> a queue is used is when a guest using the mdev device is started. When
>> that guest is terminated, the fd for the mdev device is closed and the
>> mdev device's release callback is invoked. The release callback resets
>> the queues assigned to the mdev device. Is it really necessary to
>> reset the queue again when it is unassigned even if there would have
>> been no subsequent activity?
> When I understand this here right this code is called when a queue goes
> away from the guest but is still reserved for use by the vfio dd. So it is
> possible to assign the queue now to another guest. But then it makes
> sense to clear all the entries in the millicode queue because a pending
> reply could be "received" by the wrong guest.
> 
> If this function is just called on remove of a queue device where the
> device goes back to the AP bus, a reset is not needed.

You are right Harald, the function is called when un-assigning a queue 
from a mediated device, so it must be reset before to assign it to another.


Regards,
Pierre

-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany

