Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D7CEC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 13:49:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F20A2075E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 13:49:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729701AbfC0NtT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 09:49:19 -0400
Received: from mga09.intel.com ([134.134.136.24]:42672 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725797AbfC0NtQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 09:49:16 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Mar 2019 06:49:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,277,1549958400"; 
   d="scan'208";a="145677940"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by orsmga002.jf.intel.com with ESMTP; 27 Mar 2019 06:49:14 -0700
Received: by paasikivi.fi.intel.com (Postfix, from userid 1000)
        id 10D55207E2; Wed, 27 Mar 2019 15:49:13 +0200 (EET)
Date:   Wed, 27 Mar 2019 15:49:12 +0200
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     linux-kernel@vger.kernel.org, rafael@kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-acpi@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 4/5] lib/vsprintf: Make use of fwnode API to obtain node
 names and separators
Message-ID: <20190327134912.knvr4anvbef6iqld@paasikivi.fi.intel.com>
References: <20190322152930.16642-1-sakari.ailus@linux.intel.com>
 <20190322152930.16642-5-sakari.ailus@linux.intel.com>
 <20190327125356.s7hockgf5yfyhx52@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190327125356.s7hockgf5yfyhx52@pathway.suse.cz>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Petr,

Thank you for reviewing these patches.

On Wed, Mar 27, 2019 at 01:53:56PM +0100, Petr Mladek wrote:
> On Fri 2019-03-22 17:29:29, Sakari Ailus wrote:
> > Instead of implementing our own means of discovering parent nodes, node
> > names or counting how many parents a node has, use the newly added
> > functions in the fwnode API to obtain that information.
> > 
> > Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> > ---
> >  lib/vsprintf.c | 37 +++++++++++++++----------------------
> >  1 file changed, 15 insertions(+), 22 deletions(-)
> > 
> > diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> > index 5f60b8d41277..91f2a3e4892e 100644
> > --- a/lib/vsprintf.c
> > +++ b/lib/vsprintf.c
> > @@ -37,6 +37,7 @@
> >  #include <net/addrconf.h>
> >  #include <linux/siphash.h>
> >  #include <linux/compiler.h>
> > +#include <linux/property.h>
> >  #ifdef CONFIG_BLOCK
> >  #include <linux/blkdev.h>
> >  #endif
> > @@ -1720,32 +1721,23 @@ char *flags_string(char *buf, char *end, void *flags_ptr, const char *fmt)
> >  	return format_flags(buf, end, flags, names);
> >  }
> >  
> > -static const char *device_node_name_for_depth(const struct device_node *np, int depth)
> > -{
> > -	for ( ; np && depth; depth--)
> > -		np = np->parent;
> > -
> > -	return kbasename(np->full_name);
> > -}
> > -
> >  static noinline_for_stack
> > -char *device_node_gen_full_name(const struct device_node *np, char *buf, char *end)
> > +char *fwnode_gen_full_name(struct fwnode_handle *fwnode, char *buf, char *end)
> 
> I first read this as fwnode_get_full_name(), see "get" vs. "gen".
> I guess that it was because there is used also fwnode_get_name().
> 
> Please, rename it to fwnode_full_name_string() or so ;-)

Works for me.

-- 
Regards,

Sakari Ailus
sakari.ailus@linux.intel.com
