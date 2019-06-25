Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06E35C48BD4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 04:27:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0E5D20656
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 04:27:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="X/uP253e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726772AbfFYE1M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 00:27:12 -0400
Received: from ozlabs.org ([203.11.71.1]:33595 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725881AbfFYE1M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 00:27:12 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45XtRJ1kFVz9sDn;
        Tue, 25 Jun 2019 14:27:08 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1561436829;
        bh=3Kt8+u+vvL1+jVvTKbfvb1dMHr6BhniMOgROfNlSmCQ=;
        h=Date:From:To:Cc:Subject:From;
        b=X/uP253eFt/zw/of9f21iXEcpAuQQYIIEoDLFxJiL6vvlkkVChfI1o/PtMx2OYTni
         A5EEadHkWwH2B318iHDAx5YXtnn7KK63zEAPgi4MKC4FoquN4ODdaOdPLateKXbeZL
         QU1Yu1eV+fDnamhEK9j6hGAWCSFcOzcC6FoXAjHgL476yLvzRfX6cfWOn4/l2xMtKm
         VtwSo4V4Lcp0llUPc82yb80l6jqSObagwkWBazcSlVFqWAkIrypO8xl3x7auzBjcdR
         DxpGnHdbqTTgcAiIRmR2gn28VJ3En+JYIJWvza/sdRjloF3skZd6h5xXnLhd3Ni9IO
         29F6F5fQagDXA==
Date:   Tue, 25 Jun 2019 14:27:07 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jessica Yu <jeyu@kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Nadav Amit <namit@vmware.com>
Subject: linux-next: build failure after merge of the modules tree
Message-ID: <20190625142707.00e8e9b1@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/c8ggg1/YX6MNrIzXEYXQX8O"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/c8ggg1/YX6MNrIzXEYXQX8O
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Jessica,

After merging the modules tree, today's linux-next build (powerpc
ppc64_defconfig) failed like this:

kernel/module.c: In function 'module_enable_x':
kernel/module.c:2030:2: error: implicit declaration of function 'frob_text'=
; did you mean 'rb_next'? [-Werror=3Dimplicit-function-declaration]
  frob_text(&mod->core_layout, set_memory_x);
  ^~~~~~~~~
  rb_next

Caused by commit

  2eef1399a866 ("modules: fix BUG when load module with rodata=3Dn")

frob_text() only exists when CONFIG_STRICT_MODULE_RWX is defined.

I have used the modules tree from next-20190624 for today.



--=20
Cheers,
Stephen Rothwell

--Sig_/c8ggg1/YX6MNrIzXEYXQX8O
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0RopsACgkQAVBC80lX
0Gy28Qf/evTa3Xjw5Zqzb4C5HNeiXHofkqN8M/FBIOC53wTCpgCtHD9dan9P6Run
/D7YCr+PVehcaa64ug1yd8evCzFE5RFoIloUUoVgrA3tfTRlzkxeBTow9vAqkaak
U8RiEjzqEuKCwUGwxwQAqEuPvLl2R+K8faAvHQTB4MlT7u5PKpsX5fcrlfglQaUw
uayHK+YFfmCmHJmTH0KXdi3FrKIQekFjVwqwd8mPcnHGweGeZlVXiMq/PFOLvTvS
jTfmWvMQc1zwW18V8YzfTBYPiYHG8cAyPVx9oaVOK0OeVwizw6TwHTU1B38OWw/3
xmGCmXqQfGV/KZODnRoK6xdFzeGS5g==
=9v8p
-----END PGP SIGNATURE-----

--Sig_/c8ggg1/YX6MNrIzXEYXQX8O--
