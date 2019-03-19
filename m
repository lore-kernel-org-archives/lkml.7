Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BEEEC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 23:45:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E90342175B
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 23:45:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="UoHEiFee"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727145AbfCSXpW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 19:45:22 -0400
Received: from ozlabs.org ([203.11.71.1]:45885 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726835AbfCSXpW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 19:45:22 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44P8mv2jB5z9s70;
        Wed, 20 Mar 2019 10:45:19 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1553039119;
        bh=W7mTYc7KaGuerLPj3MY+nNOmg3cW6Wdl/ogum+xjDb4=;
        h=Date:From:To:Cc:Subject:From;
        b=UoHEiFeehQK2gI+4tfQRyjtzCrMv+as6rX45uFOo3xaDry9PsAmYsSsQP1mvrIZh2
         lmgMOVZIYCWyS3ooXinNdvVsAze1HCzo/z/hnNt0ogEHTWNHJ3K8TeplHf1kbcFDJS
         RosB5JCBFHf7M+ZSR70LnXr039RVcHX+06oUs2Zcx7Rqarb2UHo6jOVW2kksbSzc/J
         grMf8NZpVXsydcfPMsg4G4285TESjjiL3ketOSi+t8n9gqvPnhnjayYo9fJmD0+5S7
         3kOPsuLnShUFwgS/KcZJmxOvqndHQQnj8IcPFu1IoKY02mNgGch38cxZ1PK8XqpV60
         Goo/oAeW7LWow==
Date:   Wed, 20 Mar 2019 10:45:02 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Wen Shi <wenshi@opensource.cirrus.com>
Subject: linux-next: build warning after merge of the sound-asoc tree
Message-ID: <20190320104502.29d22b96@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/KUo4UheB7.tCZKCPkEosc3O"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/KUo4UheB7.tCZKCPkEosc3O
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the sound-asoc tree, today's linux-next build (x86_64
allmodconfig) produced this warning:

In file included from include/linux/pm_runtime.h:12,
                 from sound/soc/codecs/wm_adsp.c:21:
sound/soc/codecs/wm_adsp.c: In function 'wmfw_parse_id_header':
sound/soc/codecs/wm_adsp.c:45:22: warning: format '%zu' expects argument of=
 type 'size_t', but argument 8 has type 'int' [-Wformat=3D]
  dev_info(_dsp->dev, "%s: " fmt, _dsp->name, ##__VA_ARGS__)
                      ^~~~~~
include/linux/device.h:1400:22: note: in definition of macro 'dev_fmt'
 #define dev_fmt(fmt) fmt
                      ^~~
sound/soc/codecs/wm_adsp.c:45:2: note: in expansion of macro 'dev_info'
  dev_info(_dsp->dev, "%s: " fmt, _dsp->name, ##__VA_ARGS__)
  ^~~~~~~~
sound/soc/codecs/wm_adsp.c:2145:2: note: in expansion of macro 'adsp_info'
  adsp_info(dsp, "Firmware: %x v%d.%d.%d, %zu algorithms\n",
  ^~~~~~~~~
sound/soc/codecs/wm_adsp.c:2145:44: note: format string is defined here
  adsp_info(dsp, "Firmware: %x v%d.%d.%d, %zu algorithms\n",
                                          ~~^
                                          %u
In file included from include/linux/pm_runtime.h:12,
                 from sound/soc/codecs/wm_adsp.c:21:
sound/soc/codecs/wm_adsp.c: In function 'wmfw_v3_parse_id_header':
sound/soc/codecs/wm_adsp.c:45:22: warning: format '%zu' expects argument of=
 type 'size_t', but argument 9 has type 'int' [-Wformat=3D]
  dev_info(_dsp->dev, "%s: " fmt, _dsp->name, ##__VA_ARGS__)
                      ^~~~~~
include/linux/device.h:1400:22: note: in definition of macro 'dev_fmt'
 #define dev_fmt(fmt) fmt
                      ^~~
sound/soc/codecs/wm_adsp.c:45:2: note: in expansion of macro 'dev_info'
  dev_info(_dsp->dev, "%s: " fmt, _dsp->name, ##__VA_ARGS__)
  ^~~~~~~~
sound/soc/codecs/wm_adsp.c:2158:2: note: in expansion of macro 'adsp_info'
  adsp_info(dsp, "Firmware: %x vendor: 0x%x v%d.%d.%d, %zu algorithms\n",
  ^~~~~~~~~
sound/soc/codecs/wm_adsp.c:2158:57: note: format string is defined here
  adsp_info(dsp, "Firmware: %x vendor: 0x%x v%d.%d.%d, %zu algorithms\n",
                                                       ~~^
                                                       %u

Introduced by commits

  a5dcb24d70ff ("ASoC: wm_adsp: Factor out parsing of firmware ID header")
  170b1e123f38 ("ASoC: wm_adsp: Add support for new Halo core DSPs")

--=20
Cheers,
Stephen Rothwell

--Sig_/KUo4UheB7.tCZKCPkEosc3O
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlyRfv4ACgkQAVBC80lX
0GwIhAgAix2SPD+KLayj90+ET1qt9404kvtE7GMDzX5scOQnllo4WhRQjYoQaiey
QpJ/Jenor+SO7FtsGiETefBuU7Tgywl7tECd/A3h0fMu4fb0WLHfkIuiL/E0f74u
1Z0uV2AZCq0q1RrXaaWI43frBuSMJz94EN5KlafAnhTfc9Mqa1ZKFX89gDgRgveN
HuyyCIKdbMzQToThjesRKW/+wVQfAyXdJjM+Ip6kV2ipe4VGtG9vB0k03v3IeCbl
nqNMIbHEcOe7St7kEoGiJEUIX5XpWZIMyl5ear3g2jP1UNNwEH0QxfegVmEp/WGc
ae5ieG63wOgbt8tOk4C6fOymuHpW1w==
=6O7Y
-----END PGP SIGNATURE-----

--Sig_/KUo4UheB7.tCZKCPkEosc3O--
