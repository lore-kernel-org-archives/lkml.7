Return-Path: <SRS0=avfD=SQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BC01C10F13
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 19:06:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E97CD206B7
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 19:06:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="4Zt9mdJn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbfDNTGm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Apr 2019 15:06:42 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:60899 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725780AbfDNTGm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Apr 2019 15:06:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=sA9PQyV94N6hguiurAqKkh0xPTEqDySVq8XxB/gLXO8=; b=4Zt9mdJnhgmonacpJ4S+bHSN88
        hnnY55QT1GIv08VZaFfEBdPUGuZdh/1HBb2+K8V8/AtRbsb4AXiDlBbo2EzZNPh847AHhSELw96oh
        +uLMttJd1ITHYw1NMIzCnnbDl4wpexjPG6evFBoaET19qcB75kZQV7IlfAzkmQs7qEx0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1hFkSb-0004Es-GW; Sun, 14 Apr 2019 21:06:37 +0200
Date:   Sun, 14 Apr 2019 21:06:37 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>, vivien.didelot@gmail.com,
        davem@davemloft.net, netdev <netdev@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Georg Waibel <georg.waibel@sensor-technik.de>
Subject: Re: [PATCH v3 net-next 18/24] net: dsa: sja1105: Add support for
 traffic through standalone ports
Message-ID: <20190414190637.GD10323@lunn.ch>
References: <20190413012822.30931-1-olteanv@gmail.com>
 <20190413012822.30931-19-olteanv@gmail.com>
 <20190413163754.GG17901@lunn.ch>
 <CA+h21hpKJS=TKGoMJMvsmK1DAtgciDsLOHAawqsKQ0xGW5dF6w@mail.gmail.com>
 <20190414160510.GA10323@lunn.ch>
 <CA+h21hoG8hRPoakx0Wvx1XyPVo2wmB-L=Y-7hGir5Pk1_NgaEg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+h21hoG8hRPoakx0Wvx1XyPVo2wmB-L=Y-7hGir5Pk1_NgaEg@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Yes, it looks like the hardware isn't doing me any favors on this one.
> >From UM10944: "If the host provides several management route entries
> with identical values for the MACADDR, the one at the lowest index is
> used first."
> So the 4 hardware management slots serve no purpose unless I'm willing
> to lock the sja1105_xmit_work_handler with a mutex. And even then
> there's no reason to use separate slots since the workers are
> serialized anyway. Weird.

So you can simply this down to just using one queue. Maybe even one
queue for all instances of this switch. You can then keep it all as
static private structures in the tag driver, maybe not even needing
ds->tag_priv.

> > Also, DSA has been very successful, we keep getting more switches from
> > different vendors, and hence more taggers. So at some point, we should
> > turn the taggers into modules. I'm not saying that should happen now,
> > but when it does happen, this driver can then become a module.

FYI: I started on this already. There might be patches today to allow
the tag drivers to be kernel modules.

    Andrew
