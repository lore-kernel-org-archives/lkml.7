Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F037FC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 09:59:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C47882070B
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 09:59:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732942AbfC0J7w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 05:59:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:60502 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725827AbfC0J7w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 05:59:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id EB137AD3A;
        Wed, 27 Mar 2019 09:59:50 +0000 (UTC)
Received: by unicorn.suse.cz (Postfix, from userid 1000)
        id 370F8E1404; Wed, 27 Mar 2019 10:59:50 +0100 (CET)
Date:   Wed, 27 Mar 2019 10:59:50 +0100
From:   Michal Kubecek <mkubecek@suse.cz>
To:     Jiri Pirko <jiri@resnulli.us>
Cc:     David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        John Linville <linville@tuxdriver.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 08/22] ethtool: support for netlink
 notifications
Message-ID: <20190327095950.GQ26076@unicorn.suse.cz>
References: <cover.1553532199.git.mkubecek@suse.cz>
 <3578e5f334acf11b84e75d0ee41c072340a7b085.1553532199.git.mkubecek@suse.cz>
 <20190326163400.GC4958@nanopsycho.orion>
 <20190326181720.GO26076@unicorn.suse.cz>
 <20190327093843.GB6979@nanopsycho>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190327093843.GB6979@nanopsycho>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 27, 2019 at 10:38:43AM +0100, Jiri Pirko wrote:
> Tue, Mar 26, 2019 at 07:17:20PM CET, mkubecek@suse.cz wrote:
> >On Tue, Mar 26, 2019 at 05:34:00PM +0100, Jiri Pirko wrote:
> >> Mon, Mar 25, 2019 at 06:08:18PM CET, mkubecek@suse.cz wrote:
> >> >+void ethtool_notify(struct net_device *dev, struct netlink_ext_ack *extack,
> >> >+		    unsigned int cmd, u32 req_mask, const void *data)
> >> >+{
> >> >+	if (unlikely(!ethnl_ok))
> >> 
> >> Why do you need this?
> >
> >If genetlink family registration fails, ethtool_notify() can be still
> >called from other code (e.g. the ethtool ioctl interface). In such case,
> >better bail out right away than fail somewhere later (probably after
> >preparing the message which can't be sent anyway).
> 
> Again, haven't seen this in any other gen netlink implementation. Why do
> they not need it?

Do they have notifications triggered from other code by directly calling
a function (i.e. not through e.g. a netdev notifier)?

An alternative to a flag would be using a RCU pointer for this function
(initialized to null and set once the family is registered) which is
what e.g. netfilter is doing with its hooks but that would mean that
each external notification would use an indirect call.

> >> >diff --git a/net/ethtool/netlink.h b/net/ethtool/netlink.h
> >> >index b8a6cd3dc3e3..5f2299548915 100644
> >> >--- a/net/ethtool/netlink.h
> >> >+++ b/net/ethtool/netlink.h
> >> >@@ -11,6 +11,8 @@
> >> > #define ETHNL_SET_ERRMSG(info, msg) \
> >> > 	do { if (info) GENL_SET_ERR_MSG(info, msg); } while (0)
> >> > 
> >> >+extern u32 ethnl_bcast_seq;
> >> 
> >> Why do you need to have this in header? Second, it is not used by
> >> anything. Please don't introduce variables that are not used. Introduce
> >> them only in patch where you use it.
> >
> >It's the same as with ethtool_genl_family. I'll make it static as well
> >until it's used in some other file.
> 
> Not only static. You should remove it as you are not using it in this
> patch at all.

OK

Michal
