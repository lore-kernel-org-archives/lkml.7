Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39064C43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 17:50:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF888205F4
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 17:50:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OsySwIhE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387427AbfDYRuH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 13:50:07 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45972 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730040AbfDYRuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 13:50:06 -0400
Received: by mail-pl1-f195.google.com with SMTP id o5so141063pls.12;
        Thu, 25 Apr 2019 10:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jGHbN/nN1EDbAj3UA1Xq3YMV/QXxIq6z3ov4Mx/TgUw=;
        b=OsySwIhE+xOm5pz3u4szO8rIguVlF3mTQzmqPtLUri/LBsxp6okZ0cvWGZcBJcGoPf
         m1JH00gLjqlLd0OEDoPO2L66JlMV8TR4vBgv+IpY+A/GFC+GPUrh4TH+OIncHssBwpKY
         j8fUzBtodIO/IBWOiDPyaH6Mv7oR2+BwTTwNR0kICl4XS5i6ruJ8t4MRPIrrrAhWvYWy
         G+kFMH7Zx1xJ4o1T0SCyNle3zXmggHv4+0Fb/hiE4A/qIPEm90HKbvmG/2bY4vVcVPKD
         DP2pP9VVWypKx7AAUg192ozSImKGGbZXbAFyqy7AIUFRvVjZ2Lm/5bLfr3WUOk6X7wR+
         pKnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jGHbN/nN1EDbAj3UA1Xq3YMV/QXxIq6z3ov4Mx/TgUw=;
        b=MwAsxJQXBNCY20i1nG5SLMFRWKPrx+dQoebQEI4upRP45MyBxG/i19PlqlNXqziSBp
         p/V2ErBU5oJGd0cecQGaAWVMsi2blBUY56gmtgOFxEJTAG8DLnfsXNq5/B3KIr90vhEz
         qpAHzzMcK4QQW8gHnr/qU5UGbETD0TbrYTjTaAdRTRPvanIodUf8XXJR3PnwrYQ6oJ09
         HK7bMvalYymvGcT9R/Hwih6sowI1DMeIYAMh8Wwo08bOelM9Pd1llxkV94llYBsBDDXX
         pF4qMaElttf9nk5q+N9dF04V83I/8WQrPsFRYKjHslb/Xf0KUiPCm2nW7Nf53sQbXAtE
         4W6w==
X-Gm-Message-State: APjAAAWtiI8HXrHT+sdKf/5VpRXN5De8Hx1Si4b5DOUuaH/BxZT5HFWn
        xW/9bmn6uhX7J2WoMN4lDdm31U3M
X-Google-Smtp-Source: APXvYqzm9SReXj97stC6ZMchCqoeqz3McYxfFUnbeSh3WPQeZp7Q/rbIe52gYoyqy/uPyMvU6GTTkA==
X-Received: by 2002:a17:902:e793:: with SMTP id cp19mr34974643plb.65.1556214606083;
        Thu, 25 Apr 2019 10:50:06 -0700 (PDT)
Received: from ?IPv6:2620:15c:2c1:200:55c7:81e6:c7d8:94b? ([2620:15c:2c1:200:55c7:81e6:c7d8:94b])
        by smtp.gmail.com with ESMTPSA id t5sm29417119pfh.141.2019.04.25.10.50.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 10:50:04 -0700 (PDT)
Subject: Re: RFC: zero copy recv()
To:     Maxim Uvarov <maxim.uvarov@linaro.org>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <CAD8XO3atijveUR0irCM2z3hsr8Rm9piwTbBp0NTwvzJt9+MHdw@mail.gmail.com>
 <d0c9c052-6153-6336-f296-15ad5611f21b@gmail.com>
 <CAD8XO3b0m5Qn1Ey3gu3HPmcOanN-yjCYBJZEUEu754X=5jAtOA@mail.gmail.com>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <77665188-27f2-6567-9e0c-62c66d98f436@gmail.com>
Date:   Thu, 25 Apr 2019 10:50:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAD8XO3b0m5Qn1Ey3gu3HPmcOanN-yjCYBJZEUEu754X=5jAtOA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/25/19 1:01 AM, Maxim Uvarov wrote:
> On Wed, 24 Apr 2019 at 18:59, Eric Dumazet <eric.dumazet@gmail.com> wrote:
>>
>>
>>
>> On 04/23/2019 11:23 PM, Maxim Uvarov wrote:
>>> Hello,
>>>
>>> On different conferences I see that people are trying to accelerate
>>> network with putting packet processing with protocol level completely
>>> to user space. It might be DPDK, ODP or AF_XDP  plus some network
>>> stack on top of it. Then people are trying to test this solution with
>>> some existence applications. And in better way do not modify
>>> application binaries and just LD_PRELOAD sockets syscalls (recv(),
>>> sendto() and etc). Current recv() expects that application allocates
>>> memory and call will "copy" packet to that memory. Copy per packet is
>>> slow.  Can we consider about implementing zero copy API calls
>>> friendly? Can this change be accepted to kernel?
>>
> 
> Hello Eric, thanks for responding.
> 
>> Generic zero copy is hard.
>>
> 
> yes that is true.
> 
>> As soon as you have multiple consumers in different domains for the data,
>> you need some kind of multiplexing, typically using hardware capabilities.
>>
>> For TCP, we implemented zero copy last year, which works quite well
>> on x86 if your network uses MTU of 4096+headers.
>>
>> tools/testing/selftests/net/tcp_mmap.c  reaches line rate (100Gbit) on
>> a single TCP flow, if using a NIC able to perform header split.
>>
> 
> That is great work. But isn't there context switches on
> getsockopt(TCP_ZEROCOPY_RECEIVE) and read() per packet?

No, since in many cases you actually know how many bytes are expected to be received.

SO_RCVLOWAT can be used by the application to tell the kernel :

- Please send me an EPOLLIN only when you have at least XXXXXX bytes available in receive queue.

> 
> I played with AF_XDP where one core can be isolated and do polling of
> umem pool memory and some other core can do softirq processing.
> And polling of umem is really fast - about 96ns on 2.5Ghz x86 laptop
> and no context switches on umem polling core.

Sure, but again this is very far from being 'generic', let say if you want to reuse TCP stack...

> 
> But in general for tcp_mmap.c code if getsockopt()+read() will be
> changed to one zero copy call, something like recvmsg_zc() then it can
> be LD_PRELOADED.
> mmap() can be also moved under socket creation to simplify api. Does
> it look reasonable?

Honestly I prefer not having to play games like that.

They are many subtle issues there really.

> 
>> But the model is not to run a legacy application with some LD_PRELOAD
>> hack/magic, sorry.
>>
> More likely that legacy applications will like to use zero copy
> networking. Once api will be stable they will support it, especially
> if api can be used with minimal changes for apps.
> Than it will be quite easy to LD_PRELOAD hack or change application to
> use some other IP stack.
> 
> Maxim.
> 
