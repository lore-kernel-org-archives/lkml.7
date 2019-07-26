Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF4E0C7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 18:41:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DEF120838
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 18:41:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388050AbfGZSlK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 14:41:10 -0400
Received: from mailoutvs11.siol.net ([185.57.226.202]:54841 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387995AbfGZSlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 14:41:06 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id 05C45523030;
        Fri, 26 Jul 2019 20:41:04 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta10.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta10.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 0tGEoaOW68jl; Fri, 26 Jul 2019 20:41:03 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id B4E8752303E;
        Fri, 26 Jul 2019 20:41:03 +0200 (CEST)
Received: from localhost.localdomain (cpe-194-152-11-237.cable.triera.net [194.152.11.237])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPSA id 69BE452303B;
        Fri, 26 Jul 2019 20:41:01 +0200 (CEST)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     thierry.reding@gmail.com, mripard@kernel.org, wens@csie.org
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: [PATCH 4/6] pwm: sun4i: Add support for H6 PWM
Date:   Fri, 26 Jul 2019 20:40:43 +0200
Message-Id: <20190726184045.14669-5-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190726184045.14669-1-jernej.skrabec@siol.net>
References: <20190726184045.14669-1-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that sun4i PWM driver supports deasserting reset line and enabling
bus clock, support for H6 PWM can be added.

Note that while H6 PWM has two channels, only first one is wired to
output pin. Second channel is used as a clock source to companion AC200
chip which is bundled into same package.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/pwm/pwm-sun4i.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
index 7d3ac3f2dc3f..9e0eca79ff88 100644
--- a/drivers/pwm/pwm-sun4i.c
+++ b/drivers/pwm/pwm-sun4i.c
@@ -331,6 +331,13 @@ static const struct sun4i_pwm_data sun4i_pwm_single_=
bypass =3D {
 	.npwm =3D 1,
 };
=20
+static const struct sun4i_pwm_data sun50i_pwm_dual_bypass_clk_rst =3D {
+	.has_bus_clock =3D true,
+	.has_prescaler_bypass =3D true,
+	.has_reset =3D true,
+	.npwm =3D 2,
+};
+
 static const struct of_device_id sun4i_pwm_dt_ids[] =3D {
 	{
 		.compatible =3D "allwinner,sun4i-a10-pwm",
@@ -347,6 +354,9 @@ static const struct of_device_id sun4i_pwm_dt_ids[] =3D=
 {
 	}, {
 		.compatible =3D "allwinner,sun8i-h3-pwm",
 		.data =3D &sun4i_pwm_single_bypass,
+	}, {
+		.compatible =3D "allwinner,sun50i-h6-pwm",
+		.data =3D &sun50i_pwm_dual_bypass_clk_rst,
 	}, {
 		/* sentinel */
 	},
--=20
2.22.0

