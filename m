Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3599C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 10:21:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9B1F2077B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 10:21:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727164AbfCKKVP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 06:21:15 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:52411 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726826AbfCKKVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 06:21:14 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id E8841806EF; Mon, 11 Mar 2019 11:21:03 +0100 (CET)
Date:   Mon, 11 Mar 2019 11:21:10 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Thomas Gleixner <tglx@linutronix.de>, corbet@lwn.net
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Jiri Kosina <jkosina@suse.cz>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Joerg Roedel <joro@8bytes.org>,
        Tony Luck <tony.luck@intel.com>,
        Salvatore Bonaccorso <carnil@debian.org>,
        linux-doc@vger.kernel.org
Subject: Re: [patch] Fix up l1ft documentation was Re: Taking a break - time
 to look back
Message-ID: <20190311102109.GA14118@amd>
References: <alpine.DEB.2.21.1812200022580.1651@nanos.tec.linutronix.de>
 <20190102235152.GA24163@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="yrj/dFKFPuw6o+aM"
Content-Disposition: inline
In-Reply-To: <20190102235152.GA24163@amd>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Ping? Jonathan, can you pick this up?

								Pavel

On Thu 2019-01-03 00:51:52, Pavel Machek wrote:
> Hi!
>=20
> > The next round of speculation-related issues including the scary L1TF
> > hardware bug was a way more "pleasant" experience to work on. While for
> > obvious reasons the mitigation development happened behind closed doors=
 in
> > a smaller group of people, we were at least able to collaborate in a way
> > which is somehow close to what we are used to.
>=20
> Ok, I guess L1TF was a lot of fun, and there was not time for a good
> documentation.
>=20
> There's admin guide that is written as an advertisment, and
> unfortunately is slightly "inaccurate" at places (to the point of
> lying).
>=20
> Plus, I believe it should go to x86/ directory, as this is really
> Intel issue, and not anything ARM (or RISC-V) people need to
> know. (But we already have some urls in printk messages that may need
> fixing up..?)
>=20
> Signed-off-by: Pavel Machek <pavel@ucw.cz>
>=20
> diff --git a/Documentation/admin-guide/l1tf.rst b/Documentation/admin-gui=
de/l1tf.rst
> index b85dd80..05c5422 100644
> --- a/Documentation/admin-guide/l1tf.rst
> +++ b/Documentation/admin-guide/l1tf.rst
> @@ -1,10 +1,11 @@
>  L1TF - L1 Terminal Fault
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =20
> -L1 Terminal Fault is a hardware vulnerability which allows unprivileged
> -speculative access to data which is available in the Level 1 Data Cache
> -when the page table entry controlling the virtual address, which is used
> -for the access, has the Present bit cleared or other reserved bits set.
> +L1 Terminal Fault is a hardware vulnerability on most recent Intel x86
> +CPUs which allows unprivileged speculative access to data which is
> +available in the Level 1 Data Cache when the page table entry
> +controlling the virtual address, which is used for the access, has the
> +Present bit cleared or other reserved bits set.
> =20
>  Affected processors
>  -------------------
> @@ -76,12 +77,14 @@ Attack scenarios
>     deterministic and more practical.
> =20
>     The Linux kernel contains a mitigation for this attack vector, PTE
> -   inversion, which is permanently enabled and has no performance
> -   impact. The kernel ensures that the address bits of PTEs, which are n=
ot
> -   marked present, never point to cacheable physical memory space.
> +   inversion, which is permanently enabled and has no measurable
> +   performance impact in most configurations. The kernel ensures that
> +   the address bits of PTEs, which are not marked present, never point
> +   to cacheable physical memory space. On x86-32, this physical memory
> +   needs to be limited to 2GiB to make mitigation effective.
> =20
> -   A system with an up to date kernel is protected against attacks from
> -   malicious user space applications.
> +   Mitigation is present in kernels v4.19 and newer, and in
> +   recent -stable kernels.
> =20
>  2. Malicious guest in a virtual machine
>  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> @@ -405,6 +408,9 @@ time with the option "l1tf=3D". The valid arguments f=
or this option are:
> =20
>    off		Disables hypervisor mitigations and doesn't emit any
>  		warnings.
> +		It also drops the swap size and available RAM limit restrictions
> +		on both hypervisor and bare metal.
> +
>    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> =20
>  The default is 'flush'. For details about L1D flushing see :ref:`l1d_flu=
sh`.
> @@ -576,7 +582,8 @@ Default mitigations
>    The kernel default mitigations for vulnerable processors are:
> =20
>    - PTE inversion to protect against malicious user space. This is done
> -    unconditionally and cannot be controlled.
> +    unconditionally and cannot be controlled. The swap storage is limited
> +    to ~16TB.
> =20
>    - L1D conditional flushing on VMENTER when EPT is enabled for
>      a guest.
>=20
>=20
>=20
>=20



--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--yrj/dFKFPuw6o+aM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlyGNpUACgkQMOfwapXb+vKiDgCgtX6pZRkVG8IoNFM6ogIeUHpV
rosAnRmq2iQ9hio1Nmiz3Lffu+AFi072
=3m6h
-----END PGP SIGNATURE-----

--yrj/dFKFPuw6o+aM--
