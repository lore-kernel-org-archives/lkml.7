Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7684C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 13:39:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1AE42075C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 13:39:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731613AbfCZNjw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 09:39:52 -0400
Received: from mga01.intel.com ([192.55.52.88]:19398 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726241AbfCZNjv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 09:39:51 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Mar 2019 06:39:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,271,1549958400"; 
   d="scan'208";a="128782339"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by orsmga008.jf.intel.com with ESMTP; 26 Mar 2019 06:39:48 -0700
Received: by paasikivi.fi.intel.com (Postfix, from userid 1000)
        id 7BD68205E7; Tue, 26 Mar 2019 15:39:47 +0200 (EET)
Date:   Tue, 26 Mar 2019 15:39:47 +0200
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        rafael@kernel.org, linux-acpi@vger.kernel.org,
        devicetree@vger.kernel.org,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH 5/5] lib/vsprintf: Add %pfw conversion specifier for
 printing fwnode names
Message-ID: <20190326133947.pbniwkvszlahw3dr@paasikivi.fi.intel.com>
References: <20190322152930.16642-1-sakari.ailus@linux.intel.com>
 <20190322152930.16642-6-sakari.ailus@linux.intel.com>
 <20190322172114.GY9224@smile.fi.intel.com>
 <20190324181745.vgckevapfwi7mul7@mara.localdomain>
 <20190326131353.GY9224@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190326131353.GY9224@smile.fi.intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On Tue, Mar 26, 2019 at 03:13:53PM +0200, Andy Shevchenko wrote:
> On Sun, Mar 24, 2019 at 08:17:46PM +0200, Sakari Ailus wrote:
> > On Fri, Mar 22, 2019 at 07:21:14PM +0200, Andy Shevchenko wrote:
> > > On Fri, Mar 22, 2019 at 05:29:30PM +0200, Sakari Ailus wrote:
> > > > Add support for %pfw conversion specifier (with "f" and "P" modifiers) to
> > > > support printing full path of the node, including its name ("f") and only
> > > > the node's name ("P") in the printk family of functions. The two flags
> > > > have equivalent functionality to existing %pOF with the same two modifiers
> > > > ("f" and "P") on OF based systems. The ability to do the same on ACPI
> > > > based systems is added by this patch.
> > > 
> > > Do we encourage people to use it instead of %pOF cases where it is suitable?
> > 
> > For code that is used on both OF and ACPI based systems, I think so. But if
> > you have something that is only used on OF, %pOF is better --- it has more
> > functionality that seems quite OF specific. In general I think the ability
> > to print a node's full name is way more important on OF. On ACPI you don't
> > need it so often --- which is probably the reason it hasn't been supported.
> 
> But if code is going to support ACPI and DT and at the same time use %pOF
> extensions that are not covered by %pfw it would be inconsistent somehow.

What you mostly need are the full name and the name of a given node. I
wasn't sure whether adding more would have been relevant, and at least it
is likely to have few if any users, so I didn't add that yet. Do not that
it can be implemented later on if it's needed --- that's also why the
modifiers are aligned with %pOF.

> 
> > > > On ACPI based systems the resulting strings look like
> > > > 
> > > > 	\_SB.PCI0.CIO2.port@1.endpoint@0
> > > > 
> > > > where the nodes are separated by a dot (".") and the first three are
> > > > ACPI device nodes and the latter two ACPI data nodes.
> > > 
> > > Do we support swnode here?
> > 
> > Good question. The swnodes have no hierarchy at the moment (they're only
> > created for a struct device as a parent) and they do not have human-readable
> > names. So I'd say it's not relevant right now. Should these two change,
> > support for swnode could (and should) be added later on.
> 
> Heikki, what do you think about this?
> 
> > > > +	if ((unsigned long)fwnode < PAGE_SIZE)
> > > > +		return string(buf, end, "(null)", spec);
> > > 
> > > Just put there a NULL pointer, we would not like to maintain duplicated strings
> > > over the kernel.
> > > 
> > > I remember Petr has a patch series related to address space check, though I
> > > don't remember the status of affairs.
> > 
> > This bit has been actually adopted from the OF counterpart. If there are
> > improvements in this area, then I'd just change both at the same time.
> 
> The patch series by Petr I mentioned takes care about OF case. But it doesn't
> have covered yours by obvious reasons.

Do you happen to have a pointer to it?

> 
> > > > +	for (pass = false; strspn(fmt, modifiers); fmt++, pass = true) {
> > > 
> > > I don't see test cases.
> > > 
> > > What would we get out of %pfwfffPPPfff?
> > > 
> > > Hint: I'm expecting above to be equivalent to %pfwf
> > 
> > I guess it's a matter of expectations. :-)
> 
> Common sense and basic expectations from all of %p extensions.
> 
> > Again this works the same way
> > than the OF counterpart.
> 
> OF lacks of testing apparently.
> 
> > Right now there's little to print (just the name
> > and the full name), but if support is added for more, then this mechanism is
> > fully relevant again.
> > 
> > The alternative would be to remove that now and add it back if it's needed
> > again. I have a slight preference towards keeping it extensible (i.e. as
> > it's now).
> 
> See how other helpers do parse this.

The behaviour on others is different indeed, you're generally printing a
single item at a time. The question rather is, whether we want to be
compatible with %pOF going forward or not. I'd prefer that, so using the
fwnode API would be easier.

-- 
Regards,

Sakari Ailus
sakari.ailus@linux.intel.com
