Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3147C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 05:59:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EB8020825
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 05:59:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="XzhM6LlY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726120AbfDOF7s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 01:59:48 -0400
Received: from ozlabs.org ([203.11.71.1]:55545 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725777AbfDOF7r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 01:59:47 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44jHrv0lLNz9s55;
        Mon, 15 Apr 2019 15:59:42 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1555307984;
        bh=RDwIKyWedHglPSeAUogKh2/Et953eTXyZrW3dwS7Vhg=;
        h=Date:From:To:Cc:Subject:From;
        b=XzhM6LlYW9IsCFO736qTFJrIMKf3/BzbsYzarKU8DejdnqyAc9aJtS3jtVjzH1Z1h
         tqkdtCXynffYG/TyF0DPECb+4r3KpTpYevEvEGCPBSNuBMbyZdMeFsdnSkD+i365kE
         sfiHYDMjJkInc1irroEag8uu01TkOrfQeAtuLK64gvRon05t9jYtbIa/2Ex7MorS+k
         MWd/UYRoCRdbJLyPA6Ojv7vSRW9RHPaGdvrW1FCzTU8xA5/Ei0YPtiKow8SPuMpGtm
         6qUuBIX4PQs3uTKeTIhEQRzj6Zhk/jSBB9mSuw0V6144ra5KcA9t3kBCLdml7/ttda
         HEIA9Jp1F2FBg==
Date:   Mon, 15 Apr 2019 15:59:39 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Martin Wilck <mwilck@suse.com>, Christoph Hellwig <hch@lst.de>
Subject: linux-next: manual merge of the scsi tree with the block tree
Message-ID: <20190415155939.35325ef1@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/d1NnJ8l8lFK=6uQL4lNPhGb"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/d1NnJ8l8lFK=6uQL4lNPhGb
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the scsi tree got a conflict in:

  drivers/scsi/sd.c

between commit:

  c92e2f04b359 ("block: disk_events: introduce event flags")

from the block tree and commit:

  21e6ba3f0e02 ("scsi: sd: Rely on the driver core for asynchronous probing=
")
  d16ece577bf2 ("scsi: sd: Inline sd_probe_part2()")

from the scsi tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/scsi/sd.c
index ebc80354714c,e610b393809b..000000000000
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@@ -3404,8 -3374,49 +3342,50 @@@ static int sd_probe(struct device *dev
  	get_device(dev);
  	dev_set_drvdata(dev, sdkp);
 =20
- 	get_device(&sdkp->dev);	/* prevent release before async_schedule */
- 	async_schedule_domain(sd_probe_async, sdkp, &scsi_sd_probe_domain);
+ 	gd->major =3D sd_major((index & 0xf0) >> 4);
+ 	gd->first_minor =3D ((index & 0xf) << 4) | (index & 0xfff00);
+=20
+ 	gd->fops =3D &sd_fops;
+ 	gd->private_data =3D &sdkp->driver;
+ 	gd->queue =3D sdkp->device->request_queue;
+=20
+ 	/* defaults, until the device tells us otherwise */
+ 	sdp->sector_size =3D 512;
+ 	sdkp->capacity =3D 0;
+ 	sdkp->media_present =3D 1;
+ 	sdkp->write_prot =3D 0;
+ 	sdkp->cache_override =3D 0;
+ 	sdkp->WCE =3D 0;
+ 	sdkp->RCD =3D 0;
+ 	sdkp->ATO =3D 0;
+ 	sdkp->first_scan =3D 1;
+ 	sdkp->max_medium_access_timeouts =3D SD_MAX_MEDIUM_TIMEOUTS;
+=20
+ 	sd_revalidate_disk(gd);
+=20
+ 	gd->flags =3D GENHD_FL_EXT_DEVT;
+ 	if (sdp->removable) {
+ 		gd->flags |=3D GENHD_FL_REMOVABLE;
+ 		gd->events |=3D DISK_EVENT_MEDIA_CHANGE;
++		gd->event_flags =3D DISK_EVENT_FLAG_POLL | DISK_EVENT_FLAG_UEVENT;
+ 	}
+=20
+ 	blk_pm_runtime_init(sdp->request_queue, dev);
+ 	device_add_disk(dev, gd, NULL);
+ 	if (sdkp->capacity)
+ 		sd_dif_config_host(sdkp);
+=20
+ 	sd_revalidate_disk(gd);
+=20
+ 	if (sdkp->security) {
+ 		sdkp->opal_dev =3D init_opal_dev(sdp, &sd_sec_submit);
+ 		if (sdkp->opal_dev)
+ 			sd_printk(KERN_NOTICE, sdkp, "supports TCG Opal\n");
+ 	}
+=20
+ 	sd_printk(KERN_NOTICE, sdkp, "Attached SCSI %sdisk\n",
+ 		  sdp->removable ? "removable " : "");
+ 	scsi_autopm_put_device(sdp);
 =20
  	return 0;
 =20

--Sig_/d1NnJ8l8lFK=6uQL4lNPhGb
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAly0HcsACgkQAVBC80lX
0GwbTQf+Jb5xUf5Ebg5uBgAKNEh0JT+CSlMUlVse1KhBLCjjdsmf5WfdDioIi1pw
RzNS+dtHjhYjQr584aZA8gmWT/f8sBNbCYTN6UGmK1VjLaZ+GyTob/v3NNwvv5g0
DYSGAd38tYrJAmchuwX3i58+0nGo3LHK4hWAMc3KT8y5bkZLG/5dqh5nViWmKtnh
pMBSAv8WymAkUOC4TWgpGYEBmINdC8x1iIMJbnnSdgj6kF6/ZjKA4QB0sy7P7ydF
8tdGnmBKIArlM3KTXAIF9gU2v+CBfYXOfIopA1EZAhk/QqZMSzrHp8YgI6lQjXdd
mj6dhGkPDd6kFrypin6nErN/87w3Gw==
=j269
-----END PGP SIGNATURE-----

--Sig_/d1NnJ8l8lFK=6uQL4lNPhGb--
