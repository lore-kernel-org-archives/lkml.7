Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FC34C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 10:20:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 477F92087C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 10:20:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726219AbfCMKUD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 06:20:03 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56732 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725870AbfCMKUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 06:20:03 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2DAJDcd031162
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 06:20:02 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2r6y6vafgm-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 06:20:01 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Wed, 13 Mar 2019 10:19:59 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 13 Mar 2019 10:19:56 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2DAJsOo52101278
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Mar 2019 10:19:54 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BBCE952059;
        Wed, 13 Mar 2019 10:19:53 +0000 (GMT)
Received: from [9.152.224.140] (unknown [9.152.224.140])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 145EB52051;
        Wed, 13 Mar 2019 10:19:53 +0000 (GMT)
Reply-To: pmorel@linux.ibm.com
Subject: Re: [PATCH v4 3/7] s390: ap: associate a ap_vfio_queue and a matrix
 mdev
To:     Tony Krowiak <akrowiak@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>
Cc:     borntraeger@de.ibm.com, alex.williamson@redhat.com,
        cohuck@redhat.com, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        frankja@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, freude@linux.ibm.com, mimu@linux.ibm.com
References: <1550849400-27152-1-git-send-email-pmorel@linux.ibm.com>
 <1550849400-27152-4-git-send-email-pmorel@linux.ibm.com>
 <20190304030935.525f4223@oc2783563651>
 <17fc3369-2496-2113-5a1a-1630df84f067@linux.ibm.com>
From:   Pierre Morel <pmorel@linux.ibm.com>
Date:   Wed, 13 Mar 2019 11:19:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <17fc3369-2496-2113-5a1a-1630df84f067@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19031310-0008-0000-0000-000002CC0F04
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19031310-0009-0000-0000-0000223832BF
Message-Id: <52eaf739-3fad-9be8-a2f7-9657000ace3e@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-13_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903130075
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/03/2019 22:39, Tony Krowiak wrote:
> On 3/3/19 9:09 PM, Halil Pasic wrote:
>> On Fri, 22 Feb 2019 16:29:56 +0100
>> Pierre Morel <pmorel@linux.ibm.com> wrote:
>>
>>> We need to associate the ap_vfio_queue, which will hold the
>>> per queue information for interrupt with a matrix mediated device
>>> which hold the configuration and the way to the CRYCB.
>> [..]
>>> +static int vfio_ap_get_all_domains(struct ap_matrix_mdev 
>>> *matrix_mdev, int apid)
>>> +{
>>> +    int apqi, apqn;
>>> +    int ret = 0;
>>> +    struct vfio_ap_queue *q;
>>> +    struct list_head q_list;
>>> +
>>> +    INIT_LIST_HEAD(&q_list);
>>> +
>>> +    for_each_set_bit_inv(apqi, matrix_mdev->matrix.aqm, AP_DOMAINS) {
>>> +        apqn = AP_MKQID(apid, apqi);
>>> +        q = vfio_ap_get_queue(apqn, &matrix_dev->free_list);
>>> +        if (!q) {
>>> +            ret = -EADDRNOTAVAIL;
>>> +            goto rewind;
>>> +        }
>>> +        if (q->matrix_mdev) {
>>> +            ret = -EADDRINUSE;
>>
>> You tried to get the q from matrix_dev->free_list thus modulo races
>> q->matrix_mdev should be 0. This change breaks the error codes in a
>> sense that it becomes impossible to provoke EADDRINUSE (the proper
>> error code for taken by another matrix_mdev).
> 
> It is necessary to determine if the queue is in use by another mdev, so
> it will still be necessary to traverse all of the matrix_mdev structs to
> see if q is in matrix_mdev->qlist. It seems that maintaining the qlist
> does not buy us much.
> 

Tony, Halil already pointed out this issue and I already answered.
Please, no need to duplicate the remarks.

Pierre

-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany

