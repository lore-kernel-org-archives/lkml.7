Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 592F1C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 11:51:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31D2C20850
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 11:51:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731018AbfCYLvW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 07:51:22 -0400
Received: from mga01.intel.com ([192.55.52.88]:64326 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730831AbfCYLvV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 07:51:21 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Mar 2019 04:51:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,256,1549958400"; 
   d="scan'208";a="330460711"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by fmsmga006.fm.intel.com with ESMTP; 25 Mar 2019 04:51:19 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1h8O8M-0005AY-A3; Mon, 25 Mar 2019 13:51:18 +0200
Date:   Mon, 25 Mar 2019 13:51:18 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Thomas Preston <thomas.preston@codethink.co.uk>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Documentation: acpi: Add an example for PRP0001
Message-ID: <20190325115118.GP9224@smile.fi.intel.com>
References: <20190322134705.27994-1-thomas.preston@codethink.co.uk>
 <CAJZ5v0isa7x+XPAregcKtMxtgsNw43JuBhGB_1x3eHkvaV8HRg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0isa7x+XPAregcKtMxtgsNw43JuBhGB_1x3eHkvaV8HRg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 10:31:13AM +0100, Rafael J. Wysocki wrote:
> On Fri, Mar 22, 2019 at 2:47 PM Thomas Preston
> <thomas.preston@codethink.co.uk> wrote:
> >
> > Add an example for the magic PRP0001 device ID which allows matching
> > ACPI devices against drivers using OF Device Tree compatible property.
> > It wasn't clear to me that PRP0001 could be used in _CID.
> 
> Mika, Andy, can you have a look at this, please?

Good to me,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Though one thing I would like to add (not directly related to the patch
per se), i.e. it would be nice to keep such examples under meta-acpi [1]
umbrella as a database for such excerpts.

Thomas, can you do that?

[1]: https://github.com/westeri/meta-acpi

> > Signed-off-by: Thomas Preston <thomas.preston@codethink.co.uk>
> > ---
> >  Documentation/acpi/enumeration.txt | 27 +++++++++++++++++++++++++++
> >  1 file changed, 27 insertions(+)
> >
> > diff --git a/Documentation/acpi/enumeration.txt b/Documentation/acpi/enumeration.txt
> > index 7bcf9c3d9fbe..391db643065a 100644
> > --- a/Documentation/acpi/enumeration.txt
> > +++ b/Documentation/acpi/enumeration.txt
> > @@ -410,6 +410,33 @@ Specifically, the device IDs returned by _HID and preceding PRP0001 in the _CID
> >  return package will be checked first.  Also in that case the bus type the device
> >  will be enumerated to depends on the device ID returned by _HID.
> >
> > +For example, the following ACPI sample might be used to enumerate an lm75-type
> > +I2C temperature sensor and match it to the driver using the Device Tree
> > +namespace link:
> > +
> > +       Device (TMP0)
> > +       {
> > +               Name (_HID, "TITMP75") /* _HID will appear in sysfs */
> > +               Name (_CID, "PRP0001")
> > +               Name (_DSD, Package() {
> > +                       ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
> > +                       Package () {
> > +                               Package (2) { "compatible", "ti,tmp75" },
> > +                       }
> > +               })
> > +               Method (_CRS, 0, Serialized)
> > +               {
> > +                       Name (SBUF, ResourceTemplate ()
> > +                       {
> > +                               I2cSerialBusV2 (0x48, ControllerInitiated,
> > +                                       400000, AddressingMode7Bit,
> > +                                       "\\_SB.PCI0.I2C1", 0x00,
> > +                                       ResourceConsumer, , Exclusive,)
> > +                       })
> > +                       Return (SBUF)
> > +               }
> > +       }
> > +
> >  It is valid to define device objects with a _HID returning PRP0001 and without
> >  the "compatible" property in the _DSD or a _CID as long as one of their
> >  ancestors provides a _DSD with a valid "compatible" property.  Such device
> > --
> > 2.11.0
> >

-- 
With Best Regards,
Andy Shevchenko


