Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A177C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 12:50:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3929A2054F
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 12:50:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lIwpRk82"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389109AbfETMu0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 08:50:26 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:40416 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730404AbfETMuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 08:50:24 -0400
Received: by mail-it1-f194.google.com with SMTP id h11so1244198itf.5
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 05:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Qx87YI2gjVMlfmpnZTr12jvkaOAAGprsDuNFTZhY9mU=;
        b=lIwpRk82jVA169lGfPnbVTNNmG3yENbUfBAKq+tGpn8kWVNVKBNmGTnXt301hGMoJS
         kH+jQGss4CbbxeYSYpZ7IbzEbdhi/iFz0d2K65D9qCpunXtM+HlkmqnkJp9U4xI0H0iX
         TcUtQoc2d81L3velqghzct5aupzuvpjfhjdAGRg3iGDNEcQIyqLjOaAlJeQM/E0utx7E
         1QojRPlj2tRGEvHtWzXvlIr2jOH12LfYpfnuZfZ5OX6mNmfD/XhyOe5Va/hCr9O7J31h
         kkFsMiS1/gTyAGrQJ17oKGupS8RVE2xFOX/J+AcpWiA0m3h9DnjVDvEjDF0zWYG0uh3u
         DvPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Qx87YI2gjVMlfmpnZTr12jvkaOAAGprsDuNFTZhY9mU=;
        b=VyewteQHnxfCWWm1MeGFNFr8T8BMcmSkWam+tcp90Ww1Nv8PTiMh8QNiXOpjDmqUAF
         k5zanMhqnAYe9wNpiDPv6x6B7nfRYqD0g3MMn+L/5tRnjhZZX6sVdelhXIPErDqKhq1O
         MtbJnj2Z78eKEXIEch0WJEe+eQXxjL1rJodIDJ+CZDe6JVgnEi0+pZqjqDm4mD58RyYr
         JrGoMoBckRoD2C4sojvOWu9gvVSq+AwYEgzUKvtGJ1BSXhK6dRLotc71l7nFQdXfTGQ1
         UrHRJ2O4wul/FSJG8m434T1ZSlCU+aupb0vXWufln181MOE2Y15jcTFvvh9ZqG741nkH
         Q3Sg==
X-Gm-Message-State: APjAAAXKJrR1//a255CDW0myqwK73j2Y1IE0tVIcIs+2GdJ/xoI8SmLr
        jjamHmeqqOw/BgjoDenPHz9rgGX5jR8=
X-Google-Smtp-Source: APXvYqw3eYQFmiU2P80F3YK/n1+jYIrr8BZKprDfqo6BJhP36N/o4ae7Go1mhoVwFjFPnHWLn0T0jA==
X-Received: by 2002:a05:660c:6c8:: with SMTP id z8mr29501887itk.51.1558356622660;
        Mon, 20 May 2019 05:50:22 -0700 (PDT)
Received: from [172.22.22.26] (c-71-195-29-92.hsd1.mn.comcast.net. [71.195.29.92])
        by smtp.googlemail.com with ESMTPSA id 74sm4796440itk.3.2019.05.20.05.50.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 May 2019 05:50:21 -0700 (PDT)
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
 <4a34d381-d31d-ea49-d6d3-3c4f632958e3@linaro.org>
 <dcd648f2-5305-04dd-8997-be87a9961fd9@linaro.org>
 <CAK8P3a0FfSvTF8kkQ8pyKFNX9-fSXvtEyMBYTjtM+VOPxMPkWg@mail.gmail.com>
From:   Alex Elder <elder@linaro.org>
Message-ID: <d3d4670f-eb8b-7dcf-f91a-1ec1d4d96f67@linaro.org>
Date:   Mon, 20 May 2019 07:50:20 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAK8P3a0FfSvTF8kkQ8pyKFNX9-fSXvtEyMBYTjtM+VOPxMPkWg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/20/19 4:25 AM, Arnd Bergmann wrote:
> On Sun, May 19, 2019 at 7:11 PM Alex Elder <elder@linaro.org> wrote:
>> On 5/17/19 1:44 PM, Alex Elder wrote:
>>> On 5/17/19 1:33 PM, Arnd Bergmann wrote:
>>>> On Fri, May 17, 2019 at 8:08 PM Alex Elder <elder@linaro.org>
>>
>> So it seems that I must *not* apply a volatile qualifier,
>> because doing so restricts the compiler from making the
>> single instruction optimization.
> 
> Right, I guess that makes sense.
> 
>> If I've missed something and you have another suggestion for
>> me to try let me know and I'll try it.
> 
> A memcpy() might do the right thing as well. Another idea would

I find memcpy() does the right thing.

> be a cast to __int128 like

I find that my environment supports 128 bit integers.  But...

> #ifdef CONFIG_ARCH_SUPPORTS_INT128
> typedef __int128 tre128_t;
> #else
> typedef struct { __u64 a; __u64 b; } tre128_t;
> #else
> 
> static inline void set_tre(struct gsi_tre *dest_tre, struct gs_tre *src_tre)
> {
>      *(volatile tre128_t *)dest_tre = *(tre128_t *)src_tre;
> }
...this produces two 8-bit assignments.  Could it be because
it's implemented as two 64-bit values?  I think so.  Dropping
the volatile qualifier produces a single "stp" instruction.

The only other thing I thought I could do to encourage
the compiler to do the right thing is define the type (or
variables) to have 128-bit alignment.  And doing that for
the original simple assignment didn't change the (desirable)
outcome, but I don't think it's really necessary in this
case, considering the single instruction uses two 64-bit
registers.

I'm going to leave it as it was originally; it's the simplest:
	*dest_tre = tre;

I added a comment about structuring the code this way with
the intention of getting the single instruction.  If a different
compiler produces different result

					-Alex

> 
>       Arnd
> 

