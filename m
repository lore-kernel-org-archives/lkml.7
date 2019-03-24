Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98DC4C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 11:31:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70EE8222D0
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 11:31:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728615AbfCXLbr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 07:31:47 -0400
Received: from bmailout2.hostsharing.net ([83.223.90.240]:52689 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726160AbfCXLbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 07:31:46 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id 847262800B48A;
        Sun, 24 Mar 2019 12:31:44 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 34A8E33099; Sun, 24 Mar 2019 12:31:44 +0100 (CET)
Date:   Sun, 24 Mar 2019 12:31:44 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        netdev@vger.kernel.org
Subject: Re: [PATCH v2 17/28] thunderbolt: Add support for full PCIe daisy
 chains
Message-ID: <20190324113144.wubme46hby7rj6r2@wunner.de>
References: <20190206131738.43696-1-mika.westerberg@linux.intel.com>
 <20190206131738.43696-18-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190206131738.43696-18-mika.westerberg@linux.intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 06, 2019 at 04:17:27PM +0300, Mika Westerberg wrote:
> @@ -63,6 +71,16 @@ static void tb_discover_tunnels(struct tb_switch *sw)
>  	}
>  }
>  
> +static void tb_switch_authorize(struct work_struct *work)
> +{
> +	struct tb_switch *sw = container_of(work, typeof(*sw), work);
> +
> +	mutex_lock(&sw->tb->lock);
> +	if (!sw->is_unplugged)
> +		tb_domain_approve_switch(sw->tb, sw);
> +	mutex_unlock(&sw->tb->lock);
> +}
> +

You're establishing PCI tunnels by having tb_scan_port() schedule
tb_switch_authorize() via a work item, which in turn calls
tb_domain_approve_switch(), which in turn calls tb_approve_switch(),
which in turn calls tb_tunnel_pci().

This seems kind of like a roundabout way of doing things, in particular
since all switches are hardcoded to be automatically authorized.

Why don't you just invoke tb_tunnel_pci() directly from tb_scan_port()?
And why is the work item needed?  I'm also confused that the work item
has been present in struct tb_switch for 2 years but is put to use only
now.


> -static void tb_activate_pcie_devices(struct tb *tb)
> +static int tb_tunnel_pci(struct tb *tb, struct tb_switch *sw)
>  {
[...]
> +	/*
> +	 * Look up available down port. Since we are chaining, it is
> +	 * typically found right above this switch.
> +	 */
> +	down = NULL;
> +	parent_sw = tb_to_switch(sw->dev.parent);
> +	while (parent_sw) {
> +		down = tb_find_unused_down_port(parent_sw);
> +		if (down)
> +			break;
> +		parent_sw = tb_to_switch(parent_sw->dev.parent);
> +	}

The problem I see here is that there's no guarantee that the switch
on which you're selecting a down port is actually itself connected
with a PCI tunnel.  E.g., allocation of a tunnel to that parent
switch may have failed.  In that case you end up establishing a
tunnel between that parent switch and the newly connected switch
but the tunnel is of no use.

It would seem more logical to me to walk down the chain of newly
connected switches and try to establish a PCI tunnel to each of
them in order.  By deferring tunnel establishment to a work item,
I think the tunnels may be established in an arbitrary order, right?

Thanks,

Lukas
