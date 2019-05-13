Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE44AC04A6B
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 01:02:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61CFF2146F
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 01:02:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="GHYjBaFw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727278AbfEMBCu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 May 2019 21:02:50 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:42923 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727218AbfEMBCu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 May 2019 21:02:50 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 452MxL2dKTz9s00;
        Mon, 13 May 2019 11:02:46 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1557709366;
        bh=Jxbu6ZzafDitOoWW/Of10h08cMn1BUXQ5mUu9eLdBIQ=;
        h=Date:From:To:Cc:Subject:From;
        b=GHYjBaFwqxj0FDQ5AOl/QChDPU/JBJv8X8wWmEPjeKLaAxb95hNtLQuRwZiBKl+UQ
         lfx7fphI47fn1JwK+Zq5gIj+KIiS/1U4jbaFGv9HyIZZQ4DL4cLGsdt+LN8LV6u/od
         Tqt+AVKY9DDH6xKL5kVdwdQvcmlYsF1nF3pUVRjUNjhgehx4542IkrhfUensxuar3/
         gG4iPQ3tNVXiCg4qJVpaUwj8dokaSipqR0+ItKosQ2iMb7E80QJZDMsld9jE9uuIkw
         iywxvPLDmWV0OMeuOpw1/eMFvmB9z9+N/73YGgmeTQtMn6rfMD4kfwnHLPSXR6Ygby
         0CNKYVRkecCOQ==
Date:   Mon, 13 May 2019 11:02:44 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Eduardo Valentin <edubezval@gmail.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: linux-next: build failure after merge of the thermal-soc tree
Message-ID: <20190513110244.0a0dc431@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/m_dtFm01sMQ2bfcj.Jz6mZj"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/m_dtFm01sMQ2bfcj.Jz6mZj
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the thermal-soc tree, today's linux-next build (powerpc
ppc64_defconfig) failed like this:

ld: drivers/infiniband/hw/cxgb4/cm.o: in function `.devm_thermal_of_cooling=
_device_register':
(.text+0x23f0): multiple definition of `.devm_thermal_of_cooling_device_reg=
ister'; drivers/infiniband/hw/cxgb4/device.o:(.text+0x28c0): first defined =
here
ld: drivers/infiniband/hw/cxgb4/cm.o:(.opd+0x2e8): multiple definition of `=
devm_thermal_of_cooling_device_register'; drivers/infiniband/hw/cxgb4/devic=
e.o:(.opd+0x198): first defined here
ld: drivers/infiniband/hw/cxgb4/provider.o: in function `.devm_thermal_of_c=
ooling_device_register':
(.text+0xf90): multiple definition of `.devm_thermal_of_cooling_device_regi=
ster'; drivers/infiniband/hw/cxgb4/device.o:(.text+0x28c0): first defined h=
ere
ld: drivers/infiniband/hw/cxgb4/provider.o:(.opd+0x198): multiple definitio=
n of `devm_thermal_of_cooling_device_register'; drivers/infiniband/hw/cxgb4=
/device.o:(.opd+0x198): first defined here
ld: drivers/infiniband/hw/cxgb4/mem.o: in function `.devm_thermal_of_coolin=
g_device_register':
(.text+0x11c0): multiple definition of `.devm_thermal_of_cooling_device_reg=
ister'; drivers/infiniband/hw/cxgb4/device.o:(.text+0x28c0): first defined =
here
ld: drivers/infiniband/hw/cxgb4/mem.o:(.opd+0xa8): multiple definition of `=
devm_thermal_of_cooling_device_register'; drivers/infiniband/hw/cxgb4/devic=
e.o:(.opd+0x198): first defined here
ld: drivers/infiniband/hw/cxgb4/cq.o: in function `.devm_thermal_of_cooling=
_device_register':
(.text+0x1750): multiple definition of `.devm_thermal_of_cooling_device_reg=
ister'; drivers/infiniband/hw/cxgb4/device.o:(.text+0x28c0): first defined =
here
ld: drivers/infiniband/hw/cxgb4/cq.o:(.opd+0x90): multiple definition of `d=
evm_thermal_of_cooling_device_register'; drivers/infiniband/hw/cxgb4/device=
.o:(.opd+0x198): first defined here
ld: drivers/infiniband/hw/cxgb4/qp.o: in function `.devm_thermal_of_cooling=
_device_register':
(.text+0x1550): multiple definition of `.devm_thermal_of_cooling_device_reg=
ister'; drivers/infiniband/hw/cxgb4/device.o:(.text+0x28c0): first defined =
here
ld: drivers/infiniband/hw/cxgb4/qp.o:(.opd+0x108): multiple definition of `=
devm_thermal_of_cooling_device_register'; drivers/infiniband/hw/cxgb4/devic=
e.o:(.opd+0x198): first defined here
ld: drivers/infiniband/hw/cxgb4/resource.o: in function `.devm_thermal_of_c=
ooling_device_register':
(.text+0x0): multiple definition of `.devm_thermal_of_cooling_device_regist=
er'; drivers/infiniband/hw/cxgb4/device.o:(.text+0x28c0): first defined here
ld: drivers/infiniband/hw/cxgb4/resource.o:(.opd+0x0): multiple definition =
of `devm_thermal_of_cooling_device_register'; drivers/infiniband/hw/cxgb4/d=
evice.o:(.opd+0x198): first defined here
ld: drivers/infiniband/hw/cxgb4/ev.o: in function `.devm_thermal_of_cooling=
_device_register':
(.text+0x0): multiple definition of `.devm_thermal_of_cooling_device_regist=
er'; drivers/infiniband/hw/cxgb4/device.o:(.text+0x28c0): first defined here
ld: drivers/infiniband/hw/cxgb4/ev.o:(.opd+0x18): multiple definition of `d=
evm_thermal_of_cooling_device_register'; drivers/infiniband/hw/cxgb4/device=
.o:(.opd+0x198): first defined here
ld: drivers/infiniband/hw/cxgb4/id_table.o: in function `.devm_thermal_of_c=
ooling_device_register':
(.text+0x0): multiple definition of `.devm_thermal_of_cooling_device_regist=
er'; drivers/infiniband/hw/cxgb4/device.o:(.text+0x28c0): first defined here
ld: drivers/infiniband/hw/cxgb4/id_table.o:(.opd+0x0): multiple definition =
of `devm_thermal_of_cooling_device_register'; drivers/infiniband/hw/cxgb4/d=
evice.o:(.opd+0x198): first defined here
ld: drivers/infiniband/hw/cxgb4/restrack.o: in function `.devm_thermal_of_c=
ooling_device_register':
(.text+0x1590): multiple definition of `.devm_thermal_of_cooling_device_reg=
ister'; drivers/infiniband/hw/cxgb4/device.o:(.text+0x28c0): first defined =
here
ld: drivers/infiniband/hw/cxgb4/restrack.o:(.opd+0xc0): multiple definition=
 of `devm_thermal_of_cooling_device_register'; drivers/infiniband/hw/cxgb4/=
device.o:(.opd+0x198): first defined here
ld: drivers/net/ethernet/chelsio/cxgb4/l2t.o: in function `.devm_thermal_of=
_cooling_device_register':
(.text+0x1220): multiple definition of `.devm_thermal_of_cooling_device_reg=
ister'; drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.o:(.text+0x79a0): fir=
st defined here
ld: drivers/net/ethernet/chelsio/cxgb4/l2t.o:(.opd+0x120): multiple definit=
ion of `devm_thermal_of_cooling_device_register'; drivers/net/ethernet/chel=
sio/cxgb4/cxgb4_main.o:(.opd+0x708): first defined here
ld: drivers/net/ethernet/chelsio/cxgb4/smt.o: in function `.devm_thermal_of=
_cooling_device_register':
(.text+0x4d0): multiple definition of `.devm_thermal_of_cooling_device_regi=
ster'; drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.o:(.text+0x79a0): firs=
t defined here
ld: drivers/net/ethernet/chelsio/cxgb4/smt.o:(.opd+0x30): multiple definiti=
on of `devm_thermal_of_cooling_device_register'; drivers/net/ethernet/chels=
io/cxgb4/cxgb4_main.o:(.opd+0x708): first defined here
ld: drivers/net/ethernet/chelsio/cxgb4/t4_hw.o: in function `.devm_thermal_=
of_cooling_device_register':
(.text+0x21f0): multiple definition of `.devm_thermal_of_cooling_device_reg=
ister'; drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.o:(.text+0x79a0): fir=
st defined here
ld: drivers/net/ethernet/chelsio/cxgb4/t4_hw.o:(.opd+0x198): multiple defin=
ition of `devm_thermal_of_cooling_device_register'; drivers/net/ethernet/ch=
elsio/cxgb4/cxgb4_main.o:(.opd+0x708): first defined here
ld: drivers/net/ethernet/chelsio/cxgb4/sge.o: in function `.devm_thermal_of=
_cooling_device_register':
(.text+0x3a60): multiple definition of `.devm_thermal_of_cooling_device_reg=
ister'; drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.o:(.text+0x79a0): fir=
st defined here
ld: drivers/net/ethernet/chelsio/cxgb4/sge.o:(.opd+0x270): multiple definit=
ion of `devm_thermal_of_cooling_device_register'; drivers/net/ethernet/chel=
sio/cxgb4/cxgb4_main.o:(.opd+0x708): first defined here
ld: drivers/net/ethernet/chelsio/cxgb4/clip_tbl.o: in function `.devm_therm=
al_of_cooling_device_register':
(.text+0x990): multiple definition of `.devm_thermal_of_cooling_device_regi=
ster'; drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.o:(.text+0x79a0): firs=
t defined here
ld: drivers/net/ethernet/chelsio/cxgb4/clip_tbl.o:(.opd+0x90): multiple def=
inition of `devm_thermal_of_cooling_device_register'; drivers/net/ethernet/=
chelsio/cxgb4/cxgb4_main.o:(.opd+0x708): first defined here
ld: drivers/net/ethernet/chelsio/cxgb4/cxgb4_ethtool.o: in function `.devm_=
thermal_of_cooling_device_register':
(.text+0x2f80): multiple definition of `.devm_thermal_of_cooling_device_reg=
ister'; drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.o:(.text+0x79a0): fir=
st defined here
ld: drivers/net/ethernet/chelsio/cxgb4/cxgb4_ethtool.o:(.opd+0x390): multip=
le definition of `devm_thermal_of_cooling_device_register'; drivers/net/eth=
ernet/chelsio/cxgb4/cxgb4_main.o:(.opd+0x708): first defined here
ld: drivers/net/ethernet/chelsio/cxgb4/cxgb4_uld.o: in function `.devm_ther=
mal_of_cooling_device_register':
(.text+0x1f60): multiple definition of `.devm_thermal_of_cooling_device_reg=
ister'; drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.o:(.text+0x79a0): fir=
st defined here
ld: drivers/net/ethernet/chelsio/cxgb4/cxgb4_uld.o:(.opd+0x138): multiple d=
efinition of `devm_thermal_of_cooling_device_register'; drivers/net/etherne=
t/chelsio/cxgb4/cxgb4_main.o:(.opd+0x708): first defined here
ld: drivers/net/ethernet/chelsio/cxgb4/srq.o: in function `.devm_thermal_of=
_cooling_device_register':
(.text+0x1b0): multiple definition of `.devm_thermal_of_cooling_device_regi=
ster'; drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.o:(.text+0x79a0): firs=
t defined here
ld: drivers/net/ethernet/chelsio/cxgb4/srq.o:(.opd+0x18): multiple definiti=
on of `devm_thermal_of_cooling_device_register'; drivers/net/ethernet/chels=
io/cxgb4/cxgb4_main.o:(.opd+0x708): first defined here
ld: drivers/net/ethernet/chelsio/cxgb4/sched.o: in function `.devm_thermal_=
of_cooling_device_register':
(.text+0x250): multiple definition of `.devm_thermal_of_cooling_device_regi=
ster'; drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.o:(.text+0x79a0): firs=
t defined here
ld: drivers/net/ethernet/chelsio/cxgb4/sched.o:(.opd+0x18): multiple defini=
tion of `devm_thermal_of_cooling_device_register'; drivers/net/ethernet/che=
lsio/cxgb4/cxgb4_main.o:(.opd+0x708): first defined here
ld: drivers/net/ethernet/chelsio/cxgb4/cxgb4_filter.o: in function `.devm_t=
hermal_of_cooling_device_register':
(.text+0xf10): multiple definition of `.devm_thermal_of_cooling_device_regi=
ster'; drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.o:(.text+0x79a0): firs=
t defined here
ld: drivers/net/ethernet/chelsio/cxgb4/cxgb4_filter.o:(.opd+0xc0): multiple=
 definition of `devm_thermal_of_cooling_device_register'; drivers/net/ether=
net/chelsio/cxgb4/cxgb4_main.o:(.opd+0x708): first defined here
ld: drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_u32.o: in function `.devm_t=
hermal_of_cooling_device_register':
(.text+0x430): multiple definition of `.devm_thermal_of_cooling_device_regi=
ster'; drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.o:(.text+0x79a0): firs=
t defined here
ld: drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_u32.o:(.opd+0x198): multipl=
e definition of `devm_thermal_of_cooling_device_register'; drivers/net/ethe=
rnet/chelsio/cxgb4/cxgb4_main.o:(.opd+0x708): first defined here
ld: drivers/net/ethernet/chelsio/cxgb4/cxgb4_ptp.o: in function `.devm_ther=
mal_of_cooling_device_register':
(.text+0x570): multiple definition of `.devm_thermal_of_cooling_device_regi=
ster'; drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.o:(.text+0x79a0): firs=
t defined here
ld: drivers/net/ethernet/chelsio/cxgb4/cxgb4_ptp.o:(.opd+0x78): multiple de=
finition of `devm_thermal_of_cooling_device_register'; drivers/net/ethernet=
/chelsio/cxgb4/cxgb4_main.o:(.opd+0x708): first defined here
ld: drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_flower.o: in function `.dev=
m_thermal_of_cooling_device_register':
(.text+0x9a0): multiple definition of `.devm_thermal_of_cooling_device_regi=
ster'; drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.o:(.text+0x79a0): firs=
t defined here
ld: drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_flower.o:(.opd+0x78): multi=
ple definition of `devm_thermal_of_cooling_device_register'; drivers/net/et=
hernet/chelsio/cxgb4/cxgb4_main.o:(.opd+0x708): first defined here
ld: drivers/net/ethernet/chelsio/cxgb4/cxgb4_cudbg.o: in function `.devm_th=
ermal_of_cooling_device_register':
(.text+0xb00): multiple definition of `.devm_thermal_of_cooling_device_regi=
ster'; drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.o:(.text+0x79a0): firs=
t defined here
ld: drivers/net/ethernet/chelsio/cxgb4/cxgb4_cudbg.o:(.opd+0x30): multiple =
definition of `devm_thermal_of_cooling_device_register'; drivers/net/ethern=
et/chelsio/cxgb4/cxgb4_main.o:(.opd+0x708): first defined here
ld: drivers/net/ethernet/chelsio/cxgb4/cudbg_common.o: in function `.devm_t=
hermal_of_cooling_device_register':
(.text+0x0): multiple definition of `.devm_thermal_of_cooling_device_regist=
er'; drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.o:(.text+0x79a0): first =
defined here
ld: drivers/net/ethernet/chelsio/cxgb4/cudbg_common.o:(.opd+0x0): multiple =
definition of `devm_thermal_of_cooling_device_register'; drivers/net/ethern=
et/chelsio/cxgb4/cxgb4_main.o:(.opd+0x708): first defined here
ld: drivers/net/ethernet/chelsio/cxgb4/cudbg_lib.o: in function `.devm_ther=
mal_of_cooling_device_register':
(.text+0x1ae0): multiple definition of `.devm_thermal_of_cooling_device_reg=
ister'; drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.o:(.text+0x79a0): fir=
st defined here
ld: drivers/net/ethernet/chelsio/cxgb4/cudbg_lib.o:(.opd+0xd8): multiple de=
finition of `devm_thermal_of_cooling_device_register'; drivers/net/ethernet=
/chelsio/cxgb4/cxgb4_main.o:(.opd+0x708): first defined here
ld: drivers/net/ethernet/chelsio/cxgb4/cudbg_zlib.o: in function `.devm_the=
rmal_of_cooling_device_register':
(.text+0x0): multiple definition of `.devm_thermal_of_cooling_device_regist=
er'; drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.o:(.text+0x79a0): first =
defined here
ld: drivers/net/ethernet/chelsio/cxgb4/cudbg_zlib.o:(.opd+0x0): multiple de=
finition of `devm_thermal_of_cooling_device_register'; drivers/net/ethernet=
/chelsio/cxgb4/cxgb4_main.o:(.opd+0x708): first defined here
ld: drivers/net/ethernet/chelsio/cxgb4/cxgb4_debugfs.o: in function `.devm_=
thermal_of_cooling_device_register':
(.text+0xed00): multiple definition of `.devm_thermal_of_cooling_device_reg=
ister'; drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.o:(.text+0x79a0): fir=
st defined here
ld: drivers/net/ethernet/chelsio/cxgb4/cxgb4_debugfs.o:(.opd+0x8d0): multip=
le definition of `devm_thermal_of_cooling_device_register'; drivers/net/eth=
ernet/chelsio/cxgb4/cxgb4_main.o:(.opd+0x708): first defined here

Caused by commit

  4e211e068ae9 ("thermal: Introduce devm_thermal_of_cooling_device_register=
")

I applied the following patch for today:

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Mon, 13 May 2019 10:55:00 +1000
Subject: [PATCH] thermal: use "static inline" for stub function

Fixes: 4e211e068ae9 ("thermal: Introduce devm_thermal_of_cooling_device_reg=
ister")
Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 include/linux/thermal.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 6f78fa9238da..15a4ca5d7099 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -508,7 +508,7 @@ static inline struct thermal_cooling_device *
 thermal_of_cooling_device_register(struct device_node *np,
 	char *type, void *devdata, const struct thermal_cooling_device_ops *ops)
 { return ERR_PTR(-ENODEV); }
-struct thermal_cooling_device *
+static inline struct thermal_cooling_device *
 devm_thermal_of_cooling_device_register(struct device *dev,
 				struct device_node *np,
 				char *type, void *devdata,
--=20
2.20.1

--=20
Cheers,
Stephen Rothwell

--Sig_/m_dtFm01sMQ2bfcj.Jz6mZj
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlzYwjQACgkQAVBC80lX
0GwbNQf8C3pVhWdy1/uW5jDFt8LDTHvxYZpLLPBs3r6LgAnSdLkoenxUA/FYr1s3
lB0MuDt8QbsEXWUF2BTr2BBMXkBQBmBQw01cOER1LOSq4s3fQYNxB1jXkMgTekIs
aIrq8V1iNVggjfmqD5Gm336ocVj+LqrHTXlU3NEVvlCy7mwn7Z3yHXhu7qVTRD1j
/FD5HwQUVum/Jd0tQGR9sjbvoBzVcoOvVHKDJBotSzfzAluBeDUx9Oy0TtXroELF
ibnCbbvvdgDH81G5leFNxHb0p3mVYfUKgnz42Ov8S4tMqd5mqqvk+UhrA1UtReEJ
Zu4/xjMBGpO88+qNAu2YUggUO82Lhw==
=DdEk
-----END PGP SIGNATURE-----

--Sig_/m_dtFm01sMQ2bfcj.Jz6mZj--
