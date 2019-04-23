Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C5BEC10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 15:46:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BFF7218D2
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 15:46:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728629AbfDWPqM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 11:46:12 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51256 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728614AbfDWPqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 11:46:09 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3NFeX0q020908
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 11:46:08 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2s25cxrs6g-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 11:46:08 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ldufour@linux.ibm.com>;
        Tue, 23 Apr 2019 16:46:06 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 23 Apr 2019 16:45:56 +0100
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x3NFjsxQ46137354
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Apr 2019 15:45:54 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 591F042041;
        Tue, 23 Apr 2019 15:45:54 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 033D842049;
        Tue, 23 Apr 2019 15:45:52 +0000 (GMT)
Received: from [9.145.7.116] (unknown [9.145.7.116])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 23 Apr 2019 15:45:51 +0000 (GMT)
Subject: Re: [PATCH v12 05/31] mm: prepare for FAULT_FLAG_SPECULATIVE
To:     Jerome Glisse <jglisse@redhat.com>
Cc:     akpm@linux-foundation.org, mhocko@kernel.org, peterz@infradead.org,
        kirill@shutemov.name, ak@linux.intel.com, dave@stgolabs.net,
        jack@suse.cz, Matthew Wilcox <willy@infradead.org>,
        aneesh.kumar@linux.ibm.com, benh@kernel.crashing.org,
        mpe@ellerman.id.au, paulus@samba.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, hpa@zytor.com,
        Will Deacon <will.deacon@arm.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        sergey.senozhatsky.work@gmail.com,
        Andrea Arcangeli <aarcange@redhat.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        David Rientjes <rientjes@google.com>,
        Ganesh Mahendran <opensource.ganesh@gmail.com>,
        Minchan Kim <minchan@kernel.org>,
        Punit Agrawal <punitagrawal@gmail.com>,
        vinayak menon <vinayakm.list@gmail.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        zhong jiang <zhongjiang@huawei.com>,
        Haiyan Song <haiyanx.song@intel.com>,
        Balbir Singh <bsingharora@gmail.com>, sj38.park@gmail.com,
        Michel Lespinasse <walken@google.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        haren@linux.vnet.ibm.com, npiggin@gmail.com,
        paulmck@linux.vnet.ibm.com, Tim Chen <tim.c.chen@linux.intel.com>,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org
References: <20190416134522.17540-1-ldufour@linux.ibm.com>
 <20190416134522.17540-6-ldufour@linux.ibm.com>
 <20190418220415.GE11645@redhat.com>
From:   Laurent Dufour <ldufour@linux.ibm.com>
Date:   Tue, 23 Apr 2019 17:45:51 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190418220415.GE11645@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19042315-0020-0000-0000-00000332DF37
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19042315-0021-0000-0000-0000218540CC
Message-Id: <8b102fee-e1bc-28e4-2187-994e39fb6734@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-23_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904230106
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 19/04/2019 à 00:04, Jerome Glisse a écrit :
> On Tue, Apr 16, 2019 at 03:44:56PM +0200, Laurent Dufour wrote:
>> From: Peter Zijlstra <peterz@infradead.org>
>>
>> When speculating faults (without holding mmap_sem) we need to validate
>> that the vma against which we loaded pages is still valid when we're
>> ready to install the new PTE.
>>
>> Therefore, replace the pte_offset_map_lock() calls that (re)take the
>> PTL with pte_map_lock() which can fail in case we find the VMA changed
>> since we started the fault.
>>
>> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>>
>> [Port to 4.12 kernel]
>> [Remove the comment about the fault_env structure which has been
>>   implemented as the vm_fault structure in the kernel]
>> [move pte_map_lock()'s definition upper in the file]
>> [move the define of FAULT_FLAG_SPECULATIVE later in the series]
>> [review error path in do_swap_page(), do_anonymous_page() and
>>   wp_page_copy()]
>> Signed-off-by: Laurent Dufour <ldufour@linux.ibm.com>
> 
> Reviewed-by: Jérôme Glisse <jglisse@redhat.com>
> 
>> ---
>>   mm/memory.c | 87 +++++++++++++++++++++++++++++++++++------------------
>>   1 file changed, 58 insertions(+), 29 deletions(-)
>>
>> diff --git a/mm/memory.c b/mm/memory.c
>> index c6ddadd9d2b7..fc3698d13cb5 100644
>> --- a/mm/memory.c
>> +++ b/mm/memory.c
>> @@ -2073,6 +2073,13 @@ int apply_to_page_range(struct mm_struct *mm, unsigned long addr,
>>   }
>>   EXPORT_SYMBOL_GPL(apply_to_page_range);
>>   
>> +static inline bool pte_map_lock(struct vm_fault *vmf)
> 
> I am not fan of the name maybe pte_offset_map_lock_if_valid() ? But
> that just a taste thing. So feel free to ignore this comment.

I agree with you that adding _if_valid or something equivalent to 
highlight the conditional of this function would be a good idea.

I'll think further about that name but yours looks good ;)


>> +{
>> +	vmf->pte = pte_offset_map_lock(vmf->vma->vm_mm, vmf->pmd,
>> +				       vmf->address, &vmf->ptl);
>> +	return true;
>> +}
>> +
>>   /*
>>    * handle_pte_fault chooses page fault handler according to an entry which was
>>    * read non-atomically.  Before making any commitment, on those architectures
> 

