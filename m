Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BD43C31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 05:04:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEF3C2087B
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 05:04:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="jCRYlgzt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726842AbfHLFES (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 01:04:18 -0400
Received: from ozlabs.org ([203.11.71.1]:38077 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725838AbfHLFER (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 01:04:17 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 466Nzz1S96z9s7T;
        Mon, 12 Aug 2019 15:04:15 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1565586255;
        bh=g/gbGEpSSp1XxK5TdhN7/rcpdB+IgEK54oF96I8REFQ=;
        h=Date:From:To:Cc:Subject:From;
        b=jCRYlgztb1rZ9bFIK3tzgC07pQrjZgsa6Mzj4jjYpifcfa9DLeuyKyUF7xG8UTOHC
         tU28agsLjKsPVQ3S3K/j6gn/pw9phygEALSPz2UcCtE6/E4GkQI3h1giAyHIbkgWpw
         8wENmeD+ikiV42ya28lmtUkWEKw/JpNMKjk09VE1pu2R7N3s/ofAmCk/m8Q9RZc7ps
         Z0XHhnNCd+JEJ9Mxkf+H2SrLQ13eRcVH7xHhLjrIX1xuBuZgRr44TxxyPghIvbFIFz
         FovkM+/r1HGWICtQV6zCShj/E0Qq+PlKm0hZmC2B5Pi0lHtnH9m4BLjSGrw2/iNTGl
         N1+KbAbzem2sQ==
Date:   Mon, 12 Aug 2019 15:04:14 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     James Morris <jmorris@namei.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jiri Bohac <jbohac@suse.cz>,
        David Howells <dhowells@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        Dave Young <dyoung@redhat.com>
Subject: linux-next: build warning after merge of the security tree
Message-ID: <20190812150414.7af55bd1@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/5t=RJwaVDPInjBbOmT5vIcc";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/5t=RJwaVDPInjBbOmT5vIcc
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the security tree, today's linux-next build (powerpc
ppc64_defconfig) produced this warning:

kernel/kexec_file.c: In function 'kimage_file_prepare_segments':
kernel/kexec_file.c:189:14: warning: unused variable 'reason' [-Wunused-var=
iable]
  const char *reason;
              ^~~~~~

Introduced by commit

  47b888368923 ("kexec_file: split KEXEC_VERIFY_SIG into KEXEC_SIG and KEXE=
C_SIG_FORCE")

--=20
Cheers,
Stephen Rothwell

--Sig_/5t=RJwaVDPInjBbOmT5vIcc
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl1Q804ACgkQAVBC80lX
0GwC9gf/YVI3GGZxhwXMKDmajNP56to046Dtudrw6EGXT2m53vGXzANNQe3B5y67
OueUf442ZqhDMilJcgqR2wC9x5QQQlxneCpi5V2f2tu/6VBSOvW3uw2huqbn2pwr
OAxdEWJz1Z9tascVZ/ErEN+PSEzaR225Ncyfthv3Rb9BL+CNmgo9WydLhpdYYhS6
DlXa671lZg5+5rZj4OEMiWvEBvRtK2ZSomK6zAbsJomVDNBX8ATQiDuMUziKifWs
OhGGjS01y8v1k2DMCpFs0pHznNyJTcUMF1VObETx8aBYe9axkh/ZZDgSdCL3Munb
h+K4hMM3O8cKqB8uD43TGpeusxLJBw==
=0Ma2
-----END PGP SIGNATURE-----

--Sig_/5t=RJwaVDPInjBbOmT5vIcc--
