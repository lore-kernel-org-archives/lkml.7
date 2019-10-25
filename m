Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FA85CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 07:53:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F1BD2070B
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 07:53:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437333AbfJYHxi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 03:53:38 -0400
Received: from mga05.intel.com ([192.55.52.43]:61386 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727275AbfJYHxi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 03:53:38 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Oct 2019 00:53:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,227,1569308400"; 
   d="scan'208";a="223845569"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga004.fm.intel.com with ESMTP; 25 Oct 2019 00:53:36 -0700
Received: from andy by smile with local (Exim 4.92.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1iNuPf-0001i5-GF; Fri, 25 Oct 2019 10:53:35 +0300
Date:   Fri, 25 Oct 2019 10:53:35 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andrey Zhizhikin <andrey.z@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     lgirdwood@gmail.com, broonie@kernel.org, lee.jones@linaro.org,
        linux-kernel@vger.kernel.org,
        Andrey Zhizhikin <andrey.zhizhikin@leica-geosystems.com>
Subject: Re: [PATCH 0/2] add regulator driver and mfd cell for Intel Cherry
 Trail Whiskey Cove PMIC
Message-ID: <20191025075335.GC32742@smile.fi.intel.com>
References: <20191024142939.25920-1-andrey.zhizhikin@leica-geosystems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191024142939.25920-1-andrey.zhizhikin@leica-geosystems.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 24, 2019 at 02:29:37PM +0000, Andrey Zhizhikin wrote:
> This patchset introduces additional regulator driver for Intel Cherry
> Trail Whiskey Cove PMIC. It also adds a cell in mfd driver for this
> PMIC, which is used to instantiate this regulator.
> 
> Regulator support for this PMIC was present in kernel release from Intel
> targeted Aero platform, but was not entirely ported upstream and has
> been omitted in mainline kernel releases. Consecutively, absence of
> regulator caused the SD Card interface not to be provided with Vqcc
> voltage source needed to operate with UHS-I cards.
> 
> Following patches are addessing this issue and making sd card interface
> to be fully operable with UHS-I cards. Regulator driver lists an ACPI id
> of the SD Card interface in consumers and exposes optional "vqmmc"
> voltage source, which mmc driver uses to switch signalling voltages
> between 1.8V and 3.3V. 
> 
> This set contains of 2 patches: one is implementing the regulator driver
> (based on a non upstreamed version from Intel Aero), and another patch
> registers this driver as mfd cell in exising Whiskey Cove PMIC driver.

Thank you.
Hans, Cc'ed, has quite interested in these kind of patches.
Am I right, Hans?

> 
> 
> Andrey Zhizhikin (2):
>   regulator: add support for Intel Cherry Whiskey Cove regulator
>   mfd: add regulator cell to Cherry Trail Whiskey Cove PMIC
> 
>  drivers/mfd/intel_soc_pmic_chtwc.c            |  15 +-
>  drivers/regulator/Kconfig                     |  10 +
>  drivers/regulator/Makefile                    |   1 +
>  drivers/regulator/intel-cht-wc-regulator.c    | 433 ++++++++++++++++++
>  .../linux/regulator/intel-cht-wc-regulator.h  |  64 +++
>  5 files changed, 521 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/regulator/intel-cht-wc-regulator.c
>  create mode 100644 include/linux/regulator/intel-cht-wc-regulator.h
> 
> -- 
> 2.17.1
> 

-- 
With Best Regards,
Andy Shevchenko


