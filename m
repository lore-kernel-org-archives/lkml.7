Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64278C33C99
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 02:18:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FE8D2075A
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 02:18:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="QStACAlT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726390AbgAHCSY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 21:18:24 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:46517 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725601AbgAHCSX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 21:18:23 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 47stFm2M4vz9sRW;
        Wed,  8 Jan 2020 13:18:20 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1578449900;
        bh=J9U58Znf8bHL9kE6aoehNBTNsV4IgbrJUvdMVKwcmO4=;
        h=Date:From:To:Cc:Subject:From;
        b=QStACAlTnsTy6ODMMvTQrFio1D7DfQxegByY+QSgYDi+Cmn9akAzR8PJd8aLCvxdz
         24BTgyIDFvYQh9S9Z6SNy2Doar/3Uf8SmUHTlaSh9OUttAIClXgpIuGUOOx668yyat
         L9gu4gjJtrx7FYjShLataTN4980whjEim7TDzG4SvcBmkM/e01b8qKCS9fl0mlpwDQ
         qFLDoYq/5Y7Gq8D9sPZKHqKvGjAQIunnLn+9oGC7ouXg+OdDi0EVxD8V/YsQHOEgjU
         nKbqvCndUaK4O3ToXHlI/a2QLwR9QK/0M3kKm92RlLsdXFj1iyMsNqQCz+FTSMDYVO
         AFCg0d63b1Ryg==
Date:   Wed, 8 Jan 2020 13:18:19 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Francis <David.Francis@amd.com>
Subject: linux-next: build failure after merge of the amdgpu tree
Message-ID: <20200108131819.469f0084@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/A+1aukA=qyKkGGsHKVskDLM";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/A+1aukA=qyKkGGsHKVskDLM
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the amdgpu tree, today's linux-next build (x86_64
allmodconfig) failed like this:

ERROR: "dcn20_add_dsc_to_stream_resource" [drivers/gpu/drm/amd/amdgpu/amdgp=
u.ko] undefined!
ERROR: "dc_dsc_parse_dsc_dpcd" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undef=
ined!
ERROR: "dc_dsc_get_policy_for_timing" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko=
] undefined!
ERROR: "dc_dsc_compute_bandwidth_range" [drivers/gpu/drm/amd/amdgpu/amdgpu.=
ko] undefined!
ERROR: "dc_dsc_compute_config" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undef=
ined!

I am not sure what caused this.

I have used the amdgpu tree from next-20200107 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/A+1aukA=qyKkGGsHKVskDLM
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl4VO+sACgkQAVBC80lX
0Gzm7wf+OPr+rihhlmX+6kVjwIa8XtXqzIuAx8gIdVX1blt7RvhIGPzqwBmlafk1
SmJ5pjQGWNUaIP3Ke6qcvHwzdq051Hv15T2soSgNb4iWkc/ntG0C4TOPaERxOO4t
SYFqwEvdb1+8Ab3Ib71DUE46zanm5Th650Q/neCXDy29uTGXWOR+vzMKlosupYoS
sxSJ+lQhwuCIspX5P9nsssmJw4ghJNZ5QNp6zSMGg4o/6MXa72DSxEviabJBj2GP
gLnXeMuqxcrNWVAXtcp/KvHVubNsib1tLqE4DJiYYU3Y14cRXXXfSugVpHjXrDDt
pZhsFDlW2CG8fmfYMWxzLEeKEMMqjQ==
=EsCS
-----END PGP SIGNATURE-----

--Sig_/A+1aukA=qyKkGGsHKVskDLM--
