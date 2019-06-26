Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2689C48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 02:00:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B39D22146E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 02:00:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ih5M2Y3X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726423AbfFZCAQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 22:00:16 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:40339 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbfFZCAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 22:00:16 -0400
Received: by mail-qt1-f194.google.com with SMTP id a15so702832qtn.7;
        Tue, 25 Jun 2019 19:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HpuOAuDXoNiwLSESipUp418iEseXPPASUvyqCZTf5Mw=;
        b=ih5M2Y3Xez7rNTHKOdlM0tA286STlKgr0/S9be5v1HeIoO44m1lsSarxkBC+N2Eb5e
         W6TFBwV5Y8BTqg/UVh2Q54hNNwEsbBxxXJTu+Nb2X5wXpxnEybX189zU6B4XuLFm+1s9
         py5t3So+h2DLha0uHL255bEV/OSvCwjNW6PG0y7in0SLWPPEeEJLyfA0jiyBloaytdFs
         Dd314PKfwvjqJbLB37OF/cHZNgB7KDkLcPKvpjGCD9Ey++WWzZwJzsYsT0/7g948xvFB
         8tXoC/jw5KrGSg/vsypNyJLNyiGtllA9achRbzPAnoKbCGCljkRnzzHLbFWafVbZr4h8
         p/UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HpuOAuDXoNiwLSESipUp418iEseXPPASUvyqCZTf5Mw=;
        b=ge33L5oGSKSR53+Fg6+/srbpG4PfEqdhv+xcH1C+7k0SS+3zQTXRGNrCdmuTb+mLi/
         IqYStXuqPDEtXeNZ7OjTeBsHOB+1Pr0GYVw9WIDgYrn279akoahcC+VSL4BB7nzahWv5
         MdT5clU6RyyoFQ6xJVPul+P2qXfjPxqAxZc+nc903wAdhIVVyVAjEf/VbbJGaehgIpS2
         5QtxxIoU7v9M8WnBoRMF66hTD9m6/r5sEUCp8D5d7ViIcOfWC8PzX3udeTcSr1kEmglY
         6zLT+sECmdnSwRNM37SPwu+Oh/1VIWwMDEZ6NQwIpY+YLw7MWc7Kv5IY/C3cVWThmEcX
         9BMg==
X-Gm-Message-State: APjAAAWMS/fs1CrKfNptAWW8lHd7xEc609Zof3KDwse217sSFuba/aTK
        aHJVPszHnJd9/8pB1ecTu1c=
X-Google-Smtp-Source: APXvYqxsk2sgNVPX0AcZD0OT3YkQmpZyeNJy6aJjXO819o3LNuOBXTzhKg373EnrondH0ZYKDY2mWg==
X-Received: by 2002:a0c:b0ce:: with SMTP id p14mr1294280qvc.51.1561514415001;
        Tue, 25 Jun 2019 19:00:15 -0700 (PDT)
Received: from smtp.gmail.com ([187.121.151.146])
        by smtp.gmail.com with ESMTPSA id a54sm6533140qtk.85.2019.06.25.19.00.11
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 25 Jun 2019 19:00:14 -0700 (PDT)
Date:   Tue, 25 Jun 2019 23:00:05 -0300
From:   Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, intel-gfx@lists.freedesktop.org
Subject: Re: [PATCH V4] drm/drm_vblank: Change EINVAL by the correct errno
Message-ID: <20190626020005.vb5gmqcvkyzgcjee@smtp.gmail.com>
References: <20190619020750.swzerehjbvx6sbk2@smtp.gmail.com>
 <20190619074856.GJ12905@phenom.ffwll.local>
 <20190619075059.GK12905@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="o7ebaymw2qc26tic"
Content-Disposition: inline
In-Reply-To: <20190619075059.GK12905@phenom.ffwll.local>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--o7ebaymw2qc26tic
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 06/19, Daniel Vetter wrote:
> On Wed, Jun 19, 2019 at 09:48:56AM +0200, Daniel Vetter wrote:
> > On Tue, Jun 18, 2019 at 11:07:50PM -0300, Rodrigo Siqueira wrote:
> > > For historical reason, the function drm_wait_vblank_ioctl always retu=
rn
> > > -EINVAL if something gets wrong. This scenario limits the flexibility
> > > for the userspace make detailed verification of the problem and take
> > > some action. In particular, the validation of =E2=80=9Cif (!dev->irq_=
enabled)=E2=80=9D
> > > in the drm_wait_vblank_ioctl is responsible for checking if the driver
> > > support vblank or not. If the driver does not support VBlank, the
> > > function drm_wait_vblank_ioctl returns EINVAL which does not represent
> > > the real issue; this patch changes this behavior by return EOPNOTSUPP.
> > > Additionally, some operations are unsupported by this function, and
> > > returns EINVAL; this patch also changes the return value to EOPNOTSUPP
> > > in this case. Lastly, the function drm_wait_vblank_ioctl is invoked by
> > > libdrm, which is used by many compositors; because of this, it is
> > > important to check if this change breaks any compositor. In this sens=
e,
> > > the following projects were examined:
> > >=20
> > > * Drm-hwcomposer
> > > * Kwin
> > > * Sway
> > > * Wlroots
> > > * Wayland-core
> > > * Weston
> > > * Xorg (67 different drivers)
> > >=20
> > > For each repository the verification happened in three steps:
> > >=20
> > > * Update the main branch
> > > * Look for any occurrence "drmWaitVBlank" with the command:
> > >   git grep -n "drmWaitVBlank"
> > > * Look in the git history of the project with the command:
> > >   git log -SdrmWaitVBlank
> > >=20
> > > Finally, none of the above projects validate the use of EINVAL which
> > > make safe, at least for these projects, to change the return values.
> > >=20
> > > Change since V3:
> > >  - Return EINVAL for _DRM_VBLANK_SIGNAL (Daniel)
> > >=20
> > > Change since V2:
> > >  Daniel Vetter and Chris Wilson
> > >  - Replace ENOTTY by EOPNOTSUPP
> > >  - Return EINVAL if the parameters are wrong
> > >=20
> >=20
> > Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> >=20
> > Apologies for the confusion on the last time around. btw if someone tel=
ls
> > you "r-b (or a-b) with these changes", then just apply the r-b/a-b tag
> > next time around. Otherwise people will re-review the same thing over a=
nd
> > over again.
>=20
> btw when resending patches it's good practice to add anyone who commented
> on it (or who commented on the igt test for the same patch and other way
> round) onto the explicit Cc: list of the patch. That way it's easier for
> them to follow the patch evolution and do a quick r-b once they're happy.

Thanks for these valuable tips.
Do you think that is a good idea to resend this patch CC's everybody? Or
is it ok if I just apply it?
=20
> If you don't do that then much bigger chances your patch gets ignored.
> -Daniel
> >=20
> > > Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
> > > ---
> > >  drivers/gpu/drm/drm_vblank.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >=20
> > > diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblan=
k.c
> > > index 603ab105125d..bed233361614 100644
> > > --- a/drivers/gpu/drm/drm_vblank.c
> > > +++ b/drivers/gpu/drm/drm_vblank.c
> > > @@ -1582,7 +1582,7 @@ int drm_wait_vblank_ioctl(struct drm_device *de=
v, void *data,
> > >  	unsigned int flags, pipe, high_pipe;
> > > =20
> > >  	if (!dev->irq_enabled)
> > > -		return -EINVAL;
> > > +		return -EOPNOTSUPP;
> > > =20
> > >  	if (vblwait->request.type & _DRM_VBLANK_SIGNAL)
> > >  		return -EINVAL;
> > > --=20
> > > 2.21.0
> >=20
> > --=20
> > Daniel Vetter
> > Software Engineer, Intel Corporation
> > http://blog.ffwll.ch
>=20
> --=20
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch

--=20
Rodrigo Siqueira
https://siqueira.tech

--o7ebaymw2qc26tic
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE4tZ+ii1mjMCMQbfkWJzP/comvP8FAl0S0aQACgkQWJzP/com
vP9OChAAhjuLcUgtK3blJvPIR0GbBQ2YKI5GBvyvsD2cAeC3QEh7a/X+5S9BcncG
AC/MTchAA76y0nXrgOKMDHD7E6y1wle9Ox+tJg4WsBpiya5f+Z6S8CllyLzfRFzS
DpIiC2ouqfYJzsecJXj9gveMbblf4YlCE22Cbn0gLajB61yOpuJ8HJK3KhFK6Zjp
KRD6sNXAuYkrWUPzsfNjOBt55r48DH2DfVtiMzANTo5qgs1yofYn1cwuYIsRqR+x
ULgg0wKUWxJXuXIWqkk4H7KD0QmZuEwtpMHMxSC85UldTnJ7fxEHiQXA661163x+
KAMlBLLUtK4LeGU5g2dbP3/ir3xLR5DuX07tZ1EXV8b5SGFzSKqrT1AEFYj2cpH1
TG62Zc0J2DqX+JuvuISAUkOd0OgKsdC1bDxEMiEy0kZpHLsnl8YOAkLYZBhf58Dy
O0RamNxYvfIEM9wcUm/wcxHtQVPAPYtqKRe2G1gOHSCHtDmRHF+Hpm8LAJcSRKdF
FTm6HY/Qbk/Nwx7gSzlVdEqB/qrc8Keqw2f8q/rHCL+zqalsIPM3P55yBWJxroGp
FM2dNRs6hN2XWRVNGpbZgaJ4im5IwzPCeIt+e+4EHu2AxPNa6jA55bW/JBOGLLOd
J9BhpzIwTExBxHySR9M97PUNMsKPYeTXG6D+La98edR5uRCDT1U=
=ksZ9
-----END PGP SIGNATURE-----

--o7ebaymw2qc26tic--
