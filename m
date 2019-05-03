Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D808C43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 14:26:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EFDE2081C
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 14:26:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727613AbfECO0y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 10:26:54 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:44264 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725777AbfECO0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 10:26:53 -0400
Received: from localhost (adsl-173-228-226-134.prtc.net [173.228.226.134])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 90E5E14B678CE;
        Fri,  3 May 2019 07:26:52 -0700 (PDT)
Date:   Fri, 03 May 2019 10:26:51 -0400 (EDT)
Message-Id: <20190503.102651.1150195235857856671.davem@davemloft.net>
To:     nicolas.ferre@microchip.com
Cc:     claudiu.beznea@microchip.com, linux-arm-kernel@lists.infradead.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        alexandre.belloni@bootlin.com, michal.simek@xilinx.com,
        harini.katakam@xilinx.com
Subject: Re: [PATCH] net: macb: shrink macb_platform_data structure
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190503103658.17237-1-nicolas.ferre@microchip.com>
References: <20190503103658.17237-1-nicolas.ferre@microchip.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 03 May 2019 07:26:53 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicolas Ferre <nicolas.ferre@microchip.com>
Date: Fri, 3 May 2019 12:36:58 +0200

> This structure was used intensively for machine specific values
> when DT was not used. Since the removal of AVR32 from the kernel,
> this structure is only used for passing clocks from PCI macb wrapper, all
> other fields being 0.
> All other known platforms use DT.
> 
> Remove the leftovers but make sure that PCI macb still works as
> expected by using default values:
> - phydev->irq is set to PHY_POLL by mdiobus_alloc()
> - mii_bus->phy_mask is cleared while allocating it
> - bp->phy_interface is set to PHY_INTERFACE_MODE_MII if mode not found
> in DT.
> 
> This simplifies driver probe path and particularly phy handling.
> 
> Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>

Applied.
