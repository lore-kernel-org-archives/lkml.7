Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA8F9C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 15:25:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 997C5218A5
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 15:25:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Ky9O2lzm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728404AbfCUPZS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 11:25:18 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:33656 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725985AbfCUPZR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 11:25:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=0Bx7MiaRYvBT1aW2Jw9qgIm+gO3yHMRiEfjUPV4t/BQ=; b=Ky9O2lzmSDgF0IQNl0oGpfbKp5
        DM5QosoSoLhiyRFGMwsLXhvITNV4ii1AXjvHxpNrkVoTwsJkj3U5vhL2kr7ZPPiGQ892uuIHxcTPN
        cXvo3QlWxysD6J5mvE7BqouneqDnogbUx1XRcm7DI4hX+G04TfztoP929sY/05+bM9gc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1h6zZ7-0006IH-NP; Thu, 21 Mar 2019 16:25:09 +0100
Date:   Thu, 21 Mar 2019 16:25:09 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Michal Kubecek <mkubecek@suse.cz>
Cc:     David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Jiri Pirko <jiri@resnulli.us>,
        Florian Fainelli <f.fainelli@gmail.com>,
        John Linville <linville@tuxdriver.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 05/22] ethtool: introduce ethtool netlink
 interface
Message-ID: <20190321152509.GB23408@lunn.ch>
References: <cover.1553170807.git.mkubecek@suse.cz>
 <a5a50f3d60cee03f75b70fdf17e73a6212aaec3d.1553170807.git.mkubecek@suse.cz>
 <20190321135705.GB17655@lunn.ch>
 <20190321141343.GH29968@unicorn.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190321141343.GH29968@unicorn.suse.cz>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 21, 2019 at 03:13:43PM +0100, Michal Kubecek wrote:
> On Thu, Mar 21, 2019 at 02:57:05PM +0100, Andrew Lunn wrote:
> > On Thu, Mar 21, 2019 at 02:07:35PM +0100, Michal Kubecek wrote:
> > > +static int __init ethnl_init(void)
> > > +{
> > > +	int ret;
> > > +
> > > +	ret = genl_register_family(&ethtool_genl_family);
> > > +	if (ret < 0)
> > > +		panic("ethtool: could not register genetlink family\n");
> > 
> > Panic seems a bit strong. Do we really want to kill the box because
> > this fails?
> 
> When I switched CONFIG_ETHTOOL_NETLINK from tristate to bool, I checked
> some other non-modular subsystems to see what they do on failed
> initialization and each of them did handle it by panic() so I didn't
> think about it too much and did the same.
> 
> Thinking about it now, if the family registration fails, the only entry
> point to care about should be ethtool_notify() (I'll have to check more
> carefully to be sure) so that adding a check there should be sufficient
> to let everything work (except for the netlink interface, of course).

Hi Michal

So maybe do a WARN_ON() and return the error code.

Linus has been quite vocal about killing the box when there is no real
need...

	Andrew
