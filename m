Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BCDCC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 14:47:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4955D2087C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 14:47:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbfCLOrw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 10:47:52 -0400
Received: from mga12.intel.com ([192.55.52.136]:1761 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726304AbfCLOrv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 10:47:51 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Mar 2019 07:47:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,471,1544515200"; 
   d="scan'208";a="130976207"
Received: from mylly.fi.intel.com (HELO [10.237.72.56]) ([10.237.72.56])
  by fmsmga008.fm.intel.com with ESMTP; 12 Mar 2019 07:47:49 -0700
Subject: Re: [PATCH 1/2] i2c: i2c-designware-platdrv: Allow a dynamic adap. nr
 without an ACPI fwnode
To:     Hans de Goede <hdegoede@redhat.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190311112216.31391-1-hdegoede@redhat.com>
 <20190311112216.31391-2-hdegoede@redhat.com>
From:   Jarkko Nikula <jarkko.nikula@linux.intel.com>
Message-ID: <c519b0ea-670d-defe-5870-c6258c19ff74@linux.intel.com>
Date:   Tue, 12 Mar 2019 16:47:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190311112216.31391-2-hdegoede@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On 3/11/19 1:22 PM, Hans de Goede wrote:
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
I went thinking would we get a regression if we switch the 
i2c-designware-platdrv to dynamic numbering unconditionally?

Only drivers/mfd/intel-lpss.c and drivers/mfd/intel_quark_i2c_gpio.c 
register platform device "i2c_designware" and otherwise in the driver 
itself for known ACPI IDs and device tree bindings.

Things should be fine for ACPI cases if slave devices are also described 
in ACPI tables. As far as I've understood with device tree matching 
adapter number is irrelevant in slave device registration?

Andy: could you tell by commit 918fe70cf475 ("mfd: intel_quark_i2c_gpio: 
support devices behind i2c bus") are those devices described in ACPI or 
in some i2c_board_infos with referring to fixed adapter number either in 
or out of kernel tree code?

Then drivers/platform/chrome/chromeos_laptop.c is the only code 
searching for adapter named as "Synopsys DesignWare I2C adapter" without 
assuming any fixed adapter numbering.

What's unclear to me can there be device tree cases where i2c-designware 
probing comes with pdev->id not starting from zero or in different 
order? I.e. would it make difference do we use pdev->id or dynamic 
adapter numbering?

-- 
Jarkko
