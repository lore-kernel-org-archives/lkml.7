Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E93AAC49ED7
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 02:57:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA6D320650
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 02:57:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390207AbfIQC5A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 22:57:00 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:12128 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729180AbfIQC5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 22:57:00 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x8H2bfFr058044;
        Mon, 16 Sep 2019 22:56:25 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2v2ju774j6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 Sep 2019 22:56:25 -0400
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x8H2lcWu078014;
        Mon, 16 Sep 2019 22:56:24 -0400
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2v2ju774ha-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 Sep 2019 22:56:24 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x8H2acQR008152;
        Tue, 17 Sep 2019 02:56:22 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
        by ppma02dal.us.ibm.com with ESMTP id 2v0svwtjs3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Sep 2019 02:56:22 +0000
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x8H2uL7q56623548
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Sep 2019 02:56:21 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 103BF6A04D;
        Tue, 17 Sep 2019 02:56:21 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3DA3E6A047;
        Tue, 17 Sep 2019 02:56:06 +0000 (GMT)
Received: from [9.199.46.123] (unknown [9.199.46.123])
        by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 17 Sep 2019 02:56:04 +0000 (GMT)
Subject: Re: [PATCH 1/1] powerpc: mm: Check if serialize_against_pte_lookup()
 really needs to run
To:     Leonardo Bras <leonardo@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Christoph Lameter <cl@linux.com>,
        "Tobin C. Harding" <tobin@kernel.org>,
        Jann Horn <jannh@google.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Davidlohr Bueso <dave@stgolabs.net>
References: <20190916205527.1859-1-leonardo@linux.ibm.com>
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Message-ID: <c1ff17e2-902d-87e6-3c1d-fc5db2428b69@linux.ibm.com>
Date:   Tue, 17 Sep 2019 08:26:01 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190916205527.1859-1-leonardo@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-17_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1909170028
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/17/19 2:25 AM, Leonardo Bras wrote:
> If a process (qemu) with a lot of CPUs (128) try to munmap() a large chunk
> of memory (496GB) mapped with THP, it takes an average of 275 seconds,
> which can cause a lot of problems to the load (in qemu case, the guest
> will lock for this time).
> 
> Trying to find the source of this bug, I found out most of this time is
> spent on serialize_against_pte_lookup(). This function will take a lot of
> time in smp_call_function_many() if there is more than a couple CPUs
> running the user process. Since it has to happen to all THP mapped, it will
> take a very long time for large amounts of memory.
> 
> By the docs, serialize_against_pte_lookup() is needed in order to avoid
> pmd_t to pte_t casting inside find_current_mm_pte() to happen concurrently
> with the next part of the functions it's called in.
> It does so by calling a do_nothing() on each CPU in mm->cpu_bitmap[];
> 
> So, by what I could understand, if there is no find_current_mm_pte()
> running, there is no need to call serialize_against_pte_lookup().
> 
> So, to avoid the cost of running serialize_against_pte_lookup(), I propose
> a counter that keeps track of how many find_current_mm_pte() are currently
> running, and if there is none, just skip smp_call_function_many().
> 
> On my workload (qemu), I could see munmap's time reduction from 275 seconds
> to 418ms.
> 
> Signed-off-by: Leonardo Bras <leonardo@linux.ibm.com>

We could possibly avoid that serialize for a full task exit unmap. ie, 
when tlb->fullmm == 1 . But that won't help the Qemu case because it 
does an umap of the guest ram range for which tlb->fullmm != 1.

> 
> ---
> I need more experienced people's help in order to understand if this is
> really a valid improvement, and if mm_struct is the best place to put such
> counter.
> 
> Thanks!
> ---
>   arch/powerpc/include/asm/pte-walk.h | 3 +++
>   arch/powerpc/mm/book3s64/pgtable.c  | 2 ++
>   include/linux/mm_types.h            | 1 +
>   3 files changed, 6 insertions(+)
> 
> diff --git a/arch/powerpc/include/asm/pte-walk.h b/arch/powerpc/include/asm/pte-walk.h
> index 33fa5dd8ee6a..3b82cb3bd563 100644
> --- a/arch/powerpc/include/asm/pte-walk.h
> +++ b/arch/powerpc/include/asm/pte-walk.h
> @@ -40,6 +40,8 @@ static inline pte_t *find_current_mm_pte(pgd_t *pgdir, unsigned long ea,
>   {
>   	pte_t *pte;
>   
> +	atomic64_inc(&current->mm->lockless_ptlookup_count);
> +
>   	VM_WARN(!arch_irqs_disabled(), "%s called with irq enabled\n", __func__);
>   	VM_WARN(pgdir != current->mm->pgd,
>   		"%s lock less page table lookup called on wrong mm\n", __func__);
> @@ -53,6 +55,7 @@ static inline pte_t *find_current_mm_pte(pgd_t *pgdir, unsigned long ea,
>   	if (hshift)
>   		WARN_ON(*hshift);
>   #endif
> +	atomic64_dec(&current->mm->lockless_ptlookup_count);
>   	return pte;
>   }



That is not correct. We need to keep the count updated  across the 
local_irq_disable()/local_irq_enable(). That is we mostly should have a 
variant like start_lockless_pgtbl_walk()/end_lockless_pgtbl_walk(). Also 
there is hash_page_mm which we need to make sure we are protected 
against w.r.t collapse pmd.

>   
> diff --git a/arch/powerpc/mm/book3s64/pgtable.c b/arch/powerpc/mm/book3s64/pgtable.c
> index 7d0e0d0d22c4..8f6fc2f80071 100644
> --- a/arch/powerpc/mm/book3s64/pgtable.c
> +++ b/arch/powerpc/mm/book3s64/pgtable.c
> @@ -95,6 +95,8 @@ static void do_nothing(void *unused)
>   void serialize_against_pte_lookup(struct mm_struct *mm)
>   {
>   	smp_mb();
> +	if (atomic64_read(&mm->lockless_ptlookup_count) == 0)
> +		return;
>   	smp_call_function_many(mm_cpumask(mm), do_nothing, NULL, 1);
>   }
>   
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 6a7a1083b6fb..97fb2545e967 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -518,6 +518,7 @@ struct mm_struct {
>   #endif
>   	} __randomize_layout;
>   
> +	atomic64_t lockless_ptlookup_count;
>   	/*
>   	 * The mm_cpumask needs to be at the end of mm_struct, because it
>   	 * is dynamically sized based on nr_cpu_ids.
> 

Move that to ppc64 specific mm_context_t.


-aneesh
