Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7267C10F03
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 13:01:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78E0221917
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 13:01:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731843AbfCVNBb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 09:01:31 -0400
Received: from mga18.intel.com ([134.134.136.126]:43881 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731007AbfCVLm7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:42:59 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Mar 2019 04:42:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,256,1549958400"; 
   d="scan'208";a="154749600"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by fmsmga004.fm.intel.com with ESMTP; 22 Mar 2019 04:42:56 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1h7IZa-0001v2-Vx; Fri, 22 Mar 2019 13:42:54 +0200
Date:   Fri, 22 Mar 2019 13:42:54 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Ian W MORRISON <ianwmorrison@gmail.com>
Cc:     benjamin.tissoires@redhat.com, hdegoede@redhat.com,
        mika.westerberg@linux.intel.com, linus.walleij@linaro.org,
        bgolaszewski@baylibre.com, linux-gpio@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] Skip deferred request irqs for devices known to fail
Message-ID: <20190322114254.GT9224@smile.fi.intel.com>
References: <20190322110515.21499-1-ianwmorrison@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190322110515.21499-1-ianwmorrison@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 22, 2019 at 10:05:15PM +1100, Ian W MORRISON wrote:

Thanks for the patch, my comments below.

> Patch ca876c7483b6 "gpiolib-acpi: make sure we trigger edge events at
> least once on boot" causes the MINIX family of mini PCs to fail to boot
> resulting in a "black screen". 

> This patch excludes MINIX devices from executing this trigger in order
> to successfully boot.

Hmm... Feels like this is symptomatic healing.
Hans, do you have anything in mind about this case?

>  #include <linux/interrupt.h>
>  #include <linux/mutex.h>
>  #include <linux/pinctrl/pinctrl.h>
> +#include <linux/dmi.h>

This should be in order.

>  /* Run deferred acpi_gpiochip_request_irqs() */
> +/* but exclude devices known to fail */

/*
 * This should be done in the similar style
 * as for multi-line comments. Like this one.
 */

> +	dmi_id = dmi_first_match(skip_deferred_request_irqs_table);
> +

Redundant blank line.

> +	if (! dmi_id) {

No space here, however, better to write positive conditional.

-- 
With Best Regards,
Andy Shevchenko


