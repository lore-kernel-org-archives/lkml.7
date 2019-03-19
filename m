Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7DE7C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 17:07:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFF5E20700
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 17:07:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727496AbfCSRHR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 13:07:17 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48710 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726579AbfCSRHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 13:07:17 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2JH6Gs9080764
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 13:07:16 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2rb30cn63g-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 13:07:16 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Tue, 19 Mar 2019 17:07:10 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 19 Mar 2019 17:07:06 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2JH78BH38666242
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 19 Mar 2019 17:07:08 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 88ED0AE059;
        Tue, 19 Mar 2019 17:07:08 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A074CAE057;
        Tue, 19 Mar 2019 17:07:07 +0000 (GMT)
Received: from [9.145.41.62] (unknown [9.145.41.62])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 19 Mar 2019 17:07:07 +0000 (GMT)
Reply-To: pmorel@linux.ibm.com
Subject: Re: [PATCH v5 1/7] s390: ap: kvm: add PQAP interception for AQIC
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
From:   Pierre Morel <pmorel@linux.ibm.com>
Date:   Tue, 19 Mar 2019 18:07:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190319155421.0f0e51c2@oc2783563651>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19031917-0008-0000-0000-000002CF3977
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19031917-0009-0000-0000-0000223B4DA3
Message-Id: <9c114f56-70bd-cc9e-3751-f62494407246@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-19_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903190125
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/03/2019 15:54, Halil Pasic wrote:
> On Tue, 19 Mar 2019 11:01:44 +0100
> Pierre Morel <pmorel@linux.ibm.com> wrote:
> 
>> On 15/03/2019 18:28, Halil Pasic wrote:
> 
> [..]
> 
>>>
>>> Things get complicated when one considers that ECA.28 is an effective
>>> control.
>>
>> I don't think so, ECA_28 is not really a problem.
>> We do not propagate ECA_AIV in VSIE and ECA_AIV is tested in the vfio
>> driver to support GISA.
>> So that the guest 3 will not support interrupt.
>>
> 
> That was not my concern, but while we are at it... I guess you refer to
> the check in handle_pqap(). That seems to do -EOPNOTSUPP, i.e. got to
> userspace, i.e. with today's QEMU operation exception. Which does not
> seem right.

We already discussed this. no?

> 
> My concern was the following. Let assume
> ECA.28 == 1 and EECA.28 == 0 != 1
> and guest issues a PQAP (for simplicity AQIC).
> 
> Currently I guess we take a 0x04 interception and go to userspace, which
> may or may not be the best thing to do.
> 
> With this patch we would take a 0x04, but (opposed to before) if guest
> does not have facility 65 we go with a specification exception.

This is not right.
We return -EOPNOTSUPP which will be intercepted by QEMU which will 
report an OPERATION exception as before.

> Operation exception should however take priority over this kind of
> specification exception. So basically everything except PQAP/AQIC would
> give you and operation exception (with current QEMU), but PQAP/AQIC would
> give you a specification exception. Which is wrong!
> 
> AFAICT there is no way to tell if we got a 04 interception because
> EECA.28 != 1 (and ECA.28 == 1) and FW won't interpret the AP
> instructions for us, or because it PQAP/AQIC is a mandatory intercept.
> In other words I don't see a way to tell if EECA.28 is 1 when
> interpreting PQAP/AQIC.
> 
> Do you agree?


No.
EECA = HOST_ECA & GUEST_ECA
after we made sure that AP instructions are available, HOST_ECA=1

(vcpu->arch.sie_block->eca & ECA_APIE) gives us the answer.

In the case HOST_ECA=0 we always go to userland as before.

> 
> [..]
> 
>>
>> Yes, the alternative is:
>>
>> 1) We do things right but this mean we change the ABI (SPECIFICATION
>> instead of OPERATION)
>>
>> I thing this is the best thing to do, it is the implementation
>> proposed by this patch where all is done in Kernel, so that we are
>> right what ever the userland user is (QEMU or other).
>>
>> 2) We want to preserve the old ABI for old QEMU
>> Then I proposed the implementation here under.
>>
>>
>> My personal opinion, is that we should change the ABI and do things
>> right now.
> 
> I tend to agree. Giving an operation exception instead of a specification
> exception is a bug. If it is a kernel or qemu bug it ain't clear to me
> at the moment.
> 
>> We should also do it right for TAPQ with t bit set. I remember
>> Christian already warned about this but we did not implement it.
>>
> 
> Yes, I have some blurry memories of something similar myself. I wonder
> if there was a reason, or did we just forget to address this issue.


I will integrate it in the next iteration too, even it is not IRQ, the 
PQAP hook patch can be more general.

Regards,
Pierre

> 
> Regards,
> Halil
> 


-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany

