Return-Path: <SRS0=ebdT=SX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FB29C10F14
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Apr 2019 07:42:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5F8A20859
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Apr 2019 07:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555832537;
	bh=9FSqfsaaOvDnXhPjfgQ6ssV0b4vkshvgBx2j1Yv/trg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=vs6xdzf0dO5DvZu5zIezfITIT2aqwkSWDKooBkwFnYntAZjCGJXlGjvvIglmhbE10
	 N6z8RI2KRnPlNZoApDT8wx7VbT2sQDdOsGxZ8nWO6tZyZnSd3Xq8s2MfAiI2J2+fLQ
	 HrGZusnFMIW97e4RjMfVXLpVxYbHlhtfEFFE3Z9I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727178AbfDUHmQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Apr 2019 03:42:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:33054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725936AbfDUHmQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Apr 2019 03:42:16 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2AAC62087F;
        Sun, 21 Apr 2019 07:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555832535;
        bh=9FSqfsaaOvDnXhPjfgQ6ssV0b4vkshvgBx2j1Yv/trg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c8hIy7MUGwz6DvxiLzNwdq9sh52bM/SXDDcDZy1rVgyhc4CjJp3YGY76ki4mDSgvf
         QMKp3aVFhoX6fNEr3RggUJq8HjBXIGLn3Pkr8E+e9YUFg7D14kM95lMlbLKl10XEXi
         NkuccbSqpP6FFl4B1BGiBeTSE201Ui0RixzS+MVE=
Date:   Sun, 21 Apr 2019 15:41:54 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "stefan.wahren@i2se.com" <stefan.wahren@i2se.com>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "heiko@sntech.de" <heiko@sntech.de>,
        "marc.w.gonzalez@free.fr" <marc.w.gonzalez@free.fr>,
        "ezequiel@collabora.com" <ezequiel@collabora.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "olof@lixom.net" <olof@lixom.net>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>
Subject: Re: [PATCH 1/2] soc: imx-sc: add i.MX system controller soc driver
 support
Message-ID: <20190421074152.GD19962@dragon>
References: <1554965048-19450-1-git-send-email-Anson.Huang@nxp.com>
 <20190421073958.GC19962@dragon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190421073958.GC19962@dragon>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 21, 2019 at 03:40:00PM +0800, Shawn Guo wrote:
> On Thu, Apr 11, 2019 at 06:49:12AM +0000, Anson Huang wrote:
> > i.MX8QXP is an ARMv8 SoC which has a Cortex-M4 system controller
> > inside, the system controller is in charge of controlling power,
> > clock and fuse etc..
> > 
> > This patch adds i.MX system controller soc driver support,
> > Linux kernel has to communicate with system controller via MU
> > (message unit) IPC to get soc revision, uid etc..
> > 
> > With this patch, soc info can be read from sysfs:
> > 
> > i.mx8qxp-mek# cat /sys/devices/soc0/family
> > Freescale i.MX
> > 
> > i.mx8qxp-mek# cat /sys/devices/soc0/soc_id
> > i.MX8QXP
> > 
> > i.mx8qxp-mek# cat /sys/devices/soc0/machine
> > Freescale i.MX8QXP MEK
> > 
> > i.mx8qxp-mek# cat /sys/devices/soc0/revision
> > 1.1
> > 
> > i.mx8qxp-mek# cat /sys/devices/soc0/soc_uid
> > 7B64280B57AC1898
> > 
> > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> > ---
> >  drivers/soc/imx/Kconfig      |   7 ++
> >  drivers/soc/imx/Makefile     |   1 +
> >  drivers/soc/imx/soc-imx-sc.c | 220 +++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 228 insertions(+)
> >  create mode 100644 drivers/soc/imx/soc-imx-sc.c
> 
> Rather than creating a new driver, please take a look at Abel's generic
> i.MX8 SoC driver, and see if it can be extended to cover i.MX8QXP.

Forgot to give pointer to Abel's driver.

https://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git/commit/?h=imx/drivers&id=a7e26f356ca12906a164d83c9e9f8527ee7da022

Shawn
