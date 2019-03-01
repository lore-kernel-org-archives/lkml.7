Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65955C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 12:10:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F6C520830
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 12:10:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388151AbfCAMKq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 07:10:46 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36896 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732558AbfCAMKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 07:10:46 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x21C9VA1116208
        for <linux-kernel@vger.kernel.org>; Fri, 1 Mar 2019 07:10:45 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qy4361ab4-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2019 07:10:44 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Fri, 1 Mar 2019 12:10:42 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 1 Mar 2019 12:10:39 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x21CAbA224117266
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 1 Mar 2019 12:10:38 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D017C11C052;
        Fri,  1 Mar 2019 12:10:37 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4120511C04A;
        Fri,  1 Mar 2019 12:10:37 +0000 (GMT)
Received: from [9.152.224.140] (unknown [9.152.224.140])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  1 Mar 2019 12:10:37 +0000 (GMT)
Reply-To: pmorel@linux.ibm.com
Subject: Re: [PATCH v4 1/7] s390: ap: kvm: add PQAP interception for AQIC
To:     Halil Pasic <pasic@linux.ibm.com>
Cc:     Christian Borntraeger <borntraeger@de.ibm.com>,
        Tony Krowiak <akrowiak@linux.ibm.com>,
        alex.williamson@redhat.com, cohuck@redhat.com,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, frankja@linux.ibm.com, david@redhat.com,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        freude@linux.ibm.com, mimu@linux.ibm.com
References: <1550849400-27152-1-git-send-email-pmorel@linux.ibm.com>
 <1550849400-27152-2-git-send-email-pmorel@linux.ibm.com>
 <babf7884-35f1-2f2e-34dc-96d9190fd15b@linux.ibm.com>
 <e7ba5cb0-b254-7f73-bc59-ca2456ce7951@linux.ibm.com>
 <9f1d9241-39b9-adbc-d0e9-cb702e609cbc@linux.ibm.com>
 <4dc59125-7f96-cba8-651b-382ed8f8bff8@linux.ibm.com>
 <8526f468-9a4d-68d2-3868-0dad5ce16f46@linux.ibm.com>
 <6058a017-6404-af3c-62ef-2452214ac97c@de.ibm.com>
 <20190228133927.75de6849@oc2783563651>
 <c391ed0f-55f1-70cc-3b5f-058c1fce691c@linux.ibm.com>
 <20190228175132.0b5b6424@oc2783563651>
From:   Pierre Morel <pmorel@linux.ibm.com>
Date:   Fri, 1 Mar 2019 13:10:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190228175132.0b5b6424@oc2783563651>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19030112-0016-0000-0000-0000025C7B02
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19030112-0017-0000-0000-000032B6EE96
Message-Id: <e70df42f-f9d7-b566-a3d7-2dc3f717d352@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-01_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903010086
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/02/2019 17:51, Halil Pasic wrote:
> On Thu, 28 Feb 2019 15:12:16 +0100
> Pierre Morel <pmorel@linux.ibm.com> wrote:
> 
>> On 28/02/2019 13:39, Halil Pasic wrote:
>>> On Thu, 28 Feb 2019 10:42:23 +0100
>>> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> [..]
>>>> Correct?
>>>
>>> IMHO mostly.
>>>
>>> I also doing the facility checks in kvm is easier, and I think this is
>>> something we can change later if needed without any major trouble.
>>>
>>> There are a couple of things I would do differently than Pierre does:
>>> 1) Do the PGM_PRIVILEGED_OP before the fc == 3 check.
>>
>> Idea was not to modify existing behavior for fc != 3
>>
>> Also Christian already proposed to handle all FC codes. So in this idea,
>> this must be done as you say.
>>
>>>
>>> 2) Do the test_kvm_facility(vcpu->kvm, 65) check in the context of fc ==
>>> 3. I.e. decide if this hook is about pqap or just about pqap aqic and
>>> make the code convey that decision to its reader.
>>>
>>> 3) I would most probably test if the queue is available by looking at the
>>> masks in CRYCB here. If not AP_RESPONSE_Q_NOT_AVAIL is what we need.
>>
>> This I do not agree with, it is typically the responsibility of the part
>> in charge of the virtualization to do this, also the vfio_driver.
>>
> 
> See at 4) regarding the details. My guess is you disagree with checking
> CRYCB explicitly but don't digress with AP_RESPONSE_Q_NOT_AVAIL if APCB
> does not authorize the queue. Your idea was to infer APCB all zero from
> the fact that pqap_hook is NULL.
> 
> If my assumption is right, then yes we can have an implicit coarse check
> here and a fine grained check in the client code (vfio_ap).




> 
>>>
>>> 4) If we have APIE and queues authorized by the CRYCB (i.e. we have a
>>> vfio_ap module loaded an an mdev associated with the kvm) the callback
>>> not set (!(vcpu->kvm->arch.crypto.pqap_hook)) is a BUG!
>>
>> I do not agree with this either, the maintainers ;) will not allow this.
> 
> After an offline discussion we came to the conclusion that I did not
> understand your code.
> 
> Your train of thought was:
> 
> !(vcpu->kvm->arch.crypto.pqap_hook) _implies_ APCB all zero (i.e. the
> masks in the CRYCB
> 
> This is *why* you respond with AP_RESPONSE_Q_NOT_AVAIL.
> 
> However if that is the case I would like that spelled out in a code
> comment at least. Furthermore setting pqap_hook and APCB needs to happen
> in the right sequence. Means client code (vfio_ap) may only set APCB
> after the qpap_hook has been set. Currently we have a race there (as
> you first do  kvm_arch_crypto_set_masks and only then
> kvm->arch.crypto.pqap_hook. Furthermore I guess
> kvm->arch.crypto.pqap_hook needs to be set with the kvm lock held, which
> does not seem to be the case.


Yes, that is right.
This part (setting/resetting hook and CRYCB will be modified for the 
reason you mention and also to correctly handle the order of releasing 
KVM and VFIO, as you and Christian mentioned.




> 
>>
>>> In that case
>>> lying that the queue is not available does not seem right. BTW this
>>> is something Pierre changed since the last version quietly (I can't
>>> recall a mention in the change log or somebody asking for this). If
>>> we want to be very pedantic about this bug scenario our best bet is
>>> probably response code 6.
>>
>>
>> RC 06 means "Invalid address of AP-queue notification byte"
>>
>> So you must have think about another code or I do not understand at
>> all what you mean.
>>
> 
> I did not assume you decided to ignore the possibility of a programming
> error (which you at least technically did commit yourself) for what I
> described as a BUG.
> 
> My train of thought was, if we are very pedantic we can make things work
> with degraded functionality in that case. I.e. without AP interrupts.
> For that we need to tell the guest something like: yes your queue is
> fine and there and all that but AQCI setup interrupts did not work. And
> RC 06 is the only RC I see being suitable to convey that.
> 
> Detect and handle if the client code does not hold up their end of the
> bargain or just ignore the possibility is a design decision. But at least
> you should spell out your expectations against the client code.
> 
> Regards,
> Halil
> 

I prefer to comment the obligation for the vfio_driver to register the 
callback instead to add code complexity for which will eventually go 
deeper and deeper.


Thanks,
Pierre


-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany

