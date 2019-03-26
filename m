Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D80AC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 15:50:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DADF20866
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 15:50:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731654AbfCZPuX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 11:50:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:34226 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726111AbfCZPuW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 11:50:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9F7A8ACE1;
        Tue, 26 Mar 2019 15:50:20 +0000 (UTC)
Date:   Tue, 26 Mar 2019 16:50:20 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-kernel@vger.kernel.org, rafael@kernel.org,
        linux-acpi@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 5/5] lib/vsprintf: Add %pfw conversion specifier for
 printing fwnode names
Message-ID: <20190326155020.awlvbnm5qqn4wu6t@pathway.suse.cz>
References: <20190322152930.16642-1-sakari.ailus@linux.intel.com>
 <20190322152930.16642-6-sakari.ailus@linux.intel.com>
 <20190322172114.GY9224@smile.fi.intel.com>
 <20190324181745.vgckevapfwi7mul7@mara.localdomain>
 <20190326131353.GY9224@smile.fi.intel.com>
 <20190326140633.GE7049@kuha.fi.intel.com>
 <20190326141243.g2x44v65npw4yhw5@paasikivi.fi.intel.com>
 <20190326143021.GE9224@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190326143021.GE9224@smile.fi.intel.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2019-03-26 16:30:21, Andy Shevchenko wrote:
> On Tue, Mar 26, 2019 at 04:12:43PM +0200, Sakari Ailus wrote:
> > On Tue, Mar 26, 2019 at 04:06:33PM +0200, Heikki Krogerus wrote:
> > > On Tue, Mar 26, 2019 at 03:13:53PM +0200, Andy Shevchenko wrote:
> 
> > > > > > Do we support swnode here?
> > > > > 
> > > > > Good question. The swnodes have no hierarchy at the moment (they're only
> > > > > created for a struct device as a parent) and they do not have human-readable
> > > > > names. So I'd say it's not relevant right now. Should these two change,
> > > > > support for swnode could (and should) be added later on.
> > > > 
> > > > Heikki, what do you think about this?
> > > 
> > > Well, the swnodes do have hierarchy. That was kind of the whole point
> > > of introducing them. They now can also be named using "name" property.
> > > See commit 344798206f171c5abea7ab1f9762fa526d7f539d.
> > 
> > Right; I saw the function after initially replying to Andy but I missed
> > where the node name came from. :-) Now I know...
> > 
> > I can add support for swnode, too, if you like.
> 
> Definitely!

It might really make sense to obsolete %pOF and handle all three
(OF, ACPI, Software) nodes using the same %pfw modifiers.

If I get it correctly, we could distinguish them by
fwnode->ops, see is_of_node(), is_acpi_static_node(),
is_software_node().

Best Regards,
Petr
