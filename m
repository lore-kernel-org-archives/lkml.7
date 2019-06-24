Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3895C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 02:27:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CDDE20674
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 02:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561343252;
	bh=ou2nDa4kNa8Pv4nkFnhiNPp3TzP3RXH/iQPlya1mB2s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=g0yl38/3M2NCV6bzGD2gHO2AFYax4+VZcHAYYwrHS3kBANYeUcJU6nvgVy+E1k8TD
	 xS7mspo65s6thCE8XSx801fOy8OxOYx2yLsgVKpgafaRWj6R6zG6Q06kQW53luz2Ot
	 P9myvGty0DDc/7K+XMWHrpwzt7exoaGMvwbC7C40=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727139AbfFXC1b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Jun 2019 22:27:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:50674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726334AbfFXC1b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jun 2019 22:27:31 -0400
Received: from dragon (li1322-146.members.linode.com [45.79.223.146])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E22FF20673;
        Mon, 24 Jun 2019 02:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561343250;
        bh=ou2nDa4kNa8Pv4nkFnhiNPp3TzP3RXH/iQPlya1mB2s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=l1Bkm9jZrS8R93bPW+8w45kq/C2uyFqIlhyY6U+jjclFujI+oqLsgfu9GIgQbspDa
         +v8wBGNfLcygxHfHmSIsyWr2pu31FOkLi+pAgPCTtEXThDoUZcb8ons8a0WNe/gaAv
         /xVPCMYtS1DjaV8NPq8ZJsJZACXKEDQTLd+WphCM=
Date:   Mon, 24 Jun 2019 10:27:14 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson.Huang@nxp.com
Cc:     mark.rutland@arm.com, aisheng.dong@nxp.com, peng.fan@nxp.com,
        festevam@gmail.com, ping.bai@nxp.com, devicetree@vger.kernel.org,
        sboyd@kernel.org, catalin.marinas@arm.com, s.hauer@pengutronix.de,
        linux-kernel@vger.kernel.org, daniel.baluta@nxp.com,
        linux-clk@vger.kernel.org, robh+dt@kernel.org, Linux-imx@nxp.com,
        kernel@pengutronix.de, leonard.crestez@nxp.com, will@kernel.org,
        mturquette@baylibre.com, linux-arm-kernel@lists.infradead.org,
        abel.vesa@nxp.com
Subject: Re: [PATCH 1/4] arm64: Enable TIMER_IMX_SYS_CTR for ARCH_MXC
 platforms
Message-ID: <20190624022713.GO3800@dragon>
References: <20190621070720.12395-1-Anson.Huang@nxp.com>
 <20190624022200.GN3800@dragon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190624022200.GN3800@dragon>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 24, 2019 at 10:22:01AM +0800, Shawn Guo wrote:
> On Fri, Jun 21, 2019 at 03:07:17PM +0800, Anson.Huang@nxp.com wrote:
> > From: Anson Huang <Anson.Huang@nxp.com>
> > 
> > ARCH_MXC platforms needs system counter as broadcast timer
> > to support cpuidle, enable it by default.
> > 
> > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> > ---
> >  arch/arm64/Kconfig.platforms | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
> > index 4778c77..f5e623f 100644
> > --- a/arch/arm64/Kconfig.platforms
> > +++ b/arch/arm64/Kconfig.platforms
> > @@ -173,6 +173,7 @@ config ARCH_MXC
> >  	select PM
> >  	select PM_GENERIC_DOMAINS
> >  	select SOC_BUS
> > +	select TIMER_IMX_SYS_CTR
> 
> Where is that driver?

Okay, just found it in the mailbox.  They seem to be sent in the wrong
order.  Really, you should send this series only after the driver lands
on mainline.

Shawn
