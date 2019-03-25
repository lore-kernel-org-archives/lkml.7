Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1E89C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 09:57:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C30120870
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 09:57:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730474AbfCYJ5i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 05:57:38 -0400
Received: from mga18.intel.com ([134.134.136.126]:28708 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730216AbfCYJ5i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 05:57:38 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Mar 2019 02:57:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,256,1549958400"; 
   d="scan'208";a="331732903"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga005.fm.intel.com with SMTP; 25 Mar 2019 02:57:34 -0700
Received: by lahna (sSMTP sendmail emulation); Mon, 25 Mar 2019 11:57:33 +0200
Date:   Mon, 25 Mar 2019 11:57:33 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     linux-kernel@vger.kernel.org,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        netdev@vger.kernel.org
Subject: Re: [PATCH v2 17/28] thunderbolt: Add support for full PCIe daisy
 chains
Message-ID: <20190325095733.GC3622@lahna.fi.intel.com>
References: <20190206131738.43696-1-mika.westerberg@linux.intel.com>
 <20190206131738.43696-18-mika.westerberg@linux.intel.com>
 <20190324113144.wubme46hby7rj6r2@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190324113144.wubme46hby7rj6r2@wunner.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 24, 2019 at 12:31:44PM +0100, Lukas Wunner wrote:
> On Wed, Feb 06, 2019 at 04:17:27PM +0300, Mika Westerberg wrote:
> > @@ -63,6 +71,16 @@ static void tb_discover_tunnels(struct tb_switch *sw)
> >  	}
> >  }
> >  
> > +static void tb_switch_authorize(struct work_struct *work)
> > +{
> > +	struct tb_switch *sw = container_of(work, typeof(*sw), work);
> > +
> > +	mutex_lock(&sw->tb->lock);
> > +	if (!sw->is_unplugged)
> > +		tb_domain_approve_switch(sw->tb, sw);
> > +	mutex_unlock(&sw->tb->lock);
> > +}
> > +
> 
> You're establishing PCI tunnels by having tb_scan_port() schedule
> tb_switch_authorize() via a work item, which in turn calls
> tb_domain_approve_switch(), which in turn calls tb_approve_switch(),
> which in turn calls tb_tunnel_pci().
> 
> This seems kind of like a roundabout way of doing things, in particular
> since all switches are hardcoded to be automatically authorized.
> 
> Why don't you just invoke tb_tunnel_pci() directly from tb_scan_port()?

Indeed, it does not make much sense to schedule separate work item just
for this.

I'm will remove it in v3. However, instead of always creating PCIe
tunnels I'm going to propose that we implement the "user" security level
in the software connection manager by default. While DMA protection
relies on IOMMU, doing this allows user to turn off PCIe tunneling
completely (or implement their own whitelisting of known good devices
for example).

> And why is the work item needed?  I'm also confused that the work item
> has been present in struct tb_switch for 2 years but is put to use only
> now.

Yes, you are right - the work item here is not needed. It is actually
remnant from the original patch series. I'll cook a patch removing it.

> > -static void tb_activate_pcie_devices(struct tb *tb)
> > +static int tb_tunnel_pci(struct tb *tb, struct tb_switch *sw)
> >  {
> [...]
> > +	/*
> > +	 * Look up available down port. Since we are chaining, it is
> > +	 * typically found right above this switch.
> > +	 */
> > +	down = NULL;
> > +	parent_sw = tb_to_switch(sw->dev.parent);
> > +	while (parent_sw) {
> > +		down = tb_find_unused_down_port(parent_sw);
> > +		if (down)
> > +			break;
> > +		parent_sw = tb_to_switch(parent_sw->dev.parent);
> > +	}
> 
> The problem I see here is that there's no guarantee that the switch
> on which you're selecting a down port is actually itself connected
> with a PCI tunnel.  E.g., allocation of a tunnel to that parent
> switch may have failed.  In that case you end up establishing a
> tunnel between that parent switch and the newly connected switch
> but the tunnel is of no use.

Since this is going through tb_domain_approve_switch() it does not allow
PCIe tunnel creation if the parent is not authorized first.

> It would seem more logical to me to walk down the chain of newly
> connected switches and try to establish a PCI tunnel to each of
> them in order.  By deferring tunnel establishment to a work item,
> I think the tunnels may be established in an arbitrary order, right?

The workqueue is ordered so AFAIK they should be run in the order the
hotplug happened. In any case I'm going to remove the work item so this
should not be an issue.
