Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC266C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 08:13:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79B1F2073F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 08:13:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730200AbfDQINN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 04:13:13 -0400
Received: from mga02.intel.com ([134.134.136.20]:12059 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727013AbfDQINN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 04:13:13 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Apr 2019 01:13:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,361,1549958400"; 
   d="scan'208";a="165456069"
Received: from kuha.fi.intel.com ([10.237.72.189])
  by fmsmga001.fm.intel.com with SMTP; 17 Apr 2019 01:13:09 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 17 Apr 2019 11:13:08 +0300
Date:   Wed, 17 Apr 2019 11:13:08 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Subject: Re: [PATCH v3 00/13] Software fwnode references
Message-ID: <20190417081308.GM1747@kuha.fi.intel.com>
References: <20190412134122.82903-1-heikki.krogerus@linux.intel.com>
 <CAJZ5v0gg9cwbNXS=88CdC6dioYaxPCVKx-PSU86PFjvU77MdRg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gg9cwbNXS=88CdC6dioYaxPCVKx-PSU86PFjvU77MdRg@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2019 at 09:54:19AM +0200, Rafael J. Wysocki wrote:
> On Fri, Apr 12, 2019 at 3:42 PM Heikki Krogerus
> <heikki.krogerus@linux.intel.com> wrote:
> >
> > Hi,
> >
> > This is the third version of my proposal to add reference handling to
> > the software node code. In this version I renamed ACPI_NAME_SIZE to
> > ACPI_NAMESEG_SIZE in 6/13, and slit patch 9/13 in two separate patches
> > (9/13 and 10/13) as suggested by Andy. Patch 9/13 will now only move
> > the registration of max17047 out of probe, and 10/13 will introduce
> > the software nodes.
> >
> > v2 commit message:
> >
> > This is the second version of this series. In this version I'm
> > introducing a new helper device_find_child_by_name() as proposed
> > by Andy. Andy requested also another helper that could be used for
> > chaining the fwnodes, but I decided not to add that now. I would like
> > to still think about how we should handle exceptions like if there
> > already is a secondary node assigned for a node.
> >
> > v1 commit message:
> >
> > This series adds support for software fwnode reference handling. In
> > practice it means making fwnode_property_get_reference_args() function
> > usable in the drivers also with software nodes. I send the series
> > originally as RFC [1].
> >
> > As the first user for the software node references, I'm converting
> > intel_cht_int33fe.c to use them as part of the series.
> >
> > [1] https://lkml.org/lkml/2019/3/15/457
> 
> I added this series to the bleeding-edge branch last night and it
> triggered some warnings from various checkers and there was a breakage
> report from Hans.  All of that needs to be fixed IMO, so I'm expecting
> an update.

I'm on it.

thanks,

-- 
heikki
