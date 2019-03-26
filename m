Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA9D5C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 18:17:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8090F20823
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 18:17:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732522AbfCZSRY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 14:17:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:58692 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732424AbfCZSRW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 14:17:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1194EB02E;
        Tue, 26 Mar 2019 18:17:21 +0000 (UTC)
Received: by unicorn.suse.cz (Postfix, from userid 1000)
        id 75D4CE1404; Tue, 26 Mar 2019 19:17:20 +0100 (CET)
Date:   Tue, 26 Mar 2019 19:17:20 +0100
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
Message-ID: <20190326181720.GO26076@unicorn.suse.cz>
References: <cover.1553532199.git.mkubecek@suse.cz>
 <3578e5f334acf11b84e75d0ee41c072340a7b085.1553532199.git.mkubecek@suse.cz>
 <20190326163400.GC4958@nanopsycho.orion>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190326163400.GC4958@nanopsycho.orion>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2019 at 05:34:00PM +0100, Jiri Pirko wrote:
> Mon, Mar 25, 2019 at 06:08:18PM CET, mkubecek@suse.cz wrote:
> >+void ethtool_notify(struct net_device *dev, struct netlink_ext_ack *extack,
> >+		    unsigned int cmd, u32 req_mask, const void *data)
> >+{
> >+	if (unlikely(!ethnl_ok))
> 
> Why do you need this?

If genetlink family registration fails, ethtool_notify() can be still
called from other code (e.g. the ethtool ioctl interface). In such case,
better bail out right away than fail somewhere later (probably after
preparing the message which can't be sent anyway).

> >+		return;
> >+	ASSERT_RTNL();
> >+
> >+	if (likely(cmd < ARRAY_SIZE(ethnl_notify_handlers) &&
> >+		   ethnl_notify_handlers[cmd]))
> >+		ethnl_notify_handlers[cmd](dev, extack, cmd, req_mask, data);
> >+	else
> >+		WARN_ONCE(1, "notification %u not implemented (dev=%s, req_mask=0x%x)\n",
> >+			  cmd, netdev_name(dev), req_mask);
> >+}
> >+EXPORT_SYMBOL(ethtool_notify);
> 
> Please be consistent with prefixes. Rest of the code (most of it) has
> prefix "ethnl".

The reason why I used ethtool_ prefix here was that this function is an
entry point which can be called from anywhere and other code doesn't
care if we are using netlink or something else. But as any caller would
need to include <linux/ethtool_netlink.h> anyway to get the constants
for cmd and req_mask, there is no point hiding the fact. I'll rename it
to ethnl_notify().

> >diff --git a/net/ethtool/netlink.h b/net/ethtool/netlink.h
> >index b8a6cd3dc3e3..5f2299548915 100644
> >--- a/net/ethtool/netlink.h
> >+++ b/net/ethtool/netlink.h
> >@@ -11,6 +11,8 @@
> > #define ETHNL_SET_ERRMSG(info, msg) \
> > 	do { if (info) GENL_SET_ERR_MSG(info, msg); } while (0)
> > 
> >+extern u32 ethnl_bcast_seq;
> 
> Why do you need to have this in header? Second, it is not used by
> anything. Please don't introduce variables that are not used. Introduce
> them only in patch where you use it.

It's the same as with ethtool_genl_family. I'll make it static as well
until it's used in some other file.

Michal
