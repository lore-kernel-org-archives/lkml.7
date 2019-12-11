Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6A09C2D0C6
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 21:36:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8B6A21556
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 21:36:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="gLEnbhS3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbfLKVgD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 16:36:03 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:46167 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726368AbfLKVgC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 16:36:02 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 47Y9GQ51xvz9sPh;
        Thu, 12 Dec 2019 08:35:58 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1576100159;
        bh=lE4ga3un2BmYAqGPl0pdVuTEBxEYuZnWQG6fmK6yUt8=;
        h=Date:From:Cc:Subject:From;
        b=gLEnbhS3fWjQZ6y03RjsHld97n7nZPGsQFLQYWhnuMlU+RVzKR0l8AmyzD+vrU6X5
         7kcAgYqnpR7o8MjQUK7ohnYvCHYJFxBry2cvWE5TKDu/c7IkVxX7EthlUaP5CIqS48
         ieQ3+KMHEorQKZ4Ubx6+raTLYjhC7jEo1X3PUEID0eVW2uhaZndV/SQvzlTfmUEF30
         Ns3A49abYyqGj/1R2Z1vJfM3RTInMeVvBo9zKMUL/nLtQLYb1gcqXHc4hhVRPbK64m
         y6ET6Uq8+TYEerns5fei0h4+EmUsif0fqDx7yelwu+jAbbS+mv6pt5iI+rw5xLoBSw
         NSNWVEmHIOtOQ==
Date:   Thu, 12 Dec 2019 08:35:56 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Lucas Stach <l.stach@pengutronix.de>
Subject: linux-next: build failure after merge of the imx-mxs tree
Message-ID: <20191212083556.1b98ece7@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/0D4KnxzN1+oUJb2C=QBLHC/";
 protocol="application/pgp-signature"; micalg=pgp-sha256
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/0D4KnxzN1+oUJb2C=QBLHC/
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the imx-mxs tree, today's linux-next build (arm
multi_v7_defconfig) failed like this:

Error: arch/arm/boot/dts/imx6ull-colibri.dtsi:536.4-5 syntax error
FATAL ERROR: Unable to parse input tree
make[2]: *** [scripts/Makefile.lib:285: arch/arm/boot/dts/imx6ull-colibri-w=
ifi-eval-v3.dtb] Error 1
Error: arch/arm/boot/dts/imx6ull-colibri.dtsi:536.4-5 syntax error
FATAL ERROR: Unable to parse input tree
make[2]: *** [scripts/Makefile.lib:285: arch/arm/boot/dts/imx6ull-colibri-e=
val-v3.dtb] Error 1
arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi:422.28-424.7: Warning (graph_endpoi=
nt): /soc/aips-bus@2100000/i2c@21a0000/edp-bridge@68/ports/port@2/endpoint:=
 graph connection to node '/panel/port/endpoint' is not bidirectional
arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi:422.28-424.7: Warning (graph_endpoi=
nt): /soc/aips-bus@2100000/i2c@21a0000/edp-bridge@68/ports/port@2/endpoint:=
 graph connection to node '/panel/port/endpoint' is not bidirectional

Caused by commit

  e7ebb215cb78 ("ARM: dts: colibri-imx6ull: correct wrong pinmuxing and add=
 comments")

The warning was (probably) introduced by commit

  e79295edf1df ("ARM: dts: imx6: RDU2: link eDP bridge to panel")

I have used the imx-mxs tree from next-20191211 for today.
--=20
Cheers,
Stephen Rothwell

--Sig_/0D4KnxzN1+oUJb2C=QBLHC/
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl3xYTwACgkQAVBC80lX
0GxxeQf+MVSQ3KvS5tgYNta+1Bt5soEbKEhL5nshnsu8KF13EaWoK95Nogdf1Vwk
6kik5S5D5LBDRhrROQzcg7Fy3AOj/THWZf45KTjxxTxZMSG2CEbb+itpjE1q40+G
UNiRwaE6adG56s9WR/SuznvaTYCVTYRhUCy0lFojQ/6dMYaKt+9wsUlYc/aWCp0G
Dg6aBIF0Jd/fJLW4LzyxT+EYKOlZyBkeZf7dkztCYV4x4T8EX+OZrAPxivNLxAkO
fdzasixi5vBkKchoPJlru/zO8AB7tTnxHFRz3vLYoDU9jRsXVpXbCnvscMMM9Lql
ZiCrzTevcMhh1iwAccz+gELpyr1bFA==
=S+nk
-----END PGP SIGNATURE-----

--Sig_/0D4KnxzN1+oUJb2C=QBLHC/--
