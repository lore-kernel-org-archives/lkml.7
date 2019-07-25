Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49BC5C76190
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 21:04:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13FAD218D4
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 21:04:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mTSJXFhE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbfGYVE0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 17:04:26 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:43986 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbfGYVE0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 17:04:26 -0400
Received: by mail-pl1-f195.google.com with SMTP id 4so16873696pld.10;
        Thu, 25 Jul 2019 14:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vnz0oidgrAEVG4XL4mwZLBvzyZzB4RcCuBUNml+uqQA=;
        b=mTSJXFhEIPhq/py2Zs5FEunzqa0YdYTK787ALKXIXmT2t4PxNca88TsFB6TLcR1Stl
         kBudNkBB4iJbQs+t1qCFln1NBpmt+jJ5nELst8qJ+QnpqMmaujaZXvCZjLyyYu59ORNj
         wbS6Wk+y3XlXcSNqNOyxeNDYTewh8y/A7m3CKJYwqTgktTWYmUYkkrLaWTyEn1QA6+7J
         aZKIKxTnaWK+hkUcfH6C1Uu1gv+WX+w2Tb3sNuINoXBxXjIn201XI6DMgZyeqkh5f9eB
         T0TWfBTuSTE1X0iixl/U5GofVwd+uOWOZWQcqEyNM3Ac5bB0MKYZ8QHFujwkPXilKPVG
         o/dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vnz0oidgrAEVG4XL4mwZLBvzyZzB4RcCuBUNml+uqQA=;
        b=GNUtjSmQ1CFxVUSoV/oZh5tT4sVnLvboPLPNpprFEF9FMbp29IKYktQ3UKE9xVjOeA
         vCDLdRq0bBdXoMbT/kD+iZlCaxJVyzGA2wLHNx8PvaoM3+T/btjjVR/rJDfDMo/IlGvi
         sUOpqS223Vdhk3AJ2Ec1LJihU7RF7n6pzdcVHsl79gmg77RcfoDnw2hiBlmpoTbifQkU
         4N7vsKqSFA7O3qyS4nJmRkclp8aC3P9gdUQ0h5aHdvPPdv6vH7AWgrlvHkZCrKf51XSs
         EU3mPR3hNrQoUe9/6S3myacceMPTXmDqovlDOozqepTa/6f9CNyky2tJMxKWG1VQ6ldY
         f4bQ==
X-Gm-Message-State: APjAAAU8BJ3IPQp9+QDlwHSY4K+Z6SmmkLRKKOinq9I5+V+nVnjGbWDH
        I/099aEGNFeNHA9nhJEwocQ=
X-Google-Smtp-Source: APXvYqwrdwb9Q2xye1ZFGows1BUzTkbEz1gkduJF8cE1mtMeXalxTYxE0P0hjj2/UCkN3jFqESA6vg==
X-Received: by 2002:a17:902:d20a:: with SMTP id t10mr42196002ply.226.1564088665449;
        Thu, 25 Jul 2019 14:04:25 -0700 (PDT)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id s5sm26013138pfm.97.2019.07.25.14.04.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Jul 2019 14:04:24 -0700 (PDT)
Subject: Re: [PATCH v7 0/7] Solve postboot supplier cleanup and optimize probe
 ordering
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Saravana Kannan <saravanak@google.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Collins <collinsd@codeaurora.org>,
        kernel-team@android.com
References: <20190724001100.133423-1-saravanak@google.com>
 <20190725134214.GD11115@kroah.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <99ca3252-55af-8eea-7653-8347b0a1ab03@gmail.com>
Date:   Thu, 25 Jul 2019 14:04:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190725134214.GD11115@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/25/19 6:42 AM, Greg Kroah-Hartman wrote:
> On Tue, Jul 23, 2019 at 05:10:53PM -0700, Saravana Kannan wrote:
>> Add device-links to track functional dependencies between devices
>> after they are created (but before they are probed) by looking at
>> their common DT bindings like clocks, interconnects, etc.
>>
>> Having functional dependencies automatically added before the devices
>> are probed, provides the following benefits:
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
>> - Supplier devices like clock providers, interconnect providers, etc
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
>> v1 -> v2:
>> - Drop patch to speed up of_find_device_by_node()
>> - Drop depends-on property and use existing bindings
>>
>> v2 -> v3:
>> - Refactor the code to have driver core initiate the linking of devs
>> - Have driver core link consumers to supplier before it's probed
>> - Add support for drivers to edit the device links before probing
>>
>> v3 -> v4:
>> - Tested edit_links() on system with cyclic dependency. Works.
>> - Added some checks to make sure device link isn't attempted from
>>   parent device node to child device node.
>> - Added way to pause/resume sync_state callbacks across
>>   of_platform_populate().
>> - Recursively parse DT node to create device links from parent to
>>   suppliers of parent and all child nodes.
>>
>> v4 -> v5:
>> - Fixed copy-pasta bugs with linked list handling
>> - Walk up the phandle reference till I find an actual device (needed
>>   for regulators to work)
>> - Added support for linking devices from regulator DT bindings
>> - Tested the whole series again to make sure cyclic dependencies are
>>   broken with edit_links() and regulator links are created properly.
>>
>> v5 -> v6:
>> - Split, squashed and reordered some of the patches.
>> - Refactored the device linking code to follow the same code pattern for
>>   any property.
>>
>> v6 -> v7:
>> - No functional changes.
>> - Renamed i to index
>> - Added comment to clarify not having to check property name for every
>>   index
>> - Added "matched" variable to clarify code. No functional change.
>> - Added comments to include/linux/device.h for add_links()
>>
>> I've also not updated this patch series to handle the new patch [1] from
>> Rafael. Will do that once this patch series is close to being Acked.
>>
>> [1] - https://lore.kernel.org/lkml/3121545.4lOhFoIcdQ@kreacher/
> 
> 
> This looks sane to me.  Anyone have any objections for me queueing this
> up for my tree to get into linux-next now?

I would like for the series to get into linux-next sooner than later,
and spend some time there.  

I am _slightly_ more optimistic than Rob that sitting in linux-next for
an extended period might reveal any latent issues, so I would like for
the series to be in linux-next for an extended period of time.  (Yes,
my understanding is that Linus does not like patches to be in linux-next
if they are not targeted for the next merge window, but I prefer that
this patch series spend as much time in linux-next as possible).

I have been waiting for the changes to settle down before bringing up
the issue of devicetree overlays.  Now that the code seems to be
settling down, I need to look at how these changes impact overlays.
So I do not think the patches will be ready for a Linus pull request
until overlays are considered.

-Frank

> 
> thanks,
> 
> greg k-h
> 

