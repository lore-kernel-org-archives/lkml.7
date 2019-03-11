Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 469E1C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:13:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0546520657
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:13:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727291AbfCKNNq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 09:13:46 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:42637 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbfCKNNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 09:13:45 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 3728F805DA; Mon, 11 Mar 2019 14:13:35 +0100 (CET)
Date:   Mon, 11 Mar 2019 14:13:41 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     corbet@lwn.net, LKML <linux-kernel@vger.kernel.org>,
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
Message-ID: <20190311131341.GA28223@amd>
References: <alpine.DEB.2.21.1812200022580.1651@nanos.tec.linutronix.de>
 <20190102235152.GA24163@amd>
 <20190311102109.GA14118@amd>
 <alpine.DEB.2.21.1903111403330.1691@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="lrZ03NoBR/3+SXJZ"
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1903111403330.1691@nanos.tec.linutronix.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2019-03-11 14:05:07, Thomas Gleixner wrote:
> On Mon, 11 Mar 2019, Pavel Machek wrote:
> > On Thu 2019-01-03 00:51:52, Pavel Machek wrote:
> > > Hi!
> > >=20
> > > > The next round of speculation-related issues including the scary L1=
TF
> > > > hardware bug was a way more "pleasant" experience to work on. While=
 for
> > > > obvious reasons the mitigation development happened behind closed d=
oors in
> > > > a smaller group of people, we were at least able to collaborate in =
a way
> > > > which is somehow close to what we are used to.
> > >=20
> > > Ok, I guess L1TF was a lot of fun, and there was not time for a good
> > > documentation.
> > >=20
> > > There's admin guide that is written as an advertisment, and
>=20
> What's advertisement there?

"No problem here, no performance issues, nothing to be seen unless you
are running VM."

> > > unfortunately is slightly "inaccurate" at places (to the point of
> > > lying).
>=20
> Huch? Care to tell what's a lie instead of making bold statements?

Take a care to look at the patch I submitted?

Lie:

# A system with an up to date kernel is protected against attacks from
# malicious user space applications.

3GB system running 32bit kernel is not protected. Same is true for for
really big 64bit systems.

If I do what dmesg suggests, this becomes untrue:

# The Linux kernel contains a mitigation for this attack vector, PTE
# inversion, which is permanently enabled and has no performance
# impact.

Limiting memory to 2GB _is_ going to have severe perfomance impact.

								Pavel

commit 9664b4dabdb132433a6843aefe05814953f1342f
Author: Pavel <pavel@ucw.cz>
Date:   Thu Jan 3 00:48:40 2019 +0100

    Ok, I guess L1TF was a lot of fun, and there was not time for a good
    documentation.
   =20
    There's admin guide that is written as an advertisment, and
    unfortunately is slightly "inaccurate" at places (to the point of
    lying).
   =20
    Plus, I believe it should go to x86/ directory, as this is really
    Intel issue, and not anything ARM (or RISC-V) people need to know.
   =20
    Signed-off-by: Pavel Machek <pavel@ucw.cz>

diff --git a/Documentation/admin-guide/l1tf.rst b/Documentation/admin-guide=
/l1tf.rst
index 9af9773..05c5422 100644
--- a/Documentation/admin-guide/l1tf.rst
+++ b/Documentation/admin-guide/l1tf.rst
@@ -1,10 +1,11 @@
 L1TF - L1 Terminal Fault
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
-L1 Terminal Fault is a hardware vulnerability which allows unprivileged
-speculative access to data which is available in the Level 1 Data Cache
-when the page table entry controlling the virtual address, which is used
-for the access, has the Present bit cleared or other reserved bits set.
+L1 Terminal Fault is a hardware vulnerability on most recent Intel x86
+CPUs which allows unprivileged speculative access to data which is
+available in the Level 1 Data Cache when the page table entry
+controlling the virtual address, which is used for the access, has the
+Present bit cleared or other reserved bits set.
=20
 Affected processors
 -------------------
@@ -76,12 +77,14 @@ Attack scenarios
    deterministic and more practical.
=20
    The Linux kernel contains a mitigation for this attack vector, PTE
-   inversion, which is permanently enabled and has no performance
-   impact. The kernel ensures that the address bits of PTEs, which are not
-   marked present, never point to cacheable physical memory space.
-
-   A system with an up to date kernel is protected against attacks from
-   malicious user space applications.
+   inversion, which is permanently enabled and has no measurable
+   performance impact in most configurations. The kernel ensures that
+   the address bits of PTEs, which are not marked present, never point
+   to cacheable physical memory space. On x86-32, this physical memory
+   needs to be limited to 2GiB to make mitigation effective.
+
+   Mitigation is present in kernels v4.19 and newer, and in
+   recent -stable kernels.
=20
 2. Malicious guest in a virtual machine
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^


--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--lrZ03NoBR/3+SXJZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlyGXwUACgkQMOfwapXb+vJFoQCfWZDKue2kMKNscc4j/gsZ8GnD
VcIAniqQ8g91FoiTBoojnhz44ehgnvDr
=xJ1/
-----END PGP SIGNATURE-----

--lrZ03NoBR/3+SXJZ--
