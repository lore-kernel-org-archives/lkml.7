Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AA3EC3A59C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 14:05:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1FC8206C1
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 14:05:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vWW9C41S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727391AbfHPOFL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 10:05:11 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:46788 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727252AbfHPOFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 10:05:11 -0400
Received: by mail-io1-f68.google.com with SMTP id x4so6356390iog.13;
        Fri, 16 Aug 2019 07:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=G9wHPsZXjoDHdSpu7wtv6+zEZ3K+98q/OK226gGp6QE=;
        b=vWW9C41ScbMtu/x6/dWfTFHMHQqbn0yipW7K3ltQIsPG5Fi+mRnCrpt+hoYY4lnzUI
         rXCmiStdb75ZZ1TeHsyRBpwSPP5QIsurk1JFK1bW/8oR8B1PXf/ps2oHO9PCXaanmtU5
         VzHYJBN1UKrW0Z+H/bcYg5zmSoHLyhTR++RP4NVR3xjnEixFe1BHoZZ2hAWo3xerCaVf
         4mx9dH1tH1ZySCLjqBGcngGRvEena1fAMALiPbFqQtUBSv9IWARf+bL/pg3mqqqxTmoF
         +Zo3/o5hqESNY+l5oAdwnt21zA7NKJ+tnk5rptH5+EDTmWUtMaQzefQShkJ5B+EjhjLD
         Lplg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=G9wHPsZXjoDHdSpu7wtv6+zEZ3K+98q/OK226gGp6QE=;
        b=O3/7RyS3pVwfzBsWHr7OU98qfEPHop/H+oiwMmPCDxNMMuVttjzfuRkaH0NrD53CMc
         NSgPcDeHZggKpT77CbssqZci1MXBToU5cOeupQWEgCXIJj/W3g/klxKK1c6Vn8FicQXm
         8iTet/+O7j9SFk/brT0UP0FyjpkIDU+OGQXme7gQM/sh5P1TVV5zMkI9oL0XwizIgur8
         9WFcAUQ9m3LZZP71LjDLsNeKV9mTdYeGjeZQhsvyvyfgfmdbGKI47qipqzRDoL7bk/tY
         ErV1E7RNSkK+d17P4eUJDJRHTIxpiV1gTZSvvuJPjvkK7vkKWyb+EbtAqGgNBDTq2Smv
         X4sg==
X-Gm-Message-State: APjAAAXQXqCexxU1K0Vpyf82TjN29KPg1y5bOtHBIHKanm6o7uuxYC9F
        UV7nqOSSjWEVbaE0qsMejEw=
X-Google-Smtp-Source: APXvYqyw/WOkUotwC94rTZvMRGZbmvB8No7jxav0ZMqI3x5/r5zyhzmPyGxxwJoCSiWSHfSndxysnQ==
X-Received: by 2002:a6b:fd13:: with SMTP id c19mr924386ioi.168.1565964310335;
        Fri, 16 Aug 2019 07:05:10 -0700 (PDT)
Received: from [192.168.43.210] (mobile-166-177-58-16.mycingular.net. [166.177.58.16])
        by smtp.gmail.com with ESMTPSA id a9sm4625714iod.76.2019.08.16.07.05.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Aug 2019 07:05:09 -0700 (PDT)
Subject: Re: [PATCH v9 0/7] Solve postboot supplier cleanup and optimize probe
 ordering
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Saravana Kannan <saravanak@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        David Collins <collinsd@codeaurora.org>,
        Android Kernel Team <kernel-team@android.com>
References: <20190731221721.187713-1-saravanak@google.com>
 <919b66e9-9708-de34-41cd-e448838b130c@gmail.com>
 <CAGETcx8LqeOXD5zPsLuxoG5pR9VZ_v=PQfRf-aFwCSaW4kwoxA@mail.gmail.com>
 <7a0ee940-f81f-36b9-93e7-2b4c242360c9@gmail.com>
 <CAGETcx_UxNV_Qk79es0SJ3L0yAtFRpOjPcU7e5Cje6UPbp5adQ@mail.gmail.com>
 <183eab70-0eda-f30e-ae25-74355b8b84c9@gmail.com>
 <20190816091056.GA15703@kroah.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <316be6cc-a138-3259-74a0-2cdf281a5646@gmail.com>
Date:   Fri, 16 Aug 2019 07:05:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190816091056.GA15703@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i Greg,

On 8/16/19 2:10 AM, Greg Kroah-Hartman wrote:
> On Thu, Aug 15, 2019 at 08:09:19PM -0700, Frank Rowand wrote:
>> Hi Saravana,
>>
>> On 8/15/19 6:50 PM, Saravana Kannan wrote:
>>> On Fri, Aug 9, 2019 at 10:20 PM Frank Rowand <frowand.list@gmail.com> wrote:
>>>>
>>>> On 8/9/19 10:00 PM, Saravana Kannan wrote:
>>>>> On Fri, Aug 9, 2019 at 7:57 PM Frank Rowand <frowand.list@gmail.com> wrote:
>>>>>>
>>>>>> Hi Saravana,
>>>>>>
>>>>>> On 7/31/19 3:17 PM, Saravana Kannan wrote:
>>>>>>> Add device-links to track functional dependencies between devices
>>>>>>> after they are created (but before they are probed) by looking at
>>>>>>> their common DT bindings like clocks, interconnects, etc.
>>>>>>>
>>>>>>> Having functional dependencies automatically added before the devices
>>>>>>> are probed, provides the following benefits:
>>>>>>>
>>>>>>> - Optimizes device probe order and avoids the useless work of
>>>>>>>   attempting probes of devices that will not probe successfully
>>>>>>>   (because their suppliers aren't present or haven't probed yet).
>>>>>>>
>>>>>>>   For example, in a commonly available mobile SoC, registering just
>>>>>>>   one consumer device's driver at an initcall level earlier than the
>>>>>>>   supplier device's driver causes 11 failed probe attempts before the
>>>>>>>   consumer device probes successfully. This was with a kernel with all
>>>>>>>   the drivers statically compiled in. This problem gets a lot worse if
>>>>>>>   all the drivers are loaded as modules without direct symbol
>>>>>>>   dependencies.
>>>>>>>
>>>>>>> - Supplier devices like clock providers, interconnect providers, etc
>>>>>>>   need to keep the resources they provide active and at a particular
>>>>>>>   state(s) during boot up even if their current set of consumers don't
>>>>>>>   request the resource to be active. This is because the rest of the
>>>>>>>   consumers might not have probed yet and turning off the resource
>>>>>>>   before all the consumers have probed could lead to a hang or
>>>>>>>   undesired user experience.
>>>>>>>
>>>>>>>   Some frameworks (Eg: regulator) handle this today by turning off
>>>>>>>   "unused" resources at late_initcall_sync and hoping all the devices
>>>>>>>   have probed by then. This is not a valid assumption for systems with
>>>>>>>   loadable modules. Other frameworks (Eg: clock) just don't handle
>>>>>>>   this due to the lack of a clear signal for when they can turn off
>>>>>>>   resources. This leads to downstream hacks to handle cases like this
>>>>>>>   that can easily be solved in the upstream kernel.
>>>>>>>
>>>>>>>   By linking devices before they are probed, we give suppliers a clear
>>>>>>>   count of the number of dependent consumers. Once all of the
>>>>>>>   consumers are active, the suppliers can turn off the unused
>>>>>>>   resources without making assumptions about the number of consumers.
>>>>>>>
>>>>>>> By default we just add device-links to track "driver presence" (probe
>>>>>>> succeeded) of the supplier device. If any other functionality provided
>>>>>>> by device-links are needed, it is left to the consumer/supplier
>>>>>>> devices to change the link when they probe.
>>>>>>>
>>>>>>> v1 -> v2:
>>>>>>> - Drop patch to speed up of_find_device_by_node()
>>>>>>> - Drop depends-on property and use existing bindings
>>>>>>>
>>>>>>> v2 -> v3:
>>>>>>> - Refactor the code to have driver core initiate the linking of devs
>>>>>>> - Have driver core link consumers to supplier before it's probed
>>>>>>> - Add support for drivers to edit the device links before probing
>>>>>>>
>>>>>>> v3 -> v4:
>>>>>>> - Tested edit_links() on system with cyclic dependency. Works.
>>>>>>> - Added some checks to make sure device link isn't attempted from
>>>>>>>   parent device node to child device node.
>>>>>>> - Added way to pause/resume sync_state callbacks across
>>>>>>>   of_platform_populate().
>>>>>>> - Recursively parse DT node to create device links from parent to
>>>>>>>   suppliers of parent and all child nodes.
>>>>>>>
>>>>>>> v4 -> v5:
>>>>>>> - Fixed copy-pasta bugs with linked list handling
>>>>>>> - Walk up the phandle reference till I find an actual device (needed
>>>>>>>   for regulators to work)
>>>>>>> - Added support for linking devices from regulator DT bindings
>>>>>>> - Tested the whole series again to make sure cyclic dependencies are
>>>>>>>   broken with edit_links() and regulator links are created properly.
>>>>>>>
>>>>>>> v5 -> v6:
>>>>>>> - Split, squashed and reordered some of the patches.
>>>>>>> - Refactored the device linking code to follow the same code pattern for
>>>>>>>   any property.
>>>>>>>
>>>>>>> v6 -> v7:
>>>>>>> - No functional changes.
>>>>>>> - Renamed i to index
>>>>>>> - Added comment to clarify not having to check property name for every
>>>>>>>   index
>>>>>>> - Added "matched" variable to clarify code. No functional change.
>>>>>>> - Added comments to include/linux/device.h for add_links()
>>>>>>>
>>>>>>> v7 -> v8:
>>>>>>> - Rebased on top of linux-next to handle device link changes in [1]
>>>>>>>
>>>>>>
>>>>>>
>>>>>>> v8 -> v9:
>>>>>>> - Fixed kbuild test bot reported errors (docs and const)
>>>>>>
>>>>>> Some maintainers have strong opinions about whether change logs should be:
>>>>>>
>>>>>>   (1) only in patch 0
>>>>>>   (2) only in the specific patches that are changed
>>>>>>   (3) both in patch 0 and in the specific patches that are changed.
>>>>>>
>>>>>> I can adapt to any of the three styles.  But for style "(1)" please
>>>>>> list which specific patch has changed for each item in the change list.
>>>>>>
>>>>>
>>>>> Thanks for the context Frank. I'm okay with (1) or (2) but I'll stick
>>>>> with (1) for this series. Didn't realize there were options (2) and
>>>>> (3). Since you started reviewing from v7, I'll do that in the future
>>>>> updates? Also, I haven't forgotten your emails. Just tied up with
>>>>> something else for a few days. I'll get to your emails next week.
>>>>
>>>> Yes, starting with future updates is fine, no need to redo the v9
>>>> change logs.
>>>>
>>>> No problem on the timing.  I figured you were busy or away from the
>>>> internet.
>>>
>>> I'm replying to your comments on the other 3 patches. Okay with a
>>> majority of them. I'll wait for your reply to see where we settle for
>>> some of the points before I send out any patches though.
>>>
>>> For now I'm thinking of sending them as separate clean up patches so
>>> that Greg doesn't have to deal with reverts in his "next" branch. We
>>> can squash them later if we really need to rip out what's in there and
>>> push it again.
>>>
>>> -Saravana
>>>
>>
>> Please do not do separate clean up patches.  The series that Greg has is
>> not ready for acceptance and I am going to ask him to revert it as we
>> work through the needed changes.
>>
>> I suspect there will be at least two more versions of the series.  The
>> first is to get the patches I commented in good shape.  Then I will
>> look at the patches later in the series to see how they fit into the
>> big picture.
>>
>> In the end, there should be one coherent patch series that implements
>> the feature.
> 
> Incremental patches to fix up the comments and documentation is fine, no
> need to respin the whole mess.

The problem is that the whole thing is a "mess" at this point.  I expect
the series to go through at least two or three more versions.

Please revert the series for now.

-Frank

> 
> thanks,
> 
> greg k-h
> 

