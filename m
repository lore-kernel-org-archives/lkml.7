Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92DD7C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 13:47:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F0122184B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 13:47:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403885AbfEXNrB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 09:47:01 -0400
Received: from mga18.intel.com ([134.134.136.126]:38809 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391124AbfEXNrB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 09:47:01 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 May 2019 06:47:00 -0700
X-ExtLoop1: 1
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.145])
  by fmsmga007.fm.intel.com with ESMTP; 24 May 2019 06:46:58 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andy.shevchenko@gmail.com>)
        id 1hUAXB-0003ZZ-T3; Fri, 24 May 2019 16:46:57 +0300
Date:   Fri, 24 May 2019 16:46:57 +0300
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     Stefan Roese <sr@denx.de>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yegor Yefremov <yegorslists@googlemail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Giulio Benetti <giulio.benetti@micronovasrl.com>
Subject: Re: [PATCH 1/2 v2] serial: mctrl_gpio: Check if GPIO property
 exisits before requesting it
Message-ID: <20190524134657.GV9224@smile.fi.intel.com>
References: <20190524094825.16151-1-sr@denx.de>
 <20190524102002.GT2781@lahna.fi.intel.com>
 <CAHp75VcMVrYv1MXmmqE9fDXShS=Y8pPdWZ4f1neo=ne88TLZDg@mail.gmail.com>
 <287cdcc8-9a8f-4583-8be9-bd1f95936733@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <287cdcc8-9a8f-4583-8be9-bd1f95936733@denx.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2019 at 01:29:34PM +0200, Stefan Roese wrote:
> On 24.05.19 13:11, Andy Shevchenko wrote:
> > On Fri, May 24, 2019 at 1:21 PM Mika Westerberg
> > <mika.westerberg@linux.intel.com> wrote:
> > > 
> > > On Fri, May 24, 2019 at 11:48:24AM +0200, Stefan Roese wrote:
> > > > This patch adds a check for the GPIOs property existence, before the
> > > > GPIO is requested. This fixes an issue seen when the 8250 mctrl_gpio
> > > > support is added (2nd patch in this patch series) on x86 platforms using
> > > > ACPI.
> > > > 
> > > > Here Mika's comments from 2016-08-09:
> > > > 
> > > > "
> > > > I noticed that with v4.8-rc1 serial console of some of our Broxton
> > > > systems does not work properly anymore. I'm able to see output but input
> > > > does not work.
> > > > 
> > > > I bisected it down to commit 4ef03d328769eddbfeca1f1c958fdb181a69c341
> > > > ("tty/serial/8250: use mctrl_gpio helpers").
> > > > 
> > > > The reason why it fails is that in ACPI we do not have names for GPIOs
> > > > (except when _DSD is used) so we use the "idx" to index into _CRS GPIO
> > > > resources. Now mctrl_gpio_init_noauto() goes through a list of GPIOs
> > > > calling devm_gpiod_get_index_optional() passing "idx" of 0 for each. The
> > > > UART device in Broxton has following (simplified) ACPI description:
> > > > 
> > > >      Device (URT4)
> > > >      {
> > > >          ...
> > > >          Name (_CRS, ResourceTemplate () {
> > > >              GpioIo (Exclusive, PullDefault, 0x0000, 0x0000, IoRestrictionOutputOnly,
> > > >                      "\\_SB.GPO0", 0x00, ResourceConsumer)
> > > >              {
> > > >                  0x003A
> > > >              }
> > > >              GpioIo (Exclusive, PullDefault, 0x0000, 0x0000, IoRestrictionOutputOnly,
> > > >                      "\\_SB.GPO0", 0x00, ResourceConsumer)
> > > >              {
> > > >                  0x003D
> > > >              }
> > > >          })
> > > > 
> > > > In this case it finds the first GPIO (0x003A which happens to be RX pin
> > > > for that UART), turns it into GPIO which then breaks input for the UART
> > > > device. This also breaks systems with bluetooth connected to UART (those
> > > > typically have some GPIOs in their _CRS).
> > > > 
> > > > Any ideas how to fix this?
> > > > 
> > > > We cannot just drop the _CRS index lookup fallback because that would
> > > > break many existing machines out there so maybe we can limit this to
> > > > only DT enabled machines. Or alternatively probe if the property first
> > > > exists before trying to acquire the GPIOs (using
> > > > device_property_present()).
> > > > "
> > > > 
> > > > This patch implements the fix suggested by Mika in his statement above.
> > > > 
> > 
> > We have a board where ASL provides _DSD for CTS and RxD pins.
> > I'm afraid this won't work on it.
> 
> With "won't work" you mean, that the GPIO can't be used for modem
> control in this case in the current implementation (with this
> patchset)? Or do you mean, that the breakage (input does not work
> on Broxton systems) will not be solved by this patch?

It will solve RxD case, due to mctrl doesn't count RxD as a "control" line.

Though we have CTS pin defined for the same purpose, which means the hardware
flow control won't work on a subset of Broxton boards.

> If its the former, then I think that solving this issue is something
> for a new patch, to support modem-control on such platforms as well
> (if needed).

> Please note that this patch is not trying to get modem-control working
> on such ACPI based systems.

I understand that. At the same time it should not break existing systems.

> Its targeted for device-tree enabled
> platforms, using the 8250 serial driver, here specifically a MIPS
> MT7688 based board. And just wants to fix the latter issue mentioned
> above so that the 8250 modem-control support can be accepted in
> mainline.

As I said already we have to distinguish *the purpose* of these GPIOs.
(like CTS).

Can we apply this if and only if the device has no ACPI companion device?

In this case DT will work as you expect and ACPI won't be broken.

> > Basically we need to understand the use of the GPIOs in UART. In our
> > case it's an out-of-band wake up source for UART.
> > Simply requiring GPIOs to be present is not enough.
> > 
> > Perhaps property like 'modem-control-gpio-in-use' (this seems a bad
> > name, given for sake of example).

-- 
With Best Regards,
Andy Shevchenko


