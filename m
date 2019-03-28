Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1693FC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 10:03:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1B382173C
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 10:03:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbfC1KDw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 06:03:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:33234 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725815AbfC1KDw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 06:03:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D1ED2ADAA;
        Thu, 28 Mar 2019 10:03:50 +0000 (UTC)
Received: by unicorn.suse.cz (Postfix, from userid 1000)
        id 9DCADE1404; Thu, 28 Mar 2019 11:03:37 +0100 (CET)
Date:   Thu, 28 Mar 2019 11:03:37 +0100
From:   Michal Kubecek <mkubecek@suse.cz>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Jiri Pirko <jiri@resnulli.us>, Andrew Lunn <andrew@lunn.ch>,
        John Linville <linville@tuxdriver.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 14/22] ethtool: provide timestamping
 information in GET_INFO request
Message-ID: <20190328100337.GC26076@unicorn.suse.cz>
References: <cover.1553532199.git.mkubecek@suse.cz>
 <1dce7f6dd3308ad4b90300014823d071f37b0f74.1553532199.git.mkubecek@suse.cz>
 <262b84dc-e4fb-6c27-7de7-bc797d2247a0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <262b84dc-e4fb-6c27-7de7-bc797d2247a0@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 27, 2019 at 08:36:53PM -0700, Florian Fainelli wrote:
> 
> 
> On 3/25/2019 10:08 AM, Michal Kubecek wrote:
> > Add timestamping information as provided by ETHTOOL_GET_TS_INFO ioctl
> > command in GET_INFO reply if ETH_INFO_IM_TSINFO flag is set in the request.
> > 
> > Add constants for counts of HWTSTAMP_TX_* and HWTSTAM_FILTER_* constants
> > and provide symbolic names for timestamping related values so that they can
> > be retrieved in GET_STRSET and GET_INFO requests.
> > 
> > Signed-off-by: Michal Kubecek <mkubecek@suse.cz>
> > ---
> 
> [snip]
> 
> > +int __ethtool_get_ts_info(struct net_device *dev, struct ethtool_ts_info *info)
> > +{
> > +	const struct ethtool_ops *ops = dev->ethtool_ops;
> > +	struct phy_device *phydev = dev->phydev;
> > +	int err = 0;
> > +
> > +	memset(info, 0, sizeof(*info));
> > +	info->cmd = ETHTOOL_GET_TS_INFO;
> > +
> > +	if (phydev && phydev->drv && phydev->drv->ts_info) {
> > +		err = phydev->drv->ts_info(phydev, info);
> > +	} else if (ops->get_ts_info) {
> > +		err = ops->get_ts_info(dev, info);
> > +	} else {
> > +		info->so_timestamping = SOF_TIMESTAMPING_RX_SOFTWARE |
> > +					SOF_TIMESTAMPING_SOFTWARE;
> > +		info->phc_index = -1;
> > +	}
> 
> We don't have to solve this just yet, but this is the type of logic that
> we want to be able to change in the future, there are a number of things
> in the current ethtool code where, say, we always prefer PHY time
> stamping over MAC time stamping when there should be a choice if both
> are supported.

For the record, this is just a code block carved out of existing
ethtool_ts_info() where the only difference is that info is a pointer
rather than a structure itself.
 
> I don't know if you maintain a TODO for after when this patch series get
> merged, but we may want to start one :)

I have some informal TODO locally; some ideas are in the cover letter,
I also mentioned some in my talk last week. Perhaps it is time to make
it a publicly visible document and start collecting ideas.

Michal
