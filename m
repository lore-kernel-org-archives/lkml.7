Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46B85C10F00
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 15:47:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22CFB218A5
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 15:47:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728522AbfCUPrO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 11:47:14 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:34179 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728497AbfCUPrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 11:47:14 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1h6zuP-0001Mm-Em; Thu, 21 Mar 2019 16:47:09 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1h6zuO-0007Z6-57; Thu, 21 Mar 2019 16:47:08 +0100
Date:   Thu, 21 Mar 2019 16:47:08 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        Robin Gong <yibin.gong@nxp.com>,
        "schnitzeltony@gmail.com" <schnitzeltony@gmail.com>,
        "otavio@ossystems.com.br" <otavio@ossystems.com.br>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "jan.tuerk@emtrion.com" <jan.tuerk@emtrion.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "stefan@agner.ch" <stefan@agner.ch>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH V8 2/5] pwm: Add i.MX TPM PWM driver support
Message-ID: <20190321154708.riet2mzmif2b7hw6@pengutronix.de>
References: <1553128960-17923-1-git-send-email-Anson.Huang@nxp.com>
 <1553128960-17923-3-git-send-email-Anson.Huang@nxp.com>
 <20190321091950.tkzem7cbgvtynr5m@pengutronix.de>
 <DB3PR0402MB3916CE06E6EF103470915905F5420@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <20190321104112.xits5qgk7tsuhdps@pengutronix.de>
 <DB3PR0402MB3916094B2F7A4D878785C676F5420@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <20190321134212.hypmz4enz7z5wamg@pengutronix.de>
 <DB3PR0402MB39162604F6C2D57FBD56E884F5420@DB3PR0402MB3916.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DB3PR0402MB39162604F6C2D57FBD56E884F5420@DB3PR0402MB3916.eurprd04.prod.outlook.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Thu, Mar 21, 2019 at 02:53:06PM +0000, Anson Huang wrote:
> > Reading through the reference manual I noticed that there might be a
> > stall: If you write two values to CnV the second write is ignored if the first
> > wasn't latched yet. That might mean that you cannot release the mutex
> > before the newly configured state is active. This is related to the request to
> > not let .apply return before the configured state is active, but I didn't thought
> > this to an end what the real consequences have to be.
> 
> The reference manual says the register is NOT updated until the current period finished
> If counter is running, so I added below check for both period update and duty update, we
> Can just wait the register value read matches what we write:
> 
> Period update:
>          writel(p->mod, tpm->base + PWM_IMX_TPM_MOD);
> 
>          /* make sure MOD register is updated */
>          timeout = jiffies + msecs_to_jiffies(tpm->real_period /
>                                               NSEC_PER_MSEC + 1);
>          while (readl(tpm->base + PWM_IMX_TPM_MOD != p->mod)) {
>                  if (time_after(jiffies, timeout))
>                          return = -ETIME;
>                  cpu_relax();
>          }

Hmm, I'm not convinced. There are several things to keep in mind:

 a) you should try to update period and duty_cycle atomically, that is,
    the new values should get both active at the same time. So if the
    PWM is running and the first of the two parameters are written to
    the hardware, the second parameter must be written, too, before the
    current period ends.

 b) A write to CnV or MOD blocks further writes until the respective
    value is "updated" (which I think means "latched into the hardware's
    logic to take effect). So you need to make sure that when updating
    the parameters of a running PWM, you didn't already configure it
    since the current period started.

b) is automatically addressed if you only return from .apply() when the
new configuration is active and hold the mutex during that time.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
