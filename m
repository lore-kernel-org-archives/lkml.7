Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D6ECC04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 18:44:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA7C620833
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 18:44:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rA7y24PM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727984AbfEQSoa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 14:44:30 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:36377 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726869AbfEQSoa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 14:44:30 -0400
Received: by mail-io1-f68.google.com with SMTP id e19so6301000iob.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2019 11:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=26Gvm8NqSnzuWy1Z2xRXYbuZqD+pzdlTw9gJXHfixmE=;
        b=rA7y24PMNP8R5jLl62HDXXSZOMa0lZYGs0NVjI4FozRGRt3zJBR/voB3jmkibwinxZ
         qCi7AiY9jIEtPDYI8WsUGrRCork6YqZcC0lzxcl+r/maeVhCOio/xh3+U9Ro2NemdkQk
         3b+N83qySzcEWeZ1ONHgjNQDxkhxwDpkIawiuppA/YCz6+y2/ggrY6N3AcoR/sfUzwa1
         R5tDkLYR1wsKn/FuPRl/o/MCzcSNCbkenvOuHIBTAYXTsZI19vVfZStz0hFZhgu1TQvZ
         mmmtQYuyTcKJflLFD2Zr7XggXZ7F1vASxvWq7VeKbOsIE1nUl7cuHaht+PhpRnXr2xvR
         m3cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=26Gvm8NqSnzuWy1Z2xRXYbuZqD+pzdlTw9gJXHfixmE=;
        b=gVk7akflhcslgzTk1eyIbJKGSyRXIeR/HHWQYL4VQvRTw1+eitePxxONaLBPoXdD21
         3Ct8X24rO8wH+MVuMudeN9ehRBpjK6syJNO9Fxmlzlt6r8yuMQVhYpnsuxBFasqJbEyn
         PzKdHzd7qTpnuGywkQIwWk1gjRF7LmFS9fArwrXQjY8Uz5GdrSMGbcIyJs01UiPh59iO
         Mgb5Esk8FejoXjpSaKKlpFXWeijQRvF4akEE6UgWxUyDaQ9nWxPnVo+48zuWASn6/liS
         2KRe3GIRIKWpy1f2zLiYTOcfUsow45+86m2j6QlfCmPbzGA8r37ahpPtMGGAvjYS0Go2
         e5Tw==
X-Gm-Message-State: APjAAAVYb5TIWYQN5ZXKq31gVaQEDanyL4aTOzaV3sBY5N/sOFZ5cGFU
        vpxgBSGoCs4Mu7RUtkCf1A0co2sBaP4=
X-Google-Smtp-Source: APXvYqyrFQ5MkHEI5COLlaixZdibqO4u3frTo+8Befr5i2LzWDTREkQ32AbACnorOP0zHNYA3hV8eQ==
X-Received: by 2002:a5e:9518:: with SMTP id r24mr2074290ioj.218.1558118669276;
        Fri, 17 May 2019 11:44:29 -0700 (PDT)
Received: from [172.22.22.26] (c-71-195-29-92.hsd1.mn.comcast.net. [71.195.29.92])
        by smtp.googlemail.com with ESMTPSA id 8sm515852itd.24.2019.05.17.11.44.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 May 2019 11:44:28 -0700 (PDT)
Subject: Re: [PATCH 09/18] soc: qcom: ipa: GSI transactions
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
From:   Alex Elder <elder@linaro.org>
Message-ID: <4a34d381-d31d-ea49-d6d3-3c4f632958e3@linaro.org>
Date:   Fri, 17 May 2019 13:44:27 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAK8P3a37bPRZTHZcrg8KrYRLAhCr9pk8v4yuo_wSyUONs2OysQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/17/19 1:33 PM, Arnd Bergmann wrote:
> On Fri, May 17, 2019 at 8:08 PM Alex Elder <elder@linaro.org> wrote:
>>
>> On 5/15/19 2:34 AM, Arnd Bergmann wrote:
>>>> +static void gsi_trans_tre_fill(struct gsi_tre *dest_tre, dma_addr_t addr,
>>>> +                              u32 len, bool last_tre, bool bei,
>>>> +                              enum ipa_cmd_opcode opcode)
>>>> +{
>>>> +       struct gsi_tre tre;
>>>> +
>>>> +       tre.addr = cpu_to_le64(addr);
>>>> +       tre.len_opcode = gsi_tre_len_opcode(opcode, len);
>>>> +       tre.reserved = 0;
>>>> +       tre.flags = gsi_tre_flags(last_tre, bei, opcode);
>>>> +
>>>> +       *dest_tre = tre;        /* Write TRE as a single (16-byte) unit */
>>>> +}
>>> Have you checked that the atomic write is actually what happens here,
>>> but looking at the compiler output? You might need to add a 'volatile'
>>> qualifier to the dest_tre argument so the temporary structure doesn't
>>> get optimized away here.
>>
>> Currently, the assignment *does* become a "stp" instruction.
>> But I don't know that we can *force* the compiler to write it
>> as a pair of registers, so I'll soften the comment with
>> "Attempt to write" or something similar.
>>
>> To my knowledge, adding a volatile qualifier only prevents the
>> compiler from performing funny optimizations, but that has no
>> effect on whether the 128-bit assignment is made as a single
>> unit.  Do you know otherwise?
> 
> I don't think it you can force the 128-bit assignment to be
> atomic, but marking 'dest_tre' should serve to prevent a
> specific optimization that replaces the function with
> 
>     dest_tre->addr = ...
>     dest_tre->len_opcode = ...
>     dest_tre->reserved = ...
>     dest_tre->flags = ...
> 
> which it might find more efficient than the stp and is equivalent
> when the pointer is not marked volatile. We also have the WRITE_ONCE()
> macro that can help prevent this, but it does not work reliably beyond
> 64 bit assignments.

OK, I'll mark it volatile to avoid that potential result.
Thanks.

					-Alex

> 
>       Arnd
> 

