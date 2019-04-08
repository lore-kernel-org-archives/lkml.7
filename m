Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F670C282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 09:49:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3470320870
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 09:49:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbfDHJtG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 05:49:06 -0400
Received: from bmailout1.hostsharing.net ([83.223.95.100]:46007 "EHLO
        bmailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726632AbfDHJtG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 05:49:06 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id 58AD530000CE3;
        Mon,  8 Apr 2019 11:49:04 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 203F656B89; Mon,  8 Apr 2019 11:49:04 +0200 (CEST)
Date:   Mon, 8 Apr 2019 11:49:04 +0200
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
Message-ID: <20190408094904.o3fo2anhogyxpaja@wunner.de>
References: <20190328123633.42882-1-mika.westerberg@linux.intel.com>
 <20190328123633.42882-20-mika.westerberg@linux.intel.com>
 <20190407165425.2z5kqm3wcfrxvqzb@wunner.de>
 <20190408073517.GA3622@lahna.fi.intel.com>
 <20190408085337.slcnajkgxjq4twkh@wunner.de>
 <20190408090744.GK3622@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190408090744.GK3622@lahna.fi.intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 08, 2019 at 12:07:44PM +0300, Mika Westerberg wrote:
> On Mon, Apr 08, 2019 at 10:53:37AM +0200, Lukas Wunner wrote:
> > Hm, what other cases are there, i.e. what is the meaning of a tb_regs_hop's
> > "next_hop" field if "out_port" doesn't have a remote?  (And why does it
> > need to be tracked on the out_port?  In case a remote is added later?)
> 
> We also need to program HopIDs for adapter ports (PCIe, DP, NHI) in
> order to enable a path. The "next_hop" from NULL port to an adapter port
> tells the HopID a packet gets when it is routed to the adapter port and
> the adapter port registers then are used to specify which HopID means
> what (for PCIe there is only 8 but for DP there is 8 and 9, for NHI it
> can be anything the service driver has negotiated).

Okay, so in_hopids are the entries allocated in this port's hop config
space, whereas out_hopids only really bears significance for adapter
ports.  For null ports (in-between two adapter ports on a path),
out_hopids is identical to the in_hopids of the next hop (IIUC).

That probably merits mentioning in struct tb_port's kerneldoc.

Thanks,

Lukas
