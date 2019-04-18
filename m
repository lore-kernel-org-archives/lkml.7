Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7B06C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 05:23:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B74FE21479
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 05:23:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731177AbfDRFXr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 01:23:47 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:33281 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725886AbfDRFXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 01:23:47 -0400
X-Originating-IP: 79.86.19.127
Received: from [192.168.0.11] (127.19.86.79.rev.sfr.net [79.86.19.127])
        (Authenticated sender: alex@ghiti.fr)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 2D76460003;
        Thu, 18 Apr 2019 05:23:38 +0000 (UTC)
Subject: Re: [PATCH v3 02/11] arm64: Make use of is_compat_task instead of
 hardcoding this test
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
 <20190417052247.17809-3-alex@ghiti.fr>
 <CAGXu5jKVa2YgAkWH1e26kxd2j6C4WsJ38+Z3K1z7JRvr_jDX6Q@mail.gmail.com>
From:   Alex Ghiti <alex@ghiti.fr>
Message-ID: <1f63cf5a-6bbe-fa55-75c0-20322d8a7f36@ghiti.fr>
Date:   Thu, 18 Apr 2019 01:23:38 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAGXu5jKVa2YgAkWH1e26kxd2j6C4WsJ38+Z3K1z7JRvr_jDX6Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: sv-FI
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/18/19 12:32 AM, Kees Cook wrote:
> On Wed, Apr 17, 2019 at 12:25 AM Alexandre Ghiti <alex@ghiti.fr> wrote:
>> Each architecture has its own way to determine if a task is a compat task,
>> by using is_compat_task in arch_mmap_rnd, it allows more genericity and
>> then it prepares its moving to mm/.
>>
>> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
> Acked-by: Kees Cook <keescook@chromium.org>


Thanks !


> -Kees
>
>> ---
>>   arch/arm64/mm/mmap.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/mm/mmap.c b/arch/arm64/mm/mmap.c
>> index 842c8a5fcd53..ed4f9915f2b8 100644
>> --- a/arch/arm64/mm/mmap.c
>> +++ b/arch/arm64/mm/mmap.c
>> @@ -54,7 +54,7 @@ unsigned long arch_mmap_rnd(void)
>>          unsigned long rnd;
>>
>>   #ifdef CONFIG_COMPAT
>> -       if (test_thread_flag(TIF_32BIT))
>> +       if (is_compat_task())
>>                  rnd = get_random_long() & ((1UL << mmap_rnd_compat_bits) - 1);
>>          else
>>   #endif
>> --
>> 2.20.1
>>
>
