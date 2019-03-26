Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5826C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 17:59:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEB302082F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 17:59:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732359AbfCZR7e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 13:59:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:55640 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731828AbfCZR7d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 13:59:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 70064AEF8;
        Tue, 26 Mar 2019 17:59:32 +0000 (UTC)
Received: by unicorn.suse.cz (Postfix, from userid 1000)
        id 12056E1404; Tue, 26 Mar 2019 18:59:32 +0100 (CET)
Date:   Tue, 26 Mar 2019 18:59:32 +0100
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
Message-ID: <20190326175932.GN26076@unicorn.suse.cz>
References: <cover.1553532199.git.mkubecek@suse.cz>
 <9123f942b484ef4bbb684bb1f4aa2b70d673a259.1553532199.git.mkubecek@suse.cz>
 <20190326155911.GA4958@nanopsycho.orion>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190326155911.GA4958@nanopsycho.orion>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2019 at 04:59:11PM +0100, Jiri Pirko wrote:
> Mon, Mar 25, 2019 at 06:08:15PM CET, mkubecek@suse.cz wrote:
> >Declare attribute type constants and add helper functions to generate and
> >parse arbitrary length bit sets.
> 
> Hmm, this looks like a lot of work. Two things:
> 1) This is generic. Not really related to ethtool in any way. Could this
>    be done in netlink common code?

I suppose it could if other netlink based APIs would be interested in
using it. The only ethtool specific part is the support for "legacy
style names" (fixed size strings) but that is something I'm not really
happy about.  Perhaps it's time to return to the original idea of
supporting only arrays of (char *) and creating them around existing
fixed size ones.

> 2) Did you think about leveraging NLA_BITFIELD32? What I mean is this:
> NEST_START
>    NLA_BITFIELD32 index 0 (bit 0-31)
>    NLA_BITFIELD32 index 1 (bit 32-63)
>    NLA_BITFIELD32 index 2 (bit 64-95)
>    NLA_BITFIELD32 index 3 (bit 96-127)
>    ....
> NEST_END
> It is basically an array of NLA_BITFIELD32.

That would be similar to compact form but it would introduce the
interleaving and extra struct nlattr header for each block. I don't
think it would make things easier.

The verbose form is meant to allow requests like

  ethtool -K eth0 tx-vlan-stag-hw-insert on
  ethtool -s eth0 advertise 1000baseT/Full off

without either keeping the table of available flags in sync between
kernel and userspace (all userspace users of the API) or having to ask
for the list first (in case of one shot requests as above; long running
tools like "ethtool --monitor" or config management daemons would keep
the tables and use compact form).

Michal
