Return-Path: <SRS0=py8C=WU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CD89C3A59E
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 12:05:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E900021670
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 12:05:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20150623.gappssmtp.com header.i=@networkplumber-org.20150623.gappssmtp.com header.b="qSY3vN9k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728085AbfHXMFn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Aug 2019 08:05:43 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:44253 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727928AbfHXMFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Aug 2019 08:05:43 -0400
Received: by mail-io1-f67.google.com with SMTP id j4so18033960iog.11
        for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2019 05:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0hvg8EcOFy1hV2UV4sVHiLXXFhFD6hDENq5iidN2YYU=;
        b=qSY3vN9kfRyMrR0s+KtgMC54iFwLVcFRzH9+NcDJCePlL2a8xUzCkuImtzreATJyvq
         VihcLboVrvBQOosXlNGS6P7BXq2Gk+Ex82CskP8ZyojkWoR2uLDDKGgbHphzjV/80Yxe
         AhGH/HKzjwSR/aJx8544cJIpvmePOx+WDhSBkvVL4mGJeNyk3VsmcLwvtaP8ftry8HDK
         42/Ppc2RMtFvE2Xkh55152WJnXm6Z88+JqmnNU7Am+AaErt7G1yd/1EMiJJtUlOvXmNX
         eiEmzTVNUC7P4yvfpA89otsB11yyAPDnF6ueut9V7AROStf57qPAOonQfx8vP7PHsNdf
         gHfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0hvg8EcOFy1hV2UV4sVHiLXXFhFD6hDENq5iidN2YYU=;
        b=ZgNg0myFUUuVRc3ojuo7dW27PQgI6G3JLmJ5DvBECECiGGdm12NfEjOAavSLWjfmCi
         rxjIZup0t1WQWkoQ/ZDXiPKXDhJETV+03Hb0Mik3mt3u1dXO9Kpg4sQL4VhzW3tUp5Vo
         kREJhOKp9kEa3zsMUCJfGh/bj/+WL75Q5y4CegpPtyAz5mSOaJgtu4iR8gpCkvljUAQV
         lKEP7IW/7EYk7Uf/W3JuK3s7h+fulVAEv2vrImejEIY/biBcunRRZjjdbzilIkBPgr4u
         uFqvUO9YFI4RKnNVWstiOulVPmUINPi52U7nds9EDAmT5W8ZwQGQMXWBukWC37rhr5cJ
         zJNA==
X-Gm-Message-State: APjAAAVceZX6oqzFguy4K3IyUx1udLCwv1fCejBB/vQcRHYOVdFaarS2
        OJZtyo5EWYxzhB15pnLH7tWRgg==
X-Google-Smtp-Source: APXvYqyIK4zLPXbh2ON1KZJES4TjV79eN/AeszSh3JNwvu8Vi9/CICCb8AZZeFzPLyPUFQ6pt2GEbg==
X-Received: by 2002:a6b:5116:: with SMTP id f22mr4074585iob.108.1566648342297;
        Sat, 24 Aug 2019 05:05:42 -0700 (PDT)
Received: from xps13.local.tld (cpe-67-255-90-149.maine.res.rr.com. [67.255.90.149])
        by smtp.gmail.com with ESMTPSA id k7sm4651829iop.88.2019.08.24.05.05.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 24 Aug 2019 05:05:42 -0700 (PDT)
Date:   Sat, 24 Aug 2019 08:05:37 -0400
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Horatiu Vultur <horatiu.vultur@microchip.com>
Cc:     <roopa@cumulusnetworks.com>, <nikolay@cumulusnetworks.com>,
        <davem@davemloft.net>, <UNGLinuxDriver@microchip.com>,
        <alexandre.belloni@bootlin.com>, <allan.nielsen@microchip.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <bridge@lists.linux-foundation.org>
Subject: Re: [Bridge] [PATCH 0/3] Add NETIF_F_HW_BRIDGE feature
Message-ID: <20190824080537.5ce7083d@xps13.local.tld>
In-Reply-To: <1566500850-6247-1-git-send-email-horatiu.vultur@microchip.com>
References: <1566500850-6247-1-git-send-email-horatiu.vultur@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Aug 2019 21:07:27 +0200
Horatiu Vultur <horatiu.vultur@microchip.com> wrote:

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

IMHO there are already enough nerd knobs in bridge to support this.
If you hardware can't do real bridging, it is only doing MACVLAN so that
is what you should support instead.
