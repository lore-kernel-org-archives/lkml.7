Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2872C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 20:43:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC60A20811
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 20:43:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727248AbfC1Uni (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 16:43:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:34074 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726095AbfC1Uni (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 16:43:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9DC56AC86;
        Thu, 28 Mar 2019 20:43:31 +0000 (UTC)
Received: by unicorn.suse.cz (Postfix, from userid 1000)
        id CF677E1404; Thu, 28 Mar 2019 21:43:29 +0100 (CET)
Date:   Thu, 28 Mar 2019 21:43:29 +0100
From:   Michal Kubecek <mkubecek@suse.cz>
To:     Jakub Kicinski <jakub.kicinski@netronome.com>
Cc:     Jiri Pirko <jiri@resnulli.us>,
        Florian Fainelli <f.fainelli@gmail.com>,
        David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        Andrew Lunn <andrew@lunn.ch>,
        John Linville <linville@tuxdriver.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 12/22] ethtool: provide string sets with
 GET_STRSET request
Message-ID: <20190328204329.GH26076@unicorn.suse.cz>
References: <cover.1553532199.git.mkubecek@suse.cz>
 <f5af581e33b4976b84eae7c7788e3fde9adfa83c.1553532199.git.mkubecek@suse.cz>
 <2c29310b-a2a0-3867-a09f-51f2dc47ecd3@gmail.com>
 <20190328071853.GY26076@unicorn.suse.cz>
 <20190328134313.GO14297@nanopsycho>
 <20190328140428.GG26076@unicorn.suse.cz>
 <20190328173524.GR14297@nanopsycho>
 <20190328115256.2a7cb952@cakuba.netronome.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190328115256.2a7cb952@cakuba.netronome.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 28, 2019 at 11:52:56AM -0700, Jakub Kicinski wrote:
> On Thu, 28 Mar 2019 18:35:24 +0100, Jiri Pirko wrote:
> > Thu, Mar 28, 2019 at 03:04:28PM CET, mkubecek@suse.cz wrote:
> > >On Thu, Mar 28, 2019 at 02:43:13PM +0100, Jiri Pirko wrote:  
> > >> 
> > >> I don't like this. This should not be bitfield/set. This should be
> > >> simply nested array of enum values:
> > >> 
> > >> enum ethtool_link_mode {
> > >> 	ETHTOOL_LINK_MODE_10baseT_Half,
> > >> 	ETHTOOL_LINK_MODE_10baseT_Full,
> > >> 	ETHTOOL_LINK_MODE_100baseT_Half,
> > >> 	ETHTOOL_LINK_MODE_100baseT_Full,
> > >> 	ETHTOOL_LINK_MODE_1000baseT_Full,
> > >> };  
> > >
> > >We already have such enum. The problem with your "no string" approach is
> > >that it requires all userspace applications to (1) keep this enum in  
> > 
> > That is how it is usually done. UAPI defines ATTRS and values, userspace
> > assigns appropriate strings.
> 
> +1 FWIW, I'm with Jiri on the string situation.

And I'm still waiting for any of you to tell me how would you handle
private flags, stats, tests etc. without the string sets.

Ditching the verbose form of bit sets would be a nuisance for userspace
using the interface but compared to e.g. having to mix three different
kernel interfaces, it's just a minor problem. Ditching the static string
sets would mean giving up the opportunity to get rid of having to sync
all kinds of tables with every userspace consumer whenever a new flag is
introduced. Pity... but still doable. But how do you want to do without
the string sets which are provided by drivers?

Michal
