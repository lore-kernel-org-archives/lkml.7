Return-Path: <SRS0=wu79=TZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7E48C282E1
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 02:40:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C5652186A
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 02:40:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QlEikb33"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726585AbfEYCkR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 22:40:17 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42003 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726454AbfEYCkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 22:40:17 -0400
Received: by mail-pf1-f194.google.com with SMTP id r22so3478450pfh.9;
        Fri, 24 May 2019 19:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rpPcDfsm9QcHhqwUf8N2nz+nfTWan6Zw1RMMS1Dh3Tk=;
        b=QlEikb33F/jpc60NAxrp4xvdP3EYjC16/vZ3DN7DMjUGZkuEUw9XW2IqzomTa8aCmd
         WWHncu09yra7bVCgvfQ+ofjxQOFF6pfDXVwA0bkWUymg4EOnFp1JDJVfVVaQGJZVVB8z
         R+tm1ONaoa77MmZFovyY0votXmiQ9pxrqt1Sxllij1ijLxoe/Ep98YKuH+K76DvWBCdg
         pu9/1bf92Kj3T6AGmY3x+HaqawfrzwxKCJInTXr394ryyT1Qv7dxxJfItfjMqKw00iyP
         nbjedAx2oGyDxk5s2qZYkdfaaspv31XSwTh7uo7JbD1TrdypcX9HJospjGHSrrJSWD+5
         cMxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rpPcDfsm9QcHhqwUf8N2nz+nfTWan6Zw1RMMS1Dh3Tk=;
        b=YZfIq5WI+HSx1IcqG4Y30sjPpNmIM+0k8+oCexI0GV75r3yS8M8iwugv5qLrMkaNty
         7esAD9Bt72Vjehqesb/i4cRVcGP6zSn4qqENPGWsxb8lBOnkhe8pO4+Xm9K11P3KPQ1H
         53LYw7YD1wbKFA6a59s3zB2pe2Ua4x4z5DC9AnbYc2LY7trrF0ioC4UGXTv1w1ZvSG6n
         qXO3Yxq4cPJkXE13YNtAoTx1Es8MnN9jU+ELFGU91fcRFgdpFF7LF53hBPT1HbG/vqWo
         APktdpbcXDIJYmghs0pbsRo6ERm67AruNyCc8I0q0/TidGKz2ewWri8Jh+psPtNE/J7i
         SaMA==
X-Gm-Message-State: APjAAAX0jGcUocFRjRQq5YOgvT6q0OAXyizawFHMWtJPMeMXQ/5E4MCy
        ko9VFtoG7GaFYqpGZcGSE0k=
X-Google-Smtp-Source: APXvYqyyGGRAmm8y7xTO5FiUEBRH3ic0vUEdWTHQQ+G9EDbt8aISjGbrD2WOHkyqHEEK0x7TpyexrQ==
X-Received: by 2002:a62:4607:: with SMTP id t7mr117977034pfa.138.1558752016264;
        Fri, 24 May 2019 19:40:16 -0700 (PDT)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id i22sm4279838pfa.127.2019.05.24.19.40.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 19:40:15 -0700 (PDT)
Subject: Re: [PATCH v1 0/5] Solve postboot supplier cleanup and optimize probe
 ordering
To:     Saravana Kannan <saravanak@google.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Android Kernel Team <kernel-team@android.com>,
        Frank Rowand <frowand.list@gmail.com>
References: <20190524010117.225219-1-saravanak@google.com>
 <06b479e2-e8a0-b3e8-567c-7fa0f1c5bdf6@gmail.com>
 <CAGETcx-21GEoBKhpzcsrDt3sEo-vUpwqnr3To7VbSPd8aW86Nw@mail.gmail.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <d49dccee-203a-628a-8e47-191014619f6b@gmail.com>
Date:   Fri, 24 May 2019 19:40:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAGETcx-21GEoBKhpzcsrDt3sEo-vUpwqnr3To7VbSPd8aW86Nw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Saranova,

I'll try to address the other portions of this email that I <snipped>
in my previous replies.


On 5/24/19 2:53 PM, Saravana Kannan wrote:
> On Fri, May 24, 2019 at 10:49 AM Frank Rowand <frowand.list@gmail.com> wrote:
>>
>> On 5/23/19 6:01 PM, Saravana Kannan wrote:
>>> Add a generic "depends-on" property that allows specifying mandatory
>>> functional dependencies between devices. Add device-links after the
>>> devices are created (but before they are probed) by looking at this
>>> "depends-on" property.
>>>
>>> This property is used instead of existing DT properties that specify
>>> phandles of other devices (Eg: clocks, pinctrl, regulators, etc). This
>>> is because not all resources referred to by existing DT properties are
>>> mandatory functional dependencies. Some devices/drivers might be able> to operate with reduced functionality when some of the resources
>>> aren't available. For example, a device could operate in polling mode
>>> if no IRQ is available, a device could skip doing power management if
>>> clock or voltage control isn't available and they are left on, etc.
>>>
>>> So, adding mandatory functional dependency links between devices by
>>> looking at referred phandles in DT properties won't work as it would
>>> prevent probing devices that could be probed. By having an explicit
>>> depends-on property, we can handle these cases correctly.
>>
>> Trying to wrap my brain around the concept, this series seems to be
>> adding the ability to declare that an apparent dependency (eg an IRQ
>> specified by a phandle) is _not_ actually a dependency.
> 
> The current implementation completely ignores existing bindings for
> dependencies and so does the current tip of the kernel. So it's not
> really overriding anything. However, if I change the implementation so
> that depends-on becomes the source of truth if it exists and falls
> back to existing common bindings if "depends-on" isn't present -- then
> depends-on would truly be overriding existing bindings for
> dependencies. It depends on how we want to define the DT property.
> 
>> The phandle already implies the dependency.
> 
> Sure, it might imply, but it's not always true.
> 
>> Creating a separate
>> depends-on property provides a method of ignoring the implied
>> dependencies.
> 
> implied != true
> 
>> This is not just hardware description.  It is instead a combination
>> of hardware functionality and driver functionality.  An example
>> provided in the second paragraph of the email I am replying to
>> suggests a device could operate in polling mode if no IRQ is
>> available.  Using this example, the devicetree does not know
>> whether the driver requires the IRQ (currently an implied
>> dependency since the IRQ phandle exists).  My understanding
>> of this example is that the device node would _not_ have a
>> depends-on property for the IRQ phandle so the IRQ would be
>> optional.  But this is an attribute of the driver, not the
>> hardware.
> 

> Not really. The interrupt could be for "SD card plugged in". That's
> never a mandatory dependency for the SD card controller to work. So
> the IRQ provider won't be a "depends-on" in this case. But if there is
> no power supply or clock for the SD card controller, it isn't going to
> work -- so they'd be listed in the "depends-on". So, this is still
> defining the hardware and not the OS.

Please comment on my observation that was based on an IRQ for a device
will polling mode vs interrupt driven mode.  You described a different
case and did not address my comment.


>> This is also configuration, declaring whether the
>> system is willing to accept polling mode instead of interrupt
>> mode.
> 
> Whether the driver will choose to operate without the IRQ is up to it.
> The OS could also assume the power supply is never turned off and
> still try to use the device. Depending on the hardware configuration,
> that might or might not work.
> 
>> Devicetree is not the proper place for driver description or
>> for configuration.
> 
> But depends-on isn't describing the driver configuration though.
> 
> Overall, the clock provider example I gave in another reply is a much
> better example. If you just assume implied dependencies are mandatory
> dependencies, some devices will never be probe because the kernel is
> using them incorrectly (they aren't meant to list mandatory
> dependencies).
> 
>> Another flaw with this method is that existing device trees
>> will be broken after the kernel is modified, because existing
>> device trees do not have the depends-on property.  This breaks
>> the devicetree compatibility rules.
> 
> This is 100% not true with the current implementation. I actually
> tested this. This is fully backwards compatible. That's another reason
> for adding depends-on and going by just what it says. The existing
> bindings were never meant to describe only mandatory dependencies. So
> using them as such is what would break backwards compatibility.
> 
>>> Having functional dependencies explicitly called out in DT and
>>> automatically added before the devices are probed, provides the
>>> following benefits:
>>>
>>> - Optimizes device probe order and avoids the useless work of
>>>   attempting probes of devices that will not probe successfully
>>>   (because their suppliers aren't present or haven't probed yet).
>>>
>>>   For example, in a commonly available mobile SoC, registering just
>>>   one consumer device's driver at an initcall level earlier than the
>>>   supplier device's driver causes 11 failed probe attempts before the
>>>   consumer device probes successfully. This was with a kernel with all
>>>   the drivers statically compiled in. This problem gets a lot worse if
>>>   all the drivers are loaded as modules without direct symbol
>>>   dependencies.
>>>
>>> - Supplier devices like clock providers, regulators providers, etc
>>>   need to keep the resources they provide active and at a particular
>>>   state(s) during boot up even if their current set of consumers don't
>>>   request the resource to be active. This is because the rest of the
>>>   consumers might not have probed yet and turning off the resource
>>>   before all the consumers have probed could lead to a hang or
>>>   undesired user experience.
>>>
>>>   Some frameworks (Eg: regulator) handle this today by turning off
>>>   "unused" resources at late_initcall_sync and hoping all the devices
>>>   have probed by then. This is not a valid assumption for systems with
>>>   loadable modules. Other frameworks (Eg: clock) just don't handle
>>>   this due to the lack of a clear signal for when they can turn off
>>>   resources. This leads to downstream hacks to handle cases like this
>>>   that can easily be solved in the upstream kernel.
>>>
>>>   By linking devices before they are probed, we give suppliers a clear
>>
>> By linking devices to suppliers before they are probed, we give suppliers a clear
> 
> Ack
> 
>>>   count of the number of dependent consumers. Once all of the
>>>   consumers are active, the suppliers can turn off the unused
>>>   resources without making assumptions about the number of consumers.
>>>
>>> By default we just add device-links to track "driver presence" (probe
>>> succeeded) of the supplier device. If any other functionality provided
>>> by device-links are needed, it is left to the consumer/supplier
>>> devices to change the link when they probe.
>>>
>>>
>>> Saravana Kannan (5):
>>>   of/platform: Speed up of_find_device_by_node()
>>>   driver core: Add device links support for pending links to suppliers
>>>   dt-bindings: Add depends-on property
>>>   of/platform: Add functional dependency link from "depends-on" property
>>>   driver core: Add sync_state driver/bus callback
>>>
>>>  .../devicetree/bindings/depends-on.txt        |  26 +++++
>>>  drivers/base/core.c                           | 106 ++++++++++++++++++
>>>  drivers/of/platform.c                         |  75 ++++++++++++-
>>>  include/linux/device.h                        |  24 ++++
>>>  include/linux/of.h                            |   3 +
>>>  5 files changed, 233 insertions(+), 1 deletion(-)
>>>  create mode 100644 Documentation/devicetree/bindings/depends-on.txt
>>>
>>
>> The above issues make this specific implementation not acceptable.
>> I like the analysis of the problem areas, and I like the concepts of
>> trying to solve not only probe ordering, but also the problem of
>> when to turn off resources that will not be needed.
> 
> Beating a dead horse here, but I want to make sure I get this into as
> many minds as possible:
> It is NOT just about turning off resources. It's about the kernel
> taking full control of resources (allowing the full range of voltages,
> clock frequencies, bus configurations, etc) and syncing the HW state
> to the SW state as determined by the consumers.
> 
>> But at the
>> moment, I don't have a suggestion of a way to implement a solution.
> 
> The problem of syncing resources to SW state after boot up completed
> has been broken for a long time in the kernel. It's high time we fix
> it. I'm open to other suggestions, but we can't just say "we don't
> have a solution".
> 
> For example, we can have a kernel command line argument that'll use
> all common implicit bindings as mandatory dependencies and allow
> "depends-on" to override them for the few cases where the implicit
> dependencies don't match mandatory dependencies. Then:
> - The kernel will be 100% backwards compatible with existing DT if the
> command line arg isn't provided.
> - New DT + old kernel will be no worse than today because old kernel
> doesn't do any dependency tracking.
> - Command line arg + new kernel + hardware where all implicit
> dependencies are actually mandatory dependencies == things work
> better.
> - Command line arg + new kernel + hardware where all implicit
> dependencies don't match mandatory dependencies + depends-on for those
> exception case == things work better.

Using a command line argument for this purpose just seems to be a
hack and bad architecture.

It also seems like an invitation to mis-configure a system (in other
words, increases the complexity and difficulty of properly configuring
and administering a system).

The is not a hard no (yet), but it will take some convincing for me
to accept the command line approach to add the feature, yet maintain
compatibility.  Please do not spend any time replying to this concern
yet - we will have plenty of time to discuss later if need be.

> 
> Would that be an acceptable use of "depends-on" to track mandatory dependencies?
> 
> 
> 
> -Saravana
> 

-Frank
