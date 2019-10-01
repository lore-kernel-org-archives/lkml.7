Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C3A5C352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 14:50:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0FB120842
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 14:50:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389304AbfJAOuq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 10:50:46 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:57465 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727051AbfJAOuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 10:50:46 -0400
X-Originating-IP: 2.224.242.101
Received: from uno.localdomain (2-224-242-101.ip172.fastwebnet.it [2.224.242.101])
        (Authenticated sender: jacopo@jmondi.org)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 4BF9D40004;
        Tue,  1 Oct 2019 14:50:39 +0000 (UTC)
Date:   Tue, 1 Oct 2019 16:52:22 +0200
From:   Jacopo Mondi <jacopo@jmondi.org>
To:     Ezequiel Garcia <ezequiel@collabora.com>
Cc:     dri-devel@lists.freedesktop.org,
        linux-rockchip@lists.infradead.org,
        Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>,
        Sandy Huang <hjc@rock-chips.com>, kernel@collabora.com,
        Sean Paul <seanpaul@chromium.org>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Douglas Anderson <dianders@chromium.org>,
        Ilia Mirkin <imirkin@alum.mit.edu>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/5] RFC: drm/atomic-helper: Reapply color
 transformation after resume
Message-ID: <20191001145222.32aapomoqlaxpvbb@uno.localdomain>
References: <20190930222802.32088-1-ezequiel@collabora.com>
 <20190930222802.32088-6-ezequiel@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zl62uyu5oe5zzls3"
Content-Disposition: inline
In-Reply-To: <20190930222802.32088-6-ezequiel@collabora.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zl62uyu5oe5zzls3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Ezequiel,

On Mon, Sep 30, 2019 at 07:28:02PM -0300, Ezequiel Garcia wrote:
> Some platforms are not able to maintain the color transformation
> state after a system suspend/resume cycle.
>
> Set the colog_mgmt_changed flag so that CMM on the CRTCs in

CMM is the name of the Renesas unit for color enanchement. It should
not be used here as this will apply to all platforms.

> the suspend state are reapplied after system resume.
>
> Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
> ---
> This is an RFC, and it's mostly based on Jacopo Mondi's work https://lkml.org/lkml/2019/9/6/498.
>
> Changes from v2:
> * New patch.
> ---
>  drivers/gpu/drm/drm_atomic_helper.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
> index e41db0f202ca..518488125575 100644
> --- a/drivers/gpu/drm/drm_atomic_helper.c
> +++ b/drivers/gpu/drm/drm_atomic_helper.c
> @@ -3234,8 +3234,20 @@ int drm_atomic_helper_resume(struct drm_device *dev,
>  			     struct drm_atomic_state *state)
>  {
>  	struct drm_modeset_acquire_ctx ctx;
> +	struct drm_crtc_state *crtc_state;
> +	struct drm_crtc *crtc;
> +	unsigned int i;
>  	int err;
>
> +	for_each_new_crtc_in_state(state, crtc, crtc_state, i) {
> +		/*
> +		 * Force re-enablement of CMM after system resume if any
> +		 * of the DRM color transformation properties was set in
> +		 * the state saved at system suspend time.
> +		 */
> +		if (crtc_state->gamma_lut)

Please note that in my original patch I only took gamma_lut into
account as that's what our CMM supports at the moment, but you should
here consider the degamma_lut and cmt flags in the crtc_state.

> +			crtc_state->color_mgmt_changed = true;
> +	}
>  	drm_mode_config_reset(dev);
>
>  	DRM_MODESET_LOCK_ALL_BEGIN(dev, ctx, 0, err);
> --
> 2.22.0
>

--zl62uyu5oe5zzls3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEtcQ9SICaIIqPWDjAcjQGjxahVjwFAl2TaCYACgkQcjQGjxah
VjyNJA//aSwBuTdB7lLcaiEaE+P3RsAcLZl6sS/EGaTO5tsvgJD43qhcW0FyAZdV
8ABNJ3e+W7ZgTzkHWVBvs6Y5eQlE3AvvAhXFPEjL9ca9Y/rRLgcF6mQ8GQCqsYO7
dvBkd1bpWG7XBOO5KzSLSDbIsjDRmDbpFVQHtTWDJZN/LzIqZHoGPZL9Tc7yoAY7
9MW3av52glPOWqTJj9zscg/Y7BWuapCmmPPV97iLUPKVtvN/G+2fgIVxushM2e3K
TJvYsU63CZ5pzKX1U02UBbs0KKsENRRjWCTcGs2gf5xq0WhBs+lC0uZAclNkw/lu
wd5ehPD3CaE2NiBECnHtptxEZE+jMzzP7jmDojYHILG0NqV6pcVVHdZsYK7AE/qb
CfqDtLn6HnbaZZcia7Smp50QpTGY5z46Qe9l15CH/wtzjywwyKyl9GvuEK18ycx5
6iwGZW0PYHJnAQwh0U4F92akAXIOf5xfpW2358jlIr8iwmSE5UgrqA4YcDDPGDfs
7YvBDUBn/Bs0RYUetb/+HI5rcYZsWdBkpL/cHP6y+8yItmdS9IyYlHS6pXxm3X04
dS7tEaUs29GYJKsVshqq7ORctg0pd4ebsSsZeyqTLq7YmzXefjzpHihSvuKt0oMU
pqCdnYKZkFUm70gLJXTHVVjSty7YOBB428DgPlWTFmgNUvVUqec=
=hYRk
-----END PGP SIGNATURE-----

--zl62uyu5oe5zzls3--
