Return-Path: <SRS0=SHWF=W4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 634F4C3A5A4
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 18:48:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D98FD2190F
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 18:48:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ul3KpkOm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729190AbfIASse (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Sep 2019 14:48:34 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:47334 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729018AbfIASse (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Sep 2019 14:48:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=hnimKs/jLgtBWYZWclCb62aoLe+8EQgWYyTHj3iDxqc=; b=ul3KpkOm7l4Uswx2WiebKEbF6Q
        MxVJXBDDZD7l1yhLXkrC9XrpUn76Y0RcClCIjRnZq59M9/lZQlNBikbbaCEIWZONlraGb74jwjnG9
        Fl3G+3Ke72A1o3+OpGKvcCJGM9lUVbO5KYnnoo/HfqLd/XVYsmJK73WwqQUv+2IAIwhI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1i4Utf-0006Uh-SO; Sun, 01 Sep 2019 20:48:19 +0200
Date:   Sun, 1 Sep 2019 20:48:19 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Ido Schimmel <idosch@idosch.org>
Cc:     David Miller <davem@davemloft.net>, jiri@resnulli.us,
        horatiu.vultur@microchip.com, alexandre.belloni@bootlin.com,
        UNGLinuxDriver@microchip.com, allan.nielsen@microchip.com,
        ivecera@redhat.com, f.fainelli@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] net: core: Notify on changes to dev->promiscuity.
Message-ID: <20190901184819.GA24673@lunn.ch>
References: <20190829175759.GA19471@splinter>
 <20190829182957.GA17530@lunn.ch>
 <20190829193613.GA23259@splinter>
 <20190829.151201.940681219080864052.davem@davemloft.net>
 <20190830094319.GA31789@splinter>
 <20190831193556.GB2647@lunn.ch>
 <20190831204705.GA28380@splinter>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190831204705.GA28380@splinter>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 31, 2019 at 11:47:05PM +0300, Ido Schimmel wrote:
> On Sat, Aug 31, 2019 at 09:35:56PM +0200, Andrew Lunn wrote:
> > > Also, what happens when I'm running these application without putting
> > > the interface in promisc mode? On an offloaded interface I would not be
> > > able to even capture packets addressed to my interface's MAC address.
> > 
> > Sorry for rejoining the discussion late. I've been travelling and i'm
> > now 3/4 of the way to Lisbon.
> 
> Hi Andrew,
> 
> Have fun!
> 
> > That statement i don't get. 
> 
> What about the other statements?
> 
> > If the frame has the MAC address of the interface, it has to be
> > delivered to the CPU. 
> 
> So every packet that needs to be routed should be delivered to the CPU?
> Definitely not.
> 
> > And so pcap will see it when running on the interface. I can pretty
> > much guarantee every DSA driver does that.
> 
> I assume because you currently only consider L2 forwarding.

Yes, that is what i missed. The vast majority of switches which Linux
supports are L2. All the switches i deal with are L2. So i did not
think about L3. My bad.

> > But to address the bigger picture. My understanding is that we want to
> > model offloading as a mechanism to accelerate what Linux can already
> > do. The user should not have to care about these accelerators. The
> > interface should work like a normal Linux interface. I can put an IP
> > address on it and ping a peer. I can run a dhcp client and get an IP
> > address from a dhcp server. I can add the interface to a bridge, and
> > packets will get bridged. I as a user should not need to care if this
> > is done in software, or accelerated by offloading it. I can add a
> > route, and if the accelerate knows about L3, it can accelerate that as
> > well. If not, the kernel will route it.
> 
> Yep, and this is how it's all working today.

So for a L3 switch, frames which match the MAC address, and one of the
many global scope IP addresses on any interface, get delivered to the
CPU, when the accelerator is L3 capable. If the IP address does not
match, it gets routed in hardware, if there is an appropriate router,
otherwise it get passed to the CPU, so the CPU can route it out an
interface which is not part of the switch.

> Look, this again boils down to what promisc mode means with regards to
> hardware offload. You want it to mean punt all traffic to the CPU? Fine.
> Does not seem like anyone will be switching sides anyway, so lets move
> forward. But the current approach is not good. Each driver needs to have
> this special case logic and the semantics of promisc mode change not
> only with regards to the value of the promisc counter, but also with
> regards to the interface's uppers. This is highly fragile and confusing.

Yes, i agree. We want one function, in the core, which handles all the
different uppers. Maybe 2, if we need to consider L2 and L3 switches
differently.

	Andrew
