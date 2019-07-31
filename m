Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D83CC433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 02:22:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 645C5206E0
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 02:22:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B6LdXvJS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726516AbfGaCWl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 22:22:41 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38021 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbfGaCWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 22:22:41 -0400
Received: by mail-pf1-f194.google.com with SMTP id y15so30918458pfn.5;
        Tue, 30 Jul 2019 19:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hPXbs9GS87M+TzGRE+Gm7mt+o30yfxU9rOmWsGjCYtk=;
        b=B6LdXvJS8rL4bA49NRQ8FTGkAM5juSx+ufpfzvdNmRUekxDydTMwrqfNVtlaiJ0biu
         GqioUQStvpsBxie/ct7Wc8qso57moMjvQDeJ+hR1rTKums92H/fUi4DNuUMGaMpuqnCF
         9pxaJ7m80RRXfBiNoxWXCbbPE+bRJOaQOGIQhwoytvVMG+2OgAkhsAxhHtufCFh0pbqw
         xYYrUfBjaUnq22L6qMyJLeSPog+1oueGMM0ya0PN+FaRnP0lkJBLLWcKksE7/J7bWHFw
         Vw9/ien68ZMOVtzb8juRlVrOLYVu3MwyVUSzbLsATnzNX81B6qOQbJMZICnYZmR87OnP
         +w9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hPXbs9GS87M+TzGRE+Gm7mt+o30yfxU9rOmWsGjCYtk=;
        b=OCG5/1yXrGW2Q2gM+jPGDOgfKZkk/Qezlda/L5p6QqhKC/NN0n8k/JzlJWx/QHJalo
         +IRQyJGnNjA1RkCeu1r+Or6oZYQKy9E4RXMbsDy6vUFUVq4JRe/RxCpZCcSrD18O1+Yc
         qWJ7ON0KNkXRZYFWRI41f6MdtIdXYpbWWtibNd1s7EFKmxmthdz6JOUANHZKIyfUat84
         afP8vu0zjd4p3cbyrvgwFL5V/r1QuRKUiFSzB6izHKZqy0ObP4+c1tOrvtKK7fFIjgOr
         D5ZGpgc80+0fRBzQob2aLJ58HRQSQvOyNBq+tQmDHdP1aJs3B3hSsvNMPw881myEHzZD
         ZzLw==
X-Gm-Message-State: APjAAAV5F7DhzlaQ2cg37EQdR2JvvfcTmy83+7tU6+pH/Bz0qK3LCq32
        H779HqADshKrLAq58Bi0gbk=
X-Google-Smtp-Source: APXvYqxOzNsSuIdaLLOIldy+Fbp9sJCzsd3Yj70wZXqaej9bbk9eaUygEwAR/6cljR6CUaiOdLCKDA==
X-Received: by 2002:a17:90a:d983:: with SMTP id d3mr439464pjv.88.1564539760166;
        Tue, 30 Jul 2019 19:22:40 -0700 (PDT)
Received: from [192.168.1.70] (c-73-231-235-122.hsd1.ca.comcast.net. [73.231.235.122])
        by smtp.gmail.com with ESMTPSA id y12sm76115726pfn.187.2019.07.30.19.22.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jul 2019 19:22:38 -0700 (PDT)
Subject: Re: [PATCH v7 0/7] Solve postboot supplier cleanup and optimize probe
 ordering
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Saravana Kannan <saravanak@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Collins <collinsd@codeaurora.org>,
        kernel-team@android.com
References: <20190724001100.133423-1-saravanak@google.com>
 <20190725134214.GD11115@kroah.com>
 <99ca3252-55af-8eea-7653-8347b0a1ab03@gmail.com>
 <20190726143225.GA13297@kroah.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <89a8db12-422d-5881-3909-56fd48881401@gmail.com>
Date:   Tue, 30 Jul 2019 19:22:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190726143225.GA13297@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg, Rob,

On 7/26/19 7:32 AM, Greg Kroah-Hartman wrote:
> On Thu, Jul 25, 2019 at 02:04:23PM -0700, Frank Rowand wrote:
>> On 7/25/19 6:42 AM, Greg Kroah-Hartman wrote:
>>> On Tue, Jul 23, 2019 at 05:10:53PM -0700, Saravana Kannan wrote:
>>>> Add device-links to track functional dependencies between devices
>>>> after they are created (but before they are probed) by looking at
>>>> their common DT bindings like clocks, interconnects, etc.
>>>>
>>>> Having functional dependencies automatically added before the devices
>>>> are probed, provides the following benefits:
>>>>
>>>> - Optimizes device probe order and avoids the useless work of
>>>>   attempting probes of devices that will not probe successfully
>>>>   (because their suppliers aren't present or haven't probed yet).
>>>>
>>>>   For example, in a commonly available mobile SoC, registering just
>>>>   one consumer device's driver at an initcall level earlier than the
>>>>   supplier device's driver causes 11 failed probe attempts before the
>>>>   consumer device probes successfully. This was with a kernel with all
>>>>   the drivers statically compiled in. This problem gets a lot worse if
>>>>   all the drivers are loaded as modules without direct symbol
>>>>   dependencies.
>>>>
>>>> - Supplier devices like clock providers, interconnect providers, etc
>>>>   need to keep the resources they provide active and at a particular
>>>>   state(s) during boot up even if their current set of consumers don't
>>>>   request the resource to be active. This is because the rest of the
>>>>   consumers might not have probed yet and turning off the resource
>>>>   before all the consumers have probed could lead to a hang or
>>>>   undesired user experience.
>>>>
>>>>   Some frameworks (Eg: regulator) handle this today by turning off
>>>>   "unused" resources at late_initcall_sync and hoping all the devices
>>>>   have probed by then. This is not a valid assumption for systems with
>>>>   loadable modules. Other frameworks (Eg: clock) just don't handle
>>>>   this due to the lack of a clear signal for when they can turn off
>>>>   resources. This leads to downstream hacks to handle cases like this
>>>>   that can easily be solved in the upstream kernel.
>>>>
>>>>   By linking devices before they are probed, we give suppliers a clear
>>>>   count of the number of dependent consumers. Once all of the
>>>>   consumers are active, the suppliers can turn off the unused
>>>>   resources without making assumptions about the number of consumers.
>>>>
>>>> By default we just add device-links to track "driver presence" (probe
>>>> succeeded) of the supplier device. If any other functionality provided
>>>> by device-links are needed, it is left to the consumer/supplier
>>>> devices to change the link when they probe.
>>>>
>>>> v1 -> v2:
>>>> - Drop patch to speed up of_find_device_by_node()
>>>> - Drop depends-on property and use existing bindings
>>>>
>>>> v2 -> v3:
>>>> - Refactor the code to have driver core initiate the linking of devs
>>>> - Have driver core link consumers to supplier before it's probed
>>>> - Add support for drivers to edit the device links before probing
>>>>
>>>> v3 -> v4:
>>>> - Tested edit_links() on system with cyclic dependency. Works.
>>>> - Added some checks to make sure device link isn't attempted from
>>>>   parent device node to child device node.
>>>> - Added way to pause/resume sync_state callbacks across
>>>>   of_platform_populate().
>>>> - Recursively parse DT node to create device links from parent to
>>>>   suppliers of parent and all child nodes.
>>>>
>>>> v4 -> v5:
>>>> - Fixed copy-pasta bugs with linked list handling
>>>> - Walk up the phandle reference till I find an actual device (needed
>>>>   for regulators to work)
>>>> - Added support for linking devices from regulator DT bindings
>>>> - Tested the whole series again to make sure cyclic dependencies are
>>>>   broken with edit_links() and regulator links are created properly.
>>>>
>>>> v5 -> v6:
>>>> - Split, squashed and reordered some of the patches.
>>>> - Refactored the device linking code to follow the same code pattern for
>>>>   any property.
>>>>
>>>> v6 -> v7:
>>>> - No functional changes.
>>>> - Renamed i to index
>>>> - Added comment to clarify not having to check property name for every
>>>>   index
>>>> - Added "matched" variable to clarify code. No functional change.
>>>> - Added comments to include/linux/device.h for add_links()
>>>>
>>>> I've also not updated this patch series to handle the new patch [1] from
>>>> Rafael. Will do that once this patch series is close to being Acked.
>>>>
>>>> [1] - https://lore.kernel.org/lkml/3121545.4lOhFoIcdQ@kreacher/
>>>
>>>
>>> This looks sane to me.  Anyone have any objections for me queueing this
>>> up for my tree to get into linux-next now?
>>
>> I would like for the series to get into linux-next sooner than later,
>> and spend some time there.  
> 
> Ok, care to give me an ack for it?  :)

Rob opined to me that if you apply the series, it will go into 5.4 unless
reverted.  That is also what I would expect.

I'm going through the series carefully now.  This is currently my highest
priority task.  I don't yet know if my comments will be minor, or whether
I will have larger changes to request.

So I am not ready to ack the series yet.

-Frank

> 
> thanks,
> 
> greg k-h
> 

