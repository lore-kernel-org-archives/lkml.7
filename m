Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65B61C4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 14:02:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DBE82183F
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 14:02:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729439AbfC2OCm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 10:02:42 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:48942 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1728996AbfC2OCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 10:02:42 -0400
Received: (qmail 1797 invoked by uid 2102); 29 Mar 2019 10:02:41 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 29 Mar 2019 10:02:41 -0400
Date:   Fri, 29 Mar 2019 10:02:41 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Bartosz Golaszewski <brgl@bgdev.pl>
cc:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH v2 0/6] ARM: davinci: ohci-da8xx: model the vbus GPIO as
 a fixed regulator
In-Reply-To: <20190329093334.3885-1-brgl@bgdev.pl>
Message-ID: <Pine.LNX.4.44L0.1903291002140.1497-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Mar 2019, Bartosz Golaszewski wrote:

> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Historically the power supply management in this driver has been handled
> in two separate places in parallel. Device-tree users simply defined an
> appropriate regulator, while two boards with no DT support (da830-evm and
> omapl138-hawk) passed functions defined in their respective board files
> over platform data. These functions simply used legacy GPIO calls to
> watch the oc GPIO for interrupts and disable the vbus GPIO when the irq
> fires.
> 
> Commit d193abf1c913 ("usb: ohci-da8xx: add vbus and overcurrent gpios")
> updated these GPIO calls to the modern API and moved them inside the
> driver.
> 
> This however is not the optimal solution for the vbus GPIO as it
> duplicates code. Instead we should model the GPIO as a fixed regulator
> that can be controlled with a GPIO.
> 
> This series adds fixed regulators for all users of vbus GPIO, adds
> overcurrent protection using the existing vbus regulator in the USB
> driver and removes the vbus GPIO calls once they're no longer used.
> 
> v1 -> v2:
> - add patch 1/6 that fixes an existing problem with missing array
>   sentinels in GPIO lookups
> - add patch 2/6 that removes an unnecessary use count variable from the
>   driver
> - reorder the changes: add support for overcurrent protection using the
>   existing vbus regulator first, then setup fixed regulators in board
>   files and finally remove the vbus GPIO from the ohci driver
> 
> Bartosz Golaszewski (6):
>   ARM: davinci: add missing sentinels to GPIO lookup tables
>   usb: ohci-da8xx: let the regulator framework keep track of use count
>   usb: ohci-da8xx: disable the regulator if the overcurrent irq fired
>   ARM: davinci: omapl138-hawk: add a fixed regulator for ohci-da8xx
>   ARM: davinci: da830-evm: add a fixed regulator for ohci-da8xx
>   usb: ohci-da8xx: drop the vbus GPIO
> 
>  arch/arm/mach-davinci/board-da830-evm.c     | 51 ++++++++++++++++++--
>  arch/arm/mach-davinci/board-da850-evm.c     |  1 +
>  arch/arm/mach-davinci/board-dm355-evm.c     |  1 +
>  arch/arm/mach-davinci/board-dm644x-evm.c    |  1 +
>  arch/arm/mach-davinci/board-omapl138-hawk.c | 50 ++++++++++++++++++--
>  drivers/usb/host/ohci-da8xx.c               | 52 ++++++++++-----------
>  6 files changed, 122 insertions(+), 34 deletions(-)

For patches 2, 3, and 6:

Acked-by: Alan Stern <stern@rowland.harvard.edu>

Alan Stern

