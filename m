Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E866C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:58:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AA9B218FE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:58:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733079AbfDXO6O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 10:58:14 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60524 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731802AbfDXO6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 10:58:12 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3OEsv1i185340
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 10:58:11 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2s2r9wdxnw-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 10:58:09 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ldufour@linux.ibm.com>;
        Wed, 24 Apr 2019 15:58:04 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 24 Apr 2019 15:57:55 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x3OEvrA663176882
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Apr 2019 14:57:53 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6642AAE04D;
        Wed, 24 Apr 2019 14:57:53 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 93EFBAE051;
        Wed, 24 Apr 2019 14:57:50 +0000 (GMT)
Received: from [9.145.176.48] (unknown [9.145.176.48])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 24 Apr 2019 14:57:50 +0000 (GMT)
Subject: Re: [PATCH v12 23/31] mm: don't do swap readahead during speculative
 page fault
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
        kemi.wang@intel.com, Daniel Jordan <daniel.m.jordan@oracle.com>,
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
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        Vinayak Menon <vinmenon@codeaurora.org>
References: <20190416134522.17540-1-ldufour@linux.ibm.com>
 <20190416134522.17540-24-ldufour@linux.ibm.com>
 <20190422213611.GN14666@redhat.com>
From:   Laurent Dufour <ldufour@linux.ibm.com>
Date:   Wed, 24 Apr 2019 16:57:50 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190422213611.GN14666@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19042414-0016-0000-0000-000002732720
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19042414-0017-0000-0000-000032CF99CC
Message-Id: <42ba3103-cbac-199f-e6f1-0fbc12aaccc8@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-24_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904240116
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 22/04/2019 à 23:36, Jerome Glisse a écrit :
> On Tue, Apr 16, 2019 at 03:45:14PM +0200, Laurent Dufour wrote:
>> Vinayak Menon faced a panic because one thread was page faulting a page in
>> swap, while another one was mprotecting a part of the VMA leading to a VMA
>> split.
>> This raise a panic in swap_vma_readahead() because the VMA's boundaries
>> were not more matching the faulting address.
>>
>> To avoid this, if the page is not found in the swap, the speculative page
>> fault is aborted to retry a regular page fault.
>>
>> Reported-by: Vinayak Menon <vinmenon@codeaurora.org>
>> Signed-off-by: Laurent Dufour <ldufour@linux.ibm.com>
> 
> Reviewed-by: Jérôme Glisse <jglisse@redhat.com>
> 
> Note that you should also skip non swap entry in do_swap_page() when doing
> speculative page fault at very least you need to is_device_private_entry()
> case.
> 
> But this should either be part of patch 22 or another patch to fix swap
> case.

Thanks Jérôme,

Yes I missed that, I guess the best option would be to abort on non swap 
entry. I'll add that in the patch 22.

>> ---
>>   mm/memory.c | 11 +++++++++++
>>   1 file changed, 11 insertions(+)
>>
>> diff --git a/mm/memory.c b/mm/memory.c
>> index 6e6bf61c0e5c..1991da97e2db 100644
>> --- a/mm/memory.c
>> +++ b/mm/memory.c
>> @@ -2900,6 +2900,17 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>>   				lru_cache_add_anon(page);
>>   				swap_readpage(page, true);
>>   			}
>> +		} else if (vmf->flags & FAULT_FLAG_SPECULATIVE) {
>> +			/*
>> +			 * Don't try readahead during a speculative page fault
>> +			 * as the VMA's boundaries may change in our back.
>> +			 * If the page is not in the swap cache and synchronous
>> +			 * read is disabled, fall back to the regular page
>> +			 * fault mechanism.
>> +			 */
>> +			delayacct_clear_flag(DELAYACCT_PF_SWAPIN);
>> +			ret = VM_FAULT_RETRY;
>> +			goto out;
>>   		} else {
>>   			page = swapin_readahead(entry, GFP_HIGHUSER_MOVABLE,
>>   						vmf);
>> -- 
>> 2.21.0
>>
> 

