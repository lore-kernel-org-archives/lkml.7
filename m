Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 574B7C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 17:22:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3771E20717
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 17:22:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727328AbfLRRWN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 12:22:13 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:35596 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727174AbfLRRWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 12:22:12 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: ezequiel)
        with ESMTPSA id 7A82628B855
Message-ID: <980c181ad15153ee0af4ea20ac2a7265cd2b56f1.camel@collabora.com>
Subject: Re: [PATCH v21 2/2] drm/bridge: Add I2C based driver for ps8640
 bridge
From:   Ezequiel Garcia <ezequiel@collabora.com>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-kernel@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>
Cc:     Collabora Kernel ML <kernel@collabora.com>, matthias.bgg@gmail.com,
        drinkcat@chromium.org, hsinyi@chromium.org,
        Jitao Shi <jitao.shi@mediatek.com>,
        Daniel Kurtz <djkurtz@chromium.org>,
        Ulrich Hecht <uli@fpond.eu>,
        linux-arm-kernel@lists.infradead.org,
        Andrzej Hajda <a.hajda@samsung.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        dri-devel@lists.freedesktop.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-mediatek@lists.infradead.org,
        David Airlie <airlied@linux.ie>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Daniel Vetter <daniel@ffwll.ch>
Date:   Wed, 18 Dec 2019 14:22:00 -0300
In-Reply-To: <9e38774d-0028-6988-1be1-2e726c5ed4ab@collabora.com>
References: <20191216135834.27775-1-enric.balletbo@collabora.com>
         <20191216135834.27775-3-enric.balletbo@collabora.com>
         <bb97505cfadae364afa14605793affe4a7d69ffa.camel@collabora.com>
         <9e38774d-0028-6988-1be1-2e726c5ed4ab@collabora.com>
Organization: Collabora
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-12-18 at 16:21 +0100, Enric Balletbo i Serra wrote:
> Hi Ezequiel,
> 
> Many thanks for the review, I am just preparing the next version to send.
> 
[..]
> > > +
> > > +#define PAGE1_VSTART		0x6b
> > > +#define PAGE2_SPI_CFG3		0x82
> > > +#define I2C_TO_SPI_RESET	0x20
> > > +#define PAGE2_ROMADD_BYTE1	0x8e
> > > +#define PAGE2_ROMADD_BYTE2	0x8f
> > > +#define PAGE2_SWSPI_WDATA	0x90
> > > +#define PAGE2_SWSPI_RDATA	0x91
> > > +#define PAGE2_SWSPI_LEN		0x92
> > > +#define PAGE2_SWSPI_CTL		0x93
> > > +#define TRIGGER_NO_READBACK	0x05
> > > +#define TRIGGER_READBACK	0x01
> > > +#define PAGE2_SPI_STATUS	0x9e
> > > +#define SPI_READY		0x0c
> > > +#define PAGE2_GPIO_L		0xa6
> > > +#define PAGE2_GPIO_H		0xa7
> > > +#define PS_GPIO9		BIT(1)
> > > +#define PAGE2_IROM_CTRL		0xb0
> > > +#define IROM_ENABLE		0xc0
> > > +#define IROM_DISABLE		0x80
> > > +#define PAGE2_SW_RESET		0xbc
> > > +#define SPI_SW_RESET		BIT(7)
> > > +#define MPU_SW_RESET		BIT(6)
> > > +#define PAGE2_ENCTLSPI_WR	0xda
> > > +#define PAGE2_I2C_BYPASS	0xea
> > > +#define I2C_BYPASS_EN		0xd0
> > > +#define PAGE2_MCS_EN		0xf3
> > > +#define MCS_EN			BIT(0)
> > > +#define PAGE3_SET_ADD		0xfe
> > > +#define PAGE3_SET_VAL		0xff
> > > +#define VDO_CTL_ADD		0x13
> > > +#define VDO_DIS			0x18
> > > +#define VDO_EN			0x1c
> > > +#define PAGE4_REV_L		0xf0
> > > +#define PAGE4_REV_H		0xf1
> > > +#define PAGE4_CHIP_L		0xf2
> > > +#define PAGE4_CHIP_H		0xf3
> > > +
> > > +#define PAGE0_DP_CNTL		0
> > 
> > Unused macro.
> > 
> > > +#define PAGE1_VDO_BDG		1
> > > +#define PAGE2_TOP_CNTL		2
> > > +#define PAGE3_DSI_CNTL1		3
> > > +#define PAGE4_MIPI_PHY		4
> > 
> > Ditto... maybe others as well?
> > 
> 
> I removed all the unused macros.
> 

In this case, given these PAGEX_XXX refer
to the I2C ancillaries, maybe you can leave them.

Moreover, I'd put them in an enum, to emphasize
their relationship.

Regards,
Ezequiel

