Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB3A3C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 15:30:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A55AF2083D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 15:30:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729382AbfCYPaf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 11:30:35 -0400
Received: from mga14.intel.com ([192.55.52.115]:17053 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729127AbfCYPaf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 11:30:35 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Mar 2019 08:30:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,269,1549958400"; 
   d="scan'208";a="143669664"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by FMSMGA003.fm.intel.com with ESMTP; 25 Mar 2019 08:30:33 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1h8RYW-0007J0-5E; Mon, 25 Mar 2019 17:30:32 +0200
Date:   Mon, 25 Mar 2019 17:30:32 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Thomas Preston <thomas.preston@codethink.co.uk>
Cc:     rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, mika.westerberg@linux.intel.com
Subject: Re: [PATCH v2] Documentation: acpi: Add an example for PRP0001
Message-ID: <20190325153032.GG9224@smile.fi.intel.com>
References: <20190325151210.23226-1-thomas.preston@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190325151210.23226-1-thomas.preston@codethink.co.uk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 03:12:10PM +0000, Thomas Preston wrote:
> Add an example for the magic PRP0001 device ID which allows matching
> ACPI devices against drivers using OF Device Tree compatible property.

> It wasn't clear to me that PRP0001 could be used in _CID.

Yes, but it's not necessary to have it if we have defined a _HID.

In that case PRP0001 is a temporary stub until corresponding driver
incorporates an official _HID.

On the contrary, when there is no official _HID available, PRP0001 can be used
instead directly as a _HID and no _CID is needed.

I would really recommend to look at the examples in meta-acpi repository. There
are cases like described above.

This one is good enough, though see below.

> Signed-off-by: Thomas Preston <thomas.preston@codethink.co.uk>
> ---
>  Documentation/acpi/enumeration.txt | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
> 
> diff --git a/Documentation/acpi/enumeration.txt b/Documentation/acpi/enumeration.txt
> index 7bcf9c3d9fbe..8375fc506b47 100644
> --- a/Documentation/acpi/enumeration.txt
> +++ b/Documentation/acpi/enumeration.txt
> @@ -410,6 +410,37 @@ Specifically, the device IDs returned by _HID and preceding PRP0001 in the _CID
>  return package will be checked first.  Also in that case the bus type the device
>  will be enumerated to depends on the device ID returned by _HID.
>  
> +For example, the following ACPI sample might be used to enumerate an lm75-type
> +I2C temperature sensor and match it to the driver using the Device Tree
> +namespace link:
> +
> +	Device (TMP0)
> +	{
> +		/* _HID will appear in sysfs */
> +		Name (_HID, "PRP0001")
> +

> +		/* _CID can also be used to search for "compatible" property */
> +		Name (_CID, "PRP0001")

So, these lines are superfluous as stated exaxtly in a following paragraph.

> +
> +		Name (_DSD, Package() {
> +			ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
> +			Package () {
> +				Package (2) { "compatible", "ti,tmp75" },
> +			}
> +		})
> +		Method (_CRS, 0, Serialized)
> +		{
> +			Name (SBUF, ResourceTemplate ()
> +			{
> +				I2cSerialBusV2 (0x48, ControllerInitiated,
> +					400000, AddressingMode7Bit,
> +					"\\_SB.PCI0.I2C1", 0x00,
> +					ResourceConsumer, , Exclusive,)
> +			})
> +			Return (SBUF)
> +		}
> +	}
> +
>  It is valid to define device objects with a _HID returning PRP0001 and without
>  the "compatible" property in the _DSD or a _CID as long as one of their
>  ancestors provides a _DSD with a valid "compatible" property.  Such device

-- 
With Best Regards,
Andy Shevchenko


