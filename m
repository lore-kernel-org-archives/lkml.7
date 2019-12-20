Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A60BC2D0C0
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 06:53:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D029624682
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 06:53:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727241AbfLTGx2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 01:53:28 -0500
Received: from [167.172.186.51] ([167.172.186.51]:59228 "EHLO shell.v3.sk"
        rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727110AbfLTGxY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 01:53:24 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 31452DFCA5;
        Fri, 20 Dec 2019 06:53:25 +0000 (UTC)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id tBGc8MQ6OD2E; Fri, 20 Dec 2019 06:53:21 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id AA2A7DFC8A;
        Fri, 20 Dec 2019 06:53:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id IPJ8qCcemK7I; Fri, 20 Dec 2019 06:53:21 +0000 (UTC)
Received: from furthur.lan (unknown [109.183.109.54])
        by zimbra.v3.sk (Postfix) with ESMTPSA id ED3F2DFC82;
        Fri, 20 Dec 2019 06:53:20 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Olof Johansson <olof@lixom.net>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        soc@kernel.org, Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH 2/5] clk: mmp2: Add HSIC clocks
Date:   Fri, 20 Dec 2019 07:53:11 +0100
Message-Id: <20191220065314.237624-3-lkundrak@v3.sk>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191220065314.237624-1-lkundrak@v3.sk>
References: <20191220065314.237624-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are two USB HSIC controllers on MMP2 and MMP3.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 drivers/clk/mmp/clk-of-mmp2.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/clk/mmp/clk-of-mmp2.c b/drivers/clk/mmp/clk-of-mmp2.=
c
index a60a1be937ad6..05834953e1fd3 100644
--- a/drivers/clk/mmp/clk-of-mmp2.c
+++ b/drivers/clk/mmp/clk-of-mmp2.c
@@ -53,6 +53,8 @@
 #define APMU_DISP1	0x110
 #define APMU_CCIC0	0x50
 #define APMU_CCIC1	0xf4
+#define APMU_USBHSIC0	0xf8
+#define APMU_USBHSIC1	0xfc
 #define MPMU_UART_PLL	0x14
=20
 struct mmp2_clk_unit {
@@ -194,6 +196,8 @@ static struct mmp_clk_mix_config sdh_mix_config =3D {
 };
=20
 static DEFINE_SPINLOCK(usb_lock);
+static DEFINE_SPINLOCK(usbhsic0_lock);
+static DEFINE_SPINLOCK(usbhsic1_lock);
=20
 static DEFINE_SPINLOCK(disp0_lock);
 static DEFINE_SPINLOCK(disp1_lock);
@@ -224,6 +228,8 @@ static struct mmp_param_div_clk apmu_div_clks[] =3D {
=20
 static struct mmp_param_gate_clk apmu_gate_clks[] =3D {
 	{MMP2_CLK_USB, "usb_clk", "usb_pll", 0, APMU_USB, 0x9, 0x9, 0x0, 0, &us=
b_lock},
+	{MMP2_CLK_USBHSIC0, "usbhsic0_clk", "usb_pll", 0, APMU_USBHSIC0, 0x1b, =
0x1b, 0x0, 0, &usbhsic0_lock},
+	{MMP2_CLK_USBHSIC1, "usbhsic1_clk", "usb_pll", 0, APMU_USBHSIC1, 0x1b, =
0x1b, 0x0, 0, &usbhsic1_lock},
 	/* The gate clocks has mux parent. */
 	{MMP2_CLK_SDH0, "sdh0_clk", "sdh_mix_clk", CLK_SET_RATE_PARENT, APMU_SD=
H0, 0x1b, 0x1b, 0x0, 0, &sdh_lock},
 	{MMP2_CLK_SDH1, "sdh1_clk", "sdh_mix_clk", CLK_SET_RATE_PARENT, APMU_SD=
H1, 0x1b, 0x1b, 0x0, 0, &sdh_lock},
--=20
2.24.1

