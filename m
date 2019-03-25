Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C308AC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 11:29:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8868E2082C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 11:29:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UozxCluZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730818AbfCYL3N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 07:29:13 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:42007 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729803AbfCYL3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 07:29:12 -0400
Received: by mail-qk1-f193.google.com with SMTP id b74so5013038qkg.9
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 04:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DlTim9mhXOY0KJ/d/k8UVegbmipds++96qaLqCbDIfU=;
        b=UozxCluZlpcDJcIDk8B1DR4N6wK9sO4Fbjb3Df0Qiqc16Ql/Pp2IGS43q4qV0uQOfb
         Gz9lYrVrwYsjp/ke26gVdB8Me6/QQc2yTAGNWJTVll+7qtWdGnvT4vFfiqPQPJnjw3EB
         4bX235VTLYDvn+TchlWOKW82T6VOc6Fqtm0fW573gG2xEkxEZ2A3oUybDNHb9byegXZ6
         ZhMFbxLk8OxAslfKl2SmES+vmEYdiY/5QkgDQEHVAL3fcLpx9rC2UKBga+prCRnuyBpl
         DtJDEf1aKNktMso9/uYdLBqWYMlbY6fB26iB782lLaI0oII0FOLUgIKQRS7yD+ImbBFW
         ZCJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DlTim9mhXOY0KJ/d/k8UVegbmipds++96qaLqCbDIfU=;
        b=qY1OV9LimADOaf9A9Yyre/ep+lV1dddp3urcVKrDPoNLKl9BRiG6vtjd7iQcAEyBt5
         dExriK1+Z9hn9KtWQNAR+InXGo2so6aFRC3O3BTmSQ+yFlNCvjI46jD5k/MRaV6Pt7SB
         uoq3nAvFH4HQfuWfBa/h+INEgUNUzWAl4JcdH2/RoOAWjibevHih+0JlMdtBhFvcZAYY
         p7QnQojkgvgCSPd4HBGdrQvE0mjPWKpixwgPdRmzCOUCNUrbM0FaaIrOnnafheQQSfIw
         F1Nx92/wRodZOE8KiShNvjqOyTlxBWY+HK+b1U8dBwn9st0qA8aEOgyjdLQQrbpQ4Chu
         RJLA==
X-Gm-Message-State: APjAAAW8ouYrZkP3XfHe3TMVRdJkeJB1xDfgFjrq7nC5JWmNf8wQCO08
        N/MapSeUINYejalasJDlLVM=
X-Google-Smtp-Source: APXvYqwnaBuYH9wn39DcqHmJ9oHiWKj/aIoqCkWLoaDUF5H0Gqe/ex4BTlWuOhgaj1n9A1VjZRQiWg==
X-Received: by 2002:a37:6381:: with SMTP id x123mr19558167qkb.110.1553513351335;
        Mon, 25 Mar 2019 04:29:11 -0700 (PDT)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id o37sm1740670qte.55.2019.03.25.04.29.07
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 25 Mar 2019 04:29:09 -0700 (PDT)
Date:   Mon, 25 Mar 2019 08:29:06 -0300
From:   Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Gerd Hoffmann <kraxel@redhat.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] drm/atomic-helper: Make atomic_enable/disable crtc
 callbacks optional
Message-ID: <20190325112906.p4zfgom3by3f2zu4@smtp.gmail.com>
References: <20190314184845.gjmvkamobj4dilyp@smtp.gmail.com>
 <20190315110031.GY2665@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="s53qnnxj7bcumgeh"
Content-Disposition: inline
In-Reply-To: <20190315110031.GY2665@phenom.ffwll.local>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--s53qnnxj7bcumgeh
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 03/15, Daniel Vetter wrote:
> On Thu, Mar 14, 2019 at 03:48:45PM -0300, Rodrigo Siqueira wrote:
> > Allow atomic_enable and atomic_disable operations from
> > drm_crtc_helper_funcs struct optional. With this, the target display
> > drivers don't need to define a dummy function if they don't need one.
> >=20
> > Changes since v2:
> > * Don't make funcs optional
> > * Update kerneldoc for atomic_enable/disable
> > * Replace "if (funcs->atomic_enable)" by "if (funcs->commit)"
> > * Improve commit message
> >=20
> > Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
>=20
> Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

Hi,
Is it ok if I apply this patch?
=20
> > ---
> >  drivers/gpu/drm/drm_atomic_helper.c      | 5 ++---
> >  include/drm/drm_modeset_helper_vtables.h | 4 ++++
> >  2 files changed, 6 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_=
atomic_helper.c
> > index 540a77a2ade9..d506e13c2945 100644
> > --- a/drivers/gpu/drm/drm_atomic_helper.c
> > +++ b/drivers/gpu/drm/drm_atomic_helper.c
> > @@ -1034,7 +1034,7 @@ disable_outputs(struct drm_device *dev, struct dr=
m_atomic_state *old_state)
> >  			funcs->atomic_disable(crtc, old_crtc_state);
> >  		else if (funcs->disable)
> >  			funcs->disable(crtc);
> > -		else
> > +		else if (funcs->dpms)
> >  			funcs->dpms(crtc, DRM_MODE_DPMS_OFF);
> > =20
> >  		if (!(dev->irq_enabled && dev->num_crtcs))
> > @@ -1277,10 +1277,9 @@ void drm_atomic_helper_commit_modeset_enables(st=
ruct drm_device *dev,
> >  		if (new_crtc_state->enable) {
> >  			DRM_DEBUG_ATOMIC("enabling [CRTC:%d:%s]\n",
> >  					 crtc->base.id, crtc->name);
> > -
> >  			if (funcs->atomic_enable)
> >  				funcs->atomic_enable(crtc, old_crtc_state);
> > -			else
> > +			else if (funcs->commit)
> >  				funcs->commit(crtc);
> >  		}
> >  	}
> > diff --git a/include/drm/drm_modeset_helper_vtables.h b/include/drm/drm=
_modeset_helper_vtables.h
> > index cfb7be40bed7..ce4de6b1e444 100644
> > --- a/include/drm/drm_modeset_helper_vtables.h
> > +++ b/include/drm/drm_modeset_helper_vtables.h
> > @@ -418,6 +418,8 @@ struct drm_crtc_helper_funcs {
> >  	 * Drivers can use the @old_crtc_state input parameter if the operati=
ons
> >  	 * needed to enable the CRTC don't depend solely on the new state but
> >  	 * also on the transition between the old state and the new state.
> > +	 *
> > +	 * This function is optional.
> >  	 */
> >  	void (*atomic_enable)(struct drm_crtc *crtc,
> >  			      struct drm_crtc_state *old_crtc_state);
> > @@ -441,6 +443,8 @@ struct drm_crtc_helper_funcs {
> >  	 * parameter @old_crtc_state which could be used to access the old
> >  	 * state. Atomic drivers should consider to use this one instead
> >  	 * of @disable.
> > +	 *
> > +	 * This function is optional.
> >  	 */
> >  	void (*atomic_disable)(struct drm_crtc *crtc,
> >  			       struct drm_crtc_state *old_crtc_state);
> > --=20
> > 2.21.0
>=20
> --=20
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch

--=20
Rodrigo Siqueira
https://siqueira.tech
Graduate Student
Department of Computer Science
University of S=E3o Paulo

--s53qnnxj7bcumgeh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE4tZ+ii1mjMCMQbfkWJzP/comvP8FAlyYu4EACgkQWJzP/com
vP9SOg//R1J6WmGPr/xGB0gn8OKnq36G/sCCK8ECTFxjtxs2q2NOxZ08fLMPqrf5
Y9ewFTwbX0oVQg5lLcChTpThc+Rj9+bykn9ha7QJbm60QJ8Dl7+wWNyHuevuGmN8
x0gQekUZxbogz+xXCGZ4mE/JIBeYn0gZxdvW1YSjuUnokok/tosT6WMWva/QlFuR
rBRonwfVUOrt2fVnA6fIrZBvUpGkQJPbHWjCuSndk0u82EW3PghQVwKNdiKlmK4A
irS6a8P5Gce7XNR3Wyg0XqSxf2o0AN0nH9jtKi7C1QUCvDL6Csf/XQrlj6ybY1Ko
GV8mQzii6kTBSqxfIWgrLYQbZ5imLsL0wiJJ1CYn5PRXSOsbQ9Oaar39ZRcro8UZ
LQJRhVSxlLUrVbJPbgWGkD4INu0jh5ywVybm4eEk+HdNdWBYMMkHtLOX+Xn8ZA1W
taZIugKXeA8x+QpZgLg6HN8GPYLSvXPxWQlWbl7mrf1BWDvHQoyDoAQaIsF1gjv7
aqFJ0/EVPyBzavRYTYDoGLCcb/0wD9p7qv15r61mk8LxIChV+lsJ0ofCVXH8gt8o
RGn2D3vs356QjeVUh5c5ntNIN45bdR+o+z02QQOHwn3esnJsOPb8BSG8hhLTzwKS
wlpe0lTKcTsQDndO6VRDbNyhrZoBwsrgvWSEWFlXKee/cKutgT0=
=HKKI
-----END PGP SIGNATURE-----

--s53qnnxj7bcumgeh--
