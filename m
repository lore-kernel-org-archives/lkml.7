Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4438AC4CECF
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 02:46:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11D5E206C2
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 02:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568602013;
	bh=QAv1wrwDejkDmV91NQY2X7M054/YqXAPK4RMZ0u7rgY=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=y/76Zr8FKCiNISnNpeUMPI0BC/aLivMa3t+iLQVAPx8xL+SJtgaGNRxB3YMMzIiQ6
	 2a6g7LFSbP5FJ518C18M02H8u2104/XnbRLbiWRhtkj1tuKHLG8JDiqOZPDV/elP4L
	 INTi2RUT9Jn2itsU6IShXvLvniSpIVnBo1aYRmyE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727325AbfIPCqw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Sep 2019 22:46:52 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:52792 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbfIPCqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Sep 2019 22:46:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Content-Type:MIME-Version:
        Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=6k+3CRYWLn1opUvIFHPqpUXKKfTT7JXNt22zBeg1anQ=; b=dn6b/L2Idtj4qHBzYq518fUyd
        +bA0FUi34EqVEv54VCdHAXCjqAayMk3btTdPNVr/S2V4ckQnOJGYygBJIcr9d/XcpPnZjGpY423N1
        4lNqvksTQCoiUmVTkV/zBfwHC62LOfDoX89G/SRvs97SAZO6pCWTkI9jrnB/kdsrE4Mxc=;
Received: from ypsilon.sirena.org.uk ([2001:470:1f1d:6b5::7])
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1i9h2K-0002Gs-WC; Mon, 16 Sep 2019 02:46:45 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id CD49F2741587; Mon, 16 Sep 2019 03:46:43 +0100 (BST)
Date:   Mon, 16 Sep 2019 03:46:43 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: manual merge of the akpm-current tree with the
 dma-mapping tree
Message-ID: <20190916024643.GV4352@sirena.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="NBQMqqtZQBFxm+aD"
Content-Disposition: inline
X-Cookie: Man and wife make one fool.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--NBQMqqtZQBFxm+aD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the akpm-current tree got a conflict in:

  arch/arm/include/asm/xen/page-coherent.h

between commits:

  bef4d2037d2143a ("xen/arm: consolidate page-coherent.h")
  60d8cd572f655aa ("arm64/xen: fix xen-swiotlb cache flushing")

=66rom the dma-mapping tree and commit:

  46d5fa030cd9225 ("mm: introduce compound_nr()")

=66rom the akpm-current tree.  The former appear to make the latter
redundant so I resolved by dropping the relevant portions of the
commit from the akpm tree.

--NBQMqqtZQBFxm+aD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1+95IACgkQJNaLcl1U
h9AHygf+KVMji6+ph63ldaWsuCuu9YbY9E3LMpIZZIQASzXPfpFUEUhc+PCbW+Hq
6xAJpovc/53ivp77IGIpAr93issgebNNnGqPVNig3erTbl/AXo/9EppWGRl4YIs/
YYUFcj8V7x128ZkPSraUh/O7ZbFxf+NTxkFjTOBQaNqzRGmrjhviPxQ04mKb5E+R
IDZzgCCBktMzEH7G7nWpTGOMD8rSqWqhLEWDutK0PEPCYuNj9R9a0yyA+vwFLuIU
UnwuU7hP6D0IDPt6+fjZKG+0G5wsmXGOmo1snMJawGFUcKVDX3QGsP1Tz/TQDdz5
hNIkfwwHqWHnVSoWp0x4UMR8qC8EHg==
=ZZK4
-----END PGP SIGNATURE-----

--NBQMqqtZQBFxm+aD--
