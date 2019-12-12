Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9660C00454
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 21:07:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91E8B214D8
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 21:07:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731010AbfLLVH4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 16:07:56 -0500
Received: from foss.arm.com ([217.140.110.172]:60880 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730742AbfLLVH4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 16:07:56 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5E04E328;
        Thu, 12 Dec 2019 13:07:55 -0800 (PST)
Received: from [192.168.1.123] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4585F3F718;
        Thu, 12 Dec 2019 13:07:53 -0800 (PST)
Subject: Re: [PATCH v1] clk: Convert managed get functions to devm_add_action
 API
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
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
References: <20191128185630.GK82109@yoga> <20191202014237.GR248138@dtor-ws>
 <f177ef95-ef7e-cab0-1322-6de28f18ecdb@free.fr>
 <c0ccca86-b7b1-b587-60c1-4794376fa789@arm.com>
 <ba630966-5479-c831-d0e2-bc2eb12bc317@free.fr>
 <20191211222829.GV50317@dtor-ws>
 <70528f77-ca10-01cd-153b-23486ce87d45@free.fr>
 <cf5b3dee-061e-a476-7219-aa08c2977488@arm.com>
 <6a647c20-c2fa-f14c-256d-6516d0ad03b0@free.fr>
 <6ce49a67-8065-277b-5f80-ed47011e50d6@arm.com>
 <20191212191002.GA101194@dtor-ws>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <3ce51e0b-f4eb-707d-c55d-0eaf4ac72c5a@arm.com>
Date:   Thu, 12 Dec 2019 21:08:04 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20191212191002.GA101194@dtor-ws>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-12-12 7:10 pm, Dmitry Torokhov wrote:
> On Thu, Dec 12, 2019 at 06:15:16PM +0000, Robin Murphy wrote:
>> On 12/12/2019 4:59 pm, Marc Gonzalez wrote:
>>> On 12/12/2019 15:47, Robin Murphy wrote:
>>>
>>>> On 12/12/2019 1:53 pm, Marc Gonzalez wrote:
>>>>
>>>>> On 11/12/2019 23:28, Dmitry Torokhov wrote:
>>>>>
>>>>>> On Wed, Dec 11, 2019 at 05:17:28PM +0100, Marc Gonzalez wrote:
>>>>>>
>>>>>>> What is the rationale for the devm_add_action API?
>>>>>>
>>>>>> For one-off and maybe complex unwind actions in drivers that wish to use
>>>>>> devm API (as mixing devm and manual release is verboten). Also is often
>>>>>> used when some core subsystem does not provide enough devm APIs.
>>>>>
>>>>> Thanks for the insight, Dmitry. Thanks to Robin too.
>>>>>
>>>>> This is what I understand so far:
>>>>>
>>>>> devm_add_action() is nice because it hides/factorizes the complexity
>>>>> of the devres API, but it incurs a small storage overhead of one
>>>>> pointer per call, which makes it unfit for frequently used actions,
>>>>> such as clk_get.
>>>>>
>>>>> Is that correct?
>>>>>
>>>>> My question is: why not design the API without the small overhead?
>>>>
>>>> Probably because on most architectures, ARCH_KMALLOC_MINALIGN is at
>>>> least as big as two pointers anyway, so this "overhead" should mostly be
>>>> free in practice. Plus the devres API is almost entirely about being
>>>> able to write simple robust code, rather than absolute efficiency - I
>>>> mean, struct devres itself is already 5 pointers large at the absolute
>>>> minimum ;)
>>>
>>> (3 pointers: 1 list_head + 1 function pointer)
>>
>> Ah yes, I failed to mentally preprocess the debug config :)
>>
>>> I'm confused. The first patch was criticized for potentially adding
>>> an extra pointer for every devm_clk_get (e.g. 800 bytes on a 64-bit
>>> platform with 100 clocks).
>>
>> I'm not sure it was a criticism so much as an observation of an aspect that
>> deserved consideration (certainly it was on my part, and I read Dmitry's "It
>> might still, ..." as implying the same). I'd say by this point it has been
>> thoroughly considered, and personally I'm now happy with the conclusion that
>> the kind of embedded platforms that will have many dozens of clocks are also
>> the kind that will tend to have enough padding to make it moot, and thus the
>> code simplification probably is worthwhile overall.
> 
> I wonder if we could actually avoid allocating the data with
> ARCH_KMALLOC_MINALIGN in all the cases. It is definitely needed for the
> devm_k*alloc() group of functions as they are direct replacement for
> k*alloc() APIs that give users aligned memory, but for other data
> structures (clocks, regulators, etc, etc) it is not required.

That's a very good point - perhaps something like this (only done properly)?

Robin.

diff --git a/drivers/base/devres.c b/drivers/base/devres.c
index 0bbb328bd17f..2382f963abbe 100644
--- a/drivers/base/devres.c
+++ b/drivers/base/devres.c
@@ -26,14 +26,7 @@ struct devres_node {

  struct devres {
         struct devres_node              node;
-       /*
-        * Some archs want to perform DMA into kmalloc caches
-        * and need a guaranteed alignment larger than
-        * the alignment of a 64-bit integer.
-        * Thus we use ARCH_KMALLOC_MINALIGN here and get exactly the same
-        * buffer alignment as if it was allocated by plain kmalloc().
-        */
-       u8 __aligned(ARCH_KMALLOC_MINALIGN) data[];
+       u8                              data[];
  };

  struct devres_group {
@@ -810,6 +803,17 @@ static int devm_kmalloc_match(struct device *dev, 
void *res, void *data)
  void * devm_kmalloc(struct device *dev, size_t size, gfp_t gfp)
  {
         struct devres *dr;
+       size_t align;
+
+       /*
+        * Some archs want to perform DMA into kmalloc caches
+        * and need a guaranteed alignment larger than
+        * the alignment of a 64-bit integer.
+        * Thus we use ARCH_KMALLOC_MINALIGN here and get exactly the same
+        * buffer alignment as if it was allocated by plain kmalloc().
+        */
+       align = (ARCH_KMALLOC_MINALIGN - sizeof(*dr)) % 
ARCH_KMALLOC_MINALIGN;
+       size += align;

         /* use raw alloc_dr for kmalloc caller tracing */
         dr = alloc_dr(devm_kmalloc_release, size, gfp, dev_to_node(dev));
@@ -822,7 +826,7 @@ void * devm_kmalloc(struct device *dev, size_t size, 
gfp_t gfp)
          */
         set_node_dbginfo(&dr->node, "devm_kzalloc_release", size);
         devres_add(dev, dr->data);
-       return dr->data;
+       return dr->data + align;
  }
  EXPORT_SYMBOL_GPL(devm_kmalloc);
