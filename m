Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C0DAC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:25:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 651482063F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:25:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727388AbfCRJZY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 05:25:24 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:42171 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726691AbfCRJZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 05:25:23 -0400
X-Originating-IP: 90.88.22.102
Received: from localhost (aaubervilliers-681-1-80-102.w90-88.abo.wanadoo.fr [90.88.22.102])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 756D820004;
        Mon, 18 Mar 2019 09:25:20 +0000 (UTC)
Date:   Mon, 18 Mar 2019 10:25:19 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Chen-Yu Tsai <wens@kernel.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/6] nvmem: sunxi_sid: Read out data in native format
Message-ID: <20190318092519.g2rvdjiunti2ev7p@flea>
References: <20190318073354.12151-1-wens@kernel.org>
 <20190318073354.12151-5-wens@kernel.org>
 <20190318084212.lv2lorskizl65uzg@flea>
 <CAGb2v67H9FkjKjSE5a7fUCb_t95Zfuk1p0bjWYJxjMqhMN-hfg@mail.gmail.com>
 <20190318085751.kziqzxnadtho4kdb@flea>
 <CAGb2v64pq5V0_nZ7f0ZPwuNxNU8HbY0A6CqeC6TMd2z2xhJHwg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fgqxvk5pq25ezuac"
Content-Disposition: inline
In-Reply-To: <CAGb2v64pq5V0_nZ7f0ZPwuNxNU8HbY0A6CqeC6TMd2z2xhJHwg@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fgqxvk5pq25ezuac
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 18, 2019 at 05:09:44PM +0800, Chen-Yu Tsai wrote:
> On Mon, Mar 18, 2019 at 4:57 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> >
> > On Mon, Mar 18, 2019 at 04:45:19PM +0800, Chen-Yu Tsai wrote:
> > > On Mon, Mar 18, 2019 at 4:42 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> > > >
> > > > Hi,
> > > >
> > > > On Mon, Mar 18, 2019 at 03:33:52PM +0800, Chen-Yu Tsai wrote:
> > > > > From: Chen-Yu Tsai <wens@csie.org>
> > > > >
> > > > > Originally the SID e-fuses were thought to be in big-endian format.
> > > > > Later sources show that they are in fact native or little-endian.
> > > > > The most compelling evidence is the thermal sensor calibration data,
> > > > > which is a set of one to three 16-bit values. In native-endian they
> > > > > are in 16-bit cells with increasing offsets, whereas with big-endian
> > > > > they are in the wrong order, and a gap with no data will show if there
> > > > > are one or three cells.
> > > > >
> > > > > Switch to a native endian representation for the nvmem device. For the
> > > > > H3, the register read-out method was already returning data in native
> > > > > endian. This only affects the other SoCs.
> > > > >
> > > > > Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> > > >
> > > > I thought only the newer SoCs were impacted by this issue?
> > >
> > > It is noticable on the newer SoCs. The old ones only have the 128-bit SID,
> > > which could be read either way, as AFAIK it's just a serial number.
> > >
> > > If you think we should leave the old ones alone I can factor that in.
> >
> > IIRC, there was also the SoC ID in the SID on those SoCs as well,
> > which we might have to use in the future so we'll want to make sure it
> > is correct.
>
> We'll need to ask Allwinner about this then.
>
> FWIW, the fel command in sunxi-tools reads them out in little endian. I
> believe this and the SID page on the linux-sunxi wiki predate the sunxi_sid
> driver.

Yeah, and the driver has a readl as well:
https://github.com/linux-sunxi/linux-sunxi/blob/sunxi-3.4/arch/arm/plat-sunxi/soc-detect.c#L92

For the whole series,
Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--fgqxvk5pq25ezuac
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXI9j/wAKCRDj7w1vZxhR
xS7XAP9B2IrcCTutwMbeq6c6gSWtVaxQ8rvMhwZa9c93cMXH2wEAtHfL5acaNqfB
wZm7JMgJzsCxg6lUHmJNCLp/QtuOeAA=
=6OsT
-----END PGP SIGNATURE-----

--fgqxvk5pq25ezuac--
