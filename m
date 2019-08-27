Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA2ADC3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 12:26:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94A49206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 12:26:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729444AbfH0M0V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 08:26:21 -0400
Received: from mga17.intel.com ([192.55.52.151]:47411 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726140AbfH0M0V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 08:26:21 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Aug 2019 05:26:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,437,1559545200"; 
   d="scan'208";a="197302179"
Received: from kuha.fi.intel.com ([10.237.72.53])
  by fmsmga001.fm.intel.com with SMTP; 27 Aug 2019 05:26:19 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 27 Aug 2019 15:26:18 +0300
Date:   Tue, 27 Aug 2019 15:26:18 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] uuid: Add helpers for finding UUID from an array
Message-ID: <20190827122618.GA8803@kuha.fi.intel.com>
References: <20190827114918.25090-1-heikki.krogerus@linux.intel.com>
 <20190827115418.GA5921@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190827115418.GA5921@lst.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 27, 2019 at 01:54:18PM +0200, Christoph Hellwig wrote:
> On Tue, Aug 27, 2019 at 02:49:18PM +0300, Heikki Krogerus wrote:
> > Matching function that compares every UUID in an array to a
> > given UUID with guid_equal().
> > 
> > Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > ---
> > Hi,
> > 
> > I don't have a user for these helpers, but since they are pretty
> > trivial, I figured that might as well propose them in any case.
> > Though, I think there was somebody proposing of doing the same thing
> > that these helpers do at one point, but just the hard way in the
> > drivers, right Andy?
> 
> XFS has something similar in xfs_uuid_mount, except that it also
> tracks empty slots.  That beeing said I'm pretty sure if you ask willy
> he's suggest to just convert the table to an xarray instead :)
> 
> So I'm defintively curious what the users would be where we just check
> a table, but don't also add something to the table.

I prepared this patch (already some time ago) as part of a series that
was meant to move the ACPI _DSD uuids "prp_guids" in
drivers/acpi/property.c to the drivers instead (so in practice, get
rid of prp_guids). I never send that series out because it would have
only worked with ACPI enumerated devices, so not with for example PCI
enumerated devices which also may have _DSD device properties.

I'm sending this patch out just because after this I'm dropping it
from my development branch. If somebody else finds it useful, great,
let's push it forward, but if there is nobody interested, or if there
is possibly even better way of handling arrays like prp_guids (please
note that I'm not going to work on that ;-), then let's just forget
about the it.

thanks,

-- 
heikki
