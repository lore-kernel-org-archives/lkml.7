Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB8B4C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 12:52:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F514206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 12:52:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727385AbfCKMwL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 08:52:11 -0400
Received: from mga14.intel.com ([192.55.52.115]:22053 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726691AbfCKMwL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 08:52:11 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Mar 2019 05:52:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,467,1544515200"; 
   d="scan'208";a="140980163"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by orsmga002.jf.intel.com with ESMTP; 11 Mar 2019 05:52:08 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1h3KPX-0005L6-4C; Mon, 11 Mar 2019 14:52:07 +0200
Date:   Mon, 11 Mar 2019 14:52:07 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>, linux-i2c@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] i2c: i2c-designware-platdrv: Allow a dynamic adap.
 nr without an ACPI fwnode
Message-ID: <20190311125207.GR9224@smile.fi.intel.com>
References: <20190311112216.31391-1-hdegoede@redhat.com>
 <20190311112216.31391-2-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190311112216.31391-2-hdegoede@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2019 at 12:22:15PM +0100, Hans de Goede wrote:
> Before this commit the i2c-designware-platdrv assumes that if the pdev
> has an apci-companion it should use a dynamic adapter-nr and otherwise
> it will use pdev->id as adapter-nr.
> 
> On some devices e.g. the Apollo Lake using Acer TravelMate Spin B118,
> some of the LPSS i2c-adapters are enumerated through PCI and do not have
> an ACPI fwnode. These devices are handled as mfd devices so they end up
> using the i2c-designware-platdrv driver.
> 
> This results in the i2c-adapter being registered with the mfd generated
> pdev->id as adapter-nr, which conflicts with existing adapters, triggering
> a WARN(id < 0, "couldn't get idr") in i2c-core-base.c and causing the
> adapter registration to fail.
> 
> This commit adds support for setting a "linux,use-dynamic-adapter-nr"
> device property on the device to make i2c-designware-platdrv use dynamic
> adapter-nrs on devices without an ACPI fwnode, together with changes to
> drivers/mfd/intel-lpss-pci.c to set this, this fixes the WARN.
> 

> Before this commit the setting of the adapter.nr was somewhat convoluted,
> in the acpi_companion case it was set from dw_i2c_acpi_configure, in the
> non acpi_companion case it was set from dw_i2c_set_fifo_size() based on
> tx_fifo_depth not being set yet. This commit also cleans this up.

Can we split this to two patches, i.e. one is almost the same as this one,
except the second one adds a new property check to the conditional?

If you agree to do so, you may add mine Rb tag to the first one out of three.

> Note the "linux,use-dynamic-adapter-nr" is meant for kernel internal use
> only, therefor it is NOT documented under Documents/devicetree/bindings.

To the second and third ones, can we rather check if the device has fwnode
either ACPI or swnode? AFAIU now we have swnode assigned during MFD device
registration and can easily distinguish this w/o any additional properties.

-- 
With Best Regards,
Andy Shevchenko


