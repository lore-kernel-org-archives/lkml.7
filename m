Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC0FFC43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 11:36:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95500206BF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 11:36:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726173AbfDZLgW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 07:36:22 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:51828 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725881AbfDZLgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 07:36:22 -0400
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1hJz9J-0006Cs-9i; Fri, 26 Apr 2019 12:36:13 +0100
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1hJz9I-00031x-R3; Fri, 26 Apr 2019 12:36:12 +0100
Message-ID: <0c6ecfca6329f0d11c6962ec5875314414813ac6.camel@decadent.org.uk>
Subject: Re: BUG: unable to handle page fault for address = ADDR
From:   Ben Hutchings <ben@decadent.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        syzbot <syzbot+45474c076a4927533d2e@syzkaller.appspotmail.com>
Cc:     David Miller <davem@davemloft.net>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Netdev <netdev@vger.kernel.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        peter@hurleysoftware.com,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        vegard.nossum@gmail.com
Date:   Fri, 26 Apr 2019 12:36:07 +0100
In-Reply-To: <CAHk-=wjp-R083To=AVbovNJWrskNfYN8rqz=nZZTPRihCohE4g@mail.gmail.com>
References: <0000000000000101b30587622a69@google.com>
         <CAHk-=wjp-R083To=AVbovNJWrskNfYN8rqz=nZZTPRihCohE4g@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-daXTa50vFJ89HdnXzyFp"
User-Agent: Evolution 3.30.5-1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-daXTa50vFJ89HdnXzyFp
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2019-04-25 at 16:13 -0700, Linus Torvalds wrote:
[...]
> so we do "slhc_free()" on an error pointer, which results in
>=20
>     BUG: unable to handle page fault for address =3D fffffffffffffff4
>=20
> and the fix might be something like the appended whitespace-damaged
> trivial one-liner: just make slhc_free() silently ignore an error
> pointer, to match the slhc_init() return behavior.
>=20
> Ben? David?

This looks sensible to me.

Ben.

>                        Linus
>=20
> diff --git a/drivers/net/slip/slhc.c b/drivers/net/slip/slhc.c
> index f4e93f5fc204..ea90db3c7705 100644
> --- a/drivers/net/slip/slhc.c
> +++ b/drivers/net/slip/slhc.c
> @@ -153,7 +153,7 @@ slhc_init(int rslots, int tslots)
>  void
>  slhc_free(struct slcompress *comp)
>  {
> -       if ( comp =3D=3D NULLSLCOMPR )
> +       if ( IS_ERR_OR_NULL(comp) )
>                 return;
>=20
>         if ( comp->tstate !=3D NULLSLSTATE )
--=20
Ben Hutchings
It is impossible to make anything foolproof
because fools are so ingenious.


--=-daXTa50vFJ89HdnXzyFp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAlzC7ScACgkQ57/I7JWG
EQk2yBAAvmqpyQJnSkFayIHpelfD1ed0i3WvJSIY2n9Z3cDCsKYj28+Qi5rnMVlD
JST69B4oh0Jbcx8JK1hZtYON0X7GfZ2JkxUgtNiD9U5qL54uph4ds4BOJRg1EWh1
p6LIYEt3OfvxGasF0KQzwa7+7XupK5cXORv/sg8J4AUtamKx278Jdg5lOFOCOXEU
InEzNEZicz6MNQdUevf0GLq9llgavMxcI58Pk0VmnaEN3JcJ4AoHRv8muPjSl3kh
rrG2gtUK3fq0Q4AgQvc1om4fXgEhTEMqATVeLwtKs75ZYZew3x3EhsGd0YYbnol8
upDkJKUdZzyL4QE1ZiZsjRsEWDi/11Ucg5fU0TMpaiDoz9fIscN6SHAexBNf4XsI
uW9A9R/pDu9fUsWfcNsh7gYPwPcBzhRgJsqypNZimQ8fqxGog1yeRSQKJLXQdUoB
SynBByMsMUyi0HPHwTsIeqghyxjK1SfS/ERwXVHOhY6M2u2QU8cwH8/2HWMzrMkv
C92F12IgNGB4kEkrJHy65NBQdIyevrpBQ6mm4jNrpjOQuVpqw7CaedebEMdbIMbj
A2mNbWrkDFVceErZheFxnv+JqUOuoqrInol/err3n69Xc+lLE8+0F69+pOYEwLMw
Jqdqdjkf6ti89hjzYldwYDEQevXNygugzOUmGNWv5TfyDSfZNNA=
=aQUL
-----END PGP SIGNATURE-----

--=-daXTa50vFJ89HdnXzyFp--
