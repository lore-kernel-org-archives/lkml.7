Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D962EC4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 13:16:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEA6D20823
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 13:16:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731570AbfCZNQa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 09:16:30 -0400
Received: from mga01.intel.com ([192.55.52.88]:17905 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726266AbfCZNQ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 09:16:29 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Mar 2019 06:16:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,271,1549958400"; 
   d="scan'208";a="125978001"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by orsmga007.jf.intel.com with ESMTP; 26 Mar 2019 06:16:27 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1h8lwI-0003FJ-2J; Tue, 26 Mar 2019 15:16:26 +0200
Date:   Tue, 26 Mar 2019 15:16:26 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        rafael@kernel.org, linux-acpi@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 3/6] device property: Add a function to obtain a
 node's prefix
Message-ID: <20190326131626.GZ9224@smile.fi.intel.com>
References: <20190326124106.27694-1-sakari.ailus@linux.intel.com>
 <20190326124106.27694-4-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190326124106.27694-4-sakari.ailus@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2019 at 02:41:03PM +0200, Sakari Ailus wrote:
> The prefix is used for printing purpose before a node, and it also works
> as a separator between two nodes.
> 

One nit below.

> +static const char *
> +acpi_fwnode_get_name_prefix(const struct fwnode_handle *fwnode)
> +{
> +	struct fwnode_handle *parent;
> +

> +	parent = fwnode_get_parent(fwnode);
> +	/* Root node. */

I guess a comment could be easier to read if it goes before parent assignment
line.

> +	if (!parent)
> +		return "";
> +
> +	parent = fwnode_get_next_parent(parent);
> +	/* Second node from the root; no prefix here either. */

Ditto.

> +	if (!parent)
> +		return "";
> +
> +	fwnode_handle_put(parent);
> +
> +	/* ACPI device or data node. */
> +	return ".";
> +}

-- 
With Best Regards,
Andy Shevchenko


