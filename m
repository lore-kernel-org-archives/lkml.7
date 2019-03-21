Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EC39C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 14:05:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46DCE218B0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 14:05:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728172AbfCUOFq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 10:05:46 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60350 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727809AbfCUOFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 10:05:46 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2LE4dZk062865
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 10:05:45 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2rcb81jm15-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 10:05:44 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Thu, 21 Mar 2019 14:05:38 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 21 Mar 2019 14:05:36 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2LE5ctl35979490
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Mar 2019 14:05:38 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B1038AE053;
        Thu, 21 Mar 2019 14:05:38 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A6F79AE058;
        Thu, 21 Mar 2019 14:05:37 +0000 (GMT)
Received: from [9.145.41.62] (unknown [9.145.41.62])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 21 Mar 2019 14:05:37 +0000 (GMT)
Reply-To: pmorel@linux.ibm.com
Subject: Re: [PATCH v5 1/7] s390: ap: kvm: add PQAP interception for AQIC
From:   Pierre Morel <pmorel@linux.ibm.com>
To:     Halil Pasic <pasic@linux.ibm.com>
Cc:     Cornelia Huck <cohuck@redhat.com>, borntraeger@de.ibm.com,
        alex.williamson@redhat.com, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        frankja@linux.ibm.com, akrowiak@linux.ibm.com, david@redhat.com,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        freude@linux.ibm.com, mimu@linux.ibm.com
References: <1552493104-30510-1-git-send-email-pmorel@linux.ibm.com>
 <1552493104-30510-2-git-send-email-pmorel@linux.ibm.com>
 <20190315112032.13b259c2.cohuck@redhat.com>
 <a0aef0e8-03e3-2cb7-3127-61521eed0629@linux.ibm.com>
 <20190315182839.4f7c0a73@oc2783563651>
 <0351d631-b756-dd22-0848-6f30747dc5e2@linux.ibm.com>
 <20190319155421.0f0e51c2@oc2783563651>
 <9c114f56-70bd-cc9e-3751-f62494407246@linux.ibm.com>
Date:   Thu, 21 Mar 2019 15:05:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <9c114f56-70bd-cc9e-3751-f62494407246@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19032114-0012-0000-0000-000003058CF0
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19032114-0013-0000-0000-0000213CA4D4
Message-Id: <268c46f2-4c30-adfd-25a4-29330aa89b35@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-21_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=921 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903210100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/03/2019 18:07, Pierre Morel wrote:
> On 19/03/2019 15:54, Halil Pasic wrote:
>> On Tue, 19 Mar 2019 11:01:44 +0100
>> Pierre Morel <pmorel@linux.ibm.com> wrote:
>>
>>> On 15/03/2019 18:28, Halil Pasic wrote:
>>

...snip...

>>
>>> We should also do it right for TAPQ with t bit set. I remember
>>> Christian already warned about this but we did not implement it.
>>>
>>
>> Yes, I have some blurry memories of something similar myself. I wonder
>> if there was a reason, or did we just forget to address this issue.
> 
> 
> I will integrate it in the next iteration too, even it is not IRQ, the 
> PQAP hook patch can be more general.

After all, I will not do this, I remember the reason why we did not do 
it once: simply it is not intercepted until we enable it.

So we will handle it when we enable the TAPQ-t interception

Regards,
Pierre

-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany

