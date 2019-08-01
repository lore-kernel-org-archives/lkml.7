Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AED4C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 15:25:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEA2F2087E
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 15:25:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cumulusnetworks.com header.i=@cumulusnetworks.com header.b="fa0Lc6jl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732558AbfHAPZZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 11:25:25 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46067 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbfHAPZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 11:25:25 -0400
Received: by mail-wr1-f66.google.com with SMTP id f9so74022453wre.12
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2019 08:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cumulusnetworks.com; s=google;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jN+visfm/JVvW47OK9SNg6KFhK5M3NjJ7kMqd0bwt2o=;
        b=fa0Lc6jlYXBAImlnDD+gQdo7H8iu30h/vkDH/jchBKD/To6phuNW85Nnx1MH4OZ5EF
         tc9BBWieW+q5W+OaQsY+eINTsnfq45tXIXAJh+BvVR/NNA9lIjipS4YkZXSEZBfc6RYv
         t48Ypi5u10WLWwBYN9iF7hWa+X0af2mTGuzqo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jN+visfm/JVvW47OK9SNg6KFhK5M3NjJ7kMqd0bwt2o=;
        b=LiUTSmhBSgCYn5xqzBSrr620f/HDY4LVICtCSXYzXRvgOd2DVGn5W2y2/mqgicZVAR
         wMIQMwDUJRHW3secN73CpcIXNwHm+T5Zz65sIC8OoEGBwecZS8PEsEBuuZPTe1CV79zf
         KvBRGzH1Ad9R6ghqE8Ndbe4l9Oc6i4SQHAM2vwCgmYTeGtUMDgSgNA8hduRtjfmw6ffg
         SCnz+OtOyF4KJr9ddNQftKeF5WmTyo+IkHqn4RU91IhY7Luve9urM8D9WAM2mBjxVlAN
         Ch3ENm5noikeWMxkyRy4chig8qhU+zWMkCV//bjpCr+eL5EGetqIodP8W6G8efmzJ3Wo
         tVnw==
X-Gm-Message-State: APjAAAXmq/SRmeqxWMbfRZxrxzkiXOLKDMMkPiuBzH2VqTS4rBHgS+wp
        UaZVe90HRcK4lSTr6nyP17LEvQ==
X-Google-Smtp-Source: APXvYqy3AzQj7ZRUKUARpPdJMBXtIMqOYS2ZWg0qrSxm8qsNQXKAOJCG5lc1wvUIVZ3/1RpHxRAbPw==
X-Received: by 2002:adf:f2d0:: with SMTP id d16mr44642500wrp.221.1564673122364;
        Thu, 01 Aug 2019 08:25:22 -0700 (PDT)
Received: from [192.168.0.107] (84-238-136-197.ip.btc-net.bg. [84.238.136.197])
        by smtp.gmail.com with ESMTPSA id s3sm73593060wmh.27.2019.08.01.08.25.20
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Aug 2019 08:25:21 -0700 (PDT)
Subject: Re: [net-next,rfc] net: bridge: mdb: Extend with multicast LLADDR
From:   Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
To:     Horatiu Vultur <horatiu.vultur@microchip.com>, idosch@mellanox.com,
        andrew@lunn.ch, allan.nielsen@microchip.com
Cc:     davem@davemloft.net, roopa@cumulusnetworks.com, petrm@mellanox.com,
        tglx@linutronix.de, fw@strlen.de, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, bridge@lists.linux-foundation.org
References: <1564663840-27721-1-git-send-email-horatiu.vultur@microchip.com>
 <f758fdbf-4e0a-57b3-f13d-23e893ba7458@cumulusnetworks.com>
 <1db865a6-9deb-fbd2-dee6-83609fcc2d95@cumulusnetworks.com>
 <696c9bcc-f7e3-3d22-69c4-cdf4f37280a9@cumulusnetworks.com>
Message-ID: <10768371-da37-7829-a427-8c65a0929138@cumulusnetworks.com>
Date:   Thu, 1 Aug 2019 18:25:19 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <696c9bcc-f7e3-3d22-69c4-cdf4f37280a9@cumulusnetworks.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/08/2019 17:15, Nikolay Aleksandrov wrote:
> On 01/08/2019 17:11, Nikolay Aleksandrov wrote:
>> On 01/08/2019 17:07, Nikolay Aleksandrov wrote:
>>> Hi Horatiu,
>>> Overall I think MDB is the right way, we'd like to contain the multicast code.
>>> A few comments below.
>>>
>>> On 01/08/2019 15:50, Horatiu Vultur wrote:
>> [snip]
>>>>
>>>> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
>>>> Co-developed-by: Allan W. Nielsen <allan.nielsen@microchip.com>
>>>> Signed-off-by: Allan W. Nielsen <allan.nielsen@microchip.com>
>>>> ---
>>>>  include/linux/if_bridge.h      |  1 +
>>>>  include/uapi/linux/if_bridge.h |  1 +
>>>>  net/bridge/br_device.c         |  7 +++++--
>>>>  net/bridge/br_forward.c        |  3 ++-
>>>>  net/bridge/br_input.c          | 13 ++++++++++--
>>>>  net/bridge/br_mdb.c            | 47 +++++++++++++++++++++++++++++++++++-------
>>>>  net/bridge/br_multicast.c      |  4 +++-
>>>>  net/bridge/br_private.h        |  3 ++-
>>>>  8 files changed, 64 insertions(+), 15 deletions(-)
>>>>
>>>
>>> Overall I don't think we need this BR_PKT_MULTICAST_L2, we could do the below much
>>> easier and without the checks if you use a per-mdb flag that says it's to be treated
>>> as a MULTICAST_L2 entry. Then you remove all of the BR_PKT_MULTICAST_L2 code (see the
>>> attached patch based on this one for example). and continue processing it as it is processed today.
>>> We'll keep the fast-path with minimal number of new conditionals.
>>>
>>> Something like the patch I've attached to this reply, note that it is not complete
>>> just to show the intent, you'll have to re-work br_mdb_notify() to make it proper
>>> and there're most probably other details I've missed. If you find even better/less
>>> complex way to do it then please do.
>>>
>>> Cheers,
>>>  Nik
>>
>> Oops, I sent back your original patch. Here's the actually changed version
>> I was talking about.
>>
>> Thanks,
>>  Nik
>>
>>
>>
> 
> The querier exists change is a hack just to get the point, I'd prefer
> to re-write that portion in a better way which makes more sense, i.e.
> get that check out of there since it doesn't mean that an actual querier
> exists. :)
> 

TBH, I'm inclined to just use proto == 0 *internally* as this even though it's reserved,
we're not putting it on the wire or using it to construct packets, it's just internal
use which can change into a flag if some day that value needs to be used. Obviously
to user-space we need it to be a flag, we can't expose or configure it as a proto value
without making it permanent uapi. I haven't looked into detail how feasible this is,
just a thought that might make it simpler.



