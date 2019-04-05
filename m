Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2E20C282DA
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 16:27:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F3B42146F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 16:27:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731571AbfDEQ14 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 12:27:56 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:35730 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730554AbfDEQ14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 12:27:56 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nicolas)
        with ESMTPSA id 17FF128226F
Message-ID: <05078223a4098c96f6260f77e9ef2a01b966daa6.camel@collabora.com>
Subject: Re: [PATCH RESEND v7 1/2] media: uapi: Add H264 low-level decoder
 API compound controls.
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
Reply-To: Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, Tomasz Figa <tfiga@chromium.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Alexandre Courbot <acourbot@chromium.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Pawel Osciak <posciak@chromium.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg "
         "Roedel <joro@8bytes.org>," <linux-arm-kernel@lists.infradead.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Jens Kuske <jenskuske@gmail.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Guenter Roeck <groeck@chromium.org>
Date:   Fri, 05 Apr 2019 12:27:48 -0400
In-Reply-To: <20190405151552.biesirbs35uivk7d@flea>
References: <cover.bfe197a82766125bea21dd26fd3de85893a921ac.1554380738.git-series.maxime.ripard@bootlin.com>
         <7cd913545cfc80fa9999839c62c4bf7b354a7904.1554380738.git-series.maxime.ripard@bootlin.com>
         <CAAFQd5ASMJL2_ovNeFOhCh2JoD86KMtV5XO+7OgM37ckxrxmfA@mail.gmail.com>
         <CAGb2v642__AF3iHO+d9FKazJ4=uRAQSfxAN_uCUWagH6Jz2twQ@mail.gmail.com>
         <c3ed6d00bf5642b1524ef4973f2db7ba6759fb6d.camel@collabora.com>
         <20190405151552.biesirbs35uivk7d@flea>
Organization: Collabora Ltd.
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
        boundary="=-105qp6mZm6hZVbLbDG+d"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-105qp6mZm6hZVbLbDG+d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le vendredi 05 avril 2019 =C3=A0 17:15 +0200, Maxime Ripard a =C3=A9crit :
> Hi Nicolas,
>=20
> On Thu, Apr 04, 2019 at 11:41:13AM -0400, Nicolas Dufresne wrote:
> > > > > +    * - __u16
> > > > > +      - ``pic_width_in_mbs_minus1``
> > > > > +      -
> > > > > +    * - __u16
> > > > > +      - ``pic_height_in_map_units_minus1``
> > > > > +      -
> > > >=20
> > > > We recently had some reflection with Alex that this is redundant wi=
th
> > > > the width and height in the OUTPUT format. It may also apply to som=
e
> > > > other fields in these structs. I feel like they should be removed a=
nd
> > > > passed via corresponding generic V4L2 properties - format, selectio=
n,
> > > > etc.
> > > >=20
> > > > The same problem is also present in the MPEG2 controls. In fact, th=
ere
> > > > was a patch already which used some fields from the controls to
> > > > calculate the destination buffer strides, rather than bytesperline =
in
> > > > the format.
> > > >=20
> > > > Since we're in staging, it could be done with a follow-up patch, th=
ough.
> > >=20
> > > Just my two cents. I played with some codecs a while back. IIRC some
> > > specify a "codec" size in addition to the actual picture size, like
> > > when the encoder does padding to fit the requirements of the codec
> > > (spec). Is this needed anywhere?
> >=20
> > With state-less encoders, the headers, which contains the crop
> > information is created by userspace and for state less decoder, the
> > headers that contains this information is parsed by userspace. So I
> > believe that in theory, the accelerator does not strictly need to be
> > aware of the cropped dimensions.
> >=20
> > Another thing, is that there is not guarantied matches between e.g.
> > depth of the chrome/luma and the final image buffers. Some hardware may
> > have bandwidth limitation or internal converter and could possibly
> > decode 10bit data into 8bit buffers.
> >=20
> > A third reason why I would not try and encode this header information
> > is that there can be multiple PPS/SPS at the same time, and I think
> > it's confusing if the relevant information to differentiate them is
> > removed.
>=20
> Sorry if that sounds a bit dumb, but it's not really clear to me if
> you're arguing for the removal of the data as Tomasz suggests, or if
> you want to keep them.
>=20
> The first paragrah seems to advocate for the former, but the two
> others for the latter.

I think the data should stay. As I said, there can be multiple SPS/PPS,
while there is only one format. That being said, how does SPS/PPS
activation works ? How do you tell the driver about all the SPS/PPS and
which one is being activated ?

>=20
> Thanks!
> Maxime
>=20
> --
> Maxime Ripard, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com

--=-105qp6mZm6hZVbLbDG+d
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQSScpfJiL+hb5vvd45xUwItrAaoHAUCXKeCBQAKCRBxUwItrAao
HPxYAKCLokQMygHQVcEBVlfoU/0wx7JIPQCgigkxrrILs+98mkAhfw91CijNlVI=
=lZ4c
-----END PGP SIGNATURE-----

--=-105qp6mZm6hZVbLbDG+d--

