Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72C17C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 05:36:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B2042147A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 05:36:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="pC4+y7YC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbfFTFgA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 01:36:00 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:48939 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725889AbfFTFf7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 01:35:59 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45TrBz584Hz9s9y;
        Thu, 20 Jun 2019 15:35:55 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1561008955;
        bh=BAOsWHXplhcuCubfT/o1yBKF/KCS9Illdvf1ACDj3Bs=;
        h=Date:From:To:Cc:Subject:From;
        b=pC4+y7YCRKkwruqlY7wAyuqryJZfl4tcfQX3L+PPloekb1WCl3TtX6Qr5cELc22FK
         KbzoqYoNgBVDT5i80A4A0ElpNTRE/S5TmBaLKhDlKuqNtn81UZmQYIB3NdnF5vhpzZ
         P1aYf1x5cOWdC3NK9/hHgWMuP+s8dlkjqordM6zGBpaulMsN8NAbvFZU6cVr4BavsX
         dknI196yA3oe21Bd22yY8tJTLoasFCsBOViPu/bDQA2KK5HqTMXOBClZt35tHSCD8t
         gj9QncIvC5fTHpX7u+xblzkWIc85scKQwmV+4iIrTB6ye+5ua4viHTnYWynrK6g2tP
         EIrlPytbXTxTA==
Date:   Thu, 20 Jun 2019 15:35:52 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>, Arnd Bergmann <arnd@arndb.de>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vitaly Lubart <vitaly.lubart@intel.com>,
        Tomas Winkler <tomas.winkler@intel.com>
Subject: linux-next: manual merge of the char-misc tree with the driver-core
 tree
Message-ID: <20190620153552.1392079c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/s4hH9bWg9WYbiPbQg4cMoeu"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/s4hH9bWg9WYbiPbQg4cMoeu
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the char-misc tree got a conflict in:

  drivers/misc/mei/debugfs.c

between commit:

  5666d896e838 ("mei: no need to check return value of debugfs_create funct=
ions")

from the driver-core tree and commit:

  b728ddde769c ("mei: Convert to use DEFINE_SHOW_ATTRIBUTE macro")

from the char-misc tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/misc/mei/debugfs.c
index df6bf8b81936,47cfd5005e1b..000000000000
--- a/drivers/misc/mei/debugfs.c
+++ b/drivers/misc/mei/debugfs.c
@@@ -233,22 -154,46 +154,21 @@@ void mei_dbgfs_deregister(struct mei_de
   *
   * @dev: the mei device structure
   * @name: the mei device name
 - *
 - * Return: 0 on success, <0 on failure.
   */
 -int mei_dbgfs_register(struct mei_device *dev, const char *name)
 +void mei_dbgfs_register(struct mei_device *dev, const char *name)
  {
 -	struct dentry *dir, *f;
 +	struct dentry *dir;
 =20
  	dir =3D debugfs_create_dir(name, NULL);
 -	if (!dir)
 -		return -ENOMEM;
 -
  	dev->dbgfs_dir =3D dir;
 =20
 -	f =3D debugfs_create_file("meclients", S_IRUSR, dir,
 -				dev, &mei_dbgfs_meclients_fops);
 -	if (!f) {
 -		dev_err(dev->dev, "meclients: registration failed\n");
 -		goto err;
 -	}
 -	f =3D debugfs_create_file("active", S_IRUSR, dir,
 -				dev, &mei_dbgfs_active_fops);
 -	if (!f) {
 -		dev_err(dev->dev, "active: registration failed\n");
 -		goto err;
 -	}
 -	f =3D debugfs_create_file("devstate", S_IRUSR, dir,
 -				dev, &mei_dbgfs_devstate_fops);
 -	if (!f) {
 -		dev_err(dev->dev, "devstate: registration failed\n");
 -		goto err;
 -	}
 -	f =3D debugfs_create_file("allow_fixed_address", S_IRUSR | S_IWUSR, dir,
 -				&dev->allow_fixed_address,
 -				&mei_dbgfs_allow_fa_fops);
 -	if (!f) {
 -		dev_err(dev->dev, "allow_fixed_address: registration failed\n");
 -		goto err;
 -	}
 -	return 0;
 -err:
 -	mei_dbgfs_deregister(dev);
 -	return -ENODEV;
 +	debugfs_create_file("meclients", S_IRUSR, dir, dev,
- 			    &mei_dbgfs_fops_meclients);
++			    &mei_dbgfs_meclients_fops);
 +	debugfs_create_file("active", S_IRUSR, dir, dev,
- 			    &mei_dbgfs_fops_active);
++			    &mei_dbgfs_active_fops);
 +	debugfs_create_file("devstate", S_IRUSR, dir, dev,
- 			    &mei_dbgfs_fops_devstate);
++			    &mei_dbgfs_devstate_fops);
 +	debugfs_create_file("allow_fixed_address", S_IRUSR | S_IWUSR, dir,
 +			    &dev->allow_fixed_address,
- 			    &mei_dbgfs_fops_allow_fa);
++			    &mei_dbgfs_allow_fa_fops);
  }
-=20

--Sig_/s4hH9bWg9WYbiPbQg4cMoeu
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0LGzgACgkQAVBC80lX
0Gx+/Qf/S15uY6Nn5ycxBmC3UidN6Uf+3Pj/x4SMY2uGl7t0VgNceWCt0jw3ltbA
q8j2KbhW7Qb0exvqptpwllSfmURa58UVBmJKZtM4KSOUCBCEGf1hfSebhjSrLjSE
PIt/1w8wkImag0yJEKYQUKQf6fy6L2USTYJUUl+02igmha+vw05+wFuQMBsbG36G
1sHUiCRosU3ZVvlnGVniFhcVOsAV4up7rckKop2iwQ8AmjgaKBDqJ89qh/ry12uA
4QYU9N6KdGzNvCsldDH5eyRX16lKAuXCZ7G4WdB2Oquo+oOvQCPY3E2kmhgtzscm
Y/ZivqOFhflKtmvT88WAS2tkU0Nqig==
=r+OW
-----END PGP SIGNATURE-----

--Sig_/s4hH9bWg9WYbiPbQg4cMoeu--
