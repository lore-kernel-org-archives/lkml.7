Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F40CC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 14:14:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64C62214D8
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 14:14:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732648AbfB1OOY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 09:14:24 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35612 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732329AbfB1OOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 09:14:23 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1SEDUJW119003
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 09:14:22 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qxfhkwjyk-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 09:14:22 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Thu, 28 Feb 2019 14:14:20 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 28 Feb 2019 14:14:16 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x1SEEEVP54395094
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 28 Feb 2019 14:14:14 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B484FA4053;
        Thu, 28 Feb 2019 14:14:14 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 20FE6A4040;
        Thu, 28 Feb 2019 14:14:14 +0000 (GMT)
Received: from [9.152.224.140] (unknown [9.152.224.140])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 28 Feb 2019 14:14:14 +0000 (GMT)
Reply-To: pmorel@linux.ibm.com
Subject: Re: [PATCH v4 1/7] s390: ap: kvm: add PQAP interception for AQIC
To:     Cornelia Huck <cohuck@redhat.com>
Cc:     Christian Borntraeger <borntraeger@de.ibm.com>,
        Tony Krowiak <akrowiak@linux.ibm.com>,
        alex.williamson@redhat.com, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        frankja@linux.ibm.com, pasic@linux.ibm.com, david@redhat.com,
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
 <2391adc2-6611-034c-61c5-feb46e2a751b@de.ibm.com>
 <20190228122251.75b31f62.cohuck@redhat.com>
 <be69498a-c4d3-81e7-b8bf-6931058cee74@linux.ibm.com>
 <20190228145254.2909425e.cohuck@redhat.com>
From:   Pierre Morel <pmorel@linux.ibm.com>
Date:   Thu, 28 Feb 2019 15:14:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190228145254.2909425e.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19022814-0012-0000-0000-000002FB530E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19022814-0013-0000-0000-00002132FF74
Message-Id: <261a1e22-3703-21a4-e33d-e737651e7d89@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-28_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=871 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902280099
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/02/2019 14:52, Cornelia Huck wrote:
> On Thu, 28 Feb 2019 14:16:09 +0100
> Pierre Morel <pmorel@linux.ibm.com> wrote:
> 
>> On 28/02/2019 12:22, Cornelia Huck wrote:
> 
>>> So, to summarize, the function should do:
>>> - Is userspace supposed to emulate everything (!ECA_APIE)? Return
>>>     -EOPNOTSUPP to hand control to it.
>>> - We are now interpreting the instruction in KVM. Do common checks
>>>     (PSTATE etc.) and inject exceptions, if needed.
>>> - Now look at the fc; if there's a handler for it, call that; if not
>>>     (case does not attempt to call a specific handler, or no handler
>>>     registered), inject a specification exception. (Do we want pre-checks
>>>     like for facility 65 here, or in the handler?)
>>>
>>> That response code 0x01 thingy probably needs to go into the specific
>>> handler function, if anywhere (don't know the semantics, sorry).
>>
>> What do you mean with specific handler function?
>>
>> If you mean a switch around the FC with static function's call, I agree,
>> if you mean a jump into a hook I do not agree.
> 
> Ah, ok; so each case (that we want to handle) should call into a
> subhandler that does
> {
> 	(... check things like facilities ...)
> 	if (!specific_hook)
> 		inject_specif_excp_and_return();
> 	ret = specific_hook();
> 	if (ret)
> 		set_resp_code_0x01(); // or in specific_hook()?
> }
> 
> ?

Yes something in this direction.

>   
>>>
>>> Question: Will the handlers for the individual fcs need to generate
>>> different exceptions on their own? I.e., do they need to do injections
>>> themselves, or should the calling function possibly inject an exception
>>> on error?
>>
>> There are some specificities.
> 
> Ok, should probably done in the subhandlers?
> 
> (I hope I don't muddy the waters too much; but basically, I'm poking
> around with a stick in the dark :)
> 

No problem, it is OK.
My first idea was to make only changes associated with PQAP/AQIC.
We already should have done it for all PQAP functions so it is decided 
that we will do it now as Christian proposed.

Regards,
Pierre


-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany

