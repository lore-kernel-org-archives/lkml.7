Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19354C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 21:11:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8D15206BF
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 21:11:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730505AbfH0VLY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 17:11:24 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:49232 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727064AbfH0VLX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 17:11:23 -0400
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1i2ikJ-0006SQ-9d; Tue, 27 Aug 2019 22:11:19 +0100
Received: from ben by deadeye with local (Exim 4.92.1)
        (envelope-from <ben@decadent.org.uk>)
        id 1i2ikI-0007E4-NV; Tue, 27 Aug 2019 22:11:18 +0100
Message-ID: <2b6111fbbe3f44c18c93bd247601a40986eacb22.camel@decadent.org.uk>
Subject: Re: a bug in genksysms/CONFIG_MODVERSIONS w/ __attribute__((foo))?
From:   Ben Hutchings <ben@decadent.org.uk>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        Debian kernel maintainers <debian-kernel@lists.debian.org>
Date:   Tue, 27 Aug 2019 22:11:13 +0100
In-Reply-To: <20190827170931.GA26908@kroah.com>
References: <CAKwvOdnJAApaUhTQs7w_VjSeYBQa0c-TNxRB4xPLi0Y0sOQMMQ@mail.gmail.com>
         <CAKwvOdkbY_XatVfRbZQ88p=nnrahZbvdjJ0OkU9m73G89_LRzg@mail.gmail.com>
         <1566899033.o5acyopsar.astroid@bobo.none>
         <CAK7LNARHacanVT6XjRDkFJDETWX6qHfUJCFhskCVG6aDL-bt1g@mail.gmail.com>
         <1566908344.dio7j9zb2h.astroid@bobo.none>
         <daacccf8e36132b6a747fa4b42626a8812906eaa.camel@decadent.org.uk>
         <20190827170931.GA26908@kroah.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-BE+bv3pJLifouWhO5Q8C"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-BE+bv3pJLifouWhO5Q8C
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2019-08-27 at 19:09 +0200, Greg KH wrote:
> On Tue, Aug 27, 2019 at 04:34:15PM +0100, Ben Hutchings wrote:
> > On Tue, 2019-08-27 at 22:42 +1000, Nicholas Piggin wrote:
> > > Masahiro Yamada's on August 27, 2019 8:49 pm:
[...]
> > > > modversions is ugly, so it would be great if we could dump it.
> > > >=20
> > > > > IIRC (without re-reading it all), in theory distros would be okay
> > > > > without modversions if they could just provide their own explicit
> > > > > versioning. They take care about ABIs, so they can version things
> > > > > carefully if they had to change.
> >=20
> > Debian doesn't currently have any other way of detecting ABI changes
> > (other than eyeballing diffs).
> >=20
> > I know there have been proposals of using libabigail for this instead,
> > but I'm not sure how far those progressed.
>=20
> Google has started using libabigail to track api changes in AOSP, here's
> a patch that updates the ABI file after changing it:
> 	https://android-review.googlesource.com/c/kernel/common/+/1108662
>=20
> Note, there are issues with it, and some rough edges, but I think it can
> work.

Thanks for the pointer.

> But, it means nothing at module load time, this is only at build-check
> time.  At least modversions would prevent module loading in some cases.

Right, but I *think* that would be enough if we could mark modules for
strict (exact version) or loose ("ABI version") matching as I outlined.

Ben.

--=20
Ben Hutchings
I'm always amazed by the number of people who take up solipsism because
they heard someone else explain it. - E*Borg on alt.fan.pratchett



--=-BE+bv3pJLifouWhO5Q8C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAl1lnHEACgkQ57/I7JWG
EQnH0BAAlri4E/3gs5cBbfQh5sIsnVG9aVv5R1v+vDF8+D6Cc68bnGBijEFifV94
LNiV9UvQzfkvxSNZHBAOPWZZlY3GIgWFR7IsSR539jH8QSu+8GTZyoO6ZWCx5sm7
feSSRh2KMTBhonLKRx7DzTMtI9x7UbyuxY82wESbE9BzRwUpZ/YJ1eVXByWkTsow
6OE9739/AtxDrgQ5mEhw21YVZzgf/173SsCJIZd7MwGN4Isyeetm9ZpCSQSpXez0
vlojkIlSKk1E+w2WwygxKd/nzYw/YPjfh/8HE6FvvVbdD1UcUj8o0kTjy39WVTe6
97lC0NEOA8ARgz1AIWpDt/PVYKKATm7iLGAUi5PeB42Hw4VqbuqQHhATelT8W3i2
UJ9zjeZiIWsB+hXBUB+fG3PAIebpnj4/OboTcpvPNDKxrLUSjOhqNH3yAdM7SGu/
IFUGo4ayvoXAspTxutjfhBDS6Hfd+voT79+0Za9gTsE4Awpz+soYtykwYpmZTrDc
ov5iKmEpPI+eyJwDOn0o7bdMyx1OZdGQ+3fONi45rfH3kzVVBPfdzASGcIRtBFae
xQxf9tOIKg0RKCWHKxnJ8OKQOWV05Bg0YofeSOsrO7srBbQd7WzlvH27o2Tohnb+
8BfqtvE+Wk4fyxvYQm7qhXxWxu1+9V6UCvmP3TF9UDJxCnYSXQ4=
=g4Is
-----END PGP SIGNATURE-----

--=-BE+bv3pJLifouWhO5Q8C--
