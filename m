Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C248C3A59C
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 13:00:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D027206C1
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 13:00:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732010AbfHONAm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 09:00:42 -0400
Received: from mga07.intel.com ([134.134.136.100]:65275 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729818AbfHONAm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 09:00:42 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Aug 2019 06:00:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,389,1559545200"; 
   d="scan'208";a="167737330"
Received: from jsakkine-mobl1.tm.intel.com (HELO localhost) ([10.237.50.163])
  by orsmga007.jf.intel.com with ESMTP; 15 Aug 2019 06:00:12 -0700
Date:   Thu, 15 Aug 2019 16:00:11 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Peter Huewe <peterhuewe@gmx.de>,
        Andrey Pronin <apronin@chromium.org>,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        Duncan Laurie <dlaurie@chromium.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <groeck@chromium.org>,
        Alexander Steffen <Alexander.Steffen@infineon.com>
Subject: Re: [PATCH v3 4/4] tpm: add driver for cr50 on SPI
Message-ID: <20190815130011.6xxofsf3onf775p4@linux.intel.com>
References: <20190806220750.86597-1-swboyd@chromium.org>
 <20190806220750.86597-5-swboyd@chromium.org>
 <e7951cb251116e903cf0040ee6f271dc4e68ff2e.camel@linux.intel.com>
 <5d51d02c.1c69fb81.6f113.f06a@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d51d02c.1c69fb81.6f113.f06a@mx.google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 12, 2019 at 01:46:35PM -0700, Stephen Boyd wrote:
> Quoting Jarkko Sakkinen (2019-08-09 13:31:04)
> > On Tue, 2019-08-06 at 15:07 -0700, Stephen Boyd wrote:
> > > From: Andrey Pronin <apronin@chromium.org>
> > > 
> > > Add TPM2.0 PTP FIFO compatible SPI interface for chips with Cr50
> > > firmware. The firmware running on the currently supported H1
> > > Secure Microcontroller requires a special driver to handle its
> > > specifics:
> > > 
> > >  - need to ensure a certain delay between spi transactions, or else
> > >    the chip may miss some part of the next transaction;
> > >  - if there is no spi activity for some time, it may go to sleep,
> > >    and needs to be waken up before sending further commands;
> > >  - access to vendor-specific registers.
> > 
> > Which Chromebook models have this chip?
> 
> Pretty much all Chromebooks released in the last year or two have this
> chip in them. I don't have an exhaustive list, but you can usually check
> this by putting your device into dev mode and then looking at the driver
> attached to the TPM device in sysfs or by grepping the dmesg output for
> cr50.
> 
> > 
> > If I had an access to one, how do I do kernel testing with it i.e.
> > how do I get it to boot initramfs and bzImage from a USB stick?
> > 
> > 
> 
> You can follow the developer guide[1] and build a USB image for the
> board you have. You can usually checkout the latest upstream kernel in
> place of where the kernel is built from in the chroot, typically
> ~/trunk/src/third_party/kernel/<version number>. The build should pick
> up that it's an upstream tree and try to use some default defconfig.
> This driver isn't upstream yet, so you may need to enable it in the
> defconfig, located in
> ~/trunk/src/third_party/chromiumos-overlay/eclass/cros-kernel/ so that
> the driver is actually built. After that, use 'cros flash' to flash the
> new kernel image to your USB stick and boot from USB with 'ctrl+u' and
> you should be on your way to chromeos kernel testing.
> 
> [1] https://chromium.googlesource.com/chromiumos/docs/+/master/developer_guide.md

Hey, thanks for info! I'll see if I can get my hands on one.

/Jarkko
