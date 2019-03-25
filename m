Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCA1AC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 09:13:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 994CA2087E
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 09:13:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="WEo15FPR";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="GuLHu01s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730224AbfCYJNe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 05:13:34 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:52342 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730029AbfCYJNe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 05:13:34 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 8F2D1602F8; Mon, 25 Mar 2019 09:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553505213;
        bh=Wl35PnpnWzaSszHVQOVqXbpqSsy/S8TUx0Hlltg0OL4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=WEo15FPRbPpxH0DTUiqqdzkA21q/NmgaIJZp7efSSRYpLjyxOCbmfUW3FhLz3lb2m
         wXLBcFRDJgnbSTio45uMEMwBpiHxSNg5M5lwrqKNplvk433tOOdyLB7CHY1KK7szTk
         XXOd3+bpi5Arv65Mg7IRIc5RVOduDN9ODejgbmx0=
Received: from [10.204.79.83] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5A7EA60767;
        Mon, 25 Mar 2019 09:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553505212;
        bh=Wl35PnpnWzaSszHVQOVqXbpqSsy/S8TUx0Hlltg0OL4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=GuLHu01sg2fFNpT5nRF06UuBeGClSAX7s1Rxig8obbzhrlKTjZsASTMjn+qzQUICX
         7e3iFjxBCepcdyclACk88R3VVYxvqoSlpPQzhqyIykoc7TlqF1oD1s5sld47iJBdbd
         NuxQuBC23AKD6WWNyTD/6mYcyek23BnG4CqiYffw=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5A7EA60767
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH] mfd: fix a potential NULL pointer dereference
To:     Lee Jones <lee.jones@linaro.org>, Kangjie Lu <kjlu@umn.edu>
Cc:     pakki001@umn.edu, linux-kernel@vger.kernel.org
References: <20190309080456.8579-1-kjlu@umn.edu>
 <C71F9E7E-5EF8-4AE5-92D4-4596D25B1D9B@umn.edu> <20190325075608.GY4731@dell>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <be967424-090f-d388-4530-47a9a817db1f@codeaurora.org>
Date:   Mon, 25 Mar 2019 14:43:25 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <20190325075608.GY4731@dell>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/25/2019 1:26 PM, Lee Jones wrote:
> On Fri, 22 Mar 2019, Kangjie Lu wrote:
>
>> Hi Lee Jones,
>>
>> Can you review this patch?
> Don't poke.
>
> I have a very long list of reviews on my TODO.  Poking only surfaces
> your patch to the top of my Inbox, and since I review patches in
> reverse chronological order, it puts the review to the back of the
> queue.
>
>>> On Mar 9, 2019, at 2:04 AM, Kangjie Lu <kjlu@umn.edu> wrote:
>>>
>>> In case devm_kzalloc fails, the fix does NULL check and returns
>>> -ENOMEM upon failure so as to avoid NULL pointer dereference.
>>>
>>> Signed-off-by: Kangjie Lu <kjlu@umn.edu>
>>> ---
>>> drivers/mfd/sm501.c | 3 +++
>>> 1 file changed, 3 insertions(+)
>>>
>>> diff --git a/drivers/mfd/sm501.c b/drivers/mfd/sm501.c
>>> index a530972c5a7e..e0173bf4b0dc 100644
>>> --- a/drivers/mfd/sm501.c
>>> +++ b/drivers/mfd/sm501.c
>>> @@ -1145,6 +1145,9 @@ static int sm501_register_gpio_i2c_instance(struct sm501_devdata *sm,
>>> 	lookup = devm_kzalloc(&pdev->dev,
>>> 			      sizeof(*lookup) + 3 * sizeof(struct gpiod_lookup),
>>> 			      GFP_KERNEL);
>>> +	if (!lookup)
>>> +		return -ENOMEM;

Seems you are using quite old codebase.
This patch is already there ..

https://elixir.bootlin.com/linux/v5.1-rc2/source/drivers/mfd/sm501.c#L1147

commit ae7b8eda27b3( mfd: sm501: Fix potential NULL pointer dereference )


Thanks,
Mukesh


>>> +
>>> 	lookup->dev_id = "i2c-gpio";
>>> 	if (iic->pin_sda < 32)
>>> 		lookup->table[0].chip_label = "SM501-LOW";
