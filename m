Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3574C2D0C9
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 05:06:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 777502073D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 05:06:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="nGFdbSdv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbfLLFG1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 00:06:27 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:32907 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725813AbfLLFG1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 00:06:27 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 47YMG667Dyz9sPc;
        Thu, 12 Dec 2019 16:06:22 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1576127183;
        bh=h2xY+I1rgeAj14AaViyot9465EdSNDElCYcHjgrZX3M=;
        h=Date:From:To:Cc:Subject:From;
        b=nGFdbSdvz5l7vO6GJpLu5pQVpeGgosP1boW3fRRbV4WOSeALRu7Z4MD81pb/Cbx7w
         BsWCs0HIpP2uI+SEk54F3tX2DL+aoPrPFn1N82jpUTidrtxRWa47oksUxu0emgQG8C
         NQiT5jCFPlxrNADXD/q9isLjpsCKWkPdags+7XrTAIa9bn7TzMnkE64Nu2oVCXyqE8
         CHN6/T1d3KpBpXyFTAKmEqydPJxYm/k8GzoR2vz8rryNDpNI76YdKGmAaIuTP41ySD
         38Sod6gWjIMFDjQDnfwmePp6oNbaLVwdW6MVX+FshDnfXIC9FxYR5Bd6d+R+EbLyLM
         HS/2+zVwBUNvQ==
Date:   Thu, 12 Dec 2019 16:06:22 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>
Subject: linux-next: build warning after merge of the rcu tree
Message-ID: <20191212160622.021517d3@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/8nB_._qYAX4EMqrQPUQKKTg";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/8nB_._qYAX4EMqrQPUQKKTg
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the rcu (I think) tree, today's linux-next build (x86_64
allnoconfig) produced this warning:

kernel/time/timer.c: In function 'schedule_timeout':
kernel/time/timer.c:969:20: warning: 'timer.expires' may be used uninitiali=
zed in this function [-Wmaybe-uninitialized]
  969 |   long diff =3D timer->expires - expires;
      |               ~~~~~^~~~~~~~~

Introduced by (bisected to) commit

  c4127fce1d02 ("timer: Use hlist_unhashed_lockless() in timer_pending()")

x86_64-linux-gnu-gcc (Debian 9.2.1-21) 9.2.1 20191130

--=20
Cheers,
Stephen Rothwell

--Sig_/8nB_._qYAX4EMqrQPUQKKTg
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl3xys4ACgkQAVBC80lX
0Gy9MQf/TJBeXx00FoQvf0zg1aUpy4gj3vt68cSnDLRZKxmuFqwESzW38e+Stoeu
PHcOwTm41RTD/CUOknupMjeD1CXic/K9qer5XOWPO8wg37BdtWZD3arSEaKGs++c
K6GY/VQ2tsQXKkmFSB07a1wn50XrgmKcQpBV2SlNWQux+S2a4lt+DRaEh5S+ZuEc
t7ANRJxob6a3SbcztvaXRNUycrzfueMIrINa+VvjkG3e1gaylnZjsYjdkoj1DVSv
sV+U6Gzb2Pl4mIZtMm84gnJanET5BJe2q/Y9hUNFn0uClFbQYb1l037MUfySLGdT
era7pcR6AGytqIN9TcSEY5WgR7XpGA==
=WtFK
-----END PGP SIGNATURE-----

--Sig_/8nB_._qYAX4EMqrQPUQKKTg--
