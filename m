Return-Path: <SRS0=AA30=TT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AAA2C04AB4
	for <linux-kernel@archiver.kernel.org>; Sun, 19 May 2019 17:11:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A15A205ED
	for <linux-kernel@archiver.kernel.org>; Sun, 19 May 2019 17:11:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Tm3w/KLq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727038AbfESRLe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 May 2019 13:11:34 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:34276 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725766AbfESRLd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 May 2019 13:11:33 -0400
Received: by mail-io1-f68.google.com with SMTP id g84so9248879ioa.1
        for <linux-kernel@vger.kernel.org>; Sun, 19 May 2019 10:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vuMFQvHw3H3yFO0Rb0gaZGrXZFFLgufmmyZYl4ovM8k=;
        b=Tm3w/KLqHWnE8q+z6u4cYVBY3EDszRWhZ+C9oiUbcnyLD1zNdDig4nTU4oBFXw6Srl
         myzxEzLSQQIeFa9E0P7a/4SPrF34poS84Gvf90C6Z/bukLGhXE7iTaHZEfAqXHaTpMOC
         p/nX5GdVjmyqWvAIELJtSFkX9OCuuDLg1grQzT3syrbpd8lSAEKYz7EQwZBZFpmlVJiV
         oNo9k0FupK+li+mKtLXMcebYTY55/klqBlIhDq3GnvB8Z0hKTxwy5PSxMKkuK7c9pfFC
         4Xai7U7I6vhvXR7xOz4CCaaiQHeiU2jcTdUvjuYrmBIkdV6JqM3IML2ciqeGTLQ5G/Oy
         FBBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vuMFQvHw3H3yFO0Rb0gaZGrXZFFLgufmmyZYl4ovM8k=;
        b=E+Aw+ob365BeFueljr7zTYU9jLXQ95QA4n7uMK/uuwIYPbW5pxnCd+ErHnqerw4feT
         2CBVOJbr2YjDO4FyGz1F1wSokX70IOVRq99mwjMfD3VRYHpIqb1xW5gLzUlH4gLdcWdJ
         3tzZQZ3zBet8DUpE3NRTlGO5Sto+L4s/Ot2pzX+hYK7NHEKFUYJcNC8ij+Ls6/qDF9C4
         6IHe5ipctcKiQ7Aq4rTcSLdBUYWNHw/vYkJn4b2OmlFkh3WVTJpBak9ubf64y5ZjXkbH
         H5XxpX1BO2RLETSfSfukwD2fhTyGUzxR8mT6tG8/j7bLmIjrVPPDgwn+nLnTofBhESe2
         bObg==
X-Gm-Message-State: APjAAAWKBmHpgnh5l7CC83TIvZ32y6NILFzoXb4Zomj1e/TP6jz/dSP9
        xRC4JYfulg7/TYciUIjLmZK1dv6K8Fc=
X-Google-Smtp-Source: APXvYqws8ofFQBVreQ0OsK8niqj57MUtF0VcKQZ5J4NsgmwPu0Kj2ifLEOg/YMjnB4JjKaVLJAbrRg==
X-Received: by 2002:a6b:ef07:: with SMTP id k7mr38214990ioh.276.1558285892004;
        Sun, 19 May 2019 10:11:32 -0700 (PDT)
Received: from [172.22.22.26] (c-71-195-29-92.hsd1.mn.comcast.net. [71.195.29.92])
        by smtp.googlemail.com with ESMTPSA id u194sm3431362ita.1.2019.05.19.10.11.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 19 May 2019 10:11:31 -0700 (PDT)
Subject: Re: [PATCH 09/18] soc: qcom: ipa: GSI transactions
From:   Alex Elder <elder@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     David Miller <davem@davemloft.net>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        syadagir@codeaurora.org, mjavid@codeaurora.org,
        evgreen@chromium.org, Ben Chan <benchan@google.com>,
        Eric Caruso <ejcaruso@google.com>, abhishek.esse@gmail.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20190512012508.10608-1-elder@linaro.org>
 <20190512012508.10608-10-elder@linaro.org>
 <CAK8P3a0eYWN6mMwft5OSu8wQQo=kWh5safGFFNkDCELZJyiMmQ@mail.gmail.com>
 <14a040b6-8187-3fbc-754d-2e267d587858@linaro.org>
 <CAK8P3a37bPRZTHZcrg8KrYRLAhCr9pk8v4yuo_wSyUONs2OysQ@mail.gmail.com>
 <4a34d381-d31d-ea49-d6d3-3c4f632958e3@linaro.org>
Message-ID: <dcd648f2-5305-04dd-8997-be87a9961fd9@linaro.org>
Date:   Sun, 19 May 2019 12:11:29 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <4a34d381-d31d-ea49-d6d3-3c4f632958e3@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/17/19 1:44 PM, Alex Elder wrote:
> On 5/17/19 1:33 PM, Arnd Bergmann wrote:
>> On Fri, May 17, 2019 at 8:08 PM Alex Elder <elder@linaro.org>
>> wrote:
>>> 
>>> On 5/15/19 2:34 AM, Arnd Bergmann wrote:
>>>>> +static void gsi_trans_tre_fill(struct gsi_tre *dest_tre,
>>>>> dma_addr_t addr, +                              u32 len, bool
>>>>> last_tre, bool bei, +                              enum
>>>>> ipa_cmd_opcode opcode) +{ +       struct gsi_tre tre; + +
>>>>> tre.addr = cpu_to_le64(addr); +       tre.len_opcode =
>>>>> gsi_tre_len_opcode(opcode, len); +       tre.reserved = 0; +
>>>>> tre.flags = gsi_tre_flags(last_tre, bei, opcode); + +
>>>>> *dest_tre = tre;        /* Write TRE as a single (16-byte)
>>>>> unit */ +}
>>>> Have you checked that the atomic write is actually what happens
>>>> here, but looking at the compiler output? You might need to add
>>>> a 'volatile' qualifier to the dest_tre argument so the
>>>> temporary structure doesn't get optimized away here.
>>> 
>>> Currently, the assignment *does* become a "stp" instruction. But
>>> I don't know that we can *force* the compiler to write it as a
>>> pair of registers, so I'll soften the comment with "Attempt to
>>> write" or something similar.
>>> 
>>> To my knowledge, adding a volatile qualifier only prevents the 
>>> compiler from performing funny optimizations, but that has no 
>>> effect on whether the 128-bit assignment is made as a single 
>>> unit.  Do you know otherwise?
>> 
>> I don't think it you can force the 128-bit assignment to be atomic,
>> but marking 'dest_tre' should serve to prevent a specific
>> optimization that replaces the function with
>> 
>> dest_tre->addr = ... dest_tre->len_opcode = ... dest_tre->reserved
>> = ... dest_tre->flags = ...
>> 
>> which it might find more efficient than the stp and is equivalent 
>> when the pointer is not marked volatile. We also have the
>> WRITE_ONCE() macro that can help prevent this, but it does not work
>> reliably beyond 64 bit assignments.
> 
> OK, I'll mark it volatile to avoid that potential result.

OK I got interesting results so I wanted to report back.

The way it is currently written (no volatile qualifier) is
the *only* way I get a 16-byte store instruction.

Specifically, with dest_tre having type (struct gsi_tre *):
        *dest_tre = tre;

Produces this:
 4ec: a9002013        stp     x19, x8, [x0]

I attempted to make the assigned-to pointer volatile:
        *(volatile struct gsi_tre *)dest_tre = tre;

But that apparently is interpreted as "assign things
in the destination in exactly the way they were assigned
above into the "tre" structure."  Because it produced this:
 748: f9000348        str     x8, [x26]
 74c: 7940c3e8        ldrh    w8, [sp, #96]
 750: 79001348        strh    w8, [x26, #8]
 754: 7940bbe8        ldrh    w8, [sp, #92]
 758: 79001748        strh    w8, [x26, #10]
 75c: b9405be8        ldr     w8, [sp, #88]
 760: b9000f48        str     w8, [x26, #12]

From there I went back and changed the type of the dest_tre pointer
parameter to (volatile struct gsi_tre *), and changed the the type
of the values passed through that argument in the two callers to
also have the volatile qualifier.  This way there was no need to
use a cast in the left-hand side.  That too produced a string of
separate assignments, not a single 128-bit one.

I also attempted this:
	*dest_tre = *(volatile struct gsi_tre *)&tre;
And even this:
        *(volatile struct gsi_tre *)dest_tre = *(volatile struct gsi_tre *)&tre;
But neither produced a single "stp" instruction; all produced
the same sequence of instructions above.

So it seems that I must *not* apply a volatile qualifier,
because doing so restricts the compiler from making the
single instruction optimization.

If I've missed something and you have another suggestion for
me to try let me know and I'll try it.

					-Alex


> Thanks.
> 
> -Alex
> 
>> 
>> Arnd
>> 
> 

