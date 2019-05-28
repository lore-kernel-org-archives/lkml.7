Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 541ADC072B1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 03:50:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28CF9208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 03:50:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="hluPAzWr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728136AbfE1DuH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 23:50:07 -0400
Received: from ozlabs.org ([203.11.71.1]:58241 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727547AbfE1DuH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 23:50:07 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45CfxS45L6z9s9N;
        Tue, 28 May 2019 13:50:04 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1559015405;
        bh=yDBuiiky7lf02FicYNPQ216CTET2XUnLWME68A4DYHE=;
        h=Date:From:To:Cc:Subject:From;
        b=hluPAzWrCnUuvYL+vjqv4+HihNPcUa1Fn6qwAN1GWEUEKn27eWaB23/8voLloCW++
         fiMQ324Jq3TTN1TpSI6V+YKp8kAk3lJ5WHKfuBYodTL6fe0pjyyElSsHnjr1SWoTwC
         JEVWrzxWU5m8/P75zBQ/4+n9R+zurtwobwd2bctyiUOgz5bdWzOJWGeaIs6A6vTo+z
         /p9jv20yRa21bUDKFfE9PwIgIlx3BC8RbOSkhTO2Q01suanOiHD+6ETjHz67LBPC5/
         hGvOvm5Vt78SZDd8I2cRRsgtcwFIENich15eYxVLUGpYklkS4Oq84xg7t6kEJElr/C
         HGfTcJIfC8HJg==
Date:   Tue, 28 May 2019 13:50:00 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Subject: linux-next: build failure after merge of the akpm-current tree
Message-ID: <20190528135000.247cfe4d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/WmuwxYVxOxiu3GFbVs594I0"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/WmuwxYVxOxiu3GFbVs594I0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the akpm-current tree, today's linux-next build (arm
multi_v7_defconfig) failed like this:

In file included from arch/arm/mm/extable.c:6:
include/linux/uaccess.h:302:29: error: static declaration of 'probe_user_re=
ad' follows non-static declaration
 static __always_inline long probe_user_read(void *dst, const void __user *=
src,
                             ^~~~~~~~~~~~~~~
include/linux/uaccess.h:254:13: note: previous declaration of 'probe_user_r=
ead' was here
 extern long probe_user_read(void *dst, const void __user *src, size_t size=
);
             ^~~~~~~~~~~~~~~

(and more ...)

Caused by commit

  3d127e17e970 ("include/linux/uaccess.h: add probe_user_read()")

interacting with commit

  3d7081822f7f ("uaccess: Add non-pagefault user-space read functions")

from the ftrace tree.

I have reverted the akpm-current tree fix for today (and the following
"mm-add-probe_user_read-fix").  Hopefully the following commit

  f414d1502add ("powerpc: use probe_user_read()") is still valid.

--=20
Cheers,
Stephen Rothwell

--Sig_/WmuwxYVxOxiu3GFbVs594I0
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlzsr+gACgkQAVBC80lX
0GxSyQf7BZj8dtGeDHtIzcfX5OK7tApjoIasX4EkUKLtpg2SWpcc6xIPDQvhIylD
Wxvnth/dd/zmB8//TVsXCLZ3rgQLrStnpHEVrq2mxzeoy5uTh0UPd+fGRz9gk0tE
tpgnX/VZA7PsOU6nM1Mm9b6y+ml0Eo4nYUVS8LnV/592lFaAoazTRSzxJ8wUjb6b
dADaKOkRNzMmoSLuGySBGazZcNGePjs6yYoer6qoIASwvUZyy1of3hmDqL1Usdgm
jD3z++A9TmBVzEZGodFxLBUnjoX10tW8KHU1OfUWCXBoazDeJvTEU34Qo9DRK0VQ
RMOyrREv+TBdkxvv1xkTbKgi7hTosw==
=Yj02
-----END PGP SIGNATURE-----

--Sig_/WmuwxYVxOxiu3GFbVs594I0--
