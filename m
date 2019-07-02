Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AD6FC06510
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 16:36:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E3DD2082F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 16:36:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbfGBQf7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 12:35:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:51448 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726046AbfGBQf6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 12:35:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7AC55B9B1;
        Tue,  2 Jul 2019 16:35:57 +0000 (UTC)
Received: by unicorn.suse.cz (Postfix, from userid 1000)
        id 2B879E0159; Tue,  2 Jul 2019 18:35:57 +0200 (CEST)
Date:   Tue, 2 Jul 2019 18:35:57 +0200
From:   Michal Kubecek <mkubecek@suse.cz>
To:     netdev@vger.kernel.org
Cc:     Stephen Hemminger <stephen@networkplumber.org>,
        David Miller <davem@davemloft.net>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Jiri Pirko <jiri@resnulli.us>, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        John Linville <linville@tuxdriver.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v6 01/15] rtnetlink: provide permanent hardware
 address in RTM_NEWLINK
Message-ID: <20190702163557.GF20101@unicorn.suse.cz>
References: <cover.1562067622.git.mkubecek@suse.cz>
 <b6e0aefbcb58297b3ec0a12ee4be8e5194eee61a.1562067622.git.mkubecek@suse.cz>
 <20190702075500.1b9845e1@hermes.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190702075500.1b9845e1@hermes.lan>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 02, 2019 at 07:55:00AM -0700, Stephen Hemminger wrote:
> On Tue,  2 Jul 2019 13:49:44 +0200 (CEST)
> Michal Kubecek <mkubecek@suse.cz> wrote:
> 
> > Permanent hardware address of a network device was traditionally provided
> > via ethtool ioctl interface but as Jiri Pirko pointed out in a review of
> > ethtool netlink interface, rtnetlink is much more suitable for it so let's
> > add it to the RTM_NEWLINK message.
> > 
> > Add IFLA_PERM_ADDRESS attribute to RTM_NEWLINK messages unless the
> > permanent address is all zeros (i.e. device driver did not fill it). As
> > permanent address is not modifiable, reject userspace requests containing
> > IFLA_PERM_ADDRESS attribute.
> > 
> > Note: we already provide permanent hardware address for bond slaves;
> > unfortunately we cannot drop that attribute for backward compatibility
> > reasons.
> > 
> > v5 -> v6: only add the attribute if permanent address is not zero
> > 
> > Signed-off-by: Michal Kubecek <mkubecek@suse.cz>
> 
> Do you want to make an iproute patch to display this?

Yes, I'm going to submit it once this patch gets into net-next.

Michal

> Acked-by: Stephen Hemminger <stephen@networkplumber.org>
