Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68AA1C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 11:18:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42E1620811
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 11:18:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727420AbfDWLSV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 07:18:21 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46002 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726033AbfDWLSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 07:18:20 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3NBHovN093250
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 07:18:19 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2s204kcfc4-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 07:18:11 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ldufour@linux.vnet.ibm.com>;
        Tue, 23 Apr 2019 12:16:49 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 23 Apr 2019 12:16:44 +0100
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x3NBGi4C51249342
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Apr 2019 11:16:44 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E72154203F;
        Tue, 23 Apr 2019 11:16:43 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1E16142041;
        Tue, 23 Apr 2019 11:16:43 +0000 (GMT)
Received: from [9.145.7.116] (unknown [9.145.7.116])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 23 Apr 2019 11:16:43 +0000 (GMT)
Subject: Re: [PATCH] x86/mpx: fix recursive munmap() corruption
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, rguenther@suse.de,
        mhocko@suse.com, vbabka@suse.cz, luto@amacapital.net,
        x86@kernel.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-mm@kvack.org, stable@vger.kernel.org
References: <20190401141549.3F4721FE@viggo.jf.intel.com>
 <alpine.DEB.2.21.1904191248090.3174@nanos.tec.linutronix.de>
 <87d0lht1c0.fsf@concordia.ellerman.id.au>
From:   Laurent Dufour <ldufour@linux.vnet.ibm.com>
Date:   Tue, 23 Apr 2019 13:16:42 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <87d0lht1c0.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19042311-0016-0000-0000-00000271A450
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19042311-0017-0000-0000-000032CE0F69
Message-Id: <6718ede2-1fcb-1a8f-a116-250eef6416c7@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-23_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904230080
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 20/04/2019 à 12:31, Michael Ellerman a écrit :
> Thomas Gleixner <tglx@linutronix.de> writes:
>> On Mon, 1 Apr 2019, Dave Hansen wrote:
>>> diff -puN mm/mmap.c~mpx-rss-pass-no-vma mm/mmap.c
>>> --- a/mm/mmap.c~mpx-rss-pass-no-vma	2019-04-01 06:56:53.409411123 -0700
>>> +++ b/mm/mmap.c	2019-04-01 06:56:53.423411123 -0700
>>> @@ -2731,9 +2731,17 @@ int __do_munmap(struct mm_struct *mm, un
>>>   		return -EINVAL;
>>>   
>>>   	len = PAGE_ALIGN(len);
>>> +	end = start + len;
>>>   	if (len == 0)
>>>   		return -EINVAL;
>>>   
>>> +	/*
>>> +	 * arch_unmap() might do unmaps itself.  It must be called
>>> +	 * and finish any rbtree manipulation before this code
>>> +	 * runs and also starts to manipulate the rbtree.
>>> +	 */
>>> +	arch_unmap(mm, start, end);
>>
>> ...
>>    
>>> -static inline void arch_unmap(struct mm_struct *mm, struct vm_area_struct *vma,
>>> -			      unsigned long start, unsigned long end)
>>> +static inline void arch_unmap(struct mm_struct *mm, unsigned long start,
>>> +			      unsigned long end)
>>
>> While you fixed up the asm-generic thing, this breaks arch/um and
>> arch/unicorn32. For those the fixup is trivial by removing the vma
>> argument.
>>
>> But itt also breaks powerpc and there I'm not sure whether moving
>> arch_unmap() to the beginning of __do_munmap() is safe. Micheal???
> 
> I don't know for sure but I think it should be fine. That code is just
> there to handle CRIU unmapping/remapping the VDSO. So that either needs
> to happen while the process is stopped or it needs to handle races
> anyway, so I don't see how the placement within the unmap path should
> matter.

My only concern is the error path.
Calling arch_unmap() before handling any error case means that it will 
have to be undo and there is no way to do so.

I don't know what is the rational to move arch_unmap() to the beginning 
of __do_munmap() but the error paths must be managed.

>> Aside of that the powerpc variant looks suspicious:
>>
>> static inline void arch_unmap(struct mm_struct *mm,
>>                                unsigned long start, unsigned long end)
>> {
>>   	if (start <= mm->context.vdso_base && mm->context.vdso_base < end)
>>                  mm->context.vdso_base = 0;
>> }
>>
>> Shouldn't that be:
>>
>>   	if (start >= mm->context.vdso_base && mm->context.vdso_base < end)
>>
>> Hmm?
> 
> Yeah looks pretty suspicious. I'll follow-up with Laurent who wrote it.
> Thanks for spotting it!

I've to admit that I had to read that code carefully before answering.

There are 2 assumptions here:
  1. 'start' and 'end' are page aligned (this is guaranteed by 
__do_munmap().
  2. the VDSO is 1 page (this is guaranteed by the union vdso_data_store 
on powerpc).

The idea is to handle a munmap() call surrounding the VDSO area:
       | VDSO |
  ^start         ^end

This is covered by this test, as the munmap() matching the exact 
boundaries of the VDSO is handled too.

Am I missing something ?

Cheers,
Laurent.

