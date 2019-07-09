Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FA80C606D6
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 06:55:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27C2E21537
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 06:55:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="HZFOY+xT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726133AbfGIGzE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 02:55:04 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:33029 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725818AbfGIGzE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 02:55:04 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45jY3R61R1z9s3l;
        Tue,  9 Jul 2019 16:54:59 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1562655301;
        bh=/OG1GFFqVrZ0mfKk3zuMK9QTPLM43PxzOJI/FlayNiQ=;
        h=Date:From:To:Cc:Subject:From;
        b=HZFOY+xTu5s6LiMNpXVwys6AtcfvsF94AsmOkTY3Xwvq4BEobkRTfWXbalYGiQeDT
         fulxk6/58/Lt9KKhbbHt4R7M9icTwwRa3lMVogy9AsAGPZivShXopG2T4ktlGGqOj7
         noATqCwVtSXLEMf8E1cJJSOTx/JuEUhG4EdTF8tchty60rbji8dfGSERJj1kLd9GLQ
         IdmMZpaazVEykuEWSpBg6zAJRuiM2r7EsLOZQ/UsoVNvM7X/KMx3PlAIzM1UXAiYXI
         tEVB/s3d+b/T94AGILfpmcLl1F/JCtzPJdr/TmJqbjMJ28wi8CZiZsDoklLcWl+o6p
         1W8g7vtzQjfeg==
Date:   Tue, 9 Jul 2019 16:54:59 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sage Weil <sage@newdream.net>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nikolay Borisov <nborisov@suse.com>,
        Ilya Dryomov <idryomov@gmail.com>
Subject: linux-next: build failure after merge of the tip tree
Message-ID: <20190709165459.11b353d8@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/T4oAY+y+6W_Hqd+T9l31+0Y"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/T4oAY+y+6W_Hqd+T9l31+0Y
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the tip tree, today's linux-next build (x86_64 allmodconfig)
failed like this:

drivers/block/rbd.c: In function 'wake_lock_waiters':
drivers/block/rbd.c:3933:2: error: implicit declaration of function 'lockde=
p_assert_held_exclusive'; did you mean 'lockdep_assert_held_write'? [-Werro=
r=3Dimplicit-function-declaration]
  lockdep_assert_held_exclusive(&rbd_dev->lock_rwsem);
  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  lockdep_assert_held_write

Caused by commit

  9ffbe8ac05db ("locking/lockdep: Rename lockdep_assert_held_exclusive() ->=
 lockdep_assert_held_write()")

interacting with commits

  637cd060537d ("rbd: new exclusive lock wait/wake code")
  a2b1da09793d ("rbd: lock should be quiesced on reacquire")

from the ceph tree.

I have added the following merge fix patch for today.

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Tue, 9 Jul 2019 16:46:12 +1000
Subject: [PATCH] rbd: fix up for lockdep_assert_held_exclusive rename

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/block/rbd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 723c3ef4bd59..02216fbdb854 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -3930,7 +3930,7 @@ static void wake_lock_waiters(struct rbd_device *rbd_=
dev, int result)
 	struct rbd_img_request *img_req;
=20
 	dout("%s rbd_dev %p result %d\n", __func__, rbd_dev, result);
-	lockdep_assert_held_exclusive(&rbd_dev->lock_rwsem);
+	lockdep_assert_held_write(&rbd_dev->lock_rwsem);
=20
 	cancel_delayed_work(&rbd_dev->lock_dwork);
 	if (!completion_done(&rbd_dev->acquire_wait)) {
@@ -4209,7 +4209,7 @@ static bool rbd_quiesce_lock(struct rbd_device *rbd_d=
ev)
 	bool need_wait;
=20
 	dout("%s rbd_dev %p\n", __func__, rbd_dev);
-	lockdep_assert_held_exclusive(&rbd_dev->lock_rwsem);
+	lockdep_assert_held_write(&rbd_dev->lock_rwsem);
=20
 	if (rbd_dev->lock_state !=3D RBD_LOCK_STATE_LOCKED)
 		return false;
--=20
2.20.1

--=20
Cheers,
Stephen Rothwell

--Sig_/T4oAY+y+6W_Hqd+T9l31+0Y
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0kOkMACgkQAVBC80lX
0GyP5Af/etG4RvEUmxBkzAToBclLZdaeLzz1oiLJ2NyLMmocCjEyiXhpe+VXxpcX
QzYXxOC2gq/KDwLbHDek/bkpjX9L127eyGQtjOSFRt5eqTbozXqqYHOLpuM5/tam
YhjMhysdXWwdgNHu3Fh/YrB2jjy32fjhFH79ug0LB2OsUSXRJNDXiSDAIV9Gz5pB
8H4cdl4fP5FthWlx4ZDTF/i3gNEFQb/xPF2x5b/2x6ydN8dVO9PvYM1Twrq5HFLG
pdBZoBRy6CazkylUsL4SAemg9naGl/cwz8C6r09f8oNfxk4I7kUoWm12myxQR/4k
gUGPTKQ7irC2Vt6o53fSo83Su4bJXQ==
=1X56
-----END PGP SIGNATURE-----

--Sig_/T4oAY+y+6W_Hqd+T9l31+0Y--
