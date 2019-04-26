Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7752DC43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 10:48:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B2DB206A3
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 10:48:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726404AbfDZKs0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 06:48:26 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34480 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725877AbfDZKsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 06:48:25 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3QAdfOK012259
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2019 06:48:24 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2s40259n0c-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2019 06:48:23 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Fri, 26 Apr 2019 11:48:22 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 26 Apr 2019 11:48:20 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x3QAmI6d38797540
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Apr 2019 10:48:18 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BD2EEA4055;
        Fri, 26 Apr 2019 10:48:18 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3944EA404D;
        Fri, 26 Apr 2019 10:48:18 +0000 (GMT)
Received: from [9.145.15.72] (unknown [9.145.15.72])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 26 Apr 2019 10:48:18 +0000 (GMT)
Reply-To: pmorel@linux.ibm.com
Subject: Re: [PATCH] KVM: s390: vsie: Return correct values for Invalid CRYCB
 format
To:     Christian Borntraeger <borntraeger@de.ibm.com>,
        David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, cohuck@redhat.com,
        linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        frankja@linux.ibm.com, akrowiak@linux.ibm.com,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
References: <1556269201-22918-1-git-send-email-pmorel@linux.ibm.com>
 <3b17dd58-77d9-65c1-335b-17ecba902f9f@redhat.com>
 <38c40ea1-9a7f-d720-a994-74c5bcee8e22@de.ibm.com>
From:   Pierre Morel <pmorel@linux.ibm.com>
Date:   Fri, 26 Apr 2019 12:48:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <38c40ea1-9a7f-d720-a994-74c5bcee8e22@de.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19042610-0020-0000-0000-000003367236
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19042610-0021-0000-0000-00002188E2CF
Message-Id: <d4cefe3e-1b53-82e0-10ef-326ac78f8fc8@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-26_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904260075
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/04/2019 11:03, Christian Borntraeger wrote:
> 
> 
> On 26.04.19 11:01, David Hildenbrand wrote:
>> On 26.04.19 11:00, Pierre Morel wrote:
>>> Let's use the correct validity number.
>>>
>>> Fixes: 55ded154b43 "KVM: s390: vsie: Allow CRYCB FORMAT-2"
>>
>>   LANG=c git show 55ded154b43
>> fatal: ambiguous argument '55ded154b43': unknown revision or path not in
>> the working tree.
>> Use '--' to separate paths from revisions, like this:
>>
> 
> I think this should be
> 56019f9aca2266edc7f304d91e4e772023b7aa14

Yes it is, sorry, forgot to adjust the hash

> 
>>
>>>
>>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>>> Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
>>> ---
>>>   arch/s390/kvm/vsie.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
>>> index ac411e9..076090f 100644
>>> --- a/arch/s390/kvm/vsie.c
>>> +++ b/arch/s390/kvm/vsie.c
>>> @@ -344,7 +344,7 @@ static int shadow_crycb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
>>>   end:
>>>   	switch (ret) {
>>>   	case -EINVAL:
>>> -		return set_validity_icpt(scb_s, 0x0020U);
>>> +		return set_validity_icpt(scb_s, 0x0022U);
>>>   	case -EFAULT:
>>>   		return set_validity_icpt(scb_s, 0x0035U);
>>>   	case -EACCES:
>>>
>>
>>
> 


-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany

