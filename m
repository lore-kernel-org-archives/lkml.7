Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7BFDC04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 03:36:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 723BC262FD
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 03:36:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="fjvlcbES"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbfEaDgQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 23:36:16 -0400
Received: from ozlabs.org ([203.11.71.1]:36757 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726531AbfEaDgQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 23:36:16 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45FVV51C8pz9sMM;
        Fri, 31 May 2019 13:36:12 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1559273773;
        bh=GVBSMbC4SJ1Xq7zVF1fMW78OfSLanI+1kYwS3klSklw=;
        h=Date:From:To:Cc:Subject:From;
        b=fjvlcbESrEuMItiqT18jaueVoLBlVyEWqbdZvrlJbM+oOVfatjQMe83eOMwPbI7Pj
         VqvvRmLAIglOXJDFVEJBRSOxVlGflYUGn/3Xb8zOhg7iJoQUczhFRGoj2hekEekegV
         8uTkGIg2QcZE/1UwcOYMIaw+03hFatftQ0Pd73lJIfbu95c0pzHgMoqHipL6drRrfg
         VAKRFmfGALSuSaKrii33KdOsSGd6nQeRsKDp2iPdtJeMs9PL0YWNEEQszwba4VlSBn
         JOvuWokyTQzQc/5P20KoYjmGDuVB4s//tK3RjiAx5DorAAqw1PdzXH1ABwTXBQlD/D
         9ktjF3bwkjwHw==
Date:   Fri, 31 May 2019 13:36:12 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: linux-next: build warning after merge of the scsi tree
Message-ID: <20190531133612.35276ad9@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/PzGjbrYAwJiDIyGlEKhqImh"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/PzGjbrYAwJiDIyGlEKhqImh
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the scsi tree, today's linux-next build (powerpc
ppc64_defconfig) produced this warning:

drivers/scsi/ibmvscsi/ibmvscsi.c: In function 'ibmvscsi_work':
drivers/scsi/ibmvscsi/ibmvscsi.c:2151:5: warning: 'rc' may be used uninitia=
lized in this function [-Wmaybe-uninitialized]
  if (rc) {
     ^
drivers/scsi/ibmvscsi/ibmvscsi.c:2121:6: note: 'rc' was declared here
  int rc;
      ^~

Introduced by commit

  035a3c4046b5 ("scsi: ibmvscsi: redo driver work thread to use enum action=
 states")

--=20
Cheers,
Stephen Rothwell

--Sig_/PzGjbrYAwJiDIyGlEKhqImh
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlzwoSwACgkQAVBC80lX
0Gxn/gf9FlLUU9ikAUgDlMtJ/iwMNIAVIgV/ln5dZu9OiAVUwZVt27mSHvggZT15
xNVKD7BbzI5wRt3KbdEDXgvWRlmIYwwMR4ZmlqItLrEi4iYPIRE+pI0pBgfF5/hu
WTedkH1L8OG4Yt45Ty3kgLxkH2U2gdx0MM4lxa5FWtgkqwUOh+vXVTKB/MrpX2Kx
i369MQwbSdR+EFD2TPJokBqxrYjsQeHN+YYSTgCtldW/idNP4fxMuYkbcaLxF4yS
X4cuTQwC77E8h/eMhIEC6avEkoY4HYda4vIlHSjFycZ5CnoBw29d+O5YGJ0Py0/5
AeN1N0+/LHFXX3evKKzYPWPT+4rjKw==
=a1s0
-----END PGP SIGNATURE-----

--Sig_/PzGjbrYAwJiDIyGlEKhqImh--
