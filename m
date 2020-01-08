Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58847C33CA2
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 17:20:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 393A320705
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 17:20:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729764AbgAHRUe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 12:20:34 -0500
Received: from ale.deltatee.com ([207.54.116.67]:44280 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729701AbgAHRUd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 12:20:33 -0500
Received: from s0106ac1f6bb1ecac.cg.shawcable.net ([70.73.163.230] helo=[192.168.11.155])
        by ale.deltatee.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1ipF00-0004MS-Qh; Wed, 08 Jan 2020 10:20:05 -0700
To:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-mm@kvack.org, Dan Williams <dan.j.williams@intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Eric Badger <ebadger@gigaio.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
References: <20200107205959.7575-1-logang@deltatee.com>
 <20200107205959.7575-7-logang@deltatee.com>
 <a5501f2a-ff8d-cea2-1540-1a70ea6bc2d2@redhat.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <9226e0e4-832b-d873-f433-f29a7853f11e@deltatee.com>
Date:   Wed, 8 Jan 2020 10:20:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <a5501f2a-ff8d-cea2-1540-1a70ea6bc2d2@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 70.73.163.230
X-SA-Exim-Rcpt-To: borntraeger@de.ibm.com, gor@linux.ibm.com, heiko.carstens@de.ibm.com, ebadger@gigaio.com, peterz@infradead.org, luto@kernel.org, dave.hansen@linux.intel.com, bp@alien8.de, mingo@redhat.com, tglx@linutronix.de, benh@kernel.crashing.org, will@kernel.org, catalin.marinas@arm.com, hch@lst.de, akpm@linux-foundation.org, mhocko@kernel.org, dan.j.williams@intel.com, linux-mm@kvack.org, platform-driver-x86@vger.kernel.org, linux-sh@vger.kernel.org, linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-ia64@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, david@redhat.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v2 6/8] s390/mm: Thread pgprot_t through
 vmem_add_mapping()
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020-01-08 5:43 a.m., David Hildenbrand wrote:
> On 07.01.20 21:59, Logan Gunthorpe wrote:
>> In prepartion to support a pgprot_t argument for arch_add_memory().
>>
>> Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
>> Cc: Vasily Gorbik <gor@linux.ibm.com>
>> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
>> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
>> ---
>>  arch/s390/include/asm/pgtable.h |  3 ++-
>>  arch/s390/mm/extmem.c           |  3 ++-
>>  arch/s390/mm/init.c             |  2 +-
>>  arch/s390/mm/vmem.c             | 10 +++++-----
>>  4 files changed, 10 insertions(+), 8 deletions(-)
>>
>> diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
>> index 7b03037a8475..e667a1a96879 100644
>> --- a/arch/s390/include/asm/pgtable.h
>> +++ b/arch/s390/include/asm/pgtable.h
>> @@ -1640,7 +1640,8 @@ static inline swp_entry_t __swp_entry(unsigned long type, unsigned long offset)
>>  
>>  #define kern_addr_valid(addr)   (1)
>>  
>> -extern int vmem_add_mapping(unsigned long start, unsigned long size);
>> +extern int vmem_add_mapping(unsigned long start, unsigned long size,
>> +			    pgprot_t prot);
>>  extern int vmem_remove_mapping(unsigned long start, unsigned long size);
>>  extern int s390_enable_sie(void);
>>  extern int s390_enable_skey(void);
>> diff --git a/arch/s390/mm/extmem.c b/arch/s390/mm/extmem.c
>> index fd0dae9d10f4..6cf7029a7b35 100644
>> --- a/arch/s390/mm/extmem.c
>> +++ b/arch/s390/mm/extmem.c
>> @@ -313,7 +313,8 @@ __segment_load (char *name, int do_nonshared, unsigned long *addr, unsigned long
>>  		goto out_free;
>>  	}
>>  
>> -	rc = vmem_add_mapping(seg->start_addr, seg->end - seg->start_addr + 1);
>> +	rc = vmem_add_mapping(seg->start_addr, seg->end - seg->start_addr + 1,
>> +			      PAGE_KERNEL);
>>  
>>  	if (rc)
>>  		goto out_free;
>> diff --git a/arch/s390/mm/init.c b/arch/s390/mm/init.c
>> index a0c88c1c9ad0..ef19522ddad2 100644
>> --- a/arch/s390/mm/init.c
>> +++ b/arch/s390/mm/init.c
>> @@ -277,7 +277,7 @@ int arch_add_memory(int nid, u64 start, u64 size,
>>  	if (WARN_ON_ONCE(modifiers->altmap))
>>  		return -EINVAL;
>>  
>> -	rc = vmem_add_mapping(start, size);
>> +	rc = vmem_add_mapping(start, size, PAGE_KERNEL);
>>  	if (rc)
>>  		return rc;
>>  
>> diff --git a/arch/s390/mm/vmem.c b/arch/s390/mm/vmem.c
>> index b403fa14847d..8a5e95f184a2 100644
>> --- a/arch/s390/mm/vmem.c
>> +++ b/arch/s390/mm/vmem.c
>> @@ -66,7 +66,7 @@ pte_t __ref *vmem_pte_alloc(void)
>>  /*
>>   * Add a physical memory range to the 1:1 mapping.
>>   */
>> -static int vmem_add_mem(unsigned long start, unsigned long size)
>> +static int vmem_add_mem(unsigned long start, unsigned long size, pgprot_t prot)
>>  {
>>  	unsigned long pgt_prot, sgt_prot, r3_prot;
>>  	unsigned long pages4k, pages1m, pages2g;
>> @@ -79,7 +79,7 @@ static int vmem_add_mem(unsigned long start, unsigned long size)
>>  	pte_t *pt_dir;
>>  	int ret = -ENOMEM;
>>  
>> -	pgt_prot = pgprot_val(PAGE_KERNEL);
>> +	pgt_prot = pgprot_val(prot);
>>  	sgt_prot = pgprot_val(SEGMENT_KERNEL);
>>  	r3_prot = pgprot_val(REGION3_KERNEL);
> 
> So, if we map as huge/gigantic pages, the protection would be discarded?
> That looks wrong.
> 
> s390x does not support ZONE_DEVICE yet. Maybe simply bail out for s390x
> as you do for sh to make your life easier?

Yeah, ok, makes sense to me; I'll change it for v3.

Logan
