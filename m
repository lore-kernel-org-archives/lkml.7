Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 785F7C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 13:21:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4824220872
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 13:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555420881;
	bh=lQvlKkLoWQROchqf3jjmgxZhA79mmpKcJdrvVgfy49I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mNU0IvTz6+ykYwVNCjnhY/y8oaoqQ3Uiq5761a1NrfU1sJNYLfKRtko7ZHeerBNFV
	 tu3CMXhfnUZXsTK6gK9pE+alQAOL86Y3yEXoi3F0lT6wYJ/ipaplfLXylhNTgUeKcX
	 QjvrYlD8H/yIrLdAi9Y4exptR/8BVyvOMi7igTC8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728422AbfDPNVU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 09:21:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:35912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727841AbfDPNVS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 09:21:18 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 984B220821;
        Tue, 16 Apr 2019 13:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555420878;
        bh=lQvlKkLoWQROchqf3jjmgxZhA79mmpKcJdrvVgfy49I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KCqQqc9q3lnd7540nAhm696oWBTotcCQYlyrjQntCRUOUa84ZufimlXgNArbcK16i
         3dcpfdNyJrW/toSMgBhNKLYadLxu4hjmFP8HFTrgHzZT0PDTO/ZLUA1mJARV1CjUIh
         EPBn4UrUDa+jwmI+1YBFnSzhJWX19cl42BX1hcEc=
Date:   Tue, 16 Apr 2019 15:16:19 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Thomas Bogendoerfer <tbogendoerfer@suse.de>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Jiri Slaby <jslaby@suse.com>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        netdev@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH v2 2/4] mfd: ioc3: Add driver for SGI IOC3 chip
Message-ID: <20190416131619.GE7406@kroah.com>
References: <20190409154610.6735-1-tbogendoerfer@suse.de>
 <20190409154610.6735-3-tbogendoerfer@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190409154610.6735-3-tbogendoerfer@suse.de>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 09, 2019 at 05:46:06PM +0200, Thomas Bogendoerfer wrote:
> SGI IOC3 chip has integrated ethernet, keyboard and mouse interface.
> It also supports connecting a SuperIO chip for serial and parallel
> interfaces. IOC3 is used inside various SGI systemboards and add-on
> cards with different equipped external interfaces.
> 
> Support for ethernet and serial interfaces were implemented inside
> the network driver. This patchset moves out the not network related
> parts to a new MFD driver, which takes care of card detection,
> setup of platform devices and interrupt distribution for the subdevices.
> 
> Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>
> ---
>  arch/mips/include/asm/sn/ioc3.h       |  345 +++---
>  arch/mips/sgi-ip27/ip27-timer.c       |   20 -
>  drivers/mfd/Kconfig                   |   13 +
>  drivers/mfd/Makefile                  |    1 +
>  drivers/mfd/ioc3.c                    |  802 ++++++++++++++
>  drivers/net/ethernet/sgi/Kconfig      |    4 +-
>  drivers/net/ethernet/sgi/ioc3-eth.c   | 1867 ++++++++++++---------------------
>  drivers/tty/serial/8250/8250_ioc3.c   |   98 ++
>  drivers/tty/serial/8250/Kconfig       |   11 +
>  drivers/tty/serial/8250/Makefile      |    1 +
>  include/linux/platform_data/ioc3eth.h |   15 +
>  11 files changed, 1762 insertions(+), 1415 deletions(-)
>  create mode 100644 drivers/mfd/ioc3.c
>  create mode 100644 drivers/tty/serial/8250/8250_ioc3.c
>  create mode 100644 include/linux/platform_data/ioc3eth.h

Serial portion:

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
