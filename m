Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28BCDC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 06:32:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00ABE21904
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 06:32:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727848AbfCVGcO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 02:32:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:34674 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727440AbfCVGcO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 02:32:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 79FD2ADE2;
        Fri, 22 Mar 2019 06:32:12 +0000 (UTC)
Received: by unicorn.suse.cz (Postfix, from userid 1000)
        id D7AEDE00BF; Fri, 22 Mar 2019 07:32:08 +0100 (CET)
Date:   Fri, 22 Mar 2019 07:32:08 +0100
From:   Michal Kubecek <mkubecek@suse.cz>
To:     Jakub Kicinski <jakub.kicinski@netronome.com>
Cc:     David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        Jiri Pirko <jiri@resnulli.us>, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        John Linville <linville@tuxdriver.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 01/22] rtnetlink: provide permanent hardware
 address in RTM_NEWLINK
Message-ID: <20190322063208.GK29968@unicorn.suse.cz>
References: <cover.1553170807.git.mkubecek@suse.cz>
 <c46e29b557e54652cce569e3348ed0385eac1469.1553170807.git.mkubecek@suse.cz>
 <20190321133505.7e186289@cakuba.netronome.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190321133505.7e186289@cakuba.netronome.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 21, 2019 at 01:35:05PM -0700, Jakub Kicinski wrote:
> On Thu, 21 Mar 2019 14:40:21 +0100 (CET), Michal Kubecek wrote:
> > Permanent hardware address of a network device was traditionally provided
> > via ethtool ioctl interface but as Jiri Pirko pointed out in a review of
> > ethtool netlink interface, rtnetlink is much more suitable for it so let's
> > add it to the RTM_NEWLINK message.
> > 
> > As permanent address is not modifiable, reject userspace requests
> > containing IFLA_PERM_ADDRESS attribute.
> > 
> > Note: we already provide permanent hardware address for bond slaves;
> > unfortunately we cannot drop that attribute for backward compatibility
> > reasons.
> > 
> > Signed-off-by: Michal Kubecek <mkubecek@suse.cz>
> > ---
> >  include/uapi/linux/if_link.h | 1 +
> >  net/core/rtnetlink.c         | 4 ++++
> >  2 files changed, 5 insertions(+)
> > 
> > diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
> > index 5b225ff63b48..351ef746b8b0 100644
> > --- a/include/uapi/linux/if_link.h
> > +++ b/include/uapi/linux/if_link.h
> > @@ -167,6 +167,7 @@ enum {
> >  	IFLA_NEW_IFINDEX,
> >  	IFLA_MIN_MTU,
> >  	IFLA_MAX_MTU,
> > +	IFLA_PERM_ADDRESS,
> >  	__IFLA_MAX
> >  };
> >  
> > diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
> > index a51cab95ba64..a72e8f4d777b 100644
> > --- a/net/core/rtnetlink.c
> > +++ b/net/core/rtnetlink.c
> > @@ -1026,6 +1026,7 @@ static noinline size_t if_nlmsg_size(const struct net_device *dev,
> >  	       + nla_total_size(4)  /* IFLA_CARRIER_DOWN_COUNT */
> >  	       + nla_total_size(4)  /* IFLA_MIN_MTU */
> >  	       + nla_total_size(4)  /* IFLA_MAX_MTU */
> > +	       + nla_total_size(MAX_ADDR_LEN) /* IFLA_PERM_ADDRESS */
> >  	       + 0;
> >  }
> >  
> > @@ -1683,6 +1684,8 @@ static int rtnl_fill_ifinfo(struct sk_buff *skb,
> >  	    nla_put_s32(skb, IFLA_NEW_IFINDEX, new_ifindex) < 0)
> >  		goto nla_put_failure;
> >  
> > +	if (nla_put(skb, IFLA_PERM_ADDRESS, dev->addr_len, dev->perm_addr))
> 
> Should we check the perm_addr is non-zero, i.e. it has been filled in
> by the driver?

It makes sense logically but there is IMHO one practical problem: if we
omit the attribute when the address is zero (i.e. not set or maybe
a device which does not have permanent address), userspace won't be able
to distinguish this case from an older kernel not implementing the
attribute.

For the iproute2 patch, I plan to show the permanent address in the
output of "ip link show" only if it differs from current address.
I think it would be desirable to distinguish "current address is the
permanent one" from "no/unknown permanent address" but absence of the
attribute could also mean "kernel does not provide the information".

Michal
