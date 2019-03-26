Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D58DBC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 13:14:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BB3D2084B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 13:14:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Ir2bcbzL";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="kQPxLX9A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731535AbfCZNOK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 09:14:10 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:33380 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731452AbfCZNOJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 09:14:09 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 6269E609F3; Tue, 26 Mar 2019 13:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553606048;
        bh=xDHQLG1zvVO/rPq0fBAFLYmo6FKErI0WBC38ViEvmJE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Ir2bcbzLftyCiGqbNJrH+QZ2/ycWw/ibfRJtxI/QzrGKFFynULlU2/XlfkQVOEh6Y
         hjnPXc4DjlOOHQ1FQX5dYi82wQxtwxjZdJz7SnRo6aCK1J3YPYD9kupzioAaS5AdNu
         6RSM2eqIuxg/GETUSstX5jQLmhM7vYkqXwiRyfuA=
Received: from [10.204.78.115] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: gkohli@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 75B69607C6;
        Tue, 26 Mar 2019 13:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553606047;
        bh=xDHQLG1zvVO/rPq0fBAFLYmo6FKErI0WBC38ViEvmJE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=kQPxLX9ADeFYRI5y5A4i7wYp6uG0XwND/HuFMnw1a4XfFAMD8uMobwtqB5OOwKxWy
         WJYPLlq5og9lL4b0mKXs2S16Y6Utx16e7jb+1tlJvDw4xPJ88NbkzJ6P7gWrQQxQQS
         sTI3d+kso9BG/rTx/2wFJxpe7Qf2JyEEEHUqZ0EU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 75B69607C6
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=gkohli@codeaurora.org
Subject: Re: [PATCH v0] nvmem: core: Export nvmem cell info to userspace
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-kernel@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org,
        Shiraz Hashim <shashim@codeaurora.org>
References: <1553061201-28894-1-git-send-email-gkohli@codeaurora.org>
 <b356f99c-15ff-06ce-e40b-4bb8b664b6c9@linaro.org>
 <ecd3986a-7846-1f87-4d2e-4c66bd6698c9@codeaurora.org>
 <f6a9162f-4d91-1ef4-db9c-deb763cf5778@linaro.org>
From:   Gaurav Kohli <gkohli@codeaurora.org>
Message-ID: <1bd48029-9acd-dca5-c05e-3a657122546d@codeaurora.org>
Date:   Tue, 26 Mar 2019 18:44:04 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <f6a9162f-4d91-1ef4-db9c-deb763cf5778@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/25/2019 4:28 PM, Srinivas Kandagatla wrote:
>
>
> On 24/03/2019 15:25, Gaurav Kohli wrote:
>>
>> On 3/22/2019 8:53 PM, Srinivas Kandagatla wrote:
>>>
>>>
>>> On 20/03/2019 05:53, Gaurav Kohli wrote:
>>>> From: Shiraz Hashim <shashim@codeaurora.org>
>>>>
>>>> Existing nvmem framework export full register space
>>>> as nvmem binary, but not exporting child node of nvmem
>>>> which is nvmem cell. Kernel can read the specific cell
>>>> by using nvmem_cell_read but userspace don't have such
>>>> provision.
>>>>
>>>> Add framework to export nvmem cell as well, So
>>>> userspace can use it directly.
>>>>
>>>> Signed-off-by: Shiraz Hashim <shashim@codeaurora.org>
>>>> Signed-off-by: Gaurav Kohli <gkohli@codeaurora.org>
>>>> Co-developed-by: Gaurav Kohli <gkohli@codeaurora.org>
>>>>
>>>> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
>>>
>>> Thankyou for the patch.
>>>
>>> Why do you need such provision when the userspace can just get the 
>>> cell values using correct offset and size.
>>> This will also bring over head of managing entries dynamically + 
>>> confusing userspace abi.
>>>
>>> Unless you have a valid reason or usecase I don't see the need for 
>>> this.
>>
>>
>> Hi Srinivas,
>>
>>
>> This is mainly for user space convenience, In existing implementation 
>> they have to do manipulation according
>
>>
>> to offset and bit, And with present patch, they just have to do cat 
>> for cell name and which can also be easily maintainable
> Yes, that is expected I guess!
>
>>
>> for different soc. But with current, it is difficult to maintain 
>> users space code as each time we have to change user space code 
>> according to bit.
>
> Which user space code/application are you referring to here? Are these 
> open source?

Hi Srini,

This is not open source, we have a requirement to read certain bits of 
nvmem.

>
>>
>>
>> This would also help to expose certain bit only as per the bit 
>> parameter mentioned in dt node, which would also help to protect 
>> exposing of
>>
> NVMEM is not just limited for DT users, non dt users use this f/w too.
> So the problem is not as simple as it sounds.
>
> If your issue is just about DT, you could easily parse active device 
> tree via  /proc/device-tree and get cell offset, length and names from 
> it, use this information to read from nvmem.
>
> There are other concerns about the userspace ABI w.r.t udev events.
> udev events would race with the creation on this cell entries 
> resulting in a behavior where user-space applications would not see 
> the entries after udev events.
>
> In worst case if we decide to go with adding cells to nvmem then we 
> should do it before the device is even probed using group attributes.
> And this would mean that we can not support cells that are dynamically 
> defined. And there might be some memory freeing issues in this method 
> too!
yes i agree they are dynamic entries as well of nvmem cell,  Can you 
please suggest some other way ?
>
> --srini
>
>
>> other bits to user space.
>>
>>>
>>> thanks,
>>> srini
>>
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center,
Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.

