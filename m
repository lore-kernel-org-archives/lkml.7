Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C53C4C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 22:56:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D4952070B
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 22:56:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728494AbfC0W4N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 18:56:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:37702 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726059AbfC0W4M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 18:56:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9F2C3ACCD;
        Wed, 27 Mar 2019 22:56:10 +0000 (UTC)
Received: by unicorn.suse.cz (Postfix, from userid 1000)
        id 06E96E1404; Wed, 27 Mar 2019 23:56:08 +0100 (CET)
Date:   Wed, 27 Mar 2019 23:56:08 +0100
From:   Michal Kubecek <mkubecek@suse.cz>
To:     Jiri Pirko <jiri@resnulli.us>
Cc:     David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        John Linville <linville@tuxdriver.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 12/22] ethtool: provide string sets with
 GET_STRSET request
Message-ID: <20190327225607.GW26076@unicorn.suse.cz>
References: <cover.1553532199.git.mkubecek@suse.cz>
 <f5af581e33b4976b84eae7c7788e3fde9adfa83c.1553532199.git.mkubecek@suse.cz>
 <20190327201237.GG14297@nanopsycho>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190327201237.GG14297@nanopsycho>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 27, 2019 at 09:12:37PM +0100, Jiri Pirko wrote:
> Mon, Mar 25, 2019 at 06:08:30PM CET, mkubecek@suse.cz wrote:
> >Requests a contents of one or more string sets, i.e. indexed arrays of
> >strings; this information is provided by ETHTOOL_GSSET_INFO and
> >ETHTOOL_GSTRINGS commands of ioctl interface. There are three types of
> >requests:
> >
> >  - no NLM_F_DUMP, no device: get "global" stringsets
> >  - no NLM_F_DUMP, with device: get string sets related to the device
> >  - NLM_F_DUMP, no device: get device related string sets for all devices
> >
> >It's possible to request all string sets of given type or only specific
> >sets. With ETHA_STRSET_COUNTS flag, only set sizes (number of strings) are
> >returned.
> >
> >Signed-off-by: Michal Kubecek <mkubecek@suse.cz>
> >---
> > Documentation/networking/ethtool-netlink.txt |  46 +-
> > include/uapi/linux/ethtool.h                 |   2 +
> > include/uapi/linux/ethtool_netlink.h         |  43 ++
> > net/ethtool/Makefile                         |   2 +-
> > net/ethtool/netlink.c                        |   8 +
> > net/ethtool/netlink.h                        |   4 +
> > net/ethtool/strset.c                         | 447 +++++++++++++++++++
> > 7 files changed, 549 insertions(+), 3 deletions(-)
> > create mode 100644 net/ethtool/strset.c
> 
> First of all, the code is hard to follow. For reasons I mentioned in
> other replies (lack of prefixes, wrappers, etc).
> 
> More importantly, why do we need this? This concept of having strings in
> kernel for various things and features and sending them to userspace is
> weird. Certainly not common for Netlink interface. I believe these
> strings should be avoided and all should be communicated to userspace
> and back in form of well-defined Netlink attributes. We are introducing
> new Netlink API, lets do it properly and don't bring baggage from past.

For some of the global string sets where the values have fixed meaning
and new values are only appended to, it would be possible. But even for
those, keeping the list in sync between kernel and ethtool is often less
than perfect. And ethtool is only one of the tools using the interface.
So even in this case, I don't see string identifiers (or tags or names
or whatever we call them) as a baggage from past, rather as a solution
to a problem some of the existing interfaces have.

Then e.g. netdev features are not fixed in this sense: the same bit
index represents different feature in different kernels. I guess we
could introduce some fixed numeric identifiers for them and map between
those and actual indices but I don't see an advantage of such approach.

But the really important question is how would you handle what is
currently described by "per device" string sets, i.e. private flags,
(ethtool) statistics, tests, ...? For these, the list depends on the
driver or even device.

Michal
