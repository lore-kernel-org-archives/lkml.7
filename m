Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A03BCA9EC5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 13:19:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5FE820663
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 13:19:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=walle.cc header.i=@walle.cc header.b="swaXjuV0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726284AbfJ3NTp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 09:19:45 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:44545 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726119AbfJ3NTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 09:19:44 -0400
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 01A0722178;
        Wed, 30 Oct 2019 14:19:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc;
        s=mail2016061301; t=1572441582;
        bh=AAz9VVTYfbth/vfQXbH6fAoLXUyTcLI/UaA6b7iXjRI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=swaXjuV0f8nBIy1iXxaXXHTa7fDmCyYrOR6xKWBYwtPfSBfEQnulrYmuK1HDvMPeB
         l9VyhLqFQaozQg0EKgZ2KW7r1GBrenyO3S7jG/D+cyrYHSar8umXvBpszehb6207Er
         cjkxTTs227Xhr8Y4BFj6NcWvJOJgMA6+A7snqZgg=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 30 Oct 2019 14:19:41 +0100
From:   Michael Walle <michael@walle.cc>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 0/3] net: phy: initialize PHYs via device tree properties
In-Reply-To: <c9447284-1c20-6dc7-8629-e62c61a7b4a8@gmail.com>
References: <20191029174819.3502-1-michael@walle.cc>
 <519d52d2-cd83-b544-591b-ca9d9bb16dfa@gmail.com>
 <4B4A80A7-05C8-441A-B224-7CC01E3D8C30@walle.cc>
 <c9447284-1c20-6dc7-8629-e62c61a7b4a8@gmail.com>
Message-ID: <652e6523817a4baa724faf64ea9a939f@walle.cc>
X-Sender: michael@walle.cc
User-Agent: Roundcube Webmail/1.2.3
X-Virus-Scanned: clamav-milter 0.101.4 at web
X-Virus-Status: Clean
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2019-10-29 21:59, schrieb Florian Fainelli:
>>> If all you need is to enable a particular clock, introduce device
>>> specific properties that describe the hardware, and make the 
>>> necessary
>>> change to the local driver that needs to act on those. You can always
>>> define a more generic scope property if you see a recurring pattern.
>> 
>> Could you have a quick look at the following patch I made for u-boot, 
>> which adds a binding for the Atheros PHY. If that is the right 
>> direction. Yeah, I should have made it first to Linux to get some 
>> feedback on the binding :p
>> 
>> https://patchwork.ozlabs.org/patch/1184516/
>> 
>> I'd then prepare another patch for Linux based on your suggestions.
> 
> This looks like the right direction IMHO.

Ok, one question though: There is a clock output, but it just supports 
four frequencies. Should there be a property like 
"atheros,clk-out-frequency = <25000000>" which can take an arbitrary 
number or should it be something like "atheros,clk-out-frequency = 
<AT803X_CLK_OUT_25_MHZ>" (the ti dp83867 uses the latter).

-michael

