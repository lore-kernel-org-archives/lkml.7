Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF032C31E40
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 00:08:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9477721871
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 00:08:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="tBPfN9hz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbfHGAII (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 20:08:08 -0400
Received: from ozlabs.org ([203.11.71.1]:55147 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726085AbfHGAIH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 20:08:07 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 463BfX3gPVz9sBF;
        Wed,  7 Aug 2019 10:08:04 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1565136484;
        bh=oUBuz+X3wmfRoM27Gkv2AbxGFNP7LK8SMyYYVUvgjpY=;
        h=Date:From:To:Cc:Subject:From;
        b=tBPfN9hzVRCTg2Nsf/dcDoSK9jqT4aVjnI53ZJocJo8o8GVy3sK992fgEEkMtROfJ
         EGhFV2hjp10lYt9Odq77UGKBi0JN37ka/nKrr2yQWfTYaOYsQC/4A9MijlDpIpOlgx
         Dvr+XEC6BnJw6Ygrp5m/2PH4fUeDd2snqy6XL+xwaFCy3xVUERHOocC0qfuE84ziWb
         jnC8EruSQEYQszAesozdKb82PUX6+FRA56qTCY71PGaYEpluhJzFjwHbdSyG8CXTGd
         i11mlpsR6AFfjwFzj3AwslnMJGrzXbxRCFrgqHpvF8gW6aO/Wsjf4L2lwOY8giKLJp
         rl2l+loOuljbg==
Date:   Wed, 7 Aug 2019 10:08:03 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andy Gross <agross@kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vaishali Thakkar <vaishali.thakkar@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kees Cook <keescook@chromium.org>
Subject: linux-next: build warning after merge of the qcom tree
Message-ID: <20190807100803.63007737@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/f1XCtaBu3WKY_/7XRGdJe.4";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/f1XCtaBu3WKY_/7XRGdJe.4
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the qcom tree, today's linux-next build (x86_64
allmodconfig) produced this warning:

drivers/soc/qcom/socinfo.c: In function 'socinfo_debugfs_init':
drivers/soc/qcom/socinfo.c:323:3: warning: this statement may fall through =
[-Wimplicit-fallthrough=3D]
   debugfs_create_x32("raw_device_number", 0400,
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        qcom_socinfo->dbg_root,
        ~~~~~~~~~~~~~~~~~~~~~~~
        &qcom_socinfo->info.raw_device_num);
        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/soc/qcom/socinfo.c:326:2: note: here
  case SOCINFO_VERSION(0, 11):
  ^~~~
drivers/soc/qcom/socinfo.c:331:3: warning: this statement may fall through =
[-Wimplicit-fallthrough=3D]
   debugfs_create_u32("foundry_id", 0400, qcom_socinfo->dbg_root,
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        &qcom_socinfo->info.foundry_id);
        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/soc/qcom/socinfo.c:333:2: note: here
  case SOCINFO_VERSION(0, 8):
  ^~~~
drivers/soc/qcom/socinfo.c:231:2: warning: this statement may fall through =
[-Wimplicit-fallthrough=3D]
  debugfs_create_file(__stringify(name), 0400,   \
  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        qcom_socinfo->dbg_root,   \
        ~~~~~~~~~~~~~~~~~~~~~~~~~~~
        info, &qcom_ ##name## _ops)
        ~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/soc/qcom/socinfo.c:336:3: note: in expansion of macro 'DEBUGFS_ADD'
   DEBUGFS_ADD(info, pmic_die_rev);
   ^~~~~~~~~~~
drivers/soc/qcom/socinfo.c:337:2: note: here
  case SOCINFO_VERSION(0, 6):
  ^~~~
drivers/soc/qcom/socinfo.c:341:3: warning: this statement may fall through =
[-Wimplicit-fallthrough=3D]
   debugfs_create_u32("hardware_platform_subtype", 0400,
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        qcom_socinfo->dbg_root,
        ~~~~~~~~~~~~~~~~~~~~~~~
        &qcom_socinfo->info.hw_plat_subtype);
        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/soc/qcom/socinfo.c:344:2: note: here
  case SOCINFO_VERSION(0, 5):
  ^~~~
drivers/soc/qcom/socinfo.c:348:3: warning: this statement may fall through =
[-Wimplicit-fallthrough=3D]
   debugfs_create_u32("accessory_chip", 0400,
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        qcom_socinfo->dbg_root,
        ~~~~~~~~~~~~~~~~~~~~~~~
        &qcom_socinfo->info.accessory_chip);
        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/soc/qcom/socinfo.c:351:2: note: here
  case SOCINFO_VERSION(0, 4):
  ^~~~
drivers/soc/qcom/socinfo.c:354:3: warning: this statement may fall through =
[-Wimplicit-fallthrough=3D]
   debugfs_create_u32("platform_version", 0400,
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        qcom_socinfo->dbg_root,
        ~~~~~~~~~~~~~~~~~~~~~~~
        &qcom_socinfo->info.plat_ver);
        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/soc/qcom/socinfo.c:357:2: note: here
  case SOCINFO_VERSION(0, 3):
  ^~~~
drivers/soc/qcom/socinfo.c:360:3: warning: this statement may fall through =
[-Wimplicit-fallthrough=3D]
   debugfs_create_u32("hardware_platform", 0400,
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        qcom_socinfo->dbg_root,
        ~~~~~~~~~~~~~~~~~~~~~~~
        &qcom_socinfo->info.hw_plat);
        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/soc/qcom/socinfo.c:363:2: note: here
  case SOCINFO_VERSION(0, 2):
  ^~~~
drivers/soc/qcom/socinfo.c:366:3: warning: this statement may fall through =
[-Wimplicit-fallthrough=3D]
   debugfs_create_u32("raw_version", 0400, qcom_socinfo->dbg_root,
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        &qcom_socinfo->info.raw_ver);
        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/soc/qcom/socinfo.c:368:2: note: here
  case SOCINFO_VERSION(0, 1):
  ^~~~

Introduced by commit

  9c84c1e78634 ("soc: qcom: socinfo: Expose custom attributes")

--=20
Cheers,
Stephen Rothwell

--Sig_/f1XCtaBu3WKY_/7XRGdJe.4
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl1KFmMACgkQAVBC80lX
0GwlTwf9GTzoAqWUB9zzB2Mz0W66AWZ4Gtl61ySnXtt7WzEU3isJENlLN/xkCJl/
tGXLpA4uFpbcTgKW7OYhRdnQOYvrRyLBqk8U2YDkmbG8Ld22n8x0gc5J9zjvR75B
ZmKuV//PLKCYg0oI6tUxGzZIo6cEWG6RqwjpsJf8Dfvp1VpdEz4ocYlS1LyW+FJk
JWsSEjbIunDtj0JSq3aqF2yaBA4cV+bDaIu2Vnvs3PMcdWMbjoEL9vEftBtxja9z
zv7IARHJR5DvbeVleiy0P4ylHjOgGTGrWcpqzOoSJMzbTozi3Ew4cZtYoTh4C/vZ
LpVUhiuq7lrdtEvmfQIId6cD7KsMSg==
=sXHz
-----END PGP SIGNATURE-----

--Sig_/f1XCtaBu3WKY_/7XRGdJe.4--
