Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2868ECE587
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 12:47:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A21D521872
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 12:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569934074;
	bh=SCN9/i8SfJeDG79Gpd/McMsedKDykRm4Mu7A1hinUZc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=aYOK0A5DCW45WM5RMfUefKKK/ej+LtCpzcvafJKFRkvvkpiqAEbtO/vXedgU6YxCW
	 aIBFErcqDS8saySoUYJItF7stP2qJyTjHrau2R0vq5B10FH2JPRFo0SJSTO5hiNQSa
	 E4oDjXiCPM/KD/zpglBwvIjHiSULloD/0znqwJ6U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388045AbfJAMry (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 08:47:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:41720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387892AbfJAMrx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 08:47:53 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A0C4921872;
        Tue,  1 Oct 2019 12:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569934071;
        bh=SCN9/i8SfJeDG79Gpd/McMsedKDykRm4Mu7A1hinUZc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tmcIniEihFeq1sr8uAw8U4Bp2GqnCyF1SHx1AAtTb30LNdgGy7ZXZops7swz2tADq
         zSEd0I80fsoKVh6RnL9I2Oj8hjA31+s+RuJuiPgzxCL2+M7vXycWDT5DS05yxGil/d
         Qe85N72KS7wTl2C91II+JxyHWhJaH986kEdiqVng=
Date:   Tue, 1 Oct 2019 14:47:48 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     linux-usb@vger.kernel.org,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Rajmohan Mani <rajmohan.mani@intel.com>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        Lukas Wunner <lukas@wunner.de>,
        Alan Stern <stern@rowland.harvard.edu>,
        Mario.Limonciello@dell.com,
        Anthony Wong <anthony.wong@canonical.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 17/22] thunderbolt: Add initial support for USB4
Message-ID: <20191001124748.GH2954373@kroah.com>
References: <20191001113830.13028-1-mika.westerberg@linux.intel.com>
 <20191001113830.13028-18-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191001113830.13028-18-mika.westerberg@linux.intel.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 01, 2019 at 02:38:25PM +0300, Mika Westerberg wrote:
> USB4 is a public spec based on Thunderbolt protocol. There are some
> differences in register layouts and flows. In addition to PCIe and DP
> tunneling, USB4 supports tunneling of USB 3.x. USB4 is also backward
> compatible with Thunderbolt 3 (and older generations but the spec only
> talks about 3rd generation). USB4 compliant devices can be identified by
> checking USB4 version field in router configuration space.
> 
> This patch adds initial support for USB4 compliant hosts and devices
> which enables following features provided by the existing functionality
> in the driver:
> 
>   - PCIe tunneling
>   - Display Port tunneling
>   - Host and device NVM firmware upgrade
>   - P2P networking
> 
> This brings the USB4 support to the same level that we already have for
> Thunderbolt 1, 2 and 3 devices.
> 
> Note the spec talks about host and device "routers" but in the driver we
> still use term "switch" in most places. Both can be used interchangeably.
> 
> This also updates the Kconfig entry accordingly.
> 
> Co-developed-by: Rajmohan Mani <rajmohan.mani@intel.com>
> Signed-off-by: Rajmohan Mani <rajmohan.mani@intel.com>
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
>  drivers/thunderbolt/Kconfig   |   9 +-
>  drivers/thunderbolt/Makefile  |   2 +-
>  drivers/thunderbolt/eeprom.c  |  53 ++-
>  drivers/thunderbolt/nhi.c     |   3 +
>  drivers/thunderbolt/nhi.h     |   2 +
>  drivers/thunderbolt/switch.c  | 384 +++++++++++++-----
>  drivers/thunderbolt/tb.c      |  20 +-
>  drivers/thunderbolt/tb.h      |  36 ++
>  drivers/thunderbolt/tb_regs.h |  36 +-
>  drivers/thunderbolt/tunnel.c  |  10 +-
>  drivers/thunderbolt/usb4.c    | 722 ++++++++++++++++++++++++++++++++++
>  drivers/thunderbolt/xdomain.c |   6 +
>  12 files changed, 1162 insertions(+), 121 deletions(-)
>  create mode 100644 drivers/thunderbolt/usb4.c
> 
> diff --git a/drivers/thunderbolt/Kconfig b/drivers/thunderbolt/Kconfig
> index fd9adca898ff..8193ec310bae 100644
> --- a/drivers/thunderbolt/Kconfig
> +++ b/drivers/thunderbolt/Kconfig
> @@ -1,6 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  menuconfig THUNDERBOLT
> -	tristate "Thunderbolt support"
> +	tristate "USB4 (Thunderbolt) support"
>  	depends on PCI
>  	depends on X86 || COMPILE_TEST
>  	select APPLE_PROPERTIES if EFI_STUB && X86
> @@ -9,9 +9,10 @@ menuconfig THUNDERBOLT
>  	select CRYPTO_HASH
>  	select NVMEM
>  	help
> -	  Thunderbolt Controller driver. This driver is required if you
> -	  want to hotplug Thunderbolt devices on Apple hardware or on PCs
> -	  with Intel Falcon Ridge or newer.
> +	  USB4 (Thunderbolt) driver. USB4 is the public spec based on
> +	  Thunderbolt 3 protocol. This driver is required if you want to
> +	  hotplug Thunderbolt and USB4 compliant devices on Apple
> +	  hardware or on PCs with Intel Falcon Ridge or newer.

Wait, did "old" thunderbolt just get re-branded as USB4?

Because if I have an "old" laptop that needs Thunderbolt support, how am
I going to know it is now called USB4 instead?

Shouldn't there just be a new USB4 option that only enables/builds the
USB4 stuff if selected?  Why would I want all of this additional code on
my old system if it's not going to do anything at all?

Or am I confused?

thanks,

greg k-h
