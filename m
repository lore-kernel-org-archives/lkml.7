Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB5CEC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 00:04:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AF132084F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 00:04:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="t16a038g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727055AbfCSAEo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 20:04:44 -0400
Received: from ozlabs.org ([203.11.71.1]:57741 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726438AbfCSAEo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 20:04:44 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44NYFj0z0jz9ryj;
        Tue, 19 Mar 2019 11:04:41 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1552953881;
        bh=6DLlDc0pFNKd4ZBLelgabQZuw9stf6lMtZqQiqPeUNs=;
        h=Date:From:To:Cc:Subject:From;
        b=t16a038ggCNCjjLfgbnBPrZJ1vnB2w9xHatWuJU7UJpHBDBq4InY+9vYX1Evomhls
         +yT32v9xffA0bysMV/iY/fAyEDj88Npxl/VI75Ve+440Y5YOAGds/e3Chk+a5e1YFu
         qGhufrvC8ulrBxBHKuBx2H8g0BQlKmMQ7PB9ml61FEQ8FNmT464TraIOWQNEHqQ3Tx
         2EhmRpQOO5Vtt63yuauqnTk8mWM9yaV6Tz6aKDzrhtGGB2DU8L6fNaziFiBOWcS+Pn
         KGcRuteXYhFR7Roe+oqdIYUbLQnfHmJETL4k1zF97taSKdnmEUZreLsGh//uN/tAmU
         b+Zp5ClIJ8yUQ==
Date:   Tue, 19 Mar 2019 11:04:39 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Francis <David.Francis@amd.com>,
        Harry Wentland <Harry.Wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Subject: linux-next: build failure after merge of the amdgpu tree
Message-ID: <20190319110439.1747b4ee@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/jzpdD3xrmVLn9CYObu4bn.s"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/jzpdD3xrmVLn9CYObu4bn.s
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the amdgpu tree, today's linux-next build (x86_64
allmodconfig) failed like this:


ERROR: "get_vupdate_offset_from_vsync" [drivers/gpu/drm/amd/amdgpu/amdgpu.k=
o] undefined!

Caused by commit

  67b112ed997b ("drm/amd/display: On DCN1, Wait for vupdate on cursor updat=
es")

I have reverted that commit for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/jzpdD3xrmVLn9CYObu4bn.s
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlyQMhcACgkQAVBC80lX
0GwJPQf7Bj0CRZpT+PjIef/Lqz9zzS6kpCEtbzH6dr/E02AxvOSEQT3XRf4eRfvS
2Rzvsx80y7x01BHJoqa4euYOwl2JVJkUD3q10ecxJSaV540wowHX4vwIf9T4cLnw
yiMEPSGltoVIY3o1ygW2EHXXxA/tlCXo/GxMd0ZGuP/yqKShhHG6y7ZfIi6LP8xo
rGmpTa3XrXXQArmO/YI5uNSHc5j5MXSxmsts/tiXkYs/Ha0sJecTCJ5EVlzDepO8
YqoPCS2yIPRdHaDRgpynx/1O7yiS0+xnlr11yTHy7j4NYptfKLp/pGI+e6WBJZ7e
Ig+xhbW47mMrspLlVJ1bPaayLX4XVg==
=DSFP
-----END PGP SIGNATURE-----

--Sig_/jzpdD3xrmVLn9CYObu4bn.s--
