Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDB90C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 17:11:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BAB220879
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 17:11:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730214AbfCYRLx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 13:11:53 -0400
Received: from mga07.intel.com ([134.134.136.100]:2008 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729680AbfCYRLw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 13:11:52 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Mar 2019 10:11:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,269,1549958400"; 
   d="scan'208";a="128531641"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by orsmga008.jf.intel.com with ESMTP; 25 Mar 2019 10:11:50 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1h8T8X-0008Pv-BS; Mon, 25 Mar 2019 19:11:49 +0200
Date:   Mon, 25 Mar 2019 19:11:49 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Thomas Preston <thomas.preston@codethink.co.uk>
Cc:     rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, mika.westerberg@linux.intel.com
Subject: Re: [PATCH v3] Documentation: acpi: Add an example for PRP0001
Message-ID: <20190325171149.GM9224@smile.fi.intel.com>
References: <20190325165338.5826-1-thomas.preston@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190325165338.5826-1-thomas.preston@codethink.co.uk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 04:53:38PM +0000, Thomas Preston wrote:
> Add an example for the magic PRP0001 device ID which allows matching
> ACPI devices against drivers using OF Device Tree compatible property.

Thank you!
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> 
> Signed-off-by: Thomas Preston <thomas.preston@codethink.co.uk>
> ---
>  Documentation/acpi/enumeration.txt | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/Documentation/acpi/enumeration.txt b/Documentation/acpi/enumeration.txt
> index 7bcf9c3d9fbe..1395b844649c 100644
> --- a/Documentation/acpi/enumeration.txt
> +++ b/Documentation/acpi/enumeration.txt
> @@ -410,6 +410,32 @@ Specifically, the device IDs returned by _HID and preceding PRP0001 in the _CID
>  return package will be checked first.  Also in that case the bus type the device
>  will be enumerated to depends on the device ID returned by _HID.
>  
> +For example, the following ACPI sample might be used to enumerate an lm75-type
> +I2C temperature sensor and match it to the driver using the Device Tree
> +namespace link:
> +
> +	Device (TMP0)
> +	{
> +		Name (_HID, "PRP0001")
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
> -- 
> 2.11.0
> 

-- 
With Best Regards,
Andy Shevchenko


