Return-Path: <SRS0=A1VX=SJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD777C10F0E
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 16:54:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E2A720896
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 16:54:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbfDGQy3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Apr 2019 12:54:29 -0400
Received: from bmailout2.hostsharing.net ([83.223.90.240]:43471 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726335AbfDGQy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Apr 2019 12:54:29 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id CC55E2800B3D1;
        Sun,  7 Apr 2019 18:54:25 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 4D20613BBF6; Sun,  7 Apr 2019 18:54:25 +0200 (CEST)
Date:   Sun, 7 Apr 2019 18:54:25 +0200
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
Message-ID: <20190407165425.2z5kqm3wcfrxvqzb@wunner.de>
References: <20190328123633.42882-1-mika.westerberg@linux.intel.com>
 <20190328123633.42882-20-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190328123633.42882-20-mika.westerberg@linux.intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 28, 2019 at 03:36:16PM +0300, Mika Westerberg wrote:
> +struct tb_path *tb_path_alloc(struct tb *tb, struct tb_port *src, int src_hopid,
> +			      struct tb_port *dst, int dst_hopid, int link_nr,
> +			      const char *name)
>  {
[...]
> +	in_hopid = src_hopid;
> +	out_port = NULL;
> +
> +	for (i = 0; i < num_hops; i++) {
> +		in_port = tb_next_port_on_path(src, dst, out_port);
> +		if (!in_port)
> +			goto err;
> +
> +		if (in_port->dual_link_port && in_port->link_nr != link_nr)
> +			in_port = in_port->dual_link_port;
> +
> +		ret = tb_port_alloc_in_hopid(in_port, in_hopid, -1);
> +		if (ret < 0)
> +			goto err;
> +		in_hopid = ret;
> +
> +		out_port = tb_next_port_on_path(src, dst, in_port);
> +		if (!out_port)
> +			goto err;
> +
> +		if (out_port->dual_link_port && out_port->link_nr != link_nr)
> +			out_port = out_port->dual_link_port;
> +
> +		if (i == num_hops - 1)
> +			ret = tb_port_alloc_out_hopid(out_port, dst_hopid,
> +						      dst_hopid);
> +		else
> +			ret = tb_port_alloc_out_hopid(out_port, -1, -1);
> +
> +		if (ret < 0)
> +			goto err;
> +		out_hopid = ret;
> +
> +		path->hops[i].in_hop_index = in_hopid;
> +		path->hops[i].in_port = in_port;
> +		path->hops[i].in_counter_index = -1;
> +		path->hops[i].out_port = out_port;
> +		path->hops[i].next_hop_index = out_hopid;
> +
> +		in_hopid = out_hopid;
> +	}

According to the code comment in struct tb_regs_hop (in tb_regs.h),
the out_hopid ("next_hop" in struct tb_regs_hop) denotes the
"hop to take after sending the packet through out_port (on the
incoming port of the next switch)".

So intuitively, the hop config space is like a routing table and
the entry in in_port's hop config space specifies through which
out_port the packets shall be routed, and which entry to look up
on the remote port reachable through out_port.

This means that the out_hopid must always be identical to the in_hopid
of out_port->remote.  Otherwise the routing wouldn't work.

And yet, you've introduced *two* struct ida for each port in
patch 16.  This doesn't seem to make sense:  The out_hopids ida
of a port always has to be identical to the in_hopids ida of that
port's remote.  But if it's identical, why does it have to exist
twice?

Also, the above algorithm fails to ensure that the two struct ida
are always identical:  It uses the out_hopid on the previous switch
as *minimum* for the in_hopid on the current switch.  If that hopid
is already taken by an existing tunnel, tb_port_alloc_in_hopid()
will allocate a *different* hopid and thereby break the routing.

So either the code comment in struct tb_regs_hop is wrong, or this
algorithm and the duplicate struct ida in patch 16 are wrong, or I'm
missing something.

Thanks,

Lukas
