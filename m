Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD87DC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 16:34:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 862CE20863
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 16:34:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729794AbfCYQe1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 12:34:27 -0400
Received: from mga14.intel.com ([192.55.52.115]:21592 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729106AbfCYQe0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 12:34:26 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Mar 2019 09:34:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,269,1549958400"; 
   d="scan'208";a="137134913"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by orsmga003.jf.intel.com with ESMTP; 25 Mar 2019 09:34:24 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1h8SYJ-0007uY-59; Mon, 25 Mar 2019 18:34:23 +0200
Date:   Mon, 25 Mar 2019 18:34:23 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Thomas Preston <thomas.preston@codethink.co.uk>
Cc:     rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, mika.westerberg@linux.intel.com
Subject: Re: [PATCH v2] Documentation: acpi: Add an example for PRP0001
Message-ID: <20190325163423.GJ9224@smile.fi.intel.com>
References: <20190325151210.23226-1-thomas.preston@codethink.co.uk>
 <20190325153032.GG9224@smile.fi.intel.com>
 <3ae33d42-1175-bdbe-036b-1df5edc6a802@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ae33d42-1175-bdbe-036b-1df5edc6a802@codethink.co.uk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 03:58:13PM +0000, Thomas Preston wrote:
> On 25/03/2019 15:30, Andy Shevchenko wrote:
> > On Mon, Mar 25, 2019 at 03:12:10PM +0000, Thomas Preston wrote:
> > > Add an example for the magic PRP0001 device ID which allows matching
> > > ACPI devices against drivers using OF Device Tree compatible property.
> > 
> > > It wasn't clear to me that PRP0001 could be used in _CID.
> > 
> > Yes, but it's not necessary to have it if we have defined a _HID.
> > 
> > In that case PRP0001 is a temporary stub until corresponding driver
> > incorporates an official _HID.
> > 
> > On the contrary, when there is no official _HID available, PRP0001 can be used
> > instead directly as a _HID and no _CID is needed.
> > 
> 
> In that case, how do we uniquely identify devices in sysfs?

By their class, etc.

Identifying devices based in instance name is bad idea to start with.

> We have a
> case where sound/soc/soc-core.c generates an i2c codec name i2c-TDA7802:00.
> It is useful to identify that device by part name, rather than some indexed
> generic PRP device i2c-PRP0001:04. I can achieve this with:

If TDA7802 is *official* _HID dedicated for that codec by vendor, add it to the
driver...

> 	_HID("TDA7802")

> 	_CID("PRP0001")
> 	...
> 	compatible = "st,tda7802" // driver I want to load using OF DT

...and these lines become unneeded.

The only case when both are needed is a time between one gets a case and actual
ID appears in the upstream driver. Effectively means product developing stage.

P.S. Yes, I know that sometimes the platform/BIOS vendors abuse specification
and ACPI ID registry and made up IDs, in that case we need to support them as a
"de facto" quirks.

And yes, ASoC subsystem in ACPI case abuses Linux device hierarchy by matching
by instance instead of matching by let say fwnode. It should be fixed there,
not in ACPI table.

> 
> > I would really recommend to look at the examples in meta-acpi repository. There
> > are cases like described above.
> > 
> > This one is good enough, though see below.
> > 
> 
> I will drop the superfluous _CID - I think the example is still useful
> to have. Even if we don't illustrate my special case for _HID/_CID.

Yes, I agree with that.

-- 
With Best Regards,
Andy Shevchenko


