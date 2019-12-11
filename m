Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1322C2D0C6
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 22:50:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 865BD20836
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 22:50:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="n7/37nEY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbfLKWun (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 17:50:43 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:60031 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726345AbfLKWun (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 17:50:43 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 47YBwc16DNz9sP6;
        Thu, 12 Dec 2019 09:50:40 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1576104640;
        bh=pQEWo5nmTzCkaZ4PlrWd7fpWflTlm/IgljPiEi4JfOE=;
        h=Date:From:To:Cc:Subject:From;
        b=n7/37nEY2a1/ribIDMBlerheVbx+9ucJI8gwm0Eq7J77KOOjXiFIBNYxVEW24EWv4
         sUXZ8FY0xJTmWJ2vgyaRTFkFEKrNxKibbkB40enTGrDXkCMxtcj/LlgP8ia6nhTfrj
         zlETJKKh4FtNz3123XWZKOnz6toazEuyKrZQkkYlXnzPgSyNbrs89AsAWbzCPErYIg
         tzNg+J+NG35JH0/NjCUT/9y4phlaqkjAdTd3/zkTITF8bo2UGLeTiGViNyQ30qL8qU
         +JadA3mbHYybgSZ7sBOmJgb1cKoEPyBYjsaq30Kq2GHWE0FyL6zNrVwsRmkcpy/JPf
         2mF7MKZRRL44w==
Date:   Thu, 12 Dec 2019 09:50:20 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrey Smirnov <andrew.smirnov@gmail.com>
Subject: linux-next: build failure after merge of the thermal tree
Message-ID: <20191212095020.523c1fbd@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/MQpQLpN+idyvXG0dyITdbze";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/MQpQLpN+idyvXG0dyITdbze
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the thermal tree, today's linux-next build (x86_64
allmodconfig) failed like this:

drivers/thermal/qoriq_thermal.c: In function 'qoriq_tmu_probe':
drivers/thermal/qoriq_thermal.c:247:20: error: 'SZ_4K' undeclared (first us=
e in this function)
  247 |   .max_register  =3D SZ_4K,
      |                    ^~~~~

Caused by commit

  c98030e5440d ("thermal: qoriq: Convert driver to use regmap API")

I have used the thermal tree from next-20191211 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/MQpQLpN+idyvXG0dyITdbze
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl3xcqwACgkQAVBC80lX
0GzRAggAhFdWcOVRvWwSQ5DgU5J9PAq8induFZFLzpYkl0qdGlYcFQ19R/oNCk2E
fFhXov042+oZk0KuKWSAsXVJKI8vlBI3VA7FZTdAbWR0ilXgfbY2LP6PPDlrSuSW
HG23iTC6v0o6fvylsP8RNpV967W9sOi9ZlvB7xqTFCHT49rqH2pKn+hg//J8gzEC
69gLPItcdjUL4MDqz36QJiMCk4Tsema6Udl1u1+xlYIyDex33+/Qjh1mMxpwC6vH
/cO49xKxZVJnIPSew37rMKb6lDsqzDTnNNdSJcuVa1qsWIHaYaTTbDj9GTyjT9Oc
yInUxPxgujmObphYMAuWjjfrl5ngkg==
=2Ll7
-----END PGP SIGNATURE-----

--Sig_/MQpQLpN+idyvXG0dyITdbze--
