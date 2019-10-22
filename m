Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 109CECA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 18:16:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2F792053B
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 18:16:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732318AbfJVSQV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 14:16:21 -0400
Received: from [217.140.110.172] ([217.140.110.172]:59336 "EHLO foss.arm.com"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1729425AbfJVSQV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 14:16:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 54DCC1650;
        Tue, 22 Oct 2019 11:15:58 -0700 (PDT)
Received: from [10.1.197.57] (e110467-lin.cambridge.arm.com [10.1.197.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 35F4B3F718;
        Tue, 22 Oct 2019 11:15:57 -0700 (PDT)
Subject: Re: [PATCH 2/2] mfd: mfd-core: Honour Device Tree's request to
 disable a child-device
To:     Lee Jones <lee.jones@linaro.org>
Cc:     broonie@kernel.org, linus.walleij@linaro.org,
        daniel.thompson@linaro.org, arnd@arndb.de, baohua@kernel.org,
        stephan@gerhold.net, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20191018122647.3849-1-lee.jones@linaro.org>
 <20191018122647.3849-3-lee.jones@linaro.org>
 <b7c59d6e-2ad8-30a1-013a-53c116f7b6ba@arm.com> <20191019072809.GX4365@dell>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <8d458795-1081-313e-f5f6-7ca8572e7457@arm.com>
Date:   Tue, 22 Oct 2019 19:15:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20191019072809.GX4365@dell>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/10/2019 08:28, Lee Jones wrote:
> Good morning Robin,
> 
> It's been a while.  I hope that you are well.
> 
> Thanks for taking an interest.
> 
> On Fri, 18 Oct 2019, Robin Murphy wrote:
>> On 18/10/2019 13:26, Lee Jones wrote:
>>> Until now, MFD has assumed all child devices passed to it (via
>>> mfd_cells) are to be registered.  It does not take into account
>>> requests from Device Tree and the like to disable child devices
>>> on a per-platform basis.
>>>
>>> Well now it does.
>>>
>>> Reported-by: Barry Song <Baohua.Song@csr.com>
>>> Reported-by: Stephan Gerhold <stephan@gerhold.net>
>>> Signed-off-by: Lee Jones <lee.jones@linaro.org>
>>> ---
>>>    drivers/mfd/mfd-core.c | 5 +++++
>>>    1 file changed, 5 insertions(+)
>>>
>>> diff --git a/drivers/mfd/mfd-core.c b/drivers/mfd/mfd-core.c
>>> index eafdadd58e8b..24c139633524 100644
>>> --- a/drivers/mfd/mfd-core.c
>>> +++ b/drivers/mfd/mfd-core.c
>>> @@ -182,6 +182,11 @@ static int mfd_add_device(struct device *parent, int id,
>>>    	if (parent->of_node && cell->of_compatible) {
>>>    		for_each_child_of_node(parent->of_node, np) {
>>>    			if (of_device_is_compatible(np, cell->of_compatible)) {
>>> +				if (!of_device_is_available(np)) {
>>> +					/* Ignore disabled devices error free */
>>> +					ret = 0;
>>> +					goto fail_alias;
>>> +				}
>>
>> Is it possible for a device to have multiple children of the same type? If
>> so, it seems like this might not work as desired if, say, the first child
>> was disabled but subsequent ones weren't.
>>
>> It might make sense to use for_each_available_child_of_node() for the outer
>> loop, then check afterwards if anything was found.
> 
> The subsystem in its current guise doesn't reliably support the
> situation you describe. We have no way to track which child nodes have
> been through this process previously, thus mfd-core will always choose
> the first child node with a matching compatible string.

Ah, OK, if that situation has never been expected to work properly then 
the simple patch is probably fine.

> If you have any suggests in terms of adding support for multiple
> children with matching compatible strings, I'd be very receptive.

I know very little about the MFD layer and its users, so I wasn't sure 
whether this 'multiple child instances' thing would ever actually be a 
real concern (other than for "simple-mfd"s which apparently don't use 
this mechanism anyway) - I was just considering the code from a pure DT 
perspective.

Cheers,
Robin.

>>>    				pdev->dev.of_node = np;
>>>    				pdev->dev.fwnode = &np->fwnode;
>>>    				break;
>>>
> 
