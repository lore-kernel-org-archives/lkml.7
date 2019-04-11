Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 015FDC282CE
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 07:33:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFD1F21841
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 07:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554967992;
	bh=NCcfCY4N4CoHyMcW9kudU2EIXCOP7nfyguC23K4whBM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=pQr9EzzQgkbHOhUMS3CZk5RZEMycsb6wSxH8wO1qeVu4dJqIuetAqHhLdw9rskrQ9
	 H4x+gAXtWEB1MFBgptxfOI64OLl31WD7JAy9/k5ZAywQQXknR6g5MTTB4/dnB4vKXa
	 oRj3QfY6qQ/liwdYGDYTikr8W1yds7IpuWOALFB0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbfDKHdL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 03:33:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:58832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726137AbfDKHdL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 03:33:11 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6BCB520873;
        Thu, 11 Apr 2019 07:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554967990;
        bh=NCcfCY4N4CoHyMcW9kudU2EIXCOP7nfyguC23K4whBM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fLg83XbVn3lhiIZI/R6h2aaIxWbFA2famBGdUDi1kjAW43Nk7V1hIgNS8jb3QWMoG
         LKDSErJLle9BtIW1lr+BiP7N9kidEJKGu/IM2E+vZKA1DMUGcpLFl2MHIFNEoferTB
         hwwMc2RyVZmdm0Cq3Gj84JfVTkguiVpbgwxYc7q8=
Date:   Thu, 11 Apr 2019 15:32:53 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "sboyd@kernel.org" <sboyd@kernel.org>, Peng Fan <peng.fan@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH V7 2/4] firmware: imx: enable imx scu general irq function
Message-ID: <20190411073252.GC3050@dragon>
References: <1554785675-8090-1-git-send-email-Anson.Huang@nxp.com>
 <1554785675-8090-2-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1554785675-8090-2-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 09, 2019 at 04:59:55AM +0000, Anson Huang wrote:
> The System Controller Firmware (SCFW) controls RTC, thermal
> and WDOG etc., these resources' interrupt function are managed
> by SCU. When any IRQ pending, SCU will notify Linux via MU general
> interrupt channel #3, and Linux kernel needs to call SCU APIs
> to get IRQ status and notify each module to handle the interrupt.
> 
> Since there is no data transmission for SCU IRQ notification, so
> doorbell mode is used for this MU channel, and SCU driver will
> use notifier mechanism to broadcast to every module which registers
> the SCU block notifier.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>

Applied, thanks.
