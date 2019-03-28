Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80A6DC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 06:41:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5689920811
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 06:41:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726351AbfC1Gls (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 02:41:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:39290 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725809AbfC1Glr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 02:41:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0BD5CAD63;
        Thu, 28 Mar 2019 06:41:46 +0000 (UTC)
Received: by unicorn.suse.cz (Postfix, from userid 1000)
        id 22D00E1404; Thu, 28 Mar 2019 07:41:43 +0100 (CET)
Date:   Thu, 28 Mar 2019 07:41:43 +0100
From:   Michal Kubecek <mkubecek@suse.cz>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Jiri Pirko <jiri@resnulli.us>, David Miller <davem@davemloft.net>,
        netdev@vger.kernel.org,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Andrew Lunn <andrew@lunn.ch>,
        John Linville <linville@tuxdriver.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 09/22] ethtool: implement EVENT notifications
Message-ID: <20190328064143.GX26076@unicorn.suse.cz>
References: <cover.1553532199.git.mkubecek@suse.cz>
 <971a93b567c81103716902cd1ad00946201f9710.1553532199.git.mkubecek@suse.cz>
 <20190327130428.GB14297@nanopsycho>
 <20190327141443.GS26076@unicorn.suse.cz>
 <a3d94fdf-964a-5a2c-3d96-74a0323af37e@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a3d94fdf-964a-5a2c-3d96-74a0323af37e@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 27, 2019 at 07:14:43PM -0700, Florian Fainelli wrote:
> 
> 
> On 3/27/2019 7:14 AM, Michal Kubecek wrote:
> > On Wed, Mar 27, 2019 at 02:04:28PM +0100, Jiri Pirko wrote:
> >> Mon, Mar 25, 2019 at 06:08:21PM CET, mkubecek@suse.cz wrote:
> >>> Three types of netlink notifications are introduced:
> >>>
> >>>  - ETHA_EVENT_NEWDEV to notify about newly registered network devices
> >>>  - ETHA_EVENT_DELDEV to notify about unregistered network devices
> >>>  - ETHA_EVENT_RENAMEDEV to notify about renamed network device
> >>>
> >>> The notifications are triggered by NETDEV_REGISTER, NETDEV_UNREGISTER and
> >>> NETDEV_CHANGENAME notifiers.
> >>>
> >>> These notifications are intended for applications and daemons monitoring
> >>> ethtool events to allow updating the list of existing devices without
> >>> having to open another socket for rtnetlink.
> >>
> >> Wait. You duplicate events that are already going out through RTNETLINK.
> >> App should open RTNETLINK in order to get those. Other apps are doing
> >> that too. I don't think that duplications like this are desirable :/
> > 
> > Is there a way to filter or at least recognize these events when using
> > rtnetlink? I couldn't find any. The only way seems to be getting every
> > RTM_NEWLINK message (there can be quite a lot of those), always perform
> > the lookup in my device list and recognize what happened - only to
> > almost always find that nothing interesting. It is possible, sure, but
> > I would really like to avoid it.
> 
> I am afraid you are right about this, would adding a filtering
> capability specifically for this in rtnetlink be a better route?

Maybe we could add new IFLA_EVENT_* values and use IFLA_EVENT to mark
RTM_NEWLINK messages announcing "new device" and "device rename". That
way, monitoring application would still need to parse all RTM_NEWLINK
messages but it would be able to recognize which announce a change in
device list without a lookup in its structures.

Michal
