Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDF96C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 11:30:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9BA321850
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 11:30:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P38sKNAA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727931AbfCTLaK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 07:30:10 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50179 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbfCTLaJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 07:30:09 -0400
Received: by mail-wm1-f66.google.com with SMTP id z11so11708071wmi.0;
        Wed, 20 Mar 2019 04:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6cth7Y463YwZNMzZQfogNVGpIY2rvKagq7dq2OfCuEU=;
        b=P38sKNAANu+uvCM7XitK2f4L4lsW0FtLNOD08bj5d665cZWnyrbF+nMR/lfEHc2pvw
         ewvVDkgUzju4BYLpdy1LuFvqwRFOFzoJi6thcl2fQ/Fij0xd2/3IwGcu+b/zMBIX8WwL
         2NjS/KAfnOuQoM1NvVynGdt/dpKIrQxMRtkIJwD0uslF16Q2QVl1SlLUQjG8EgKl06fW
         lYru7GpKCjVD8HGbEYUVlARxvm4hGZ7mPeDfN303kPrnnhx9bbrod12RO3L9gv5cfXnb
         +WPGztKgOXBxAg8KGiZd49fP2UqmEuIuuZAzwo3J2mY/azQ22n03IH8zhLn6r8R5sMxl
         htbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6cth7Y463YwZNMzZQfogNVGpIY2rvKagq7dq2OfCuEU=;
        b=sKAUGX2Bl7x8Eua2Ijw+3cdadr6JAyl5O5oaMUcEnAf5drV8chjU1drcVgHC+6CBUB
         mCxdsTiarZji8N0Q/d3+ot0RObnw6h28R08XC6D5O5KRPE2fCxdP570TANLP1TqgJOAu
         eEHJDSicYniPvIvldYhayO0nDFSlKnVLeqhdiHQ/3Sf/QuVZDqexACNOA5PbUdHjhWhc
         DPNIzDxjLGX1FDi7yTaqIKJtAnbFZzfxHYw1533uc4iJXk0P5Z5EbnYh5TvFb1Hszr4q
         OouDPi1wgpkDRn2qWy98wRXL5ff8KdLAuB74DLznc+C/O4CvcVNAu+GyYgY1qfo/3YoK
         oXIg==
X-Gm-Message-State: APjAAAVRqgpFO8ohuo3hU6XgN3X0P7c/8t55HjYaoHFK8/nEstvvXtqp
        I9FG2fLaWFgd0+ieq3crudk=
X-Google-Smtp-Source: APXvYqw4SI24Ut3PNk+rbZYZVntYfcR0t4fA/mm6oqOCfYXUrDfZqCS9AKLzF3o1aoE3MBPqadTYoQ==
X-Received: by 2002:a1c:804c:: with SMTP id b73mr7625251wmd.116.1553081407535;
        Wed, 20 Mar 2019 04:30:07 -0700 (PDT)
Received: from localhost (pD9E51D2D.dip0.t-ipconnect.de. [217.229.29.45])
        by smtp.gmail.com with ESMTPSA id c10sm2757402wrt.65.2019.03.20.04.30.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Mar 2019 04:30:06 -0700 (PDT)
Date:   Wed, 20 Mar 2019 12:30:05 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH] pwm: img: Turn final 'else if' into 'else' in
 img_pwm_config
Message-ID: <20190320113005.GB23838@ulmo>
References: <20190307223628.21270-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="/NkBOFFp2J2Af1nK"
Content-Disposition: inline
In-Reply-To: <20190307223628.21270-1-natechancellor@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/NkBOFFp2J2Af1nK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 07, 2019 at 03:36:28PM -0700, Nathan Chancellor wrote:
> When building with -Wsometimes-uninitialized, Clang warns:
>=20
> drivers/pwm/pwm-img.c:126:13: error: variable 'timebase' is used
> uninitialized whenever 'if' condition is false
> [-Werror,-Wsometimes-uninitialized]
>=20
> The final else if functions as an else; make that explicit so that Clang
> understands that timebase cannot be used uninitialized.
>=20
> Link: https://github.com/ClangBuiltLinux/linux/issues/400
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  drivers/pwm/pwm-img.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks!

Thierry

--/NkBOFFp2J2Af1nK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlySJD0ACgkQ3SOs138+
s6E56A/9F05DPbUM0SbbazEQOwUiPy48Ag9mRyXsXCvhxloijwFNTHSOGJ86C/Hh
wLpYG5t47dqrnFgb3W07M2BGsEH3FyrfYRLrhYgB5M2/7Dc718TWodZfvt6jthOE
1sjFKAg1CHTt/bUNPAarq19l5ENKVrwj52auukodIUeRFQjjst4weFQ4NVmJN2rp
Yh6jHHq9VmGsNUUhw0OiIigXshIg8UQAcINvmzfK5RlAYfbp6/F37/MgBjYluV2u
C2Fb2d6s1V/5u72CdC0MD0lcbTsVZwBGdgcdPTHgW32IpToI6JkDDiIT8rDHteHE
ThVTECSLbrLRDyhFS5W2O0eoMejiiYLh01Is7es0cMXzlW9/sxia8pHdtySnD9lN
5vPT8V47Sfq+v6EvEI5m8i0u4iHdNclB4qe0pMN3pZHH3FsW/VjN4oYt9xkl3Xfm
7feiX5pI1NaVVwQ89kJaqVt/Cwmcy3HDDCmSXzXgeviDGguqnX+VD7O2iyRwPhvi
eaf8hgGrRcyM8EFtOBpz+RBeaVGA8mO3eNdzDNYHa76vdUQcoZz5ApfYgjOOgMfT
qdP864Sdc67xCdKSGxy74WDom3DLZ7OoyIiHJyWz6rbHK49abbCQSH9I7eKYFusl
zW3GxLvKpVzgkyfM4ZvjtV8Bi1YEMcAFBn4HVnzTghZIHXOxrEw=
=xI91
-----END PGP SIGNATURE-----

--/NkBOFFp2J2Af1nK--
