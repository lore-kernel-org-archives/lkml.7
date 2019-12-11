Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37259C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 16:17:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15F21205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 16:17:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730355AbfLKQRh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 11:17:37 -0500
Received: from ns.iliad.fr ([212.27.33.1]:46870 "EHLO ns.iliad.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729742AbfLKQRb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 11:17:31 -0500
Received: from ns.iliad.fr (localhost [127.0.0.1])
        by ns.iliad.fr (Postfix) with ESMTP id 6989D20348;
        Wed, 11 Dec 2019 17:17:28 +0100 (CET)
Received: from [192.168.108.51] (freebox.vlq16.iliad.fr [213.36.7.13])
        by ns.iliad.fr (Postfix) with ESMTP id 3EDE020159;
        Wed, 11 Dec 2019 17:17:28 +0100 (CET)
Subject: Re: [PATCH v1] clk: Convert managed get functions to devm_add_action
 API
To:     Robin Murphy <robin.murphy@arm.com>,
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
        Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <3d8a58bf-0814-1ec1-038a-10a20b9646ad@free.fr>
 <20191128185630.GK82109@yoga> <20191202014237.GR248138@dtor-ws>
 <f177ef95-ef7e-cab0-1322-6de28f18ecdb@free.fr>
 <c0ccca86-b7b1-b587-60c1-4794376fa789@arm.com>
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
Message-ID: <ba630966-5479-c831-d0e2-bc2eb12bc317@free.fr>
Date:   Wed, 11 Dec 2019 17:17:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <c0ccca86-b7b1-b587-60c1-4794376fa789@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV using ClamSMTP ; ns.iliad.fr ; Wed Dec 11 17:17:28 2019 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/12/2019 14:51, Robin Murphy wrote:

> On 02/12/2019 9:25 am, Marc Gonzalez wrote:
>
>> On 02/12/2019 02:42, Dmitry Torokhov wrote:
>>
>>> On Thu, Nov 28, 2019 at 10:56:30AM -0800, Bjorn Andersson wrote:
>>>
>>>> On Tue 26 Nov 08:13 PST 2019, Marc Gonzalez wrote:
>>>>
>>>>> Date: Tue, 26 Nov 2019 13:56:53 +0100
>>>>>
>>>>> Using devm_add_action_or_reset() produces simpler code and smaller
>>>>> object size:
>>>>>
>>>>> 1 file changed, 16 insertions(+), 46 deletions(-)
>>>>>
>>>>>      text	   data	    bss	    dec	    hex	filename
>>>>> -   1797	     80	      0	   1877	    755	drivers/clk/clk-devres.o
>>>>> +   1499	     56	      0	   1555	    613	drivers/clk/clk-devres.o
>>>>>
>>>>> Signed-off-by: Marc Gonzalez <marc.w.gonzalez@free.fr>
>>>>
>>>> Looks neat
>>>>
>>>> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
>>>
>>> This however increases the runtime costs as each custom action cost us
>>> an extra pointer. Given that in a system we likely have many clocks
>>> managed by devres, I am not sure that this code savings is actually
>>> gives us overall win. It might still, I just want to understand how we
>>> are allocating/packing devres structures.
>>
>> I'm not 100% sure what you are saying.
> 
> You reduce the text size by a constant amount, at the cost of allocating 
> twice as much runtime data per clock (struct action_devres  vs. void*). 
> Assuming 64-bit pointers, that means that in principle your ~320-byte 
> saving would be cancelled out at ~40 managed clocks. However, that's 
> also assuming that the minimum allocation granularity is no larger than 
> a single pointer, which generally isn't true, so in reality it depends 
> on whether the difference in data pushes the total struct devres 
> allocation over the next ARCH_KMALLOC_MINALIGN boundary - if it doesn't, 
> the difference comes entirely for free; if it does, the memory cost 
> tradeoff gets even worse.

Aaah... memory overhead. Thanks for pointing it out.

BEFORE

devm_clk_get()
  -> devres_alloc(devm_clk_release, sizeof(*ptr), GFP_KERNEL);
     allocates space for a struct devres + a pointer

struct devres {
	struct devres_node		node;
	/*
	 * Some archs want to perform DMA into kmalloc caches
	 * and need a guaranteed alignment larger than
	 * the alignment of a 64-bit integer.
	 * Thus we use ARCH_KMALLOC_MINALIGN here and get exactly the same
	 * buffer alignment as if it was allocated by plain kmalloc().
	 */
	u8 __aligned(ARCH_KMALLOC_MINALIGN) data[];
};

Not sure what it means for a flexible array member to be X-aligned...

(Since the field's address depends on the start address, which is only
determined at run-time...)

For example, on arm64, ARCH_KMALLOC_MINALIGN appears to be 128 (sometimes).

/*
 * Memory returned by kmalloc() may be used for DMA, so we must make
 * sure that all such allocations are cache aligned. Otherwise,
 * unrelated code may cause parts of the buffer to be read into the
 * cache before the transfer is done, causing old data to be seen by
 * the CPU.
 */
#define ARCH_DMA_MINALIGN	(128)


Unless the strict alignment is also imposed on kmalloc?

So basically, a struct devres starts on a multiple-of-128 address,
first the devres_node member, then padding to the next 128, then the
data member?


/*
 * Some archs want to perform DMA into kmalloc caches and need a guaranteed
 * alignment larger than the alignment of a 64-bit integer.
 * Setting ARCH_KMALLOC_MINALIGN in arch headers allows that.
 */
#if defined(ARCH_DMA_MINALIGN) && ARCH_DMA_MINALIGN > 8
#define ARCH_KMALLOC_MINALIGN ARCH_DMA_MINALIGN
#define KMALLOC_MIN_SIZE ARCH_DMA_MINALIGN
#define KMALLOC_SHIFT_LOW ilog2(ARCH_DMA_MINALIGN)
#else
#define ARCH_KMALLOC_MINALIGN __alignof__(unsigned long long)
#endif


A devres_node boils down to 2 object pointers + 1 function pointer.

Are there architectures supported by Linux where a function pointer
is not the same size as an object pointer? (ia64 maybe?)



OK, I will give this patch some more thought.

But I need to ask: what is the rationale for the devm_add_action API?

Regards.
