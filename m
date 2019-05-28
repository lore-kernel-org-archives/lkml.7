Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D97DC072B1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 11:54:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14B9F2075B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 11:54:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726909AbfE1Lys (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 07:54:48 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:35181 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726580AbfE1Lyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 07:54:47 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 7B43E80324; Tue, 28 May 2019 13:54:34 +0200 (CEST)
Date:   Tue, 28 May 2019 13:54:44 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Hugh Dickins <hughd@google.com>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>, x86@kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Borislav Petkov <bp@suse.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: My emacs problem -- was Re: [PATCH] x86/fpu: Use
 fault_in_pages_writeable() for pre-faulting
Message-ID: <20190528115443.GA27627@amd>
References: <20190526173325.lpt5qtg7c6rnbql5@linutronix.de>
 <20190526173501.6pdufup45rc2omeo@linutronix.de>
 <alpine.LSU.2.11.1905261211400.2004@eggly.anvils>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="3V7upXqbjpZ4EhLz"
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.11.1905261211400.2004@eggly.anvils>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

On Sun 2019-05-26 12:25:27, Hugh Dickins wrote:
> On Sun, 26 May 2019, Sebastian Andrzej Siewior wrote:
> > On 2019-05-26 19:33:25 [+0200], To Hugh Dickins wrote:
> > From: Hugh Dickins <hughd@google.com>
> > =E2=80=A6
> > > Signed-off-by: Hugh Dickins <hughd@google.com>
> >=20
> > Hugh, I took your patch, slapped a signed-off-by line. Please say that
> > you are fine with it (or object otherwise).
>=20
> I'm fine with it, thanks Sebastian. Sorry if I wasted your time by not
> giving it my sign-off in the first place, but I was not comfortable to
> dabble there without your sign-off too - which it now has. (And thought
> you might already have your own version anyway: just provided mine as
> illustration, so that we could be sure of exactly what I'd been testing.)

I applied Hugh's patch on top of -rc2, but still get emacs problems:

But this time I'm not sure if it is same emacs problem or different
emacs problem....

X protocol error: BadValue (integer parameter out of range for
operation) on protocol request 139
When compiled with GTK, Emacs cannot recover from X disconnects.
This is a GTK bug: https://bugzilla.gnome.org/show_bug.cgi?id=3D85715
For details, see etc/PROBLEMS.

(emacs:8175): GLib-WARNING **: g_main_context_prepare() called
recursively from within a source's check() or prepare() member.

(emacs:8175): GLib-WARNING **: g_main_context_check() called
recursively from within a source's check() or prepare() member.
Fatal error 6: Aborted
Backtrace:
emacs[0x8138719]
emacs[0x8120446]
emacs[0x813875c]
emacs[0x80f54c0]
emacs[0x80f6f3f]
emacs[0x80f6fab]
/usr/lib/i386-linux-gnu/libX11.so.6(_XError+0x11a)[0xf6ea1b3a]
/usr/lib/i386-linux-gnu/libX11.so.6(+0x39b5b)[0xf6e9eb5b]
/usr/lib/i386-linux-gnu/libX11.so.6(+0x39c26)[0xf6e9ec26]
/usr/lib/i386-linux-gnu/libX11.so.6(_XEventsQueued+0x6e)[0xf6e9f4be]
/usr/lib/i386-linux-gnu/libX11.so.6(XPending+0x62)[0xf6e90752]
/usr/lib/i386-linux-gnu/libgdk-3.so.0(+0x48073)[0xf7566073]
/lib/i386-linux-gnu/libglib-2.0.so.0(g_main_context_prepare+0x17b)[0xf70244=
fb]
/lib/i386-linux-gnu/libglib-2.0.so.0(+0x46f74)[0xf7024f74]
/lib/i386-linux-gnu/libglib-2.0.so.0(g_main_context_pending+0x34)[0xf702514=
4]
/usr/lib/i386-linux-gnu/libgtk-3.so.0(gtk_events_pending+0x1f)[0xf77c9a8f]
emacs[0x80f55a9]
emacs[0x812714f]
emacs[0x8126a95]
emacs[0x8172db9]
emacs[0x8192bd7]
emacs[0x819312d]
emacs[0x8125634]
emacs[0x8125c6d]
emacs[0x812725b]
emacs[0x8129eaa]
emacs[0x81c7c90]
emacs[0x8127815]
emacs[0x812ada3]
emacs[0x812bdad]
emacs[0x812d838]
emacs[0x818b76c]
emacs[0x8120890]
emacs[0x818b66b]
emacs[0x8124b84]
emacs[0x8124e3f]
emacs[0x8059cb0]
/lib/i386-linux-gnu/i686/cmov/libc.so.6(__libc_start_main+0xf3)[0xf61a7a63]
emacs[0x805a76f]
Aborted (core dumped)

Best regards,
									Pavel


commit 018c9da72adf920efd0ba250fcf433b836d3cfbc
Author: Hugh Dickins <hughd@google.com>
Date:   Sun May 26 19:33:25 2019 +0200

    x86/fpu: Use fault_in_pages_writeable() for pre-faulting
   =20
    Since commit
   =20
       d9c9ce34ed5c8 ("x86/fpu: Fault-in user stack if copy_fpstate_to_sigf=
rame() fails")
   =20
    we use get_user_pages_unlocked() to pre-faulting user's memory if a
    write generates a page fault while the handler is disabled.
    This works in general and uncovered a bug as reported by Mike Rapoport.
   =20
    It has been pointed out that this function may be fragile and a
    simple pre-fault as in fault_in_pages_writeable() would be a better
    solution. Better as in taste and simplicity: That write (as performed by
    the alternative function) performs exactly the same faulting of memory
    that we had before. This was suggested by Hugh Dickins and Andrew
    Morton.
   =20
    Use fault_in_pages_writeable() for pre-faulting of user's stack.
   =20
    Suggested-by: Andrew Morton <akpm@linux-foundation.org>
    Signed-off-by: Hugh Dickins <hughd@google.com>
    Link: https://lkml.kernel.org/r/alpine.LSU.2.11.1905251033230.1112@eggl=
y.anvils
    [bigeasy: patch description]
    Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index 5a8d118..060d618 100644
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -5,6 +5,7 @@
=20
 #include <linux/compat.h>
 #include <linux/cpu.h>
+#include <linux/pagemap.h>
=20
 #include <asm/fpu/internal.h>
 #include <asm/fpu/signal.h>
@@ -189,15 +190,7 @@ int copy_fpstate_to_sigframe(void __user *buf, void __=
user *buf_fx, int size)
 	fpregs_unlock();
=20
 	if (ret) {
-		int aligned_size;
-		int nr_pages;
-
-		aligned_size =3D offset_in_page(buf_fx) + fpu_user_xstate_size;
-		nr_pages =3D DIV_ROUND_UP(aligned_size, PAGE_SIZE);
-
-		ret =3D get_user_pages_unlocked((unsigned long)buf_fx, nr_pages,
-					      NULL, FOLL_WRITE);
-		if (ret =3D=3D nr_pages)
+		if (!fault_in_pages_writeable(buf_fx, fpu_user_xstate_size))
 			goto retry;
 		return -EFAULT;
 	}



--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--3V7upXqbjpZ4EhLz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlztIYMACgkQMOfwapXb+vI75ACdHJt+UjplhowDy8ZXEkJhicP0
z70Anih1OGc59Aa8Dl3kUnN28Z4i83Dy
=94bm
-----END PGP SIGNATURE-----

--3V7upXqbjpZ4EhLz--
