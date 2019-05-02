Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06A6FC43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 23:25:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF459206DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 23:25:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="U2AKWiVt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726406AbfEBXZW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 19:25:22 -0400
Received: from ozlabs.org ([203.11.71.1]:35907 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726022AbfEBXZV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 19:25:21 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44wBFW06WPz9s5c;
        Fri,  3 May 2019 09:25:18 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1556839519;
        bh=qf5YqcLzwb1kOcTamLG+PVNNunhxERBinB5SrkA9BR8=;
        h=Date:From:To:Cc:Subject:From;
        b=U2AKWiVt4hzSGDsnkp2KvCtZZmY9BgZAlCDRRbUA3aeNNZzxtpXAJm7psSrzFqp/X
         /AG8YGmIDHM6PqqL9vV8gBGdlHRQ8gHj+oLwNDHgs1gxWdVPmZmJmFZTOx1iT44OEX
         Wo4bzO+yFeaDdyxGoOqX753I3E1Rud8UMt94BzxXTsirx77egcCMnG4ygwn0K7uDyt
         N26+PQyzIQDd4n37KOKwSbLg7Ixm3e55X/bl7+BIbAfUNuDqG1tcnYRw2gxp/IjSA4
         D2Tg3CcFSBpfv3hlKyBAvSqcWC9S8zuliRsB9vL4JdRor/bvQ4Rzzh4WGPdRZT9Q3u
         vbSqgJXJle3Fg==
Date:   Fri, 3 May 2019 09:25:11 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: build failure after merge of the clk tree
Message-ID: <20190503092511.0054911e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/gFfI+SNKNCDM.A9s2hfbtor"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/gFfI+SNKNCDM.A9s2hfbtor
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the clk tree, today's linux-next build (arm
multi_v7_defconfig) failed like this:

arch/arm/mach-omap2/omap_hwmod.c: In function '_get_clkdm':
arch/arm/mach-omap2/omap_hwmod.c:669:35: error: 'CLK_IS_BASIC' undeclared (=
first use in this function); did you mean 'CLOCKS_MASK'?
   if (__clk_get_flags(oh->_clk) & CLK_IS_BASIC)
                                   ^~~~~~~~~~~~
                                   CLOCKS_MASK
arch/arm/mach-omap2/omap_hwmod.c:669:35: note: each undeclared identifier i=
s reported only once for each function it appears in

Caused by commit

  7c36ec8a90a8 ("clk: Remove CLK_IS_BASIC clk flag")

I have used the clk tree from next-20190502 for today.  (The above commit
does not revert cleanly.)



--=20
Cheers,
Stephen Rothwell

--Sig_/gFfI+SNKNCDM.A9s2hfbtor
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlzLfFcACgkQAVBC80lX
0GyepAf/W4XM6u3R+Sg7mSYJXwVPIsHCIho/yBw2mU2uJv+bFJvV+9GK+4OYmJIM
L/cJ9Y4UEHswQuyXE+n7g6k/9C2j6WK/CkMhShzYuN0bGs+mYDWILOtRt4JYVmq0
kiZZG1puq2hKnB/znXq1h3kvXeeoYjKORcXO9pvIkmI+nyhHWgtcSgQTqi2KxSM/
paRRNMQyCtR64fQMsJaVtjCnVrah/tP5nwqk87R+6kuLCem+Z8bBKcP0rdTcXqQt
f7HFkB55msnAjzAqA50iHnfQB26E+uzt45MUMTLr9gAFMUOEOynYZUxnebq1Pvw0
dR5fQq0Mm8iDH5in036CW/thbea9/w==
=QEbq
-----END PGP SIGNATURE-----

--Sig_/gFfI+SNKNCDM.A9s2hfbtor--
