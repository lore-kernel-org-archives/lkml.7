Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E40E6C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 13:15:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEFE52084C
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 13:15:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbfDCNPP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 09:15:15 -0400
Received: from mga05.intel.com ([192.55.52.43]:44506 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726097AbfDCNPP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 09:15:15 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Apr 2019 06:15:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,304,1549958400"; 
   d="scan'208";a="334627151"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by fmsmga005.fm.intel.com with ESMTP; 03 Apr 2019 06:15:11 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1hBfjS-0002qL-IF; Wed, 03 Apr 2019 16:15:10 +0300
Date:   Wed, 3 Apr 2019 16:15:10 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Peter Rosin <peda@axentia.se>,
        Stefan Lengfeld <contact@stefanchrist.eu>,
        linux-omap@vger.kernel.org, linux-tegra@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 00/12] i2c: core: introduce atomic transfers
Message-ID: <20190403131510.GE9224@smile.fi.intel.com>
References: <20190403124019.8947-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190403124019.8947-1-wsa+renesas@sang-engineering.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 03, 2019 at 02:40:07PM +0200, Wolfram Sang wrote:
> This series adds support for very late atomic transfers to the I2C subsystem.
> It finally reached a state which I think is ready-to-apply. This is mainly
> because of two things:
> 
> a) we decided to respect the current locking scheme and to not give atomic
> transfers a priority. The code needed for that would have been either
> incomplete or very invasive. And we cannot guarantee successful transfers
> anyhow. See [1] for the discussion and other write-ups for design choices.
> 
> b) thanks to a discussion with Peter Zijlstra[2], the conditions when to allow
> atomic transfers became much clearer. The new helper i2c_in_atomic_xfer_mode()
> adds readability, too.
> 
> In detail, changes since RFC v2:
> 
> * dropped coding style patch because already applied
> * added new patch 1 to drop in_atomic() and have better conditions when
>   to enter the atomic path
> * added support to the mux-core
> * simplified omap conversion a little
> * added new conversions for ocores, stu300, and algo-bit/gpio
> * typo corrections found by Simon and Stefan
> * added tags to drivers
> * dropped tags from core patches because that part changed too much
> 
> All tested on a Renesas Lager board (R-Car H2). Sadly, the i2c-sh_mobile driver
> cannot be converted now because of other work needed first. I tested with the
> i2c-gpio driver, though. The other driver patches are build tested. A branch
> can be found here:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git renesas/i2c/atomic_xfer
> 
> I am happy for reviews and comments. Please note if you review (especially the
> core parts), I'd like to have a short summary of your review even if there is
> no proposed change. Like what you did, what you think about it, etc. Some stuff
> in here is subtle, so if you went through the effort to double check my
> assumptions you should name it :)
> 

Thank you!

FWIW,

Reviewed-by Andy Shevchenko <andriy.shevchenko@linux.intel.com>

for patches 1-5,12.

Indeed, atomic condition sounds clear now.

> 
> Finally, a big thank you and credit to Renesas for funding this work, of course!
> 
> Happy hacking,
> 
>    Wolfram
> 
> [1] https://lkml.org/lkml/2019/3/2/76
> [2] http://patchwork.ozlabs.org/patch/1067437/
> 
> Wolfram Sang (12):
>   i2c: remove use of in_atomic()
>   i2c: core: use I2C locking behaviour also for SMBUS
>   i2c: core: introduce callbacks for atomic transfers
>   i2c: mux: populate the new *_atomic callbacks
>   i2c: demux: handle the new atomic callbacks
>   i2c: omap: Add the master_xfer_irqless hook
>   i2c: tegra-bpmp: convert to use new atomic callbacks
>   i2c: ocores: refactor setup for polling
>   i2c: ocores: enable atomic xfers
>   i2c: stu300: use xfer_atomic callback to bail out early
>   i2c: algo: bit: add flag to whitelist atomic transfers
>   i2c: gpio: flag atomic capability if possible
> 
>  drivers/i2c/algos/i2c-algo-bit.c      | 22 +++++++++-
>  drivers/i2c/busses/i2c-gpio.c         |  2 +
>  drivers/i2c/busses/i2c-ocores.c       | 16 +++-----
>  drivers/i2c/busses/i2c-omap.c         | 76 +++++++++++++++++++++++++++++------
>  drivers/i2c/busses/i2c-stu300.c       | 25 +++++-------
>  drivers/i2c/busses/i2c-tegra-bpmp.c   | 25 +++++++++---
>  drivers/i2c/i2c-core-base.c           | 17 ++++----
>  drivers/i2c/i2c-core-smbus.c          | 25 +++++++++---
>  drivers/i2c/i2c-core.h                | 25 ++++++++++++
>  drivers/i2c/i2c-mux.c                 |  6 +++
>  drivers/i2c/muxes/i2c-demux-pinctrl.c |  2 +
>  include/linux/i2c-algo-bit.h          |  1 +
>  include/linux/i2c.h                   | 15 +++++--
>  13 files changed, 194 insertions(+), 63 deletions(-)
> 
> -- 
> 2.11.0
> 

-- 
With Best Regards,
Andy Shevchenko


