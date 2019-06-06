Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 239B0C04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 13:09:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01E7D20684
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 13:09:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727321AbfFFNJQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 09:09:16 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:50524 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbfFFNJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 09:09:15 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id B5F4B8027B; Thu,  6 Jun 2019 15:09:03 +0200 (CEST)
Date:   Thu, 6 Jun 2019 15:09:13 +0200
From:   Pavel Machek <pavel@denx.de>
To:     pavel@ucw.cz
Cc:     linux-kernel@vger.kernel.org,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 4.19 208/276] x86/ia32: Fix ia32_restore_sigcontext() AC
 leak
Message-ID: <20190606130913.GD27432@amd>
References: <20190530030523.133519668@linuxfoundation.org>
 <20190530030538.134917754@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="ZARJHfwaSJQLOEUz"
Content-Disposition: inline
In-Reply-To: <20190530030538.134917754@linuxfoundation.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ZARJHfwaSJQLOEUz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

(stable removed from cc).

> [ Upstream commit 67a0514afdbb8b2fc70b771b8c77661a9cb9d3a9 ]
>=20
> Objtool spotted that we call native_load_gs_index() with AC set.
> Re-arrange the code to avoid that.

Does this introduce undefined behaviour?
>=20
> @@ -72,6 +71,7 @@ static int ia32_restore_sigcontext(struct pt_regs *regs,
>  				   struct sigcontext_32 __user *sc)
>  {
>  	unsigned int tmpflags, err =3D 0;
> +	u16 gs, fs, es, ds;
>  	void __user *buf;
>  	u32 tmp;
> =20
> @@ -79,16 +79,10 @@ static int ia32_restore_sigcontext(struct pt_regs *re=
gs,
>  	current->restart_block.fn =3D do_no_restart_syscall;
> =20
>  	get_user_try {
> -		/*
> -		 * Reload fs and gs if they have changed in the signal
> -		 * handler.  This does not handle long fs/gs base changes in
> -		 * the handler, but does not clobber them at least in the
> -		 * normal case.
> -		 */
> -		RELOAD_SEG(gs);
> -		RELOAD_SEG(fs);
> -		RELOAD_SEG(ds);
> -		RELOAD_SEG(es);

> +		gs =3D GET_SEG(gs);

es is unitialized at this point, and we can trap.

> +		fs =3D GET_SEG(fs);
> +		ds =3D GET_SEG(ds);
> +		es =3D GET_SEG(es);
> =20
>  		COPY(di); COPY(si); COPY(bp); COPY(sp); COPY(bx);
>  		COPY(dx); COPY(cx); COPY(ip); COPY(ax);
> @@ -106,6 +100,17 @@ static int ia32_restore_sigcontext(struct pt_regs *r=
egs,
>  		buf =3D compat_ptr(tmp);
>  	} get_user_catch(err);
> =20
> +	/*
> +	 * Reload fs and gs if they have changed in the signal
> +	 * handler.  This does not handle long fs/gs base changes in
> +	 * the handler, but does not clobber them at least in the
> +	 * normal case.
> +	 */
> +	RELOAD_SEG(gs);
> +	RELOAD_SEG(fs);
> +	RELOAD_SEG(ds);
> +	RELOAD_SEG(es);
> +

But now we use uninitialized value in es...

>  	err |=3D fpu__restore_sig(buf, 1);
> =20
>  	force_iret();

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--ZARJHfwaSJQLOEUz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlz5EHkACgkQMOfwapXb+vIfLACffEPp+lXO+Qx/xdsCtIi7lPTd
R8sAoKLfCon9uCspCieqbuE8LudvueJF
=FYiM
-----END PGP SIGNATURE-----

--ZARJHfwaSJQLOEUz--
