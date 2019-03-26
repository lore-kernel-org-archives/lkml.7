Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21F8AC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 13:24:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB25F2075D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 13:24:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731583AbfCZNYz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 09:24:55 -0400
Received: from mga17.intel.com ([192.55.52.151]:26474 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726177AbfCZNYy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 09:24:54 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Mar 2019 06:24:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,271,1549958400"; 
   d="scan'208";a="330799271"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by fmsmga006.fm.intel.com with ESMTP; 26 Mar 2019 06:24:51 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1h8m4Q-0003KK-74; Tue, 26 Mar 2019 15:24:50 +0200
Date:   Tue, 26 Mar 2019 15:24:50 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        rafael@kernel.org, linux-acpi@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 6/6] lib/vsprintf: Add %pfw conversion specifier for
 printing fwnode names
Message-ID: <20190326132450.GB9224@smile.fi.intel.com>
References: <20190326124106.27694-1-sakari.ailus@linux.intel.com>
 <20190326124106.27694-7-sakari.ailus@linux.intel.com>
 <8c6accab-9e0c-c2d4-ce93-ea3ede60f34e@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c6accab-9e0c-c2d4-ce93-ea3ede60f34e@rasmusvillemoes.dk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2019 at 02:11:35PM +0100, Rasmus Villemoes wrote:
> On 26/03/2019 13.41, Sakari Ailus wrote:
> > Add support for %pfw conversion specifier (with "f" and "P" modifiers) to
> > support printing full path of the node, including its name ("f") and only
> > the node's name ("P") in the printk family of functions. The two flags
> > have equivalent functionality to existing %pOF with the same two modifiers
> > ("f" and "P") on OF based systems. The ability to do the same on ACPI
> > based systems is added by this patch.

> > +	for (pass = false; strspn(fmt, modifiers); fmt++, pass = true) {
> > +		if (pass) {
> > +			if (buf < end)
> > +				*buf = ':';
> > +			buf++;
> > +		}
> > +
> > +		switch (*fmt) {
> > +		case 'f':	/* full_name */
> > +			buf = fwnode_gen_full_name(fwnode, buf, end);
> > +			break;
> > +		case 'P':	/* name */
> > +			buf = string(buf, end, fwnode_get_name(fwnode),
> > +				     str_spec);
> > +			break;
> > +		default:
> > +			break;
> > +		}
> > +	}
> 
> This seems awfully complicated. Why would anyone ever pass more than one
> of 'f' and 'P'? Why not just
> 
> switch(*fmt) {
> case 'P':
>    ...
> case 'f':
> default:
>    ...
> }
> 
> which avoids the loop and the strcspn. Or, drop the default: case and
> don't have logic at all for falling back to 'f' if neither is present.
> 
> > +	return widen_string(buf, buf - buf_start, end, spec);
> > +}

My point as well (as per sent comments against previous version).
Sakari, can you add test cases at the same time?

> >  			return device_node_string(buf, end, ptr, spec, fmt + 1);

> > +			return fwnode_string(buf, end, ptr, spec, fmt + 1);
> 
> Why not pass fmt+2; we know that fmt+1 points at a 'w'. Just to avoid
> doing the fmt++ inside fwnode_string().

I guess in order to be consistent with existing %pOF case. But wouldn't be
better to fix %pOF for that sooner or later?

-- 
With Best Regards,
Andy Shevchenko


