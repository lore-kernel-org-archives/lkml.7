Return-Path: <SRS0=lz0T=XK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1FF2C4CEC7
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Sep 2019 22:05:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EBE5214D9
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Sep 2019 22:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568585155;
	bh=EWn92g3Phulea1QmCJ66vYqdap3rP8f8a7HMaqYkOTQ=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=lSzrxWdO69pXSTfya2iD3pJvosw6iyKArbVF1S1ZOJvKtlQAoDzcgwNNbIzexKczI
	 kWjvOPSqdwZP5ncouJPPHWioTcoADz9z0X+NrCRdUVWqGPkT8cC04G/QWC24ex8wdL
	 JQvqGmVRxNENG7DIrT/ABa8epu5WGFFTaUavwyQY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbfIOWFy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Sep 2019 18:05:54 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:60300 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbfIOWFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Sep 2019 18:05:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Content-Type:MIME-Version:
        Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=BZfamDuKW9zum2bvuldn42rfct2cwwZfcxINJ6AUDaU=; b=uaPxHNRnfn82HYDMOSTS0t0Ab
        accoD3vXIPGEmMHOKsXnRS2L/TJO8tZbdlvqpKcmaGoFPbfdbib59bZilPBIaffRnFTXhhC56ABs4
        THZT0bc/XeIEtRUmeJCBIuoOMbyiXuf913s+Nt+kW1zvDRkfTKOy45k63LhTQxn0JR/X8=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1i9ceU-0001Th-Ao; Sun, 15 Sep 2019 22:05:50 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 5F6DE27415FF; Sun, 15 Sep 2019 23:05:49 +0100 (BST)
Date:   Sun, 15 Sep 2019 23:05:49 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Jessica Yu <jeyu@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Matthias Maennich <maennich@google.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: manual merge of the modules tree with the kbuild tree
Message-ID: <20190915220549.GK4352@sirena.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="9a9Vq1BJdYBEXpLG"
Content-Disposition: inline
X-Cookie: Man and wife make one fool.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--9a9Vq1BJdYBEXpLG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the modules tree got a conflict in:

  scripts/Makefile.modpost

between commit:

  9b9a3f20cbe0ba ("kbuild: split final module linking out into Makefile.mod=
final")

=66rom the kbuild tree and commit:

  eb8305aecb958e ("cripts: Coccinelle script for namespace dependencies.")

=66rom the modules tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --cc scripts/Makefile.modpost
index 9800a3988f23e,743fe3a2e885f..0000000000000
--- a/scripts/Makefile.modpost
+++ b/scripts/Makefile.modpost
diff --git a/scripts/Makefile.modfinal b/scripts/Makefile.modfinal
index 411c1e600e7dd..c164d644138ab 100644
--- a/scripts/Makefile.modfinal
+++ b/scripts/Makefile.modfinal
@@ -42,6 +42,8 @@ $(modules): %.ko: %.o %.mod.o $(KBUILD_LDS_MODULE) FORCE
=20
 targets +=3D $(modules) $(modules:.ko=3D.mod.o)
=20
+nsdeps: __modpost
+
 # Add FORCE to the prequisites of a target to force it to be always rebuil=
t.
 # ------------------------------------------------------------------------=
---
=20

--9a9Vq1BJdYBEXpLG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1+tbwACgkQJNaLcl1U
h9B2tgf+Lzb9gTE3lWLQaPX/y4tmgBboES2YFIRs5O1gBqzMtXCeP2jqGNUJ7oCa
WxJui9dd5pLNW3K0yLHSWf9u2scSmNpg62vPCTk+Rfx3nl7wOt2zdFQvKartW5sY
kdNiWwx6fFNG+2G9SpUUxyPfmhl016xxU/eSpb+XL4h8PbILtSd+RT/fNgUnh6Mo
+yLwPL/KhleFEMiwFzNWvoLb78+SIJv9i/wrpiwJhHEsIA6hEaoKvKQ1vQwVe7Au
vsvQB6qcVaU5/j7dVnbS7jdfqGgz4XxKqQ5mwMs+VwrGO6zX37/3BiQeFdwSFkns
uxOs3AECzmo+S6MiN1EIC4e7P879CQ==
=M9oK
-----END PGP SIGNATURE-----

--9a9Vq1BJdYBEXpLG--
