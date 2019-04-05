Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B0F4C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 15:16:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F385F218A6
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 15:16:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731517AbfDEPQA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 11:16:00 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:33145 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726291AbfDEPP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 11:15:58 -0400
X-Originating-IP: 90.88.30.125
Received: from localhost (aaubervilliers-681-1-89-125.w90-88.abo.wanadoo.fr [90.88.30.125])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 56B7860010;
        Fri,  5 Apr 2019 15:15:53 +0000 (UTC)
Date:   Fri, 5 Apr 2019 17:15:52 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Nicolas Dufresne <nicolas.dufresne@collabora.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, Tomasz Figa <tfiga@chromium.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Alexandre Courbot <acourbot@chromium.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Pawel Osciak <posciak@chromium.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg 
        Roedel <joro@8bytes.org>," <linux-arm-kernel@lists.infradead.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Jens Kuske <jenskuske@gmail.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Guenter Roeck <groeck@chromium.org>
Subject: Re: [PATCH RESEND v7 1/2] media: uapi: Add H264 low-level decoder
 API compound controls.
Message-ID: <20190405151552.biesirbs35uivk7d@flea>
References: <cover.bfe197a82766125bea21dd26fd3de85893a921ac.1554380738.git-series.maxime.ripard@bootlin.com>
 <7cd913545cfc80fa9999839c62c4bf7b354a7904.1554380738.git-series.maxime.ripard@bootlin.com>
 <CAAFQd5ASMJL2_ovNeFOhCh2JoD86KMtV5XO+7OgM37ckxrxmfA@mail.gmail.com>
 <CAGb2v642__AF3iHO+d9FKazJ4=uRAQSfxAN_uCUWagH6Jz2twQ@mail.gmail.com>
 <c3ed6d00bf5642b1524ef4973f2db7ba6759fb6d.camel@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="t2qijco5lkwnrc7e"
Content-Disposition: inline
In-Reply-To: <c3ed6d00bf5642b1524ef4973f2db7ba6759fb6d.camel@collabora.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--t2qijco5lkwnrc7e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Nicolas,

On Thu, Apr 04, 2019 at 11:41:13AM -0400, Nicolas Dufresne wrote:
> > > > +    * - __u16
> > > > +      - ``pic_width_in_mbs_minus1``
> > > > +      -
> > > > +    * - __u16
> > > > +      - ``pic_height_in_map_units_minus1``
> > > > +      -
> > >
> > > We recently had some reflection with Alex that this is redundant with
> > > the width and height in the OUTPUT format. It may also apply to some
> > > other fields in these structs. I feel like they should be removed and
> > > passed via corresponding generic V4L2 properties - format, selection,
> > > etc.
> > >
> > > The same problem is also present in the MPEG2 controls. In fact, there
> > > was a patch already which used some fields from the controls to
> > > calculate the destination buffer strides, rather than bytesperline in
> > > the format.
> > >
> > > Since we're in staging, it could be done with a follow-up patch, though.
> >
> > Just my two cents. I played with some codecs a while back. IIRC some
> > specify a "codec" size in addition to the actual picture size, like
> > when the encoder does padding to fit the requirements of the codec
> > (spec). Is this needed anywhere?
>
> With state-less encoders, the headers, which contains the crop
> information is created by userspace and for state less decoder, the
> headers that contains this information is parsed by userspace. So I
> believe that in theory, the accelerator does not strictly need to be
> aware of the cropped dimensions.
>
> Another thing, is that there is not guarantied matches between e.g.
> depth of the chrome/luma and the final image buffers. Some hardware may
> have bandwidth limitation or internal converter and could possibly
> decode 10bit data into 8bit buffers.
>
> A third reason why I would not try and encode this header information
> is that there can be multiple PPS/SPS at the same time, and I think
> it's confusing if the relevant information to differentiate them is
> removed.

Sorry if that sounds a bit dumb, but it's not really clear to me if
you're arguing for the removal of the data as Tomasz suggests, or if
you want to keep them.

The first paragrah seems to advocate for the former, but the two
others for the latter.

Thanks!
Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--t2qijco5lkwnrc7e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXKdxKAAKCRDj7w1vZxhR
xaguAQDVqL8citHvAI0AYhkqcltH5ypA6lOK0dh6sIpwALsmDwEA3MEjg5BzYQbl
HkVCdLdoLNkzR2QAVGyty1UFWk84Zgw=
=+ba4
-----END PGP SIGNATURE-----

--t2qijco5lkwnrc7e--
