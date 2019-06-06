Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC234C28CC5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 00:34:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7ED9020872
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 00:34:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="dAlpqFAE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbfFFAed (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 20:34:33 -0400
Received: from ozlabs.org ([203.11.71.1]:39681 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726532AbfFFAed (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 20:34:33 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45K69g0rTrz9s3l;
        Thu,  6 Jun 2019 10:34:31 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1559781271;
        bh=tq3+bNdoKDR+n9hVF1HK/+s0rAY2G/RUg5oBu0MDm+s=;
        h=Date:From:To:Cc:Subject:From;
        b=dAlpqFAEPcABugq5Cc7gs1c2Xfjj/CxaNfttoWi/GwD/C75WhMOnEU8tuV4TRO21O
         nH20DpQ6R5R5PW1BpcttNautrP4ldPuUenZRKGfBydT65Kqjfn4y5ScEVcYkC7m7UL
         cTh/Vq53G7Cg/jh6eVv+7z+kWguXI/4Tea507VubtCzCM/aFm/EkOZ9I7H3PyhDgn2
         jnOtQ7HJXAUxeQQloN9F8dcwwvQJaPnOPMDUVpEEYD1rHLSIwszJ42QhsRuILynesj
         vj15ZCtbq4GZ588bXHzFeyquRLbxYkFSMRqQs8qVUduNQHGcWGjoHHzET8K6+JnWDx
         JuosxXVQnzSPw==
Date:   Thu, 6 Jun 2019 10:34:30 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Krzysztof Adamski <krzysztof.adamski@nokia.com>,
        Alexander Sverdlin <alexander.sverdlin@nokia.com>
Subject: linux-next: build warning after merge of the hwmon-staging tree
Message-ID: <20190606103430.74fd20f2@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/9Cdgb7hx.tTijwoz1+CEvz9"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/9Cdgb7hx.tTijwoz1+CEvz9
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the hwmon-staging tree, today's linux-next build (x86_64
allmodconfig) produced this warning:

drivers/hwmon/pmbus/adm1275.c: In function 'adm1275_write_pmon_config':
drivers/hwmon/pmbus/adm1275.c:179:23: warning: unused variable 'data' [-Wun=
used-variable]
  struct adm1275_data *data =3D to_adm1275_data(info);
                       ^~~~

Introduced by commit

  438318513375 ("hwmon: (pmbus/adm1275) support PMBUS_VIRT_*_SAMPLES")

--=20
Cheers,
Stephen Rothwell

--Sig_/9Cdgb7hx.tTijwoz1+CEvz9
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlz4X5YACgkQAVBC80lX
0Gy3pggAg48LSZEwJebd/U5f1t5qtcKCS8AFR0oh8ih2l9IH1GUJI06zuANxEsNO
i1dN13XbK74e5HbG+4WtG9ga3NZnLBmpHUAzKcPlsjN8UxFxwwuIvnzv3hpDo0Z6
ArPolFacivIY3T2suBIY2vBZ5pK9747ZSqpLs20ylgbsovN1x45c3c5sFlMPe77F
JJ5ahPFfkBwfppLqZlETugnAwIsQVELsx1ttC2uW2CC4HP9CdVp8JxqbisK5qGXR
6tYGGGwgwc0ZGclFSJWCXDuah/Bc3e+TRQmbmFTCxNupE3nLQvJdiKrZP0qUJUPq
E+BssmFMpTOyG7dTxxp8Di5WxpaULQ==
=jaZm
-----END PGP SIGNATURE-----

--Sig_/9Cdgb7hx.tTijwoz1+CEvz9--
