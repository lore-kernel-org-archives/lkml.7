Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57D20C282DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:01:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F5B320643
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:01:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728841AbfDSTBL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 15:01:11 -0400
Received: from mslow2.mail.gandi.net ([217.70.178.242]:38222 "EHLO
        mslow2.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727676AbfDSTBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 15:01:10 -0400
X-Greylist: delayed 825 seconds by postgrey-1.27 at vger.kernel.org; Fri, 19 Apr 2019 15:01:08 EDT
Received: from relay3-d.mail.gandi.net (unknown [217.70.183.195])
        by mslow2.mail.gandi.net (Postfix) with ESMTP id 6DE5E3A913B;
        Fri, 19 Apr 2019 07:21:23 +0000 (UTC)
X-Originating-IP: 81.250.144.103
Received: from [10.30.1.20] (lneuilly-657-1-5-103.w81-250.abo.wanadoo.fr [81.250.144.103])
        (Authenticated sender: alex@ghiti.fr)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 78D2F6000E;
        Fri, 19 Apr 2019 07:21:16 +0000 (UTC)
From:   Alex Ghiti <alex@ghiti.fr>
Subject: Re: [PATCH v3 08/11] mips: Properly account for stack randomization
 and stack guard gap
To:     Paul Burton <paul.burton@mips.com>
Cc:     Albert Ou <aou@eecs.berkeley.edu>,
        Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Will Deacon <will.deacon@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Ralf Baechle <ralf@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        James Hogan <jhogan@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <20190417052247.17809-1-alex@ghiti.fr>
 <20190417052247.17809-9-alex@ghiti.fr>
 <20190418212701.dpymnwuki3g7rox2@pburton-laptop>
Message-ID: <b971499a-ae49-bea5-d3ac-dc779d4817ef@ghiti.fr>
Date:   Fri, 19 Apr 2019 09:20:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20190418212701.dpymnwuki3g7rox2@pburton-laptop>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/18/19 5:27 PM, Paul Burton wrote:
> Hi Alexandre,
>
> On Wed, Apr 17, 2019 at 01:22:44AM -0400, Alexandre Ghiti wrote:
>> This commit takes care of stack randomization and stack guard gap when
>> computing mmap base address and checks if the task asked for randomization.
>> This fixes the problem uncovered and not fixed for mips here:
>> https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1429066.html
>>
>> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
> For patches 8-10:
>
>      Acked-by: Paul Burton <paul.burton@mips.com>
>
> Thanks for improving this,


Thank you for your time,


Alex


>      Paul
>
>> ---
>>   arch/mips/mm/mmap.c | 14 ++++++++++++--
>>   1 file changed, 12 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/mips/mm/mmap.c b/arch/mips/mm/mmap.c
>> index 2f616ebeb7e0..3ff82c6f7e24 100644
>> --- a/arch/mips/mm/mmap.c
>> +++ b/arch/mips/mm/mmap.c
>> @@ -21,8 +21,9 @@ unsigned long shm_align_mask = PAGE_SIZE - 1;	/* Sane caches */
>>   EXPORT_SYMBOL(shm_align_mask);
>>   
>>   /* gap between mmap and stack */
>> -#define MIN_GAP (128*1024*1024UL)
>> -#define MAX_GAP ((TASK_SIZE)/6*5)
>> +#define MIN_GAP		(128*1024*1024UL)
>> +#define MAX_GAP		((TASK_SIZE)/6*5)
>> +#define STACK_RND_MASK	(0x7ff >> (PAGE_SHIFT - 12))
>>   
>>   static int mmap_is_legacy(struct rlimit *rlim_stack)
>>   {
>> @@ -38,6 +39,15 @@ static int mmap_is_legacy(struct rlimit *rlim_stack)
>>   static unsigned long mmap_base(unsigned long rnd, struct rlimit *rlim_stack)
>>   {
>>   	unsigned long gap = rlim_stack->rlim_cur;
>> +	unsigned long pad = stack_guard_gap;
>> +
>> +	/* Account for stack randomization if necessary */
>> +	if (current->flags & PF_RANDOMIZE)
>> +		pad += (STACK_RND_MASK << PAGE_SHIFT);
>> +
>> +	/* Values close to RLIM_INFINITY can overflow. */
>> +	if (gap + pad > gap)
>> +		gap += pad;
>>   
>>   	if (gap < MIN_GAP)
>>   		gap = MIN_GAP;
>> -- 
>> 2.20.1
>>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
