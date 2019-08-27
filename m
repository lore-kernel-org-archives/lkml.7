Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06EECC3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 14:11:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D43B52173E
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 14:11:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729225AbfH0OLZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 10:11:25 -0400
Received: from mga06.intel.com ([134.134.136.31]:21136 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725920AbfH0OLZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 10:11:25 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Aug 2019 07:11:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,437,1559545200"; 
   d="scan'208";a="181712688"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga007.fm.intel.com with ESMTP; 27 Aug 2019 07:11:23 -0700
Received: from andy by smile with local (Exim 4.92.1)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1i2cBu-0004nV-Ud; Tue, 27 Aug 2019 17:11:22 +0300
Date:   Tue, 27 Aug 2019 17:11:22 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] uuid: Add helpers for finding UUID from an array
Message-ID: <20190827141122.GF2680@smile.fi.intel.com>
References: <20190827114918.25090-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190827114918.25090-1-heikki.krogerus@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 27, 2019 at 02:49:18PM +0300, Heikki Krogerus wrote:
> Matching function that compares every UUID in an array to a
> given UUID with guid_equal().

> I don't have a user for these helpers, but since they are pretty
> trivial, I figured that might as well propose them in any case.
> Though, I think there was somebody proposing of doing the same thing
> that these helpers do at one point, but just the hard way in the
> drivers, right Andy?


Candidates to use a helper
~~~~~~~~~~~~~~~~~~~~~~~~~~

acpi_is_property_guid(): seems like a candidate
nfit_spa_type(): seems like a candidate

xfs_uuid_unmount(): it looks for dups and holes

lmLogFileSystem(): it looks for holes


Below just users where UUID is a member of structure
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

visorbus_match() has two deviations: it uses embedded member and according to
code it allows having duplicate UUIDs, though it seems a side effect of not
strictly written code.

publish_vbus_dev_info()
tee_client_device_match()
hv_vmbus_dev_match()
hv_get_dev_type()
mei_cl_device_find()
ishtp_fw_cl_by_uuid()
is_unsupported_vmbus_devs()

...and few more.

-- 
With Best Regards,
Andy Shevchenko


