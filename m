Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E077DC7618B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 14:21:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 940042070D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 14:21:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cumulusnetworks.com header.i=@cumulusnetworks.com header.b="NDD9Bysp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387842AbfG2OVL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 10:21:11 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33915 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387813AbfG2OVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 10:21:10 -0400
Received: by mail-wr1-f67.google.com with SMTP id 31so62108164wrm.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 07:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cumulusnetworks.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jYeAreXZkpeRmGyTNDMAkstl+DgUacK6YuylrpO0VuI=;
        b=NDD9ByspwUWrirE6DQ7CY5fcduTsFPxzHG1Q0FYKIM3X/ft9Ej2ex+AF1RJaG8DbXw
         vOcxcWN/XLiamR9LtpzfKP79HlbRpM0Km6jmdCV7YNMPAccJUfjbSeZWxXObWEKbOdP0
         jl2640HrABQgy2+wfNrqOJ8UboQHUpYSAKpks=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jYeAreXZkpeRmGyTNDMAkstl+DgUacK6YuylrpO0VuI=;
        b=YlPxVAxnAJI4K+Jkee6B/O1idUFgc6vt1V64wavn8F9vYGd+xQjuFK/gnBAOtvRWS3
         rb73USKo++GvBpk14mGoX+eP6cSYigh1mLc4JwIxZmuwlJjsx7LyMj09DTVwWxnhyVUh
         d7B4zyVj7fK4Emb2wiHbmw1dahLU/0XCMTaJJqRP7HG4Rr5/vDt/eNFtgiGAXbzmJhnV
         iQqlnKog5Bz70QemqDbUUbQ9gRWEDvxxpHG8CIiKMtU5RY2t/lnBFvY67Q+rkTA9hYXm
         qyyWuKaJrr8W/666r3NTogvkEtg/nNxkAR/iMQnObIUoLOYIZ1BaSZ1MHp5FSZIK1nSe
         2wAA==
X-Gm-Message-State: APjAAAXnZABS6xni0oK8tSIhXteRpoiphLBD8e8THFrrnc8DFzi4JJ3W
        4qDW7++bMhWnAbAKsBTB3OX5ohES7xg=
X-Google-Smtp-Source: APXvYqzU7BwHJbtdPKKJeCsbMG3ib6n+ls+MsuKYcgV5etREcg9rBUhaKA5FcuGImpmI1twRpG1u6Q==
X-Received: by 2002:adf:ea4c:: with SMTP id j12mr125728562wrn.75.1564410068458;
        Mon, 29 Jul 2019 07:21:08 -0700 (PDT)
Received: from [192.168.0.107] (84-238-136-197.ip.btc-net.bg. [84.238.136.197])
        by smtp.gmail.com with ESMTPSA id g2sm53851307wmh.0.2019.07.29.07.21.07
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jul 2019 07:21:07 -0700 (PDT)
Subject: Re: [PATCH] net: bridge: Allow bridge to joing multicast groups
To:     "Allan W. Nielsen" <allan.nielsen@microchip.com>
Cc:     Horatiu Vultur <horatiu.vultur@microchip.com>,
        roopa@cumulusnetworks.com, davem@davemloft.net,
        bridge@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <eef063fe-fd3a-7e02-89c2-e40728a17578@cumulusnetworks.com>
 <20190725142101.65tusauc6fzxb2yp@soft-dev3.microsemi.net>
 <b9ce433a-3ef7-fe15-642a-659c5715d992@cumulusnetworks.com>
 <e6ad982f-4706-46f9-b8f0-1337b09de350@cumulusnetworks.com>
 <20190726120214.c26oj5vks7g5ntwu@soft-dev3.microsemi.net>
 <b755f613-e6d8-a2e6-16cd-6f13ec0a6ddc@cumulusnetworks.com>
 <20190729121409.wa47uelw5f6l4vs4@lx-anielsen.microsemi.net>
 <95315f9e-0d31-2d34-ba50-11e1bbc1465c@cumulusnetworks.com>
 <20190729131420.tqukz55tz26jkg73@lx-anielsen.microsemi.net>
 <3cc69103-d194-2eca-e7dd-e2fa6a730223@cumulusnetworks.com>
 <20190729135205.oiuthcyesal4b4ct@lx-anielsen.microsemi.net>
From:   Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <e4cd0db9-695a-82a7-7dc0-623ded66a4e5@cumulusnetworks.com>
Date:   Mon, 29 Jul 2019 17:21:06 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190729135205.oiuthcyesal4b4ct@lx-anielsen.microsemi.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/07/2019 16:52, Allan W. Nielsen wrote:
> The 07/29/2019 15:50, Nikolay Aleksandrov wrote:
>> On 29/07/2019 15:22, Nikolay Aleksandrov wrote:
>>> Hi Allan,
>>> On 29/07/2019 15:14, Allan W. Nielsen wrote:
>>>> First of all, as mentioned further down in this thread, I realized that our
>>>> implementation of the multicast floodmasks does not align with the existing SW
>>>> implementation. We will change this, such that all multicast packets goes to the
>>>> SW bridge.
>>>>
>>>> This changes things a bit, not that much.
>>>>
>>>> I actually think you summarized the issue we have (after changing to multicast
>>>> flood-masks) right here:
>>>>
>>>> The 07/26/2019 12:26, Nikolay Aleksandrov wrote:
>>>>>>> Actually you mentioned non-IP traffic, so the querier stuff is not a problem. This
>>>>>>> traffic will always be flooded by the bridge (and also a copy will be locally sent up).
>>>>>>> Thus only the flooding may need to be controlled.
>>>>
>>>> This seems to be exactly what we need.
>>>>
>>>> Assuming we have a SW bridge (br0) with 4 slave interfaces (eth0-3). We use this
>>>> on a network where we want to limit the flooding of frames with dmac
>>>> 01:21:6C:00:00:01 (which is non IP traffic) to eth0 and eth1.
>>>>
>>>> One way of doing this could potentially be to support the following command:
>>>>
>>>> bridge fdb add    01:21:6C:00:00:01 port eth0
>>>> bridge fdb append 01:21:6C:00:00:01 port eth1
>>>>
>>
>> And the fdbs become linked lists?
> Yes, it will most likely become a linked list
> 
>> So we'll increase the complexity for something that is already supported by
>> ACLs (e.g. tc) and also bridge per-port multicast flood flag ?
> I do not think it can be supported with the facilities we have today in tc.
> 
> We can do half of it (copy more fraems to the CPU) with tc, but we can not limit
> the floodmask of a frame with tc (say we want it to flood to 2 out of 4 slave
> ports).
> 

Why not ? You attach an egress filter for the ports and allow that dmac on only
2 of the ports.

>> I'm sorry but that doesn't sound good to me for a case which is very rare and
>> there are existing ways to solve without incurring performance hits or increasing
>> code complexity.
> I do not consider it rarely, controling the forwarding of L2 multicast frames is
> quite common in the applications we are doing.
> 
>> If you find a way to achieve this without incurring a performance hit or significant
>> code complexity increase, and without breaking current use-cases (e.g. unexpected default
>> forwarding behaviour changes) then please send a patch and we can discuss it further with
>> all details present. People have provided enough alternatives which avoid all of the
>> problems.
> Will do, thanks for the guidance.
> 
> /Allan
> 

