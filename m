Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2789C28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 20:03:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6FCD2411C
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 20:03:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B8qh1Ld1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726311AbfE2UDZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 16:03:25 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:37707 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbfE2UDZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 16:03:25 -0400
Received: by mail-oi1-f195.google.com with SMTP id i4so2747127oih.4
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 13:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wGYaW+Hbd7AIoyclHFi63uNBzsUxP8AhdA4OguMOUvU=;
        b=B8qh1Ld1yMoWv42IjspSyHyrdNKC/Oak8TrNecsHfG/hEFJqdhKoXaNDznyMAbR8TY
         JDudaudBS400/nz0t2T89CvhNY7aY48OZ92qeMBJ2L4TrkqBWlsOa7qb8O6EAmyizV/w
         h5/z2hq1cYpvnFgrT69H3jABNHO1ao+JnuspAqa7ayvj56s9jXAt3TxfO3PU0pVarzNR
         b3kt9GEmlrh9w000Qg3vprCJNFsmy4fHFQHaTcAXpOPZQwK+uH/mv99EEI5hOTSNfaJE
         uxLWN2jt7vTQhYuPaCiuJ8fFW6Y8JCBUMdOJppnbQMSCuxX7rGB2slGjawAtJHnDCihn
         8D6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wGYaW+Hbd7AIoyclHFi63uNBzsUxP8AhdA4OguMOUvU=;
        b=a9HbtDuf8YTrX98R7QZzqTin6qVSrBBNtta4QJtXtZnThoKezkJOZ15zIR4kq161UH
         At/x6iYs3xEaWvwRIe4AOUqRxuooH76cjcdSQ+4XYd2egcu8ZNuYU+/RlE+aH8utW+yN
         Rd4aQkGI4QlAf2iUAdPHiXYC08ukQefz6jpQdrLYhFjEu6k6oyTEyXrVzDoDJF2cedFv
         8f6FHQSLK/mSshPgdF4OD1KbZpd8ljCQ8BaPBzHN2hIWanZNOg2kDWlshu4qQpC0XUMu
         moc4BzVyw5eCA2GFWHKo6u/zcxa+Yzq84NGSQYXNMUjmeZ8aGHdJ+B3ADjqoRwrhCUqE
         q3bw==
X-Gm-Message-State: APjAAAX8QaTEjHOiCAQXtvbjyywI8kU48k7O0WkyHH93K1Wx0O0f46ru
        BcuJ5r+ZP1+FBqqfMfmCFFXusKwvY2fBWxJHDlYylg==
X-Google-Smtp-Source: APXvYqz/ZWCizrBFHM4Cq1/ncU1oZvTHMFn6u0WZv6z/Jxsk+gNST636u5zULqKhQ67c/cd+0e4ZjxI0UTLTyU4JRZ8=
X-Received: by 2002:aca:ec0f:: with SMTP id k15mr21599oih.43.1559160199272;
 Wed, 29 May 2019 13:03:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190524010117.225219-1-saravanak@google.com> <CAGETcx8MY7Xhc4YjCcO9TH6X9Sse4Mg2Wi6vjau5T6d4C-itFQ@mail.gmail.com>
In-Reply-To: <CAGETcx8MY7Xhc4YjCcO9TH6X9Sse4Mg2Wi6vjau5T6d4C-itFQ@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Wed, 29 May 2019 13:02:43 -0700
Message-ID: <CAGETcx-xWt50zb0JQrDRpqxL8i-PAV4j4_rPLFrJantuyxAxnw@mail.gmail.com>
Subject: Re: [PATCH v1 0/5] Solve postboot supplier cleanup and optimize probe ordering
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sending again because email client somehow reverted to HTML.
Frank, Rob, Mark,

Gentle reminder. I've replied to your emails spread across the
different patches in the series. Hoping they address your questions
and concerns. Please let me know what you think.

Thanks,
Saravana


On Wed, May 29, 2019 at 1:00 PM Saravana Kannan <saravanak@google.com> wrote:
>
> Frank, Rob, Mark,
>
> Gentle reminder. I've replied to your emails spread across the different patches in the series. Hoping they address your questions and concerns. Please let me know what you think.
>
> Thanks,
> Saravana
>
> On Thu, May 23, 2019 at 6:01 PM Saravana Kannan <saravanak@google.com> wrote:
>>
>> Add a generic "depends-on" property that allows specifying mandatory
>> functional dependencies between devices. Add device-links after the
>> devices are created (but before they are probed) by looking at this
>> "depends-on" property.
>>
>> This property is used instead of existing DT properties that specify
>> phandles of other devices (Eg: clocks, pinctrl, regulators, etc). This
>> is because not all resources referred to by existing DT properties are
>> mandatory functional dependencies. Some devices/drivers might be able
>> to operate with reduced functionality when some of the resources
>> aren't available. For example, a device could operate in polling mode
>> if no IRQ is available, a device could skip doing power management if
>> clock or voltage control isn't available and they are left on, etc.
>>
>> So, adding mandatory functional dependency links between devices by
>> looking at referred phandles in DT properties won't work as it would
>> prevent probing devices that could be probed. By having an explicit
>> depends-on property, we can handle these cases correctly.
>>
>> Having functional dependencies explicitly called out in DT and
>> automatically added before the devices are probed, provides the
>> following benefits:
>>
>> - Optimizes device probe order and avoids the useless work of
>>   attempting probes of devices that will not probe successfully
>>   (because their suppliers aren't present or haven't probed yet).
>>
>>   For example, in a commonly available mobile SoC, registering just
>>   one consumer device's driver at an initcall level earlier than the
>>   supplier device's driver causes 11 failed probe attempts before the
>>   consumer device probes successfully. This was with a kernel with all
>>   the drivers statically compiled in. This problem gets a lot worse if
>>   all the drivers are loaded as modules without direct symbol
>>   dependencies.
>>
>> - Supplier devices like clock providers, regulators providers, etc
>>   need to keep the resources they provide active and at a particular
>>   state(s) during boot up even if their current set of consumers don't
>>   request the resource to be active. This is because the rest of the
>>   consumers might not have probed yet and turning off the resource
>>   before all the consumers have probed could lead to a hang or
>>   undesired user experience.
>>
>>   Some frameworks (Eg: regulator) handle this today by turning off
>>   "unused" resources at late_initcall_sync and hoping all the devices
>>   have probed by then. This is not a valid assumption for systems with
>>   loadable modules. Other frameworks (Eg: clock) just don't handle
>>   this due to the lack of a clear signal for when they can turn off
>>   resources. This leads to downstream hacks to handle cases like this
>>   that can easily be solved in the upstream kernel.
>>
>>   By linking devices before they are probed, we give suppliers a clear
>>   count of the number of dependent consumers. Once all of the
>>   consumers are active, the suppliers can turn off the unused
>>   resources without making assumptions about the number of consumers.
>>
>> By default we just add device-links to track "driver presence" (probe
>> succeeded) of the supplier device. If any other functionality provided
>> by device-links are needed, it is left to the consumer/supplier
>> devices to change the link when they probe.
>>
>>
>> Saravana Kannan (5):
>>   of/platform: Speed up of_find_device_by_node()
>>   driver core: Add device links support for pending links to suppliers
>>   dt-bindings: Add depends-on property
>>   of/platform: Add functional dependency link from "depends-on" property
>>   driver core: Add sync_state driver/bus callback
>>
>>  .../devicetree/bindings/depends-on.txt        |  26 +++++
>>  drivers/base/core.c                           | 106 ++++++++++++++++++
>>  drivers/of/platform.c                         |  75 ++++++++++++-
>>  include/linux/device.h                        |  24 ++++
>>  include/linux/of.h                            |   3 +
>>  5 files changed, 233 insertions(+), 1 deletion(-)
>>  create mode 100644 Documentation/devicetree/bindings/depends-on.txt
>>
>> --
>> 2.22.0.rc1.257.g3120a18244-goog
>>
