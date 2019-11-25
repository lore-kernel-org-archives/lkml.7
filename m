Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51314C432C3
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 13:16:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3013620863
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 13:16:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727577AbfKYNQS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 08:16:18 -0500
Received: from ns.iliad.fr ([212.27.33.1]:55136 "EHLO ns.iliad.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725823AbfKYNQS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 08:16:18 -0500
Received: from ns.iliad.fr (localhost [127.0.0.1])
        by ns.iliad.fr (Postfix) with ESMTP id 5DE9920600;
        Mon, 25 Nov 2019 14:16:17 +0100 (CET)
Received: from [192.168.108.51] (freebox.vlq16.iliad.fr [213.36.7.13])
        by ns.iliad.fr (Postfix) with ESMTP id 4651C2056B;
        Mon, 25 Nov 2019 14:16:17 +0100 (CET)
Subject: Re: [PATCH v1] clk: Add devm_clk_{prepare,enable,prepare_enable}
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <1d7a1b3b-e9bf-1d80-609d-a9c0c932b15a@free.fr>
 <34e32662-c909-9eb3-e561-3274ad0bf3cc@free.fr>
 <20191125125231.GO25745@shell.armlinux.org.uk>
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
Message-ID: <45730e3c-efc7-4433-4980-e6aefebdcbff@free.fr>
Date:   Mon, 25 Nov 2019 14:16:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191125125231.GO25745@shell.armlinux.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV using ClamSMTP ; ns.iliad.fr ; Mon Nov 25 14:16:17 2019 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/11/2019 13:52, Russell King - ARM Linux admin wrote:

> On Mon, Nov 25, 2019 at 01:46:51PM +0100, Marc Gonzalez wrote:
> 
>> On 15/07/2019 17:34, Marc Gonzalez wrote:
>>
>>> Provide devm variants for automatic resource release on device removal.
>>> probe() error-handling is simpler, and remove is no longer required.
>>>
>>> Signed-off-by: Marc Gonzalez <marc.w.gonzalez@free.fr>
>>> ---
>>>  Documentation/driver-model/devres.rst |  3 +++
>>>  drivers/clk/clk.c                     | 24 ++++++++++++++++++++++++
>>>  include/linux/clk.h                   |  8 ++++++++
>>>  3 files changed, 35 insertions(+)
>>>
>>> diff --git a/Documentation/driver-model/devres.rst b/Documentation/driver-model/devres.rst
>>> index 1b6ced8e4294..9357260576ef 100644
>>> --- a/Documentation/driver-model/devres.rst
>>> +++ b/Documentation/driver-model/devres.rst
>>> @@ -253,6 +253,9 @@ CLOCK
>>>    devm_clk_hw_register()
>>>    devm_of_clk_add_hw_provider()
>>>    devm_clk_hw_register_clkdev()
>>> +  devm_clk_prepare()
>>> +  devm_clk_enable()
>>> +  devm_clk_prepare_enable()
>>>  
>>>  DMA
>>>    dmaenginem_async_device_register()
>>> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
>>> index c0990703ce54..5e85548357c0 100644
>>> --- a/drivers/clk/clk.c
>>> +++ b/drivers/clk/clk.c
>>> @@ -914,6 +914,18 @@ int clk_prepare(struct clk *clk)
>>>  }
>>>  EXPORT_SYMBOL_GPL(clk_prepare);
>>>  
>>> +static void unprepare(void *clk)
>>> +{
>>> +	clk_unprepare(clk);
>>> +}
>>> +
>>> +int devm_clk_prepare(struct device *dev, struct clk *clk)
>>> +{
>>> +	int rc = clk_prepare(clk);
>>> +	return rc ? : devm_add_action_or_reset(dev, unprepare, clk);
>>> +}
>>> +EXPORT_SYMBOL_GPL(devm_clk_prepare);
>>> +
>>>  static void clk_core_disable(struct clk_core *core)
>>>  {
>>>  	lockdep_assert_held(&enable_lock);
>>> @@ -1136,6 +1148,18 @@ int clk_enable(struct clk *clk)
>>>  }
>>>  EXPORT_SYMBOL_GPL(clk_enable);
>>>  
>>> +static void disable(void *clk)
>>> +{
>>> +	clk_disable(clk);
>>> +}
>>> +
>>> +int devm_clk_enable(struct device *dev, struct clk *clk)
>>> +{
>>> +	int rc = clk_enable(clk);
>>> +	return rc ? : devm_add_action_or_reset(dev, disable, clk);
>>> +}
>>> +EXPORT_SYMBOL_GPL(devm_clk_enable);
>>> +
>>>  static int clk_core_prepare_enable(struct clk_core *core)
>>>  {
>>>  	int ret;
>>> diff --git a/include/linux/clk.h b/include/linux/clk.h
>>> index 3c096c7a51dc..d09b5207e3f1 100644
>>> --- a/include/linux/clk.h
>>> +++ b/include/linux/clk.h
>>> @@ -895,6 +895,14 @@ static inline void clk_restore_context(void) {}
>>>  
>>>  #endif
>>>  
>>> +int devm_clk_prepare(struct device *dev, struct clk *clk);
>>> +int devm_clk_enable(struct device *dev, struct clk *clk);
>>> +static inline int devm_clk_prepare_enable(struct device *dev, struct clk *clk)
>>> +{
>>> +	int rc = devm_clk_prepare(dev, clk);
>>> +	return rc ? : devm_clk_enable(dev, clk);
>>> +}
>>> +
>>>  /* clk_prepare_enable helps cases using clk_enable in non-atomic context. */
>>>  static inline int clk_prepare_enable(struct clk *clk)
>>>  {
>>
>> Thoughts? Comments?
> 
> These are part of the clk API rather than the CCF API, and belong in
> drivers/clk/clk-devres.c.

I'm totally confused.

Are you saying that a hypothetical devm_clk_prepare() function should not be
implemented in the same file as the "raw" clk_prepare() ?

Regards.
