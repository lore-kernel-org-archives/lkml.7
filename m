Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ABDEC04E30
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 11:58:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 102CF207FF
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 11:58:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="AbJPXu35"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727665AbfLIL6S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 06:58:18 -0500
Received: from mout.web.de ([212.227.15.3]:52581 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727581AbfLIL6R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 06:58:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1575892687;
        bh=62z6uy/6WR5j1vgtqdICXgaRlMrLkDw2kYFQchsQQX4=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=AbJPXu35r/mj1Kl1py0u+c+fdjS9F0ZheA9EJhQwyiJH2LgDHZ4f/HcwViTbZC9Qc
         +sF64Ghtu3UmR0ytixvENnBoJ4pBauTStZpwaY8jxPa6f1iiGD7ziKDZiLLelovYV9
         BrYC9rvv7ESVrtdNUvX+xvcVdImlFEb9+hSg0Vu8=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost.localdomain ([89.204.137.214]) by smtp.web.de
 (mrweb002 [213.165.67.108]) with ESMTPSA (Nemesis) id
 0LZvrx-1htN0k2PHx-00ll33; Mon, 09 Dec 2019 12:58:07 +0100
From:   Soeren Moch <smoch@web.de>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Soeren Moch <smoch@web.de>, Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mfd: rk808: Always use poweroff when requested
Date:   Mon,  9 Dec 2019 12:57:46 +0100
Message-Id: <20191209115746.12953-1-smoch@web.de>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4QjbT4z/xIikNcKmfWLhhH6xzC1/KEdG24B8uNl/vw7p1fNxDaT
 DMCoS7br/0f/uZE6ia5Q4XSuEwZZv85bfTQjwVFJMTARxXoR+4JBODy8zMwegXgrLjQeOfa
 SDNP9AJhPW1AH6h0pbD9uA0+HrN4B+X7em8dTcBHuVO8IAS1EdkFoeyPJuIrepHovm4pBFX
 Y3vxnLkJ5c8RjoOMgFlIg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:vQQoMiCyYJs=:MjRPsmkGhlVryNQvyaXF2Q
 UDQ6nFwdncGTI2yDgUCC5JOngbTHVvXAAonkzM4YIEjTLTU2UFsqg8sgZPuYLjEZcO2hflaDE
 UQDRj0PeoNVt7ZCxRjgjl3EpgX6GJK4GKBaF2X0EaCfAUWdelW88s5b3g0epAWbl5T9ab5KS3
 8wwS9TGEEOwS9RO2zdqUbyaoGXv505aZYA3w3agKQhUGG/Mu2SVe10XXHLoMetthCCmB1M2Gb
 puDV57K8hYkF7gva41AyPc0RYHLNhl+wV0K81ueSxtln3gibAHfoYQY9ubZAbkXVjBs5Lpl7N
 I0TgicHs5h/5sqFpcSgQa1ombO5FP0i5qvwT3LM1tvkAZpSuEgNlJ3CBHSFmQ9fMk8UwmGOQH
 XcI25wUO0Mir4so8WhDRp0GlBJsN/qdcs56/leyEuqTmhXGAxIzpBIShwp2V1rwwdRRuBEp7t
 tGMyvUsuzQgnFFh32/WY8tR4uQFtg/GJBuk7NnjABcInCRAt7o/gFaBtpWKa+qAAycY+fFlJT
 z/bf0/+MUpHRpMGa4WHwoZHI5XTWFMJQBKIGwjmwNHhhd8Ct62LmZTAcRDvf7QtwQFw0UbHFH
 +DR/wydj2pPISHD072lxEOvZ+XlmZAibEWN6uQCIXNzMfRg86ZF9/8jD5KMWPAvv0xySXFJyi
 t4oP9rFpXSrzuQJ4imZPiquaJtiS3zkuouN1gPF06yp7RotUCo/u2dAFhJc7KFtcIJArviRhq
 o+eU93RUXToRDJ8DHtKpg7WuW0CE/p+r2OzU+nww2QOuuJxduh46bdAfMa0C1Pb4Im6hGVPSh
 jIwuyc485gfStufjf6mnTkwErktu/j+uMCIwA9Rleb3mmVDrSbrK0Om+qs/33Q/B0vYuo0Cvj
 QIJOjnsNFai7KiKOZmT+LYpSlRJvBPQ39zKqeuBUxDceDNPXqHsXsVk4inTXJhH/8py8Ec+mY
 fiBZF08raV+TTnYOXL4XIuIar5dCn0HUb2JJCEvlz270DMbbTABebwCTsPyJPZmMtvQAenNCj
 IXbfdyhGMMX7QxoSz9FZk5cUopg5yVG9BVWONEjJYEf7u8LtfF7+HNVgucTDn7DXzL2Y4ETBe
 j3v89GKLUFmaDGtEjbxSG4uvwg7+sCj892qqWgFPDkApSsGBjOzvBFEWbbTHkwuBA5BbFXNAJ
 mLlijWCMKRAm9URSoGpJzYGaiBUcl4p0Ci/5Me9VeXjE8QRjQHvFrlTtKua3HYJB9oHcRUn+4
 PIoyvU3E5HLp30W9H1e+leJtCqxXdnF8SEvBuyg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the device tree property "rockchip,system-power-controller" we
explicitly request to use this PMIC to power off the system. So always
register our poweroff function, even if some other handler (probably
PSCI poweroff) was registered before.

Signed-off-by: Soeren Moch <smoch@web.de>
=2D--
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Heiko Stuebner <heiko@sntech.de>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-rockchip@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
=2D--
 drivers/mfd/rk808.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/mfd/rk808.c b/drivers/mfd/rk808.c
index a69a6742ecdc..616e44e7ef98 100644
=2D-- a/drivers/mfd/rk808.c
+++ b/drivers/mfd/rk808.c
@@ -550,7 +550,7 @@ static int rk808_probe(struct i2c_client *client,
 	const struct mfd_cell *cells;
 	int nr_pre_init_regs;
 	int nr_cells;
-	int pm_off =3D 0, msb, lsb;
+	int msb, lsb;
 	unsigned char pmic_id_msb, pmic_id_lsb;
 	int ret;
 	int i;
@@ -674,16 +674,9 @@ static int rk808_probe(struct i2c_client *client,
 		goto err_irq;
 	}

-	pm_off =3D of_property_read_bool(np,
-				"rockchip,system-power-controller");
-	if (pm_off && !pm_power_off) {
+	if (of_property_read_bool(np, "rockchip,system-power-controller")) {
 		rk808_i2c_client =3D client;
 		pm_power_off =3D rk808->pm_pwroff_fn;
-	}
-
-	if (pm_off && !pm_power_off_prepare) {
-		if (!rk808_i2c_client)
-			rk808_i2c_client =3D client;
 		pm_power_off_prepare =3D rk808->pm_pwroff_prep_fn;
 	}

=2D-
2.17.1

