Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9698FC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 07:30:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E83F2084C
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 07:30:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728656AbfDCHaB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 03:30:01 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:47739 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbfDCHaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 03:30:00 -0400
Received: from localhost (aaubervilliers-681-1-89-125.w90-88.abo.wanadoo.fr [90.88.30.125])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 92621100006;
        Wed,  3 Apr 2019 07:29:48 +0000 (UTC)
Date:   Wed, 3 Apr 2019 09:29:48 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     hans.verkuil@cisco.com, acourbot@chromium.org,
        sakari.ailus@linux.intel.com,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        tfiga@chromium.org, posciak@chromium.org,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        nicolas.dufresne@collabora.com, jenskuske@gmail.com,
        jernej.skrabec@gmail.com, jonas@kwiboo.se, ezequiel@collabora.com,
        linux-sunxi@googlegroups.com,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Guenter Roeck <groeck@chromium.org>
Subject: Re: [PATCH v6 1/2] media: uapi: Add H264 low-level decoder API
 compound controls.
Message-ID: <20190403072948.ixugqb2t4z3dcyd4@flea>
References: <cover.3917a1471bfc8cbdfdde8026566b3857caff5762.1553009355.git-series.maxime.ripard@bootlin.com>
 <9d9fe5c2dc58f9398cb6b1e9bb208640d25ae816.1553009355.git-series.maxime.ripard@bootlin.com>
 <dbe5702e-f76d-9c92-cab6-bd88d243ae55@xs4all.nl>
 <4c70e58d-ce7b-c15d-4b1c-063cf9b67007@xs4all.nl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6mczpj43p5bcvl5e"
Content-Disposition: inline
In-Reply-To: <4c70e58d-ce7b-c15d-4b1c-063cf9b67007@xs4all.nl>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6mczpj43p5bcvl5e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Hans,

On Tue, Apr 02, 2019 at 01:39:21PM +0200, Hans Verkuil wrote:
> >> +struct v4l2_h264_dpb_entry {
> >> +	__u64 timestamp;
> >
> > As mentioned above, I suggest to rename this to 'reference_ts'.
> >
> > But see also the discussion below.
> >
> >> +	__u16 frame_num;
> >> +	__u16 pic_num;
> >> +	/* Note that field is indicated by v4l2_buffer.field */
> >> +	__s32 top_field_order_cnt;
> >> +	__s32 bottom_field_order_cnt;
> >> +	__u32 flags; /* V4L2_H264_DPB_ENTRY_FLAG_* */
> >> +};
> >> +
> >> +#define V4L2_H264_DECODE_PARAM_FLAG_IDR_PIC	0x01
> >> +
> >> +struct v4l2_ctrl_h264_decode_param {
> >> +	__u32 num_slices;
> >> +	__u32 nal_ref_idc;
> >> +	__u8 ref_pic_list_p0[32];
> >> +	__u8 ref_pic_list_b0[32];
> >> +	__u8 ref_pic_list_b1[32];
> >> +	__s32 top_field_order_cnt;
> >> +	__s32 bottom_field_order_cnt;
> >> +	__u32 flags; /* V4L2_H264_DECODE_PARAM_FLAG_* */
> >> +	struct v4l2_h264_dpb_entry dpb[16];
> >
> > Should the reference timestamp be included in this control? Or be
> > separated into its own control?
> >
> > Reference frames do not apply to stateless encoders (the driver will
> > have to maintain the reference frames internally). Everything else
> > is equally valid for both stateless encoders and decoders, but only
> > stateless decoders need to provide the reference frames.
> >
> > So in this case we would need to create a new control:
> >
> > #define V4L2_CID_MPEG_VIDEO_H264_DECODE_REF_TS	(V4L2_CID_MPEG_BASE+1005)
> >
> > Which is a u64 array control (16 elements for H.264).
> >
> > You would need to do something similar for MPEG2.
>
> The question is if this is worth the extra effort. An alternative is
> to just specify that these reference timestamps are always to be zeroed
> by stateless encoders and are unused.
>
> I'm undecided on this.

I'll address your other comments, thanks!

For that part, I haven't really looked at the encoder parameters yet,
but I guess we should have other controls to be passed there as well
(like the target level of encoding). We can probably reuse the
existing controls for that though.

=46rom the way it looks, our encoder needs to put some parameters (the
level and feature flags, mostly) and will output the entire
bitstream. I'm not really sure if it qualifies as a stateless encoder,
but that would require far less than what we have in those controls
already.

Either way, maybe the good way forward here would be to way for an
H264 / MPEG2 stateless encoder to come up, either ours or some other,
to see what should we do about this. How does that sound?

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--6mczpj43p5bcvl5e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXKRg7AAKCRDj7w1vZxhR
xWkOAQDj950LGL8g5ChswLf8C7Ktgyu6QoYL2RuqohRF+mFhYwEA/a01+LbhBj+n
C+ihsMxE3npCOR5y/vroVSe+hgDWkg8=
=MqY4
-----END PGP SIGNATURE-----

--6mczpj43p5bcvl5e--
