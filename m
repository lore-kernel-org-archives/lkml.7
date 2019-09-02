Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9F9EC3A59E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 13:09:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3CA32168B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 13:09:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730934AbfIBNJc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 09:09:32 -0400
Received: from mga11.intel.com ([192.55.52.93]:49446 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729840AbfIBNJb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 09:09:31 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Sep 2019 06:09:30 -0700
X-IronPort-AV: E=Sophos;i="5.64,459,1559545200"; 
   d="scan'208";a="176318019"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Sep 2019 06:09:27 -0700
Received: by paasikivi.fi.intel.com (Postfix, from userid 1000)
        id 98BFB20B48; Mon,  2 Sep 2019 16:09:25 +0300 (EEST)
Date:   Mon, 2 Sep 2019 16:09:25 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        rafael@kernel.org, linux-acpi@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH v4 11/11] lib/test_printf: Add tests for %pfw printk
 modifier
Message-ID: <20190902130925.GL5475@paasikivi.fi.intel.com>
References: <20190902083240.20367-1-sakari.ailus@linux.intel.com>
 <20190902083240.20367-12-sakari.ailus@linux.intel.com>
 <20190902122627.GG2680@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190902122627.GG2680@smile.fi.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 02, 2019 at 03:26:27PM +0300, Andy Shevchenko wrote:
> On Mon, Sep 02, 2019 at 11:32:40AM +0300, Sakari Ailus wrote:
> > Add a test for the %pfw printk modifier using software nodes.
> 
> > +	const struct software_node softnodes[] = {
> > +		{ .name = "first", },
> > +		{ .name = "second", .parent = &softnodes[0], },
> > +		{ .name = "third", .parent = &softnodes[1], },
> > +		{ NULL /* Guardian */ },
> > +	};
> 
> > +	test(full_name_second, "%pfw",
> > +	     software_node_fwnode(&softnodes[ARRAY_SIZE(softnodes) - 3]));
> > +	test(full_name, "%pfw",
> > +	     software_node_fwnode(&softnodes[ARRAY_SIZE(softnodes) - 2]));
> > +	test(full_name, "%pfwf",
> > +	     software_node_fwnode(&softnodes[ARRAY_SIZE(softnodes) - 2]));
> > +	test(second_name, "%pfwP",
> > +	     software_node_fwnode(&softnodes[ARRAY_SIZE(softnodes) - 3]));
> > +	test(third_name, "%pfwP",
> > +	     software_node_fwnode(&softnodes[ARRAY_SIZE(softnodes) - 2]));
> 
> 
> These can be shorted and easier to parse if you use absolute indexes.

The above doesn't end up accessing out-of-bounds memory without compiler
errors or warnings if the array is changed, therefore I'd prefer to keep it
as-is.

But I'll remove the comma from the guardian entry for v5. :-)

-- 
Sakari Ailus
sakari.ailus@linux.intel.com
