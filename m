Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7AB2C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 22:26:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99DCE205ED
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 22:26:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cumulusnetworks.com header.i=@cumulusnetworks.com header.b="T+4E4T3+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394009AbfHVW0U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 18:26:20 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:33698 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393992AbfHVW0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 18:26:17 -0400
Received: by mail-lj1-f194.google.com with SMTP id z17so7063945ljz.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2019 15:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cumulusnetworks.com; s=google;
        h=subject:from:to:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=tl0f02UPpp3QSnTEonqbC2evIwlfUUJ6tMhF98nlrXY=;
        b=T+4E4T3+BvqIxVHuiB70tNqFlTbRn6cEaa91bPZ4FRi3yJDAbv87VEoDtPgsRahlZG
         GNmis1OL1anAfBZjbf/64jQuoykB2tOpum/BojewUCKcD/o9ZpBLai+c/kAiZSf0ziTN
         /e/xpWHwwMXhHiTJjFIHJM9lke90Rvq3yyySg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tl0f02UPpp3QSnTEonqbC2evIwlfUUJ6tMhF98nlrXY=;
        b=mWlayhkTL5Emm2DnBBtktXWqCJ9PjpcGWG0f8gLET06X6l7/XGzLemU5rPS/8bZGJP
         9HToaN3UdzthZqkFiahF0AkRRGdaOc6RXdJj4wmqjJ2As15kQ3F5LNaHP2yUbADO3uN/
         ihBqaHM8YTif9qqqMlaN7kXYc/Q3ldHaiim2ezW0dKZDYDMu9lRLNLdnyZMjzeEujmBj
         5nsRoR5kT/6UlxBBuYmAaN5gIBcuC3FBF8y0xs/cryB8xZ4c0ItQaAM6lYkk58wfqtSO
         JGB4BDsBScRcjb62aI/X4Zp3UOSfiuV0+EezS35zfDPXPLK2CDWs+MCuTR+JVyre/nZQ
         jn6g==
X-Gm-Message-State: APjAAAX1h71oSSriu+c0aA4t7cHZex5AtRfJkuXumIHJ44kC+4qTCR8Y
        /7J4AsgC08MvVhsZFixbFUAANA==
X-Google-Smtp-Source: APXvYqxdfeo+d4JutVmAzL4NfgsyqnBkCzdtU41GjUmrhW0NwDgPKB7/cjlAnOhaanx2zL6yqI/nOw==
X-Received: by 2002:a2e:9214:: with SMTP id k20mr894743ljg.232.1566512775276;
        Thu, 22 Aug 2019 15:26:15 -0700 (PDT)
Received: from [192.168.0.110] (84-238-136-197.ip.btc-net.bg. [84.238.136.197])
        by smtp.googlemail.com with ESMTPSA id o9sm235103ljc.51.2019.08.22.15.26.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Aug 2019 15:26:14 -0700 (PDT)
Subject: Re: [PATCH 0/3] Add NETIF_F_HW_BRIDGE feature
From:   Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
To:     Horatiu Vultur <horatiu.vultur@microchip.com>,
        roopa@cumulusnetworks.com, davem@davemloft.net,
        UNGLinuxDriver@microchip.com, alexandre.belloni@bootlin.com,
        allan.nielsen@microchip.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, bridge@lists.linux-foundation.org
References: <1566500850-6247-1-git-send-email-horatiu.vultur@microchip.com>
 <1e16da88-08c5-abd5-0a3e-b8e6c3db134a@cumulusnetworks.com>
Message-ID: <b2c52206-82d1-ef28-aeec-a5dcdbe9df6c@cumulusnetworks.com>
Date:   Fri, 23 Aug 2019 01:26:12 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1e16da88-08c5-abd5-0a3e-b8e6c3db134a@cumulusnetworks.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/23/19 1:09 AM, Nikolay Aleksandrov wrote:
> On 22/08/2019 22:07, Horatiu Vultur wrote:
>> Current implementation of the SW bridge is setting the interfaces in
>> promisc mode when they are added to bridge if learning of the frames is
>> enabled.
>> In case of Ocelot which has HW capabilities to switch frames, it is not
>> needed to set the ports in promisc mode because the HW already capable of
>> doing that. Therefore add NETIF_F_HW_BRIDGE feature to indicate that the
>> HW has bridge capabilities. Therefore the SW bridge doesn't need to set
>> the ports in promisc mode to do the switching.
>> This optimization takes places only if all the interfaces that are part
>> of the bridge have this flag and have the same network driver.
>>
>> If the bridge interfaces is added in promisc mode then also the ports part
>> of the bridge are set in promisc mode.
>>
>> Horatiu Vultur (3):
>>   net: Add HW_BRIDGE offload feature
>>   net: mscc: Use NETIF_F_HW_BRIDGE
>>   net: mscc: Implement promisc mode.
>>
>>  drivers/net/ethernet/mscc/ocelot.c | 26 ++++++++++++++++++++++++--
>>  include/linux/netdev_features.h    |  3 +++
>>  net/bridge/br_if.c                 | 29 ++++++++++++++++++++++++++++-
>>  net/core/ethtool.c                 |  1 +
>>  4 files changed, 56 insertions(+), 3 deletions(-)
>>
> 

Just to clarify:
> IMO the name is misleading.
- that's not mandatory or anything, just saying people might get confused when they see it

> Why do the devices have to be from the same driver ? This is too specific targeting some
> devices. The bridge should not care what's the port device, it should be the other way
That was mostly a rhetorical question, it's obvious why but please add an explanation
at least in the commit message and please fix the typos in the comment. Also HW
is capable of doing switching, this needs some clarification that the whole process
stays in HW IIUC. More details here would be great.

> around, so adding device-specific code to the bridge is not ok. Isn't there a solution
> where you can use NETDEV_JOIN and handle it all from your driver ?
> Would all HW-learned entries be hidden from user-space in this case ?
> 
I.e. isn't there a way to do this without introducing a new feature flag ?
 

