Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70B21C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 15:26:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3667120700
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 15:26:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="mH+bfUCD";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="X9dYIJl/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728642AbfCXP0G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 11:26:06 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:38950 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbfCXP0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 11:26:05 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 3E93E608BA; Sun, 24 Mar 2019 15:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553441164;
        bh=PT7gMdgDKCPg21cn8rPlhLS3pKQ4Q0XrDpgOh2KwebU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=mH+bfUCD6jg8e8o8JkzDxTwkbBsN0/1fZsOQy1ouFpJOmyhAepHZbt94//8ZwQ/HR
         TaqpjczZa03gGz3tq0f6P+SOCFPPxhLoQmmJEac/DTSPa3W7HLh7jFbNaCA1qXOGxL
         yZ8CHK2GKtLXJhZDWsN1R/5yPpOPkqVKanAmow/Q=
Received: from [192.168.1.4] (unknown [122.175.84.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: gkohli@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 04A3E602F8;
        Sun, 24 Mar 2019 15:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553441163;
        bh=PT7gMdgDKCPg21cn8rPlhLS3pKQ4Q0XrDpgOh2KwebU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=X9dYIJl/2Z0zkpohshrLSipBdzoMc9VTXxn27m/lppN2BczqbCwu6EKEwb05PcLNE
         do7mvjGDOT/PmRL1xoHklz/HM8LciqhElBxY1tkZuytOWcHMOsMRJhGCzXgwaKe+jS
         2qkEfVA9p9+3I0aPcRnE3jjoDy090AvCpvTRBUDg=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 04A3E602F8
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=gkohli@codeaurora.org
Subject: Re: [PATCH v0] nvmem: core: Export nvmem cell info to userspace
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-kernel@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org,
        Shiraz Hashim <shashim@codeaurora.org>
References: <1553061201-28894-1-git-send-email-gkohli@codeaurora.org>
 <b356f99c-15ff-06ce-e40b-4bb8b664b6c9@linaro.org>
From:   Gaurav Kohli <gkohli@codeaurora.org>
Message-ID: <ecd3986a-7846-1f87-4d2e-4c66bd6698c9@codeaurora.org>
Date:   Sun, 24 Mar 2019 20:55:59 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <b356f99c-15ff-06ce-e40b-4bb8b664b6c9@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/22/2019 8:53 PM, Srinivas Kandagatla wrote:
>
>
> On 20/03/2019 05:53, Gaurav Kohli wrote:
>> From: Shiraz Hashim <shashim@codeaurora.org>
>>
>> Existing nvmem framework export full register space
>> as nvmem binary, but not exporting child node of nvmem
>> which is nvmem cell. Kernel can read the specific cell
>> by using nvmem_cell_read but userspace don't have such
>> provision.
>>
>> Add framework to export nvmem cell as well, So
>> userspace can use it directly.
>>
>> Signed-off-by: Shiraz Hashim <shashim@codeaurora.org>
>> Signed-off-by: Gaurav Kohli <gkohli@codeaurora.org>
>> Co-developed-by: Gaurav Kohli <gkohli@codeaurora.org>
>>
>> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
>
> Thankyou for the patch.
>
> Why do you need such provision when the userspace can just get the 
> cell values using correct offset and size.
> This will also bring over head of managing entries dynamically + 
> confusing userspace abi.
>
> Unless you have a valid reason or usecase I don't see the need for this.


Hi Srinivas,


This is mainly for user space convenience, In existing implementation 
they have to do manipulation according

to offset and bit, And with present patch, they just have to do cat for 
cell name and which can also be easily maintainable

for different soc. But with current, it is difficult to maintain users 
space code as each time we have to change user space code according to bit.


This would also help to expose certain bit only as per the bit parameter 
mentioned in dt node, which would also help to protect exposing of

other bits to user space.

>
> thanks,
> srini

-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center,
Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.

