Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90857C06510
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 03:53:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B96A20836
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 03:53:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="rqWtEOj2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbfGBDxL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 23:53:11 -0400
Received: from ozlabs.org ([203.11.71.1]:52713 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726434AbfGBDxK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 23:53:10 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45d9Lq4dwVz9s4V;
        Tue,  2 Jul 2019 13:53:07 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1562039587;
        bh=MkJwD4pjMs/8oJOmOSRghhqAhq5x1w7PSQ8DblZHZXY=;
        h=Date:From:To:Cc:Subject:From;
        b=rqWtEOj2iCeEi1o0LkgNgneHxxzd2uHjrTuyRul3aF6TvXvmVffN1b5W2x14KO1Fe
         Leb9pCA2eC+Mk5emaTLj10le7vVMSTcKvN4GFvRMEvzfmEBIUamBDlko2QJWGU3rpL
         t9kk9gml7HxNJCYTalDSoVC4okPceMsj4rrcLIorr8Ty6KrVluTr3ilfpYQ/7cNjtl
         6z2BPKItRAco91bgiy9maXYuKhL3skqVk4WC1F6iKkSsNl+24Gj921LgCRVKlg/000
         hD+h26LH/0cb51OUFH1PJq3QdBSG4aSEQAaK+jKpNFhFYF3CEfOpHPseiO52e5bjCM
         xc3t9BsLvRKIw==
Date:   Tue, 2 Jul 2019 13:53:07 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jack Xiao <Jack.Xiao@amd.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>
Subject: linux-next: build warning after merge of the amdgpu tree
Message-ID: <20190702135307.43a332a5@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/B=fJl4k7K8g2/T3B5HdUyEk"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/B=fJl4k7K8g2/T3B5HdUyEk
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the amdgpu tree, today's linux-next build (x86_64
allmodcnofig) produced this warning:

drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_device.c: In function 'kgd2kfd_pro=
be':
drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_device.c:490:6: warning: unused va=
riable 'ret' [-Wunused-variable]
  int ret;
      ^~~

Introduced by commit

  aabf3a951c4e ("drm/amdkfd: remove duplicated PCIE atomics request")

--=20
Cheers,
Stephen Rothwell

--Sig_/B=fJl4k7K8g2/T3B5HdUyEk
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0a1SMACgkQAVBC80lX
0GzghQf+Jar7CYzMM77A1grMh1h9UggttF/24JGLxrHtSPB8R0crv1rVbeBJQAVD
aZQoeTmloYsxf5ogSjjFF+EXpOZjyG00UVdM4mOjLZHDDIlhZvo49CnLezh2WHHd
cVPHmmwY+l+7GP0XPUFiNqAGNVAIMqiivf8Ls80V6SZuhfxa9MEuLhyZv0JQw4A1
wJNpwiU8An65SZUiT14zupMS/WMafcuzluW432Iqrd9bQMRYbAGNqqH3jAA8QNlH
8AsWFB0RfBB6/DQtz833yfjEvpSADvH6Ak5rKejM8nQrIeRI+AjW/CjOVIkhyT8F
taZq1/WjPMN9VjNS3ABlumdr51rh/g==
=oIQU
-----END PGP SIGNATURE-----

--Sig_/B=fJl4k7K8g2/T3B5HdUyEk--
