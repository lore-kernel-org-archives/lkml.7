Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B37B7C32792
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 11:02:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AFA821920
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 11:02:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="OqIAvAlJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730922AbfI3LCk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 07:02:40 -0400
Received: from mail.andi.de1.cc ([85.214.55.253]:32980 "EHLO mail.andi.de1.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730759AbfI3LCj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 07:02:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=4Q2eQSaoD2aHtt1rANXm2Cc6hpmxzVEktPN68KNFqac=; b=OqIAvAlJtHFC+dzBE4XSIO2Ve+
        +GF+kIQuQrXylq0OprfQ77TKbeo5rWyzgbD8EIYC5kpQqJeAxgHlMkqrqqWqxjKj1qgHYWMxv1OKZ
        V+PRUS55Nlw9YUBiwvNrZq7FEJ9FCX8dsBLKX5upiljQVbxbkVaBHoGK2vmqsl1uaaCM=;
Received: from p200300ccff0b4c001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff0b:4c00:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1iEtRf-0007ix-TS; Mon, 30 Sep 2019 13:02:24 +0200
Date:   Mon, 30 Sep 2019 13:02:22 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, manivannan.sadhasivam@linaro.org,
        andrew.smirnov@gmail.com, marex@denx.de, angus@akkea.ca,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, j.neuschaefer@gmx.net,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>
Subject: Re: [PATCH 1/3] ARM: dts: add Netronix E60K02 board common file
Message-ID: <20190930130222.4e1cdf64@aktux>
In-Reply-To: <20190930082715.mplf5ra35ikqmbyr@pengutronix.de>
References: <20190927061423.17278-1-andreas@kemnade.info>
        <20190927061423.17278-2-andreas@kemnade.info>
        <20190927094721.w26ggnli4f5a64uv@pengutronix.de>
        <20190927210807.26439a94@aktux>
        <20190930082715.mplf5ra35ikqmbyr@pengutronix.de>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Sep 2019 10:27:15 +0200
Marco Felsch <m.felsch@pengutronix.de> wrote:

[..]
> > so you disagree with this pattern:
> > in .dtsi
> >  some_device {
> >    pinctrl-0 = <&pinctrl_some_device>;
> >  };
> > 
> > and in .dts (one I sent with this patch series and the tolino/mx6sl one
> > is not ready-cooked yet, will be part of a later series)
> > &iomuxc {
> >    pinctrl_some_device: some_devicegrp {
> >    	fsl,pins = <...>;
> >    };
> > };
> > 
> > ?  
> 
> Yes, because IMHO a dtsi is self contained as well as a dts. If it is
> common for all boards you can move the muxing into the dtsi else it
> should be done within the dts.
> 
well, since imx6sll-pinfunc.h is different than imx6sl-pinfunc.h,
we agree that this belongs to the dts.

> > > > +&snvs_rtc {
> > > > +	status = "disabled";    
> > > 
> > > Same applies here.
> > >   
> > 
> > No, seems to be an exception, it does not have a status = "disabled" in
> > imx6sll.dtsi.  
> 
> Did you mean 6sll or 6ull?
> 
> Okay, is this baseboard only used with a 6ull?
> 

MCIMX6V7DVN10AB and MCIMX6L8DVN10AB
So it is 6sll and 6sl (6sl support will be added in a follow-up patch
series). 

I will send a v2 this evening, so we can all look at better-sorted
things.

Regards,
Andreas
