Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2A90C32753
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 06:16:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF537206A2
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 06:16:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="aGQD9zZP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727299AbfGaGQd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 02:16:33 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:40853 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725871AbfGaGQd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 02:16:33 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45z38s5l8Lz9sBF;
        Wed, 31 Jul 2019 16:16:29 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1564553790;
        bh=RjggibSCwHEvmitFOU351CfCAHNFU+f9gYdeHS0rz/4=;
        h=Date:From:To:Cc:Subject:From;
        b=aGQD9zZPBUs1S5W4LL3CiLH+t0cHADJj4QDJHGH/6rdssf5kbDce46WPB8fO19F4b
         CchJuLykZmzj5f0ZCDaM1ic0Gk6tgtFmdmuUkVX1xgTXWYJbryBk0UDpsFrmn9xFdM
         KAdTHrPR62fATm1iLp8sfz99sTB5BYtniejCOCdcvm+F5UP2KakEMnIlSFLWtMKYwT
         42f3YHnQfLIejZftrHzwtmHUD4JI7wYtxgPfdkYodLUakc/o2ZSpJLH2Mk8lqljohb
         fW+4P4MFpf2L+M8qS+QldDv4Dfu0vm6DHO16lzmP8YueWne4rlyQwRptEDDpI2pymo
         dLuZhFbh6dt6A==
Date:   Wed, 31 Jul 2019 16:16:29 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jia-Ju Bai <baijiaju1990@gmail.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>
Subject: linux-next: build warning after merge of the akpm-current tree
Message-ID: <20190731161629.4a20a23d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/2O9vfEIaU/ity45KHFFYutT";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/2O9vfEIaU/ity45KHFFYutT
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the akpm-current tree, today's linux-next build (x86_64
allmodconfig) produced this warning:

fs/ocfs2/xattr.c:1493:13: warning: 'ocfs2_xa_add_entry' defined but not use=
d [-Wunused-function]
 static void ocfs2_xa_add_entry(struct ocfs2_xa_loc *loc, u32 name_hash)
             ^~~~~~~~~~~~~~~~~~

Introduced by commit

  45d9aa3d263d ("fs: ocfs2: fix possible null-pointer dereferences in ocfs2=
_xa_prepare_entry()")

--=20
Cheers,
Stephen Rothwell

--Sig_/2O9vfEIaU/ity45KHFFYutT
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl1BMj0ACgkQAVBC80lX
0Gz3/Af/ctvhY0sjP4Q84oxOWmfZYMQjNlgQv2dCkJ6tJHbKl4M67kuoHdYx9kGc
6uGSoFfR5lHWkRuDP7gJFNd5vCdtVJvsQ1TiNIpKy03cmnPV3h8LBCC+/wFQbPat
kd0500qFXZlrrSUm88fU4C0UNJ8WmKTTquMtdMn1YmIloWdnRtLg63laVSybQURr
PzXvbQlNRe3xVmpEQ8zQWjVVx2NlWxqXxw7le9nLGhQ/o2FaHTBbxRsbMDarEhcI
Jcq6xVVeemcekYBkO4jrs7QgYeVJy887k1//quU/s49qEl1yx+V/dWfql9DVqrd5
en80mTBnKhUX6PaK6CQRCLUCP0Yj/w==
=s2Ez
-----END PGP SIGNATURE-----

--Sig_/2O9vfEIaU/ity45KHFFYutT--
