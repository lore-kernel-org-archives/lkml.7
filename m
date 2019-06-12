Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7812EC31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 16:07:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 430722173C
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 16:07:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qwMg9oFM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502068AbfFLQHP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 12:07:15 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:35656 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502009AbfFLQHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 12:07:13 -0400
Received: by mail-pl1-f193.google.com with SMTP id p1so6830083plo.2;
        Wed, 12 Jun 2019 09:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Hjw2bLzrSUuDXv8RXIsP/q2KDLq3UZ91ppuckVlhbyE=;
        b=qwMg9oFMu6eDINyZSzPc+WJEqL1VZEJki4LNhfBngkJn58Bx6WhmnAqAUB1+xSYZiD
         RcnD013DDMWDajUmPOmoIZxPUE42V1eQmhpV/KhjLdKigyVBfKzZiuoBcVec3IIO0w59
         LMr5R0fgx+MPtizsyNsalKYMxmTE8bqb/HetSdnKrKHBkZwVjJk1UjHnv62d9d/Youce
         PwyXgjZQ41fcyLPycsDQIyykQf9UdnPlNHP7kwVf2ArHEBIcrQR/YyEdC72HVwW2AtT+
         21q7pi8e4lQEsJMf+XRy9K+SAtFnwCMZdyyty/SHItWLL5gNor6iwM8Y7JlAaXwJbj1v
         HA9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Hjw2bLzrSUuDXv8RXIsP/q2KDLq3UZ91ppuckVlhbyE=;
        b=DegSREBDPRr9jMH9qG9+Kj948eQZaaS1IApzj3tXbWPZZNI9YytdAxEsmznMBO+uYn
         x+QrPplCw6sP0vQ4ETikNsOUhIqZpzoxK3hcRDyimMj+214kXg8z7xNLmIv+Anz3JH2r
         +P2I5bAqm7yU6TI8Hj3+vNGwIidzpcCsZ/Pz+vjwWzInBkeM22+5GEStrCOvGb0a6OWO
         Ble114m5YroermW3wzefcuJecxRet2qcCrdoBfevOAZd3ypL9sLVyAsROl2K+dDvzEye
         9SAZR+5u6tKK+YNd3Uf2RfBUpOpJYde+aAVjz9jmfYr1v9N1D8NOJGBWiUSzLIGC+axV
         imUQ==
X-Gm-Message-State: APjAAAV7VG8i+vF7ZlXxOaVpYV6xkdJdkugIv3ufYfTdB/xieSgpuGjK
        phXQ//h13O13oDRpX8uc6Q0=
X-Google-Smtp-Source: APXvYqyRLJ6c3B1ISIUlzj7Dk5f6zxvH8X8bjV2fzSuynVz27pCUqYTKSuGtgCOirU4NCbOsXW+dTw==
X-Received: by 2002:a17:902:f204:: with SMTP id gn4mr64254233plb.3.1560355633057;
        Wed, 12 Jun 2019 09:07:13 -0700 (PDT)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id n127sm17303290pga.57.2019.06.12.09.07.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Jun 2019 09:07:12 -0700 (PDT)
Subject: Re: [RESEND PATCH v1 1/5] of/platform: Speed up
 of_find_device_by_node()
To:     Rob Herring <robh+dt@kernel.org>,
        Sandeep Patil <sspatil@android.com>,
        Saravana Kannan <saravanak@google.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        David Collins <collinsd@codeaurora.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>
References: <20190604003218.241354-1-saravanak@google.com>
 <20190604003218.241354-2-saravanak@google.com>
 <CAL_JsqLWfNUJm23x+doJDwyuMLOvqWAnLKGQYcgVct-AyWb9LQ@mail.gmail.com>
 <570474f4-8749-50fd-5f72-36648ed44653@gmail.com>
 <CAGETcx8M3YkUBZ-e2LLfrbWgnMKMMNG5cv=p8MMmBe7ZyPJ7xw@mail.gmail.com>
 <20190611215242.GE212690@google.com>
 <CAL_Jsq+V9QUBpzmPyYjWe93-06-mpU=5JmUqvf-QsnuLxPnmUA@mail.gmail.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <75be9e83-4d56-6080-7011-0c79b70c8cb9@gmail.com>
Date:   Wed, 12 Jun 2019 09:07:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAL_Jsq+V9QUBpzmPyYjWe93-06-mpU=5JmUqvf-QsnuLxPnmUA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/12/19 6:53 AM, Rob Herring wrote:
> On Tue, Jun 11, 2019 at 3:52 PM Sandeep Patil <sspatil@android.com> wrote:
>>
>> On Tue, Jun 11, 2019 at 01:56:25PM -0700, 'Saravana Kannan' via kernel-team wrote:
>>> On Tue, Jun 11, 2019 at 8:18 AM Frank Rowand <frowand.list@gmail.com> wrote:
>>>>
>>>> Hi Saravana,
>>>>
>>>> On 6/10/19 10:36 AM, Rob Herring wrote:
>>>>> Why are you resending this rather than replying to Frank's last
>>>>> comments on the original?
>>>>
>>>> Adding on a different aspect...  The independent replies from three different
>>>> maintainers (Rob, Mark, myself) pointed out architectural issues with the
>>>> patch series.  There were also some implementation issues brought out.
>>>> (Although I refrained from bringing up most of my implementation issues
>>>> as they are not relevant until architecture issues are resolved.)
>>>
>>> Right, I'm not too worried about the implementation issues before we
>>> settle on the architectural issues. Those are easy to fix.
>>>
>>> Honestly, the main points that the maintainers raised are:
>>> 1) This is a configuration property and not describing the device.
>>> Just use the implicit dependencies coming from existing bindings.
>>>
>>> I gave a bunch of reasons for why I think it isn't an OS configuration
>>> property. But even if that's not something the maintainers can agree
>>> to, I gave a concrete example (cyclic dependencies between clock
>>> provider hardware) where the implicit dependencies would prevent one
>>> of the devices from probing till the end of time. So even if the
>>> maintainers don't agree we should always look at "depends-on" to
>>> decide the dependencies, we still need some means to override the
>>> implicit dependencies where they don't match the real dependency. Can
>>> we use depends-on as an override when the implicit dependencies aren't
>>> correct?
>>>
>>> 2) This doesn't need to be solved because this is just optimizing
>>> probing or saving power ("we should get rid of this auto disabling"):
>>>
>>> I explained why this patch series is not just about optimizing probe
>>> ordering or saving power. And why we can't ignore auto disabling
>>> (because it's more than just auto disabling). The kernel is currently
>>> broken when trying to use modules in ARM SoCs (probably in other
>>> systems/archs too, but I can't speak for those).
>>>
>>> 3) Concerns about backwards compatibility
>>>
>>> I pointed out why the current scheme (depends-on being the only source
>>> of dependency) doesn't break compatibility. And if we go with
>>> "depends-on" as an override what we could do to keep backwards
>>> compatibility. Happy to hear more thoughts or discuss options.
>>>
>>> 4) How the "sync_state" would work for a device that supplies multiple
>>> functionalities but a limited driver.
>>
>> <snip>
>> To be clear, all of above are _real_ problems that stops us from efficiently
>> load device drivers as modules for Android.
>>
>> So, if 'depends-on' doesn't seem like the right approach and "going back to
>> the drawing board" is the ask, could you please point us in the right
>> direction?
> 
> Use the dependencies which are already there in DT. That's clocks,
> pinctrl, regulators, interrupts, gpio at a minimum. I'm simply not
> going to accept duplicating all those dependencies in DT. The downside
> for the kernel is you have to address these one by one and can't have
> a generic property the driver core code can parse. After that's in
> place, then maybe we can consider handling any additional dependencies
> not already captured in DT. Once all that is in place, we can probably
> sort device and/or driver lists to optimize the probe order (maybe the
> driver core already does that now?).
> 
> Get rid of the auto disabling of clocks and regulators in
> late_initcall. It's simply not a valid marker that boot is done when
> modules are involved. We probably can't get rid of it as lot's of
> platforms rely on that, so it will have to be opt out. Make it the
> platform's responsibility for ensuring a consistent state.

Setting aside modules for one moment, why is there any auto disabling
of clocks and regulators in late initcall????  Deferred probe processing
does not begin until deferred_probe_initcall() sets
driver_deferred_probe_enable to true.  No late_initcall function
should ever depend on ordering with respect to any other late_initcall.
(And yes, I know that among various initcall levels, there have been
games played to get a certain amount of ordering, but that is at
best fragile.)

In addition to modules, devicetree overlays need to be considered.

Just as modules can result in a driver appearing after boot finishes,
overlays can result in new devicetree nodes (and thus dependencies)
appearing after boot finishes.

-Frank

> 
> Perhaps we need a 'boot done' or 'stop deferring probe' trigger from
> userspace in order to make progress if dependencies are missing. Or
> maybe just some timeout would be sufficient. I think this is probably
> more useful for development than in a shipping product. Even if you
> could fallback to polling mode instead of interrupts for example, I
> doubt you would want to in a product.
> 
> You should also keep in mind that everything needed for a console has
> to be built in. Maybe Android can say the console isn't needed, but in
> general we can't.
> 
> Rob
> .
> 

