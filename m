Return-Path: <SRS0=Iotr=V7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51284C433FF
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Aug 2019 15:53:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EE352166E
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Aug 2019 15:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564847631;
	bh=/Sz995kn2vhhOIU477qk6hrw4p98X9l1OrZDiibt7XU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=UUKMGDv++CTf68jQWrXk+x5VjXDiLuJrzZdmJ/0mXUGjGA/7n5hBMQBx8ebMOs4Pl
	 V84VnDJoSDNW5WeCoV5tIYph1fnHzqnoxU4OQWCvNECIPOdlD6Be9vMCamOn99bBJY
	 iuVKfqlSENatU5B4H5HIIIHtqIaJM3fJZPoM7YTo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728042AbfHCPxu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Aug 2019 11:53:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:45906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727758AbfHCPxt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Aug 2019 11:53:49 -0400
Received: from X250.getinternet.no (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B0C42085B;
        Sat,  3 Aug 2019 15:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564847628;
        bh=/Sz995kn2vhhOIU477qk6hrw4p98X9l1OrZDiibt7XU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LSHJJGu70TAXfJmFefWWrw0g4zM7f/OgvZzu+LanKMT685a0IqwtfeL4GeBoPcpQ9
         TGJ5ZkXaE67LmgN7WIsBqG+BetrDYh0g91iaFSexahq5yMi1OW2jPRc8Ohhx6twoTB
         5thGucacB/PRcaOUjpEucPUJt9Y/o9OJDF10Y0HI=
Date:   Sat, 3 Aug 2019 17:53:42 +0200
From:   Shawn Guo <shawnguo@kernel.org>
To:     Lukasz Majewski <lukma@denx.de>
Cc:     Fabio Estevam <festevam@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Stefan Agner <stefan@agner.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] ARM: dts: vf610-bk4: Fix qspi node description
Message-ID: <20190803155341.GT8870@X250.getinternet.no>
References: <20190731141151.7196-1-lukma@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190731141151.7196-1-lukma@denx.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 31, 2019 at 04:11:51PM +0200, Lukasz Majewski wrote:
> Before this change the device tree description of qspi node for
> second memory on BK4 board was wrong (applicable to old, removed
> fsl-quadspi.c driver).
> 
> As a result this memory was not recognized correctly when used
> with the new spi-fsl-qspi.c driver.
> 
> From the dt-bindings:
> 
> "Required SPI slave node properties:
>   - reg: There are two buses (A and B) with two chip selects each.
> This encodes to which bus and CS the flash is connected:
> <0>: Bus A, CS 0
> <1>: Bus A, CS 1
> <2>: Bus B, CS 0
> <3>: Bus B, CS 1"
> 
> According to above with new driver the second SPI-NOR memory shall
> have reg=<2> as it is connected to Bus B, CS 0.
> 
> Fixes: a67d2c52a82f ("ARM: dts: Add support for Liebherr's BK4 device (vf610 based)")
> Suggested-by: Fabio Estevam <festevam@gmail.com>
> Signed-off-by: Lukasz Majewski <lukma@denx.de>
> Reviewed-by: Fabio Estevam <festevam@gmail.com>

Applied, thanks.
