Return-Path: <SRS0=qvRn=2F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC9EAC2D0CB
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Dec 2019 08:29:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9404324654
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Dec 2019 08:29:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726099AbfLOI3W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Dec 2019 03:29:22 -0500
Received: from asavdk3.altibox.net ([109.247.116.14]:52228 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbfLOI3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Dec 2019 03:29:22 -0500
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id C5EEA20028;
        Sun, 15 Dec 2019 09:29:17 +0100 (CET)
Date:   Sun, 15 Dec 2019 09:29:16 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Cc:     thierry.reding@gmail.com, mark.rutland@arm.com,
        devicetree@vger.kernel.org,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        robh+dt@kernel.org, christoph.muellner@theobroma-systems.com
Subject: Re: [PATCH 3/3] drm/panel: add panel driver for Xinpeng XPP055C272
 panels
Message-ID: <20191215082916.GA25772@ravnborg.org>
References: <20191209144208.4863-1-heiko@sntech.de>
 <20191209144208.4863-3-heiko@sntech.de>
 <20191214081730.GC22818@ravnborg.org>
 <2272108.TFxdGdtKl4@diego>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2272108.TFxdGdtKl4@diego>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=eMA9ckh1 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10
        a=B31p6XxBGmTHbxNlXPsA:9 a=CjuIK1q_8ugA:10 a=Z5ABNNGmrOfJ6cZ5bIyy:22
        a=SsAZrZ5W_gNWK9tOzrEV:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heiko.

> Am Samstag, 14. Dezember 2019, 09:17:30 CET schrieb Sam Ravnborg:
> > > +#define dsi_generic_write_seq(dsi, cmd, seq...) do {			\
> > > +		static const u8 d[] = { seq };				\
> > > +		int ret;						\
> > > +		ret = mipi_dsi_dcs_write(dsi, cmd, d, ARRAY_SIZE(d));	\
> > > +		if (ret < 0)						\
> > > +			return ret;					\
> > > +	} while (0)
> > This macro return an error code if a write fails.
> > 
> > > +
> > > +static int xpp055c272_init_sequence(struct xpp055c272 *ctx)
> > > +{
> > > +	struct mipi_dsi_device *dsi = to_mipi_dsi_device(ctx->dev);
> > > +	struct device *dev = ctx->dev;
> > > +	int ret;
> > > +
> > > +	/*
> > > +	 * Init sequence was supplied by the panel vendor without much
> > > +	 * documentation.
> > > +	 */
> > > +	dsi_generic_write_seq(dsi, XPP055C272_CMD_SETEXTC, 0xf1, 0x12, 0x83);
> > But all uses of the macro here ignore the error.
> 
> hmm, am I way off track here?
> 
> 	dsi_generic_write_seq(dsi, XPP055C272_CMD_SETEXTC, 0xf1, 0x12, 0x83);
> 	dsi_generic_write_seq(dsi, XPP055C272_CMD_SETMIPI,
> 			      0x33, 0x81, 0x05, 0xf9, 0x0e, 0x0e, 0x00, 0x00,
> 			      0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x44, 0x25,
> 			      0x00, 0x91, 0x0a, 0x00, 0x00, 0x02, 0x4f, 0x01,
> 			      0x00, 0x00, 0x37);
> 	...
> 
> should just expand to
> 
> do {
> 		static const u8 d[] = { 0xf1, 0x12, 0x83 };
> 		int ret;
> 		ret = mipi_dsi_dcs_write(dsi, XPP055C272_CMD_SETEXTC, d, ARRAY_SIZE(d));
> 		if (ret < 0)
> 			return ret;
> } while (0)
> do {
> 		static const u8 d[] = { 0x33, 0x81, 0x05, 0xf9, 0x0e, 0x0e, 0x00, 0x00,
> 			      0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x44, 0x25,
> 			      0x00, 0x91, 0x0a, 0x00, 0x00, 0x02, 0x4f, 0x01,
> 			      0x00, 0x00, 0x37 };
> 		int ret;
> 		ret = mipi_dsi_dcs_write(dsi, XPP055C272_CMD_SETMIPI, d, ARRAY_SIZE(d));
> 		if (ret < 0)
> 			return ret;
> } while (0)
> ...
> 
> so every write instance will actually return an error if it happens and not
> continue on with the next init item.
The idea was that if a write returned an error then do not even attempt
more writes. So if a write fails we do not loose the original error
code, assuming subsequent write would also fail.

I have looked through all the panel drivers now, and the majority does
not check if the write goes wrong.
So following the pattern on the other panels you can also decide to just
ignore the return value of mipi_dsi_dcs_write() rahter than trying to
invent the check I tried to explain.

	Sam
