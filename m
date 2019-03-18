Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54639C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 10:02:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15B9D2063F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 10:02:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HtcJ5IVH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727493AbfCRKCz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 06:02:55 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:43533 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727194AbfCRKCz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 06:02:55 -0400
Received: by mail-lj1-f196.google.com with SMTP id p20so587218lji.10;
        Mon, 18 Mar 2019 03:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=8kfNWzUrNIKyTzwDSEgw0dfSmuhWCqYTQM2E7ljmhAo=;
        b=HtcJ5IVHN+AiTD/dREac//rgvsmlxLotpKmt5UahX9SZstC0aU/jTnA2eD+rVbbRK5
         XTF+UIwl1zFzqwIFmtpTFLkr7m1kpr9Gul5AMsAx7qo43iCSaKbRt/CZtHJ/90IPrgx4
         Z/SMPOh9ub+WSLCvtGF2NPUdas0H8AY4hks7EdeOJKvkcHXjXpcFojluTc00MViQ2C14
         2oBdJgrGhS91Aw/oYyIzuFyMVxIs6dnDxCn5bPYSQUNtPs85nREkayRWoe13sviSObYU
         u54RUOsEVPXXfMAiGbGT2BiZtbU5I+/p80cb6IqfXtWf7eOOOXr29kSQBrQXr0nwQo7b
         MpPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=8kfNWzUrNIKyTzwDSEgw0dfSmuhWCqYTQM2E7ljmhAo=;
        b=ZVs8ig+FJJdaFNdntkiHDddY8Umi848CvB3qmut1Rg3ODFXterwYs9lF5lopq5b0Ba
         F86G0PwTuAJT+3Dvjxc7Td0lRFFarOQ6Vqc/sej1R0/Em/OYgdVkJN07hbbJ9RzYyc+f
         9fb6bmnfMxnJdWA4zntwTDKd6D7C8cRlCZK2Fhyq6UslkMHch5XS8jBNZPYgemTRIrHS
         BsZfWjru7Z70Vksg6/8+Qt04F0wvPPnW00dOXCkKTGtxoikwRLlGlTGAs3+Vxj4Ci/Kg
         8hXbCf2YOLliiIM0ttOjJC8EaJG2LLksNzQXsUI1xXQAVTXhWYQWJ6aabXvhgYogbDUe
         /IwQ==
X-Gm-Message-State: APjAAAXajVGSxvdUHfbhOIRYxbm9svHqFvG0/AntpWFeP4A9H2qy/2T7
        +8AinMMhBCxeOlEvlh9CK0k=
X-Google-Smtp-Source: APXvYqxP0wzRoiMwRwR1Afx2VOCBpaL/jBNkR115Iya4EG6kK4d5kDGJS0HkXyvN2wnG8tdMiJRoIg==
X-Received: by 2002:a2e:42cf:: with SMTP id h76mr1943708ljf.95.1552903371850;
        Mon, 18 Mar 2019 03:02:51 -0700 (PDT)
Received: from [10.17.182.20] (ll-74.141.223.85.sovam.net.ua. [85.223.141.74])
        by smtp.gmail.com with ESMTPSA id f22sm2178102ljk.18.2019.03.18.03.02.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Mar 2019 03:02:50 -0700 (PDT)
Subject: Re: [Xen-devel] [PATCH] xen/netfront: Remove unneeded .resume
 callback
To:     Julien Grall <julien.grall@arm.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        netdev@vger.kernel.org, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org, jgross@suse.com,
        sstabellini@kernel.org, davem@davemloft.net
Cc:     Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
        kamatam@amazon.com, anchalag@amazon.com, eduval@amazon.com
References: <20190314131749.25706-1-andr2000@gmail.com>
 <c87d2bfb-b029-6c18-e3ad-cb798055f761@oracle.com>
 <6205819a-af39-8cd8-db87-f3fe047ff064@gmail.com>
 <ecc825e6-89d3-bbd5-5243-5cc66fa93045@oracle.com>
 <b55d4f90-100c-7a2a-9651-c99c06953465@gmail.com>
 <09afcdca-258f-e5ca-5c31-b7fd079eb213@oracle.com>
 <3e868e7a-4872-e8ab-fd2c-90917ad6d593@arm.com>
From:   Oleksandr Andrushchenko <andr2000@gmail.com>
Message-ID: <d709d185-5345-c463-3fd1-e711f954e58a@gmail.com>
Date:   Mon, 18 Mar 2019 12:02:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <3e868e7a-4872-e8ab-fd2c-90917ad6d593@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Amazon
pls see inline

On 3/14/19 9:00 PM, Julien Grall wrote:
> Hi,
>
> On 3/14/19 3:40 PM, Boris Ostrovsky wrote:
>> On 3/14/19 11:10 AM, Oleksandr Andrushchenko wrote:
>>> On 3/14/19 5:02 PM, Boris Ostrovsky wrote:
>>>> On 3/14/19 10:52 AM, Oleksandr Andrushchenko wrote:
>>>>> On 3/14/19 4:47 PM, Boris Ostrovsky wrote:
>>>>>> On 3/14/19 9:17 AM, Oleksandr Andrushchenko wrote:
>>>>>>> From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
>>>>>>>
>>>>>>> Currently on driver resume we remove all the network queues and
>>>>>>> destroy shared Tx/Rx rings leaving the driver in its current state
>>>>>>> and never signaling the backend of this frontend's state change.
>>>>>>> This leads to the number of consequences:
>>>>>>> - when frontend withdraws granted references to the rings etc. it
>>>>>>> cannot
>>>>>>>      be cleanly done as the backend still holds those (it was not
>>>>>>> told to
>>>>>>>      free the resources)
>>>>>>> - it is not possible to resume driver operation as all the
>>>>>>> communication
>>>>>>>      means with the backned were destroyed by the frontend, thus
>>>>>>>      making the frontend appear to the guest OS as functional, but
>>>>>>>      not really.
>>>>>> What do you mean? Are you saying that after resume you lose
>>>>>> connectivity?
>>>>> Exactly, if you take a look at the .resume callback as it is now
>>>>> what it does it destroys the rings etc. and never notifies the 
>>>>> backend
>>>>> of that, e.g. it stays in, say, connected state with communication
>>>>> channels destroyed. It never goes into any other Xen bus state, so
>>>>> there is
>>>>> no way its state machine can help recovering.
>>>>
>>>> My tree is about a month old so perhaps there is some sort of 
>>>> regression
>>>> but this certainly works for me. After resume netfront gets
>>>> XenbusStateInitWait from backend which causes xennet_connect().
>>> Ah, the difference can be of the way we get the guest enter
>>> the suspend state. I am making my guest to suspend with:
>>> echo mem > /sys/power/state
>>> And then I use an interrupt to the guest (this is a test code)
>>> to wake it up.
>>> Could you please share your exact use-case when the guest enters 
>>> suspend
>>> and what you do to resume it?
>>
>>
>> xl save / xl restore
>>
>>> I can see no way backend may want enter XenbusStateInitWait in my
>>> use-case
>>> as it simply doesn't know we want him to.
>>
>>
>> Yours looks like ACPI path, I don't know how well it was tested TBH.
>
> I remember a series from amazon [1] that plays around suspend and 
> hibernation. The patch [2] leads me to think that guest triggered 
> suspend/resume does not work properly. It looks like the series has 
> never been fully reviewed. Not sure why...
Julien, thanks a lot for bringing these patches to our attention which 
we obviously missed.
>
> Anyway, from my understanding this series may solve Oleksandr issue. 
> However, this would only address the common code side. AFAIK Oleksandr 
> is targeting Arm platform. If so, I think this would require more work 
> than this series. Arm code still miss few bits properly suspend/resume 
> arch specific code (see [2]).
>
> I have a branch on my git to track the series. However, they never 
> have been resent after Ian Campbell left Citrix. I would be happy to 
> review them if someone wants to pick them up and repost them.
>
First of all, let me make it clear that we are interested in hibernation 
long term, so it would be
desirable to re-use as much work form resume/suspend as we can. But, we 
see it as a step by
step work, e.g. first S2RAM and later on hibernation.
Let me clarify the immediate use-case that we have, so it is easier to 
understand what we want
and what we don't at the moment. We are about to continue work started 
by Mirela/Xilinx on
Suspend-to-RAM for ARM [3] and we made number of assumptions:
1. We are talking about *system* suspend, e.g. the goal is to suspend 
all the components
of the system and Xen itself at once. Think about this as fast-boot 
and/or energy saving
feature if you will.
2. With suspend/resume there is no intention to migrate VMs to any other 
host.
3. Most probably configuration of the back/front won't change between 
suspend/resume.
But long term we are also thinking for supporting suspend/resume in its 
broader meaning,
e.g. what is probably what you mean by suspend/resume.
Given that, we think that we don't need Xen support to save grants, page 
tables and other
VM's context on suspend at least at the first stage as we are 
implementing not a fully
blown suspend/resume, but only S2RAM part of it which is much more 
simpler than a generic
suspend implementation. We only need changes to Linux kernel frontend 
drivers from [1] - the
piece that we miss is suspend/resume implementation in the netfront 
driver. What is more, as
we are not changing back/front configuration, we can even live with 
empty .resume/.suspend
frontend's callbacks because event channels, rings etc. are "statically" 
allocated in our
use-case at the first system start (cold boot). And indeed, tests show 
that waking domains
in the right order do allow that.
So, frankly, from [3] we are immediately interested in implementing 
.resume/.suspend, not
even freeze/thaw/restore callbacks: if Amazon has will and capacity to 
continue working on [3]
then once that gets into the upstream it also solves our S2RAM use-case, 
but if not then we
can probably re-work netfront patch and only provide .resume/.suspend 
callbacks which we need
for now (remember our very specific use-case which can survive suspend 
without callbacks
implemented).
IMO, patches at [2] seem to be useful while implementing generic 
suspend/resume and can
be postponed for S2RAM.

Julien/Juergen/Boris/Amazon - could you please express your view on the 
above?
Is it acceptable that for now we only take re-worked netfront patch from 
[3] with full
implementation in mind for later (we reuse code for .resume/.suspend)?

> Cheers,
>
> [1] 
> https://lists.xenproject.org/archives/html/xen-devel/2018-06/msg00823.html
>
> [2] 
> http://xenbits.xen.org/gitweb/?p=people/julieng/linux-arm.git;a=shortlog;h=refs/heads/xen-migration/v2
>
[3] 
https://lists.xenproject.org/archives/html/xen-devel/2018-11/msg01093.html
>>
>>
>> -boris
>>
>> _______________________________________________
>> Xen-devel mailing list
>> Xen-devel@lists.xenproject.org
>> https://lists.xenproject.org/mailman/listinfo/xen-devel
>>
>
Thank you,
Oleksandr
