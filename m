Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 582F2C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 04:59:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17AB12073D
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 04:59:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TB4GdK7+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732410AbfHBE75 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 00:59:57 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46860 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbfHBE75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 00:59:57 -0400
Received: by mail-pg1-f194.google.com with SMTP id k189so16383293pgk.13
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2019 21:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=LoXCYNXDN/gY//rGffF67REslgzM9m+tejR6An12dGk=;
        b=TB4GdK7+IYXiZlY116tymxqfz5o1b6tHDJ46snBLAuKihW3/nlX8HMv0QWJxsxqcpd
         BYXluhbYMtwQgA+voDr/TKPMCXMp5tK+0AJupWjyxLC3vRxGCG0A5i+geMAV3qZ20lGn
         5SoqeycGW27o/gIi7Kvnt1KxrOUDF+OTz6Xn7mKHGfG9n79JjispqokJDU3W8i5S2a6o
         fVudWUgEnHJpu8GjR/hZ0zMPUXxsLlNWt1cd6Ozi/uVEpGgwxa8wzs5J3a6ElFXLHPzk
         Zu5tBHooHYXEq8anf0zC4nDqjm8pA7aTufi5wLbeQrUv3eb+2VPnT1QaPKY2eGqj6vL1
         0ptA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LoXCYNXDN/gY//rGffF67REslgzM9m+tejR6An12dGk=;
        b=gfF7gwOt0ZzGbJrlKIwzePbAoNv1/N0mOM0M8LLZgrBM2CWtwGgGnpirM9Xbdlwzqd
         6Du25cQOIsoKqqBMqRar1ob2Bs61AkvqxHwMhsq9kbJLYFrle442Z/DVxfE/ScrBNnL0
         UiA0zCCZZR+Nhu4qbRxzu0anpyZmyxtc5YIr3DsbRLnZNdHXql58sXa0AT5UvvXizkDI
         vvXtkuKqnSQQqD6Y3QoHDqp9DzUS6Z1p15HDRg34/2ue0kiChD/+LrRlA3uUSP08SYiq
         Z4S9zi3DzRupDf6PE620HAX1RkDoRB5Lp69bDKSKiLdKt9KsZGxowuZArNh0Esl3PG/Q
         z77g==
X-Gm-Message-State: APjAAAV0mRfXn9TRzwYjfMua8AyfWiFIhY7mNIrexRXBAl0qmwXs6ZjU
        ff8+1zoofGTGHBfFR0tn3nw=
X-Google-Smtp-Source: APXvYqx3fPzXaP91dhlBLUagvFtX3BfTYw6uPCF+dtSmNhbvs9db3cnYK+q+xcb3Q7RejHwVGG+uow==
X-Received: by 2002:a17:90a:36a7:: with SMTP id t36mr2415642pjb.34.1564721996554;
        Thu, 01 Aug 2019 21:59:56 -0700 (PDT)
Received: from [10.0.2.15] ([122.163.105.8])
        by smtp.gmail.com with ESMTPSA id 81sm117483655pfx.111.2019.08.01.21.59.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Aug 2019 21:59:56 -0700 (PDT)
Subject: Re: [PATCH] mailbox: zynqmp-ipi-mailbox: Add of_node_put() before
 goto
To:     Michal Simek <michal.simek@xilinx.com>, jassisinghbrar@gmail.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20190709172841.13769-1-nishkadg.linux@gmail.com>
 <eaf1fcbe-615e-0fec-d330-ae94e8f3c102@xilinx.com>
 <6a5306bd-946d-383f-0b42-f17675c24218@gmail.com>
 <c0be80c9-16ef-fe03-ae3b-a7d3d1a2ede8@xilinx.com>
From:   Nishka Dasgupta <nishkadg.linux@gmail.com>
Message-ID: <ab6db31d-ff16-5a32-f097-347daa6b98fc@gmail.com>
Date:   Fri, 2 Aug 2019 10:29:49 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <c0be80c9-16ef-fe03-ae3b-a7d3d1a2ede8@xilinx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/07/19 7:51 PM, Michal Simek wrote:
> On 31. 07. 19 15:06, Nishka Dasgupta wrote:
>> On 31/07/19 2:01 PM, Michal Simek wrote:
>>> On 09. 07. 19 19:28, Nishka Dasgupta wrote:
>>>> Each iteration of for_each_available_child_of_node puts the previous
>>>> node, but in the case of a goto from the middle of the loop, there is
>>>> no put, thus causing a memory leak. Hence add an of_node_put before the
>>>> goto.
>>>> Issue found with Coccinelle.
>>>>
>>>> Signed-off-by: Nishka Dasgupta <nishkadg.linux@gmail.com>
>>>> ---
>>>>    drivers/mailbox/zynqmp-ipi-mailbox.c | 1 +
>>>>    1 file changed, 1 insertion(+)
>>>>
>>>> diff --git a/drivers/mailbox/zynqmp-ipi-mailbox.c
>>>> b/drivers/mailbox/zynqmp-ipi-mailbox.c
>>>> index 86887c9a349a..bd80d4c10ec2 100644
>>>> --- a/drivers/mailbox/zynqmp-ipi-mailbox.c
>>>> +++ b/drivers/mailbox/zynqmp-ipi-mailbox.c
>>>> @@ -661,6 +661,7 @@ static int zynqmp_ipi_probe(struct
>>>> platform_device *pdev)
>>>>            if (ret) {
>>>>                dev_err(dev, "failed to probe subdev.\n");
>>>>                ret = -EINVAL;
>>>> +            of_node_put(nc);
>>>>                goto free_mbox_dev;
>>>>            }
>>>>            mbox++;
>>>>
>>>
>>> Patch is good but when you are saying that this was found by Coccinelle
>>> then it should be added as script to kernel to detect it.
>>
>> This particular patch was suggested by a script I did not write myself;
>> someone else wrote it and sent it to me. How should I proceed in this case?
> 
> You can ask him to submit it to kernel.
> Or you can take it, keep his authorship and send it to:

I have asked her to submit this script, thank you. Will I need to 
resubmit this patch, however?

Regards,
Nishka

> ./scripts/get_maintainer.pl -f scripts/coccinelle/
> Julia Lawall <Julia.Lawall@lip6.fr> (supporter:COCCINELLE/Semantic
> Patches (SmPL))
> Gilles Muller <Gilles.Muller@lip6.fr> (supporter:COCCINELLE/Semantic
> Patches (SmPL))
> Nicolas Palix <nicolas.palix@imag.fr> (supporter:COCCINELLE/Semantic
> Patches (SmPL))
> Michal Marek <michal.lkml@markovi.net> (supporter:COCCINELLE/Semantic
> Patches (SmPL))
> cocci@systeme.lip6.fr (moderated list:COCCINELLE/Semantic Patches (SmPL))
> linux-kernel@vger.kernel.org (open list)
> 
> Thanks,
> Michal
> 

