Return-Path: <SRS0=avfD=SQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0953C10F13
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 16:18:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BCFA20880
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 16:18:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="jlhe66+f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbfDNQSB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Apr 2019 12:18:01 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:60810 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726055AbfDNQSB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Apr 2019 12:18:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=6Nwhnvg2sOdLRem9fCGmIQRjXuBwoKB8XSFc/C2nYbI=; b=jlhe66+fraDR4SKcTK2MgYmb/w
        pSNjleQlGYGX4JHattgR9ykgw5mGAxn9tF3obt1pEFqMOjZB8roBEbGc8OlQxtEO01jyuCeHmIJ5v
        YCLoYLQu742CuOjxLlH6FQ9ELfxnvGkb4qHDBS13u4fmhNbhaDlddFwcmzmWsffqvdhA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1hFhpN-0003BT-1s; Sun, 14 Apr 2019 18:17:57 +0200
Date:   Sun, 14 Apr 2019 18:17:57 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>, vivien.didelot@gmail.com,
        davem@davemloft.net, netdev <netdev@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Georg Waibel <georg.waibel@sensor-technik.de>
Subject: Re: [PATCH v3 net-next 18/24] net: dsa: sja1105: Add support for
 traffic through standalone ports
Message-ID: <20190414161757.GB10323@lunn.ch>
References: <20190413012822.30931-1-olteanv@gmail.com>
 <20190413012822.30931-19-olteanv@gmail.com>
 <20190413163754.GG17901@lunn.ch>
 <CA+h21hpKJS=TKGoMJMvsmK1DAtgciDsLOHAawqsKQ0xGW5dF6w@mail.gmail.com>
 <CA+h21hp=_LrGDZo3Jmoe2hNKqx7nrdqRbK3UWYntN-9My-z5Hg@mail.gmail.com>
 <CA+h21hp47bOwvEdF5KCV0bAo01mv+K11JSuP9AzEoWHTjmVAtQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+h21hp47bOwvEdF5KCV0bAo01mv+K11JSuP9AzEoWHTjmVAtQ@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > > > > +             return dsa_8021q_xmit(skb, netdev, ETH_P_EDSA,
> > > > > +                                  ((pcp << VLAN_PRIO_SHIFT) | tx_vid));
> > > >
> > > > Please don't reuse ETH_P_EDSA. Define an ETH_P_SJA1105.
> > > >
> 
> I'm receiving contradictory advice on this. Why should I define a new
> ethertype, and if I do, what scope should the definition have (local
> to the driver and the tagger, local to DSA, UAPI)?

ETH_P_EDSA has a well defined meaning. It is a true global EtherType,
and means a Marvell EtherType DSA header follows.

You are polluting this meaning of ETH_P_EDSA. Would you put ETH_P_IP
or ETH_P_8021AD here?

   Andrew
