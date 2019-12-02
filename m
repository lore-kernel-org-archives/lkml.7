Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79505C43215
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 13:51:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59719206F0
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 13:51:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727572AbfLBNvM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 08:51:12 -0500
Received: from foss.arm.com ([217.140.110.172]:54724 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727451AbfLBNvL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 08:51:11 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CED6130E;
        Mon,  2 Dec 2019 05:51:10 -0800 (PST)
Received: from [10.1.196.37] (e121345-lin.cambridge.arm.com [10.1.196.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 598313F68E;
        Mon,  2 Dec 2019 05:51:09 -0800 (PST)
Subject: Re: [PATCH v1] clk: Convert managed get functions to devm_add_action
 API
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
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
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <c0ccca86-b7b1-b587-60c1-4794376fa789@arm.com>
Date:   Mon, 2 Dec 2019 13:51:08 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <f177ef95-ef7e-cab0-1322-6de28f18ecdb@free.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/12/2019 9:25 am, Marc Gonzalez wrote:
> On 02/12/2019 02:42, Dmitry Torokhov wrote:
> 
>> On Thu, Nov 28, 2019 at 10:56:30AM -0800, Bjorn Andersson wrote:
>>
>>> On Tue 26 Nov 08:13 PST 2019, Marc Gonzalez wrote:
>>>
>>>> Date: Tue, 26 Nov 2019 13:56:53 +0100
>>>>
>>>> Using devm_add_action_or_reset() produces simpler code and smaller
>>>> object size:
>>>>
>>>> 1 file changed, 16 insertions(+), 46 deletions(-)
>>>>
>>>>      text	   data	    bss	    dec	    hex	filename
>>>> -   1797	     80	      0	   1877	    755	drivers/clk/clk-devres.o
>>>> +   1499	     56	      0	   1555	    613	drivers/clk/clk-devres.o
>>>>
>>>> Signed-off-by: Marc Gonzalez <marc.w.gonzalez@free.fr>
>>>
>>> Looks neat
>>>
>>> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
>>
>> This however increases the runtime costs as each custom action cost us
>> an extra pointer. Given that in a system we likely have many clocks
>> managed by devres, I am not sure that this code savings is actually
>> gives us overall win. It might still, I just want to understand how we
>> are allocating/packing devres structures.
> 
> I'm not 100% sure what you are saying.

You reduce the text size by a constant amount, at the cost of allocating 
twice as much runtime data per clock (struct action_devres  vs. void*). 
Assuming 64-bit pointers, that means that in principle your ~320-byte 
saving would be cancelled out at ~40 managed clocks. However, that's 
also assuming that the minimum allocation granularity is no larger than 
a single pointer, which generally isn't true, so in reality it depends 
on whether the difference in data pushes the total struct devres 
allocation over the next ARCH_KMALLOC_MINALIGN boundary - if it doesn't, 
the difference comes entirely for free; if it does, the memory cost 
tradeoff gets even worse.

Robin.

> Are you arguing that the proposed patch increases the run-time cost of
> devm_clk_put() so much that the listed improvements (simpler source code,
> smaller object size) are not worth it?
> 
> AFAIU, the release action is only called
> - explicitly, when devm_clk_put() is called
> - implicitly, when the device is removed
> 
> How often are clocks removed?
> 
> In hot code-path (called hundreds of times per second) it makes sense to
> write more complex code, to shave a few cycles every iteration. But in
> cold code-path, I think it's better to write short/simple code.
> 
> Regards.
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
