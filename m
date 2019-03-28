Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEE62C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 22:46:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5FFC2075E
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 22:46:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728360AbfC1WqV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 18:46:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:58064 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727120AbfC1WqU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 18:46:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8489CADA9;
        Thu, 28 Mar 2019 22:46:19 +0000 (UTC)
Received: by unicorn.suse.cz (Postfix, from userid 1000)
        id D06FAE1404; Thu, 28 Mar 2019 23:46:18 +0100 (CET)
Date:   Thu, 28 Mar 2019 23:46:18 +0100
From:   Michal Kubecek <mkubecek@suse.cz>
To:     Jakub Kicinski <jakub.kicinski@netronome.com>
Cc:     Jiri Pirko <jiri@resnulli.us>, David Miller <davem@davemloft.net>,
        netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        John Linville <linville@tuxdriver.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 13/22] ethtool: provide driver/device
 information in GET_INFO request
Message-ID: <20190328224618.GJ26076@unicorn.suse.cz>
References: <cover.1553532199.git.mkubecek@suse.cz>
 <b7aea4b2642b2fe6f12cfb843a03154f584f3bf6.1553532199.git.mkubecek@suse.cz>
 <20190327201411.GH14297@nanopsycho>
 <20190327222554.GV26076@unicorn.suse.cz>
 <20190328092126.GL14297@nanopsycho>
 <20190328095347.GB26076@unicorn.suse.cz>
 <20190328163439.GP14297@nanopsycho>
 <20190328130904.48905338@cakuba.netronome.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190328130904.48905338@cakuba.netronome.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 28, 2019 at 01:09:04PM -0700, Jakub Kicinski wrote:
> On Thu, 28 Mar 2019 17:34:39 +0100, Jiri Pirko wrote:
> > Thu, Mar 28, 2019 at 10:53:47AM CET, mkubecek@suse.cz wrote:
> > >On Thu, Mar 28, 2019 at 10:21:26AM +0100, Jiri Pirko wrote:  
> > >> Wed, Mar 27, 2019 at 11:25:54PM CET, mkubecek@suse.cz wrote:  
> > >> >
> > >> >I'm all for implementing new features which are are related to physical
> > >> >device (ASIC) rather than network interface only in devlink (at the
> > >> >level of kernel-userspace interface). But for features already provided
> > >> >by ethtool (userspace utility) I can't help seeing the state of devlink
> > >> >support in NIC drivers as a serious blocker.  
> > >> 
> > >> What I'm thinking about at for some time now would be en explicit
> > >> default devlink and devlink_port registration for every netdev for
> > >> drivers that does not support devlink themselves. I need to think about
> > >> it more, but it seems doable. Then we can hang appropriate things there
> > >> and make the ethtoolnl/devlink separation clear. I believe we need to do
> > >> it.  
> > >
> > >That sounds great, such "generic devlink" implementation would be a way
> > >around. Kernel could then emulate features which are not implemented by
> > >an actual devlink handler (i.e. "generic devlink" is used or particular
> > >handler is missing) by falling back to ethtool_ops handler so that
> > >userspace could rely on devlink API for things like device information,
> > >various dumps, flashing etc. without losing anything.  
> > 
> > Yep. Plan to do that next week.
> 
> The problem with the main part of dev info - fw_version - is that it is
> often overloaded in drivers and becomes impossible to parse for users.
> I'd rather we didn't dump that nasty chaos in devlink info and let it
> die with ethtool IOCTL.

If I understand you correctly, what you are suggesting would result in
"ethtool -i" through netlink not showing firmware version for NICs
without actual devlink implementation (which is vast majority of NICs at
the moment). I'm afraid doing that would make sure ioctl ethtool
wouldn't die any time soon.

> Flashing can also be handled at user space tool level.

I'm not sure how to understand this.

Michal
