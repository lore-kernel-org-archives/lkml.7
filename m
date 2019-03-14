Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23AE0C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 19:00:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0D102186A
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 19:00:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727669AbfCNTAG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 15:00:06 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:48780 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727034AbfCNTAF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 15:00:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 37D19A78;
        Thu, 14 Mar 2019 12:00:05 -0700 (PDT)
Received: from [10.37.12.84] (unknown [10.37.12.84])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A719A3F59C;
        Thu, 14 Mar 2019 12:00:02 -0700 (PDT)
Subject: Re: [Xen-devel] [PATCH] xen/netfront: Remove unneeded .resume
 callback
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Oleksandr Andrushchenko <andr2000@gmail.com>,
        netdev@vger.kernel.org, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org, jgross@suse.com,
        sstabellini@kernel.org, davem@davemloft.net
Cc:     Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
References: <20190314131749.25706-1-andr2000@gmail.com>
 <c87d2bfb-b029-6c18-e3ad-cb798055f761@oracle.com>
 <6205819a-af39-8cd8-db87-f3fe047ff064@gmail.com>
 <ecc825e6-89d3-bbd5-5243-5cc66fa93045@oracle.com>
 <b55d4f90-100c-7a2a-9651-c99c06953465@gmail.com>
 <09afcdca-258f-e5ca-5c31-b7fd079eb213@oracle.com>
From:   Julien Grall <julien.grall@arm.com>
Message-ID: <3e868e7a-4872-e8ab-fd2c-90917ad6d593@arm.com>
Date:   Thu, 14 Mar 2019 19:00:00 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <09afcdca-258f-e5ca-5c31-b7fd079eb213@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 3/14/19 3:40 PM, Boris Ostrovsky wrote:
> On 3/14/19 11:10 AM, Oleksandr Andrushchenko wrote:
>> On 3/14/19 5:02 PM, Boris Ostrovsky wrote:
>>> On 3/14/19 10:52 AM, Oleksandr Andrushchenko wrote:
>>>> On 3/14/19 4:47 PM, Boris Ostrovsky wrote:
>>>>> On 3/14/19 9:17 AM, Oleksandr Andrushchenko wrote:
>>>>>> From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
>>>>>>
>>>>>> Currently on driver resume we remove all the network queues and
>>>>>> destroy shared Tx/Rx rings leaving the driver in its current state
>>>>>> and never signaling the backend of this frontend's state change.
>>>>>> This leads to the number of consequences:
>>>>>> - when frontend withdraws granted references to the rings etc. it
>>>>>> cannot
>>>>>>      be cleanly done as the backend still holds those (it was not
>>>>>> told to
>>>>>>      free the resources)
>>>>>> - it is not possible to resume driver operation as all the
>>>>>> communication
>>>>>>      means with the backned were destroyed by the frontend, thus
>>>>>>      making the frontend appear to the guest OS as functional, but
>>>>>>      not really.
>>>>> What do you mean? Are you saying that after resume you lose
>>>>> connectivity?
>>>> Exactly, if you take a look at the .resume callback as it is now
>>>> what it does it destroys the rings etc. and never notifies the backend
>>>> of that, e.g. it stays in, say, connected state with communication
>>>> channels destroyed. It never goes into any other Xen bus state, so
>>>> there is
>>>> no way its state machine can help recovering.
>>>
>>> My tree is about a month old so perhaps there is some sort of regression
>>> but this certainly works for me. After resume netfront gets
>>> XenbusStateInitWait from backend which causes xennet_connect().
>> Ah, the difference can be of the way we get the guest enter
>> the suspend state. I am making my guest to suspend with:
>> echo mem > /sys/power/state
>> And then I use an interrupt to the guest (this is a test code)
>> to wake it up.
>> Could you please share your exact use-case when the guest enters suspend
>> and what you do to resume it?
> 
> 
> xl save / xl restore
> 
>> I can see no way backend may want enter XenbusStateInitWait in my
>> use-case
>> as it simply doesn't know we want him to.
> 
> 
> Yours looks like ACPI path, I don't know how well it was tested TBH.

I remember a series from amazon [1] that plays around suspend and 
hibernation. The patch [2] leads me to think that guest triggered 
suspend/resume does not work properly. It looks like the series has 
never been fully reviewed. Not sure why...

Anyway, from my understanding this series may solve Oleksandr issue. 
However, this would only address the common code side. AFAIK Oleksandr 
is targeting Arm platform. If so, I think this would require more work 
than this series. Arm code still miss few bits properly suspend/resume 
arch specific code (see [2]).

I have a branch on my git to track the series. However, they never have 
been resent after Ian Campbell left Citrix. I would be happy to review 
them if someone wants to pick them up and repost them.

Cheers,

[1] 
https://lists.xenproject.org/archives/html/xen-devel/2018-06/msg00823.html

[2] 
http://xenbits.xen.org/gitweb/?p=people/julieng/linux-arm.git;a=shortlog;h=refs/heads/xen-migration/v2

> 
> 
> -boris
> 
> _______________________________________________
> Xen-devel mailing list
> Xen-devel@lists.xenproject.org
> https://lists.xenproject.org/mailman/listinfo/xen-devel
> 

-- 
Julien Grall
