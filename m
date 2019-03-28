Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D00EC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 14:04:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 602B72173C
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 14:04:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726516AbfC1OEd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 10:04:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:37044 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725875AbfC1OEc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 10:04:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 31793AFB8;
        Thu, 28 Mar 2019 14:04:31 +0000 (UTC)
Received: by unicorn.suse.cz (Postfix, from userid 1000)
        id 0C9BDE1404; Thu, 28 Mar 2019 15:04:28 +0100 (CET)
Date:   Thu, 28 Mar 2019 15:04:28 +0100
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
Message-ID: <20190328140428.GG26076@unicorn.suse.cz>
References: <cover.1553532199.git.mkubecek@suse.cz>
 <f5af581e33b4976b84eae7c7788e3fde9adfa83c.1553532199.git.mkubecek@suse.cz>
 <2c29310b-a2a0-3867-a09f-51f2dc47ecd3@gmail.com>
 <20190328071853.GY26076@unicorn.suse.cz>
 <20190328134313.GO14297@nanopsycho>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190328134313.GO14297@nanopsycho>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 28, 2019 at 02:43:13PM +0100, Jiri Pirko wrote:
> 
> I don't like this. This should not be bitfield/set. This should be
> simply nested array of enum values:
> 
> enum ethtool_link_mode {
> 	ETHTOOL_LINK_MODE_10baseT_Half,
> 	ETHTOOL_LINK_MODE_10baseT_Full,
> 	ETHTOOL_LINK_MODE_100baseT_Half,
> 	ETHTOOL_LINK_MODE_100baseT_Full,
> 	ETHTOOL_LINK_MODE_1000baseT_Full,
> };

We already have such enum. The problem with your "no string" approach is
that it requires all userspace applications to (1) keep this enum in
sync with kernel and (2) maintain their our tables of names. Experience
shows we are not very good and satisfying these conditions even for the
one which should be best at keeping up.

> and then there should be 2 attrs:
> ETHTOOL_A_LINK_MODE_LIST_OUR	/* nest */
> ETHTOOL_A_LINK_MODE_LIST_PEER	/* nest */
> ETHTOOL_A_LINK_MODE		/* u32 */
> 
> and then the message should look like:
> 
>    ETHTOOL_A_LINK_MODE_LIST_OUR start nest
>      ETHTOOL_A_LINK_MODE = ETHTOOL_LINK_MODE_10baseT_Half
>      ETHTOOL_A_LINK_MODE = ETHTOOL_LINK_MODE_10baseT_Full
>      ETHTOOL_A_LINK_MODE = ETHTOOL_LINK_MODE_100baseT_Half
>      ETHTOOL_A_LINK_MODE = ETHTOOL_LINK_MODE_100baseT_Full
>      ETHTOOL_A_LINK_MODE = ETHTOOL_LINK_MODE_1000baseT_Full
>    ETHTOOL_A_LINK_MODE_LIST_OUR end nest
>    ETHTOOL_A_LINK_MODE_LIST_PEER start nest
>      ETHTOOL_A_LINK_MODE = ETHTOOL_LINK_MODE_10baseT_Half
>      ETHTOOL_A_LINK_MODE = ETHTOOL_LINK_MODE_10baseT_Full
>      ETHTOOL_A_LINK_MODE = ETHTOOL_LINK_MODE_100baseT_Half
>      ETHTOOL_A_LINK_MODE = ETHTOOL_LINK_MODE_100baseT_Full
>      ETHTOOL_A_LINK_MODE = ETHTOOL_LINK_MODE_1000baseT_Full
>    ETHTOOL_A_LINK_MODE_LIST_PEER end nest
> 
> Nice and simple. No bits, no strings.

A bit too simple, actually. You would need third nest to distinguish
supported and advertised modes. And for setting, you would also need two
arrays if you want to set only some of the modes (unless you introduce
something that would be similar to mine except for omitting the names).

More important: you still didn't explain how is your "no strings"
approach supposed to work for bit sets where userspace cannot possibly
know the set of available flags (e.g. the private flags).

Michal
