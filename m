Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34364C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 22:09:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD74321744
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 22:09:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cumulusnetworks.com header.i=@cumulusnetworks.com header.b="ZI42VLIf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393850AbfHVWJy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 18:09:54 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45299 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390311AbfHVWJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 18:09:54 -0400
Received: by mail-wr1-f66.google.com with SMTP id q12so6772718wrj.12
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2019 15:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cumulusnetworks.com; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=M+oIdnD3jm/q0FEoEMnIGzoD27Ik3dMH4NYQUO8iSBo=;
        b=ZI42VLIf3XR0ok5i+0x5WISOnHyGwIZxT87RAf5JOkT72TxGxOM5SLOZYlrOMK2Lz0
         /pMXLKJ9Bp6o+JdDPyTNehpyrMiXLKq/THe45t1S8Y9iG0NX2rg/tiUPjo6oBHCdZUgS
         H9MYSXYdU+sMDcOmye0Qxn0PQG2F3X8yS+ekQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=M+oIdnD3jm/q0FEoEMnIGzoD27Ik3dMH4NYQUO8iSBo=;
        b=niHCT8aBUBDC4UDbDUaojGezmmIe6kS5UbkMyUBLD5rEueQKZX5BNzUBk+AV2CBG9A
         cwuGV8kjYx4gUHkqBRI5mkY9HzlReykd1Ms6c3jfWUW0rWYcGw53xIJdWaHm7eANkcm3
         +BOBErcK/tErKMb3RdMWZf+kwGI9QRcALChVKK04zyDLSL0pzS8mt/MPD6uyPKpRHdCf
         dnailchxeNzMioz15kd7bRR8mM5nYHDuSqzBriVAUCJqYjcg8K5E+hv7kPHEsho/w8Ly
         CUiQ07FPweM8IyljFsvx0R5vq/8XY0lYl5onZpYHgp/KGatnX5FrsTXhS9d7KEVis3rh
         19oQ==
X-Gm-Message-State: APjAAAWT6GjSjSioNsyQrofy04mSzOgoWxQaxUsYlSihr1y+3v+IX62T
        qwr+XZkkqZPzhajZweba5U7sVA==
X-Google-Smtp-Source: APXvYqwhFYLuDgxoml+DLuSpfZTqsK4iafwdRNx6hqMwddGuTcDHWBVBaZxAq1227fwR/ulvrWIyEw==
X-Received: by 2002:adf:e504:: with SMTP id j4mr1064839wrm.222.1566511792353;
        Thu, 22 Aug 2019 15:09:52 -0700 (PDT)
Received: from [192.168.0.107] (84-238-136-197.ip.btc-net.bg. [84.238.136.197])
        by smtp.gmail.com with ESMTPSA id c11sm590230wrs.86.2019.08.22.15.09.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Aug 2019 15:09:51 -0700 (PDT)
Subject: Re: [PATCH 0/3] Add NETIF_F_HW_BRIDGE feature
To:     Horatiu Vultur <horatiu.vultur@microchip.com>,
        roopa@cumulusnetworks.com, davem@davemloft.net,
        UNGLinuxDriver@microchip.com, alexandre.belloni@bootlin.com,
        allan.nielsen@microchip.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, bridge@lists.linux-foundation.org
References: <1566500850-6247-1-git-send-email-horatiu.vultur@microchip.com>
From:   Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <1e16da88-08c5-abd5-0a3e-b8e6c3db134a@cumulusnetworks.com>
Date:   Fri, 23 Aug 2019 01:09:50 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1566500850-6247-1-git-send-email-horatiu.vultur@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/08/2019 22:07, Horatiu Vultur wrote:
> Current implementation of the SW bridge is setting the interfaces in
> promisc mode when they are added to bridge if learning of the frames is
> enabled.
> In case of Ocelot which has HW capabilities to switch frames, it is not
> needed to set the ports in promisc mode because the HW already capable of
> doing that. Therefore add NETIF_F_HW_BRIDGE feature to indicate that the
> HW has bridge capabilities. Therefore the SW bridge doesn't need to set
> the ports in promisc mode to do the switching.
> This optimization takes places only if all the interfaces that are part
> of the bridge have this flag and have the same network driver.
> 
> If the bridge interfaces is added in promisc mode then also the ports part
> of the bridge are set in promisc mode.
> 
> Horatiu Vultur (3):
>   net: Add HW_BRIDGE offload feature
>   net: mscc: Use NETIF_F_HW_BRIDGE
>   net: mscc: Implement promisc mode.
> 
>  drivers/net/ethernet/mscc/ocelot.c | 26 ++++++++++++++++++++++++--
>  include/linux/netdev_features.h    |  3 +++
>  net/bridge/br_if.c                 | 29 ++++++++++++++++++++++++++++-
>  net/core/ethtool.c                 |  1 +
>  4 files changed, 56 insertions(+), 3 deletions(-)
> 

IMO the name is misleading.
Why do the devices have to be from the same driver ? This is too specific targeting some
devices. The bridge should not care what's the port device, it should be the other way
around, so adding device-specific code to the bridge is not ok. Isn't there a solution
where you can use NETDEV_JOIN and handle it all from your driver ?
Would all HW-learned entries be hidden from user-space in this case ?



