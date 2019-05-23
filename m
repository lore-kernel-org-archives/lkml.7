Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FE81C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 22:29:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD34C20879
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 22:29:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="KnktJHet"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388396AbfEWW3e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 18:29:34 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:52055 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387616AbfEWW3e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 18:29:34 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45941Q1cSPz9sBr;
        Fri, 24 May 2019 08:29:29 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1558650571;
        bh=oZ+Y4Oj9nlfaxg+9a4yhZHeUnYqYAt63cgwtgI91vS0=;
        h=Date:From:To:Cc:Subject:From;
        b=KnktJHetT3IepuRUUS14pUn3nwEyKmleQnnr37irUY8y32u0aQQiIh4o5/oVTuyh0
         oTqkISOqntV6hscMwoWTDUTLk+F2VpQGy1FJT7KRapF4wfKKx5V3zhaPyLwPYtbY+f
         q61LWFQ13oAtfXv0l5LXT2sPAirPEHIFXG5eBIU9ZtJpFgbFJkJUXHo0HSb3ykQkGz
         Nqta7ZZSGaIR4Buo3UoocOYIFSLZ3ivnqscB/2exCa3r10JYoC1yYdU1inKONZfZoq
         yMEt4vG8bA+FzvumnhNIYt8doHwhH82l1cXgND9Xwjfp5YKs74HIV3Nj94jCYXmoRh
         rYb7tcTWX7BoA==
Date:   Fri, 24 May 2019 08:29:26 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Dave Airlie <airlied@linux.ie>,
        DRI <dri-devel@lists.freedesktop.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Harry Wentland <harry.wentland@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Subject: linux-next: build failure after merge of the drm-fixes tree
Message-ID: <20190524082926.6e1a7d8f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/3/vL9jhrSoegPrs8wupWN73"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/3/vL9jhrSoegPrs8wupWN73
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the drm-fixes tree, today's linux-next build (x86_64
allmodconfig) failed like this:

drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c: In function 'l=
oad_dmcu_fw':
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:667:7: error: i=
mplicit declaration of function 'ASICREV_IS_PICASSO'; did you mean 'ASICREV=
_IS_VEGA12_P'? [-Werror=3Dimplicit-function-declaration]
   if (ASICREV_IS_PICASSO(adev->external_rev_id))
       ^~~~~~~~~~~~~~~~~~
       ASICREV_IS_VEGA12_P

Caused by commit

  55143dc23ca4 ("drm/amd/display: Don't load DMCU for Raven 1")

I have reverted that commit for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/3/vL9jhrSoegPrs8wupWN73
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlznHsYACgkQAVBC80lX
0Gxiqgf/TX+jNEffQfpsZ0K5DEdyod6S5jH6C3F8/4luruSvyxWOVsJkfo3n7+eY
G3FgBMxNkwfk/gNzHujp7JwZ1cyONguMQhUd/MgTWdLtu8tj0sELLLxrLecDJtJA
ru1k5stROtvFEFJBt7ttqyQyqUQTCIH29WPrmnRDOlspkhVC9nnY1EaHhIjGJZkq
4Z1AmffQnv4BI0riIg+6EDgM8GlzkopAqn0JkSLXqXrlYyN7o9SyNoh/JsunmF02
+ySAqwq7WO3aAxGUAx24aO8MCJbFw6ZfwAZk+tF6h/28sV0Mkqs9p91uFmxFMqB/
d00p8y1eDXWFDmkJpd+l+HIXXMEP7w==
=XBe4
-----END PGP SIGNATURE-----

--Sig_/3/vL9jhrSoegPrs8wupWN73--
