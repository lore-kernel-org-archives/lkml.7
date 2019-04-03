Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C4E8C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 14:22:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 256172075E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 14:22:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbfDCOWs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 10:22:48 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47712 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726144AbfDCOWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 10:22:48 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x33EFBtV133797
        for <linux-kernel@vger.kernel.org>; Wed, 3 Apr 2019 10:22:47 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2rmwf53u7j-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 10:22:46 -0400
Received: from localhost
        by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <walling@linux.ibm.com>;
        Wed, 3 Apr 2019 15:22:46 +0100
Received: from b03cxnp08026.gho.boulder.ibm.com (9.17.130.18)
        by e31.co.us.ibm.com (192.168.1.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 3 Apr 2019 15:22:42 +0100
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x33EMdHk60031212
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 3 Apr 2019 14:22:39 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B11FB136051;
        Wed,  3 Apr 2019 14:22:39 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DFD38136053;
        Wed,  3 Apr 2019 14:22:38 +0000 (GMT)
Received: from [9.56.58.47] (unknown [9.56.58.47])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed,  3 Apr 2019 14:22:38 +0000 (GMT)
Subject: Re: [PATCH v3 1/2] s390/setup: diag318: remove bit check and refactor
 struct
To:     Cornelia Huck <cohuck@redhat.com>,
        David Hildenbrand <david@redhat.com>
Cc:     pbonzini@redhat.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        borntraeger@de.ibm.com, frankja@linux.ibm.com
References: <20190402174636.15175-1-walling@linux.ibm.com>
 <20190402174636.15175-2-walling@linux.ibm.com>
 <599addd3-a4f8-d4e7-5898-dc45f52cd7a6@redhat.com>
 <20190403143333.2a3db681.cohuck@redhat.com>
From:   Collin Walling <walling@linux.ibm.com>
Date:   Wed, 3 Apr 2019 10:22:38 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190403143333.2a3db681.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19040314-8235-0000-0000-00000E78E889
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010867; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000284; SDB=6.01183759; UDB=6.00619764; IPR=6.00964510;
 MB=3.00026276; MTD=3.00000008; XFM=3.00000015; UTC=2019-04-03 14:22:44
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19040314-8236-0000-0000-00004502BD8A
Message-Id: <bce6e8cf-6f45-7549-8ada-ba4f77059487@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-03_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904030097
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/3/19 8:33 AM, Cornelia Huck wrote:
> On Wed, 3 Apr 2019 14:03:21 +0200
> David Hildenbrand <david@redhat.com> wrote:
> 
>> On 02.04.19 19:46, Collin Walling wrote:
>>> Execution of DIAGNOSE 0x318 is fenced by checking an SCLP bit
>>> for the availability of hardware support for the instruction.
>>>
>>> In order to support this instruction for a KVM/QEMU guest, we
>>> would need to provide modifications to the SCLP Read SCP Info
>>> data, which will in turn reduce the maximum number of CPUs that
>>> may be provided to the guest. This issue introduces compatability
>>> and legacy concerns.
>>>
>>> Let's circumvent this issue by removing the bit check and blindly
>>> executing the instruction. An exception table rule is in place to
>>> catch the case where hardware does not support this instruction.
>>>
>>> While we're at it, let's condense the version code fields in the
>>> diag318_info struct until we can determine how it will be used.
>>>
>>> This modifies commit 4ad78b8651aacf26b3ab6d1e784952eb70469c43
>>>
>>> Signed-off-by: Collin Walling <walling@linux.ibm.com>
>>> ---
>>>   arch/s390/include/asm/diag.h |  6 ++----
>>>   arch/s390/kernel/setup.c     | 12 ++++++------
>>>   2 files changed, 8 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/arch/s390/include/asm/diag.h b/arch/s390/include/asm/diag.h
>>> index 19562be22b7e..215516284175 100644
>>> --- a/arch/s390/include/asm/diag.h
>>> +++ b/arch/s390/include/asm/diag.h
>>> @@ -298,10 +298,8 @@ struct diag26c_mac_resp {
>>>   union diag318_info {
>>>   	unsigned long val;
>>>   	struct {
>>> -		unsigned int cpnc : 8;
>>> -		unsigned int cpvc_linux : 24;
>>> -		unsigned char cpvc_distro[3];
>>> -		unsigned char zero;
>>> +		unsigned long cpnc : 8;
>>> +		unsigned long cpvc : 56;
> 
> That part looks reasonable (we don't have a proper convention yet, have
> we?)
> 
>>>   	};
>>>   };
>>>   
>>> diff --git a/arch/s390/kernel/setup.c b/arch/s390/kernel/setup.c
>>> index 2c642af526ce..fe70201f8b5d 100644
>>> --- a/arch/s390/kernel/setup.c
>>> +++ b/arch/s390/kernel/setup.c
>>> @@ -1011,15 +1011,15 @@ static void __init setup_control_program_code(void)
>>>   {
>>>   	union diag318_info diag318_info = {
>>>   		.cpnc = CPNC_LINUX,
>>> -		.cpvc_linux = 0,
>>> -		.cpvc_distro = {0},
>>> +		.cpvc = 0,
>>>   	};
>>>   
>>> -	if (!sclp.has_diag318)
>>> -		return;
>>> -
>>>   	diag_stat_inc(DIAG_STAT_X318);
>>> -	asm volatile("diag %0,0,0x318\n" : : "d" (diag318_info.val));
>>> +	asm volatile(
>>> +		"	diag	%0,0,0x318\n"
>>> +		"0:	nopr	%%r7\n"
>>> +		EX_TABLE(0b,0b)
>>> +		: : "d" (diag318_info.val));
>>>   }
>>>   
>>>   /*
>>>    
>>
>> That smells like a nasty hack to not expose new features in QEMU and
>> deal with the issue of handling CPU limits. No, I don't like this.
>>
>> Fix QEMU, not the kernel.
>>
> 
> I agree. The compat handling is a bit annoying, but I don't think we
> can get around it.
> 

Thanks for the feedback, everyone.

The consensus here is to keep the bit check, so I'll throw that back in.
I'll squeeze in a "clean-up" patch for the diag318_info struct in v4.

I'll see that QEMU 4.1 has a max cpu limit of at most 247 (one less than
the current max). If anyone has a suggestion on a better limit
(Christian mentioned 240), please let me know. Otherwise we can discuss
that value in the next version.

