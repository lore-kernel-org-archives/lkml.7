Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA9D3C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 15:32:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADB6E2084D
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 15:32:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388916AbfCAPcl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 10:32:41 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54138 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388109AbfCAPck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 10:32:40 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x21FUhYB026850
        for <linux-kernel@vger.kernel.org>; Fri, 1 Mar 2019 10:32:39 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qy5frq3m3-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2019 10:32:39 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Fri, 1 Mar 2019 15:32:36 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 1 Mar 2019 15:32:33 -0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x21FWVR928377114
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 1 Mar 2019 15:32:31 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C3EB34203F;
        Fri,  1 Mar 2019 15:32:31 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1A5BF4204B;
        Fri,  1 Mar 2019 15:32:31 +0000 (GMT)
Received: from [9.152.224.140] (unknown [9.152.224.140])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  1 Mar 2019 15:32:31 +0000 (GMT)
Reply-To: pmorel@linux.ibm.com
Subject: Re: [PATCH v4 1/7] s390: ap: kvm: add PQAP interception for AQIC
To:     Cornelia Huck <cohuck@redhat.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     Tony Krowiak <akrowiak@linux.ibm.com>, alex.williamson@redhat.com,
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
 <2391adc2-6611-034c-61c5-feb46e2a751b@de.ibm.com>
 <20190228122251.75b31f62.cohuck@redhat.com>
 <be69498a-c4d3-81e7-b8bf-6931058cee74@linux.ibm.com>
 <20190228145254.2909425e.cohuck@redhat.com>
 <261a1e22-3703-21a4-e33d-e737651e7d89@linux.ibm.com>
 <3fedbde5-ef83-c67e-6352-fd492f258009@linux.ibm.com>
 <f4b3dec4-cdf6-85df-309e-b542ba83230a@de.ibm.com>
 <20190301133609.3ee469dc.cohuck@redhat.com>
From:   Pierre Morel <pmorel@linux.ibm.com>
Date:   Fri, 1 Mar 2019 16:32:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190301133609.3ee469dc.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19030115-0008-0000-0000-000002C68FF9
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19030115-0009-0000-0000-00002232E62C
Message-Id: <7fab18c4-9781-b776-5fd9-250ba19cafe5@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-01_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903010108
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/03/2019 13:36, Cornelia Huck wrote:
> On Fri, 1 Mar 2019 13:05:54 +0100
> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> 
>> On 01.03.2019 13:03, Pierre Morel wrote:
>>> On 28/02/2019 15:14, Pierre Morel wrote:
>>>> On 28/02/2019 14:52, Cornelia Huck wrote:
>>>>> On Thu, 28 Feb 2019 14:16:09 +0100
>>>>> Pierre Morel <pmorel@linux.ibm.com> wrote:
>>>>>   
>>>>>> On 28/02/2019 12:22, Cornelia Huck wrote:
>>>>>   
>>>>>>> So, to summarize, the function should do:
>>>>>>> - Is userspace supposed to emulate everything (!ECA_APIE)? Return
>>>>>>>      -EOPNOTSUPP to hand control to it.
>>>>>>> - We are now interpreting the instruction in KVM. Do common checks
>>>>>>>      (PSTATE etc.) and inject exceptions, if needed.
>>>>>>> - Now look at the fc; if there's a handler for it, call that; if not
>>>>>>>      (case does not attempt to call a specific handler, or no handler
>>>>>>>      registered), inject a specification exception. (Do we want pre-checks
>>>>>>>      like for facility 65 here, or in the handler?)
>>>>>>>
>>>>>>> That response code 0x01 thingy probably needs to go into the specific
>>>>>>> handler function, if anywhere (don't know the semantics, sorry).
>>>>>>
>>>>>> What do you mean with specific handler function?
>>>>>>
>>>>>> If you mean a switch around the FC with static function's call, I agree,
>>>>>> if you mean a jump into a hook I do not agree.
>>>>>
>>>>> Ah, ok; so each case (that we want to handle) should call into a
>>>>> subhandler that does
>>>>> {
>>>>>      (... check things like facilities ...)
>>>>>      if (!specific_hook)
>>>>>          inject_specif_excp_and_return();
>>>>>      ret = specific_hook();
>>>>>      if (ret)
>>>>>          set_resp_code_0x01(); // or in specific_hook()?
>>>>> }
>>>>>
>>>>> ?
>>>>
>>>> Yes something in this direction.
>>>
>>> Sorry, after reflection, no, we do not want to change the previous behavior so we only handle the AQIC case.
>>
>> I think what you wanted to say is the following:
>> Today (without the patch set) we will answer PQAP with an exception.
>> With this patch set we want to handle FC==3, but nothing else. So for anything FC!=3 we
>> will continue to return an exception?
>>
>> Correct?

Yes correct.
Thanks for the much preciser explanation.

>>
> 
> That sounds reasonable; but I don't see how this conflicts with my
> proposal? Just don't introduce a subfunction for fc != 3...
> 

Correct too, it does not conflict, as you said it is just not introduce 
subfunctions.

Regards,
Pierre


-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany

