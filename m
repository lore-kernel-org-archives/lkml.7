Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 438A4C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 13:50:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B74C2133D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 13:50:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726844AbfDKNup (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 09:50:45 -0400
Received: from mx1.emlix.com ([188.40.240.192]:35534 "EHLO mx1.emlix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726106AbfDKNuo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 09:50:44 -0400
Received: from mailer.emlix.com (unknown [81.20.119.6])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.emlix.com (Postfix) with ESMTPS id BFC3460A29;
        Thu, 11 Apr 2019 15:50:42 +0200 (CEST)
From:   Rolf Eike Beer <eb@emlix.com>
To:     nicolas.dichtel@6wind.com
Cc:     tglx@linutronix.de, jpoimboe@redhat.com,
        yamada.masahiro@socionext.com, peterz@infradead.org,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH linux] objtool: fix pkg-config query in case of cross-compilation
Date:   Thu, 11 Apr 2019 15:50:38 +0200
Message-ID: <8596683.VRQu17hJsJ@devpool35>
Organization: emlix GmbH
In-Reply-To: <cc009072-64d4-4be3-0bb2-20be4d5c357f@6wind.com>
References: <20190411083940.3911-1-nicolas.dichtel@6wind.com> <4208204.4d101oJ1v5@devpool35> <cc009072-64d4-4be3-0bb2-20be4d5c357f@6wind.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart25922085.1yZWV1yWd9"; micalg="pgp-sha256"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart25922085.1yZWV1yWd9
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

Am Donnerstag, 11. April 2019, 11:26:12 CEST schrieb Nicolas Dichtel:
> Le 11/04/2019 =C3=A0 10:52, Rolf Eike Beer a =C3=A9crit :
> > Am Donnerstag, 11. April 2019, 10:39:40 CEST schrieb Nicolas Dichtel:
> >> In case of cross-compilation, there may be two pkg-config tools, one f=
or
> >> the host and one for the target. Enable to override the default name.
> >>=20
> >> Fixes: 056d28d135bc ("objtool: Query pkg-config for libelf location")
> >> Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
> >=20
> > If you do that, you have to fix a lot of other places, too. This starts=
 in
> > scripts/kconfig/ and also includes e.g. tools/testing/.
> >=20
> > Usually you have pkg-config for host and ${target_platform}-pkg-config =
for
> > the
> My use case was for buildroot, which define pkg-config and host-pkgconf. =
In
> fact, I've just seen that a buildroot patch was accepted for this problem:
> https://patchwork.ozlabs.org/patch/1081379/

I agree that it makes sense to have both host and target pkg-config=20
configurable. But IMHO that must happen in a central place (i.e. ./Makefile=
),=20
and it has to be used everywhere. Currently PKG_CONFIG is defined at multip=
le=20
places, sometimes host, sometimes target, and often pkg-config is called=20
directly, also mixing both usages.

So, IMHO, if you want to fix this: fix it once and for all in the whole=20
kernel, not just one place. What I have introduced was just the same as=20
kconfig is using to find the dependencies for some of the *config variants,=
 so=20
this usecase would break for you anyway, although I don't think anyone in=20
buildroot will notice this.

Eike
=2D-=20
Rolf Eike Beer, emlix GmbH, http://www.emlix.com
=46on +49 551 30664-0, Fax +49 551 30664-11
Gothaer Platz 3, 37083 G=C3=B6ttingen, Germany
Sitz der Gesellschaft: G=C3=B6ttingen, Amtsgericht G=C3=B6ttingen HR B 3160
Gesch=C3=A4ftsf=C3=BChrung: Heike Jordan, Dr. Uwe Kracke =E2=80=93 Ust-IdNr=
=2E: DE 205 198 055

emlix - smart embedded open source
--nextPart25922085.1yZWV1yWd9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iLMEAAEIAB0WIQQ/Uctzh31xzAxFCLur5FH7Xu2t/AUCXK9GLgAKCRCr5FH7Xu2t
/IMzA/9KVFJHOFsFzEsPSePEIO0p72hbQiOatEVw4FNMH7nv39WZhSAHaJbCKm/G
nWUazMsIdG4bnaAY4yYisROyKtxHwAvbntrJWZjBTNidxTylLpPbFEeB9tR70sHN
I/wkPPJu6Qjd6Nho1i7wCkzH9h+UAvJcoLoO1eDDQ3v/8GWtcg==
=d+N0
-----END PGP SIGNATURE-----

--nextPart25922085.1yZWV1yWd9--



