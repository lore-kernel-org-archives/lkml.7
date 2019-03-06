Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBEEDC43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 14:56:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A565320661
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 14:56:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728020AbfCFO4z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 09:56:55 -0500
Received: from mx2.suse.de ([195.135.220.15]:47400 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726934AbfCFO4y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 09:56:54 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id AD4C8BA11;
        Wed,  6 Mar 2019 14:56:52 +0000 (UTC)
Subject: Re: [PATCH v2 01/15] ARM: actions: fix a leaked reference by
 addingmissing of_node_put
To:     wen.yang99@zte.com.cn
Cc:     linux@armlinux.org.uk, linus.walleij@linaro.org,
        julia.lawall@lip6.fr, tomi.valkeinen@ti.com,
        linux-kernel@vger.kernel.org, wang.yi59@zte.com.cn,
        manivannan.sadhasivam@linaro.org,
        linux-arm-kernel@lists.infradead.org
References: <201903061118011200191@zte.com.cn>
From:   =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Openpgp: preference=signencrypt
Organization: SUSE Linux GmbH
Message-ID: <d51c9855-1cff-5d1e-d9da-d7e908eb1949@suse.de>
Date:   Wed, 6 Mar 2019 15:56:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <201903061118011200191@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wen,

Am 06.03.19 um 04:18 schrieb wen.yang99@zte.com.cn:
> On Tue, Mar 05, 2019 at 07:41 PM +0800, RussellKing wrote:
>> Subject: Re: [PATCH v2 01/15] ARM: actions: fix a leaked reference by addingmissing of_node_put
>> On Tue, Mar 05, 2019 at 07:33:52PM +0800, Wen Yang wrote:
>>> The call to of_get_next_child returns a node pointer with refcount
>>> incremented thus it must be explicitly decremented after the last
>>> usage.
>>>
>>> Detected by coccinelle with the following warnings:
>>> ./arch/arm/mach-actions/platsmp.c:112:2-8: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 103, but without a corresponding object release within this function.
>>> ./arch/arm/mach-actions/platsmp.c:124:2-8: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 115, but without a corresponding object release within this function.
>>> ./arch/arm/mach-actions/platsmp.c:137:3-9: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 128, but without a corresponding object release within this function.
>>
>> I question this.  Your reasoning is that the node is no longer used
>> so the reference count needs to be put.
>>
>> However, in all these cases, data is read from the nodes properties
>> and the device remains in-use for the life of the kernel.  There is
>> a big difference here.
>>
>> With normal drivers, each device is bound to their associated device
>> node associated with the device.  When the device node goes away, then
>> the corresponding device goes away too, which causes the driver to be
>> unbound from the device.
>>
>> However, there is another class of "driver" which are the ones below,
>> where they are "permanent" devices.  These can never go away, even if
>> the device node refcount hits zero and the device node is freed - the
>> device is still present and in-use in the system.
> 
> Hi Russel, 
> Thank you very much for your comments.
> The problem we want to solve is "fix the reference leaks of device_node".
> We use the following coccinelle script to achieve the goal:
> @search exists@
> local idexpression struct device_node * node;
> expression e, e1;
> position p1,p2;
> type T,T1,T2;
> @@
> 
> node = @p1\(of_find_compatible_node\|of_find_node_by_name\|of_parse_phandle\|
>     of_find_node_by_type\|of_find_node_by_name\|of_find_all_nodes\|
>     of_get_cpu_node\|of_get_parent\|of_get_next_parent\|
>     of_get_next_child\|of_get_next_available_child\|of_get_next_cpu_node\|
>     of_get_compatible_child\|of_get_child_by_name\|of_find_node_opts_by_path\|
>     of_find_node_with_property\|of_find_matching_node_and_match\|of_find_node_by_phandle\|
>     of_parse_phandle\)(...)
> ... when != e = (T)node
> if (node == NULL || ...) { ... return ...; }
> ... when != of_node_put(node)
>     when != if (node) { ... of_node_put(node) ... }
>     when != e1 = (T1)node
> (
>   return (T2)node;
> | return@p2 ...;
> )
> 
> Using the script above, we found the issues for this file in the patch:
> arch/arm/mach-actions/platsmp.c
> 99 static void __init s500_smp_prepare_cpus(unsigned int max_cpus)
> 100 {
> 101 struct device_node *node;
> 102
> 103 node = of_find_compatible_node(NULL, NULL, "actions,s500-timer");
> ...
> 109 timer_base_addr = of_iomap(node, 0);
> 110 if (!timer_base_addr) {
> 111 pr_err("%s: could not map timer registers\n", __func__);
> 112 return;
> 113 }
> 114
> 115 node = of_find_compatible_node(NULL, NULL, "actions,s500-sps");
> ...
> 
> The comment for of_find_compatible_node writes:
> “Returns a node pointer with refcount incremented, use of_node_put() on it when done.”
> the node is a local variable obtained by of_find_compatible_node.
> But the code does not call on_node_put() to reduce the reference count, 
> the function returns directly, or directly reassigns it.
> This leads to a reference leak.

The unanswered question I raised a couple months ago when this topic
first came up was: does it actually matter? The function seemed
non-reentrant, and the base Device Tree stays around throughout the
lifetime of the kernel anyway. So it seems you're fixing warnings that
in practice don't make a difference - it won't hurt to put the nodes,
but I haven't seen a use case description of how the current code leads
to a leak - when the system powers down, the device_node reference count
shouldn't matter any more?

If it does lead to an actual problem, then the patch fixing it should
get a Fixes header so that it gets backported to all relevant upstream
and downstream kernels.

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)
