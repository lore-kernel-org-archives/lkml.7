Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A2C6C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 23:03:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3648A2147C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 23:03:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="uI0shSIN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731770AbfCZXDk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 19:03:40 -0400
Received: from ozlabs.org ([203.11.71.1]:38239 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731483AbfCZXDj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 19:03:39 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44TRWX4z4vz9sRx;
        Wed, 27 Mar 2019 10:03:36 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1553641416;
        bh=/fFCDbTpivf9mhOP7A0qko8W8q4jntO6RXXinBEZhik=;
        h=Date:From:To:Cc:Subject:From;
        b=uI0shSINAu/bnPVvkL3qyY2Az9gmT6RGiYaAjRZd13bMCtR5Pqisoyez8cQxwzMrQ
         K3IE3VdETQ3YGDzGhUrzheHrktHZG5CeE85hlFUSa+YUALTpMW3cwbcberfk2zXzTr
         3w7pb1D89p3IZsBVW9BOQPZiKeK49N/wkPo0EgO0LztaA0mpfjjjmIhObOVq6gbxtG
         27WNn5V5V1gaCavkmzKGjoyh746auuCA2BP5fLLjSu5jc4HrqWhw1ngXyoivrMHqhg
         CpmJZMNkWnux+yHAFjIg8UiF0RB0TvH5Ps59VsmKE+rv5wkbYQXu/WE6NpIY0gI3Dg
         UqBIox1lEMtAA==
Date:   Wed, 27 Mar 2019 10:03:36 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Viorel Suman <viorel.suman@nxp.com>
Subject: linux-next: build failure after merge of the sound-asoc tree
Message-ID: <20190327100336.142b4b08@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_//EM.dT8f7SAzbtk7pXQ6So."; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_//EM.dT8f7SAzbtk7pXQ6So.
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the sound-asoc tree, today's linux-next build (x86_64
allmodconfig) failed like this:

In file included from include/linux/printk.h:330,
                 from include/linux/kernel.h:15,
                 from include/linux/clk.h:16,
                 from sound/soc/fsl/fsl_audmix.c:8:
sound/soc/fsl/fsl_audmix.c: In function 'fsl_audmix_state_trans':
include/linux/dynamic_debug.h:80:13: error: initializer element is not cons=
tant
   .format =3D (fmt),    \
             ^
include/linux/dynamic_debug.h:116:2: note: in expansion of macro 'DEFINE_DY=
NAMIC_DEBUG_METADATA'
  DEFINE_DYNAMIC_DEBUG_METADATA(id, fmt);  \
  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
include/linux/dynamic_debug.h:136:2: note: in expansion of macro '__dynamic=
_func_call'
  __dynamic_func_call(__UNIQUE_ID(ddebug), fmt, func, ##__VA_ARGS__)
  ^~~~~~~~~~~~~~~~~~~
include/linux/dynamic_debug.h:150:2: note: in expansion of macro '_dynamic_=
func_call'
  _dynamic_func_call(fmt,__dynamic_dev_dbg,   \
  ^~~~~~~~~~~~~~~~~~
include/linux/device.h:1493:2: note: in expansion of macro 'dynamic_dev_dbg'
  dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
  ^~~~~~~~~~~~~~~
sound/soc/fsl/fsl_audmix.c:93:3: note: in expansion of macro 'dev_dbg'
   dev_dbg(comp->dev, prm.msg);
   ^~~~~~~
include/linux/dynamic_debug.h:80:13: note: (near initialization for '__UNIQ=
UE_ID_ddebug374.format')
   .format =3D (fmt),    \
             ^
include/linux/dynamic_debug.h:116:2: note: in expansion of macro 'DEFINE_DY=
NAMIC_DEBUG_METADATA'
  DEFINE_DYNAMIC_DEBUG_METADATA(id, fmt);  \
  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
include/linux/dynamic_debug.h:136:2: note: in expansion of macro '__dynamic=
_func_call'
  __dynamic_func_call(__UNIQUE_ID(ddebug), fmt, func, ##__VA_ARGS__)
  ^~~~~~~~~~~~~~~~~~~
include/linux/dynamic_debug.h:150:2: note: in expansion of macro '_dynamic_=
func_call'
  _dynamic_func_call(fmt,__dynamic_dev_dbg,   \
  ^~~~~~~~~~~~~~~~~~
include/linux/device.h:1493:2: note: in expansion of macro 'dynamic_dev_dbg'
  dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
  ^~~~~~~~~~~~~~~
sound/soc/fsl/fsl_audmix.c:93:3: note: in expansion of macro 'dev_dbg'
   dev_dbg(comp->dev, prm.msg);
   ^~~~~~~

Caused by commit

  be1df61cf06e ("ASoC: fsl: Add Audio Mixer CPU DAI driver")

I have reverted that commit (and its 2 following ones) for today.

--=20
Cheers,
Stephen Rothwell

--Sig_//EM.dT8f7SAzbtk7pXQ6So.
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlyar8gACgkQAVBC80lX
0Gzdagf+MnbpcBCIjxnTzv+8wKtN4YYichCECj4pWIRt+6p32ZIk6dlSWYo0yCOt
JPR5mGvfdab1zOImVg/WNIkrauf5rRMo5lhNEKPrtEyIreMpD0l67IUQSSbpcf12
5paAmJKOM4nrUc+XwPlSyhQsTGDPCUxum15fL3eSYQlDMc+TbER2pZ0KR3GbVKgH
p2gvWtvUB1c6s7QsoD07rCJv1OI03cW0fYEnRBuDM3cDGMVeT5Y9igxCcMHGR2Uk
YkktxhMXY9LaiK9GR4BuAfcVyfHYhqBK1Ia1W477I6wMHRRKQ7D9wEKpeaxzWBwE
zqaNOC9LkT59vZh4Yfe4dKBsTPU/CA==
=KLYT
-----END PGP SIGNATURE-----

--Sig_//EM.dT8f7SAzbtk7pXQ6So.--
