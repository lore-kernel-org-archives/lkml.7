Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63E32C282DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:37:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C26E204EC
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:37:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728387AbfDSShx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:37:53 -0400
Received: from mga18.intel.com ([134.134.136.126]:62980 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726960AbfDSShv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 14:37:51 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Apr 2019 10:16:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,370,1549958400"; 
   d="scan'208";a="163345283"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by fmsmga004.fm.intel.com with ESMTP; 19 Apr 2019 10:16:09 -0700
Date:   Fri, 19 Apr 2019 11:09:59 -0600
From:   Keith Busch <keith.busch@intel.com>
To:     Alison Schofield <alison.schofield@intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Robert Moore <robert.moore@intel.com>,
        "Schmauss, Erik" <erik.schmauss@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] acpi/hmat: Update acpi_hmat_type enum with
 ACPI_HMAT_TYPE_PROXIMITY
Message-ID: <20190419170958.GA9331@localhost.localdomain>
References: <20190417181310.27613-1-alison.schofield@intel.com>
 <20190418145640.GA7659@localhost.localdomain>
 <CAJZ5v0g1EZbzr6BJhVBVb8JZGnVQg2Sz8NHtz_0Ji9R_58wMbA@mail.gmail.com>
 <20190419165435.GA2284@alison-desk.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190419165435.GA2284@alison-desk.jf.intel.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 19, 2019 at 09:54:35AM -0700, Alison Schofield wrote:
> On Thu, Apr 18, 2019 at 05:07:12PM +0200, Rafael J. Wysocki wrote:
> > On Thu, Apr 18, 2019 at 5:02 PM Keith Busch <keith.busch@intel.com> wrote:
> > >
> > > On Wed, Apr 17, 2019 at 11:13:10AM -0700, Alison Schofield wrote:
> > > > ACPI 6.3 changed the subtable "Memory Subsystem Address Range Structure"
> > > > to "Memory Proximity Domain Attributes Structure".
> > > >
> > > > Updating and renaming of the structure was included in commit:
> > > > ACPICA: ACPI 6.3: HMAT updates (9a8d961f1ef835b0d338fbe13da03cb424e87ae5)
> > >
> > > I was not really happy with that HMAT update. Platforms implementing
> > > 6.2's HMAT continue to exist even if 6.3 isn't backward compatible. We
> > > just lost the original subtable definition.
> > 
> > Well, that's true, sadly, but the question is what to do in the kernel.
> > 
> > Definitely, the 6.3 format needs to be supported, but if the 6.2 ships
> > anywhere in practice, that will need to be supported too.
> 
> So, what's the usual practice when ACPI tables are updated?
> Do we define separate 6.2 and 6.3 versions of this subtable and let
> the kernel figure out which one its looking at?

Yeah, I think either new struct definitions for incompatible versions,
or unions for conflicting members would be good.

But I think Rafael is saying we only care if someone's shipping platform
implements a particular version. I don't happen to know which ACPI
version platforms I'm interested are going to release with, so I have
HMAT supporting either right now. The 6.3 update wasn't difficult to
handle this time.
