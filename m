Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AABF5C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 19:38:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74A1920869
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 19:38:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbfDLTib (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 15:38:31 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37580 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726829AbfDLTib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 15:38:31 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3CJZ282038854
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2019 15:38:30 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2rtx83ppc3-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2019 15:38:30 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <akrowiak@linux.ibm.com>;
        Fri, 12 Apr 2019 20:38:29 +0100
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
        by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 12 Apr 2019 20:38:26 +0100
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x3CJcMHf23724214
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Apr 2019 19:38:22 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A83B228058;
        Fri, 12 Apr 2019 19:38:22 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D4CA62805A;
        Fri, 12 Apr 2019 19:38:21 +0000 (GMT)
Received: from [9.85.196.181] (unknown [9.85.196.181])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 12 Apr 2019 19:38:21 +0000 (GMT)
Subject: Re: [PATCH 1/7] s390: zcrypt: driver callback to indicate resource in
 use
To:     Cornelia Huck <cohuck@redhat.com>
Cc:     Harald Freudenberger <freude@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, Reinhard Buendgen <buendgen@de.ibm.com>,
        borntraeger@de.ibm.com, frankja@linux.ibm.com, david@redhat.com,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        pmorel@linux.ibm.com, pasic@linux.ibm.com,
        alex.williamson@redhat.com, kwankhede@nvidia.com
References: <1555016604-2008-1-git-send-email-akrowiak@linux.ibm.com>
 <1555016604-2008-2-git-send-email-akrowiak@linux.ibm.com>
 <223c82c7-6a75-7209-3652-c2341c83878f@linux.ibm.com>
 <20190412114313.0156c01b.cohuck@redhat.com>
From:   Tony Krowiak <akrowiak@linux.ibm.com>
Date:   Fri, 12 Apr 2019 15:38:21 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190412114313.0156c01b.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19041219-0060-0000-0000-0000032C345C
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010915; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000284; SDB=6.01188145; UDB=6.00622416; IPR=6.00968912;
 MB=3.00026414; MTD=3.00000008; XFM=3.00000015; UTC=2019-04-12 19:38:29
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19041219-0061-0000-0000-000048EDC62C
Message-Id: <89f09e58-eab6-94d4-c5aa-937162d60744@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-12_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904120131
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/12/19 5:43 AM, Cornelia Huck wrote:
> On Fri, 12 Apr 2019 08:54:54 +0200
> Harald Freudenberger <freude@linux.ibm.com> wrote:
> 
>> On 11.04.19 23:03, Tony Krowiak wrote:
>>> Introduces a new driver callback to prevent a root user from unbinding
>>> an AP queue from its device driver if the queue is in use. This prevents
>>> a root user from inadvertently taking a queue away from a guest and
>>> giving it to the host, or vice versa. The callback will be invoked
>>> whenever a change to the AP bus's apmask or aqmask sysfs interfaces may
>>> result in one or more AP queues being removed from its driver. If the
>>> callback responds in the affirmative for any driver queried, the change
>>> to the apmask or aqmask will be rejected with a device in use error.
>>>
>>> For this patch, only non-default drivers will be queried. Currently,
>>> there is only one non-default driver, the vfio_ap device driver. The
>>> vfio_ap device driver manages AP queues passed through to one or more
>>> guests and we don't want to unexpectedly take AP resources away from
>>> guests which are most likely independently administered.
>>>
>>> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
>>
>> Hello Tony
>>
>> you are going out with your patches but ... what is the result of the discussions
>> we had in the past ? Do we have a common understanding that we want to have
>> it this way ? A driver which is able to claim resources and the bus code
>> has lower precedence ?

This is what Reinhard suggested and what we agreed to as a team quite
some time ago. I submitted three versions of this patch to our
internal mailing list, all of which you reviewed, so I'm not sure
why you are surprised by this now.

> 
> I don't know about previous discussions, but I'm curious how you
> arrived at this design. A driver being able to override the bus code
> seems odd. Restricting this to 'non-default' drivers looks even more
> odd.
> 
> What is this trying to solve? Traditionally, root has been able to
> shoot any appendages of their choice. I would rather expect that in a
> supported setup you'd have some management software keeping track of
> device usage and making sure that only unused queues can be unbound. Do
> we need to export more information to user space so that management
> software can make better choices?

Is there a reason other than tradition to prevent root from accidentally
shooting himself in the foot or any other appendage? At present,
sysfs is the only supported setup, so IMHO it makes sense to prevent as
much accidentally caused damage as possible in the kernel.

> 
>>
>>> ---
>>>   drivers/s390/crypto/ap_bus.c | 138 +++++++++++++++++++++++++++++++++++++++++--
>>>   drivers/s390/crypto/ap_bus.h |   3 +
>>>   2 files changed, 135 insertions(+), 6 deletions(-)
> 

