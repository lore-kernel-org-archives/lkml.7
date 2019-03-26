Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7642BC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 02:33:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BBBA20811
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 02:33:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="VonFoxm5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730625AbfCZCdz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 22:33:55 -0400
Received: from ozlabs.org ([203.11.71.1]:56895 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726553AbfCZCdy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 22:33:54 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44SwDZ1RfWz9sSX;
        Tue, 26 Mar 2019 13:33:50 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1553567630;
        bh=+2XOQDm9zHvPMiAGiYHcvgDmFWIwJFM7xMqfG32IkzE=;
        h=Date:From:To:Cc:Subject:From;
        b=VonFoxm5W47FxDVumGbSCUPw7oriIBZcvy6Td+E2AWpjqq/fZOdC26DyPoXhN/niI
         4a8t5LGQV+oq9AWMfpdPeR+cHzsa0beug/FK8nN+3HRhUtnhewqqEStYYMgS9gqQun
         kJZR5pbAjrkkjZz1qwfcMSLjA5cllPHHkVa/JJmJMMWApjBtkAoJQN25R7fHRvQF3N
         UzFZcewOxy1kxDcpSMSZH5R+iBrBT3bWgk1K715hlLmHk05pg/TCzki5IFuDtkd0dR
         Y1xOA5pAq6NYASyxS5BAj7t6B2VEQzCcR/SLoFMKdxPdrwZJq+OJYoJlCbEfNQsa+2
         xOhM55H9FvQdA==
Date:   Tue, 26 Mar 2019 13:33:49 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Annaliese McDermond <nh6z@nh6z.net>
Subject: linux-next: build failure after merge of the sound-asoc tree
Message-ID: <20190326133349.3d9427dc@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/zSXO.IBzzLUjpIjCBp586O7"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/zSXO.IBzzLUjpIjCBp586O7
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the sound-asoc tree, today's linux-next build (powerpc
allyesconfig) failed like this:

sound/soc/codecs/tlv320aic32x4-clk.c:19:16: error: field 'hw' has incomplet=
e type
  struct clk_hw hw;
                ^~
In file included from include/linux/init.h:5,
                 from include/linux/io.h:22,
                 from include/linux/clk-provider.h:9,
                 from sound/soc/codecs/tlv320aic32x4-clk.c:10:
sound/soc/codecs/tlv320aic32x4-clk.c: In function 'clk_aic32x4_pll_prepare':
include/linux/kernel.h:979:32: error: dereferencing pointer to incomplete t=
ype 'struct clk_hw'
  BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) && \
                                ^~~~~~
include/linux/compiler.h:328:9: note: in definition of macro '__compiletime=
_assert'
   if (!(condition))     \
         ^~~~~~~~~
include/linux/compiler.h:348:2: note: in expansion of macro '_compiletime_a=
ssert'
  _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
  ^~~~~~~~~~~~~~~~~~~
include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_a=
ssert'
 #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
                                     ^~~~~~~~~~~~~~~~~~
include/linux/kernel.h:979:2: note: in expansion of macro 'BUILD_BUG_ON_MSG'
  BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) && \
  ^~~~~~~~~~~~~~~~
include/linux/kernel.h:979:20: note: in expansion of macro '__same_type'
  BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) && \
                    ^~~~~~~~~~~
sound/soc/codecs/tlv320aic32x4-clk.c:17:29: note: in expansion of macro 'co=
ntainer_of'
 #define to_clk_aic32x4(_hw) container_of(_hw, struct clk_aic32x4, hw)
                             ^~~~~~~~~~~~
sound/soc/codecs/tlv320aic32x4-clk.c:49:28: note: in expansion of macro 'to=
_clk_aic32x4'
  struct clk_aic32x4 *pll =3D to_clk_aic32x4(hw);
                            ^~~~~~~~~~~~~~
sound/soc/codecs/tlv320aic32x4-clk.c: At top level:
sound/soc/codecs/tlv320aic32x4-clk.c:257:21: error: variable 'aic32x4_pll_o=
ps' has initializer but incomplete type
 static const struct clk_ops aic32x4_pll_ops =3D {
                     ^~~~~~~
sound/soc/codecs/tlv320aic32x4-clk.c:258:3: error: 'const struct clk_ops' h=
as no member named 'prepare'
  .prepare =3D clk_aic32x4_pll_prepare,
   ^~~~~~~
sound/soc/codecs/tlv320aic32x4-clk.c:258:13: warning: excess elements in st=
ruct initializer
  .prepare =3D clk_aic32x4_pll_prepare,
             ^~~~~~~~~~~~~~~~~~~~~~~
sound/soc/codecs/tlv320aic32x4-clk.c:258:13: note: (near initialization for=
 'aic32x4_pll_ops')
sound/soc/codecs/tlv320aic32x4-clk.c:259:3: error: 'const struct clk_ops' h=
as no member named 'unprepare'
  .unprepare =3D clk_aic32x4_pll_unprepare,
   ^~~~~~~~~
sound/soc/codecs/tlv320aic32x4-clk.c:259:15: warning: excess elements in st=
ruct initializer
  .unprepare =3D clk_aic32x4_pll_unprepare,
               ^~~~~~~~~~~~~~~~~~~~~~~~~
sound/soc/codecs/tlv320aic32x4-clk.c:259:15: note: (near initialization for=
 'aic32x4_pll_ops')
sound/soc/codecs/tlv320aic32x4-clk.c:260:3: error: 'const struct clk_ops' h=
as no member named 'is_prepared'
  .is_prepared =3D clk_aic32x4_pll_is_prepared,
   ^~~~~~~~~~~
sound/soc/codecs/tlv320aic32x4-clk.c:260:17: warning: excess elements in st=
ruct initializer
  .is_prepared =3D clk_aic32x4_pll_is_prepared,
                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~
sound/soc/codecs/tlv320aic32x4-clk.c:260:17: note: (near initialization for=
 'aic32x4_pll_ops')
sound/soc/codecs/tlv320aic32x4-clk.c:261:3: error: 'const struct clk_ops' h=
as no member named 'recalc_rate'
  .recalc_rate =3D clk_aic32x4_pll_recalc_rate,
   ^~~~~~~~~~~
sound/soc/codecs/tlv320aic32x4-clk.c:261:17: warning: excess elements in st=
ruct initializer
  .recalc_rate =3D clk_aic32x4_pll_recalc_rate,
                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~
sound/soc/codecs/tlv320aic32x4-clk.c:261:17: note: (near initialization for=
 'aic32x4_pll_ops')
sound/soc/codecs/tlv320aic32x4-clk.c:262:3: error: 'const struct clk_ops' h=
as no member named 'round_rate'
  .round_rate =3D clk_aic32x4_pll_round_rate,
   ^~~~~~~~~~
sound/soc/codecs/tlv320aic32x4-clk.c:262:16: warning: excess elements in st=
ruct initializer
  .round_rate =3D clk_aic32x4_pll_round_rate,
                ^~~~~~~~~~~~~~~~~~~~~~~~~~
sound/soc/codecs/tlv320aic32x4-clk.c:262:16: note: (near initialization for=
 'aic32x4_pll_ops')
sound/soc/codecs/tlv320aic32x4-clk.c:263:3: error: 'const struct clk_ops' h=
as no member named 'set_rate'
  .set_rate =3D clk_aic32x4_pll_set_rate,
   ^~~~~~~~
sound/soc/codecs/tlv320aic32x4-clk.c:263:14: warning: excess elements in st=
ruct initializer
  .set_rate =3D clk_aic32x4_pll_set_rate,
              ^~~~~~~~~~~~~~~~~~~~~~~~
sound/soc/codecs/tlv320aic32x4-clk.c:263:14: note: (near initialization for=
 'aic32x4_pll_ops')
sound/soc/codecs/tlv320aic32x4-clk.c:264:3: error: 'const struct clk_ops' h=
as no member named 'set_parent'
  .set_parent =3D clk_aic32x4_pll_set_parent,
   ^~~~~~~~~~
sound/soc/codecs/tlv320aic32x4-clk.c:264:16: warning: excess elements in st=
ruct initializer
  .set_parent =3D clk_aic32x4_pll_set_parent,
                ^~~~~~~~~~~~~~~~~~~~~~~~~~
sound/soc/codecs/tlv320aic32x4-clk.c:264:16: note: (near initialization for=
 'aic32x4_pll_ops')
sound/soc/codecs/tlv320aic32x4-clk.c:265:3: error: 'const struct clk_ops' h=
as no member named 'get_parent'
  .get_parent =3D clk_aic32x4_pll_get_parent,
   ^~~~~~~~~~
sound/soc/codecs/tlv320aic32x4-clk.c:265:16: warning: excess elements in st=
ruct initializer
  .get_parent =3D clk_aic32x4_pll_get_parent,
                ^~~~~~~~~~~~~~~~~~~~~~~~~~
sound/soc/codecs/tlv320aic32x4-clk.c:265:16: note: (near initialization for=
 'aic32x4_pll_ops')
sound/soc/codecs/tlv320aic32x4-clk.c:287:21: error: variable 'aic32x4_codec=
_clkin_ops' has initializer but incomplete type
 static const struct clk_ops aic32x4_codec_clkin_ops =3D {
                     ^~~~~~~
sound/soc/codecs/tlv320aic32x4-clk.c:288:3: error: 'const struct clk_ops' h=
as no member named 'set_parent'
  .set_parent =3D clk_aic32x4_codec_clkin_set_parent,
   ^~~~~~~~~~
sound/soc/codecs/tlv320aic32x4-clk.c:288:16: warning: excess elements in st=
ruct initializer
  .set_parent =3D clk_aic32x4_codec_clkin_set_parent,
                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
sound/soc/codecs/tlv320aic32x4-clk.c:288:16: note: (near initialization for=
 'aic32x4_codec_clkin_ops')
sound/soc/codecs/tlv320aic32x4-clk.c:289:3: error: 'const struct clk_ops' h=
as no member named 'get_parent'
  .get_parent =3D clk_aic32x4_codec_clkin_get_parent,
   ^~~~~~~~~~
sound/soc/codecs/tlv320aic32x4-clk.c:289:16: warning: excess elements in st=
ruct initializer
  .get_parent =3D clk_aic32x4_codec_clkin_get_parent,
                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
sound/soc/codecs/tlv320aic32x4-clk.c:289:16: note: (near initialization for=
 'aic32x4_codec_clkin_ops')
sound/soc/codecs/tlv320aic32x4-clk.c:346:21: error: variable 'aic32x4_div_o=
ps' has initializer but incomplete type
 static const struct clk_ops aic32x4_div_ops =3D {
                     ^~~~~~~
sound/soc/codecs/tlv320aic32x4-clk.c:347:3: error: 'const struct clk_ops' h=
as no member named 'prepare'
  .prepare =3D clk_aic32x4_div_prepare,
   ^~~~~~~
sound/soc/codecs/tlv320aic32x4-clk.c:347:13: warning: excess elements in st=
ruct initializer
  .prepare =3D clk_aic32x4_div_prepare,
             ^~~~~~~~~~~~~~~~~~~~~~~
sound/soc/codecs/tlv320aic32x4-clk.c:347:13: note: (near initialization for=
 'aic32x4_div_ops')
sound/soc/codecs/tlv320aic32x4-clk.c:348:3: error: 'const struct clk_ops' h=
as no member named 'unprepare'
  .unprepare =3D clk_aic32x4_div_unprepare,
   ^~~~~~~~~
sound/soc/codecs/tlv320aic32x4-clk.c:348:15: warning: excess elements in st=
ruct initializer
  .unprepare =3D clk_aic32x4_div_unprepare,
               ^~~~~~~~~~~~~~~~~~~~~~~~~
sound/soc/codecs/tlv320aic32x4-clk.c:348:15: note: (near initialization for=
 'aic32x4_div_ops')
sound/soc/codecs/tlv320aic32x4-clk.c:349:3: error: 'const struct clk_ops' h=
as no member named 'set_rate'
  .set_rate =3D clk_aic32x4_div_set_rate,
   ^~~~~~~~
sound/soc/codecs/tlv320aic32x4-clk.c:349:14: warning: excess elements in st=
ruct initializer
  .set_rate =3D clk_aic32x4_div_set_rate,
              ^~~~~~~~~~~~~~~~~~~~~~~~
sound/soc/codecs/tlv320aic32x4-clk.c:349:14: note: (near initialization for=
 'aic32x4_div_ops')
sound/soc/codecs/tlv320aic32x4-clk.c:350:3: error: 'const struct clk_ops' h=
as no member named 'round_rate'
  .round_rate =3D clk_aic32x4_div_round_rate,
   ^~~~~~~~~~
sound/soc/codecs/tlv320aic32x4-clk.c:350:16: warning: excess elements in st=
ruct initializer
  .round_rate =3D clk_aic32x4_div_round_rate,
                ^~~~~~~~~~~~~~~~~~~~~~~~~~
sound/soc/codecs/tlv320aic32x4-clk.c:350:16: note: (near initialization for=
 'aic32x4_div_ops')
sound/soc/codecs/tlv320aic32x4-clk.c:351:3: error: 'const struct clk_ops' h=
as no member named 'recalc_rate'
  .recalc_rate =3D clk_aic32x4_div_recalc_rate,
   ^~~~~~~~~~~
sound/soc/codecs/tlv320aic32x4-clk.c:351:17: warning: excess elements in st=
ruct initializer
  .recalc_rate =3D clk_aic32x4_div_recalc_rate,
                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~
sound/soc/codecs/tlv320aic32x4-clk.c:351:17: note: (near initialization for=
 'aic32x4_div_ops')
sound/soc/codecs/tlv320aic32x4-clk.c:372:21: error: variable 'aic32x4_bdiv_=
ops' has initializer but incomplete type
 static const struct clk_ops aic32x4_bdiv_ops =3D {
                     ^~~~~~~
sound/soc/codecs/tlv320aic32x4-clk.c:373:3: error: 'const struct clk_ops' h=
as no member named 'prepare'
  .prepare =3D clk_aic32x4_div_prepare,
   ^~~~~~~
sound/soc/codecs/tlv320aic32x4-clk.c:373:13: warning: excess elements in st=
ruct initializer
  .prepare =3D clk_aic32x4_div_prepare,
             ^~~~~~~~~~~~~~~~~~~~~~~
sound/soc/codecs/tlv320aic32x4-clk.c:373:13: note: (near initialization for=
 'aic32x4_bdiv_ops')
sound/soc/codecs/tlv320aic32x4-clk.c:374:3: error: 'const struct clk_ops' h=
as no member named 'unprepare'
  .unprepare =3D clk_aic32x4_div_unprepare,
   ^~~~~~~~~
sound/soc/codecs/tlv320aic32x4-clk.c:374:15: warning: excess elements in st=
ruct initializer
  .unprepare =3D clk_aic32x4_div_unprepare,
               ^~~~~~~~~~~~~~~~~~~~~~~~~
sound/soc/codecs/tlv320aic32x4-clk.c:374:15: note: (near initialization for=
 'aic32x4_bdiv_ops')
sound/soc/codecs/tlv320aic32x4-clk.c:375:3: error: 'const struct clk_ops' h=
as no member named 'set_parent'
  .set_parent =3D clk_aic32x4_bdiv_set_parent,
   ^~~~~~~~~~
sound/soc/codecs/tlv320aic32x4-clk.c:375:16: warning: excess elements in st=
ruct initializer
  .set_parent =3D clk_aic32x4_bdiv_set_parent,
                ^~~~~~~~~~~~~~~~~~~~~~~~~~~
sound/soc/codecs/tlv320aic32x4-clk.c:375:16: note: (near initialization for=
 'aic32x4_bdiv_ops')
sound/soc/codecs/tlv320aic32x4-clk.c:376:3: error: 'const struct clk_ops' h=
as no member named 'get_parent'
  .get_parent =3D clk_aic32x4_bdiv_get_parent,
   ^~~~~~~~~~
sound/soc/codecs/tlv320aic32x4-clk.c:376:16: warning: excess elements in st=
ruct initializer
  .get_parent =3D clk_aic32x4_bdiv_get_parent,
                ^~~~~~~~~~~~~~~~~~~~~~~~~~~
sound/soc/codecs/tlv320aic32x4-clk.c:376:16: note: (near initialization for=
 'aic32x4_bdiv_ops')
sound/soc/codecs/tlv320aic32x4-clk.c:377:3: error: 'const struct clk_ops' h=
as no member named 'set_rate'
  .set_rate =3D clk_aic32x4_div_set_rate,
   ^~~~~~~~
sound/soc/codecs/tlv320aic32x4-clk.c:377:14: warning: excess elements in st=
ruct initializer
  .set_rate =3D clk_aic32x4_div_set_rate,
              ^~~~~~~~~~~~~~~~~~~~~~~~
sound/soc/codecs/tlv320aic32x4-clk.c:377:14: note: (near initialization for=
 'aic32x4_bdiv_ops')
sound/soc/codecs/tlv320aic32x4-clk.c:378:3: error: 'const struct clk_ops' h=
as no member named 'round_rate'
  .round_rate =3D clk_aic32x4_div_round_rate,
   ^~~~~~~~~~
sound/soc/codecs/tlv320aic32x4-clk.c:378:16: warning: excess elements in st=
ruct initializer
  .round_rate =3D clk_aic32x4_div_round_rate,
                ^~~~~~~~~~~~~~~~~~~~~~~~~~
sound/soc/codecs/tlv320aic32x4-clk.c:378:16: note: (near initialization for=
 'aic32x4_bdiv_ops')
sound/soc/codecs/tlv320aic32x4-clk.c:379:3: error: 'const struct clk_ops' h=
as no member named 'recalc_rate'
  .recalc_rate =3D clk_aic32x4_div_recalc_rate,
   ^~~~~~~~~~~
sound/soc/codecs/tlv320aic32x4-clk.c:379:17: warning: excess elements in st=
ruct initializer
  .recalc_rate =3D clk_aic32x4_div_recalc_rate,
                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~
sound/soc/codecs/tlv320aic32x4-clk.c:379:17: note: (near initialization for=
 'aic32x4_bdiv_ops')
sound/soc/codecs/tlv320aic32x4-clk.c: In function 'aic32x4_register_clk':
sound/soc/codecs/tlv320aic32x4-clk.c:440:23: error: storage size of 'init' =
isn't known
  struct clk_init_data init;
                       ^~~~
sound/soc/codecs/tlv320aic32x4-clk.c:460:9: error: implicit declaration of =
function 'devm_clk_register'; did you mean 'device_register'? [-Werror=3Dim=
plicit-function-declaration]
  return devm_clk_register(dev, &priv->hw);
         ^~~~~~~~~~~~~~~~~
         device_register
sound/soc/codecs/tlv320aic32x4-clk.c:440:23: warning: unused variable 'init=
' [-Wunused-variable]
  struct clk_init_data init;
                       ^~~~
sound/soc/codecs/tlv320aic32x4-clk.c: At top level:
sound/soc/codecs/tlv320aic32x4-clk.c:257:29: error: storage size of 'aic32x=
4_pll_ops' isn't known
 static const struct clk_ops aic32x4_pll_ops =3D {
                             ^~~~~~~~~~~~~~~
sound/soc/codecs/tlv320aic32x4-clk.c:287:29: error: storage size of 'aic32x=
4_codec_clkin_ops' isn't known
 static const struct clk_ops aic32x4_codec_clkin_ops =3D {
                             ^~~~~~~~~~~~~~~~~~~~~~~
sound/soc/codecs/tlv320aic32x4-clk.c:346:29: error: storage size of 'aic32x=
4_div_ops' isn't known
 static const struct clk_ops aic32x4_div_ops =3D {
                             ^~~~~~~~~~~~~~~
sound/soc/codecs/tlv320aic32x4-clk.c:372:29: error: storage size of 'aic32x=
4_bdiv_ops' isn't known
 static const struct clk_ops aic32x4_bdiv_ops =3D {
                             ^~~~~~~~~~~~~~~~
sound/soc/codecs/tlv320aic32x4-clk.c: In function 'aic32x4_register_clk':
sound/soc/codecs/tlv320aic32x4-clk.c:461:1: warning: control reaches end of=
 non-void function [-Wreturn-type]
 }
 ^

Caused by commit

  514b044cba66 ("ASoC: tlv320aic32x4: Model PLL in CCF")

This build has

CONFIG_SND_SOC_TLV320AIC32X4=3Dy
CONFIG_SND_SOC_TLV320AIC32X4_I2C=3Dy
CONFIG_SND_SOC_TLV320AIC32X4_SPI=3Dy

but CONFIG_COMMON_CLK is not set.  I assume tha bove get set due to
"select" statements and we get this warning:

WARNING: unmet direct dependencies detected for SND_SOC_TLV320AIC32X4
  Depends on [n]: SOUND [=3Dy] && !UML && SND [=3Dy] && SND_SOC [=3Dy] && C=
OMMON_CLK [=3Dn]
  Selected by [y]:
  - SND_SOC_TLV320AIC32X4_I2C [=3Dy] && SOUND [=3Dy] && !UML && SND [=3Dy] =
&& SND_SOC [=3Dy] && I2C [=3Dy]
  - SND_SOC_TLV320AIC32X4_SPI [=3Dy] && SOUND [=3Dy] && !UML && SND [=3Dy] =
&& SND_SOC [=3Dy] && SPI_MASTER [=3Dy]

I have disabled that driver for now using:

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Tue, 26 Mar 2019 13:18:03 +1100
Subject: [PATCH] disable the SND_SOC_TLV320AIC32X4 driver for now

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 sound/soc/codecs/Kconfig | 5 +++--
 sound/soc/fsl/Kconfig    | 1 +
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 6e99320c79b8..c225c81a7aef 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -180,8 +180,6 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_TLV320AIC23_SPI if SPI_MASTER
 	select SND_SOC_TLV320AIC26 if SPI_MASTER
 	select SND_SOC_TLV320AIC31XX if I2C
-	select SND_SOC_TLV320AIC32X4_I2C if I2C
-	select SND_SOC_TLV320AIC32X4_SPI if SPI_MASTER
 	select SND_SOC_TLV320AIC3X if I2C
 	select SND_SOC_TPA6130A2 if I2C
 	select SND_SOC_TLV320DAC33 if I2C
@@ -1105,15 +1103,18 @@ config SND_SOC_TLV320AIC31XX
=20
 config SND_SOC_TLV320AIC32X4
 	tristate
+	depends on BROKEN
 	depends on COMMON_CLK
=20
 config SND_SOC_TLV320AIC32X4_I2C
 	tristate "Texas Instruments TLV320AIC32x4 audio CODECs - I2C"
+	depends on BROKEN
 	depends on I2C
 	select SND_SOC_TLV320AIC32X4
=20
 config SND_SOC_TLV320AIC32X4_SPI
 	tristate "Texas Instruments TLV320AIC32x4 audio CODECs - SPI"
+	depends on BROKEN
 	depends on SPI_MASTER
 	select SND_SOC_TLV320AIC32X4
=20
diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
index 7b1d9970be8b..d7b4f9d4d61d 100644
--- a/sound/soc/fsl/Kconfig
+++ b/sound/soc/fsl/Kconfig
@@ -207,6 +207,7 @@ config SND_MXC_SOC_WM1133_EV1
=20
 config SND_SOC_MX27VIS_AIC32X4
 	tristate "SoC audio support for Visstrim M10 boards"
+	depends on BROKEN
 	depends on MACH_IMX27_VISSTRIM_M10 && I2C
 	select SND_SOC_TLV320AIC32X4
 	select SND_SOC_IMX_PCM_DMA
--=20
2.20.1

--=20
Cheers,
Stephen Rothwell

--Sig_/zSXO.IBzzLUjpIjCBp586O7
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlyZj40ACgkQAVBC80lX
0GxCHgf/aSN6qdOqSbFFCHc6OoWrzlvcXegT2YwMT5JgjUkJ9AhDoWal6qNn7+Kz
N2JdHru3kRSPmT6I2NgqGQI4FQk2C4qShadxn8fCic287t0oWgOmiVC5jSBw0So8
Bw+vyPq9vSOvt3nzPcgp4Xmshbg26GEGEJHsIMQgPXyGiAZXMoVAwiHl5pDtU1CZ
nfG2NOUwsugtMVuIM6pWAicwc05X6yOUjSAEB1gKa7fFt8cIiSvSaplfSm8RKABh
ZkF9waEUCOwYIrD/CoQHXH0s3HB0fCmWHekhNsF6Ay28dplOHQH4e2oymTP80Q5O
yeOjUxE70RqUsOmEqHGncfQyi2PgWg==
=1BlU
-----END PGP SIGNATURE-----

--Sig_/zSXO.IBzzLUjpIjCBp586O7--
