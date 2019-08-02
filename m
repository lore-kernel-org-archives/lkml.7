Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70745C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 20:44:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4205D2087E
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 20:44:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437030AbfHBUow (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 16:44:52 -0400
Received: from mga12.intel.com ([192.55.52.136]:35806 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726574AbfHBUov (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 16:44:51 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Aug 2019 13:44:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,339,1559545200"; 
   d="scan'208";a="181118540"
Received: from psathya-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.36.242])
  by FMSMGA003.fm.intel.com with ESMTP; 02 Aug 2019 13:44:47 -0700
Date:   Fri, 2 Aug 2019 23:44:46 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Peter Huewe <peterhuewe@gmx.de>,
        Duncan Laurie <dlaurie@chromium.org>,
        linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org,
        Andrey Pronin <apronin@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
Subject: Re: [PATCH v2 6/6] tpm: Add driver for cr50 on I2C
Message-ID: <20190802204446.pj3vx56gzrdohibx@linux.intel.com>
References: <20190716224518.62556-1-swboyd@chromium.org>
 <20190716224518.62556-7-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190716224518.62556-7-swboyd@chromium.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 16, 2019 at 03:45:18PM -0700, Stephen Boyd wrote:
> From: Duncan Laurie <dlaurie@chromium.org>
> 
> Add TPM 2.0 compatible I2C interface for chips with cr50 firmware.
> 
> The firmware running on the currently supported H1 MCU requires a
> special driver to handle its specific protocol, and this makes it
> unsuitable to use tpm_tis_core_* and instead it must implement the
> underlying TPM protocol similar to the other I2C TPM drivers.
> 
> - All 4 byes of status register must be read/written at once.
> - FIFO and burst count is limited to 63 and must be drained by AP.
> - Provides an interrupt to indicate when read response data is ready
> and when the TPM is finished processing write data.
> 
> This driver is based on the existing infineon I2C TPM driver, which
> most closely matches the cr50 i2c protocol behavior.  The driver is
> intentionally kept very similar in structure and style to the
> corresponding drivers in coreboot and depthcharge.
> 
> Signed-off-by: Duncan Laurie <dlaurie@chromium.org>
> [swboyd@chromium.org: Depend on i2c even if it's a module, replace
> boilier plate with SPDX tag, drop asm/byteorder.h include, simplify
> return from probe]
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>

Apologies. I missed this when I stated my comment about SPI.

/Jarkko
