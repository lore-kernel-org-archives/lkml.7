Return-Path: <SRS0=py8C=WU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1D5EC3A59E
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 07:42:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0A612146E
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 07:42:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="UuCMpAb1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbfHXHmI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Aug 2019 03:42:08 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39185 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726076AbfHXHmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Aug 2019 03:42:08 -0400
Received: by mail-wr1-f65.google.com with SMTP id t16so10562028wra.6
        for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2019 00:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ip+/2UFsqnRlpVZ0C6S+KUXKzEwaCh99ektOwnbv38M=;
        b=UuCMpAb11y8XQBxUDvyzG/sYs6kCsahahng2dlI1Doyc765+ekid3Qe81k/e1RHZUW
         65+batFV8m3njiH+RyVaJ6mzjqtRlT76OpnyoWMhIfFga7gmJ14chi300sp2IIpysc3b
         tBu1Kz5X7ybLQxnrMPqUUkJy0a5oMTurfs9q6DBcGlUhCfxTURPCp66IEYx116QJ2OgP
         OaUaxYlRk+BIQz+v/Q49UE9WXFRoSHAoxXwFYh9DnSthSp3kBaRiP3ZyodTGamgZ/HTH
         uDFjluKeCAmm5OTvxdnM9GTHaViSQHxcAoeUSdw+QtfuKNz/X3FKIulLhKa/lA6uxuug
         Nbag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ip+/2UFsqnRlpVZ0C6S+KUXKzEwaCh99ektOwnbv38M=;
        b=nYFFfxSMdUt+KYrW1eZsa1M50xjcHCtb0TgzSFGN26UZELfcZ5ht97KZdt1f/RkPME
         AIrZHDHDD9nevtRlAHjoYG2g9thwx7qj/QsZc/2kZjx5ycVaNkTsd5oSy8qtaIcXhPvI
         H4TjcmD4mILRsBBB3aZfNxYirYgRT/+qAydkTDaCMdXXpePIitVJOa5RPnWBIuv4d9uR
         L8YApm2/UjBblzYch0xjRBfiK2upYkIVxK7UmfERJRdwkx0hgThsBmFfhyT2BoioVReS
         LWn/agAqQ041ca+edKWjPnBMBKAfkPZSpbV9eywWe3eLGLw/OdE1E4UYd1aSO/hEsXd6
         ig0Q==
X-Gm-Message-State: APjAAAUMC7BIFMddxSKWH6TmTs9mwnFg+Qv6Az/+pVsQ6zqgM1lGS+fg
        6hcJHLeA0BugKx6kzLSrjImzSQ==
X-Google-Smtp-Source: APXvYqz3ZBZz3CY8KRTU2t8eeN5o2vyZN7IdC6zEX1A+AZJ4A51eh54y1FOYtJjw3XetINFyAhHksQ==
X-Received: by 2002:adf:ba4a:: with SMTP id t10mr9322894wrg.325.1566632526261;
        Sat, 24 Aug 2019 00:42:06 -0700 (PDT)
Received: from localhost (jirka.pirko.cz. [84.16.102.26])
        by smtp.gmail.com with ESMTPSA id 74sm9736213wma.15.2019.08.24.00.42.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Aug 2019 00:42:05 -0700 (PDT)
Date:   Sat, 24 Aug 2019 09:42:05 +0200
From:   Jiri Pirko <jiri@resnulli.us>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Horatiu Vultur <horatiu.vultur@microchip.com>,
        roopa@cumulusnetworks.com, nikolay@cumulusnetworks.com,
        davem@davemloft.net, UNGLinuxDriver@microchip.com,
        alexandre.belloni@bootlin.com, allan.nielsen@microchip.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        bridge@lists.linux-foundation.org
Subject: Re: [PATCH 0/3] Add NETIF_F_HW_BRIDGE feature
Message-ID: <20190824074204.GA15041@nanopsycho.orion>
References: <1566500850-6247-1-git-send-email-horatiu.vultur@microchip.com>
 <e47a318c-6446-71cd-660c-8592037d8166@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e47a318c-6446-71cd-660c-8592037d8166@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sat, Aug 24, 2019 at 01:25:02AM CEST, f.fainelli@gmail.com wrote:
>On 8/22/19 12:07 PM, Horatiu Vultur wrote:
>> Current implementation of the SW bridge is setting the interfaces in
>> promisc mode when they are added to bridge if learning of the frames is
>> enabled.
>> In case of Ocelot which has HW capabilities to switch frames, it is not
>> needed to set the ports in promisc mode because the HW already capable of
>> doing that. Therefore add NETIF_F_HW_BRIDGE feature to indicate that the
>> HW has bridge capabilities. Therefore the SW bridge doesn't need to set
>> the ports in promisc mode to do the switching.
>
>Then do not do anything when the ndo_set_rx_mode() for the ocelot
>network device is called and indicates that IFF_PROMISC is set and that
>your network port is a bridge port member. That is what mlxsw does AFAICT.

Correct.

>
>As other pointed out, the Linux bridge implements a software bridge by
>default, and because it needs to operate on a wide variety of network
>devices, all with different capabilities, the easiest way to make sure
>that all management (IGMP, BPDU, etc. ) as well as non-management
>traffic can make it to the bridge ports, is to put the network devices
>in promiscuous mode. If this is suboptimal for you, you can take
>shortcuts in your driver that do not hinder the overall functionality.
>
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
>
>-- 
>Florian
