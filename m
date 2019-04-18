Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B289C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 06:04:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D822204FD
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 06:04:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387418AbfDRGER (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 02:04:17 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:44073 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbfDRGEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 02:04:16 -0400
X-Originating-IP: 79.86.19.127
Received: from [192.168.0.11] (127.19.86.79.rev.sfr.net [79.86.19.127])
        (Authenticated sender: alex@ghiti.fr)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id DC0F4240004;
        Thu, 18 Apr 2019 06:04:08 +0000 (UTC)
Subject: Re: [PATCH v3 06/11] arm: Use STACK_TOP when computing mmap base
 address
To:     Kees Cook <keescook@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Luis Chamberlain <mcgrof@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-mips@vger.kernel.org, linux-riscv@lists.infradead.org,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
References: <20190417052247.17809-1-alex@ghiti.fr>
 <20190417052247.17809-7-alex@ghiti.fr>
 <CAGXu5jLFtaiRqvd_Lw2B688bzUyti2O8o_iZVmQhb7rmnEKzBQ@mail.gmail.com>
From:   Alex Ghiti <alex@ghiti.fr>
Message-ID: <9fdc1de9-8552-da1b-7d05-0596969ddad2@ghiti.fr>
Date:   Thu, 18 Apr 2019 02:04:08 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAGXu5jLFtaiRqvd_Lw2B688bzUyti2O8o_iZVmQhb7rmnEKzBQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: sv-FI
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/18/19 1:27 AM, Kees Cook wrote:
> On Wed, Apr 17, 2019 at 12:29 AM Alexandre Ghiti <alex@ghiti.fr> wrote:
>> mmap base address must be computed wrt stack top address, using TASK_SIZE
>> is wrong since STACK_TOP and TASK_SIZE are not equivalent.
>>
>> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
>> ---
>>   arch/arm/mm/mmap.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm/mm/mmap.c b/arch/arm/mm/mmap.c
>> index bff3d00bda5b..0b94b674aa91 100644
>> --- a/arch/arm/mm/mmap.c
>> +++ b/arch/arm/mm/mmap.c
>> @@ -19,7 +19,7 @@
>>
>>   /* gap between mmap and stack */
>>   #define MIN_GAP                (128*1024*1024UL)
>> -#define MAX_GAP                ((TASK_SIZE)/6*5)
>> +#define MAX_GAP                ((STACK_TOP)/6*5)
> Parens around STACK_TOP aren't needed, but you'll be removing it
> entirely, so I can't complain. ;)
>
>>   #define STACK_RND_MASK (0x7ff >> (PAGE_SHIFT - 12))
>>
>>   static int mmap_is_legacy(struct rlimit *rlim_stack)
>> @@ -51,7 +51,7 @@ static unsigned long mmap_base(unsigned long rnd, struct rlimit *rlim_stack)
>>          else if (gap > MAX_GAP)
>>                  gap = MAX_GAP;
>>
>> -       return PAGE_ALIGN(TASK_SIZE - gap - rnd);
>> +       return PAGE_ALIGN(STACK_TOP - gap - rnd);
>>   }
>>
>>   /*
>> --
>> 2.20.1
>>
> Acked-by: Kees Cook <keescook@chromium.org>


Thanks !

>
