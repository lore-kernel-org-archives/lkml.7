Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1ECEC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 12:37:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B45FB20700
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 12:37:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729082AbfC0MhB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 08:37:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:57142 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728194AbfC0MhB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 08:37:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DA435AF6A;
        Wed, 27 Mar 2019 12:36:59 +0000 (UTC)
Date:   Wed, 27 Mar 2019 13:36:59 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, rafael@kernel.org,
        linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 3/6] device property: Add a function to obtain a
 node's prefix
Message-ID: <20190327123659.nna3hqcotnerptiz@pathway.suse.cz>
References: <20190326124106.27694-1-sakari.ailus@linux.intel.com>
 <20190326124106.27694-4-sakari.ailus@linux.intel.com>
 <20190326131626.GZ9224@smile.fi.intel.com>
 <20190326133248.2nrm5javjw4vd2yq@paasikivi.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190326133248.2nrm5javjw4vd2yq@paasikivi.fi.intel.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2019-03-26 15:32:48, Sakari Ailus wrote:
> Hi Andy,
> 
> On Tue, Mar 26, 2019 at 03:16:26PM +0200, Andy Shevchenko wrote:
> > On Tue, Mar 26, 2019 at 02:41:03PM +0200, Sakari Ailus wrote:
> > > The prefix is used for printing purpose before a node, and it also works
> > > as a separator between two nodes.
> > > 
> > 
> > One nit below.
> > 
> > > +static const char *
> > > +acpi_fwnode_get_name_prefix(const struct fwnode_handle *fwnode)
> > > +{
> > > +	struct fwnode_handle *parent;
> > > +
> > 
> > > +	parent = fwnode_get_parent(fwnode);
> > > +	/* Root node. */
> > 
> > I guess a comment could be easier to read if it goes before parent assignment
> > line.
> 
> Only if the comments are changed accordingly. What we're doing here is
> trying to figure out whether this is the root node. I can do that for v3.

IMHO, the comment in acpi_fwnode_get_name() is easier to understand:

/* Is this the root node? */

> > 
> > > +	if (!parent)
> > > +		return "";
> > > +
> > > +	parent = fwnode_get_next_parent(parent);
> > > +	/* Second node from the root; no prefix here either. */
> > 
> > Ditto.

/* Is this 2nd node from the root? */

> > > +	if (!parent)
> > > +		return "";
> > > +
> > > +	fwnode_handle_put(parent);
> > > +
> > > +	/* ACPI device or data node. */
> > > +	return ".";
> > > +}

Best Regards,
Petr
