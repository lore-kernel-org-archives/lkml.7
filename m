Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DA58C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 05:24:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F79921479
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 05:24:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731257AbfDRFYl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 01:24:41 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:56715 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbfDRFYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 01:24:41 -0400
X-Originating-IP: 79.86.19.127
Received: from [192.168.0.11] (127.19.86.79.rev.sfr.net [79.86.19.127])
        (Authenticated sender: alex@ghiti.fr)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 42730240002;
        Thu, 18 Apr 2019 05:24:33 +0000 (UTC)
Subject: Re: [PATCH v3 03/11] arm64: Consider stack randomization for mmap
 base only when necessary
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
 <20190417052247.17809-4-alex@ghiti.fr>
 <CAGXu5jKo26zXw=jfKSzr_pnfx5Zux+fVbY7V9bJwEMApDcFi8w@mail.gmail.com>
From:   Alex Ghiti <alex@ghiti.fr>
Message-ID: <b2d80348-a3d4-ffcc-d174-0a7a244dae0b@ghiti.fr>
Date:   Thu, 18 Apr 2019 01:24:32 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAGXu5jKo26zXw=jfKSzr_pnfx5Zux+fVbY7V9bJwEMApDcFi8w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: sv-FI
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/18/19 12:37 AM, Kees Cook wrote:
> On Wed, Apr 17, 2019 at 12:26 AM Alexandre Ghiti <alex@ghiti.fr> wrote:
>> Do not offset mmap base address because of stack randomization if
>> current task does not want randomization.
> Maybe mention that this makes this logic match the existing x86 behavior too?


Ok I will add this in case of a v4.


>
>> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
> Acked-by: Kees Cook <keescook@chromium.org>

Thanks !


>
> -Kees
>
>> ---
>>   arch/arm64/mm/mmap.c | 6 +++++-
>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/mm/mmap.c b/arch/arm64/mm/mmap.c
>> index ed4f9915f2b8..ac89686c4af8 100644
>> --- a/arch/arm64/mm/mmap.c
>> +++ b/arch/arm64/mm/mmap.c
>> @@ -65,7 +65,11 @@ unsigned long arch_mmap_rnd(void)
>>   static unsigned long mmap_base(unsigned long rnd, struct rlimit *rlim_stack)
>>   {
>>          unsigned long gap = rlim_stack->rlim_cur;
>> -       unsigned long pad = (STACK_RND_MASK << PAGE_SHIFT) + stack_guard_gap;
>> +       unsigned long pad = stack_guard_gap;
>> +
>> +       /* Account for stack randomization if necessary */
>> +       if (current->flags & PF_RANDOMIZE)
>> +               pad += (STACK_RND_MASK << PAGE_SHIFT);
>>
>>          /* Values close to RLIM_INFINITY can overflow. */
>>          if (gap + pad > gap)
>> --
>> 2.20.1
>>
>
