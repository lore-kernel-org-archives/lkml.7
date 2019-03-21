Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B519C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 16:47:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB0702183E
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 16:47:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728585AbfCUQre (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 12:47:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:44712 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727829AbfCUQre (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 12:47:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CC536AF68;
        Thu, 21 Mar 2019 16:47:32 +0000 (UTC)
Received: by unicorn.suse.cz (Postfix, from userid 1000)
        id 3E5E3E00BF; Thu, 21 Mar 2019 17:47:31 +0100 (CET)
Date:   Thu, 21 Mar 2019 17:47:31 +0100
From:   Michal Kubecek <mkubecek@suse.cz>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Jiri Pirko <jiri@resnulli.us>,
        Florian Fainelli <f.fainelli@gmail.com>,
        John Linville <linville@tuxdriver.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 05/22] ethtool: introduce ethtool netlink
 interface
Message-ID: <20190321164731.GJ29968@unicorn.suse.cz>
References: <cover.1553170807.git.mkubecek@suse.cz>
 <a5a50f3d60cee03f75b70fdf17e73a6212aaec3d.1553170807.git.mkubecek@suse.cz>
 <20190321135705.GB17655@lunn.ch>
 <20190321141343.GH29968@unicorn.suse.cz>
 <20190321152509.GB23408@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190321152509.GB23408@lunn.ch>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 21, 2019 at 04:25:09PM +0100, Andrew Lunn wrote:
> On Thu, Mar 21, 2019 at 03:13:43PM +0100, Michal Kubecek wrote:
> > On Thu, Mar 21, 2019 at 02:57:05PM +0100, Andrew Lunn wrote:
> > > On Thu, Mar 21, 2019 at 02:07:35PM +0100, Michal Kubecek wrote:
> > > > +static int __init ethnl_init(void)
> > > > +{
> > > > +	int ret;
> > > > +
> > > > +	ret = genl_register_family(&ethtool_genl_family);
> > > > +	if (ret < 0)
> > > > +		panic("ethtool: could not register genetlink family\n");
> > > 
> > > Panic seems a bit strong. Do we really want to kill the box because
> > > this fails?
> > 
> > When I switched CONFIG_ETHTOOL_NETLINK from tristate to bool, I checked
> > some other non-modular subsystems to see what they do on failed
> > initialization and each of them did handle it by panic() so I didn't
> > think about it too much and did the same.
> > 
> > Thinking about it now, if the family registration fails, the only entry
> > point to care about should be ethtool_notify() (I'll have to check more
> > carefully to be sure) so that adding a check there should be sufficient
> > to let everything work (except for the netlink interface, of course).
> 
> Hi Michal
> 
> So maybe do a WARN_ON() and return the error code.
> 
> Linus has been quite vocal about killing the box when there is no real
> need...

Yes, WARN_ON() seems to be the right thing to do: it says clearly enough
something went seriously wrong but doesn't make the system completely
unusable. I'll do that in v5.

Michal
