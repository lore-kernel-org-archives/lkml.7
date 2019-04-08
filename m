Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31F6FC282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 08:53:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0887520883
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 08:53:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbfDHIxl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 04:53:41 -0400
Received: from bmailout1.hostsharing.net ([83.223.95.100]:59405 "EHLO
        bmailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbfDHIxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 04:53:40 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id 3849F30000D31;
        Mon,  8 Apr 2019 10:53:38 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id EB9263F2B3; Mon,  8 Apr 2019 10:53:37 +0200 (CEST)
Date:   Mon, 8 Apr 2019 10:53:37 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Christian Kellner <ckellner@redhat.com>,
        Mario.Limonciello@dell.com
Subject: Re: [PATCH v3 19/36] thunderbolt: Extend tunnel creation to more
 than 2 adjacent switches
Message-ID: <20190408085337.slcnajkgxjq4twkh@wunner.de>
References: <20190328123633.42882-1-mika.westerberg@linux.intel.com>
 <20190328123633.42882-20-mika.westerberg@linux.intel.com>
 <20190407165425.2z5kqm3wcfrxvqzb@wunner.de>
 <20190408073517.GA3622@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190408073517.GA3622@lahna.fi.intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 08, 2019 at 10:35:17AM +0300, Mika Westerberg wrote:
> On Sun, Apr 07, 2019 at 06:54:25PM +0200, Lukas Wunner wrote:
> > According to the code comment in struct tb_regs_hop (in tb_regs.h),
> > the out_hopid ("next_hop" in struct tb_regs_hop) denotes the
> > "hop to take after sending the packet through out_port (on the
> > incoming port of the next switch)".
> > 
> > So intuitively, the hop config space is like a routing table and
> > the entry in in_port's hop config space specifies through which
> > out_port the packets shall be routed, and which entry to look up
> > on the remote port reachable through out_port.
> > 
> > This means that the out_hopid must always be identical to the in_hopid
> > of out_port->remote.  Otherwise the routing wouldn't work.
> > 
> > And yet, you've introduced *two* struct ida for each port in
> > patch 16.  This doesn't seem to make sense:  The out_hopids ida
> > of a port always has to be identical to the in_hopids ida of that
> > port's remote.  But if it's identical, why does it have to exist
> > twice?
> 
> The reason for two HopID allocators (struct idas) is to make it possible
> to track HopIDs to each direction. The same port can be output for one
> path and input for another. I'm not sure how that can be done without
> having two struct idas per port.
> 
> You are right, in case of out port HopID connecter to remote in port,
> they should use the same HopID.

Hm, what other cases are there, i.e. what is the meaning of a tb_regs_hop's
"next_hop" field if "out_port" doesn't have a remote?  (And why does it
need to be tracked on the out_port?  In case a remote is added later?)

Thanks,

Lukas
