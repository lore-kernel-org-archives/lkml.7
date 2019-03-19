Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEAF9C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 00:51:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A26AE20989
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 00:51:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="WAKky9MU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727183AbfCSAv2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 20:51:28 -0400
Received: from ozlabs.org ([203.11.71.1]:38015 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726487AbfCSAv2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 20:51:28 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44NZHc2qWRz9s5c;
        Tue, 19 Mar 2019 11:51:23 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1552956685;
        bh=3+0VJVvQZQzP6jTOmh1QmYYo/8rSeUzwMQrdP/UDIX8=;
        h=Date:From:To:Cc:Subject:From;
        b=WAKky9MUMqTp4Ne8ZhWP10duWq+pVaDnAywQfkhvl6RcKiCkig3Fylf4kNqGR72bC
         tR9uLo5agjF5X5qI60VVvfhM4TZU80wBDmDhhv23IvWvOZEU0k4qa2Ud9O4mloEcIK
         zTWWA7J90zoaewKaRZ0lp2WsHMX3nmTWZBQkft6HpM7MqJt+EEogAWAvZg8DFKV5h1
         lDWFIvY02T1wMLA7zCNoCJoN5mrF2WvwHTSvWI440FOqJAPY6piMBoP2aT6RKrxvSW
         xqfeTVVoztr6oiMxiF4InYpkKob447EQal4IpsHwh9RVKANcAVGnSvDS7CUflf7qB2
         NzuDXrZ/GbWAA==
Date:   Tue, 19 Mar 2019 11:51:16 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ville =?UTF-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Uma Shankar <uma.shankar@intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Subject: linux-next: manual merge of the drm-misc tree with the drm-intel
 tree
Message-ID: <20190319115116.5b5892fd@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/pUnUBgG_2I692jZXpr+YLiI"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/pUnUBgG_2I692jZXpr+YLiI
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the drm-misc tree got a conflict in:

  drivers/gpu/drm/i915/intel_hdmi.c

between commit:

  fbf08556ed43 ("drm/i915: Precompute HDMI infoframes")

from the drm-intel tree and commit:

  2f146b78d5a9 ("drm/i915: Attach colorspace property and enable modeset")

from the drm-misc tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/gpu/drm/i915/intel_hdmi.c
index ecfec5d3292e,765718b606d8..000000000000
--- a/drivers/gpu/drm/i915/intel_hdmi.c
+++ b/drivers/gpu/drm/i915/intel_hdmi.c
@@@ -638,70 -469,39 +638,72 @@@ static void intel_write_infoframe(struc
  	buffer[3] =3D 0;
  	len++;
 =20
 -	intel_dig_port->write_infoframe(encoder,
 -					crtc_state,
 -					frame->any.type, buffer, len);
 +	intel_dig_port->write_infoframe(encoder, crtc_state, type, buffer, len);
  }
 =20
 -static void intel_hdmi_set_avi_infoframe(struct intel_encoder *encoder,
 -					 const struct intel_crtc_state *crtc_state,
 -					 const struct drm_connector_state *conn_state)
 +void intel_read_infoframe(struct intel_encoder *encoder,
 +			  const struct intel_crtc_state *crtc_state,
 +			  enum hdmi_infoframe_type type,
 +			  union hdmi_infoframe *frame)
  {
 +	struct intel_digital_port *intel_dig_port =3D enc_to_dig_port(&encoder->=
base);
 +	u8 buffer[VIDEO_DIP_DATA_SIZE];
 +	int ret;
 +
 +	if ((crtc_state->infoframes.enable &
 +	     intel_hdmi_infoframe_enable(type)) =3D=3D 0)
 +		return;
 +
 +	intel_dig_port->read_infoframe(encoder, crtc_state,
 +				       type, buffer, sizeof(buffer));
 +
 +	/* Fill the 'hole' (see big comment above) at position 3 */
 +	memmove(&buffer[1], &buffer[0], 3);
 +
 +	/* see comment above for the reason for this offset */
 +	ret =3D hdmi_infoframe_unpack(frame, buffer + 1, sizeof(buffer) - 1);
 +	if (ret) {
 +		DRM_DEBUG_KMS("Failed to unpack infoframe type 0x%02x\n", type);
 +		return;
 +	}
 +
 +	if (frame->any.type !=3D type)
 +		DRM_DEBUG_KMS("Found the wrong infoframe type 0x%x (expected 0x%02x)\n",
 +			      frame->any.type, type);
 +}
 +
 +static bool
 +intel_hdmi_compute_avi_infoframe(struct intel_encoder *encoder,
 +				 struct intel_crtc_state *crtc_state,
 +				 struct drm_connector_state *conn_state)
 +{
 +	struct hdmi_avi_infoframe *frame =3D &crtc_state->infoframes.avi.avi;
  	const struct drm_display_mode *adjusted_mode =3D
  		&crtc_state->base.adjusted_mode;
 -	union hdmi_infoframe frame;
 +	struct drm_connector *connector =3D conn_state->connector;
  	int ret;
 =20
 -	ret =3D drm_hdmi_avi_infoframe_from_display_mode(&frame.avi,
 -						       conn_state->connector,
 +	if (!crtc_state->has_infoframe)
 +		return true;
 +
 +	crtc_state->infoframes.enable |=3D
 +		intel_hdmi_infoframe_enable(HDMI_INFOFRAME_TYPE_AVI);
 +
 +	ret =3D drm_hdmi_avi_infoframe_from_display_mode(frame, connector,
  						       adjusted_mode);
 -	if (ret < 0) {
 -		DRM_ERROR("couldn't fill AVI infoframe\n");
 -		return;
 -	}
 +	if (ret)
 +		return false;
 =20
  	if (crtc_state->output_format =3D=3D INTEL_OUTPUT_FORMAT_YCBCR420)
 -		frame.avi.colorspace =3D HDMI_COLORSPACE_YUV420;
 +		frame->colorspace =3D HDMI_COLORSPACE_YUV420;
  	else if (crtc_state->output_format =3D=3D INTEL_OUTPUT_FORMAT_YCBCR444)
 -		frame.avi.colorspace =3D HDMI_COLORSPACE_YUV444;
 +		frame->colorspace =3D HDMI_COLORSPACE_YUV444;
  	else
 -		frame.avi.colorspace =3D HDMI_COLORSPACE_RGB;
 +		frame->colorspace =3D HDMI_COLORSPACE_RGB;
 =20
 -	drm_hdmi_avi_infoframe_colorspace(&frame.avi, conn_state);
++	drm_hdmi_avi_infoframe_colorspace(frame, conn_state);
+=20
 -	drm_hdmi_avi_infoframe_quant_range(&frame.avi,
 -					   conn_state->connector,
 +	drm_hdmi_avi_infoframe_quant_range(frame, connector,
  					   adjusted_mode,
  					   crtc_state->limited_color_range ?
  					   HDMI_QUANTIZATION_RANGE_LIMITED :

--Sig_/pUnUBgG_2I692jZXpr+YLiI
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlyQPQQACgkQAVBC80lX
0GwcOwf+NWXUXmOYQAgH7YS/rY2UXvv9tQnq/BMB3Am4MkpV4j2QOgZ9wLiCzaTY
VdkMbEXDk4FCwhO5hJ9hSX5G3w6Ilm9IxFf8AjdrAD8aQ8fpHQcw50FvgcnZgc6b
xENKPbJ5cW81LcUoeaFo7zZXNDwWYsLhxaJUbv6bYfneUlLt31fSl7KGsO/Zx+es
8A4BErsvPwnYzqE4mKdFbLLS61DTQjpuDc4tBv3HvxUXXWv08pUFtVR7p2sfsoJ3
0yZ4vCyuBwbAdlQt1qwoR8Nq0AXEN15TzATYyIhWPCklNMeGXcsPyq4x7DB5/IuT
wE1RFKqO1El7g6p0BKSJb/gubiXCSw==
=icGM
-----END PGP SIGNATURE-----

--Sig_/pUnUBgG_2I692jZXpr+YLiI--
