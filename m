Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E03FC04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 20:47:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08822260CC
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 20:47:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NzfStkHq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbfEaUre (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 16:47:34 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:37919 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726695AbfEaUre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 16:47:34 -0400
Received: by mail-it1-f196.google.com with SMTP id h9so3250075itk.3
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2019 13:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IRpwbW094OnH6umHCwQlKPhM3hpX6SvgnfjHic143gQ=;
        b=NzfStkHq0nkMo+SQp+KB/exvjNcPVOvISq6eJknDst/NZVZpKcqHgITyDIN1vsKsyV
         8OjIkYPmO6YCREB9IeRwsRx0V72d//Z3u4cnNagkgUKKtTpuznSNCJD8oe9nuCP7SpmM
         jy5Fq/Y8TDI5btRgQwOEsHlWVDU7sPv7KnU0pq/FZZUXfebygU7vjjVYLszBlHoOfB0g
         NTj+2GhyUPDb+2opYTXoym0vNjjnN+GezroevkGF2HWj3we4Ijkr9xq+I7/9fxwnfQTG
         bEkiSgEbV+ukcT8RYnzk6jtI9Cxo7xjZ8HheemOk/tx09ah7zR8OU5pTwZJZyErWTOq7
         4Lcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IRpwbW094OnH6umHCwQlKPhM3hpX6SvgnfjHic143gQ=;
        b=IukDEZCIeIZDwyVgDt2TotnqdLxP84H6uBdl3kE1dUh5jHdR4N2Q5/0F6HRRMkoOIW
         AyhylbJ37a1j4DrUfO/qxMRT0kYfVHYoGqMUy42P4Ws0qdpbRqd7twKHTgS6NJg7o3xB
         0a4IM+JPt9yGd8KNIGuIpuFOiRiGuLCkLB3XV5NZ+jUprMJGvRMYGE5pfFygCH8UfahQ
         QLB+uq2tq99OwNj8Rwn6y/yGO5qMMpazoOq+Kp/3UpiNYPwWjXmxqXA8D5caVI/yoq8j
         xkFsD0Bzwa10HYN6EXNMTyjU0OQyoqCIZ+bIah9YZv0ExfSL6DgPd4yZtNybZ9+9fcX0
         cNaw==
X-Gm-Message-State: APjAAAVmr+UahU8H2tCIkp9C+z5nE4riVrAMI0wNhn+AzFCzOTnE2/AI
        tlVeTjkmGQFQ9fQ7l+TzJegqTA==
X-Google-Smtp-Source: APXvYqxMwgapovXvtTiMAmYy3K2/KLt39IROipPv8qWsPS7pwqaEQ4P+f4PszMxyXxk6DGk15dn94w==
X-Received: by 2002:a24:378b:: with SMTP id r133mr8135816itr.154.1559335653390;
        Fri, 31 May 2019 13:47:33 -0700 (PDT)
Received: from [172.22.22.26] (c-71-195-29-92.hsd1.mn.comcast.net. [71.195.29.92])
        by smtp.googlemail.com with ESMTPSA id x11sm2327554ion.10.2019.05.31.13.47.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 May 2019 13:47:32 -0700 (PDT)
Subject: Re: [PATCH v2 00/17] net: introduce Qualcomm IPA driver
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Dan Williams <dcbw@redhat.com>, David Miller <davem@davemloft.net>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        evgreen@chromium.org, Ben Chan <benchan@google.com>,
        Eric Caruso <ejcaruso@google.com>, cpratapa@codeaurora.org,
        syadagir@codeaurora.org,
        Subash Abhinov Kasiviswanathan <subashab@codeaurora.org>,
        abhishek.esse@gmail.com, Networking <netdev@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-soc@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm@vger.kernel.org
References: <20190531035348.7194-1-elder@linaro.org>
 <e75cd1c111233fdc05f47017046a6b0f0c97673a.camel@redhat.com>
 <065c95a8-7b17-495d-f225-36c46faccdd7@linaro.org>
 <CAK8P3a05CevRBV3ym+pnKmxv+A0_T+AtURW2L4doPAFzu3QcJw@mail.gmail.com>
From:   Alex Elder <elder@linaro.org>
Message-ID: <a28c5e13-59bc-144d-4153-9d104cfa9188@linaro.org>
Date:   Fri, 31 May 2019 15:47:31 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a05CevRBV3ym+pnKmxv+A0_T+AtURW2L4doPAFzu3QcJw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/31/19 2:19 PM, Arnd Bergmann wrote:
> On Fri, May 31, 2019 at 6:36 PM Alex Elder <elder@linaro.org> wrote:
>> On 5/31/19 9:58 AM, Dan Williams wrote:
>>> On Thu, 2019-05-30 at 22:53 -0500, Alex Elder wrote:
>>>
>>> My question from the Nov 2018 IPA rmnet driver still stands; how does
>>> this relate to net/ethernet/qualcomm/rmnet/ if at all? And if this is
>>> really just a netdev talking to the IPA itself and unrelated to
>>> net/ethernet/qualcomm/rmnet, let's call it "ipa%d" and stop cargo-
>>> culting rmnet around just because it happens to be a net driver for a
>>> QC SoC.
>>
>> First, the relationship between the IPA driver and the rmnet driver
>> is that the IPA driver is assumed to sit between the rmnet driver
>> and the hardware.
> 
> Does this mean that IPA can only be used to back rmnet, and rmnet
> can only be used on top of IPA, or can or both of them be combined
> with another driver to talk to instead?

No it does not mean that.

As I understand it, one reason for the rmnet layer was to abstract
the back end, which would allow using a modem, or using something
else (a LAN?), without exposing certain details of the hardware.
(Perhaps to support multiplexing, etc. without duplicating that
logic in two "back-end" drivers?)

To be perfectly honest, at first I thought having IPA use rmnet
was a cargo cult thing like Dan suggested, because I didn't see
the benefit.  I now see why one would use that pass-through layer
to handle the QMAP features.

But back to your question.  The other thing is that I see no
reason the IPA couldn't present a "normal" (non QMAP) interface
for a modem.  It's something I'd really like to be able to do,
but I can't do it without having the modem firmware change its
configuration for these endpoints.  My access to the people who
implement the modem firmware has been very limited (something
I hope to improve), and unless and until I can get corresponding
changes on the modem side to implement connections that don't
use QMAP, I can't implement such a thing.

>> Currently the modem is assumed to use QMAP protocol.  This means
>> each packet is prefixed by a (struct rmnet_map_header) structure
>> that allows the IPA connection to be multiplexed for several logical
>> connections.  The rmnet driver parses such messages and implements
>> the multiplexed network interfaces.
>>
>> QMAP protocol can also be used for aggregating many small packets
>> into a larger message.  The rmnet driver implements de-aggregation
>> of such messages (and could probably aggregate them for TX as well).
>>
>> Finally, the IPA can support checksum offload, and the rmnet
>> driver handles providing a prepended header (for TX) and
>> interpreting the appended trailer (for RX) if these features
>> are enabled.
>>
>> So basically, the purpose of the rmnet driver is to handle QMAP
>> protocol connections, and right now that's what the modem provides.
> 
> Do you have any idea why this particular design was picked?

I don't really.  I inherited it.  Early on, when I asked about
the need for QMAP I was told it was important because it offered
certain features, but at that time I was somewhat new to the code
and didn't have the insight to judge the merits of the design.
Since then I've mostly just accepted it and concentrated on
improving the IPA driver.

> My best guess is that it evolved organically with multiple
> generations of hardware and software, rather than being thought
> out as a nice abstraction layer. If the two are tightly connected,
> this might mean that what we actually want here is to reintegrate
> the two components into a single driver with a much simpler
> RX and TX path that handles the checksumming and aggregation
> of data packets directly as it passes them from the network
> stack into the hardware.

In general, I agree.  And Dan suggested combining the rmnet
and IPA drivers into a single driver when I posted the RFC
code last year.  There's still the notion of switching back
ends that I mentioned earlier; if that's indeed an important
feature it might argue for keeping rmnet as a shim layer.
But I'm really not the person to comment on this.  Someone
(Subash?) from Qualcomm might be able to provide better answers.

> Always passing data from one netdev to another both ways
> sounds like it introduces both direct CPU overhead, and
> problems with flow control when data gets buffered inbetween.

My impression is the rmnet driver is a pretty thin layer,
so the CPU overhead is probably not that great (though
deaggregating a message is expensive).  I agree with you
on the flow control.

> The intermediate buffer here acts like a router that must
> pass data along or randomly drop packets when the consumer
> can't keep up with the producer.

I haven't reviewed the rmnet code in any detail, but you
may be right.

					-Alex

> 
>         Arnd
> 

