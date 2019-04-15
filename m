Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 393C6C10F13
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 00:55:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F008E2070D
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 00:55:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="SNXcD+L6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726556AbfDOAzE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Apr 2019 20:55:04 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:37649 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726159AbfDOAzD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Apr 2019 20:55:03 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44j95J44kzz9s00;
        Mon, 15 Apr 2019 10:54:59 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1555289701;
        bh=+Vt705o2HBYSkWCQ0ORKuLMIjjuIGmUYQQ0k0cyu1Uk=;
        h=Date:From:To:Cc:Subject:From;
        b=SNXcD+L6w17OjmtSC4Weng3IQgeTilOXkEBqtDjeOzApmsK80oRXrUqESv1XX+wa1
         aLqlLHL/ioDxgKuCU6CfaSV8JTAbeeipIAybtEu0b+pWSM+lPZwS8Dk7avrLmOzMHt
         HDtoPbEsKk5E3FDxiF/Lo9l2cc61utuQeXvdn6UI52UF9KBcaiRZ1tbBjCUdMaQgj7
         Zm3cEUev8GdumzQPnaIsm5VytBP2sr7OnXDDHx9sxmbonkbXnbp3Pb10j1mBc2Pf2u
         ioToGt7kFWCQerWkxdqZ98DoJiD1Q4gPqzi5souzZGGDD5pyVA7LXwDVHj5QYSWIp9
         SiYy/g5SUDvjQ==
Date:   Mon, 15 Apr 2019 10:54:58 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ursula Braun <ubraun@linux.ibm.com>
Subject: linux-next: manual merge of the net-next tree with the net tree
Message-ID: <20190415105458.63e97507@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/9IVzHh9R+LIuEYUBeldkTc+"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/9IVzHh9R+LIuEYUBeldkTc+
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the net-next tree got a conflict in:

  net/smc/af_smc.c

between commit:

  07603b230895 ("net/smc: propagate file from SMC to TCP socket")

from the net tree and commit:

  50717a37db03 ("net/smc: nonblocking connect rework")

from the net-next tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc net/smc/af_smc.c
index 6f869ef49b32,e066899de72d..000000000000
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@@ -457,9 -447,10 +455,10 @@@ static void smc_switch_to_fallback(stru
  /* fall back during connect */
  static int smc_connect_fallback(struct smc_sock *smc, int reason_code)
  {
 -	smc->use_fallback =3D true;
 +	smc_switch_to_fallback(smc);
  	smc->fallback_rsn =3D reason_code;
  	smc_copy_sock_settings_to_clc(smc);
+ 	smc->connect_nonblock =3D 0;
  	if (smc->sk.sk_state =3D=3D SMC_INIT)
  		smc->sk.sk_state =3D SMC_ACTIVE;
  	return 0;
@@@ -783,16 -780,10 +788,14 @@@ static void smc_connect_work(struct wor
  		smc->sk.sk_err =3D -rc;
 =20
  out:
 -	if (smc->sk.sk_err)
 -		smc->sk.sk_state_change(&smc->sk);
 -	else
 -		smc->sk.sk_write_space(&smc->sk);
 +	if (!sock_flag(&smc->sk, SOCK_DEAD)) {
 +		if (smc->sk.sk_err) {
 +			smc->sk.sk_state_change(&smc->sk);
 +		} else { /* allow polling before and after fallback decision */
 +			smc->clcsock->sk->sk_write_space(smc->clcsock->sk);
 +			smc->sk.sk_write_space(&smc->sk);
 +		}
 +	}
- 	kfree(smc->connect_info);
- 	smc->connect_info =3D NULL;
  	release_sock(&smc->sk);
  }
 =20
@@@ -1244,19 -1215,11 +1232,14 @@@ static void smc_listen_work(struct work
  	struct socket *newclcsock =3D new_smc->clcsock;
  	struct smc_clc_msg_accept_confirm cclc;
  	struct smc_clc_msg_proposal *pclc;
- 	struct smc_ib_device *ibdev;
+ 	struct smc_init_info ini =3D {0};
  	bool ism_supported =3D false;
- 	struct smcd_dev *ismdev;
  	u8 buf[SMC_CLC_MAX_LEN];
- 	int local_contact =3D 0;
- 	unsigned short vlan;
- 	int reason_code =3D 0;
  	int rc =3D 0;
- 	u8 ibport;
 =20
 +	if (new_smc->listen_smc->sk.sk_state !=3D SMC_LISTEN)
 +		return smc_listen_out_err(new_smc);
 +
  	if (new_smc->use_fallback) {
  		smc_listen_out_connected(new_smc);
  		return;

--Sig_/9IVzHh9R+LIuEYUBeldkTc+
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlyz1mIACgkQAVBC80lX
0GwZcQf+OTmWmq3W322azok557zqAjW9aiOq74uyx9jXfo31KW8aHV+GWvpPv9rx
hl+v5w9lnh/FxaVi8vH6+h4B+DezAZ3B6X01ieWXLWNxTsTnTUMysMAXPXINHVZ5
xX62gQeU0zhDKOCGePSOdK0SHO5s0umGZFHFGqkBXjYymn6jczhCOPkT1MrNJLro
39rm11aAONKddxwcXBZQuk71COkqZcLirrLK7CQ3m9EMm9ALNpEyRrRykK+f54GR
+uZxdOMzCQlyIzn2PZJr1cZxMpte32GEo9aT0HMRFvTI+jAopALi7zOtvwYrWjhJ
tbgf9meIxJJhWXHYiaoRJCFZClaXZA==
=MwTp
-----END PGP SIGNATURE-----

--Sig_/9IVzHh9R+LIuEYUBeldkTc+--
