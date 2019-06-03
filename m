Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4F08C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 12:32:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1C0924204
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 12:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559565168;
	bh=nH7El9F5kOiagXyhzBVYhdnWSGsNuX6qBDg41snSmDs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mx9/DnvrLobMveSdlRcWRYzifT4ETGANKUPx4m3/Pb/M19E+LG2neGqDtj3/70lxI
	 UYh/qjwVIfrvmEvgvbyjjo1soCshdNupb4fysXhwDBxPf09fnCdMBgTR7eF1iaaahz
	 6PbMNt1vP5ROKPFTQkDD4i4eH3nbJ9QdYKtd28f8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727323AbfFCMcr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 08:32:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:42958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726270AbfFCMcr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 08:32:47 -0400
Received: from dragon (li1232-89.members.linode.com [45.79.133.89])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4405C26A31;
        Mon,  3 Jun 2019 12:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559565167;
        bh=nH7El9F5kOiagXyhzBVYhdnWSGsNuX6qBDg41snSmDs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k/BlXcMhrQvbfDVb3Rns/tjKuya+BuFBiSA0VusyE3Kq+8ab3qZQsmVQXufMv5piA
         GJu1alG/6SqCfX3OlRoYWSQSZcURZJl6NIBhX1hrYLjW/HCvFdS3Jt6mkqzC/bBNmt
         MwJBCSEXrkWQiwU5ttd7ObCaKAA7DEZ8uKuK2uaQ=
Date:   Mon, 3 Jun 2019 20:32:31 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "olof@lixom.net" <olof@lixom.net>,
        "agross@kernel.org" <agross@kernel.org>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "dinguyen@kernel.org" <dinguyen@kernel.org>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH V7 1/2] soc: imx: Add SCU SoC info driver support
Message-ID: <20190603123124.GB16651@dragon>
References: <1558662440-8820-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1558662440-8820-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2019 at 01:52:36AM +0000, Anson Huang wrote:
> Add i.MX SCU SoC info driver to support i.MX8QXP SoC, introduce
> driver dependency into Kconfig as CONFIG_IMX_SCU must be
> selected to support i.MX SCU SoC driver, also need to use
> platform driver model to make sure IMX_SCU driver is probed
> before i.MX SCU SoC driver.
> 
> With this patch, SoC info can be read from sysfs:
> 
> i.mx8qxp-mek# cat /sys/devices/soc0/family
> Freescale i.MX
> 
> i.mx8qxp-mek# cat /sys/devices/soc0/soc_id
> 0x2
> 
> i.mx8qxp-mek# cat /sys/devices/soc0/machine
> Freescale i.MX8QXP MEK
> 
> i.mx8qxp-mek# cat /sys/devices/soc0/revision
> 1.1
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> Reviewed-by: Abel Vesa <abel.vesa@nxp.com>
> Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>

Applied, thanks.
