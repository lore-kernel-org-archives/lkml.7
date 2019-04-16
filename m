Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7EF1C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 08:54:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D2BF20868
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 08:54:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="e1qTt/6v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728853AbfDPIyA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 04:54:00 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:35831 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726917AbfDPIx7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 04:53:59 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44jzgS5wHmz9s3l;
        Tue, 16 Apr 2019 18:53:56 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1555404837;
        bh=4LZpdkzAAb6xcMkY9hrs2knER0i5d3ddm6JSYFixsT8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=e1qTt/6vz7bLK3ZkjAGK2IPEzWr/FsZa09L9xkgS9LQwBkpMLg5FNFEwMwIyYzJi2
         OG5tmfTyobzBDe+jlqIqJT4U+NJEno1yV3DLMgREn7SVVzrHLoPunJEN5JmNn2m46v
         Y2aa/bwr3qKwI6XjSD/npR54VMDJkyNM+aKL3m+NiSDwc0a/gKf0xbsEAkkICCpE8g
         WgvURH5wVN9WdCJjV4f6pVKl9Pm8OMljwuaKl+y8zW9mH+1/akwNnhuraSP+uM993w
         MdkjxA4YGCuXHdESwC8lqRIQdoWiLoWT7Yt8Qon1wdrMZlAds0Q8qpehifxCs4Iz0+
         MTFJYGpqXGLRw==
Date:   Tue, 16 Apr 2019 18:53:27 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kees Cook <keescook@chromium.org>, Jann Horn <jannh@google.com>
Subject: Re: [PATCH] kernel/compat.c: mark expected switch fall-throughs
Message-ID: <20190416185327.5c129073@canb.auug.org.au>
In-Reply-To: <CAK8P3a31Cp_COwjuOm6uG_23M3Ys4tJTB33jBENj-so0jkhgzg@mail.gmail.com>
References: <20190416172937.6a7621f7@canb.auug.org.au>
        <CAK8P3a31Cp_COwjuOm6uG_23M3Ys4tJTB33jBENj-so0jkhgzg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/8xcDDK.D_AWd64QfaDUIJ6N"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/8xcDDK.D_AWd64QfaDUIJ6N
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Arnd,

On Tue, 16 Apr 2019 10:32:55 +0200 Arnd Bergmann <arnd@arndb.de> wrote:
>
> Acked-by: Arnd Bergmann <arnd@arndb.de>

Thanks

> It's a bit inconsistent though since put_compat_sigset() has the
> comments in separate lines, as of commit 89976005536c
> ("include/linux/compat.h: mark expected switch fall-throughs").

OK, I wasn't aware of that one.

> I don't care either way, but it might be better to do it the same way
> for both.

Indeed, I will redo it that way (with your Acked-by).

> We could also consider just getting rid of put_compat_sigset() and
> get_compat_sigset() but replacing them with a combined
> put_sigset()/get_sigset() that does the right thing for both native
> and compat tasks. This lets us kill a couple of compat system
> calls that only differ in their sigset_t argument. On little-endian
> systems (which are the vast majority of the installed base), there
> is no difference anyway there is no overhead anyway since
> native and compat sigset_t are identical.

That sounds like a bigger patch that would require some real testing :-)

--=20
Cheers,
Stephen Rothwell

--Sig_/8xcDDK.D_AWd64QfaDUIJ6N
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAly1mAcACgkQAVBC80lX
0GzWPgf8Cx27EoDmu6ot7P/Q77fOmChW6X0hAqILgvlS1xTrmpSJepfv1cvo98Vk
mD+gBqbEz/us88Dppy7l0oTmNZLpr0Svr7eXWZpEWzwFzbZy3FES/UC272cZKwRB
eqj2Yb/63ap299nGUC06/LIt2yRpioRqVdaLA/tDc8MCSj1Mt5SNlOlO8Og7mP0L
jnMLXG6W8BtSeIJb8BdgUnvNMzgXTMmeyEx3u21kbCZVtcq7+DeHjKQhX5dmb796
w06Mc9ENFw9OSgpgio6320RMwh3epkFhRgO2QVXFMCvmPKcHgk7MejtJqKFIaKVL
XRPR0lYqOLTiD+kpboW7X04OUYtEvw==
=UV9l
-----END PGP SIGNATURE-----

--Sig_/8xcDDK.D_AWd64QfaDUIJ6N--
