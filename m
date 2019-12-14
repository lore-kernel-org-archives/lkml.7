Return-Path: <SRS0=X3/1=2E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15ABAC2D0CB
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Dec 2019 23:07:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9CAF2073D
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Dec 2019 23:07:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727091AbfLNXH5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Dec 2019 18:07:57 -0500
Received: from gloria.sntech.de ([185.11.138.130]:43282 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726803AbfLNXH5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Dec 2019 18:07:57 -0500
Received: from ip5f5a6266.dynamic.kabel-deutschland.de ([95.90.98.102] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1igGVq-00005i-Hi; Sun, 15 Dec 2019 00:07:50 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     thierry.reding@gmail.com, mark.rutland@arm.com,
        devicetree@vger.kernel.org,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        robh+dt@kernel.org, christoph.muellner@theobroma-systems.com
Subject: Re: [PATCH 3/3] drm/panel: add panel driver for Xinpeng XPP055C272 panels
Date:   Sun, 15 Dec 2019 00:07:49 +0100
Message-ID: <2272108.TFxdGdtKl4@diego>
In-Reply-To: <20191214081730.GC22818@ravnborg.org>
References: <20191209144208.4863-1-heiko@sntech.de> <20191209144208.4863-3-heiko@sntech.de> <20191214081730.GC22818@ravnborg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sam,

thanks for the thorough review :-)

Am Samstag, 14. Dezember 2019, 09:17:30 CET schrieb Sam Ravnborg:
> > +#define dsi_generic_write_seq(dsi, cmd, seq...) do {			\
> > +		static const u8 d[] = { seq };				\
> > +		int ret;						\
> > +		ret = mipi_dsi_dcs_write(dsi, cmd, d, ARRAY_SIZE(d));	\
> > +		if (ret < 0)						\
> > +			return ret;					\
> > +	} while (0)
> This macro return an error code if a write fails.
> 
> > +
> > +static int xpp055c272_init_sequence(struct xpp055c272 *ctx)
> > +{
> > +	struct mipi_dsi_device *dsi = to_mipi_dsi_device(ctx->dev);
> > +	struct device *dev = ctx->dev;
> > +	int ret;
> > +
> > +	/*
> > +	 * Init sequence was supplied by the panel vendor without much
> > +	 * documentation.
> > +	 */
> > +	dsi_generic_write_seq(dsi, XPP055C272_CMD_SETEXTC, 0xf1, 0x12, 0x83);
> But all uses of the macro here ignore the error.

hmm, am I way off track here?

	dsi_generic_write_seq(dsi, XPP055C272_CMD_SETEXTC, 0xf1, 0x12, 0x83);
	dsi_generic_write_seq(dsi, XPP055C272_CMD_SETMIPI,
			      0x33, 0x81, 0x05, 0xf9, 0x0e, 0x0e, 0x00, 0x00,
			      0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x44, 0x25,
			      0x00, 0x91, 0x0a, 0x00, 0x00, 0x02, 0x4f, 0x01,
			      0x00, 0x00, 0x37);
	...

should just expand to

do {
		static const u8 d[] = { 0xf1, 0x12, 0x83 };
		int ret;
		ret = mipi_dsi_dcs_write(dsi, XPP055C272_CMD_SETEXTC, d, ARRAY_SIZE(d));
		if (ret < 0)
			return ret;
} while (0)
do {
		static const u8 d[] = { 0x33, 0x81, 0x05, 0xf9, 0x0e, 0x0e, 0x00, 0x00,
			      0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x44, 0x25,
			      0x00, 0x91, 0x0a, 0x00, 0x00, 0x02, 0x4f, 0x01,
			      0x00, 0x00, 0x37 };
		int ret;
		ret = mipi_dsi_dcs_write(dsi, XPP055C272_CMD_SETMIPI, d, ARRAY_SIZE(d));
		if (ret < 0)
			return ret;
} while (0)
...

so every write instance will actually return an error if it happens and not
continue on with the next init item.

Or I'm not thinking correctly at 0:07 ;-)


Heiko


