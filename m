Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73D47C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 16:21:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36B3B20663
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 16:21:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tPmfrySU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732016AbfFXQVc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 12:21:32 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:42082 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726686AbfFXQVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 12:21:31 -0400
Received: by mail-io1-f67.google.com with SMTP id u19so2366872ior.9
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 09:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DTdhMvHGSpRSYv+O4zZF8FaJwPrfZLTTyd9vaWKATdY=;
        b=tPmfrySUrHFTfHEWGy9TrC/IHOCSSqqAIwzEUzU+Rz7NrirPaY1DvhgyqBPm2cwW+9
         UszyhOghqLy1knpjHUDSI3bgA4cBbr3rqbwCk2lUXIvEE35Gic/adiiZp/uTcMZG8Wwn
         EXVZO6hFXRSiquGOh2WfyVBqY5Ios8VVce31ZgSOipQYGpxtdq6do7A/39NgNSX9Ec2E
         FzfUUsilUBEWcu6Ez6QsIHjePKYvueexIbvhtkxV/6i+g+vEGGvpYyx3iTTKxiC5SveA
         54bZHa7LZzYAWRacyaU/IG+gZo2uuB5bNf6q/f3jOf74y0xIWPb2aV0oAO2DXHk2WKcB
         4YWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DTdhMvHGSpRSYv+O4zZF8FaJwPrfZLTTyd9vaWKATdY=;
        b=PDzy6JrBoeSyFZS31GJh7yL3dyMTydNFp6y0lCliCij11ZRMgcY0m4OKXynzS/HnHx
         VUcM2+GhuSFeBd7A0Q9zOZmUmz35Y/i7KISrrC0drfJ4VhHUWFPUnhbOJ/JgSvmLXF1x
         Rk9Be7r4ngHzPgm2/aq+xz70cak2h8OziDilF3weik7+1TyAdeiapl7F9ni1JeEFlR9e
         iNgM+mMBBYn+Y5+uyhrrQX897RUU531wT0nvPw5FET3WL1ffzZKf06LvCUCBm91zW3QH
         9Si/9Gctr0oLPVqOZWUjgnM+OWIAhXhW+4GDWJwBBDAaz/aDjgYgGE4FqxwZ7IVmrh3f
         91ZA==
X-Gm-Message-State: APjAAAUWAf6Sw3gc40YMEkIfPrIUReyG21C03JR4m4GghRN83YVhwQh7
        jsbTKEerPFDN1+Wc0ZtNeGXF5w==
X-Google-Smtp-Source: APXvYqwdIdy6gdFnh0AoofirCVmNPT2cDDVwmDZlJD8dTb+hXiv59U6tCJDzC8nEAkMRQg/1EV+S1A==
X-Received: by 2002:a6b:b7d5:: with SMTP id h204mr6073067iof.188.1561393290206;
        Mon, 24 Jun 2019 09:21:30 -0700 (PDT)
Received: from [172.22.22.26] (c-71-195-29-92.hsd1.mn.comcast.net. [71.195.29.92])
        by smtp.googlemail.com with ESMTPSA id v13sm14220933ioq.13.2019.06.24.09.21.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2019 09:21:29 -0700 (PDT)
Subject: Re: [PATCH v2 00/17] net: introduce Qualcomm IPA driver
To:     Johannes Berg <johannes@sipsolutions.net>,
        Arnd Bergmann <arnd@arndb.de>, Dan Williams <dcbw@redhat.com>
Cc:     Subash Abhinov Kasiviswanathan <subashab@codeaurora.org>,
        abhishek.esse@gmail.com, Ben Chan <benchan@google.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        cpratapa@codeaurora.org, David Miller <davem@davemloft.net>,
        DTML <devicetree@vger.kernel.org>,
        Eric Caruso <ejcaruso@google.com>, evgreen@chromium.org,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-soc@vger.kernel.org, Networking <netdev@vger.kernel.org>,
        syadagir@codeaurora.org
References: <380a6185-7ad1-6be0-060b-e6e5d4126917@linaro.org>
 <a94676381a5ca662c848f7a725562f721c43ce76.camel@sipsolutions.net>
 <CAK8P3a0kV-i7BJJ2X6C=5n65rSGfo8fUiC4J_G-+M8EctYKbkg@mail.gmail.com>
 <fc0d08912bc10ad089eb74034726308375279130.camel@redhat.com>
 <36bca57c999f611353fd9741c55bb2a7@codeaurora.org>
 <153fafb91267147cf22e2bf102dd822933ec823a.camel@redhat.com>
 <CAK8P3a2Y+tcL1-V57dtypWHndNT3eDJdcKj29c_v+k8o1HHQig@mail.gmail.com>
 <f4249aa5f5acdd90275eda35aa16f3cfb29d29be.camel@redhat.com>
 <CAK8P3a2nzZKtshYfomOOSYkqx5HdU15Wr9b+3va0B1euNhFOAg@mail.gmail.com>
 <dbb32f185d2c3a654083ee0a7188379e1f88d899.camel@sipsolutions.net>
 <e6ba8a9063e63506c0b88a70418d74ca4efe85cd.camel@sipsolutions.net>
 <850eed1d-0fec-c396-6e91-b5f1f8440ded@linaro.org>
 <967604dd8d466a99b865649174f8b9cd34b2560e.camel@sipsolutions.net>
From:   Alex Elder <elder@linaro.org>
Message-ID: <cf4e990c-1a59-802b-7565-4d7c876416b9@linaro.org>
Date:   Mon, 24 Jun 2019 11:21:28 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <967604dd8d466a99b865649174f8b9cd34b2560e.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/18/19 1:48 PM, Johannes Berg wrote:
> Just to add to Dan's response, I think he's captured our discussions and
> thoughts well.
> 
>> First, a few terms (correct or improve as you like):
> 
> Thanks for defining, we don't do that nearly often enough.
> 
>> - WWAN device is a hardware device (like IPA) that presents a
>>   connection between AP and modem, and presents an interface
>>   that allows the use of that connection to be managed.
> 
> Yes. But I was actually thinking of a "wwan_dev" to be a separate
> structure, not *directly* owned by a single driver and used to represent
> the hardware like a (hypothetical) "struct ipa_dev".

I think you're talking about creating a coordination interface
that allows multiple drivers to interact with a WWAN device,
which might implement several independent features.

>> - WWAN netdevice represents a Linux network interface, with its
>>   operations and queues, etc., but implements a standardized
>>   set of WWAN-specific operations.  It represents a logical
>> ' channel whose data is multiplexed over the WWAN device.
> 
> I'm not sure I'd asy it has much WWAN-specific operations? But yeah, I
> guess it might.

I want to withdraw this notion of a "WWAN netdevice"...

>> - WWAN channel is a user space abstraction that corresponds
>>   with a WWAN netdevice (but I'm not clear on all the ways
>>   they differ or interact).
> 
> As Dan said, this could be a different abstraction than a netdevice,
> like a TTY, etc.

Right, I get that now.

. . .

>> - Which WWAN channel attributes must be set *before* the
>>   channel is activated, and can't be changed?  Are there any
>>   that can be changed dynamically?
> 
> It's a good question. I threw a "u32 pdn" in there, but I'm not actually
> sure that's what you *really* need?
> 
> Maybe the modem and userspace just agree on some arbitrary "session
> identifier"? Dan mentions "MUX ID" or "MBIM Session ID", maybe there
> really is no good general term for this and we should just call it a
> "session identifier" and agree that it depends on the control protocol
> (MBIM vs. QMI vs. ...)?
> 
>> And while the whole point of this is to make things generic,
>> it might be nice to have a way to implement a new feature
>> before it can be "standardized".
> 
> Not sure I understand this?

I'm talking about a way to experiment with new functionality in a
way that's explicitly not part of the interface.  But doing that
isn't necessary and it's probably not a good idea anyway.

> FWIW, I actually came to this because we want to upstream a driver for
> an Intel modem, but ... can't really make up our mind on whether or not
> to use VLAN tags, something like rmnet (but we obviously cannot use
> rmnet, so that'd be another vendor specific interface like rmnet), or
> sysfs, or any of the other methods we have today ... :-)

OK cool then we have some common needs.   Let's get this defined so
we can use it for both!

					-Alex

> 
> johannes
> 

