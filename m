Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB5AFC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 09:37:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93FD42075E
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 09:37:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbfC1Jhv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 05:37:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:50106 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725815AbfC1Jhu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 05:37:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 45A77AEF5;
        Thu, 28 Mar 2019 09:37:49 +0000 (UTC)
Received: by unicorn.suse.cz (Postfix, from userid 1000)
        id 74954E1404; Thu, 28 Mar 2019 10:37:46 +0100 (CET)
Date:   Thu, 28 Mar 2019 10:37:46 +0100
From:   Michal Kubecek <mkubecek@suse.cz>
To:     Jiri Pirko <jiri@resnulli.us>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Andrew Lunn <andrew@lunn.ch>,
        John Linville <linville@tuxdriver.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 05/22] ethtool: introduce ethtool netlink
 interface
Message-ID: <20190328093746.GA26076@unicorn.suse.cz>
References: <cover.1553532199.git.mkubecek@suse.cz>
 <8795d07d3315b232b4e7ebc7d109c9aa3185e555.1553532199.git.mkubecek@suse.cz>
 <20190326120909.GF2230@nanopsycho>
 <20190326132427.GK26076@unicorn.suse.cz>
 <20190326134251.GA5181@nanopsycho.orion>
 <20190327092604.GP26076@unicorn.suse.cz>
 <20190327095023.GC6979@nanopsycho>
 <7e883a7c-7f1a-b1a0-4735-0ad368998c65@gmail.com>
 <20190328081010.GJ14297@nanopsycho>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190328081010.GJ14297@nanopsycho>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 28, 2019 at 09:10:10AM +0100, Jiri Pirko wrote:
> Thu, Mar 28, 2019 at 03:05:14AM CET, f.fainelli@gmail.com wrote:
> >
> >
> >On 3/27/2019 2:50 AM, Jiri Pirko wrote:
> >> 
> >> Why don't you have ETHTOOL_MSG_SET_FOO for set? I think that for
> >> kerne->userspace the ETHTOOL_MSG_FOO if fine. I would change the
> >> ordering of words thought, but it is cosmetics:
> >> ETHTOOL_MSG_FOO /* kernel->userspace messages - replies, notifications */
> >> ETHTOOL_MSG_FOO_GET
> >> ETHTOOL_MSG_FOO_SET
> >> ETHTOOL_MSG_FOO_ACT
> >> 
> >> What do you think?
> >
> >We could even name the notification explicitly with: ETHTOOL_MSG_NOTIF
> >or ETHTOOL_MSG_NTF just so we spell out exactly what those messages are.
> 
> Sound good. Something like:
> 
> ETHTOOL_MSG_FOO_GET
> ETHTOOL_MSG_FOO_GET_RPLY /* kernel->userspace replies to get */
> ETHTOOL_MSG_FOO_SET
> ETHTOOL_MSG_FOO_ACT
> ETHTOOL_MSG_FOO_NTF /* kernel->userspace async messages - notifications */

The names sound fine to me and having different message ids would still
allow processing messages by the same handler easily.

But there is one potential issue I would like to point out: this way we
spend 4 message ids for a get/set pair rather than 2. These message ids
(genlmsghdr::cmd) are u8, i.e. the resource is not as infinite as one
would wish. There are 80 ioctl commands (43 "get" and 29 "set") at the
moment.

Netlink API should be less greedy in general. I already combined some
ioctl commands into one netlink request type and with an easy way to add
new attributes to existing commands, we won't need to add new commands
as often (certainly not in a way which left us with 9 "get" and 9 "set"
ioctl commands for netdev features). So even with 4 ids per get/set
pair, we might be safe for reasonably long time. But it's still
something to keep in mind.

Michal
