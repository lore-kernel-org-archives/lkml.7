Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18CBBC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 13:44:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C50ED214D8
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 13:44:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731046AbfB1No3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 08:44:29 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46204 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727781AbfB1No2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 08:44:28 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1SDdFiu078843
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 08:44:26 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qxfnruk9c-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 08:44:25 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Thu, 28 Feb 2019 13:44:23 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 28 Feb 2019 13:44:19 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x1SDiHdr32964762
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 28 Feb 2019 13:44:17 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 940F911C054;
        Thu, 28 Feb 2019 13:44:17 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 804EE11C052;
        Thu, 28 Feb 2019 13:44:16 +0000 (GMT)
Received: from oc7455500831.ibm.com (unknown [9.152.98.20])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 28 Feb 2019 13:44:16 +0000 (GMT)
Subject: Re: [PATCH v4 1/7] s390: ap: kvm: add PQAP interception for AQIC
To:     pmorel@linux.ibm.com, Tony Krowiak <akrowiak@linux.ibm.com>
Cc:     alex.williamson@redhat.com, cohuck@redhat.com,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, frankja@linux.ibm.com, pasic@linux.ibm.com,
        david@redhat.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, freude@linux.ibm.com, mimu@linux.ibm.com
References: <1550849400-27152-1-git-send-email-pmorel@linux.ibm.com>
 <1550849400-27152-2-git-send-email-pmorel@linux.ibm.com>
 <babf7884-35f1-2f2e-34dc-96d9190fd15b@linux.ibm.com>
 <e7ba5cb0-b254-7f73-bc59-ca2456ce7951@linux.ibm.com>
 <9f1d9241-39b9-adbc-d0e9-cb702e609cbc@linux.ibm.com>
 <4dc59125-7f96-cba8-651b-382ed8f8bff8@linux.ibm.com>
 <8526f468-9a4d-68d2-3868-0dad5ce16f46@linux.ibm.com>
 <6058a017-6404-af3c-62ef-2452214ac97c@de.ibm.com>
 <2d52b709-05dd-fa60-658a-36b827cf3041@linux.ibm.com>
From:   Christian Borntraeger <borntraeger@de.ibm.com>
Openpgp: preference=signencrypt
Autocrypt: addr=borntraeger@de.ibm.com; prefer-encrypt=mutual; keydata=
 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
 syiRa+UVlsKmx1hsEg==
Date:   Thu, 28 Feb 2019 14:44:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <2d52b709-05dd-fa60-658a-36b827cf3041@linux.ibm.com>
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 19022813-0008-0000-0000-000002C60CD8
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19022813-0009-0000-0000-000022325EA6
Message-Id: <ee916b01-8d8f-6bcc-8764-4c8b1f636014@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-28_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902280095
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 28.02.2019 14:23, Pierre Morel wrote:
> On 28/02/2019 10:42, Christian Borntraeger wrote:
>>
>>
>> On 27.02.2019 19:00, Tony Krowiak wrote:
>>> On 2/27/19 3:09 AM, Pierre Morel wrote:
>>>> On 26/02/2019 16:47, Tony Krowiak wrote:
>>>>> On 2/26/19 6:47 AM, Pierre Morel wrote:
>>>>>> On 25/02/2019 19:36, Tony Krowiak wrote:
>>>>>>> On 2/22/19 10:29 AM, Pierre Morel wrote:
>>>>>>>> We prepare the interception of the PQAP/AQIC instruction for
>>>>>>>> the case the AQIC facility is enabled in the guest.
>>>>>>>>
>>>>>>>> We add a callback inside the KVM arch structure for s390 for
>>>>>>>> a VFIO driver to handle a specific response to the PQAP
>>>>>>>> instruction with the AQIC command.
>>>>>>>>
>>>>>>>> We inject the correct exceptions from inside KVM for the case the
>>>>>>>> callback is not initialized, which happens when the vfio_ap driver
>>>>>>>> is not loaded.
>>>>>>>>
>>>>>>>> If the callback has been setup we call it.
>>>>>>>> If not we setup an answer considering that no queue is available
>>>>>>>> for the guest when no callback has been setup.
>>>>>>>>
>>>>>>>> We do consider the responsability of the driver to always initialize
>>>>>>>> the PQAP callback if it defines queues by initializing the CRYCB for
>>>>>>>> a guest.
>>>>>>>>
>>>>>>>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>>>>>>
>>>>>> ...snip...
>>>>>>
>>>>>>>> @@ -592,6 +593,55 @@ static int handle_io_inst(struct kvm_vcpu *vcpu)
>>>>>>>>        }
>>>>>>>>    }
>>>>>>>> +/*
>>>>>>>> + * handle_pqap: Handling pqap interception
>>>>>>>> + * @vcpu: the vcpu having issue the pqap instruction
>>>>>>>> + *
>>>>>>>> + * We now support PQAP/AQIC instructions and we need to correctly
>>>>>>>> + * answer the guest even if no dedicated driver's hook is available.
>>>>>>>> + *
>>>>>>>> + * The intercepting code calls a dedicated callback for this instruction
>>>>>>>> + * if a driver did register one in the CRYPTO satellite of the
>>>>>>>> + * SIE block.
>>>>>>>> + *
>>>>>>>> + * For PQAP/AQIC instructions only, verify privilege and specifications.
>>>>>>>> + *
>>>>>>>> + * If no callback available, the queues are not available, return this to
>>>>>>>> + * the caller.
>>>>>>>> + * Else return the value returned by the callback.
>>>>>>>> + */
>>>>>>>> +static int handle_pqap(struct kvm_vcpu *vcpu)
>>>>>>>> +{
>>>>>>>> +    uint8_t fc;
>>>>>>>> +    struct ap_queue_status status = {};
>>>>>>>> +
>>>>>>>> +    /* Verify that the AP instruction are available */
>>>>>>>> +    if (!ap_instructions_available())
>>>>>>>> +        return -EOPNOTSUPP;
>>>>>>>
>>>>>>> How can the guest even execute an AP instruction if the AP instructions
>>>>>>> are not available? If the AP instructions are not available on the host,
>>>>>>> they will not be available on the guest (i.e., CPU model feature
>>>>>>> S390_FEAT_AP will not be set). I suppose it doesn't hurt to check this
>>>>>>> here given QEMU may not be the only client.
>>>>>>>
>>>>>>>> +    /* Verify that the guest is allowed to use AP instructions */
>>>>>>>> +    if (!(vcpu->arch.sie_block->eca & ECA_APIE))
>>>>>>>> +        return -EOPNOTSUPP;
>>>>>>>> +    /* Verify that the function code is AQIC */
>>>>>>>> +    fc = vcpu->run->s.regs.gprs[0] >> 24;
>>>>>>>> +    if (fc != 0x03)
>>>>>>>> +        return -EOPNOTSUPP;
>>>>>>>
>>>>>>> You must have missed my suggestion to move this to the
>>>>>>> vcpu->kvm->arch.crypto.pqap_hook(vcpu) in the following responses:
>>>>>>
>>>>>> Please consider what happen if the vfio_ap module is not loaded.
>>>>>
>>>>> I have considered it and even verified my expectations empirically. If
>>>>> the vfio_ap module is not loaded, you will not be able to create an mdev device.
>>>>
>>>> OK, now please consider that another userland tool, not QEMU uses KVM.
>>>
>>> What does that have to do with loading the vfio_ap module? Without the
>>> vfio_ap module, there will be no AP devices for the guest. What are you
>>> suggesting here?
>>>
>>>>
>>>>> If you don't have an mdev device, you will not be able to
>>>>> start a guest with a vfio-ap device. If you start a guest without a
>>>>> vfio-ap device, but enable AP instructions for the guest, there will be
>>>>> no AP devices attached to the guest. Without any AP devices attached,
>>>>> the PQAP(AQIC) instructions will not ever get executed.
>>>>
>>>> This is not right. The instruction will be executed, eventually, after decoding.
>>>
>>> Please explain why the PQAP(AQIC) instruction will be executed on a
>>> guest without any devices? Point me to the code in the AP bus where
>>> PQAP(AQIC) is executed without a queue?
>>
>> The host must be prepared to handle malicous and broken guests. So if
>> a guest does PQAP, we must handle that gracefully (e.g. by injecting an
>> exception)
>>
>>>
>>>>
>>>>> Even if for some
>>>>> unknown reason the PQAP(AQIC) instruction is executed - for some unknown
>>>>> reason, it will fail with response code 0x01, AP-queue number not valid.
>>>>
>>>> No, before accessing the AP-queue the instruction will be decoded and depending on the installed micro-code it will fail with
>>>> - OPERATION EXCEPTION if the micro-code is not installed
>>>> - PRIVILEDGE OPERATION if the instruction is issued from userland (programm state)
>>>> - SPECIFICATION exception if the instruction do not respect the usage specification
>>>>
>>>> then it will be interpreted by the microcode and access the queue and only then it will fail with RC 0x01, AP queue not valid.
>>>>
>>>> In the case of KVM, we intercept the instruction because it is issued by the guest and we set the AQIC facility on to force interception.
>>>>
>>>> KVM do for us all the decode steps I mention here above, if there is or not a pqap hook to be call to simulate the QP queue access.
>>>>
>>>> That done, the AP queue virtualisation can be called, this is done by calling the hook.
>>>
>>> Okay, let's go back to the genesis of this discussion; namely, my
>>> suggestion about moving the fc == 0x03 check into the hook code. If
>>> the vfio_ap module is not loaded, there will be no hook code. In that
>>> case, the check for the hook will fail and ultimately response code
>>> 0x01 will be set in the status word (which may not be the right thing
>>> to do?). You have not stated a single good reason for keeping this
>>> check, but I'm done with this silly argument. It certainly doesn't
>>> hurt anything.
>>
>> The instruction handler must handle the basic checks for the
>> instruction itself as outlined above.
>>
>> Do we want to allow QEMU to fully emulate everything (the  ECA_APIE case being off)?
>> The we should pass along everything to QEMU, but this is already done with the
>> ECA_APIE check, correct?
>>
>> Do we agree that when we are beyond the ECA_APIE check, that we do not emulate
>> in QEMU and we have enabled the AP instructions interpretion?
>> If yes then this has some implication:
>>
>> 1. ECA is on and we should only get PQAP interception for specific FC (namely 3).
>> 2. What we certainly should check is the facility bit of the guest (65) and reject fc==3
>> right away with a specification exception. I do not want the hook to mess with
>> the kvm cpu model. @Pierre would be good to actually check test_kvm_facility(vcpu->kvm, 65))
> 
> 
> Currently the check test_kvm_facility(vcpu->kvm, 65) is done in the instruction handler, what do you mean here?

Found it. I think we should couple the check for 64 to fc==3. Otherwise both things are somewhat
disconnected when reviewing.

