Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21B1BC3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 21:30:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D84CD22CE8
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 21:30:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U+Vhg3eq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728551AbfHSVaH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 17:30:07 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36446 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728387AbfHSVaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 17:30:07 -0400
Received: by mail-pl1-f196.google.com with SMTP id f19so1169288plr.3;
        Mon, 19 Aug 2019 14:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Edh1Yz4E7w1NZ9Sx/az64PkqGgiFtT5zbUPva6pMUa4=;
        b=U+Vhg3eqCS8nYGf6OE4fQWuVplK/GpoiR0HhZrSjluWTaQkMqs6AqKkAL+J+8R5D5d
         Wf3by8+NH+lV14cy9Is5cm2e0XBgiYPPpATDpbx6YUTnE6xA28/ClC66sQGYP6qU/UU2
         62pu0HapDRSIkO79ygb8sjwWe2gPKc5PTPm6sIwtJ5Q27vga3NE4UgIEV9HPBCCjr22M
         GpKrgze0R0tPwEiAyMODt1/496Uir8Ehk+EYrLCp8WebRiX3OFMae0y8RRLNAQoyijhy
         CM+VQAkAzDbN/XxVkkBSsbN9sryEzlneyoNJtaClPRrMTKCUngLil2x0CXmyOtonSHTt
         hXbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Edh1Yz4E7w1NZ9Sx/az64PkqGgiFtT5zbUPva6pMUa4=;
        b=Ciqk19RAhFfmtW7PiXDDaBv51+eOQH9ggPRxqD9CHS/Pvn1WDePuOJA0vW0hZhUiHE
         hrWu0Wdg4jqy3nCW++f/v6hs5nkbwUSLftU+rHUeMywUQY2fI0rEA37CDlYrvwkfpki3
         uVzSaUDv7LSPDez0qV330Lr50d9kjJTq5fiaPlI8ks7LFOnOISg5nhD+rWFAF2z/79hW
         a2wpX9m3rpVRQicq9b1u3/66IlgXgTt1oMuW6nVQKhrE45Dc1AmS1IRnL0MVxdM6gqEs
         Cc4qzKkANq3OtHWNgQ4QZFH6racxfzY1b08jvUbh+kQc9PKBr5OESOAleEHfyDXWULB6
         PYsA==
X-Gm-Message-State: APjAAAXbwWtvEEuEGmIQ/6zmHdQGdg0oenO7vzPpkjJQeC+4YQW0uIR2
        WQa1KS3Y7yIyUr7S1zP9arc=
X-Google-Smtp-Source: APXvYqy0UQj7EgXtym2oSyuvkHVisZmXGSKvzoH1p1E/HNj3qg4yMA3qEOXZw54MOYNBVq8kBPMWbQ==
X-Received: by 2002:a17:902:d882:: with SMTP id b2mr24477208plz.66.1566250206210;
        Mon, 19 Aug 2019 14:30:06 -0700 (PDT)
Received: from [192.168.1.70] (c-73-231-235-122.hsd1.ca.comcast.net. [73.231.235.122])
        by smtp.gmail.com with ESMTPSA id v67sm29306052pfb.45.2019.08.19.14.30.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Aug 2019 14:30:05 -0700 (PDT)
Subject: Re: [PATCH v7 3/7] of/platform: Add functional dependency link from
 DT bindings
To:     Saravana Kannan <saravanak@google.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        David Collins <collinsd@codeaurora.org>,
        Android Kernel Team <kernel-team@android.com>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
References: <20190724001100.133423-1-saravanak@google.com>
 <20190724001100.133423-4-saravanak@google.com>
 <141d2e16-26cc-1f05-1ac0-6784bab5ae88@gmail.com>
 <CAGETcx-dVnLCRA+1CX47gtZgtwTcrN5KefpjMzh9OJB-BEnqyg@mail.gmail.com>
 <19c99a6e-51c3-68d7-d1d6-640aae754c14@gmail.com>
 <CAGETcx-XcXZq7YFHsFdzBDniQku9cxFUJL_vBoEKKhCH+cDKRw@mail.gmail.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <74931824-f8a1-0435-e00a-5b5cdbe8a8a2@gmail.com>
Date:   Mon, 19 Aug 2019 14:30:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAGETcx-XcXZq7YFHsFdzBDniQku9cxFUJL_vBoEKKhCH+cDKRw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/19/19 1:49 PM, Saravana Kannan wrote:
> On Mon, Aug 19, 2019 at 10:16 AM Frank Rowand <frowand.list@gmail.com> wrote:
>>
>> On 8/15/19 6:50 PM, Saravana Kannan wrote:
>>> On Wed, Aug 7, 2019 at 7:06 PM Frank Rowand <frowand.list@gmail.com> wrote:
>>>>
>>>> On 7/23/19 5:10 PM, Saravana Kannan wrote:
>>>>> Add device-links after the devices are created (but before they are
>>>>> probed) by looking at common DT bindings like clocks and
>>>>> interconnects.
>>
>>
>> < very big snip (lots of comments that deserve answers) >
>>
>>
>>>>
>>>> /**
>>>>  * of_link_property - TODO:
>>>>  * dev:
>>>>  * con_np:
>>>>  * prop:
>>>>  *
>>>>  * TODO...
>>>>  *
>>>>  * Any failed attempt to create a link will NOT result in an immediate return.
>>>>  * of_link_property() must create all possible links even when one of more
>>>>  * attempts to create a link fail.
>>>>
>>>> Why?  isn't one failure enough to prevent probing this device?
>>>> Continuing to scan just results in extra work... which will be
>>>> repeated every time device_link_check_waiting_consumers() is called
>>>
>>> Context:
>>> As I said in the cover letter, avoiding unnecessary probes is just one
>>> of the reasons for this patch. The other (arguably more important)
>>
>> Agree that it is more important.
>>
>>
>>> reason for this patch is to make sure suppliers know that they have
>>> consumers that are yet to be probed. That way, suppliers can leave
>>> their resource on AND in the right state if they were left on by the
>>> bootloader. For example, if a clock was left on and at 200 MHz, the
>>> clock provider needs to keep that clock ON and at 200 MHz till all the
>>> consumers are probed.
>>>
>>> Answer: Let's say a consumer device Z has suppliers A, B and C. If the
>>> linking fails at A and you return immediately, then B and C could
>>> probe and then figure that they have no more consumers (they don't see
>>> a link to Z) and turn off their resources. And Z could fail
>>> catastrophically.
>>
>> Then I think that this approach is fatally flawed in the current implementation.
> 
> I'm waiting to hear how it is fatally flawed. But maybe this is just a
> misunderstanding of the problem?

Fatally flawed because it does not handle modules that add a consumer
device when the module is loaded.


> 
> In the text below, I'm not sure if you mixing up two different things
> or just that your wording it a bit ambiguous. So pardon my nitpick to
> err on the side of clarity.

Please do nitpick.  Clarity is good.


> 
>> A device can be added by a module that is loaded.
> 
> No, in the example I gave, of_platform_default_populate_init() would
> add all 3 of those devices during arch_initcall_sync().

The example you gave does not cover all use cases.

There are modules that add devices when the module is loaded.  You can not
ignore systems using such modules.


> 
>>  In that case the device
>> was not present at late boot when the suppliers may turn off their resources.
> 
> In that case, the _drivers_ for those devices aren't present at late
> boot. So that they can't request to keep the resources on for their
> consumer devices. Since there are no consumer requests on resources,
> the suppliers turn off their resources at late boot (since there isn't
> a better location as of today). The sync_state() call back added in a
> subsequent patche in this series will provide the better location.

And the sync_state() call back will not deal with modules that add consumer
devices when the module is loaded, correct?


> 
>> (I am assuming the details since I have not reviewed the patches later in
>> the series that implement this part.)
>>
>> Am I missing something?
> 
> I think you are mixing up devices getting added/populated with drivers
> getting loaded as modules?

Only some modules add devices when they are loaded.  But these modules do
exist.

-Frank

> 
>> If I am wrong, then I'll have more comments for your review replies for
>> patches 2 and 3.
> 
> I'll wait for more review replies?
> 
> Thanks,
> Saravana
> 

