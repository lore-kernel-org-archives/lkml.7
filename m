Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46524C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 17:03:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11AF320896
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 17:03:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hqQNwaEa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731354AbfFLRD1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 13:03:27 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33649 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730565AbfFLRD0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 13:03:26 -0400
Received: by mail-pl1-f193.google.com with SMTP id c14so604232plo.0;
        Wed, 12 Jun 2019 10:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mvhLlnddcybxUcwjK6AI3AmyWdGVpe5T8b6TCJ/Tv6U=;
        b=hqQNwaEargI8vwsUbeDJDaCEDha13sC18kj75HoqJxxDfTAdQASiMkUmJqAkp2eQ4F
         fUCjK0NtKYKpmMNaljwS49omWB4RZF8WtK1jiQ7NbyfDpxJqYp0xbp0EMCyf9MDBgF11
         JSyXHPSz5my+KHu7jVYJ1sAmHoS8iv5dkRk6Dzjlu3acURgVSYcisaMqaCXnhne+hqrG
         nayvioE9PPpR+vFvieJrUFWj7tVrSrHfrqXalUZ+hBSLZDO1QUeRPwLPhFSLRYcp8Cy7
         Z1W2yFWf4sTKb0xgTRgP+cFwLgK/Jypw4GKoWnlzsDU90pNMxW/xtajhIeRAJs5M6clR
         CjZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mvhLlnddcybxUcwjK6AI3AmyWdGVpe5T8b6TCJ/Tv6U=;
        b=mGkxZCUeIdqWz2lEgtd6pP/NqPW8q+ytBmgQ6ffQLFM3Ut9/JP2j5uaL4FJM9lw6Cm
         y3i743CScyj/NUF4cwt1YPP03K3tA2m0BgII/tz71onvI/9Cl6vjRsVSDPmMR6Q1rBFG
         4Psca1rYpG7s6Phaqua7muwmyPETbdIwCR6j+qu8B1+Z4U9RZmzC3vMU2H53tOKsb0nS
         RucEpknhya0PS/RGfvvh/0gPaprls9NdHwCar6TrSWhYy9ElsCD9nUQhgwnZOVtX0Eqd
         A7l9nkwcXibKQV3c6NxakNWaAivxbXk2TL+RkbSytq6UxjE6Q/cWC86LCREAZyZ5sy0p
         +MNQ==
X-Gm-Message-State: APjAAAXlV+dBWQnxw53Bc6P7wSebqbyZA1+Rcmfi8D2J+vNSFitIiqAu
        ZAtETNQvxsJrREbvyLVRijE=
X-Google-Smtp-Source: APXvYqz5LD2x5u+J8gFcaAofaOK0QY2JGKWGnOBCCaJxFq71mmAnINsx6CAETkZ2FHLAjod/Ks+Wsg==
X-Received: by 2002:a17:902:ac98:: with SMTP id h24mr75952097plr.79.1560359005830;
        Wed, 12 Jun 2019 10:03:25 -0700 (PDT)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id b15sm170225pff.31.2019.06.12.10.03.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Jun 2019 10:03:25 -0700 (PDT)
Subject: Re: [RESEND PATCH v1 1/5] of/platform: Speed up
 of_find_device_by_node()
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Sandeep Patil <sspatil@android.com>,
        Saravana Kannan <saravanak@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
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
 <20190612142159.GA11563@kroah.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <a63ba5a8-cfe7-662b-5aee-e4c1aef982e7@gmail.com>
Date:   Wed, 12 Jun 2019 10:03:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190612142159.GA11563@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/12/19 7:21 AM, Greg Kroah-Hartman wrote:
> On Wed, Jun 12, 2019 at 07:53:39AM -0600, Rob Herring wrote:
>> On Tue, Jun 11, 2019 at 3:52 PM Sandeep Patil <sspatil@android.com> wrote:
>>>
>>> On Tue, Jun 11, 2019 at 01:56:25PM -0700, 'Saravana Kannan' via kernel-team wrote:
>>>> On Tue, Jun 11, 2019 at 8:18 AM Frank Rowand <frowand.list@gmail.com> wrote:
>>>>>
>>>>> Hi Saravana,
>>>>>
>>>>> On 6/10/19 10:36 AM, Rob Herring wrote:
>>>>>> Why are you resending this rather than replying to Frank's last
>>>>>> comments on the original?
>>>>>
>>>>> Adding on a different aspect...  The independent replies from three different
>>>>> maintainers (Rob, Mark, myself) pointed out architectural issues with the
>>>>> patch series.  There were also some implementation issues brought out.
>>>>> (Although I refrained from bringing up most of my implementation issues
>>>>> as they are not relevant until architecture issues are resolved.)
>>>>
>>>> Right, I'm not too worried about the implementation issues before we
>>>> settle on the architectural issues. Those are easy to fix.
>>>>
>>>> Honestly, the main points that the maintainers raised are:
>>>> 1) This is a configuration property and not describing the device.
>>>> Just use the implicit dependencies coming from existing bindings.
>>>>
>>>> I gave a bunch of reasons for why I think it isn't an OS configuration
>>>> property. But even if that's not something the maintainers can agree
>>>> to, I gave a concrete example (cyclic dependencies between clock
>>>> provider hardware) where the implicit dependencies would prevent one
>>>> of the devices from probing till the end of time. So even if the
>>>> maintainers don't agree we should always look at "depends-on" to
>>>> decide the dependencies, we still need some means to override the
>>>> implicit dependencies where they don't match the real dependency. Can
>>>> we use depends-on as an override when the implicit dependencies aren't
>>>> correct?
>>>>
>>>> 2) This doesn't need to be solved because this is just optimizing
>>>> probing or saving power ("we should get rid of this auto disabling"):
>>>>
>>>> I explained why this patch series is not just about optimizing probe
>>>> ordering or saving power. And why we can't ignore auto disabling
>>>> (because it's more than just auto disabling). The kernel is currently
>>>> broken when trying to use modules in ARM SoCs (probably in other
>>>> systems/archs too, but I can't speak for those).
>>>>
>>>> 3) Concerns about backwards compatibility
>>>>
>>>> I pointed out why the current scheme (depends-on being the only source
>>>> of dependency) doesn't break compatibility. And if we go with
>>>> "depends-on" as an override what we could do to keep backwards
>>>> compatibility. Happy to hear more thoughts or discuss options.
>>>>
>>>> 4) How the "sync_state" would work for a device that supplies multiple
>>>> functionalities but a limited driver.
>>>
>>> <snip>
>>> To be clear, all of above are _real_ problems that stops us from efficiently
>>> load device drivers as modules for Android.
>>>
>>> So, if 'depends-on' doesn't seem like the right approach and "going back to
>>> the drawing board" is the ask, could you please point us in the right
>>> direction?
>>
>> Use the dependencies which are already there in DT. That's clocks,
>> pinctrl, regulators, interrupts, gpio at a minimum. I'm simply not
>> going to accept duplicating all those dependencies in DT. The downside
>> for the kernel is you have to address these one by one and can't have
>> a generic property the driver core code can parse. After that's in
>> place, then maybe we can consider handling any additional dependencies
>> not already captured in DT. Once all that is in place, we can probably
>> sort device and/or driver lists to optimize the probe order (maybe the
>> driver core already does that now?).
>>
>> Get rid of the auto disabling of clocks and regulators in
>> late_initcall. It's simply not a valid marker that boot is done when
>> modules are involved. We probably can't get rid of it as lot's of
>> platforms rely on that, so it will have to be opt out. Make it the
>> platform's responsibility for ensuring a consistent state.
>>
>> Perhaps we need a 'boot done' or 'stop deferring probe' trigger from
>> userspace in order to make progress if dependencies are missing.
> 
> People have tried to do this multiple times, and you never really know
> when "boot is done" due to busses that have discoverable devices and
> async probing of other busses.
> 
> You do know "something" when you pivot to a new boot disk, and when you
> try to load init, but given initramfs and the fact that modules are
> usually included on them, that's not really a good indication that
> anything is "finished".
> 
> I don't want userspace to be responsible for telling the kernel, "hey
> you should be finished now!", as that's an async notification that is
> going to be ripe for problems.
> 
> I really like the "depends-on" information, as it shows a topology that
> DT doesn't seem to be able to show today, yet we rely on it in the
> kernel with the whole deferred probing mess.  To me, there doesn't seem
> to be any other way to properly "know" this.

Rob pointed out (above) the dependencies that are already contained in
devicetree.  Those are real hardware descriptions that have to be
correct or the devices will not use the hardware that they "depend on"
(thus an incorrect hardware description _also_ results in the resource
that is not described not actually being a dependency).

If you add a second set of properties purely to list dependencies then
the second set of dependencies is likely to have latent errors that are
not initially detected (when the property is first introduced) because
the proper resources just happen to be available by sheer chance.  Then
a later change in boot order resulting from a code change or configuration
change can expose that latent error.

A second set of dependency properties is making boot more fragile.

-Frank

> 
>> Or
>> maybe just some timeout would be sufficient. I think this is probably
>> more useful for development than in a shipping product. Even if you
>> could fallback to polling mode instead of interrupts for example, I
>> doubt you would want to in a product.
> 
> timeouts suck.  And do not work for shipping products.  I want a device
> with 100 modules that relys on DT to be able to boot just as fast as a
> laptop with 100 modules that has all of the needed dependancies
> described today in their bus topologies, because they used sane hardware
> (i.e. PCI and ACPI).  Why hurt embedded people just because their
> hardware relies on a system where you have to loop for long periods of
> time because DT can not show the topology correctly?
> 
>> You should also keep in mind that everything needed for a console has
>> to be built in. Maybe Android can say the console isn't needed, but in
>> general we can't.
> 
> What does a console have to do with any of this?
> 
> confused,
> 
> greg k-h
> 

