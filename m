Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BDA8C3A5A8
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 09:48:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E6902168B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 09:48:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731021AbfIBJsG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 05:48:06 -0400
Received: from mga04.intel.com ([192.55.52.120]:18169 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730106AbfIBJsF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 05:48:05 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Sep 2019 02:48:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,457,1559545200"; 
   d="scan'208";a="189515436"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by FMSMGA003.fm.intel.com with ESMTP; 02 Sep 2019 02:48:03 -0700
Received: from andy by smile with local (Exim 4.92.1)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1i4iwM-00086E-H9; Mon, 02 Sep 2019 12:48:02 +0300
Date:   Mon, 2 Sep 2019 12:48:02 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        rafael@kernel.org, linux-acpi@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 07/10] lib/vsprintf: Make use of fwnode API to obtain
 node names and separators
Message-ID: <20190902094802.GT2680@smile.fi.intel.com>
References: <20190829101043.24963-1-sakari.ailus@linux.intel.com>
 <20190829101043.24963-8-sakari.ailus@linux.intel.com>
 <20190830125314.GG2680@smile.fi.intel.com>
 <20190902071130.GF5475@paasikivi.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190902071130.GF5475@paasikivi.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 02, 2019 at 10:11:30AM +0300, Sakari Ailus wrote:
> On Fri, Aug 30, 2019 at 03:53:14PM +0300, Andy Shevchenko wrote:
> > On Thu, Aug 29, 2019 at 01:10:40PM +0300, Sakari Ailus wrote:
> > > Instead of implementing our own means of discovering parent nodes, node
> > > names or counting how many parents a node has, use the newly added
> > > functions in the fwnode API to obtain that information.
> > > 
> > 
> > Some style comments below.
> > Nevertheless,
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Thanks!

> > >  		case 'f':	/* full_name */
> > > -			buf = device_node_gen_full_name(dn, buf, end);
> > 
> > > +			buf = fwnode_full_name_string(of_fwnode_handle(dn), buf,
> > > +						      end);
> > 
> > Ditto, disregard checkpatch.
> 
> Why? I see no reason to avoid wrapping here; in fact, if I'd review a patch
> that contained such code, I'd ask the submitter to wrap the lines.

For sake of readability. If you look to that file we broke that rule few times
for the same reason.


-- 
With Best Regards,
Andy Shevchenko


