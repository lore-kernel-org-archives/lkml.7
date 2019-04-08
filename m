Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A66A1C282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 07:35:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80A4C20870
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 07:35:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726527AbfDHHfW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 03:35:22 -0400
Received: from mga06.intel.com ([134.134.136.31]:50600 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726133AbfDHHfV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 03:35:21 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Apr 2019 00:35:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,324,1549958400"; 
   d="scan'208";a="159158465"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga002.fm.intel.com with SMTP; 08 Apr 2019 00:35:17 -0700
Received: by lahna (sSMTP sendmail emulation); Mon, 08 Apr 2019 10:35:17 +0300
Date:   Mon, 8 Apr 2019 10:35:17 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     linux-kernel@vger.kernel.org,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Christian Kellner <ckellner@redhat.com>,
        Mario.Limonciello@dell.com
Subject: Re: [PATCH v3 19/36] thunderbolt: Extend tunnel creation to more
 than 2 adjacent switches
Message-ID: <20190408073517.GA3622@lahna.fi.intel.com>
References: <20190328123633.42882-1-mika.westerberg@linux.intel.com>
 <20190328123633.42882-20-mika.westerberg@linux.intel.com>
 <20190407165425.2z5kqm3wcfrxvqzb@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190407165425.2z5kqm3wcfrxvqzb@wunner.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 07, 2019 at 06:54:25PM +0200, Lukas Wunner wrote:
> On Thu, Mar 28, 2019 at 03:36:16PM +0300, Mika Westerberg wrote:
> > +struct tb_path *tb_path_alloc(struct tb *tb, struct tb_port *src, int src_hopid,
> > +			      struct tb_port *dst, int dst_hopid, int link_nr,
> > +			      const char *name)
> >  {
> [...]
> > +	in_hopid = src_hopid;
> > +	out_port = NULL;
> > +
> > +	for (i = 0; i < num_hops; i++) {
> > +		in_port = tb_next_port_on_path(src, dst, out_port);
> > +		if (!in_port)
> > +			goto err;
> > +
> > +		if (in_port->dual_link_port && in_port->link_nr != link_nr)
> > +			in_port = in_port->dual_link_port;
> > +
> > +		ret = tb_port_alloc_in_hopid(in_port, in_hopid, -1);
> > +		if (ret < 0)
> > +			goto err;
> > +		in_hopid = ret;
> > +
> > +		out_port = tb_next_port_on_path(src, dst, in_port);
> > +		if (!out_port)
> > +			goto err;
> > +
> > +		if (out_port->dual_link_port && out_port->link_nr != link_nr)
> > +			out_port = out_port->dual_link_port;
> > +
> > +		if (i == num_hops - 1)
> > +			ret = tb_port_alloc_out_hopid(out_port, dst_hopid,
> > +						      dst_hopid);
> > +		else
> > +			ret = tb_port_alloc_out_hopid(out_port, -1, -1);
> > +
> > +		if (ret < 0)
> > +			goto err;
> > +		out_hopid = ret;
> > +
> > +		path->hops[i].in_hop_index = in_hopid;
> > +		path->hops[i].in_port = in_port;
> > +		path->hops[i].in_counter_index = -1;
> > +		path->hops[i].out_port = out_port;
> > +		path->hops[i].next_hop_index = out_hopid;
> > +
> > +		in_hopid = out_hopid;
> > +	}
> 
> According to the code comment in struct tb_regs_hop (in tb_regs.h),
> the out_hopid ("next_hop" in struct tb_regs_hop) denotes the
> "hop to take after sending the packet through out_port (on the
> incoming port of the next switch)".
> 
> So intuitively, the hop config space is like a routing table and
> the entry in in_port's hop config space specifies through which
> out_port the packets shall be routed, and which entry to look up
> on the remote port reachable through out_port.
> 
> This means that the out_hopid must always be identical to the in_hopid
> of out_port->remote.  Otherwise the routing wouldn't work.
> 
> And yet, you've introduced *two* struct ida for each port in
> patch 16.  This doesn't seem to make sense:  The out_hopids ida
> of a port always has to be identical to the in_hopids ida of that
> port's remote.  But if it's identical, why does it have to exist
> twice?

The reason for two HopID allocators (struct idas) is to make it possible
to track HopIDs to each direction. The same port can be output for one
path and input for another. I'm not sure how that can be done without
having two struct idas per port.

You are right, in case of out port HopID connecter to remote in port,
they should use the same HopID.

> Also, the above algorithm fails to ensure that the two struct ida
> are always identical:  It uses the out_hopid on the previous switch
> as *minimum* for the in_hopid on the current switch.  If that hopid
> is already taken by an existing tunnel, tb_port_alloc_in_hopid()
> will allocate a *different* hopid and thereby break the routing.
> 
> So either the code comment in struct tb_regs_hop is wrong, or this
> algorithm and the duplicate struct ida in patch 16 are wrong, or I'm
> missing something.

No you are right. I think the above code should look like:

	ret = tb_port_alloc_in_hopid(in_port, in_hopid, in_hopid);

instead of

	ret = tb_port_alloc_in_hopid(in_port, in_hopid, -1);

to make sure out port and in port of a remote use the same HopID. Will
fix.
