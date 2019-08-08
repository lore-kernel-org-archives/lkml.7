Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B8F3C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 02:13:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F61B214C6
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 02:13:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s26x7wZ/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727997AbfHHCN3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 22:13:29 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44974 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727230AbfHHCN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 22:13:29 -0400
Received: by mail-pl1-f195.google.com with SMTP id t14so42805317plr.11;
        Wed, 07 Aug 2019 19:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=waXtlB05f+0oT+NAh0dgnin4RN5DOvr8iXtp2qLrgBc=;
        b=s26x7wZ/NEfxbOM94e5VHMPt8a5Dio2+JYoNMUO4g0611FT8R03mNoiscXDDX2tOk5
         kEbz61kvwcbZIXltOIZXRd7kuRt1caFhENum4z7L2qtLpFODOSjPX1asFevjH+Wb6joI
         pkr+JSg3DuwNaJEz2/YAmiU3uIIuI28cJ415aQP83txOR0okPkGUOYNN6QM63REAjSsK
         j2FTT8rTlDmTe/hYKmHdb3VvdMfnqs731KzLYbGbYeJ5Dlmeml8qZDvLYUPaloto9pM8
         tkDnEhYYD1c4qOVXmAh4eT586T31Ud/KvWmsU2H6MZzv8T6cCSGaGx1bp/9mTLkkeKdl
         o8/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=waXtlB05f+0oT+NAh0dgnin4RN5DOvr8iXtp2qLrgBc=;
        b=lZkiRlIIyn6zAixX0vD4F1+epiGP1gcx7bw0CabYVAC2PV2LrGqMBvX1LjSuXk4Sbj
         7FOVg4yK79pb4YREqyNdTvaAHqoOmpU8ThJS4WOB0arMXy7/UujBPGTA6uQlg12r0Aqz
         xlq4Yk0kT57pzXUFThKoP7rRuTIPfi1qibq/3G5a4sPdJPaK9ffL/Nwnr6afxbT4ew9V
         Wnive3b72DQsd4TsYpPUqvfzJHrm7ySAqsUI35jAeYGsme23xe6+GdkLcq5GrISssc/0
         9flPdZdiwA9VRbiDviwnmOC7LlrlfvpeygStVyGPOi/QFvWopKhrKqmWFN/ucxMHoR/+
         lqKg==
X-Gm-Message-State: APjAAAUmoUhVYlWu9ngOXtdQmQZZVIVpxXvNx3RBrrRrCi1IeIB6synS
        6NDCMwCJ3DR7H2U/UJcBPmw=
X-Google-Smtp-Source: APXvYqx4ASLfaRKoPrJcT9DZETsVZVCXhYnKZH2eplpYxXGxd5q3NbyOPRCwveYJCkQ7tsml0c87jQ==
X-Received: by 2002:a17:902:654f:: with SMTP id d15mr10312511pln.253.1565230408376;
        Wed, 07 Aug 2019 19:13:28 -0700 (PDT)
Received: from [192.168.1.70] (c-73-231-235-122.hsd1.ca.comcast.net. [73.231.235.122])
        by smtp.gmail.com with ESMTPSA id h6sm93386700pfb.20.2019.08.07.19.13.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Aug 2019 19:13:27 -0700 (PDT)
Subject: Re: [PATCH v9 0/7] Solve postboot supplier cleanup and optimize probe
 ordering
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Saravana Kannan <saravanak@google.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Collins <collinsd@codeaurora.org>,
        kernel-team@android.com
References: <20190731221721.187713-1-saravanak@google.com>
 <20190801061209.GA3570@kroah.com>
 <5a1e785d-075e-19a0-7d3d-949e1b65d726@gmail.com>
 <20190801193248.GA24916@kroah.com>
 <6366cb2a-65ea-cb44-f765-f246f3fb3bf9@gmail.com>
 <20190802063720.GA12789@kroah.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <05d4f2b2-0395-476d-8c93-37b2b07bdd4f@gmail.com>
Date:   Wed, 7 Aug 2019 19:13:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190802063720.GA12789@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg, Saravana,

On 8/1/19 11:37 PM, Greg Kroah-Hartman wrote:
> On Thu, Aug 01, 2019 at 12:59:25PM -0700, Frank Rowand wrote:
>> On 8/1/19 12:32 PM, Greg Kroah-Hartman wrote:
>>> On Thu, Aug 01, 2019 at 12:28:13PM -0700, Frank Rowand wrote:
>>>> Hi Greg,
>>>>
>>>> On 7/31/19 11:12 PM, Greg Kroah-Hartman wrote:
>>>>> On Wed, Jul 31, 2019 at 03:17:13PM -0700, Saravana Kannan wrote:
>>>>>> Add device-links to track functional dependencies between devices
>>>>>> after they are created (but before they are probed) by looking at
>>>>>> their common DT bindings like clocks, interconnects, etc.
>>>>>>
>>>>>> Having functional dependencies automatically added before the devices
>>>>>> are probed, provides the following benefits:
>>>>>>
>>>>>> - Optimizes device probe order and avoids the useless work of
>>>>>>   attempting probes of devices that will not probe successfully
>>>>>>   (because their suppliers aren't present or haven't probed yet).
>>>>>>
>>>>>>   For example, in a commonly available mobile SoC, registering just
>>>>>>   one consumer device's driver at an initcall level earlier than the
>>>>>>   supplier device's driver causes 11 failed probe attempts before the
>>>>>>   consumer device probes successfully. This was with a kernel with all
>>>>>>   the drivers statically compiled in. This problem gets a lot worse if
>>>>>>   all the drivers are loaded as modules without direct symbol
>>>>>>   dependencies.
>>>>>>
>>>>>> - Supplier devices like clock providers, interconnect providers, etc
>>>>>>   need to keep the resources they provide active and at a particular
>>>>>>   state(s) during boot up even if their current set of consumers don't
>>>>>>   request the resource to be active. This is because the rest of the
>>>>>>   consumers might not have probed yet and turning off the resource
>>>>>>   before all the consumers have probed could lead to a hang or
>>>>>>   undesired user experience.
>>>>>>
>>>>>>   Some frameworks (Eg: regulator) handle this today by turning off
>>>>>>   "unused" resources at late_initcall_sync and hoping all the devices
>>>>>>   have probed by then. This is not a valid assumption for systems with
>>>>>>   loadable modules. Other frameworks (Eg: clock) just don't handle
>>>>>>   this due to the lack of a clear signal for when they can turn off
>>>>>>   resources. This leads to downstream hacks to handle cases like this
>>>>>>   that can easily be solved in the upstream kernel.
>>>>>>
>>>>>>   By linking devices before they are probed, we give suppliers a clear
>>>>>>   count of the number of dependent consumers. Once all of the
>>>>>>   consumers are active, the suppliers can turn off the unused
>>>>>>   resources without making assumptions about the number of consumers.
>>>>>>
>>>>>> By default we just add device-links to track "driver presence" (probe
>>>>>> succeeded) of the supplier device. If any other functionality provided
>>>>>> by device-links are needed, it is left to the consumer/supplier
>>>>>> devices to change the link when they probe.
>>>>>
>>>>> All now queued up in my driver-core-testing branch, and if 0-day is
>>>>> happy with this, will move it to my "real" driver-core-next branch in a
>>>>> day or so to get included in linux-next.
>>>>
>>>> I have been slow in getting my review out.
>>>>
>>>> This patch series is not yet ready for sending to Linus, so if putting
>>>> this in linux-next implies that it will be in your next pull request
>>>> to Linus, please do not put it in linux-next.
>>>
>>> It means that it will be in my pull request for 5.4-rc1, many many
>>> waeeks away from now.
>>
>> If you are willing to revert the series before the pull request _if_ I
>> have significant review issues in the next couple of days, then I am happy
>> to see the patches get exposure in linux-next.
> 
> If you have significant review issues, yes, I will be glad to revert them.

Just a heads up that I have sent review issues in reply to version 7 of this
patch series.

We'll see what the responses are to my review comments, but I am expecting
the changes are big enough to result in a new version (or a couple more
versions) of the patch series.

No rush to revert version 9 since your 5.4-rc1 pull request is still not
near, and I am glad for whatever exposure these patches are getting in
linux-next.

Thanks,

Frank

> 
> thanks,
> 
> greg k-h
> 

