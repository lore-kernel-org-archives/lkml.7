Return-Path: <SRS0=GVTe=2R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10DFFC2D0C6
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 12:48:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEF01208C4
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 12:48:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727102AbfL0MsE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Dec 2019 07:48:04 -0500
Received: from mx2.suse.de ([195.135.220.15]:47610 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726053AbfL0MsD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Dec 2019 07:48:03 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id BEBD8ACD7;
        Fri, 27 Dec 2019 12:48:01 +0000 (UTC)
Received: by unicorn.suse.cz (Postfix, from userid 1000)
        id 11E7AE008A; Fri, 27 Dec 2019 13:47:59 +0100 (CET)
Date:   Fri, 27 Dec 2019 13:47:59 +0100
From:   Michal Kubecek <mkubecek@suse.cz>
To:     netdev@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        David Miller <davem@davemloft.net>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Jiri Pirko <jiri@resnulli.us>, Andrew Lunn <andrew@lunn.ch>,
        John Linville <linville@tuxdriver.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v8 14/14] ethtool: provide link state with
 LINKSTATE_GET request
Message-ID: <20191227124759.GK21614@unicorn.suse.cz>
References: <cover.1577052887.git.mkubecek@suse.cz>
 <7a6c4161fc6d29620bdc95a919e03f8be8b91e48.1577052887.git.mkubecek@suse.cz>
 <918da8cd-7ebc-b895-85c8-afad9eed6036@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <918da8cd-7ebc-b895-85c8-afad9eed6036@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 23, 2019 at 08:44:19PM -0800, Florian Fainelli wrote:
> 
> 
> On 12/22/2019 3:46 PM, Michal Kubecek wrote:
> > Implement LINKSTATE_GET netlink request to get link state information.
> > 
> > At the moment, only link up flag as provided by ETHTOOL_GLINK ioctl command
> > is returned.
> > 
> > LINKSTATE_GET request can be used with NLM_F_DUMP (without device
> > identification) to request the information for all devices in current
> > network namespace providing the data.
> > 
> > Signed-off-by: Michal Kubecek <mkubecek@suse.cz>
> > ---
> 
> [snip]
> 
> > +Kernel response contents:
> > +
> > +  ====================================  ======  ==========================
> > +  ``ETHTOOL_A_LINKSTATE_HEADER``        nested  reply header
> > +  ``ETHTOOL_A_LINKSTATE_LINK``          u8      autonegotiation status
> 
> ^ ==== Humm, auto-negotiation status may not be exactly accurate
> especially with complex devices with SerDes/PHY/SFPs/what have you/.
> Other than that, the code looks correct:

It seems I forgot to edit this cell text after copy&paste from
LINKMODES_GET above. Fixed in v9, thanks.

Michal

> Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
> -- 
> Florian
