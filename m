Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05896C43215
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 09:25:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB0B520833
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 09:25:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727428AbfLBJZk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 04:25:40 -0500
Received: from ns.iliad.fr ([212.27.33.1]:58668 "EHLO ns.iliad.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726254AbfLBJZk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 04:25:40 -0500
Received: from ns.iliad.fr (localhost [127.0.0.1])
        by ns.iliad.fr (Postfix) with ESMTP id 907632041C;
        Mon,  2 Dec 2019 10:25:37 +0100 (CET)
Received: from [192.168.108.51] (freebox.vlq16.iliad.fr [213.36.7.13])
        by ns.iliad.fr (Postfix) with ESMTP id 7DB261FFCE;
        Mon,  2 Dec 2019 10:25:37 +0100 (CET)
Subject: Re: [PATCH v1] clk: Convert managed get functions to devm_add_action
 API
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-clk <linux-clk@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>
References: <3d8a58bf-0814-1ec1-038a-10a20b9646ad@free.fr>
 <20191128185630.GK82109@yoga> <20191202014237.GR248138@dtor-ws>
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
Message-ID: <f177ef95-ef7e-cab0-1322-6de28f18ecdb@free.fr>
Date:   Mon, 2 Dec 2019 10:25:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191202014237.GR248138@dtor-ws>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV using ClamSMTP ; ns.iliad.fr ; Mon Dec  2 10:25:37 2019 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/12/2019 02:42, Dmitry Torokhov wrote:

> On Thu, Nov 28, 2019 at 10:56:30AM -0800, Bjorn Andersson wrote:
> 
>> On Tue 26 Nov 08:13 PST 2019, Marc Gonzalez wrote:
>>
>>> Date: Tue, 26 Nov 2019 13:56:53 +0100
>>>
>>> Using devm_add_action_or_reset() produces simpler code and smaller
>>> object size:
>>>
>>> 1 file changed, 16 insertions(+), 46 deletions(-)
>>>
>>>     text	   data	    bss	    dec	    hex	filename
>>> -   1797	     80	      0	   1877	    755	drivers/clk/clk-devres.o
>>> +   1499	     56	      0	   1555	    613	drivers/clk/clk-devres.o
>>>
>>> Signed-off-by: Marc Gonzalez <marc.w.gonzalez@free.fr>
>>
>> Looks neat
>>
>> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> 
> This however increases the runtime costs as each custom action cost us
> an extra pointer. Given that in a system we likely have many clocks
> managed by devres, I am not sure that this code savings is actually
> gives us overall win. It might still, I just want to understand how we
> are allocating/packing devres structures.

I'm not 100% sure what you are saying.

Are you arguing that the proposed patch increases the run-time cost of
devm_clk_put() so much that the listed improvements (simpler source code,
smaller object size) are not worth it?

AFAIU, the release action is only called
- explicitly, when devm_clk_put() is called
- implicitly, when the device is removed

How often are clocks removed?

In hot code-path (called hundreds of times per second) it makes sense to
write more complex code, to shave a few cycles every iteration. But in
cold code-path, I think it's better to write short/simple code.

Regards.
