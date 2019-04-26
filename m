Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B489C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 20:14:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45D6F20869
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 20:14:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ucQZ1YVz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbfDZUOZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 16:14:25 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:43544 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbfDZUOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 16:14:25 -0400
Received: by mail-pl1-f195.google.com with SMTP id n8so2052300plp.10;
        Fri, 26 Apr 2019 13:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wCQ/z+XGfQ5EHjyqddQsAaUdNxDT8ar3CR3uERib6/g=;
        b=ucQZ1YVzRBzyFMisHTaE4gyEJySzw2434kcTLemEkVpgviaP5L40T0s0lwsyizl95M
         P1pfiXhjuuhq3PIZZjDuyE1gPgOrhHQGwNV1wXzETdEfG4wlxnPsdSSALILVrjoX3SHH
         cflmus+LiV1M4+ugEa68N/MRO7M+17rRQ2+QU7/N72icCPVOWaAS7rAilaifRu5jyRLx
         8Q/e9jMmoKWJwrL7C6OCP5W7yWbkrLpnTpsIKSNytcv1Z49QScbEC52ONPrQ+6WQoq6E
         MZhAIXJaNQf8j8+T5GZ7MvFGpk7QsX8Y4QigIqPQlGoPI8oLIhEGAcOvHUNb668Z005J
         CArg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=wCQ/z+XGfQ5EHjyqddQsAaUdNxDT8ar3CR3uERib6/g=;
        b=fD15O83QrvuYG+WBAl0KlZ/CTq2quUWo+MlbLif31USKbeYsHHdLyFaHh2/Oaoq8Wa
         XG3kkhb1TM7ZLx/IZASq3i37TGNRddeBpfo6ut/CS4MQTlE0RVGpt9RDmfpySYUJtreo
         aI+UQW3SaEsvyV4oP/Nvk4tqoBcZBrFJsN94o3IEQ8/ZQWj+w7ZnSEt5eIc70Mxcxk0G
         hQrxanIbuMKEgw7rV7Ln42FfwbTIRh3AgGazNMF2imrgGGUhy8/vOnUw/6uAUACykRMC
         3nCiHUdOmFuu286rqYVQ6kG4Bk1qYMW9R6fbaUlKlNps709ulseqA2UwZUueAWq7diMg
         yW7g==
X-Gm-Message-State: APjAAAV1wF1thB7cPFAzpZgRW+5XSYnGZ1N4opCiSWicq/OkwP+cy9yv
        l/fcwT6OvC7OwMbt8TkEzOM=
X-Google-Smtp-Source: APXvYqyQHha55RlAzTVKzB2306QasdZv3Yv9BfaO1tIADYCPWsbMKPvR2peGBXerqk7XcfDxNRBCqw==
X-Received: by 2002:a17:902:4a0c:: with SMTP id w12mr31304602pld.52.1556309664307;
        Fri, 26 Apr 2019 13:14:24 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o9sm19098426pgh.68.2019.04.26.13.14.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Apr 2019 13:14:23 -0700 (PDT)
Date:   Fri, 26 Apr 2019 13:14:21 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH 1/2] firmware: imx: SCU irq should ONLY be enabled after
 SCU IPC is ready
Message-ID: <20190426201421.GA21075@roeck-us.net>
References: <1556154581-31890-1-git-send-email-Anson.Huang@nxp.com>
 <4a89a37c-fc7b-3248-4cc3-ae232ab310b7@roeck-us.net>
 <DB3PR0402MB39163FEF47E9D59FC2D78EB3F53D0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB3PR0402MB39163FEF47E9D59FC2D78EB3F53D0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 25, 2019 at 06:51:11AM +0000, Anson Huang wrote:
> Hi, Guenter
> 
> > -----Original Message-----
> > From: Guenter Roeck [mailto:groeck7@gmail.com] On Behalf Of Guenter
> > Roeck
> > Sent: Thursday, April 25, 2019 10:15 AM
> > To: Anson Huang <anson.huang@nxp.com>; shawnguo@kernel.org;
> > s.hauer@pengutronix.de; kernel@pengutronix.de; festevam@gmail.com;
> > wim@linux-watchdog.org; Aisheng Dong <aisheng.dong@nxp.com>; linux-
> > arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org; linux-
> > watchdog@vger.kernel.org
> > Cc: dl-linux-imx <linux-imx@nxp.com>
> > Subject: Re: [PATCH 1/2] firmware: imx: SCU irq should ONLY be enabled
> > after SCU IPC is ready
> > 
> > On 4/24/19 6:14 PM, Anson Huang wrote:
> > > The imx_scu_irq_group_enable() is normally called during module driver
> > > probe phase to enable SCU group irq, e.g., i.MX system controller
> > > watchdog driver will call it during its driver probe phase, as i.MX
> > > system controller watchdog driver does NOT need SCU IPC handle for
> > > operations, so it could be probed before i.MX SCU IPC is ready, and
> > > below dump will show out:
> > >
> > > [    0.933001] Hardware name: Freescale i.MX8QXP MEK (DT)
> > > [    0.938129] pstate: 60000005 (nZCv daif -PAN -UAO)
> > > [    0.942907] pc : imx_scu_call_rpc+0x114/0x158
> > > [    0.947251] lr : imx_scu_irq_group_enable+0x74/0xc4
> > > [    0.952113] sp : ffff00001005bae0
> > > [    0.955415] x29: ffff00001005bae0 x28: ffff0000111bb0a0
> > > [    0.960712] x27: ffff00001140b000 x26: ffff00001111068c
> > > [    0.966011] x25: ffff0000111bb100 x24: 0000000000000000
> > > [    0.971311] x23: ffff0000113d9cd8 x22: 0000000000000001
> > > [    0.976610] x21: 0000000000000001 x20: ffff80083b51a410
> > > [    0.981909] x19: ffff000011259000 x18: 0000000000000480
> > > [    0.987209] x17: 000000000023ffb8 x16: 0000000000000010
> > > [    0.992508] x15: 000000000000023f x14: ffffffffffffffff
> > > [    0.997807] x13: 0000000000000018 x12: 0000000000000030
> > > [    1.003107] x11: 0000000000000003 x10: 0101010101010101
> > > [    1.008406] x9 : ffffffffffffffff x8 : 7f7f7f7f7f7f7f7f
> > > [    1.013706] x7 : fefefeff646c606d x6 : 0000000000000000
> > > [    1.019005] x5 : ffff0000112596c8 x4 : 0000000000000008
> > > [    1.024304] x3 : 0000000000000003 x2 : 0000000000000001
> > > [    1.029604] x1 : ffff00001005bb58 x0 : 0000000000000000
> > > [    1.034905] Call trace:
> > > [    1.037341]  imx_scu_call_rpc+0x114/0x158
> > > [    1.041334]  imx_scu_irq_group_enable+0x74/0xc4
> > > [    1.045856]  imx_sc_wdt_probe+0x24/0x150
> > > [    1.049766]  platform_drv_probe+0x4c/0xb0
> > > [    1.053762]  really_probe+0x1f8/0x2c8
> > > [    1.057407]  driver_probe_device+0x58/0xfc
> > > [    1.061490]  device_driver_attach+0x68/0x70
> > > [    1.065660]  __driver_attach+0x94/0xdc
> > > [    1.069397]  bus_for_each_dev+0x64/0xc0
> > > [    1.073220]  driver_attach+0x20/0x28
> > > [    1.076782]  bus_add_driver+0x148/0x1fc
> > > [    1.080601]  driver_register+0x68/0x120
> > > [    1.084424]  __platform_driver_register+0x4c/0x54
> > > [    1.089120]  imx_sc_wdt_driver_init+0x18/0x20
> > > [    1.093463]  do_one_initcall+0x58/0x1b8
> > > [    1.097287]  kernel_init_freeable+0x1cc/0x288
> > > [    1.101630]  kernel_init+0x10/0x100
> > > [    1.105101]  ret_from_fork+0x10/0x18
> > > [    1.108669] ---[ end trace 9e03302114457de9 ]---
> > > [    1.113296] enable irq failed, group 1, mask 1, ret -22
> > >
> > > To avoid such scenario, return -EPROBE_DEFER in
> > > imx_scu_irq_group_enable() API if SCU IPC is NOT ready, then module
> > > driver which calls this API in probe phase will defer probe after SCU IPC
> > ready.
> > >
> > Difficult to comment - I seem to have missed the patch introducing the call to
> > imx_scu_irq_group_enable() from the watchdog driver, and I don't see it in -
> > next either.
> > 
> > However, as far as I can see, imx_sc_irq_ipc_handle is initialized from
> > imx_scu_probe(). If the watchdog driver depends on it, it should be a sub-
> > node of fsl,imx-scu, and be instantiated from the call to
> > devm_of_platform_populate() in imx_scu_probe(). This should make the
> > EPROBE_DEFER unnecessary.
> > 
> > In other words, the above statement "i.MX system controller watchdog
> > driver does NOT need SCU IPC handle for operations" is no longer accurate.
> > If it needs the interrupt, and the interrupt needs the IPC handle, the
> > watchdog driver does require the IPC handle. It would otherwise not need to
> > defer its probe function until the IPC handle is available.
> > 
> > I would like to add that it is highly unusual for a watchdog driver to depend
> > on a firmware driver. However, again, that is difficult to argue since I seem to
> > have missed the patch series introducing that dependency.
> 
> I agreed watchdog should be a sub-node of SCU if it depends ON it, but as this API is
> exposed, I think adding such check is necessary, we do NOT know when this API could
> be called, so this protection should be necessary, it is just because I met this issue
> during adding pretimeout function of i.MX SC wdog, so I put the patches together.
> 
I agree that the check is necessary for imx_scu_irq_group_enable().
But the watchdog driver should still only be instantiated after
(or, rather, from) its parent driver since that is now the well
defined initialization order.

Guenter

> Thanks,
> Anson
> 
> > 
> > Guenter
> > 
> > > Fixes: 851826c7566e ("firmware: imx: enable imx scu general irq
> > > function")
> > > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> > > ---
> > >   drivers/firmware/imx/imx-scu-irq.c | 3 +++
> > >   1 file changed, 3 insertions(+)
> > >
> > > diff --git a/drivers/firmware/imx/imx-scu-irq.c
> > > b/drivers/firmware/imx/imx-scu-irq.c
> > > index 043833a..687121f 100644
> > > --- a/drivers/firmware/imx/imx-scu-irq.c
> > > +++ b/drivers/firmware/imx/imx-scu-irq.c
> > > @@ -100,6 +100,9 @@ int imx_scu_irq_group_enable(u8 group, u32 mask,
> > u8 enable)
> > >   	struct imx_sc_rpc_msg *hdr = &msg.hdr;
> > >   	int ret;
> > >
> > > +	if (!imx_sc_irq_ipc_handle)
> > > +		return -EPROBE_DEFER;
> > > +
> > >   	hdr->ver = IMX_SC_RPC_VERSION;
> > >   	hdr->svc = IMX_SC_RPC_SVC_IRQ;
> > >   	hdr->func = IMX_SC_IRQ_FUNC_ENABLE;
> > >
> 
