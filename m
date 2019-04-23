Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D89EC10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 15:22:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD67E206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 15:22:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728394AbfDWPWE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 11:22:04 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46436 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727745AbfDWPWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 11:22:04 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3NFKeoB043492
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 11:22:02 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2s242uuy6c-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 11:22:01 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ldufour@linux.ibm.com>;
        Tue, 23 Apr 2019 16:21:52 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 23 Apr 2019 16:21:42 +0100
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x3NFLfkJ26017998
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Apr 2019 15:21:41 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DC7BC42045;
        Tue, 23 Apr 2019 15:21:40 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 678A04204D;
        Tue, 23 Apr 2019 15:21:38 +0000 (GMT)
Received: from [9.145.7.116] (unknown [9.145.7.116])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 23 Apr 2019 15:21:38 +0000 (GMT)
Subject: Re: [PATCH v12 01/31] mm: introduce CONFIG_SPECULATIVE_PAGE_FAULT
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
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org
References: <20190416134522.17540-1-ldufour@linux.ibm.com>
 <20190416134522.17540-2-ldufour@linux.ibm.com>
 <20190418214721.GA11645@redhat.com>
From:   Laurent Dufour <ldufour@linux.ibm.com>
Date:   Tue, 23 Apr 2019 17:21:37 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190418214721.GA11645@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19042315-0012-0000-0000-00000311DE1E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19042315-0013-0000-0000-0000214A2FD2
Message-Id: <bcb29b68-0dd4-92a7-4f7e-1cb009233ed7@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-23_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904230103
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 18/04/2019 à 23:47, Jerome Glisse a écrit :
> On Tue, Apr 16, 2019 at 03:44:52PM +0200, Laurent Dufour wrote:
>> This configuration variable will be used to build the code needed to
>> handle speculative page fault.
>>
>> By default it is turned off, and activated depending on architecture
>> support, ARCH_HAS_PTE_SPECIAL, SMP and MMU.
>>
>> The architecture support is needed since the speculative page fault handler
>> is called from the architecture's page faulting code, and some code has to
>> be added there to handle the speculative handler.
>>
>> The dependency on ARCH_HAS_PTE_SPECIAL is required because vm_normal_page()
>> does processing that is not compatible with the speculative handling in the
>> case ARCH_HAS_PTE_SPECIAL is not set.
>>
>> Suggested-by: Thomas Gleixner <tglx@linutronix.de>
>> Suggested-by: David Rientjes <rientjes@google.com>
>> Signed-off-by: Laurent Dufour <ldufour@linux.ibm.com>
> 
> Reviewed-by: Jérôme Glisse <jglisse@redhat.com>

Thanks Jérôme.

> Small question below
> 
>> ---
>>   mm/Kconfig | 22 ++++++++++++++++++++++
>>   1 file changed, 22 insertions(+)
>>
>> diff --git a/mm/Kconfig b/mm/Kconfig
>> index 0eada3f818fa..ff278ac9978a 100644
>> --- a/mm/Kconfig
>> +++ b/mm/Kconfig
>> @@ -761,4 +761,26 @@ config GUP_BENCHMARK
>>   config ARCH_HAS_PTE_SPECIAL
>>   	bool
>>   
>> +config ARCH_SUPPORTS_SPECULATIVE_PAGE_FAULT
>> +       def_bool n
>> +
>> +config SPECULATIVE_PAGE_FAULT
>> +	bool "Speculative page faults"
>> +	default y
>> +	depends on ARCH_SUPPORTS_SPECULATIVE_PAGE_FAULT
>> +	depends on ARCH_HAS_PTE_SPECIAL && MMU && SMP
>> +	help
>> +	  Try to handle user space page faults without holding the mmap_sem.
>> +
>> +	  This should allow better concurrency for massively threaded processes
> 
> Is there any case where it does not provide better concurrency ? The
> should make me wonder :)

Depending on the VMA's type, it may not provide better concurrency. 
Indeed only anonymous mapping are managed currently. Perhaps this should 
be mentioned here, is it ?

>> +	  since the page fault handler will not wait for other thread's memory
>> +	  layout change to be done, assuming that this change is done in
>> +	  another part of the process's memory space. This type of page fault
>> +	  is named speculative page fault.
>> +
>> +	  If the speculative page fault fails because a concurrent modification
>> +	  is detected or because underlying PMD or PTE tables are not yet
>> +	  allocated, the speculative page fault fails and a classic page fault
>> +	  is then tried.
>> +
>>   endmenu
>> -- 
>> 2.21.0
>>
> 

