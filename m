Return-Path: <SRS0=4CSQ=WG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2220C433FF
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 05:20:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62E1A217F4
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 05:20:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rO8fh5d1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725862AbfHJFUz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Aug 2019 01:20:55 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43810 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbfHJFUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Aug 2019 01:20:54 -0400
Received: by mail-pf1-f194.google.com with SMTP id i189so47113961pfg.10;
        Fri, 09 Aug 2019 22:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vCsZ0PUnHs9X6E+H649TATEMkEAfcQAEW4STfpgMP9A=;
        b=rO8fh5d1udF9jjI9wNP6a/eo3y9gsdKSGShy/3uXD+5E3Rv8bKfPqP48YfAv4P5tFW
         24tEm862r084m6K+F7vkLHZtrYbu3uH0VhZb72L+BdzQjWPoCkI4y1M159wW8cXg6/2h
         SC0Fx0K287Y3JtrFAsTZlU3R+VSHnKwnGZ5ySnsK0T3Q4vbA3Egs8Ap6y8rqofK9b3AJ
         gPSf+KCf1hxHSIoSMnBE4syof28Ql4tc/y5Z9TbqnzXpC/AjoJDPbc5RUaS1wFxKuvk9
         JFNQU+0dR2OqYRYK4dqCw52NBiuopwRsUrV41gZIXeL31nxCrOIipbyQZ4PZyEiup97Q
         T+5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vCsZ0PUnHs9X6E+H649TATEMkEAfcQAEW4STfpgMP9A=;
        b=aa5s2wmXquRQ2zwo7UmTzBiBcfENyMpjKQZL5TK98kRwdorGA5Ox8Ols7lQ8sjn1sP
         KDEu3GRdvLUM/w9b1MG6w01xZQLDsoiT1s/YCY8+ukGytvesPll2WqaQqtJtOrr2Xw/D
         1dNVHzMp0a9Hj92TC9jD3Xp6L0/ilwMnhkYlzVlki7mjSR6Q/NjWj48+3FxtaJXzHNsg
         ZeV0H5W/LTzb05UwcttU2SP0tGDgobqj3NT1OWnGYrbAupvebvg5RJUmJOWd28J+hvst
         NqGGUYgtyJ/c17LCpA625xU3Lo+XfeyuH0B8kQqIiyvSD7ZV5ixS+3AWY+5Aj/JhPY2H
         Ziww==
X-Gm-Message-State: APjAAAWSzgUeYmK0mf/4hlk6upEVgX3reVY7ZRHBcXYYIc6tBR66uDcV
        yDDcrh0+mGJrFVlyng1AdMs=
X-Google-Smtp-Source: APXvYqylqJg+lOXNG/X7r1SmMXsjDbYwCILG7+M8gI8MG1Dx/AOhqRqPQFUJzL+GG9pxAM3o9gEOUg==
X-Received: by 2002:a63:204b:: with SMTP id r11mr20600578pgm.121.1565414453897;
        Fri, 09 Aug 2019 22:20:53 -0700 (PDT)
Received: from [192.168.1.70] (c-73-231-235-122.hsd1.ca.comcast.net. [73.231.235.122])
        by smtp.gmail.com with ESMTPSA id x24sm95073669pgl.84.2019.08.09.22.20.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Aug 2019 22:20:53 -0700 (PDT)
Subject: Re: [PATCH v9 0/7] Solve postboot supplier cleanup and optimize probe
 ordering
To:     Saravana Kannan <saravanak@google.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        David Collins <collinsd@codeaurora.org>,
        Android Kernel Team <kernel-team@android.com>
References: <20190731221721.187713-1-saravanak@google.com>
 <919b66e9-9708-de34-41cd-e448838b130c@gmail.com>
 <CAGETcx8LqeOXD5zPsLuxoG5pR9VZ_v=PQfRf-aFwCSaW4kwoxA@mail.gmail.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <7a0ee940-f81f-36b9-93e7-2b4c242360c9@gmail.com>
Date:   Fri, 9 Aug 2019 22:20:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAGETcx8LqeOXD5zPsLuxoG5pR9VZ_v=PQfRf-aFwCSaW4kwoxA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/9/19 10:00 PM, Saravana Kannan wrote:
> On Fri, Aug 9, 2019 at 7:57 PM Frank Rowand <frowand.list@gmail.com> wrote:
>>
>> Hi Saravana,
>>
>> On 7/31/19 3:17 PM, Saravana Kannan wrote:
>>> Add device-links to track functional dependencies between devices
>>> after they are created (but before they are probed) by looking at
>>> their common DT bindings like clocks, interconnects, etc.
>>>
>>> Having functional dependencies automatically added before the devices
>>> are probed, provides the following benefits:
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
>>> - Supplier devices like clock providers, interconnect providers, etc
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
>>>   count of the number of dependent consumers. Once all of the
>>>   consumers are active, the suppliers can turn off the unused
>>>   resources without making assumptions about the number of consumers.
>>>
>>> By default we just add device-links to track "driver presence" (probe
>>> succeeded) of the supplier device. If any other functionality provided
>>> by device-links are needed, it is left to the consumer/supplier
>>> devices to change the link when they probe.
>>>
>>> v1 -> v2:
>>> - Drop patch to speed up of_find_device_by_node()
>>> - Drop depends-on property and use existing bindings
>>>
>>> v2 -> v3:
>>> - Refactor the code to have driver core initiate the linking of devs
>>> - Have driver core link consumers to supplier before it's probed
>>> - Add support for drivers to edit the device links before probing
>>>
>>> v3 -> v4:
>>> - Tested edit_links() on system with cyclic dependency. Works.
>>> - Added some checks to make sure device link isn't attempted from
>>>   parent device node to child device node.
>>> - Added way to pause/resume sync_state callbacks across
>>>   of_platform_populate().
>>> - Recursively parse DT node to create device links from parent to
>>>   suppliers of parent and all child nodes.
>>>
>>> v4 -> v5:
>>> - Fixed copy-pasta bugs with linked list handling
>>> - Walk up the phandle reference till I find an actual device (needed
>>>   for regulators to work)
>>> - Added support for linking devices from regulator DT bindings
>>> - Tested the whole series again to make sure cyclic dependencies are
>>>   broken with edit_links() and regulator links are created properly.
>>>
>>> v5 -> v6:
>>> - Split, squashed and reordered some of the patches.
>>> - Refactored the device linking code to follow the same code pattern for
>>>   any property.
>>>
>>> v6 -> v7:
>>> - No functional changes.
>>> - Renamed i to index
>>> - Added comment to clarify not having to check property name for every
>>>   index
>>> - Added "matched" variable to clarify code. No functional change.
>>> - Added comments to include/linux/device.h for add_links()
>>>
>>> v7 -> v8:
>>> - Rebased on top of linux-next to handle device link changes in [1]
>>>
>>
>>
>>> v8 -> v9:
>>> - Fixed kbuild test bot reported errors (docs and const)
>>
>> Some maintainers have strong opinions about whether change logs should be:
>>
>>   (1) only in patch 0
>>   (2) only in the specific patches that are changed
>>   (3) both in patch 0 and in the specific patches that are changed.
>>
>> I can adapt to any of the three styles.  But for style "(1)" please
>> list which specific patch has changed for each item in the change list.
>>
> 
> Thanks for the context Frank. I'm okay with (1) or (2) but I'll stick
> with (1) for this series. Didn't realize there were options (2) and
> (3). Since you started reviewing from v7, I'll do that in the future
> updates? Also, I haven't forgotten your emails. Just tied up with
> something else for a few days. I'll get to your emails next week.

Yes, starting with future updates is fine, no need to redo the v9
change logs.

No problem on the timing.  I figured you were busy or away from the
internet.

-Frank

> 
> Thanks,
> Saravana
> 

