Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E4F4C5DF60
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 16:00:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFFF02190F
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 16:00:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="td+Wxj2i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390053AbfKEQAC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 11:00:02 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:49982 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389843AbfKEQAB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 11:00:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=M6wh6jqbqRIdXmd1bC6JTsPk8LafWc1uYKqnOR4Fy6w=; b=td+Wxj2iB7RRCP2UQiQYGq7A1c
        bLgegAl+A9wVz1p4HProK0kUYgUOjXga0p2LWvgYRFh1zvj1ELRlUd/Fb6+5xyqnLlMRstLAm3MaK
        C40gV1/wsZdUw6wQhPGda/PD0CHAR8JlUSKweWNkcqGNK+OmSGSopZ2r3lTCohXy+9Do=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.92.2)
        (envelope-from <andrew@lunn.ch>)
        id 1iS1FK-0002fM-Fe; Tue, 05 Nov 2019 16:59:54 +0100
Date:   Tue, 5 Nov 2019 16:59:54 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Ioana Ciornei <ioana.ciornei@nxp.com>
Cc:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>
Subject: Re: [PATCH 06/12] staging: dpaa2-ethsw: add ACL entry to redirect
 STP to CPU
Message-ID: <20191105155954.GE17620@lunn.ch>
References: <1572957275-23383-1-git-send-email-ioana.ciornei@nxp.com>
 <1572957275-23383-7-git-send-email-ioana.ciornei@nxp.com>
 <20191105142202.GC7189@lunn.ch>
 <VI1PR0402MB28007254BB7614477CED4DBCE07E0@VI1PR0402MB2800.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VI1PR0402MB28007254BB7614477CED4DBCE07E0@VI1PR0402MB2800.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> The control queues do not form an actual interface in the sense that
> the CPU does not receive unknown unicast, broadcast and multicast
> frames by default.  For each frame that we want to direct to the CPU
> we must add an ACL entry.

So this appears to be one of the dumbest switches so far :-(

Can you add an ACL which is all L2 broadcast/multicast?  That would be
a good first step.

Does the ACL stop further processing of the frame? Ideally you want
the switch to also flood broadcast/multicast out other ports, if they
are in a bridge. If it cannot, you end up with the software bridge
doing the flooding.

So i also assume it does not perform learning on CPU frames? That
probably means you need to connect up the fdb add/remove calls to add
in ACLs. And you will need to implement ndo_set_rx_mode. Each unicast
and multicast address needs to be turned into an ACL. What i don't
know is if the network stack will automatically add the interfaces own
MAC address. You might have to handle that special case.

    Andrew
