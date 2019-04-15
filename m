Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47FFBC10F13
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 03:07:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 134D02077C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 03:07:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="M6e+n60g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727011AbfDODHS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Apr 2019 23:07:18 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:32810 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725789AbfDODHR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Apr 2019 23:07:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=oKpgIhBVpDdsPi4+lN5iHvcrVeFVVmNwfzgBgdJt0VY=; b=M6e+n60gBT5jacB71pxCFeYkll
        DCcM1PM75WDyJvfwavaySVuzEZSJG5etfpL1IgbjB9H0G++TFW+NwGVvTueHEz3NNOc5kHueJvu0D
        b7UHakcXGdRpNn+ItdeSocmhnzy7jD4/O/5sFS5Ej2wpcNZEe3XW27XKZxgZtOp25/JM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1hFrxe-0006e3-DJ; Mon, 15 Apr 2019 05:07:10 +0200
Date:   Mon, 15 Apr 2019 05:07:10 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>, vivien.didelot@gmail.com,
        davem@davemloft.net, netdev <netdev@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Georg Waibel <georg.waibel@sensor-technik.de>
Subject: Re: [PATCH v3 net-next 18/24] net: dsa: sja1105: Add support for
 traffic through standalone ports
Message-ID: <20190415030710.GC24455@lunn.ch>
References: <20190413012822.30931-1-olteanv@gmail.com>
 <20190413012822.30931-19-olteanv@gmail.com>
 <20190413163754.GG17901@lunn.ch>
 <CA+h21hpKJS=TKGoMJMvsmK1DAtgciDsLOHAawqsKQ0xGW5dF6w@mail.gmail.com>
 <CA+h21hp=_LrGDZo3Jmoe2hNKqx7nrdqRbK3UWYntN-9My-z5Hg@mail.gmail.com>
 <CA+h21hp47bOwvEdF5KCV0bAo01mv+K11JSuP9AzEoWHTjmVAtQ@mail.gmail.com>
 <20190414161757.GB10323@lunn.ch>
 <CA+h21ho9AKSmX=6CU1P_fddcYSGB-DN0T-XqVYg8GnTRfuShVw@mail.gmail.com>
 <20190414191318.GE10323@lunn.ch>
 <CA+h21hrGPfo4-QxMjG9hqitd6qBWEpcYHeqvyPzYMFpkSLbBQw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+h21hrGPfo4-QxMjG9hqitd6qBWEpcYHeqvyPzYMFpkSLbBQw@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> It fails to decode the frames, obviously. But so does any other EtherType.

> Florian was hinting
> (https://lwn.net/ml/netdev/b52f4cdf-edcf-0757-1d6e-d4a831ec7943@gmail.com/)
> at the recent pull requests submitted to tcpdump and libpcap that make
> it possible to decode based on the string in
> /sys/class/net/${master}/dsa/tagging. I admit I haven't actually
> tested or studied those closely yet (there are more important things
> to focus on ATM), but since my driver returns "8021q" in sysfs and
> yours returns "edsa", I would presume tcpdump could use that
> information.

No it does not. It is a valid EtherType, that is what is used to
trigger the decoding, it takes no notice of what is in
/sys/class/net/${master}/dsa/tagging, nor the extra meta-data added to
the pcap file. There is no need. you can identify it is a Marvell EDSA
header from the EtherType.

In fact, this tcpdump code for decoding EDSA pre-dated Florians
patches by a few years.

You only need the code which Florian added when you cannot identify
the header directly from the packet. And that is true for most of the
tagging protocols. But EDSA you can.

> Anyway, since you obviously know more on this topic than I do,
> please make me understand what are the real problems in spoofing the
> Ethertype as a Marvell one.

Despite there being an EDSA EtherType in the frame, what follows is
not an ESDA header. It is like having the IPv4 EtherType but what
following is not an IP header. Broken.

    Andrew
