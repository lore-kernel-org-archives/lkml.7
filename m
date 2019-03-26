Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41194C4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 18:23:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03B4B2084B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 18:23:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="iE4ICotU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732537AbfCZSXm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 14:23:42 -0400
Received: from mout.gmx.net ([212.227.15.18]:47061 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731531AbfCZSXk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 14:23:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1553624604;
        bh=HU96eXhK5KbTymKNaAh+dmLrxXkha17vvULgbKpL0Cs=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=iE4ICotUIylPV8U/mrvLMirHNN7fffetrxvTajvo4SH3Iu93cnD1derYrRKZ5Y9r5
         dIsW03mojj1M4esFpf2h8NBh4dmEsuJomB9xGfv3dO9e855AmjFsLd8DduGSDoUmQ0
         IBgBEFdshVJomexPEMocdiMzp/nxSuPWKBwtNmQo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([109.90.232.48]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LzcIM-1gv9P422b4-014osi; Tue, 26
 Mar 2019 19:23:24 +0100
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
Subject: [PATCH v2 2/2] clk: imx5: Fix i.MX50 ESDHC clock registers
Date:   Tue, 26 Mar 2019 19:22:58 +0100
Message-Id: <20190326182258.21945-3-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190326182258.21945-1-j.neuschaefer@gmx.net>
References: <20190326182258.21945-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jwLXZMpo8BdC/AT/9cyth6U7aau0byCCrz1HFeoEQCXkfhnu6sm
 Rzl2xuDI9PzlUJzk8uMRAJfWpwfXdwg7E+qzUVc98FOQKPfov7YWNO7gVbScoylpvlbcZ2d
 XxuKnb6Fw5QmNe8XlBq+7kTOXgDbLVaUVg8fprHmHzZDc0m3pT1F/Dc3snNg+6wRibJAS+Y
 DAkTQLz+711pFlW/6mByw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:y0Q0bttFAK8=:+tVAqr2NCWMQuaU5pOO3E7
 LxVtEQXUJDEOkkh0Hi2ey+vuuuNAOAsMxd8xaMLL0Ph23HjTWTLJZAqPHAH0ACAQ8DmlTN66t
 Q9gRKqRE2LgIUhiyuofrNGFGzFXgP9WwLXgBjRokGUrSTR9hF4u7SPrNNGD42xSKhbDcy/5DR
 K3mllSMjXplIbvs41HNAr/5H3AJYQvLnbdqtuQoeiYZJ40y2F14iYTONSajNJpq3TbAed1G3N
 fwiQuQKZ8s83D4jrYT5rSkiiAT79hwa8a5PyBwfwUVYtLhwPCiqz0B/+cJ/VWWVRuuKPqBTQ7
 xuZs98SEiu3MzEy5rsfv855e+1T6ZFzWyv7QZQgmn3K9zGgg2NdCrvqAsDtfZaisq+6EstVtx
 CQZxfunaePaO8oQQqMRsz2YOOGRRkqxrXtFpQGJ4Nd9Mcn6Hs2bRdHhgBopv1CnFRegwW2Fje
 BeYdmikJQgV6Zr6qvI8JSFDKvh5fhE3uVy+Z1mOGVzKaGV5FvQVnwMI39/OmTigokhmQt6v3Q
 qDZOhehkEBmSGNFGRf2PJQD9iiM/d3dZy7aGN7k/4gEC/l8DqWPQVRP9gsRXG+D8D0UsOdlyK
 zw2sMDbGWRUxOhfoyKGxaxVbJInQylu829VSnpeFZVPPAnFnO2/aq7eQZE9trdwdeJ5jcs5uf
 NEIJCPlxcKqqFDaSbcdpvaxg37xq763ZzXb/mUwpQF/bt5IM1y7NIzSGSqgwiYHc0+tq2oqxH
 /k3m1oS/UoC64Fujp1Q8eboliIaxqjPPViA+CHijvF3tDgvBkKF8UiDAC9ypGN4jEBDivnV+N
 KmiYtI82AVYXXgjoyYhBZdsh+7WFZKS/SshZw+PsRiQAPJczSA6AL2/36uyMLNJNhwMWeDF5p
 k0B3kVbig54gspZ2uQDyZ2JVVsoQ51EiGwQBnRRvXrF3e4A3Zrujx4jIH6PDu98yGc/mgh3MN
 g2ytNA+eC/A==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MUX bits for esdhc_{a,c,d}_sel are shifted by one bit within CSCMR1,
because esdhc_b_sel (ESDHC3_CLK_SEL in the Reference Manual) is extended
by one bit.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
v2:
- Split into two patches, as suggested by Aisheng Dong
- Extended the commit message slightly

v1:
https://lore.kernel.org/lkml/20190318231737.8459-1-j.neuschaefer@gmx.net/
=2D--
 drivers/clk/imx/clk-imx51-imx53.c | 40 +++++++++++++++++++++++--------
 1 file changed, 30 insertions(+), 10 deletions(-)

diff --git a/drivers/clk/imx/clk-imx51-imx53.c b/drivers/clk/imx/clk-imx51=
-imx53.c
index 3c188aa37cd7..c85ebd74a8a5 100644
=2D-- a/drivers/clk/imx/clk-imx51-imx53.c
+++ b/drivers/clk/imx/clk-imx51-imx53.c
@@ -187,16 +187,10 @@ static void __init mx5_clocks_common_init(void __iom=
em *ccm_base)
 	clk[IMX5_CLK_UART_PRED]		=3D imx_clk_divider("uart_pred", "uart_sel", MX=
C_CCM_CSCDR1, 3, 3);
 	clk[IMX5_CLK_UART_ROOT]		=3D imx_clk_divider("uart_root", "uart_pred", M=
XC_CCM_CSCDR1, 0, 3);

-	clk[IMX5_CLK_ESDHC_A_SEL]	=3D imx_clk_mux("esdhc_a_sel", MXC_CCM_CSCMR1,=
 20, 2,
-						standard_pll_sel, ARRAY_SIZE(standard_pll_sel));
-	clk[IMX5_CLK_ESDHC_B_SEL]	=3D imx_clk_mux("esdhc_b_sel", MXC_CCM_CSCMR1,=
 16, 2,
-						standard_pll_sel, ARRAY_SIZE(standard_pll_sel));
 	clk[IMX5_CLK_ESDHC_A_PRED]	=3D imx_clk_divider("esdhc_a_pred", "esdhc_a_=
sel", MXC_CCM_CSCDR1, 16, 3);
 	clk[IMX5_CLK_ESDHC_A_PODF]	=3D imx_clk_divider("esdhc_a_podf", "esdhc_a_=
pred", MXC_CCM_CSCDR1, 11, 3);
 	clk[IMX5_CLK_ESDHC_B_PRED]	=3D imx_clk_divider("esdhc_b_pred", "esdhc_b_=
sel", MXC_CCM_CSCDR1, 22, 3);
 	clk[IMX5_CLK_ESDHC_B_PODF]	=3D imx_clk_divider("esdhc_b_podf", "esdhc_b_=
pred", MXC_CCM_CSCDR1, 19, 3);
-	clk[IMX5_CLK_ESDHC_C_SEL]	=3D imx_clk_mux("esdhc_c_sel", MXC_CCM_CSCMR1,=
 19, 1, esdhc_c_sel, ARRAY_SIZE(esdhc_c_sel));
-	clk[IMX5_CLK_ESDHC_D_SEL]	=3D imx_clk_mux("esdhc_d_sel", MXC_CCM_CSCMR1,=
 18, 1, esdhc_d_sel, ARRAY_SIZE(esdhc_d_sel));

 	clk[IMX5_CLK_EMI_SEL]		=3D imx_clk_mux("emi_sel", MXC_CCM_CBCDR, 26, 1,
 						emi_slow_sel, ARRAY_SIZE(emi_slow_sel));
@@ -307,10 +301,6 @@ static void __init mx5_clocks_common_init(void __iome=
m *ccm_base)
 	clk_register_clkdev(clk[IMX5_CLK_CPU_PODF], NULL, "cpu0");
 	clk_register_clkdev(clk[IMX5_CLK_GPC_DVFS], "gpc_dvfs", NULL);

-	/* Set SDHC parents to be PLL2 */
-	clk_set_parent(clk[IMX5_CLK_ESDHC_A_SEL], clk[IMX5_CLK_PLL2_SW]);
-	clk_set_parent(clk[IMX5_CLK_ESDHC_B_SEL], clk[IMX5_CLK_PLL2_SW]);
-
 	/* move usb phy clk to 24MHz */
 	clk_set_parent(clk[IMX5_CLK_USB_PHY_SEL], clk[IMX5_CLK_OSC]);
 }
@@ -347,6 +337,12 @@ static void __init mx50_clocks_init(struct device_nod=
e *np)

 	clk[IMX5_CLK_LP_APM]		=3D imx_clk_mux("lp_apm", MXC_CCM_CCSR, 10, 1,
 						lp_apm_sel, ARRAY_SIZE(lp_apm_sel));
+	clk[IMX5_CLK_ESDHC_A_SEL]	=3D imx_clk_mux("esdhc_a_sel", MXC_CCM_CSCMR1,=
 21, 2,
+						standard_pll_sel, ARRAY_SIZE(standard_pll_sel));
+	clk[IMX5_CLK_ESDHC_B_SEL]	=3D imx_clk_mux("esdhc_b_sel", MXC_CCM_CSCMR1,=
 16, 2,
+						standard_pll_sel, ARRAY_SIZE(standard_pll_sel));
+	clk[IMX5_CLK_ESDHC_C_SEL]	=3D imx_clk_mux("esdhc_c_sel", MXC_CCM_CSCMR1,=
 20, 1, esdhc_c_sel, ARRAY_SIZE(esdhc_c_sel));
+	clk[IMX5_CLK_ESDHC_D_SEL]	=3D imx_clk_mux("esdhc_d_sel", MXC_CCM_CSCMR1,=
 19, 1, esdhc_d_sel, ARRAY_SIZE(esdhc_d_sel));
 	clk[IMX5_CLK_ESDHC1_PER_GATE]	=3D imx_clk_gate2("esdhc1_per_gate", "esdh=
c_a_podf", MXC_CCM_CCGR3, 2);
 	clk[IMX5_CLK_ESDHC2_PER_GATE]	=3D imx_clk_gate2("esdhc2_per_gate", "esdh=
c_c_sel", MXC_CCM_CCGR3, 6);
 	clk[IMX5_CLK_ESDHC3_PER_GATE]	=3D imx_clk_gate2("esdhc3_per_gate", "esdh=
c_b_podf", MXC_CCM_CCGR3, 10);
@@ -375,6 +371,10 @@ static void __init mx50_clocks_init(struct device_nod=
e *np)
 	clk_data.clk_num =3D ARRAY_SIZE(clk);
 	of_clk_add_provider(np, of_clk_src_onecell_get, &clk_data);

+	/* Set SDHC parents to be PLL2 */
+	clk_set_parent(clk[IMX5_CLK_ESDHC_A_SEL], clk[IMX5_CLK_PLL2_SW]);
+	clk_set_parent(clk[IMX5_CLK_ESDHC_B_SEL], clk[IMX5_CLK_PLL2_SW]);
+
 	/* set SDHC root clock to 200MHZ*/
 	clk_set_rate(clk[IMX5_CLK_ESDHC_A_PODF], 200000000);
 	clk_set_rate(clk[IMX5_CLK_ESDHC_B_PODF], 200000000);
@@ -429,6 +429,12 @@ static void __init mx51_clocks_init(struct device_nod=
e *np)
 						mx51_tve_sel, ARRAY_SIZE(mx51_tve_sel));
 	clk[IMX5_CLK_TVE_GATE]		=3D imx_clk_gate2("tve_gate", "tve_sel", MXC_CCM=
_CCGR2, 30);
 	clk[IMX5_CLK_TVE_PRED]		=3D imx_clk_divider("tve_pred", "pll3_sw", MXC_C=
CM_CDCDR, 28, 3);
+	clk[IMX5_CLK_ESDHC_A_SEL]	=3D imx_clk_mux("esdhc_a_sel", MXC_CCM_CSCMR1,=
 20, 2,
+						standard_pll_sel, ARRAY_SIZE(standard_pll_sel));
+	clk[IMX5_CLK_ESDHC_B_SEL]	=3D imx_clk_mux("esdhc_b_sel", MXC_CCM_CSCMR1,=
 16, 2,
+						standard_pll_sel, ARRAY_SIZE(standard_pll_sel));
+	clk[IMX5_CLK_ESDHC_C_SEL]	=3D imx_clk_mux("esdhc_c_sel", MXC_CCM_CSCMR1,=
 19, 1, esdhc_c_sel, ARRAY_SIZE(esdhc_c_sel));
+	clk[IMX5_CLK_ESDHC_D_SEL]	=3D imx_clk_mux("esdhc_d_sel", MXC_CCM_CSCMR1,=
 18, 1, esdhc_d_sel, ARRAY_SIZE(esdhc_d_sel));
 	clk[IMX5_CLK_ESDHC1_PER_GATE]	=3D imx_clk_gate2("esdhc1_per_gate", "esdh=
c_a_podf", MXC_CCM_CCGR3, 2);
 	clk[IMX5_CLK_ESDHC2_PER_GATE]	=3D imx_clk_gate2("esdhc2_per_gate", "esdh=
c_b_podf", MXC_CCM_CCGR3, 6);
 	clk[IMX5_CLK_ESDHC3_PER_GATE]	=3D imx_clk_gate2("esdhc3_per_gate", "esdh=
c_c_sel", MXC_CCM_CCGR3, 10);
@@ -459,6 +465,10 @@ static void __init mx51_clocks_init(struct device_nod=
e *np)
 	/* set the usboh3 parent to pll2_sw */
 	clk_set_parent(clk[IMX5_CLK_USBOH3_SEL], clk[IMX5_CLK_PLL2_SW]);

+	/* Set SDHC parents to be PLL2 */
+	clk_set_parent(clk[IMX5_CLK_ESDHC_A_SEL], clk[IMX5_CLK_PLL2_SW]);
+	clk_set_parent(clk[IMX5_CLK_ESDHC_B_SEL], clk[IMX5_CLK_PLL2_SW]);
+
 	/* set SDHC root clock to 166.25MHZ*/
 	clk_set_rate(clk[IMX5_CLK_ESDHC_A_PODF], 166250000);
 	clk_set_rate(clk[IMX5_CLK_ESDHC_B_PODF], 166250000);
@@ -538,6 +548,12 @@ static void __init mx53_clocks_init(struct device_nod=
e *np)
 						mx53_tve_ext_sel, ARRAY_SIZE(mx53_tve_ext_sel), CLK_SET_RATE_PARENT=
);
 	clk[IMX5_CLK_TVE_GATE]		=3D imx_clk_gate2("tve_gate", "tve_pred", MXC_CC=
M_CCGR2, 30);
 	clk[IMX5_CLK_TVE_PRED]		=3D imx_clk_divider("tve_pred", "tve_ext_sel", M=
XC_CCM_CDCDR, 28, 3);
+	clk[IMX5_CLK_ESDHC_A_SEL]	=3D imx_clk_mux("esdhc_a_sel", MXC_CCM_CSCMR1,=
 20, 2,
+						standard_pll_sel, ARRAY_SIZE(standard_pll_sel));
+	clk[IMX5_CLK_ESDHC_B_SEL]	=3D imx_clk_mux("esdhc_b_sel", MXC_CCM_CSCMR1,=
 16, 2,
+						standard_pll_sel, ARRAY_SIZE(standard_pll_sel));
+	clk[IMX5_CLK_ESDHC_C_SEL]	=3D imx_clk_mux("esdhc_c_sel", MXC_CCM_CSCMR1,=
 19, 1, esdhc_c_sel, ARRAY_SIZE(esdhc_c_sel));
+	clk[IMX5_CLK_ESDHC_D_SEL]	=3D imx_clk_mux("esdhc_d_sel", MXC_CCM_CSCMR1,=
 18, 1, esdhc_d_sel, ARRAY_SIZE(esdhc_d_sel));
 	clk[IMX5_CLK_ESDHC1_PER_GATE]	=3D imx_clk_gate2("esdhc1_per_gate", "esdh=
c_a_podf", MXC_CCM_CCGR3, 2);
 	clk[IMX5_CLK_ESDHC2_PER_GATE]	=3D imx_clk_gate2("esdhc2_per_gate", "esdh=
c_c_sel", MXC_CCM_CCGR3, 6);
 	clk[IMX5_CLK_ESDHC3_PER_GATE]	=3D imx_clk_gate2("esdhc3_per_gate", "esdh=
c_b_podf", MXC_CCM_CCGR3, 10);
@@ -600,6 +616,10 @@ static void __init mx53_clocks_init(struct device_nod=
e *np)
 	clk_data.clk_num =3D ARRAY_SIZE(clk);
 	of_clk_add_provider(np, of_clk_src_onecell_get, &clk_data);

+	/* Set SDHC parents to be PLL2 */
+	clk_set_parent(clk[IMX5_CLK_ESDHC_A_SEL], clk[IMX5_CLK_PLL2_SW]);
+	clk_set_parent(clk[IMX5_CLK_ESDHC_B_SEL], clk[IMX5_CLK_PLL2_SW]);
+
 	/* set SDHC root clock to 200MHZ*/
 	clk_set_rate(clk[IMX5_CLK_ESDHC_A_PODF], 200000000);
 	clk_set_rate(clk[IMX5_CLK_ESDHC_B_PODF], 200000000);
=2D-
2.20.1

