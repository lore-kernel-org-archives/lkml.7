Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 226AEC2D0C9
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 18:15:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00792214AF
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 18:15:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730391AbfLLSPV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 13:15:21 -0500
Received: from foss.arm.com ([217.140.110.172]:56042 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730246AbfLLSPU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 13:15:20 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8A1C7328;
        Thu, 12 Dec 2019 10:15:19 -0800 (PST)
Received: from [10.1.196.37] (e121345-lin.cambridge.arm.com [10.1.196.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E85583F6CF;
        Thu, 12 Dec 2019 10:15:17 -0800 (PST)
Subject: Re: [PATCH v1] clk: Convert managed get functions to devm_add_action
 API
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        x86 <x86@kernel.org>
References: <3d8a58bf-0814-1ec1-038a-10a20b9646ad@free.fr>
 <20191128185630.GK82109@yoga> <20191202014237.GR248138@dtor-ws>
 <f177ef95-ef7e-cab0-1322-6de28f18ecdb@free.fr>
 <c0ccca86-b7b1-b587-60c1-4794376fa789@arm.com>
 <ba630966-5479-c831-d0e2-bc2eb12bc317@free.fr>
 <20191211222829.GV50317@dtor-ws>
 <70528f77-ca10-01cd-153b-23486ce87d45@free.fr>
 <cf5b3dee-061e-a476-7219-aa08c2977488@arm.com>
 <6a647c20-c2fa-f14c-256d-6516d0ad03b0@free.fr>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <6ce49a67-8065-277b-5f80-ed47011e50d6@arm.com>
Date:   Thu, 12 Dec 2019 18:15:16 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <6a647c20-c2fa-f14c-256d-6516d0ad03b0@free.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/12/2019 4:59 pm, Marc Gonzalez wrote:
> On 12/12/2019 15:47, Robin Murphy wrote:
> 
>> On 12/12/2019 1:53 pm, Marc Gonzalez wrote:
>>
>>> On 11/12/2019 23:28, Dmitry Torokhov wrote:
>>>
>>>> On Wed, Dec 11, 2019 at 05:17:28PM +0100, Marc Gonzalez wrote:
>>>>
>>>>> What is the rationale for the devm_add_action API?
>>>>
>>>> For one-off and maybe complex unwind actions in drivers that wish to use
>>>> devm API (as mixing devm and manual release is verboten). Also is often
>>>> used when some core subsystem does not provide enough devm APIs.
>>>
>>> Thanks for the insight, Dmitry. Thanks to Robin too.
>>>
>>> This is what I understand so far:
>>>
>>> devm_add_action() is nice because it hides/factorizes the complexity
>>> of the devres API, but it incurs a small storage overhead of one
>>> pointer per call, which makes it unfit for frequently used actions,
>>> such as clk_get.
>>>
>>> Is that correct?
>>>
>>> My question is: why not design the API without the small overhead?
>>
>> Probably because on most architectures, ARCH_KMALLOC_MINALIGN is at
>> least as big as two pointers anyway, so this "overhead" should mostly be
>> free in practice. Plus the devres API is almost entirely about being
>> able to write simple robust code, rather than absolute efficiency - I
>> mean, struct devres itself is already 5 pointers large at the absolute
>> minimum ;)
> 
> (3 pointers: 1 list_head + 1 function pointer)

Ah yes, I failed to mentally preprocess the debug config :)

> I'm confused. The first patch was criticized for potentially adding
> an extra pointer for every devm_clk_get (e.g. 800 bytes on a 64-bit
> platform with 100 clocks).

I'm not sure it was a criticism so much as an observation of an aspect 
that deserved consideration (certainly it was on my part, and I read 
Dmitry's "It might still, ..." as implying the same). I'd say by this 
point it has been thoroughly considered, and personally I'm now happy 
with the conclusion that the kind of embedded platforms that will have 
many dozens of clocks are also the kind that will tend to have enough 
padding to make it moot, and thus the code simplification probably is 
worthwhile overall.

Robin.

> Let's see. On arm64, ARCH_KMALLOC_MINALIGN is 128.
> 
> So basically, a struct devres looks like this on arm64:
> 
> 	list_head.next
> 	list_head.prev
> 	dr_release_t
> 		.
> 		.
> 		.
> 	104 bytes of padding
> 		.
> 		.
> 		.
> 	data (flexible array)
> 		.
> 		.
> 		.
> 	padding up to 256 bytes
> 
> 
> Basically, on arm64, every struct devres occupies 256 bytes, most of it
> (typically 104 + 112 = 216) wasted as padding.
> 
> Hmmm, given how many devm stuff goes on in a modern platform, there
> might be large savings to be had...
> 
> Assuming 10,000 calls to devres_alloc_node(), we would be wasting ~2 MB
> of RAM. Not sure it's worth trying to save that?
> 
> $ git grep '#define ARCH_DMA_MINALIGN'
> arch/arc/include/asm/cache.h:#define ARCH_DMA_MINALIGN  SMP_CACHE_BYTES
> arch/arm/include/asm/cache.h:#define ARCH_DMA_MINALIGN  L1_CACHE_BYTES
> arch/arm64/include/asm/cache.h:#define ARCH_DMA_MINALIGN        (128)
> arch/c6x/include/asm/cache.h:#define ARCH_DMA_MINALIGN  L1_CACHE_BYTES
> arch/csky/include/asm/cache.h:#define ARCH_DMA_MINALIGN L1_CACHE_BYTES
> arch/hexagon/include/asm/cache.h:#define ARCH_DMA_MINALIGN      L1_CACHE_BYTES
> arch/m68k/include/asm/cache.h:#define ARCH_DMA_MINALIGN L1_CACHE_BYTES
> arch/microblaze/include/asm/page.h:#define ARCH_DMA_MINALIGN    L1_CACHE_BYTES
> arch/mips/include/asm/mach-generic/kmalloc.h:#define ARCH_DMA_MINALIGN  128
> arch/mips/include/asm/mach-ip32/kmalloc.h:#define ARCH_DMA_MINALIGN     32
> arch/mips/include/asm/mach-ip32/kmalloc.h:#define ARCH_DMA_MINALIGN     128
> arch/mips/include/asm/mach-tx49xx/kmalloc.h:#define ARCH_DMA_MINALIGN L1_CACHE_BYTES
> arch/nds32/include/asm/cache.h:#define ARCH_DMA_MINALIGN   L1_CACHE_BYTES
> arch/nios2/include/asm/cache.h:#define ARCH_DMA_MINALIGN        L1_CACHE_BYTES
> arch/parisc/include/asm/cache.h:#define ARCH_DMA_MINALIGN       L1_CACHE_BYTES
> arch/powerpc/include/asm/page_32.h:#define ARCH_DMA_MINALIGN    L1_CACHE_BYTES
> arch/sh/include/asm/page.h:#define ARCH_DMA_MINALIGN    L1_CACHE_BYTES
> arch/unicore32/include/asm/cache.h:#define ARCH_DMA_MINALIGN    L1_CACHE_BYTES
> arch/xtensa/include/asm/cache.h:#define ARCH_DMA_MINALIGN       L1_CACHE_BYTES
> 
> Hmmm, how does arch/x86 do it?
> 
> Regards.
> 
