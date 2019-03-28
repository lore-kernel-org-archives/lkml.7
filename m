Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 236ECC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 09:53:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED45C206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 09:53:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726611AbfC1Jxt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 05:53:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:57184 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725846AbfC1Jxt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 05:53:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3AD79AD43;
        Thu, 28 Mar 2019 09:53:48 +0000 (UTC)
Received: by unicorn.suse.cz (Postfix, from userid 1000)
        id 92F71E1404; Thu, 28 Mar 2019 10:53:47 +0100 (CET)
Date:   Thu, 28 Mar 2019 10:53:47 +0100
From:   Michal Kubecek <mkubecek@suse.cz>
To:     Jiri Pirko <jiri@resnulli.us>
Cc:     David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        John Linville <linville@tuxdriver.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 13/22] ethtool: provide driver/device
 information in GET_INFO request
Message-ID: <20190328095347.GB26076@unicorn.suse.cz>
References: <cover.1553532199.git.mkubecek@suse.cz>
 <b7aea4b2642b2fe6f12cfb843a03154f584f3bf6.1553532199.git.mkubecek@suse.cz>
 <20190327201411.GH14297@nanopsycho>
 <20190327222554.GV26076@unicorn.suse.cz>
 <20190328092126.GL14297@nanopsycho>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190328092126.GL14297@nanopsycho>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 28, 2019 at 10:21:26AM +0100, Jiri Pirko wrote:
> Wed, Mar 27, 2019 at 11:25:54PM CET, mkubecek@suse.cz wrote:
> >
> >I'm all for implementing new features which are are related to physical
> >device (ASIC) rather than network interface only in devlink (at the
> >level of kernel-userspace interface). But for features already provided
> >by ethtool (userspace utility) I can't help seeing the state of devlink
> >support in NIC drivers as a serious blocker.
> 
> What I'm thinking about at for some time now would be en explicit
> default devlink and devlink_port registration for every netdev for
> drivers that does not support devlink themselves. I need to think about
> it more, but it seems doable. Then we can hang appropriate things there
> and make the ethtoolnl/devlink separation clear. I believe we need to do
> it.

That sounds great, such "generic devlink" implementation would be a way
around. Kernel could then emulate features which are not implemented by
an actual devlink handler (i.e. "generic devlink" is used or particular
handler is missing) by falling back to ethtool_ops handler so that
userspace could rely on devlink API for things like device information,
various dumps, flashing etc. without losing anything.

Michal
