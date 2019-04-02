Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9805BC4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 14:02:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CC702133D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 14:02:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731985AbfDBOC5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 10:02:57 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:43985 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726903AbfDBOC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 10:02:57 -0400
Received: by mail-ed1-f66.google.com with SMTP id d26so11752969ede.10
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 07:02:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FlU3Z1JuAgbkyJeen+qNNV7k4fpbjcTgpkrENWzuQvc=;
        b=V6vw1GZz9WbmlYXoxMy2emRgc/j+AY5j9umu85gdNnG9/vjyW69RVDkPwBVkuBpHxj
         xw37LvEJzR7DS8A6AavpLUblQd3C9nWy8QNMpEVZQU1TvLG/Sqmn4CYWuiyjFTYkpoaM
         TTlD/qXfgH38CX2wYSWRtjDXYMlvzH3FftXOl5zbE6SOKHb1CrJJvZGe6/IQOrUD9YWM
         q5CTgvgr+MQbzmZyAFzLcfKnDYy2FUKEAL6kCa/yZKNMgGRy1q7QRFOGxnDEjagTmtJR
         UdjeKGC7wpA/EK7w/blx8wF6P1oge9U/nhO9JnCAp6D+NPGcTyu7VUVm4CR6UefsKIb3
         zXEw==
X-Gm-Message-State: APjAAAW1AsHZQic5tHaa0/YgPIn7Qo7TcgFDPXp/PTsy+nKKEWqkbyje
        nMlVvUcUyo69lX/Kb4LEuwjpLoLC8ec=
X-Google-Smtp-Source: APXvYqyuvGQo58iJeBhmtnx2xgFCpu9+lPo+JYnSbSvQCBeRSNwC1A33usduV9CCkkgcNw3gamb1dw==
X-Received: by 2002:a17:906:3ed1:: with SMTP id d17mr13360457ejj.221.1554213775149;
        Tue, 02 Apr 2019 07:02:55 -0700 (PDT)
Received: from shalem.localdomain (84-106-84-65.cable.dynamic.v4.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id j46sm3220072eda.72.2019.04.02.07.02.53
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Apr 2019 07:02:54 -0700 (PDT)
Subject: Re: [PATCH] HID: force setting drvdata to NULL when removing the
 driver
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jiri Kosina <jikos@kernel.org>,
        =?UTF-8?Q?Bruno_Pr=c3=a9mont?= <bonbons@linux-vserver.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Jason Gerecke <killertofu@gmail.com>,
        Ping Cheng <pinglinux@gmail.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
References: <20190328155151.577687-1-benjamin.tissoires@redhat.com>
 <CAKdAkRRwKS+wzXjh=gyOQtSEiMwWhArZVc_cwecJsEZ=MGRa8w@mail.gmail.com>
 <CAO-hwJK2yusO2f+oFnUcNGuxo6e_+7F6Cjqmcsuimy4zrm-Jww@mail.gmail.com>
 <a31a6f95-924a-4930-e4df-5576abc694fb@redhat.com>
 <CAO-hwJK5B1uEmw7vnt73k2BLv4YQeLMf_KwS58-LgAOrLfCqhA@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <5a31f086-7f30-bce9-5bdd-0deeb3bffd29@redhat.com>
Date:   Tue, 2 Apr 2019 16:02:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAO-hwJK5B1uEmw7vnt73k2BLv4YQeLMf_KwS58-LgAOrLfCqhA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 02-04-19 16:00, Benjamin Tissoires wrote:
> On Tue, Apr 2, 2019 at 3:52 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> Hi,
>>
>> On 02-04-19 15:44, Benjamin Tissoires wrote:
>>> Hi Dmitry,
>>>
>>> On Fri, Mar 29, 2019 at 11:26 PM Dmitry Torokhov
>>> <dmitry.torokhov@gmail.com> wrote:
>>>>
>>>> Hi Benjamin,
>>>>
>>>> On Thu, Mar 28, 2019 at 8:52 AM Benjamin Tissoires
>>>> <benjamin.tissoires@redhat.com> wrote:
>>>>>
>>>>> Or when the probe failed.
>>>>>
>>>>> This is a common pattern in the HID drivers to reset the drvdata. Some
>>>>> do it properly, some do it only in case of failure.
>>>>> Anyway, it's never a good thing to have breadcrumbs, so force a clean
>>>>> state when removing or when probe is failing.
>>>>
>>>> Just a data point: driver core already clears drvdata, so as long as
>>>> dev_get/set_drvdata() is the same as hid_get/set_drvdata() no special
>>>> handling is needed in HID core.
>>>
>>> You are correct (as always ;-P). I'll drop the hid-core changes and
>>> send a v2 ASAP.
>>
>> I was just looking at the same thing. I should have known about this
>> since I wrote the patch to make the core clear drvdata. I should have
>> mentioned that, but I was assuming that the hid code was special somehow,
>> however now I see it just uses a regular device_add, so indeed the core
>> changes are not necessary.
>>
>> Given the large hid-logitech-*.c patch-set it might be easier for
>> Jiri if you split out the hid-logitech-*.c changes into a separate
>> patch, then he can keep that on his logitech branch (just a thought).
>>
> 
> I do not expect the logitech changes to now create some big conflict.
> But looking at the current for-5.2* branches, I should probably split
> the series per driver given that there is no more dependency on
> hid-core. This way, we can take the logitech changes in the
> for-5.2/logitech branch, and you can rebase your work on top of it.

Great, thank you.

Regards,

Hans
