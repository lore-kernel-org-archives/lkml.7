Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 255B5C47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 07:42:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F341A2064A
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 07:42:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="czOrRXCD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727732AbfJKHmA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 03:42:00 -0400
Received: from mail.andi.de1.cc ([85.214.55.253]:43662 "EHLO mail.andi.de1.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727068AbfJKHmA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 03:42:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=IoXlssjG1luXMNpP9iA7nYasHU7jHnQgpQnqZCdm4Qo=; b=czOrRXCDzFObju9ojt2G06iQ+3
        cUQUvK2zXFw6UP/ainnCbMNd2CAZaKTfSPfWTt5EpMustJkIeBPrnpEnlZVf/+9HTepP/TQSmdHxp
        AXeihDs1ceh5g+L3G1t+eOFKW1jC2D0S2KEnn+Pc3paPKAXA6X+rprYAaeC1VKMKl4ek=;
Received: from p200300ccff0b9e001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff0b:9e00:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1iIpYb-0001YV-Rx; Fri, 11 Oct 2019 09:41:50 +0200
Date:   Fri, 11 Oct 2019 09:41:48 +0200
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
Subject: Re: [PATCH v3 2/3] ARM: dts: add Netronix E60K02 board common file
Message-ID: <20191011094148.1376430e@aktux>
In-Reply-To: <20191011065609.6irap7elicatmsgg@pengutronix.de>
References: <20191010192357.27884-1-andreas@kemnade.info>
        <20191010192357.27884-3-andreas@kemnade.info>
        <20191011065609.6irap7elicatmsgg@pengutronix.de>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Oct 2019 08:56:09 +0200
Marco Felsch <m.felsch@pengutronix.de> wrote:

> Hi Andreas,
> 
> On 19-10-10 21:23, Andreas Kemnade wrote:
> > The Netronix board E60K02 can be found some several Ebook-Readers,
> > at least the Kobo Clara HD and the Tolino Shine 3. The board
> > is equipped with different SoCs requiring different pinmuxes.
> > 
> > For now the following peripherals are included:
> > - LED
> > - Power Key
> > - Cover (gpio via hall sensor)
> > - RC5T619 PMIC (the kernel misses support for rtc and charger
> >   subdevices).
> > - Backlight via lm3630a
> > - Wifi sdio chip detection (mmc-powerseq and stuff)
> > 
> > It is based on vendor kernel but heavily reworked due to many
> > changed bindings.
> > 
> > Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> > ---
> > Changes in v3:
> > - better led name
> > - correct memory size
> > - comments about missing devices
> > 
> > Changes in v2:
> > - reordered, was 1/3
> > - moved pinmuxes to their actual users, not the parents
> >   of them
> > - removed some already-disabled stuff
> > - minor cleanups  
> 
> You won't change the muxing, so a this dtsi can be self contained?
> 
So you want me to put a big 
#if defined(MX6SLL) 
[...]
             pinctrl_i2c1: i2c1grp {
                        fsl,pins = <
                                MX6SLL_PAD_I2C1_SCL__I2C1_SCL    0x4001f8b1
                                MX6SLL_PAD_I2C1_SDA__I2C1_SDA    0x4001f8b1
                        >;
                };

#elif (MX6SL)
[...]
               pinctrl_i2c1: i2c1grp {
                        fsl,pins = <
                                MX6SL_PAD_I2C1_SCL__I2C1_SCL     0x4001f8b1
                                MX6SL_PAD_I2C1_SDA__I2C1_SDA     0x4001f8b1
                        >;
                };

#endif
in the dtsi?

Regards,
Andreas
