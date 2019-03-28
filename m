Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2417AC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 14:29:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC9D1206C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 14:29:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726367AbfC1O33 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 10:29:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:46578 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725994AbfC1O33 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 10:29:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A6318AB71;
        Thu, 28 Mar 2019 14:29:27 +0000 (UTC)
Date:   Thu, 28 Mar 2019 15:29:27 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-kernel@vger.kernel.org, rafael@kernel.org,
        linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 6/6] lib/vsprintf: Add %pfw conversion specifier for
 printing fwnode names
Message-ID: <20190328142927.uxd54bqdvrfbfbn7@pathway.suse.cz>
References: <20190326124106.27694-1-sakari.ailus@linux.intel.com>
 <20190326124106.27694-7-sakari.ailus@linux.intel.com>
 <8c6accab-9e0c-c2d4-ce93-ea3ede60f34e@rasmusvillemoes.dk>
 <20190326132450.GB9224@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190326132450.GB9224@smile.fi.intel.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2019-03-26 15:24:50, Andy Shevchenko wrote:
> On Tue, Mar 26, 2019 at 02:11:35PM +0100, Rasmus Villemoes wrote:
> > On 26/03/2019 13.41, Sakari Ailus wrote:
> > > Add support for %pfw conversion specifier (with "f" and "P" modifiers) to
> > > support printing full path of the node, including its name ("f") and only
> > > the node's name ("P") in the printk family of functions. The two flags
> > > have equivalent functionality to existing %pOF with the same two modifiers
> > > ("f" and "P") on OF based systems. The ability to do the same on ACPI
> > > based systems is added by this patch.
> 
> > > +	for (pass = false; strspn(fmt, modifiers); fmt++, pass = true) {
> > > +		if (pass) {
> > > +			if (buf < end)
> > > +				*buf = ':';
> > > +			buf++;
> > > +		}
> > > +
> > > +		switch (*fmt) {
> > > +		case 'f':	/* full_name */
> > > +			buf = fwnode_gen_full_name(fwnode, buf, end);
> > > +			break;
> > > +		case 'P':	/* name */
> > > +			buf = string(buf, end, fwnode_get_name(fwnode),
> > > +				     str_spec);
> > > +			break;
> > > +		default:
> > > +			break;
> > > +		}
> > > +	}
> > 
> > This seems awfully complicated. Why would anyone ever pass more than one
> > of 'f' and 'P'? Why not just
> > 
> > switch(*fmt) {
> > case 'P':
> >    ...
> > case 'f':
> > default:
> >    ...
> > }
> > 
> > which avoids the loop and the strcspn. Or, drop the default: case and
> > don't have logic at all for falling back to 'f' if neither is present.
> > 
> > > +	return widen_string(buf, buf - buf_start, end, spec);
> > > +}
> 
> My point as well (as per sent comments against previous version).
> Sakari, can you add test cases at the same time?
> 
> > >  			return device_node_string(buf, end, ptr, spec, fmt + 1);
> 
> > > +			return fwnode_string(buf, end, ptr, spec, fmt + 1);
> > 
> > Why not pass fmt+2; we know that fmt+1 points at a 'w'. Just to avoid
> > doing the fmt++ inside fwnode_string().
> 
> I guess in order to be consistent with existing %pOF case. But wouldn't be
> better to fix %pOF for that sooner or later?

Good question. Are there any %pOF users that would want to use the for
cycle and printk more values by single %pOF? Would the output be human
readable without any delimiters or words around?

Best Regards,
Petr
