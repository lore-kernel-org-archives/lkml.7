Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64EBBC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 11:43:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3754F21773
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 11:43:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726179AbfC1Ln6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 07:43:58 -0400
Received: from mga07.intel.com ([134.134.136.100]:27352 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726334AbfC1Ln5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 07:43:57 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Mar 2019 04:43:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,280,1549958400"; 
   d="scan'208";a="135526536"
Received: from pmangere-mobl1.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.252.62.244])
  by fmsmga008.fm.intel.com with ESMTP; 28 Mar 2019 04:43:54 -0700
Received: by kekkonen.fi.intel.com (Postfix, from userid 1000)
        id 575E921E50; Thu, 28 Mar 2019 13:43:51 +0200 (EET)
Date:   Thu, 28 Mar 2019 13:43:51 +0200
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, rafael@kernel.org,
        linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 3/6] device property: Add a function to obtain a
 node's prefix
Message-ID: <20190328114350.cyzj7zkbmbu4a2i4@kekkonen.localdomain>
References: <20190326124106.27694-1-sakari.ailus@linux.intel.com>
 <20190326124106.27694-4-sakari.ailus@linux.intel.com>
 <20190326131626.GZ9224@smile.fi.intel.com>
 <20190326133248.2nrm5javjw4vd2yq@paasikivi.fi.intel.com>
 <20190327123659.nna3hqcotnerptiz@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190327123659.nna3hqcotnerptiz@pathway.suse.cz>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 27, 2019 at 01:36:59PM +0100, Petr Mladek wrote:
> On Tue 2019-03-26 15:32:48, Sakari Ailus wrote:
> > Hi Andy,
> > 
> > On Tue, Mar 26, 2019 at 03:16:26PM +0200, Andy Shevchenko wrote:
> > > On Tue, Mar 26, 2019 at 02:41:03PM +0200, Sakari Ailus wrote:
> > > > The prefix is used for printing purpose before a node, and it also works
> > > > as a separator between two nodes.
> > > > 
> > > 
> > > One nit below.
> > > 
> > > > +static const char *
> > > > +acpi_fwnode_get_name_prefix(const struct fwnode_handle *fwnode)
> > > > +{
> > > > +	struct fwnode_handle *parent;
> > > > +
> > > 
> > > > +	parent = fwnode_get_parent(fwnode);
> > > > +	/* Root node. */
> > > 
> > > I guess a comment could be easier to read if it goes before parent assignment
> > > line.
> > 
> > Only if the comments are changed accordingly. What we're doing here is
> > trying to figure out whether this is the root node. I can do that for v3.
> 
> IMHO, the comment in acpi_fwnode_get_name() is easier to understand:
> 
> /* Is this the root node? */
> 
> > > 
> > > > +	if (!parent)
> > > > +		return "";
> > > > +
> > > > +	parent = fwnode_get_next_parent(parent);
> > > > +	/* Second node from the root; no prefix here either. */
> > > 
> > > Ditto.
> 
> /* Is this 2nd node from the root? */

I used both the strings.

-- 
Sakari Ailus
sakari.ailus@linux.intel.com
