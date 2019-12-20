Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B057C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 14:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CFA421655
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 14:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576851616;
	bh=e/P4Ykt81ttoicPomR1Xz3l4YIRD0OfZwgj/VUS8Tyo=;
	h=To:Subject:Date:From:Cc:In-Reply-To:References:List-ID:From;
	b=YuBW1xeOFg9jVpEyqvaM96vDfCQkH4gD2w6OBRlX9RtlWXgG+GSy7YGGdWn+GSgyX
	 Md+mAC1w8HIN6KmmOBV0zjnbtF7YLeyJsqsNkdDpjQmRD3mzvVP85gY4wVAwfqLHav
	 TelTPFca1+V9Hrn3pEQuoiV8B5iFH129GW3r14ro=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727401AbfLTOUP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 09:20:15 -0500
Received: from inca-roads.misterjones.org ([213.251.177.50]:48457 "EHLO
        inca-roads.misterjones.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727347AbfLTOUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 09:20:14 -0500
Received: from www-data by cheepnis.misterjones.org with local (Exim 4.80)
        (envelope-from <maz@kernel.org>)
        id 1iiJ8R-0006rT-NQ; Fri, 20 Dec 2019 15:20:07 +0100
To:     Joakim Zhang <qiangqing.zhang@nxp.com>
Subject: RE: [PATCH V3 2/2] drivers/irqchip: add NXP INTMUX interrupt  multiplexer support
X-PHP-Originating-Script: 0:main.inc
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 20 Dec 2019 14:20:07 +0000
From:   Marc Zyngier <maz@kernel.org>
Cc:     Lokesh Vutla <lokeshvutla@ti.com>, <tglx@linutronix.de>,
        <jason@lakedaemon.net>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <shawnguo@kernel.org>,
        <s.hauer@pengutronix.de>, Andy Duan <fugang.duan@nxp.com>,
        "S.j. Wang" <shengjiu.wang@nxp.com>,
        <linux-kernel@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>,
        <kernel@pengutronix.de>, <linux-arm-kernel@lists.infradead.org>
In-Reply-To: <DB7PR04MB4618B9A227807CCF884910C6E62D0@DB7PR04MB4618.eurprd04.prod.outlook.com>
References: <1576827431-31942-1-git-send-email-qiangqing.zhang@nxp.com>
 <1576827431-31942-3-git-send-email-qiangqing.zhang@nxp.com>
 <ad5165ba-24d7-ceeb-8794-cdbe4e564bd5@ti.com>
 <DB7PR04MB4618B9A227807CCF884910C6E62D0@DB7PR04MB4618.eurprd04.prod.outlook.com>
Message-ID: <8bc6bcf113cce13816c62c166f091785@www.loen.fr>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/0.7.2
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Rcpt-To: qiangqing.zhang@nxp.com, lokeshvutla@ti.com, tglx@linutronix.de, jason@lakedaemon.net, robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org, s.hauer@pengutronix.de, fugang.duan@nxp.com, shengjiu.wang@nxp.com, linux-kernel@vger.kernel.org, linux-imx@nxp.com, kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on cheepnis.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-12-20 14:10, Joakim Zhang wrote:
>> -----Original Message-----
>> From: Lokesh Vutla <lokeshvutla@ti.com>

[...]

>> Does the user care to which channel does the interrupt source goes 
>> to? If not,
>> interrupt-cells in DT can just be a single entry and the channel 
>> selection can be
>> controlled by the driver no? I am trying to understand why user 
>> should specify
>> the channel no.
> Hi Lokesh,
>
> If a fixed channel is specified in the driver, all interrupt sources
> will be connected to this channel, affecting the interrupt priority 
> to
> some extent.
>
> From my point of view, a fixed channel could be enough if don't care
> interrupt priority.

Hold on a sec:

Is the channel to which an interrupt is routed to programmable? What 
has
the priority of the interrupt to do with this? How does this affect
interrupt delivery?

It looks like this HW does more that you initially explained...

         M.
-- 
Jazz is not dead. It just smells funny...
