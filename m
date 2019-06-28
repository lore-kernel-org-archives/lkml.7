Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 776ECC5B57A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 16:41:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43B382086D
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 16:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561740072;
	bh=e4cVI5/BirGjIMBnE9rF+HBaJm6I4oQhhNJFDJBvOQ4=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=ltXpGTVgIjWgddrLT9ztXseKs6LbbCzBn3tv9QXY0bB35WvH1vsULVanFhnz0BuRZ
	 vBiqpUAYm5f3kQ9D+F1xRa7yczy3hXPtRiqbj4UeT58QVsaTE+VER7jY6OzFSVuIjp
	 61o8vvujUGpK9gCETgVliDZkce9gawtqby94Jvwc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbfF1QlL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 12:41:11 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:38333 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726707AbfF1QlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 12:41:10 -0400
Received: by mail-io1-f67.google.com with SMTP id j6so13857926ioa.5
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2019 09:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KD/8y/gRnlN03Hv3M0VtEroiHNnBUv4QKMlPaJ6XTsg=;
        b=cEvGoMioIr9xh9AyXW9bFHtQLhwJqaw0+UrmA+269AEaw86aRJkiIBTEU4cj4RUAx3
         yKHsJH/7tKJrU0t11Jw3upLE3OCXf2mZf4XfQ91aCaAhP1SktqOW31XqCF5iI/sr7xUg
         QHNjIxVWAQcl5K2dqLKgwX8aV1Y4VGEw9ZNRs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KD/8y/gRnlN03Hv3M0VtEroiHNnBUv4QKMlPaJ6XTsg=;
        b=CeKUTccJkZ4v1XttQGqP6aZRyTwbyJKq7wFDQqlPTLA7zKuIF6de2haqW5yrq5UWLK
         RzKQ3Re7Kny5MDhZKIiFz8XsYcfU++vYJ3dwz03PjG78BdI69nNiIZJLh1jX7AoTjPc6
         lFX9Jmy7BrOum4irpClaigIWtGSxkl05nGgPuN0uZddIZwSaCxRnBPOl1ozSosSlatHm
         GJupdw5ZrIOU9UE2876HkE895G3FlYbbwK/6u2w3emd49IQN+R3dQWtzKyfd9xYKI874
         O8uxDO/NfC0vYjXH8pnDjH2zxjagU3h0m+OcTqY2wkBTRUkXVq//7iPYR615PVWNhzV2
         aYmg==
X-Gm-Message-State: APjAAAWJIpgBxL0aKsq95dBZhIVfxecsZ6dEkoNv3Dco+WWt5EO4p5sY
        3huojqzTi+w5vWvoUz6D+UT3Og==
X-Google-Smtp-Source: APXvYqwbPPnDRWt9w9SAx8KXS6VzZYt3bW6G3CDybafVH1596+3Uetpn0et4TRaezY7TOgoCJgmXmA==
X-Received: by 2002:a6b:ba56:: with SMTP id k83mr12351213iof.105.1561740069558;
        Fri, 28 Jun 2019 09:41:09 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id k26sm2149794ios.38.2019.06.28.09.41.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Jun 2019 09:41:08 -0700 (PDT)
Subject: Re: [PATCH 0/2] Use Media Dev Allocator to fix vimc dev lifetime bugs
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Helen Koike <helen.koike@collabora.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <cover.1558667245.git.skhan@linuxfoundation.org>
 <c9160fe7-e880-4070-3959-b9e9177acf54@xs4all.nl>
 <2862ebca-c58f-c265-cc74-8d0f9b943275@collabora.com>
 <1c794ca1-5490-26a4-dc39-f86e05fadc46@linuxfoundation.org>
 <20190616184506.GD5006@pendragon.ideasonboard.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <6e67ae76-6d37-cd70-c05f-1c6b6dd4af1a@linuxfoundation.org>
Date:   Fri, 28 Jun 2019 10:41:07 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190616184506.GD5006@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent,

On 6/16/19 12:45 PM, Laurent Pinchart wrote:
> Hi Shuah,
> 
> On Fri, Jun 14, 2019 at 05:26:46PM -0600, Shuah Khan wrote:
>> On 6/13/19 7:24 AM, Helen Koike wrote:
>>> On 6/13/19 2:44 AM, Hans Verkuil wrote:
>>>> On 5/24/19 5:31 AM, Shuah Khan wrote:
>>>>> media_device is embedded in struct vimc_device and when vimc is removed
>>>>> vimc_device and the embedded media_device goes with it, while the active
>>>>> stream and vimc_capture continue to access it.
>>>>>
>>>>> Fix the media_device lifetime problem by changing vimc to create shared
>>>>> media_device using Media Device Allocator API and vimc_capture getting
>>>>> a reference to vimc module. With this change, vimc module can be removed
>>>>> only when the references are gone. vimc can be removed after vimc_capture
>>>>> is removed.
>>>>>
>>>>> Media Device Allocator API supports just USB devices. Enhance it
>>>>> adding a genetic device allocate interface to support other media
>>>>> drivers.
>>>>>
>>>>> The new interface takes pointer to struct device instead and creates
>>>>> media device. This interface allows a group of drivers that have a
>>>>> common root device to share media device resource and ensure media
>>>>> device doesn't get deleted as long as one of the drivers holds its
>>>>> reference.
>>>>>
>>>>> The new interface has been tested with vimc component driver to fix
>>>>> panics when vimc module is removed while streaming is in progress.
>>>>
>>>> Helen, can you review this series? I'm not sure this is the right approach
>>>> for a driver like vimc, and even if it is, then it is odd that vimc-capture
>>>> is the only vimc module that's handled here.
>>>
>>> Hi Hans,
>>>
>>> Yes, I can take a look. Sorry, I've been a bit busy these days but I'll
>>> try to take a look at this patch series (and the others) asap.
>>>
>>> Helen
>>>
>>>> My gut feeling is that this should be handled inside vimc directly and not
>>>> using the media-dev-allocator.
>>
>> Hi Hans and Helen,
>>
>> I explored fixing the problem within vimc before I went down the path to
>> use Media Device Allocator API. I do think that it is cleaner to go this
>> way and easier to maintain.
>>
>> vimc is a group pf component drivers that rely on the media device vimc
>> in vimc and falls into the use-case Media Device Allocator API is added
>> to address. The release and life-time management happens without vimc
>> component drivers being changed other than using the API to get and put
>> media device reference.
> 
> Our replies crossed each other, please see my reply to Hans. I would
> just like to comment here that if having multiple kernel modules causes
> issue, they can all be merged together. There's no need for vimc to be
> handled through multiple modules (I actually think it's quite
> counterproductive, it only makes it more complex, for no added value).
> 

There are several problems in this group of drivers as far as lifetime
management is concerned. I explained some of it in the patch 2/2

If vimc module is removed while streaming is active, vimc_exit runs
into NULL pointer dereference error when streaming thread tries to
access and lock graph_mutex in the struct media_device.

The primary reason for this is that:

media_device is embedded in struct vimc_device and when vimc is removed
vimc_device and the embedded media_device goes with it, while the active
stream and vimc_capture continue to access it.

If we chose to keep these drivers as component drivers, media device
needs to stick around until all components stop using it. This is tricky
because there is no tie between these set of drivers. vimc module can
be deleted while others are still active. As vimc gets removed, other
component drivers start wanting to access the media device tree.

This is classic media device lifetime problem which could be solved
easily with the way I solved it with this series. I saw this as a
variation on the same use-case we had with sound and media drivers
sharing the media device.

I have a TODO request from you asking to extend Media Device Allocator
API to generic case and not restrict it to USB devices. My thinking is
that this gives a perfect test case to extend the API to be generic
and use to solve this problem.

Collapsing the drivers into one might be lot more difficult and complex
than solving this problem with Media Device Allocator API. This approach
has an added benefit of extending the API to be generic and not just for
USB.

I looked at this as a good way to add generic API and have a great test
case for it. This patch series fixes the problem for the current vimc
architecture.

thanks,
-- Shuah




