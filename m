Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BE58C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 14:10:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2553D2087C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 14:10:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728837AbfC0OKw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 10:10:52 -0400
Received: from mga03.intel.com ([134.134.136.65]:61878 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726346AbfC0OKv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 10:10:51 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Mar 2019 07:10:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,277,1549958400"; 
   d="scan'208";a="218033148"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by orsmga001.jf.intel.com with ESMTP; 27 Mar 2019 07:10:49 -0700
Received: by paasikivi.fi.intel.com (Postfix, from userid 1000)
        id 17D16207E2; Wed, 27 Mar 2019 16:10:48 +0200 (EET)
Date:   Wed, 27 Mar 2019 16:10:48 +0200
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     linux-kernel@vger.kernel.org, rafael@kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-acpi@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 5/5] lib/vsprintf: Add %pfw conversion specifier for
 printing fwnode names
Message-ID: <20190327141047.bhndwqde7vjz6bad@paasikivi.fi.intel.com>
References: <20190322152930.16642-1-sakari.ailus@linux.intel.com>
 <20190322152930.16642-6-sakari.ailus@linux.intel.com>
 <20190326151307.erqyps6wfvf4on2d@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190326151307.erqyps6wfvf4on2d@pathway.suse.cz>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Petr,

On Tue, Mar 26, 2019 at 04:13:07PM +0100, Petr Mladek wrote:
> On Fri 2019-03-22 17:29:30, Sakari Ailus wrote:
> > Add support for %pfw conversion specifier (with "f" and "P" modifiers) to
> > support printing full path of the node, including its name ("f") and only
> > the node's name ("P") in the printk family of functions. The two flags
> > have equivalent functionality to existing %pOF with the same two modifiers
> > ("f" and "P") on OF based systems. The ability to do the same on ACPI
> > based systems is added by this patch.
> > 
> > On ACPI based systems the resulting strings look like
> > 
> > 	\_SB.PCI0.CIO2.port@1.endpoint@0
> > 
> > where the nodes are separated by a dot (".") and the first three are
> > ACPI device nodes and the latter two ACPI data nodes.
> > 
> > Depends-on: ("vsprintf: Remove support for %pF and %pf in favour of %pS and %ps")
> 
> Reusing obsolete modifiers is dangerous from many reasons:
> 
>    + people might miss the change of the meaning
>    + backporting mistakes
>    + 3rd party modules
> 
> It might be acceptable if the long term gain is bigger
> than a short time difficulties. But it would be better
> to it a safe way when possible.
> 
> Fortunately, we could keep the backward compatibility
> for "%pf" and handle only "%pfw*" with the fwnode api.

The v2 of this patch produces a warning (using WARN_ONCE()) for "%pf" not
immediately followed by "w". "%pfw" was not a valid conversion specifier
before this set, so we're actually not re-using the exactly same conversion
specifiers.

-- 
Regards,

Sakari Ailus
sakari.ailus@linux.intel.com
