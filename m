Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F24CC28CC5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 00:32:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1BB020717
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 00:32:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="cjOVpyVE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbfFFAcY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 20:32:24 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:59885 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726532AbfFFAcX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 20:32:23 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45K6786SHdz9sND;
        Thu,  6 Jun 2019 10:32:20 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1559781141;
        bh=xX0NK+dVc6rN21G8F08XZuRFtW8t1EJKv0G7QCY5CSI=;
        h=Date:From:To:Cc:Subject:From;
        b=cjOVpyVE736PfGhl905bHWQKRw/5RnYJq4AjKT2E5K2R6oAlxmj9R1PWVRKBJXDby
         Qq6EPfG3Fbouxitr3E8TMhLK8QjIZIqbKLs8IpEq2xlfQErie2u7dnd8BnWcfLVpWB
         bdUv/+O5aqiCWRHd17/vF227ZxMB/QcXXSPK2OX1OI3jRyY900x+WpiEkfnvR02Sds
         bqfDjjVuibnUpudz2c2zG9wljaHklRMgiHIIU93hzikc19Yd8EwBgurWeXB+TtK6v5
         ZKpaMijdnih9AJRGlZGnBxv9HyViD/PhDleEfgpem8e4MRbfTL/MxN+ZtCBat4+Nn8
         NHOaxsG55vJpw==
Date:   Thu, 6 Jun 2019 10:32:20 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "amy.shih" <amy.shih@advantech.com.tw>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kees Cook <keescook@chromium.org>
Subject: linux-next: build warnings after merge of the hwmon-staging tree
Message-ID: <20190606103220.1168317e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/jp2IeK1cPImbdQNeyy9X1hn"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/jp2IeK1cPImbdQNeyy9X1hn
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the hwmon-staging tree, today's linux-next build (x86_64
allmodconfig) produced this warning:

drivers/hwmon/nct7904.c: In function 'nct7904_in_is_visible':
drivers/hwmon/nct7904.c:313:6: warning: this statement may fall through [-W=
implicit-fallthrough=3D]
   if (channel > 0 && (data->vsen_mask & BIT(index)))
      ^
drivers/hwmon/nct7904.c:315:2: note: here
  case hwmon_in_min:
  ^~~~
drivers/hwmon/nct7904.c: In function 'nct7904_fan_is_visible':
drivers/hwmon/nct7904.c:230:6: warning: this statement may fall through [-W=
implicit-fallthrough=3D]
   if (data->fanin_mask & (1 << channel))
      ^
drivers/hwmon/nct7904.c:232:2: note: here
  case hwmon_fan_min:
  ^~~~
drivers/hwmon/nct7904.c: In function 'nct7904_temp_is_visible':
drivers/hwmon/nct7904.c:443:6: warning: this statement may fall through [-W=
implicit-fallthrough=3D]
   if (channel < 5) {
      ^
drivers/hwmon/nct7904.c:450:2: note: here
  case hwmon_temp_max:
  ^~~~

Introduced by commit

  af55ab0b0792 ("hwmon: (nct7904) Add extra sysfs support for fan, voltage =
and temperature.")

I get these warnings because I am building with -Wimplicit-fallthrough
in attempt to catch new additions early.  The gcc warning can be turned
off by adding a /* fall through */ comment at the point the fall through
happens (assuming that the fall through is intentional).

--=20
Cheers,
Stephen Rothwell

--Sig_/jp2IeK1cPImbdQNeyy9X1hn
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlz4XxQACgkQAVBC80lX
0GxHrwf/b52AhBEkP/dSy+wGbsZhpjUGSUeC6kHyqPyMrRMdf1DUSP15WdD9cfGr
ByAPjvP+UMZcz/+/bEwCSPobhgXRekE+CpEzIRTPudNcTspq0tTCWVnTLKLfjOx7
Fy/VJOsbq0oRGs7+V5YyxO2IR1ECNVbg906I2RKB2fSjCnJmY+a4f/frSkRgqnON
+UWufptun4ri8kvt4ab/IhFZc/dTaZzpuZr/AIVbxR5MBVXMAPdVhvyAMqYBXn7n
GWptCTJUvG0jdMEtBxkHNUAz9L2oVe+j1BdC5qOXxbZPZZE3slU0KEdKolurlW7H
cDiDTw3f65nUx3G/wZboyGfrmEgMLA==
=GsH5
-----END PGP SIGNATURE-----

--Sig_/jp2IeK1cPImbdQNeyy9X1hn--
