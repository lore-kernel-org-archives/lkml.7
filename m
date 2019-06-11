Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDEC0C43218
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 00:42:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD1F1206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 00:42:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="e9RVoK6l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728904AbfFKAmn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 20:42:43 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:33679 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728645AbfFKAmm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 20:42:42 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45NB6m0JrXz9s6w;
        Tue, 11 Jun 2019 10:42:40 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1560213760;
        bh=3YClmk+7vZOeaLZeCfF1lGV7UTUaJ5rr0JUABVbvYSA=;
        h=Date:From:To:Cc:Subject:From;
        b=e9RVoK6lQxCwYPMndJiuUHqu1ko7boUszaR0QTHaOW9+jAzP2xhR85wKTkvECzd0o
         o8nCVjMKIucFjpqhQDFK01cZjMk1PVLcW9pXUHzki/pxqXJdD+5xgY/DNFenHCQWiy
         pAty7mg67HK6FmLpSUPDiLCoHD45ZytYyQ4UTWdXEFX3L/YH0I4SM7rZFlTMU1asEU
         iEdlocmxGKg9xBR1ryTl1mb6JuQpbLI1OGxvVOEON6TTK2iktfButaMPn00LqaiWH4
         KM1jsxyiVmuIiQZy26B4cyF1DSBSUjpHZy+YZpybI6m+pvZxBSVjJU/eYmlVdDkD2J
         YgpVw3NrgIXOg==
Date:   Tue, 11 Jun 2019 10:42:39 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: build warning after merge of the fbdev tree
Message-ID: <20190611104239.109513ab@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/ya33RlH6F2mfjpAyS+1ve/8"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ya33RlH6F2mfjpAyS+1ve/8
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Bartlomiej,

After merging the fbdev tree, today's linux-next build (x86_64
allmodconfig) produced this warning:

drivers/video/fbdev/pvr2fb.c:726:12: warning: 'pvr2_get_param_val' defined =
but not used [-Wunused-function]
 static int pvr2_get_param_val(const struct pvr2_params *p, const char *s,
            ^~~~~~~~~~~~~~~~~~

Introduced by commit

  0f5a5712ad1e ("video: fbdev: pvr2fb: add COMPILE_TEST support")

The uses are protected by #ifndef MODULE.

--=20
Cheers,
Stephen Rothwell

--Sig_/ya33RlH6F2mfjpAyS+1ve/8
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlz++P8ACgkQAVBC80lX
0GyKvwf/WIWZqtKz/HxIhvWRbM7gKQKjxPqxUYUnckHlokdWkXNiSCQvGp/+PStd
Z6qpoH/4zUnW8KHPLWpDwCTsXKyy7RAOkKJlat7Z5Fi9U84fT67piDzxu0+BHM1x
E+86yq+HvnGiwts4rPuzwES9v0sK8RNTp/rqJilIpMBw/JdMHd8+uyG4KdATR1F9
Db2aLQY0pxVN3ZOQL7jFNviJ7Wf/0y2E3YKAHIEHfeWps+k1u+LtVa0bwYWqRh/s
I8nCBTeeuCWrDwmTU9uUUV81D7E4bF85gysbk8D5z6Ngf81a45TQKPd8+n6SgvQ6
5yiDoEYIVEe4OL9nH9CdfBSVUgPE6A==
=7k8Y
-----END PGP SIGNATURE-----

--Sig_/ya33RlH6F2mfjpAyS+1ve/8--
