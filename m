Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 645DFC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 18:20:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2ED3E20811
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 18:20:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UyWyNn4I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727764AbfCNSUu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 14:20:50 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:36425 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726888AbfCNSUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 14:20:50 -0400
Received: by mail-lj1-f196.google.com with SMTP id v10so5693591lji.3;
        Thu, 14 Mar 2019 11:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=BgNew5MgUIOcV+Ksfy+wAI71rERjBI6PZPM6uHdJkak=;
        b=UyWyNn4IjR8CauEfEwAi380BGzpKuq9K/QfxepIARAv+O1xicU+JpgzNSTw3ZUZM6z
         I70AkGrtYXt+RIHxD50eaxjwfdAe8iaZ5bRDV8AFSPaNH/D4P+zOAgSaG/YyS2ojz+vm
         cLtkKz10gNzJQdrHYvX8WimkKfywneLVetUNeXIfNq6bKuY4A19Oxa7jFypCionbEAd8
         pSd9lUsAZJRwlxbUMgiGmV7pUa7KcCFVXsSgazaocqhkgXhUwuuzqjzWzitbvxRd0KVx
         UWhX6MKV+aOtNc/3L60CVI/pM4rDDb+1NTdDvMzQioJrBrWoJ2oBL3Mq0EJ2DmLCTD4H
         C/fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=BgNew5MgUIOcV+Ksfy+wAI71rERjBI6PZPM6uHdJkak=;
        b=MavzOugB7FihpgKN2koSqAgV3g7n2MTwgK4icY/aNqQ7ZUQY+/vYZIy3NGStM/Jeho
         9dsdTjr5ZyRJmqkVwX6NkAwi++VAzax1JVXhQDZJk6lcZiq/H9QJhyuRbNPC6OSN/rTt
         YgeH5IWIK7CihE2hNRDGPzbhE1sXE3apy+9cM9+9+oH5EcWcWTPXqmfYzGCHDg6CjXH0
         U/ggWnyhgd7jWicM98LO7Er5cYxOLyoSaw7KIiD5+VyvDF5YDPDidcrCOFzwYamA+rfk
         CuV0ojwliDvFOUU/AcFuvxpL3xnaPJetp386HCoTodvD7FVAa/vcFpK4cZ5LLKSyrEWv
         7/4Q==
X-Gm-Message-State: APjAAAV7cdWC7g6WKlIlnokcDlPq197G2zBRvwLTqB+bz/cUYI3JZfTc
        RnGFpUVD9yIVMv9KAVtA8GSDdJuL
X-Google-Smtp-Source: APXvYqwL28kTXri5cb3Xt+/dH0FUGbZunWQ1fTAODXksPWbNo/NpZU9MMupgSk6kKYg0U/RYWqcnOQ==
X-Received: by 2002:a2e:965a:: with SMTP id z26mr24309181ljh.59.1552587647222;
        Thu, 14 Mar 2019 11:20:47 -0700 (PDT)
Received: from [192.168.0.20] (59-58-132-95.pool.ukrtel.net. [95.132.58.59])
        by smtp.gmail.com with ESMTPSA id b141sm3109254lfb.72.2019.03.14.11.20.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Mar 2019 11:20:45 -0700 (PDT)
Subject: Re: [Xen-devel][PATCH] xen/netfront: Remove unneeded .resume callback
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        netdev@vger.kernel.org, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org, jgross@suse.com,
        sstabellini@kernel.org, davem@davemloft.net
Cc:     Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
        Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>
References: <20190314131749.25706-1-andr2000@gmail.com>
 <c87d2bfb-b029-6c18-e3ad-cb798055f761@oracle.com>
 <6205819a-af39-8cd8-db87-f3fe047ff064@gmail.com>
 <ecc825e6-89d3-bbd5-5243-5cc66fa93045@oracle.com>
 <b55d4f90-100c-7a2a-9651-c99c06953465@gmail.com>
 <09afcdca-258f-e5ca-5c31-b7fd079eb213@oracle.com>
 <46fe25f2-2db7-496a-cd2c-071cd211ea50@gmail.com>
 <be1f029c-326a-7e8c-f1f8-216b581468e3@oracle.com>
From:   Oleksandr Andrushchenko <andr2000@gmail.com>
Message-ID: <75a47ba2-4524-6309-a758-490471d15c5f@gmail.com>
Date:   Thu, 14 Mar 2019 20:20:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <be1f029c-326a-7e8c-f1f8-216b581468e3@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/14/19 20:16, Boris Ostrovsky wrote:
> On 3/14/19 12:33 PM, Oleksandr Andrushchenko wrote:
>> On 3/14/19 17:40, Boris Ostrovsky wrote:
>>> On 3/14/19 11:10 AM, Oleksandr Andrushchenko wrote:
>>>> On 3/14/19 5:02 PM, Boris Ostrovsky wrote:
>>>>> On 3/14/19 10:52 AM, Oleksandr Andrushchenko wrote:
>>>>>> On 3/14/19 4:47 PM, Boris Ostrovsky wrote:
>>>>>>> On 3/14/19 9:17 AM, Oleksandr Andrushchenko wrote:
>>>>>>>> From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
>>>>>>>>
>>>>>>>> Currently on driver resume we remove all the network queues and
>>>>>>>> destroy shared Tx/Rx rings leaving the driver in its current state
>>>>>>>> and never signaling the backend of this frontend's state change.
>>>>>>>> This leads to the number of consequences:
>>>>>>>> - when frontend withdraws granted references to the rings etc. it
>>>>>>>> cannot
>>>>>>>>       be cleanly done as the backend still holds those (it was not
>>>>>>>> told to
>>>>>>>>       free the resources)
>>>>>>>> - it is not possible to resume driver operation as all the
>>>>>>>> communication
>>>>>>>>       means with the backned were destroyed by the frontend, thus
>>>>>>>>       making the frontend appear to the guest OS as functional, but
>>>>>>>>       not really.
>>>>>>> What do you mean? Are you saying that after resume you lose
>>>>>>> connectivity?
>>>>>> Exactly, if you take a look at the .resume callback as it is now
>>>>>> what it does it destroys the rings etc. and never notifies the
>>>>>> backend
>>>>>> of that, e.g. it stays in, say, connected state with communication
>>>>>> channels destroyed. It never goes into any other Xen bus state, so
>>>>>> there is
>>>>>> no way its state machine can help recovering.
>>>>> My tree is about a month old so perhaps there is some sort of
>>>>> regression
>>>>> but this certainly works for me. After resume netfront gets
>>>>> XenbusStateInitWait from backend which causes xennet_connect().
>>>> Ah, the difference can be of the way we get the guest enter
>>>> the suspend state. I am making my guest to suspend with:
>>>> echo mem > /sys/power/state
>>>> And then I use an interrupt to the guest (this is a test code)
>>>> to wake it up.
>>>> Could you please share your exact use-case when the guest enters
>>>> suspend
>>>> and what you do to resume it?
>>> xl save / xl restore
>>>
>>>> I can see no way backend may want enter XenbusStateInitWait in my
>>>> use-case
>>>> as it simply doesn't know we want him to.
>>> Yours looks like ACPI path, I don't know how well it was tested TBH.
>> Hm, so it does work for your use-case, but doesn't for mine.
>>
>> What would be the best way forward?
>>
>> 1. Implement .resume properly as, for example, block front does [1]
>>
>> 2. Remove .resume completely: this does work as long as backend
>> doesn't change anything
> For save/restore (migration) there is no guarantee that the new backend
> has the same set of features.
>
>> I am still a bit unsure if we really need to re-initialize rings,
>> re-read front's config from
>>
>> Xenstore etc - what changes on backend side are expected when we
>> resume the front driver?
>
> Number of queues, for example. Or things in xennet_fix_features().
Ok, so it seems I have no choice, but implement proper .resume then )
>
> -boris
Thank you!
>>>
>>> -boris
>> Thank you,
>>
>> Oleksandr
>>
>>
>> [1]
>> https://elixir.bootlin.com/linux/v5.0.2/source/drivers/block/xen-blkfront.c#L2072
>>
