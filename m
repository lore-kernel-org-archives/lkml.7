Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDD90C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 10:20:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B572C20856
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 10:20:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390420AbfEXKUG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 06:20:06 -0400
Received: from mga18.intel.com ([134.134.136.126]:27154 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389448AbfEXKUG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 06:20:06 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 May 2019 03:20:05 -0700
X-ExtLoop1: 1
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 24 May 2019 03:20:02 -0700
Received: by lahna (sSMTP sendmail emulation); Fri, 24 May 2019 13:20:02 +0300
Date:   Fri, 24 May 2019 13:20:02 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Stefan Roese <sr@denx.de>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Yegor Yefremov <yegorslists@googlemail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Giulio Benetti <giulio.benetti@micronovasrl.com>
Subject: Re: [PATCH 1/2 v2] serial: mctrl_gpio: Check if GPIO property
 exisits before requesting it
Message-ID: <20190524102002.GT2781@lahna.fi.intel.com>
References: <20190524094825.16151-1-sr@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190524094825.16151-1-sr@denx.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2019 at 11:48:24AM +0200, Stefan Roese wrote:
> This patch adds a check for the GPIOs property existence, before the
> GPIO is requested. This fixes an issue seen when the 8250 mctrl_gpio
> support is added (2nd patch in this patch series) on x86 platforms using
> ACPI.
> 
> Here Mika's comments from 2016-08-09:
> 
> "
> I noticed that with v4.8-rc1 serial console of some of our Broxton
> systems does not work properly anymore. I'm able to see output but input
> does not work.
> 
> I bisected it down to commit 4ef03d328769eddbfeca1f1c958fdb181a69c341
> ("tty/serial/8250: use mctrl_gpio helpers").
> 
> The reason why it fails is that in ACPI we do not have names for GPIOs
> (except when _DSD is used) so we use the "idx" to index into _CRS GPIO
> resources. Now mctrl_gpio_init_noauto() goes through a list of GPIOs
> calling devm_gpiod_get_index_optional() passing "idx" of 0 for each. The
> UART device in Broxton has following (simplified) ACPI description:
> 
>     Device (URT4)
>     {
>         ...
>         Name (_CRS, ResourceTemplate () {
>             GpioIo (Exclusive, PullDefault, 0x0000, 0x0000, IoRestrictionOutputOnly,
>                     "\\_SB.GPO0", 0x00, ResourceConsumer)
>             {
>                 0x003A
>             }
>             GpioIo (Exclusive, PullDefault, 0x0000, 0x0000, IoRestrictionOutputOnly,
>                     "\\_SB.GPO0", 0x00, ResourceConsumer)
>             {
>                 0x003D
>             }
>         })
> 
> In this case it finds the first GPIO (0x003A which happens to be RX pin
> for that UART), turns it into GPIO which then breaks input for the UART
> device. This also breaks systems with bluetooth connected to UART (those
> typically have some GPIOs in their _CRS).
> 
> Any ideas how to fix this?
> 
> We cannot just drop the _CRS index lookup fallback because that would
> break many existing machines out there so maybe we can limit this to
> only DT enabled machines. Or alternatively probe if the property first
> exists before trying to acquire the GPIOs (using
> device_property_present()).
> "
> 
> This patch implements the fix suggested by Mika in his statement above.
> 
> Signed-off-by: Stefan Roese <sr@denx.de>
> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
