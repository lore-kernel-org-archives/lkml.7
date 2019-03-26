Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBB36C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 13:24:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90BEF2075D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 13:24:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731457AbfCZNYd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 09:24:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:58266 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726177AbfCZNYd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 09:24:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DEDB2AD0A;
        Tue, 26 Mar 2019 13:24:30 +0000 (UTC)
Received: by unicorn.suse.cz (Postfix, from userid 1000)
        id 83A0DE1404; Tue, 26 Mar 2019 14:24:27 +0100 (CET)
Date:   Tue, 26 Mar 2019 14:24:27 +0100
From:   Michal Kubecek <mkubecek@suse.cz>
To:     Jiri Pirko <jiri@resnulli.us>
Cc:     David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        John Linville <linville@tuxdriver.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 05/22] ethtool: introduce ethtool netlink
 interface
Message-ID: <20190326132427.GK26076@unicorn.suse.cz>
References: <cover.1553532199.git.mkubecek@suse.cz>
 <8795d07d3315b232b4e7ebc7d109c9aa3185e555.1553532199.git.mkubecek@suse.cz>
 <20190326120909.GF2230@nanopsycho>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190326120909.GF2230@nanopsycho>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2019 at 01:09:09PM +0100, Jiri Pirko wrote:
> Mon, Mar 25, 2019 at 06:08:09PM CET, mkubecek@suse.cz wrote:
> >+All "set" and "action" type requests require admin privileges (CAP_NET_ADMIN
> >+in the namespace). Most "get" type request are allowed for anyone but there
> 
> s/request/requests/

Will fix.

> >+Device identification
> >+---------------------
> >+
> >+When appropriate, network device is identified by a nested attribute named
> >+ETHA_*_DEV. This attribute can contain
> 
> Isn't it ETHA_DEV_*? I must admit I'm a bit confused.

ETHA_*_DEV is the nesting attribute (e.g. ETHA_SETTINGS_DEV), ETHA_DEV_*
(ETHA_DEV_INDEX and ETHA_DEV_NAME) are in the nest.

> 
> 
> >+
> >+    ETHA_DEV_INDEX	(u32)		device ifindex
> >+    ETHA_DEV_NAME	(string)	device name
> >+
> >+In device related requests, one of these is sufficient; if both are used, they
> >+must match (i.e. identify the same device). In device related replies both are
> 
> You say this now for the second time. First time this was said in second
> para.

I'll drop one of them.

> >+List of message types
> >+---------------------
> >+
> >+All constants use ETHNL_CMD_ prefix, usually followed by "GET", "SET" or "ACT"
> 
> Why "usually"? Why not "always"?

Right, it's always. And if it changes one day, the sentence will have to
be rewritten anyway.

> >+Messages of type "get" are used by userspace to request information and
> >+usually do not contain any attributes (that may be added later for dump
> >+filtering). Kernel response is in the form of corresponding "set" message;
> 
> Okay. Do we want reply to "*_cmd_something_get" command to be
> "*_cmd_something_set". That sounds odd. Why reply has to be "cmd"? Why
> not something like "reply" or "response"?
> This should work for both "doit/dumpit" and notifications.

As stated right below, the aim is to use the same format for replies to
GET requests as userspace uses for related SET requests. We could use
different id (genlmsghdr::cmd) but that seemed like a waste for no actual
gain.

> >+the same message can be also used to set (some of) the parameters, except for
> >+messages marked as "response only" in the table above. "Get" messages with
> >+NLM_F_DUMP flags and no device identification dump the information for all
> >+devices supporting the request.

> >+
> >+enum {
> >+	ETHNL_CMD_NOOP,
> >+
> 
> Usually headers have something like:
> /* add new commands above here */
> here.

OK

> >diff --git a/net/ethtool/Makefile b/net/ethtool/Makefile
> >index 3ebfab2bca66..f30e0da88be5 100644
> >--- a/net/ethtool/Makefile
> >+++ b/net/ethtool/Makefile
> >@@ -1,3 +1,7 @@
> > # SPDX-License-Identifier: GPL-2.0
> > 
> >-obj-y		+= ioctl.o
> >+obj-y				+= ioctl.o
> >+
> >+obj-$(CONFIG_ETHTOOL_NETLINK)	+= ethtool_nl.o
> 
> Why? I believe this should be always build-in same as ioctl.

I would like to make the ioctl interface optional as well, eventually.
As someone noted in one of the earlier discussions, there may be some
special minimalistic setups where ethtool interface may be of no use.

> >+struct genl_family ethtool_genl_family = {
> >+	.hdrsize	= 0,
> 
> No need to set 0.

OK

> >+
> >+extern struct genl_family ethtool_genl_family;
> 
> Why? You need this just within "netlink.c", don't you?

In the submitted part, yes. But one of the later patches adds specific
notify handler (different from ethnl_std_notify()) which is not in
netlink.c and needs to use pointer to ethtool_genl_family for a call to
genlmsg_put() and genlmsg_multicast().

But I can make it static for now and change to extern when it's needed.

Michal

