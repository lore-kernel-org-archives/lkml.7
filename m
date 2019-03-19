Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E268C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 21:51:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 070152146E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 21:51:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="ZzVpye8l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727210AbfCSVvV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 17:51:21 -0400
Received: from ozlabs.org ([203.11.71.1]:54943 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726784AbfCSVvU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 17:51:20 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44P6FJ5cLPz9sBp;
        Wed, 20 Mar 2019 08:51:16 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1553032278;
        bh=xFWnKOibxlW+QQixST4hmzvrqFXNoeUMXKcr4lOOcVM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZzVpye8lF1x9wP6p0afCXWiwXfUalNydgLA/SR2STICVbq63MbNL9xjmROE7NuJ63
         nO4vDRH2p5CeuZ631eKDq4/z8stz66JZ4EAl091WDhErkrLAQX8MV5SfuGOQTBnIXz
         L7rTUH+BL2KVMgqtfUWrkwpkFqIhkBrW1CKtvc/LwNM8R75/l8sqviQitIEW856fHw
         Fp+ZhseTyvOCnzw4cCkZfpz/HUN9DPf/X4SiV3oBXGk0r3K5L5lAps5ZglaSyxWj/h
         cWlkd5laaQF0v8+tm4+RrFZEee0niw4I9PV6i05rbuyICvPHGaXbX+bHeuRsCTlfCq
         qGoipDgBw3GMQ==
Date:   Wed, 20 Mar 2019 08:51:14 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Jerome Glisse <jglisse@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: Re: [PATCH 00/10] HMM updates for 5.1
Message-ID: <20190320085114.3c60ccce@canb.auug.org.au>
In-Reply-To: <20190319101249.d2076f4bacbef948055ae758@linux-foundation.org>
References: <20190129165428.3931-1-jglisse@redhat.com>
        <20190313012706.GB3402@redhat.com>
        <20190313091004.b748502871ba0aa839b924e9@linux-foundation.org>
        <20190318170404.GA6786@redhat.com>
        <20190319094007.a47ce9222b5faacec3e96da4@linux-foundation.org>
        <20190319165802.GA3656@redhat.com>
        <20190319101249.d2076f4bacbef948055ae758@linux-foundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/rZ_YS7Q3KOb_0EEI.p64CGi"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/rZ_YS7Q3KOb_0EEI.p64CGi
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On Tue, 19 Mar 2019 10:12:49 -0700 Andrew Morton <akpm@linux-foundation.org=
> wrote:
>
> Yes, a resend against mainline with those various updates will be
> helpful.  Please go through the various fixes which we had as well:
>=20
> mm-hmm-use-reference-counting-for-hmm-struct.patch
> mm-hmm-do-not-erase-snapshot-when-a-range-is-invalidated.patch
> mm-hmm-improve-and-rename-hmm_vma_get_pfns-to-hmm_range_snapshot.patch
> mm-hmm-improve-and-rename-hmm_vma_fault-to-hmm_range_fault.patch
> mm-hmm-improve-driver-api-to-work-and-wait-over-a-range.patch
> mm-hmm-improve-driver-api-to-work-and-wait-over-a-range-fix.patch
> mm-hmm-improve-driver-api-to-work-and-wait-over-a-range-fix-fix.patch
> mm-hmm-add-default-fault-flags-to-avoid-the-need-to-pre-fill-pfns-arrays.=
patch
> mm-hmm-add-an-helper-function-that-fault-pages-and-map-them-to-a-device.p=
atch
> mm-hmm-support-hugetlbfs-snap-shoting-faulting-and-dma-mapping.patch
> mm-hmm-allow-to-mirror-vma-of-a-file-on-a-dax-backed-filesystem.patch
> mm-hmm-allow-to-mirror-vma-of-a-file-on-a-dax-backed-filesystem-fix.patch
> mm-hmm-allow-to-mirror-vma-of-a-file-on-a-dax-backed-filesystem-fix-2.pat=
ch
> mm-hmm-add-helpers-for-driver-to-safely-take-the-mmap_sem.patch

I have dropped all those from linux-next today (along with
mm-hmm-fix-unused-variable-warnings.patch).

--=20
Cheers,
Stephen Rothwell

--Sig_/rZ_YS7Q3KOb_0EEI.p64CGi
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlyRZFIACgkQAVBC80lX
0Gw81AgAnXTKZqmeBZ4XjAsL8P7H6EEBR0UIaAyWsozfkZPGrrTgSMamze/8WwWu
JaraU0UrKqcUviCT1rKDjxiNThMMbiWqdR6q4GlndWsBUjWTp9Kdis1qBzKG84pb
j0p+0oPChjQTUkDnJ+sDu4kNzKzsI/dnELnv0eD7CBD6/7fMs0cZqPcIWOx8gU6C
ZjFRZ3rL1x62j+XQV6Soi75OUmmK3B09pcGSoveJcnczUYbWObuabzxhwIss0+Hs
uAAVyn8QqeCewozDT1RM8zJMgCsfoxVgUjjeG2OdHGH+812z2yOVXHH5FS68RqWW
rLwHse5BU5x5GObt1LUXGHPMDksB5w==
=Kvth
-----END PGP SIGNATURE-----

--Sig_/rZ_YS7Q3KOb_0EEI.p64CGi--
