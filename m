Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1FF5C5DF63
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 14:50:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F439217F5
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 14:50:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="qDfzgBdf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731891AbfKFOum (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 09:50:42 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:51840 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726945AbfKFOum (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 09:50:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=uBDdKmPjBDsCsId+vpm+knbnzv6iTZMNK66dCjE/fy8=; b=qDfzgBdfNKAtx+WE9GBytWMseU
        7W+qKZ7VEH+DR7tjA8cyMcuV/DZCqBrZBPVlBMx8OL64+QJDC4q84Jx86+RQkdLSzXPtiwI+++sgj
        V8fxqGcBvQ5GHqKaIbjhBq9VRl9McwgdhwHxIA5kojAtNBG3Vroppb8dNIEtMMR1t2vo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.92.2)
        (envelope-from <andrew@lunn.ch>)
        id 1iSMdq-0008Of-7A; Wed, 06 Nov 2019 15:50:38 +0100
Date:   Wed, 6 Nov 2019 15:50:38 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Ioana Ciornei <ioana.ciornei@nxp.com>
Cc:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>
Subject: Re: [PATCH 06/12] staging: dpaa2-ethsw: add ACL entry to redirect
 STP to CPU
Message-ID: <20191106145038.GB30762@lunn.ch>
References: <1572957275-23383-1-git-send-email-ioana.ciornei@nxp.com>
 <1572957275-23383-7-git-send-email-ioana.ciornei@nxp.com>
 <20191105142202.GC7189@lunn.ch>
 <VI1PR0402MB28007254BB7614477CED4DBCE07E0@VI1PR0402MB2800.eurprd04.prod.outlook.com>
 <20191105155954.GE17620@lunn.ch>
 <DB6PR0402MB27899B298481E7A3460BB9BFE0790@DB6PR0402MB2789.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB6PR0402MB27899B298481E7A3460BB9BFE0790@DB6PR0402MB2789.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 06, 2019 at 01:47:47PM +0000, Ioana Ciornei wrote:
> > Subject: Re: [PATCH 06/12] staging: dpaa2-ethsw: add ACL entry to redirect
> > STP to CPU
> > 
> > > The control queues do not form an actual interface in the sense that
> > > the CPU does not receive unknown unicast, broadcast and multicast
> > > frames by default.  For each frame that we want to direct to the CPU
> > > we must add an ACL entry.
> > 
> > So this appears to be one of the dumbest switches so far :-(
> 
> To be fair, the actual hardware can do much more.
> The problem here is that the firmware models the switch in a non-Linux style.

Well, the whole hardware is not very linux like!

> > 
> > Can you add an ACL which is all L2 broadcast/multicast?  That would be a good
> > first step.
> 
> I can add that but it would not be enough.
> For example, unknown unicast would not be matched thus would not reach the CPU.

Not ideal, but you could rely on ARP and ND. Any conversation should
start with a broadcast/multicast ARP or ND. The bridge should add an
FDB based on what it just learned, and traffic should flow. And when
the interface is not part of a bridge, you don't care about unknown
unicast.

> > Does the ACL stop further processing of the frame? Ideally you want the
> > switch to also flood broadcast/multicast out other ports, if they are in a
> > bridge. If it cannot, you end up with the software bridge doing the flooding.
> 
> Yes, the ACL stops any further processing. 

O.K, the software bridge can handle that. It is not the best use for
hardware, but will work.

> Your assumption is true, learning, with the current implementation, is not possible for CPU frames.
> In .ndo_start_xmit() we inject directly into the switch port's Tx queues, thus bypassing the entire learning process.
> 
> All in all, I do not see a way out just by using the ACL mechanism (because of unknown unicast frames).
> 
> I have to talk in detail with the firmware team, but from what I can understand if we make the following changes in firmware it would better fit the Linux framework:
>  * make the CPU receive unknown unicast, broadcast and multicast frames by default (without any ACLs)

Yes, that is the first step. Some switches go further. Link local L2
frames are always passed to the CPU. All ARP and ND packets are
passed, IGMP, etc. Once you have the first step working, you start
thinking about the next step. That is blocking some of this traffic
hitting the CPU. IGMP snooping is one way. You need to continue
receiving the IGMP frames, but not the multicast traffic. But they use
the same MAC address. So the switch needs to look deeper into the
packet.

> * frames originated on the CPU should not bypass the learning
>   process (it should have its own Tx queues that go through the
>   same learning process)

Learning is needed. But maybe not its own Tx queue. It depends on the
QoS architecture. Ideally you want QoS to work on CPU frames, so they
get put into the correct egress queue for there QoS level.

With DSA this is simpler, since you have a physical interface
connected to the CPU, so you can use that interface number in all your
tables. But with a pure switchdev driver, each port effectively
becomes two ports, one to the front panel and one to the CPU port. And
your tables need to differentiate this.

     Andrew
