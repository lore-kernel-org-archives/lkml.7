Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38039C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 13:32:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E34AE2084B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 13:32:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731594AbfCZNcv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 09:32:51 -0400
Received: from mga04.intel.com ([192.55.52.120]:24320 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726175AbfCZNcv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 09:32:51 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Mar 2019 06:32:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,271,1549958400"; 
   d="scan'208";a="155323719"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by fmsmga002.fm.intel.com with ESMTP; 26 Mar 2019 06:32:49 -0700
Received: by paasikivi.fi.intel.com (Postfix, from userid 1000)
        id C9059205E7; Tue, 26 Mar 2019 15:32:48 +0200 (EET)
Date:   Tue, 26 Mar 2019 15:32:48 +0200
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        rafael@kernel.org, linux-acpi@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 3/6] device property: Add a function to obtain a
 node's prefix
Message-ID: <20190326133248.2nrm5javjw4vd2yq@paasikivi.fi.intel.com>
References: <20190326124106.27694-1-sakari.ailus@linux.intel.com>
 <20190326124106.27694-4-sakari.ailus@linux.intel.com>
 <20190326131626.GZ9224@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190326131626.GZ9224@smile.fi.intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On Tue, Mar 26, 2019 at 03:16:26PM +0200, Andy Shevchenko wrote:
> On Tue, Mar 26, 2019 at 02:41:03PM +0200, Sakari Ailus wrote:
> > The prefix is used for printing purpose before a node, and it also works
> > as a separator between two nodes.
> > 
> 
> One nit below.
> 
> > +static const char *
> > +acpi_fwnode_get_name_prefix(const struct fwnode_handle *fwnode)
> > +{
> > +	struct fwnode_handle *parent;
> > +
> 
> > +	parent = fwnode_get_parent(fwnode);
> > +	/* Root node. */
> 
> I guess a comment could be easier to read if it goes before parent assignment
> line.

Only if the comments are changed accordingly. What we're doing here is
trying to figure out whether this is the root node. I can do that for v3.

> 
> > +	if (!parent)
> > +		return "";
> > +
> > +	parent = fwnode_get_next_parent(parent);
> > +	/* Second node from the root; no prefix here either. */
> 
> Ditto.
> 
> > +	if (!parent)
> > +		return "";
> > +
> > +	fwnode_handle_put(parent);
> > +
> > +	/* ACPI device or data node. */
> > +	return ".";
> > +}

-- 
Regards,

Sakari Ailus
sakari.ailus@linux.intel.com
