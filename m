Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF006C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 22:28:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C20382173C
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 22:28:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728256AbfC1W2r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 18:28:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:56074 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727906AbfC1W2r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 18:28:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id AAD4EACC6;
        Thu, 28 Mar 2019 22:28:45 +0000 (UTC)
Received: by unicorn.suse.cz (Postfix, from userid 1000)
        id BBC48E1404; Thu, 28 Mar 2019 23:28:41 +0100 (CET)
Date:   Thu, 28 Mar 2019 23:28:41 +0100
From:   Michal Kubecek <mkubecek@suse.cz>
To:     Jiri Pirko <jiri@resnulli.us>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Andrew Lunn <andrew@lunn.ch>,
        John Linville <linville@tuxdriver.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 12/22] ethtool: provide string sets with
 GET_STRSET request
Message-ID: <20190328222841.GI26076@unicorn.suse.cz>
References: <cover.1553532199.git.mkubecek@suse.cz>
 <f5af581e33b4976b84eae7c7788e3fde9adfa83c.1553532199.git.mkubecek@suse.cz>
 <2c29310b-a2a0-3867-a09f-51f2dc47ecd3@gmail.com>
 <20190328071853.GY26076@unicorn.suse.cz>
 <20190328134313.GO14297@nanopsycho>
 <20190328140428.GG26076@unicorn.suse.cz>
 <20190328173524.GR14297@nanopsycho>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190328173524.GR14297@nanopsycho>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 28, 2019 at 06:35:24PM +0100, Jiri Pirko wrote:
> 
> Moreover, I think that speed, duplex and type should be sent
> separatelly:
> 
>     ETHTOOL_A_LINK_MODE_LIST_OUR start nest
>       ETHTOOL_A_LINK_MODE start nest
>         ETHTOOL_A_LINK_MODE_SPEED = 100 /* this should be u64 */
> 	ETHTOOL_A_LINK_MODE_DUPLEX = ETHTOOL_LINK_MODE_DUPLEX_FULL
> 	ETHTOOL_A_LINK_MODE_TYPE = ETHTOOL_LINK_MODE_TYPE_BASET
>       ETHTOOL_A_LINK_MODE start end
>       ETHTOOL_A_LINK_MODE start nest
>         ETHTOOL_A_LINK_MODE_SPEED = 10
> 	ETHTOOL_A_LINK_MODE_DUPLEX = ETHTOOL_LINK_MODE_DUPLEX_HALF
> 	ETHTOOL_A_LINK_MODE_TYPE = ETHTOOL_LINK_MODE_TYPE_BASET
>       ETHTOOL_A_LINK_MODE start end
>     ETHTOOL_A_LINK_MODE_LIST_PEER end nest
> 
> Does not really make sense to combine those 3 attributes together.

This helped me to realize the primary source of misunderstanding: as I'm
working on kernel and ethtool implementation simultaneously, I don't
look only at the API itself and don't consider only if its design is
clean and logical. I always think about the actual userspace programs
wanting to use the interface and try to imagine what the design means
for them.

So when you say e.g. "this belongs to rtnetlink", I have to admit that
from strictly logical point of view you are right but at the same time,
chain of thoughts starts: "that means two sockets; we need a table which
command needs which, some might need both, monitor will have to listen
at two sockets, that's fork/pthread/poll..."

From this point of view, the scheme above which, on its own, makes
perfect sense (there might be a bit of a problem with 10000baseR_FEC
mode but that one is a trouble in any scheme), means that one side will
translate the link mode number to the three parameters and the other
will look the triplet out in its own table to get the link mode number.
On userspace side, there will be another translation between link mode
number and name. What exactly is the gain from such representation?
No idea.

There is one crucial difference between ethtool and devlink. You are
building devlink from scratch so you define the logic, define the API
based on that logic and make both NIC drivers and userspace conform to
it. With ethtool, the situation is exactly the opposite: on one side,
there are ethtool_ops as a constraint, on the other, it's ethtool with
its feature set and users used to it. Changing ethtool_ops is going to
be slow and painful process. Changing the users and their habits...
we already know how that works.

Michal
