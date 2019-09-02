Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BFAAC41514
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 07:29:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22FAC2377D
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 07:29:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729768AbfIBH33 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 03:29:29 -0400
Received: from mga14.intel.com ([192.55.52.115]:65312 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729408AbfIBH33 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 03:29:29 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Sep 2019 00:29:28 -0700
X-IronPort-AV: E=Sophos;i="5.64,457,1559545200"; 
   d="scan'208";a="186935814"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Sep 2019 00:29:26 -0700
Received: by paasikivi.fi.intel.com (Postfix, from userid 1000)
        id 6BD8920B09; Mon,  2 Sep 2019 10:29:24 +0300 (EEST)
Date:   Mon, 2 Sep 2019 10:29:24 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        rafael@kernel.org, linux-acpi@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 05/10] device property: Add a function to obtain a
 node's prefix
Message-ID: <20190902072924.GI5475@paasikivi.fi.intel.com>
References: <20190829101043.24963-1-sakari.ailus@linux.intel.com>
 <20190829101043.24963-6-sakari.ailus@linux.intel.com>
 <20190830124657.GE2680@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190830124657.GE2680@smile.fi.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On Fri, Aug 30, 2019 at 03:46:57PM +0300, Andy Shevchenko wrote:
> On Thu, Aug 29, 2019 at 01:10:38PM +0300, Sakari Ailus wrote:
> > The prefix is used for printing purpose before a node, and it also works
> > as a separator between two nodes.
> 
> > +	/* Is this the root node? */
> > +	parent = fwnode_get_parent(fwnode);
> > +	if (!parent)
> > +		return "";
> > +
> > +	/* Is this 2nd node from the root? */
> > +	parent = fwnode_get_next_parent(parent);
> > +	if (!parent)
> 
> Can we theoretically have a case when we got parent != NULL and thus taken
> reference, while the 2nd one is NULL and we leak reference here (and in all
> similar places)?

fwnode_get_next_parent() releases that reference unconditionally.

-- 
Sakari Ailus
sakari.ailus@linux.intel.com
