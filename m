Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35819CA9EB9
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 22:07:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06AF72084C
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 22:07:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="IJZYTKzc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436697AbfJWWHO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 18:07:14 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33081 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436658AbfJWWHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 18:07:13 -0400
Received: by mail-pf1-f195.google.com with SMTP id c184so4251427pfb.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2019 15:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=cujCjqkjjqtzyxP2LMvJxOSW52EZURhhallr8EyFLWI=;
        b=IJZYTKzc6XlQIOzUqw0cdsZHx6qAqEIQo7oMaBK9BqX4LLrV5o8m8xjoTgGrnYEdtR
         iMtH/eyJA6pKIWFCifnu6CxvWnGq2vJdVTNMY8DCC9Luub+UH11+cTYryzQOzHTJ0xBc
         vO/PMUjSG7+xUWXfX6R4WSzqyIs5K46KkomO6uiQoXkgdEe1+o4ZZgLtYbrfR5ktBVh6
         osG+FCHEaBcn65mOdiciNjsOGpnFbiFWhCHVDEnkvM6411T2lJNs2W3tSz3MClp5CcQg
         FE6Qo1ZNnKBst5kHz5QtXOYpr0ogBBsReo8xJF2frZyOtmwiWfCdismm8t+KnIwBKtfA
         uq6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=cujCjqkjjqtzyxP2LMvJxOSW52EZURhhallr8EyFLWI=;
        b=WrUlGzYas1Ay7jZhkaW29Cj9ylvw4xMhGdVWhdR+N3HnNYGyUrWlpP/7cC2b3+N0wn
         W6FbLIE/9/FKuJPdkkzEurAPiRD3OS6S4XYN5PuvH7Pn1+oUD27MJEDoLB5kPox8XDME
         pXlEIXNiR3o7vMf9uBjw92+C2x76mJqIbBuoNigqGjnEBagvp7DjBu9pN63JFf1M2plQ
         wD5/ser6Rf84p6F4Fsfa6RronRsjw7suh3P5KTUc6FAY2WE1s8HAb5L6w70DadKlcL8X
         VPi1mG+n0kuhdxleVI8OGS/c2NPZlgXWNCPiQm/2dkHWlf6eCUjrQ/uaHIznKRoIUPZt
         1lFA==
X-Gm-Message-State: APjAAAU3eNez/852bkCUb7Jt9p2bIVdT6sRNgc3EsYvDa0I/fLhjw7T5
        1/wf88qilaSwlBgF61gAsIRWYA==
X-Google-Smtp-Source: APXvYqzQN2qqMoAroPF87fAIhAAY/k/ioMXMfV8E2oLtQe7lZxdAcyktactW4hBzY5AJG1pUXxCIYQ==
X-Received: by 2002:aa7:838f:: with SMTP id u15mr6005674pfm.13.1571868431482;
        Wed, 23 Oct 2019 15:07:11 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id j128sm25978757pfg.51.2019.10.23.15.07.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2019 15:07:10 -0700 (PDT)
Date:   Wed, 23 Oct 2019 15:07:10 -0700 (PDT)
X-Google-Original-Date: Wed, 23 Oct 2019 15:07:06 PDT (-0700)
Subject:     Re: [PATCH] irqchip: Skip contexts other supervisor in plic_init()
In-Reply-To: <alpine.DEB.2.21.9999.1910231152580.16536@viisi.sifive.com>
CC:     alan.mikhak@sifive.com, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, tglx@linutronix.de,
        jason@lakedaemon.net, maz@kernel.org,
        Christoph Hellwig <hch@infradead.org>
From:   Palmer Dabbelt <palmer@sifive.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>
Message-ID: <mhng-aefb3209-29c4-46db-8cf2-e12db46d9a6e@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Oct 2019 11:54:54 PDT (-0700), Paul Walmsley wrote:
> + hch
>
> On Wed, 23 Oct 2019, Alan Mikhak wrote:
>
>> From: Alan Mikhak <alan.mikhak@sifive.com>
>>
>> Modify plic_init() to skip .dts interrupt contexts other
>> than supervisor external interrupt.
>
> Might be good to explain the motivation here.
>
>>
>> Signed-off-by: Alan Mikhak <alan.mikhak@sifive.com>
>> ---
>>  drivers/irqchip/irq-sifive-plic.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
>> index c72c036aea76..5f2a773d5669 100644
>> --- a/drivers/irqchip/irq-sifive-plic.c
>> +++ b/drivers/irqchip/irq-sifive-plic.c
>> @@ -251,8 +251,8 @@ static int __init plic_init(struct device_node *node,
>>  			continue;
>>  		}
>>
>> -		/* skip context holes */
>> -		if (parent.args[0] == -1)
>> +		/* skip contexts other than supervisor external interrupt */
>> +		if (parent.args[0] != IRQ_S_EXT)
>>  			continue;
>
> Will this need to change for RISC-V M-mode Linux support?
>
> https://lore.kernel.org/linux-riscv/20191017173743.5430-1-hch@lst.de/

Yes.

>
>
> - Paul
