Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48D87C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 20:32:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0362E218AE
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 20:32:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="dDu/d82Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733015AbfB1Ucr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 15:32:47 -0500
Received: from ozlabs.org ([203.11.71.1]:48121 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726926AbfB1Ucr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 15:32:47 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 449PPQ43lqz9s70;
        Fri,  1 Mar 2019 07:32:42 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1551385964;
        bh=7ZUBRTTm81Dii7ohiwqEoFKuY/SfkluhBUrk7dYvQqA=;
        h=Date:From:To:Cc:Subject:From;
        b=dDu/d82YHd4wN4NANpAgutkG5IUO1nwV40HcXIuQaMiOAmGYz7V/iW+GYsiSQTmIb
         O1kPh6oXRS0T75SzBPzbcMKC5jb2u63h+TrIvmECEwDkyQ5OJsXHErQquu2TxD3s4C
         GUGcdiAX/ud94qADMsZZuo6wJM6iQOAbDYDLWUYPpiMPWC15pzkNTCrulL7ObP71Om
         ACTHRdY4SupKmalH5a4ViiYKSR+zScbENMi8lsb50GvZTkcKVF33wtojSHMEv62HUV
         dyptIJul3DQ0SXflBxt4qCeCbTfREk4SUvCE69I9RpeU8mM9YtC7mOsddMIHHA3Sl9
         gGBKV2Yb2jTSw==
Date:   Fri, 1 Mar 2019 07:32:34 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sheng Lan <lansheng@huawei.com>,
        Eric Dumazet <edumazet@google.com>
Subject: linux-next: Fixes tag needs some work in the net tree
Message-ID: <20190301073217.27931d39@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/bM4IbjYuQmcKHRbQQr/M=Xc"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/bM4IbjYuQmcKHRbQQr/M=Xc
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  5845f706388a ("net: netem: fix skb length BUG_ON in __skb_to_sgvec")

Fixes tag

  Fixes: 35d889d1 ("sch_netem: fix skb leak in netem_enqueue()")

has these problem(s):

  - SHA1 should be at least 12 digits long
    Can be fixed by setting core.abbrev to 12 (or more) or (for git v2.11
    or later) just making sure it is not set (or set to "auto").

--=20
Cheers,
Stephen Rothwell

--Sig_/bM4IbjYuQmcKHRbQQr/M=Xc
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlx4RWIACgkQAVBC80lX
0Gw8Ygf/UaRvRGAtenDvUlJUKnjMq92Wjj0CTC5JI0qgG8LA5cxCSR1lu6mWl2Gn
8YELN2PALK6mP9rhzdhVRms3AZ9xmwGJ0+4zH5Hj4jRAWrM+UCxN3bezRlRlzQ8R
/TDqPZkHuMAy4ge5LI78mJvjNYylD0RL1mh/n519b1ZbE6Z3sbPOJAL+6X64dvAN
PrAJfaEx33tlSZIAHREe9O4LSFz/ruJaYvC2V4atSbQDoh7QYOoKbSbk1IrR2XjF
5w0cwFM4TACVxzY6208L7SHMHTjdmaaC4WlBh20Gm9btxbdRRQRBjE2lKwTFbQDP
JU6Q3gd/9VDX9z66j2debUjFgDa+HQ==
=YzC3
-----END PGP SIGNATURE-----

--Sig_/bM4IbjYuQmcKHRbQQr/M=Xc--
