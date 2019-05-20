Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C2B6C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 22:38:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9F3D20862
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 22:38:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="JV1eOCLk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727143AbfETWiE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 18:38:04 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:47755 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726940AbfETWiC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 18:38:02 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 457DLb494Bz9sBV;
        Tue, 21 May 2019 08:37:59 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1558391879;
        bh=BeyfWqNI+oIVF5RDV0bxiwaxM9006vp6mwLADaT6HYE=;
        h=Date:From:To:Cc:Subject:From;
        b=JV1eOCLkUizHfbYOr+Vmo4e90WkhHwLRVLVo8po/G52ITjspj/0s8bK8l4zNVbe4d
         EBV3FswyhPYIfpUvqJgMmLZKJsikhL5aIs+2cBzeYvAErnzXl8ChSNeDrmBaOi60hV
         GVBVeHRZNpDCNXHjI+3OOR4akF7W8CXwvOEu+cGN67w4k4BZ6v8BJOwx8yeJ5evoGr
         I46EtO7ZOnAFpF4mizN8gb+Cooc49HC/6gIhk2XqWETjzKpBIZX0/FNBxLwOUckjwq
         qp8YcaDkl4hpBhdrHw56yo03G8xxDvvFCD36wHWqJyL2f7kgur2ascpmGqNomuJUF7
         taB3X3l0PcA6Q==
Date:   Tue, 21 May 2019 08:37:56 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Anson Huang <anson.huang@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>
Subject: linux-next: build failure after merge of the imx-mxs tree
Message-ID: <20190521083756.4c8aee8a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/bQg1/fUf/cfnr+0L7IqKhpx"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/bQg1/fUf/cfnr+0L7IqKhpx
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Shawn,

After merging the imx-mxs tree, today's linux-next build (arm
multi_v7_defconfig) failed like this:

drivers/clk/imx/clk.c: In function 'imx_mmdc_mask_handshake':
drivers/clk/imx/clk.c:20:8: error: implicit declaration of function 'readl_=
relaxed'; did you mean 'xchg_relaxed'? [-Werror=3Dimplicit-function-declara=
tion]
  reg =3D readl_relaxed(ccm_base + CCM_CCDR);
        ^~~~~~~~~~~~~
        xchg_relaxed
drivers/clk/imx/clk.c:22:2: error: implicit declaration of function 'writel=
_relaxed'; did you mean 'xchg_relaxed'? [-Werror=3Dimplicit-function-declar=
ation]
  writel_relaxed(reg, ccm_base + CCM_CCDR);
  ^~~~~~~~~~~~~~
  xchg_relaxed

Caused by commit

  0dc6b492b6e0 ("clk: imx: Add common API for masking MMDC handshake")

I have used the imx-mxs tree from next-20190520 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/bQg1/fUf/cfnr+0L7IqKhpx
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlzjLEQACgkQAVBC80lX
0GxtwAf/RqY1cshi846/r9/RWEOqXu5OgNeBnNXcrCxwNyIMaVG6rwHZPpBzK+2q
4NE9MlE+ZJJeou7FP3zVvQlheEGJ1/oMKIARO0us4wMroF6kiUP481uC6GcXplG6
2OqccIQi+WDH7yghtPjd12XGrXAcM++aI0ANkub9W1xUBfFV08eoViYQJtH0fP9N
rGbz5dhlS5bBPNj3lGUjzznTFEl8QQeoUKCpODh/SWluj12h7NVh7vklcpjUgT51
vr44g85ZULK6PyVre3pnveWAz04qZbUyGjRFZFINSvb4BTi4NUleZTntGXts89/1
hf641I8XVZTIhIqanvAFywSlYrUfag==
=N24Q
-----END PGP SIGNATURE-----

--Sig_/bQg1/fUf/cfnr+0L7IqKhpx--
