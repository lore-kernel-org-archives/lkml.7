Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 145C2C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 10:19:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E20DD20700
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 10:19:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733089AbfC0KT0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 06:19:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:35656 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725827AbfC0KTZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 06:19:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0ED68AD2F;
        Wed, 27 Mar 2019 10:19:24 +0000 (UTC)
Received: by unicorn.suse.cz (Postfix, from userid 1000)
        id 855C1E1404; Wed, 27 Mar 2019 11:19:23 +0100 (CET)
Date:   Wed, 27 Mar 2019 11:19:23 +0100
From:   Michal Kubecek <mkubecek@suse.cz>
To:     Jiri Pirko <jiri@resnulli.us>
Cc:     David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        John Linville <linville@tuxdriver.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 07/22] ethtool: netlink bitset handling
Message-ID: <20190327101923.GR26076@unicorn.suse.cz>
References: <cover.1553532199.git.mkubecek@suse.cz>
 <9123f942b484ef4bbb684bb1f4aa2b70d673a259.1553532199.git.mkubecek@suse.cz>
 <20190326155911.GA4958@nanopsycho.orion>
 <20190326175932.GN26076@unicorn.suse.cz>
 <20190327095749.GD6979@nanopsycho>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190327095749.GD6979@nanopsycho>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 27, 2019 at 10:57:49AM +0100, Jiri Pirko wrote:
> Tue, Mar 26, 2019 at 06:59:32PM CET, mkubecek@suse.cz wrote:
> >On Tue, Mar 26, 2019 at 04:59:11PM +0100, Jiri Pirko wrote:
> >> Mon, Mar 25, 2019 at 06:08:15PM CET, mkubecek@suse.cz wrote:
> >> >Declare attribute type constants and add helper functions to generate and
> >> >parse arbitrary length bit sets.
> >> 
> >> Hmm, this looks like a lot of work. Two things:
> >> 1) This is generic. Not really related to ethtool in any way. Could this
> >>    be done in netlink common code?
> >
> >I suppose it could if other netlink based APIs would be interested in
> >using it. The only ethtool specific part is the support for "legacy
> >style names" (fixed size strings) but that is something I'm not really
> >happy about.  Perhaps it's time to return to the original idea of
> >supporting only arrays of (char *) and creating them around existing
> >fixed size ones.
> 
> Wait, could you please describe this more?

At the moment, there are two formats of bit name tables. Legacy format
which is used by ioctl string sets, e.g.

const char netdev_features_strings[NETDEV_FEATURE_COUNT][ETH_GSTRING_LEN] = {
	...
};

(the same is provided by NIC drivers with ethtool_ops::get_strings())
and simple format used for newly added string sets, e.g.

const char *const link_mode_names[] = {
	...
};

If the bitset implementation is to be used by other APIs, legacy format
support would make little sense so I would suggest to drop legacy format
support from bitset code and build a (const char **) "index" for ethtool
legacy string arrays before passing it to bitset related functions.

Michal
