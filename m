Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9EE8C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 23:24:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FC9D2133D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 23:24:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="JljgeUKw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbfDIXYa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 19:24:30 -0400
Received: from ozlabs.org ([203.11.71.1]:58219 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726573AbfDIXYa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 19:24:30 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44f3K63WC7z9sTb;
        Wed, 10 Apr 2019 09:24:26 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1554852267;
        bh=YxOpPIeWu9EdRk6jtrcq6hgrgqwy2P6dHNciaX36jlM=;
        h=Date:From:To:Cc:Subject:From;
        b=JljgeUKwusd+f1lQdPxxnVqp19pEEU0kV5PVCAigF0OatoREn/2sWoaRVgVjy4uYr
         wB4xi70S2l3otSAfVvl/KLXFXSQ2QtjzyuWtnU2SC0hz4wHOW7WnavrpJpAMQBzs5S
         wX7cBWiIfEX9pngCCZiMVgz2H7CMlsOfAwGeTyf87UQEm1wAQyG3ioqBa4PDls1T5H
         W9JMMIyIK6MFOjDXmZTxiyd5tTBRkXCf4dU44U7R7CpNyw+jkIonjU7ORcX34r86Iw
         B23MfLhWBikhIBejzmZcaY07AZ4rtftL2+2HoaKz+yENdw4lmu+/N/mDaZYCWDgUYf
         1QinwvAwTlPsg==
Date:   Wed, 10 Apr 2019 09:24:07 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Joe Perches <joe@perches.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: linux-next: manual merge of the printk tree with Linus' tree
Message-ID: <20190410092407.4ed718b8@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/GPuOcJ0TjSNjC=9LYTU4wu6"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/GPuOcJ0TjSNjC=9LYTU4wu6
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the printk tree got conflicts in:

  drivers/base/power/main.c

between commit:

  7a5bd1279bce ("PM: Add and use pr_fmt()")

from Linus' tree and commit:

  d75f773c86a2 ("treewide: Switch printk users from %pf and %pF to %ps and =
%pS, respectively")

from the printk tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/base/power/main.c
index f80d298de3fa,c88f56b9ae5b..000000000000
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@@ -2063,7 -2062,7 +2063,7 @@@ EXPORT_SYMBOL_GPL(dpm_suspend_start)
  void __suspend_report_result(const char *function, void *fn, int ret)
  {
  	if (ret)
- 		pr_err("%s(): %pF returns %d\n", function, fn, ret);
 -		printk(KERN_ERR "%s(): %pS returns %d\n", function, fn, ret);
++		pr_err("%s(): %pS returns %d\n", function, fn, ret);
  }
  EXPORT_SYMBOL_GPL(__suspend_report_result);
 =20

--Sig_/GPuOcJ0TjSNjC=9LYTU4wu6
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlytKZcACgkQAVBC80lX
0GyH/gf/fuxtr4BM8vb+NfNB6K8sffpJAwGRe3IaLYujL4ud+5AQzR+pyTlerQRO
VYM4KBB+XnpNdbWGiMPx1d+BWZSHnWYRiw3VPIDaAIH3U9SG2+xrdZuXzSTjchQ/
vgG10U1xK1dVR89o3VralZFrkgeWGDGIWVWcZgR6AP9ylTWQqqrub2fjVhpF2QJZ
p8noJlmZdRT5Eidu/5oo/qOnKf2pQUnYxAYHY/qvDLVtZLDMOB4DC9HBcsWazfcG
2PVX2jC6CMBwznlXjqPuQBfZ2yKE9NYJTGzV79joTfyUjKCjOTCDnayI59mCkMZ6
NTVBmFRZsBF3jB9mB6WE44cmGDlerQ==
=81Gy
-----END PGP SIGNATURE-----

--Sig_/GPuOcJ0TjSNjC=9LYTU4wu6--
