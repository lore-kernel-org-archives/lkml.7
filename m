Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDA4BC3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 15:34:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0C12206BF
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 15:34:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727910AbfH0Peb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 11:34:31 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:47242 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726170AbfH0Peb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 11:34:31 -0400
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1i2dUI-0004GE-5G; Tue, 27 Aug 2019 16:34:26 +0100
Received: from ben by deadeye with local (Exim 4.92.1)
        (envelope-from <ben@decadent.org.uk>)
        id 1i2dUH-0006yL-Ie; Tue, 27 Aug 2019 16:34:25 +0100
Message-ID: <daacccf8e36132b6a747fa4b42626a8812906eaa.camel@decadent.org.uk>
Subject: Re: a bug in genksysms/CONFIG_MODVERSIONS w/ __attribute__((foo))?
From:   Ben Hutchings <ben@decadent.org.uk>
To:     Nicholas Piggin <npiggin@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        Debian kernel maintainers <debian-kernel@lists.debian.org>
Date:   Tue, 27 Aug 2019 16:34:15 +0100
In-Reply-To: <1566908344.dio7j9zb2h.astroid@bobo.none>
References: <CAKwvOdnJAApaUhTQs7w_VjSeYBQa0c-TNxRB4xPLi0Y0sOQMMQ@mail.gmail.com>
         <CAKwvOdkbY_XatVfRbZQ88p=nnrahZbvdjJ0OkU9m73G89_LRzg@mail.gmail.com>
         <1566899033.o5acyopsar.astroid@bobo.none>
         <CAK7LNARHacanVT6XjRDkFJDETWX6qHfUJCFhskCVG6aDL-bt1g@mail.gmail.com>
         <1566908344.dio7j9zb2h.astroid@bobo.none>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-M8fZOvUYsySZrgN6hjpJ"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-M8fZOvUYsySZrgN6hjpJ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2019-08-27 at 22:42 +1000, Nicholas Piggin wrote:
> Masahiro Yamada's on August 27, 2019 8:49 pm:
> > Hi.
> >=20
> > On Tue, Aug 27, 2019 at 6:59 PM Nicholas Piggin <npiggin@gmail.com> wro=
te:
> > > Nick Desaulniers's on August 27, 2019 8:57 am:
> > > > On Mon, Aug 26, 2019 at 2:22 PM Nick Desaulniers
> > > > <ndesaulniers@google.com> wrote:
> > > > > I'm looking into a linkage failure for one of our device kernels,=
 and
> > > > > it seems that genksyms isn't producing a hash value correctly for
> > > > > aggregate definitions that contain __attribute__s like
> > > > > __attribute__((packed)).
> > > > >=20
> > > > > Example:
> > > > > $ echo 'struct foo { int bar; };' | ./scripts/genksyms/genksyms -=
d
> > > > > Defn for struct foo =3D=3D <struct foo { int bar ; } >
> > > > > Hash table occupancy 1/4096 =3D 0.000244141
> > > > > $ echo 'struct __attribute__((packed)) foo { int bar; };' |
> > > > > ./scripts/genksyms/genksyms -d
> > > > > Hash table occupancy 0/4096 =3D 0
> > > > >=20
> > > > > I assume the __attribute__ part isn't being parsed correctly (loo=
ks
> > > > > like genksyms is a lex/yacc based C parser).
> > > > >=20
> > > > > The issue we have in our out of tree driver (*sadface*) is basica=
lly a
> > > > > EXPORT_SYMBOL'd function whose signature contains a packed struct=
.
> > > > >=20
> > > > > Theoretically, there should be nothing wrong with exporting a fun=
ction
> > > > > that requires packed structs, and this is just a bug in the lex/y=
acc
> > > > > based parser, right?  I assume that not having CONFIG_MODVERSIONS
> > > > > coverage of packed structs in particular could lead to potentiall=
y
> > > > > not-fun bugs?  Or is using packed structs in exported function sy=
mbols
> > > > > with CONFIG_MODVERSIONS forbidden in some documentation somewhere=
 I
> > > > > missed?
> > > >=20
> > > > Ah, looks like I'm late to the party:
> > > > https://lwn.net/Articles/707520/
> > >=20
> > > Yeah, would be nice to do something about this.
> >=20
> > modversions is ugly, so it would be great if we could dump it.
> >=20
> > > IIRC (without re-reading it all), in theory distros would be okay
> > > without modversions if they could just provide their own explicit
> > > versioning. They take care about ABIs, so they can version things
> > > carefully if they had to change.

Debian doesn't currently have any other way of detecting ABI changes
(other than eyeballing diffs).

I know there have been proposals of using libabigail for this instead,
but I'm not sure how far those progressed.

> > We have not provided any alternative solution for this, haven't we?
> >=20
> > In your patch (https://lwn.net/Articles/707729/),
> > you proposed CONFIG_MODULE_ABI_EXPLICIT.
>=20
> Right, that was just my first proposal, but I am not confident that I
> understood everybody's requirements. I don't think the distro people
> had much time to to test things out.
>=20
> One possible shortcoming with that patch is no per-symbol version. The=
=20
> distro may break an ABI for a security fix, but they don't want to break
> all out of tree modules if it's an obscure ABI.

Right, for example the KVM kABI is only meant for in-tree modules (like
kvm_intel) and in Debian we do not change the "ABI version" and require
rebuilding out-of-tree modules just because that ABI changes.=20
Currently we maintain explicit lists of exported symbols and exporting
modules for which we ignore ABI changes at build time.

> The counter argument to=20
> that is they should just rename the symbol in their kernel for such=20
> cases, so I didn't implement it without somebody describing a good
> requirement.
[...]

Sometimes it is just a single function that changes, but often a
structure change can affect large numbers of functions.  For example,
if KVM adds a member to an operations struct that can indirectly change
the ABI for most of its exported functions.  We wouldn't want to change
the ABI version but would still want to prevent loading mismatched kvm
and kvm_intel versions.  It would be a lot more work to change all of
the affected function names.

An alternative to symbol version matching that I think would work for
us is: if a module's exports or imports match the "changes ignored"
list then the module can only be loaded on the exact version of the
kernel, otherwise it only needs to match the ABI version.  I think that
would avoid the need for carrying symbol versions, but we would still
need a build-time ABI check and a way of flagging which symbols need
the tighter version match.

Ben.

--=20
Ben Hutchings
I'm always amazed by the number of people who take up solipsism because
they heard someone else explain it. - E*Borg on alt.fan.pratchett



--=-M8fZOvUYsySZrgN6hjpJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAl1lTXcACgkQ57/I7JWG
EQkyMBAAmBY7qrN2ClR38KfBrGphPE2ygTwHin6uUojtqSvUNUULMAIeibALH5/y
zEPantIq5VKJr0FP2PlBEcmB/fl/fugTBSjGyeKGAKsaoKZ9GT+FPlWMvuyG5FeR
1ui2bBUGoMv5V+IVA62As38Vf/2YYJziN21XcRP3InriAiRJ/5qyxg73Hq02FQST
g3W1uJ5UVvoYc8BYCi6l3SF05go7eOsnIHh8VwiDbfkQwFB5oPNkUZdN+dcl18Dc
cj1r/itgTQV9epv9JoBcc05sXHsW9ieyiiF70W5Zw5wWbFf6imCrWpwLenzI5FXE
aPwCJmJcJC+kYI4J7gbEGaOxLGHoddfYIYgVY4QP3wzB9kVC+5vNoBz3yR0WczBT
PLte+PjTYe9EXprn+6yKZ1tAuUxsKQSXyE3a88zVKufPiE0RoyydVZ1uT9mNDCac
msW4sgwoe6mT10jo6nJnk6tgkHcYa5KxkKBxNviUSwSoWG/ruREu5053f/OsXVKD
PGHl6sB9qXHAHxVPDsbSOVQgwS06GBQUkcz+pbMxq//wmdP17opfMnMjELY/AbSG
Vlp1mDha4LqVHtFQzMjkfAKe4ZsIkpkS/gGC6tIComR+JDgYvRjjJ6AKJ1d1DdP0
KHfNu++Tcu/CfXmfP954IE/YyCWKZFPVR7F0KzZwGC+dWnkXL1g=
=VC7W
-----END PGP SIGNATURE-----

--=-M8fZOvUYsySZrgN6hjpJ--
