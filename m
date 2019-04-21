Return-Path: <SRS0=ebdT=SX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16FCBC10F14
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Apr 2019 07:40:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9DDC2147C
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Apr 2019 07:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555832428;
	bh=Pb6r3vWA/DTvoY0vZsBOP1/4gpXHCnVCuOnEawkWSNQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=kH4X+mLIH14T0AiPvtOxzJ8Wwcn0flQ6KLmh+HgJIaDxNegYxMhg4r8Y7K6Tz3XWf
	 3wVu/vllHWNToGhnugDysXIyMf5Ew9sE71Dbg8CH1emOGgNsdlmx8u5F7e3fq1WF6Z
	 3o/HiKZ/79eFDSzgUnT8Bi0UZLF6honX6fhD0SZ8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbfDUHk1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Apr 2019 03:40:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:60900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725936AbfDUHk1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Apr 2019 03:40:27 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 336842087F;
        Sun, 21 Apr 2019 07:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555832426;
        bh=Pb6r3vWA/DTvoY0vZsBOP1/4gpXHCnVCuOnEawkWSNQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b0pcba+m8lOH685aoS1r2KLDj6By0mI9FJ6Fjb7oz31ze/Azf0ervTA2doN/WWkec
         xpnywYh2M+q0vaCz7yisMjYTAf2APzqGANlrQ8kT+4EaSNDfX2JeoGycFaQqvjtVcQ
         GgHebgD8Rr6tcZo+zxrS3WQrSfLoYECGqlIYnkC0=
Date:   Sun, 21 Apr 2019 15:40:00 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "heiko@sntech.de" <heiko@sntech.de>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        "olof@lixom.net" <olof@lixom.net>,
        Andy Gross <andy.gross@linaro.org>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "stefan.wahren@i2se.com" <stefan.wahren@i2se.com>,
        "ezequiel@collabora.com" <ezequiel@collabora.com>,
        "marc.w.gonzalez@free.fr" <marc.w.gonzalez@free.fr>,
        "robh@kernel.org" <robh@kernel.org>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        Abel Vesa <abel.vesa@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH 1/2] soc: imx-sc: add i.MX system controller soc driver
 support
Message-ID: <20190421073958.GC19962@dragon>
References: <1554965048-19450-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1554965048-19450-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 11, 2019 at 06:49:12AM +0000, Anson Huang wrote:
> i.MX8QXP is an ARMv8 SoC which has a Cortex-M4 system controller
> inside, the system controller is in charge of controlling power,
> clock and fuse etc..
> 
> This patch adds i.MX system controller soc driver support,
> Linux kernel has to communicate with system controller via MU
> (message unit) IPC to get soc revision, uid etc..
> 
> With this patch, soc info can be read from sysfs:
> 
> i.mx8qxp-mek# cat /sys/devices/soc0/family
> Freescale i.MX
> 
> i.mx8qxp-mek# cat /sys/devices/soc0/soc_id
> i.MX8QXP
> 
> i.mx8qxp-mek# cat /sys/devices/soc0/machine
> Freescale i.MX8QXP MEK
> 
> i.mx8qxp-mek# cat /sys/devices/soc0/revision
> 1.1
> 
> i.mx8qxp-mek# cat /sys/devices/soc0/soc_uid
> 7B64280B57AC1898
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  drivers/soc/imx/Kconfig      |   7 ++
>  drivers/soc/imx/Makefile     |   1 +
>  drivers/soc/imx/soc-imx-sc.c | 220 +++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 228 insertions(+)
>  create mode 100644 drivers/soc/imx/soc-imx-sc.c

Rather than creating a new driver, please take a look at Abel's generic
i.MX8 SoC driver, and see if it can be extended to cover i.MX8QXP.

Shawn
