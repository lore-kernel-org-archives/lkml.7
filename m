Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89F9AC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 18:23:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EE8220896
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 18:23:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Hs3GPYML"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732510AbfCZSXh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 14:23:37 -0400
Received: from mout.gmx.net ([212.227.17.20]:49709 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731531AbfCZSXe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 14:23:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1553624601;
        bh=cziDXRLYbTTSnQxzKs9LbCTKltOWXhpJdvZvkNJOfCw=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Hs3GPYMLz+u4az0oHIO9ydi4eTkfroDuE/wq0esVvEp3Tm9Sb9vASXwLrBSOfIB7E
         1ercLA98PiRZHgNHfNF79PzwjTug3JmYUQLu4V71a4BQNHepwYeGoajNX+gzEjVUmy
         p2r7+4B3B/Hu/cb496YbOaqNInK8mlPORZNipPpc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([109.90.232.48]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MYwQh-1hUUDj3uJH-00VdqV; Tue, 26
 Mar 2019 19:23:21 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-clk@vger.kernel.org
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Lucas Stach <l.stach@pengutronix.de>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Aisheng Dong <aisheng.dong@nxp.com>
Subject: [PATCH v2 1/2] clk: imx5: Fix i.MX50 mainbus clock registers
Date:   Tue, 26 Mar 2019 19:22:57 +0100
Message-Id: <20190326182258.21945-2-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190326182258.21945-1-j.neuschaefer@gmx.net>
References: <20190326182258.21945-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8gaCm0iUeJvgJXIqxMW2Iez3IF+HrF7aeGnhsSZnJC3aKB1Vuhy
 /t5DXb1hNnaIAkabFx/jffI/h79dPxUe4t6y7toLGrxI0i4hgsCvAcp47wAjEqe8esSlBO5
 zPzTwOyZ1NafsYAf8tr8Nvlazhjq2JAlbGlthgyRwi032xACOjX/AokbwQlMjFr0yLxvyaX
 TdzTF4fJmVY6iDRQ1aXFw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:lAGShuKM7Ww=:V9e8zrj32yUKCt2JftmzZ+
 e7mSpLcD8Y1EvF/1OqXPAMT0atyZDRV8a/QNIeC9uJx4EwDjr5wX9YsW+gkD+TE8zNX8jYOzW
 NN1x9x/5no5nIbjfoIrGhbYoLr7I/1Ee40fXJtSPKhkIYZeM8od/7EiPJ72gLl1v3pkXJsfYh
 74sZpcKSxnJvWVST4ur2vjuI/Q96hNx1gRKqNjHwNYJWBk0MqmRUCRsIFU9FxKvyaoQDdOKJN
 ywa/BqNzMKS1zgqpG8P93klEnNOJvu923Jl8eSCRYadfkTi9HQiHtFQUR6ttqxPCFv04Jj9mM
 kJyvMsyOb2Ux5xRA/xsbb3dEGSB42fNSXwDZ9YT4V7K43aPEHy5Twgcs3g3nbsuuHy0OQ0/U+
 vP/481v8eghXEVwatHTZHD4siYyDiUFDltJfi3DM6CpLfZftiY9FuE+OSxzO+ypJKrQvI0CAi
 zKdJIwmxQO9T6H8aGJjg0mANtkB1lWrYxtVFzvi/jH+smklgPfpLPVUn6nQexTpP6SH1FOakW
 7X62LyV6t+v0HPenBavj+1kVFNJ9dbnbX46+tnB+U2kN6vdZAwzZ+W93hrb4gz1VNIcjV8IIO
 rUaqNZIcUF4Acd3H3qTPDjR+Nk6RxYDI5WdZOVXjc5xQhVsj6+TjAf/BNB5+7179psgB74ETe
 Ju6DaN3tuglt80FRL9liManengKKO0OpxJeol+NrcZNlqlQyK5Wm8MIZbzbqng9g5kH4Pk727
 yo19FW03X2iwWiaNWp2v0Q1PyBfBwJeWcqYj+ZutN0BnosW0QVhm2V6D25JAcwR5LHefp/a76
 K0XNmUr1NP+J/btPairDl9c4JZlPSuXYSakfHWnrMrzmhMHe2ccjRPQFIMz/pwLPR5iLO+heX
 HPJOqEof61pRNsywGJDEotsX2LxlzH5aFawxAa97J+kuCnqJM/Ntp1bZWEQA/UJwHtlRcNNBl
 ZzkfIfVwgLg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i.MX50 does not have a periph_apm clock. Instead, the main bus clock
(a.k.a. periph_clk) comes directly from a MUX between pll1_sw, pll2_sw,
pll3_sw, and lp_apm.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
v2:
- Split into two patches, as suggested by Aisheng Dong

v1:
https://lore.kernel.org/lkml/20190318231737.8459-1-j.neuschaefer@gmx.net/

 drivers/clk/imx/clk-imx51-imx53.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/imx/clk-imx51-imx53.c b/drivers/clk/imx/clk-imx51=
-imx53.c
index e91c826bce70..3c188aa37cd7 100644
=2D-- a/drivers/clk/imx/clk-imx51-imx53.c
+++ b/drivers/clk/imx/clk-imx51-imx53.c
@@ -164,10 +164,6 @@ static void __init mx5_clocks_common_init(void __iome=
m *ccm_base)
 	clk[IMX5_CLK_CKIH1]		=3D imx_obtain_fixed_clock("ckih1", 0);
 	clk[IMX5_CLK_CKIH2]		=3D imx_obtain_fixed_clock("ckih2", 0);

-	clk[IMX5_CLK_PERIPH_APM]	=3D imx_clk_mux("periph_apm", MXC_CCM_CBCMR, 12=
, 2,
-						periph_apm_sel, ARRAY_SIZE(periph_apm_sel));
-	clk[IMX5_CLK_MAIN_BUS]		=3D imx_clk_mux("main_bus", MXC_CCM_CBCDR, 25, 1=
,
-						main_bus_sel, ARRAY_SIZE(main_bus_sel));
 	clk[IMX5_CLK_PER_LP_APM]	=3D imx_clk_mux("per_lp_apm", MXC_CCM_CBCMR, 1,=
 1,
 						per_lp_apm_sel, ARRAY_SIZE(per_lp_apm_sel));
 	clk[IMX5_CLK_PER_PRED1]		=3D imx_clk_divider("per_pred1", "per_lp_apm", =
MXC_CCM_CBCDR, 6, 2);
@@ -342,6 +338,13 @@ static void __init mx50_clocks_init(struct device_nod=
e *np)

 	mx5_clocks_common_init(ccm_base);

+	/*
+	 * This clock is called periph_clk in the i.MX50 Reference Manual, but
+	 * it comes closest in scope to the main_bus_clk of i.MX51 and i.MX53
+	 */
+	clk[IMX5_CLK_MAIN_BUS]          =3D imx_clk_mux("main_bus", MXC_CCM_CBCD=
R, 25, 2,
+						standard_pll_sel, ARRAY_SIZE(standard_pll_sel));
+
 	clk[IMX5_CLK_LP_APM]		=3D imx_clk_mux("lp_apm", MXC_CCM_CCSR, 10, 1,
 						lp_apm_sel, ARRAY_SIZE(lp_apm_sel));
 	clk[IMX5_CLK_ESDHC1_PER_GATE]	=3D imx_clk_gate2("esdhc1_per_gate", "esdh=
c_a_podf", MXC_CCM_CCGR3, 2);
@@ -410,6 +413,10 @@ static void __init mx51_clocks_init(struct device_nod=
e *np)

 	mx5_clocks_common_init(ccm_base);

+	clk[IMX5_CLK_PERIPH_APM]	=3D imx_clk_mux("periph_apm", MXC_CCM_CBCMR, 12=
, 2,
+						periph_apm_sel, ARRAY_SIZE(periph_apm_sel));
+	clk[IMX5_CLK_MAIN_BUS]		=3D imx_clk_mux("main_bus", MXC_CCM_CBCDR, 25, 1=
,
+						main_bus_sel, ARRAY_SIZE(main_bus_sel));
 	clk[IMX5_CLK_LP_APM]		=3D imx_clk_mux("lp_apm", MXC_CCM_CCSR, 9, 1,
 						lp_apm_sel, ARRAY_SIZE(lp_apm_sel));
 	clk[IMX5_CLK_IPU_DI0_SEL]	=3D imx_clk_mux_flags("ipu_di0_sel", MXC_CCM_C=
SCMR2, 26, 3,
@@ -506,6 +513,10 @@ static void __init mx53_clocks_init(struct device_nod=
e *np)

 	mx5_clocks_common_init(ccm_base);

+	clk[IMX5_CLK_PERIPH_APM]	=3D imx_clk_mux("periph_apm", MXC_CCM_CBCMR, 12=
, 2,
+						periph_apm_sel, ARRAY_SIZE(periph_apm_sel));
+	clk[IMX5_CLK_MAIN_BUS]		=3D imx_clk_mux("main_bus", MXC_CCM_CBCDR, 25, 1=
,
+						main_bus_sel, ARRAY_SIZE(main_bus_sel));
 	clk[IMX5_CLK_LP_APM]		=3D imx_clk_mux("lp_apm", MXC_CCM_CCSR, 10, 1,
 						lp_apm_sel, ARRAY_SIZE(lp_apm_sel));
 	clk[IMX5_CLK_LDB_DI1_DIV_3_5]	=3D imx_clk_fixed_factor("ldb_di1_div_3_5"=
, "ldb_di1_sel", 2, 7);
=2D-
2.20.1

