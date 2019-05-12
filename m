Return-Path: <SRS0=t4ha=TM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC703C04AB1
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 01:38:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2F412184B
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 01:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557625106;
	bh=JkvU+KlkRvtgh/MsOJk6K2HSfkvE9ZydgyArarzhN90=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=y+xdS0IoI2b9+xonfZTgmhtyr3wS8C6H1h2sGsa85U1B8HBiCI1MxHW7pOA/xs1Nt
	 7TLgiRgK+2j1ML56JcZEdE6XG3buWLoyvECdoq//5pFUy7YCB/+qaV1ibg7zV5r9Dp
	 TF91nhnFNtpcG5X1E/EeLDfise8FMVGL78hYmlBY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbfELBiZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 May 2019 21:38:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:54214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726124AbfELBiZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 May 2019 21:38:25 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 956BE2183F;
        Sun, 12 May 2019 01:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557625103;
        bh=JkvU+KlkRvtgh/MsOJk6K2HSfkvE9ZydgyArarzhN90=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fMj4TkC6YrNwhvvCLWLm1CEW0uqhcQk0xjnHbs32i8WdsVkP737mSipnkh3ZWH7Vh
         mUD79y9XGMm6Nq5nLPYxE7GQPKrxBZ9lESFupDOJdbwAHv3+HgE3+TYh9RfNV4E1vZ
         c1cUhk6n5/dC0jwHxadf/Gl4Ygd/KswjL3ctRV0Y=
Date:   Sun, 12 May 2019 09:37:55 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH V2] firmware: imx: SCU irq should ONLY be enabled after
 SCU IPC is ready
Message-ID: <20190512013753.GN15856@dragon>
References: <1556420305-14680-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556420305-14680-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 28, 2019 at 03:03:12AM +0000, Anson Huang wrote:
> The imx_scu_irq_group_enable() is normally called during module driver
> probe phase to enable SCU group irq, if SCU IPC is NOT ready, below
> dump will show out:
> 
> [    0.933001] Hardware name: Freescale i.MX8QXP MEK (DT)
> [    0.938129] pstate: 60000005 (nZCv daif -PAN -UAO)
> [    0.942907] pc : imx_scu_call_rpc+0x114/0x158
> [    0.947251] lr : imx_scu_irq_group_enable+0x74/0xc4
> [    0.952113] sp : ffff00001005bae0
> [    0.955415] x29: ffff00001005bae0 x28: ffff0000111bb0a0
> [    0.960712] x27: ffff00001140b000 x26: ffff00001111068c
> [    0.966011] x25: ffff0000111bb100 x24: 0000000000000000
> [    0.971311] x23: ffff0000113d9cd8 x22: 0000000000000001
> [    0.976610] x21: 0000000000000001 x20: ffff80083b51a410
> [    0.981909] x19: ffff000011259000 x18: 0000000000000480
> [    0.987209] x17: 000000000023ffb8 x16: 0000000000000010
> [    0.992508] x15: 000000000000023f x14: ffffffffffffffff
> [    0.997807] x13: 0000000000000018 x12: 0000000000000030
> [    1.003107] x11: 0000000000000003 x10: 0101010101010101
> [    1.008406] x9 : ffffffffffffffff x8 : 7f7f7f7f7f7f7f7f
> [    1.013706] x7 : fefefeff646c606d x6 : 0000000000000000
> [    1.019005] x5 : ffff0000112596c8 x4 : 0000000000000008
> [    1.024304] x3 : 0000000000000003 x2 : 0000000000000001
> [    1.029604] x1 : ffff00001005bb58 x0 : 0000000000000000
> [    1.034905] Call trace:
> [    1.037341]  imx_scu_call_rpc+0x114/0x158
> [    1.041334]  imx_scu_irq_group_enable+0x74/0xc4
> [    1.045856]  imx_sc_wdt_probe+0x24/0x150
> [    1.049766]  platform_drv_probe+0x4c/0xb0
> [    1.053762]  really_probe+0x1f8/0x2c8
> [    1.057407]  driver_probe_device+0x58/0xfc
> [    1.061490]  device_driver_attach+0x68/0x70
> [    1.065660]  __driver_attach+0x94/0xdc
> [    1.069397]  bus_for_each_dev+0x64/0xc0
> [    1.073220]  driver_attach+0x20/0x28
> [    1.076782]  bus_add_driver+0x148/0x1fc
> [    1.080601]  driver_register+0x68/0x120
> [    1.084424]  __platform_driver_register+0x4c/0x54
> [    1.089120]  imx_sc_wdt_driver_init+0x18/0x20
> [    1.093463]  do_one_initcall+0x58/0x1b8
> [    1.097287]  kernel_init_freeable+0x1cc/0x288
> [    1.101630]  kernel_init+0x10/0x100
> [    1.105101]  ret_from_fork+0x10/0x18
> [    1.108669] ---[ end trace 9e03302114457de9 ]---
> [    1.113296] enable irq failed, group 1, mask 1, ret -22
> 
> To avoid such scenario, return -EPROBE_DEFER in imx_scu_irq_group_enable()
> API if SCU IPC is NOT ready, then module driver which calls this API
> in probe phase will defer probe after SCU IPC ready.
> 
> Fixes: 851826c7566e ("firmware: imx: enable imx scu general irq function")
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Looks good.  But please resend with no base64 encoding.

Shawn
