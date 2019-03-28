Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE520C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 12:43:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 967942082F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 12:43:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbfC1Mnq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 08:43:46 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58560 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726108AbfC1Mnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 08:43:45 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2SCYweh112199
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 08:43:44 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2rgw2y40x3-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 08:43:43 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Thu, 28 Mar 2019 12:43:42 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 28 Mar 2019 12:43:39 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2SChbak16711864
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Mar 2019 12:43:37 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4E959A405C;
        Thu, 28 Mar 2019 12:43:37 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CE9B8A405F;
        Thu, 28 Mar 2019 12:43:36 +0000 (GMT)
Received: from [9.152.224.145] (unknown [9.152.224.145])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 28 Mar 2019 12:43:36 +0000 (GMT)
Reply-To: pmorel@linux.ibm.com
Subject: Re: [PATCH v6 1/7] s390: ap: kvm: add PQAP interception for AQIC
To:     Tony Krowiak <akrowiak@linux.ibm.com>, borntraeger@de.ibm.com
Cc:     alex.williamson@redhat.com, cohuck@redhat.com,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, frankja@linux.ibm.com, pasic@linux.ibm.com,
        david@redhat.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, freude@linux.ibm.com, mimu@linux.ibm.com
References: <1553265828-27823-1-git-send-email-pmorel@linux.ibm.com>
 <1553265828-27823-2-git-send-email-pmorel@linux.ibm.com>
 <66abb1f6-425a-df94-cc7c-f1fdec0ece9c@linux.ibm.com>
From:   Pierre Morel <pmorel@linux.ibm.com>
Date:   Thu, 28 Mar 2019 13:43:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <66abb1f6-425a-df94-cc7c-f1fdec0ece9c@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19032812-0028-0000-0000-000003599422
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19032812-0029-0000-0000-000024185479
Message-Id: <1489c200-8eec-309e-f253-8dce5a6d88d1@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-28_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903280089
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/03/2019 19:57, Tony Krowiak wrote:
> On 3/22/19 10:43 AM, Pierre Morel wrote:
>> We prepare the interception of the PQAP/AQIC instruction for
>> the case the AQIC facility is enabled in the guest.
>>

...snip...

>> +/*
>> + * handle_pqap: Handling pqap interception
>> + * @vcpu: the vcpu having issue the pqap instruction
>> + *
>> + * We now support PQAP/AQIC instructions and we need to correctly
>> + * answer the guest even if no dedicated driver's hook is available.
>> + *
>> + * The intercepting code calls a dedicated callback for this instruction
>> + * if a driver did register one in the CRYPTO satellite of the
>> + * SIE block.
>> + *
>> + * For PQAP AQIC and TAPQ instructions, verify privilege and 
>> specifications.
> 
> The two paragraphs above should be described via the comments embedded
> in the code and is not necessary here.
> 
>> + *
>> + * If no callback available, the queues are not available, return 
>> this to
>> + * the caller.
> 
> This implies it is specified via the return code when it is in fact
> the response code in the status word.
> 
>> + * Else return the value returned by the callback.
>> + */
> 
> Given this handler may be called for any PQAP instruction sub-function,
> I think the function doc should be more generic, providing:
> 
> * A general description of what the function does
> * A description of each input parameter
> * A description of the value returned. If the return value is a return
>    code, the possible rc values can be enumerated with a description for
>    of the reason each particular value may be returned.

Sorry, I do not understand what you want here.
Isn't it exactly what is done?

And don't you exactly say the opposite when you say that the description 
should be done by the embedded comments?


> 
>> +static int handle_pqap(struct kvm_vcpu *vcpu)
>> +{
>> +    struct ap_queue_status status = {};
>> +    unsigned long reg0;
>> +    int ret;
>> +    uint8_t fc;
>> +
>> +    /* Verify that the AP instruction are available */
>> +    if (!ap_instructions_available())
>> +        return -EOPNOTSUPP;
>> +    /* Verify that the guest is allowed to use AP instructions */
>> +    if (!(vcpu->arch.sie_block->eca & ECA_APIE))
>> +        return -EOPNOTSUPP;
>> +    /*
>> +     * The only possibly intercepted instructions when AP 
>> instructions are
>> +     * available for the guest are AQIC and TAPQ with the t bit set
>> +     * since we do not set IC.3 (FIII) we currently will not intercept
>> +     * TAPQ.
>> +     * The following code will only treat AQIC function code.
>> +     */
> 
> Simplify to:
> 
> /* The only supported PQAP function is AQIC (0x03) */

OK, but then istn't obvious from reading the code ?

> 
>> +    reg0 = vcpu->run->s.regs.gprs[0];
>> +    fc = reg0 >> 24;
>> +    if (fc != 0x03) {
>> +        pr_warn("%s: Unexpected interception code 0x%02x\n",
>> +            __func__, fc);
>> +        return -EOPNOTSUPP;
>> +    }
>> +    /* All PQAP instructions are allowed for guest kernel only */
> 
> There is only one PQAP instruction with multiple sub-functions.
> /* PQAP instruction is allowed for guest kernel only */
>                          or
> /* PQAP instruction is privileged */

OK

> 
>> +    if (vcpu->arch.sie_block->gpsw.mask & PSW_MASK_PSTATE)
>> +        return kvm_s390_inject_program_int(vcpu, PGM_PRIVILEGED_OP);
>> +    /*
>> +     * Common tests for PQAP instructions to generate a specification
>> +     * exception
>> +     */
> 
> This comment is unnecessary as the individual comments below adequately
> do the job.

OK

> 
>> +    /* Zero bits overwrite produce a specification exception */
> 
> This comment has no meaning unless you intimately know the architecture.
> The following would make more sense:
> 
>      /* Bits 41-47 must all be zeros */
> 
> It's probably not a big deal, but since we don't support PQAP(TAPQ),
> would it make more sense to make sure bits 40-47 are zeros (i.e.,
> the 't' bit is not set)?

I am not sure about this one as APFT is installed in our case.
Or do you want that we test if it is installed and test the bit 40?

We should discuss this offline because I do not find any evidence that 
we should really do this in the documentation.

> 
>> +    if (reg0 & 0x007f0000UL)
>> +        goto specification_except;
>> +    /* If APXA is not installed APQN is limited */
> 
> Wouldn't it be better to state how the APQN is limited?
> For example:
> 
>      /*
>       * If APXA is not installed, then the maximum APID is
>       * 63 (bits 48-49 of reg0 must be zero) and the maximum
>       * APQI is 15 (bits 56-59 must be zero)
>       */
OK
> 
>> +    if (!(vcpu->kvm->arch.crypto.crycbd & 0x02))
>> +        if (reg0 & 0x000030f0UL)
> 
> If APXA is not installed, then bits 48-49 and 56-59 must all be
> zeros. Shouldn't this mask be 0x0000c0f0UL?

You can better count than I do ;)
I will change this to c0f0.

...snip...
> 
> 
> 
>> +    status.response_code = 0x01;
>> +    memcpy(&vcpu->run->s.regs.gprs[1], &status, sizeof(status));

hum,
I miss a
	kvm_s390_set_psw_cc(vcpu, 3);
here
and certainly wherever fault in the status response code are set.

Will be corrected in the next iteration.


Thanks for the comments,

regards,
Pierre



-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany

