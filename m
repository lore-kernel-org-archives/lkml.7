Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C62ECC4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 16:21:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C369217F4
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 16:21:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="TPbxWUyq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727434AbfIZQVB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 12:21:01 -0400
Received: from mout.web.de ([212.227.15.4]:43943 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726029AbfIZQVA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 12:21:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1569514853;
        bh=04Sl9AFkxlEamQ7lVjfYu9c42klIXZLL0/09R/Udrcw=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=TPbxWUyqEmI+QnEfG+0qz0DggbzI5598NeEsn3ybQY+DotTjSlXg3Vk2RLxTXeJtz
         EiTGpcbPykHO+5+3Kv50idPxlrnhYBmxF+Pi2vuRW+6TFL7DXSp23mPArfO/c+ehLy
         4Yxe7FdN2vdDK52ADDv+IArC/zPkHu8OktacIKeI=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.135.81.241]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MarqU-1iTPji3MfS-00KRFq; Thu, 26
 Sep 2019 18:20:52 +0200
To:     kernel-janitors@vger.kernel.org, Igal Liberman <igall@marvell.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     LKML <linux-kernel@vger.kernel.org>
From:   Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] phy-mvebu-a3700-utmi: Use devm_platform_ioremap_resource() in
 mvebu_a3700_utmi_phy_probe()
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <5403540b-d3de-4a29-ec84-7ce5bb8d6d9f@web.de>
Date:   Thu, 26 Sep 2019 18:20:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:CqcNkQG6uNvKkDGq8fhwra5jxy4wQ0FQnuxYJvBnClhQ2c36hpF
 OUeh8/i4uqHRkN1CA02NEw36S4K6vxvQj+C2F/ptnfIjW2DCtPS4NuGYzHpw9uo+frDPwg6
 FhHqj2Nh7z+XwNJ0N+yK5Jef9R3TXn0TBQcB0/japICNJWD/DzMK+xr43RMc5x1OcivzlGU
 9N4Do87haifiqG7EJVq0Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:B54L7PAx53o=:SLe3UbYYkGMuFVMXWtYr6K
 aTrGprrfP/kKl/Miy0SCK00opS8W0EOEWajEBbLWODbXdBEfc5BO6bboQM8gku0cZAWpNNg22
 sQH7ZDM36xbWngVAGELBAizrDvGamTawX2O5I1QAkDzdYbcfnvT8qw1IKWeRu3LiX9MHR5Cqx
 Pi6ahsYXuJF2YUlc9U3hpaFNgp6TvvxX54IydqxVlPEkGdsr7LnGnjgBPHN75W03quMLhJlGf
 0r+cYbxJ2GJRJsih7rf8bX/cQpNJRX6MxE0xvapt6E44OXSfeKDDbdCTepr6/EWXYTnYrRLgs
 9LPB0DuCwkYsS0tAtx7MlvIyx6a/m+gcaaR0u/fXMlIFgli0xFentKe5oHryoJWtWYBu3xMaE
 LTHJBlrFDF3y7PrwmF/1PSRN33BPiL/gGtuTZAvCzBAcptGnY7El9XlrwLmtgU3gDaljrn3Ru
 msvRqJbT07u/zG5e5k4p99IGEwSb7/iubZzr4xjlADt+DZQ9xlBZ65vA+p3LGNBf5IiQ9C3SR
 cTfXT/3oq9NHxbiR4eXG2kRenSD59wJFg09KeV9NdXCGYDopVRgMXqfDR+yuakashx6XPVBAx
 SQkPXiL+0FnHZoBLXQdAOMsvmDK56hDvzJKZMVIi9abECKdgBHCfMsK08kKwyrZ/KRfqiNOC7
 EjJNsko0vNEkaWuUb2rIkHMf+35emAAlFjWVZwpLOoBpyUdrHUwDUZpBSMKbwoyjXvUtmPsbJ
 +BQWUQy0TOU24MqJpg5zKHF7ovXIVkK80YLTlOaWpGC2jYYM8NTHCqtNq+dxXZ/aEqSQERYru
 PfwktjuRFyVmqYqki9sSCg8AoAUpOxLf7SOnCfp5n6XNT38J2zvMA+s+9uf67DdinyIutulTc
 EIB0Y2fDK6fYhyZc60BJOMhV905q5lPtJON3sTg3UC0CA31zsF9u2y5HQ20Fgu1w973kTyQ+a
 tq63e0EE718GVKflpsgTeU5vkjnPMUNKV5IA05MW8I48K1TXsDrfdptLTtgJZxghRfWdemIys
 4ddHj/TuiiM/J3b54v6celP7X19VyRnPE36YfwO5U7BoJdefQs/DOI1ZBylWesZ1Dbj6YojnA
 3FKbJkf/Hwr0qk8jbn6uOZ6gwR/PCkVr9U/qOevxaYmjw9JkJGbxv9u5ImMQO7sxNd6ClCw6C
 YSug+3z36Mqd0S2OLxO8MGgGBla4IDEAR3QImQKbm5GjlDAlMeoflqU3UeUAoG7+CMjJdYuu+
 RRTLCzHjGjah9pADK2eXcbICmwSKxs24s0CyKD1aQp9xCrSlwGb1jM0tRG8Q=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 26 Sep 2019 18:15:23 +0200

Simplify this function implementation by using a known wrapper function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/phy/marvell/phy-mvebu-a3700-utmi.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/phy/marvell/phy-mvebu-a3700-utmi.c b/drivers/phy/marv=
ell/phy-mvebu-a3700-utmi.c
index ded900b06f5a..23bc3bf5c4c0 100644
=2D-- a/drivers/phy/marvell/phy-mvebu-a3700-utmi.c
+++ b/drivers/phy/marvell/phy-mvebu-a3700-utmi.c
@@ -216,20 +216,13 @@ static int mvebu_a3700_utmi_phy_probe(struct platfor=
m_device *pdev)
 	struct device *dev =3D &pdev->dev;
 	struct mvebu_a3700_utmi *utmi;
 	struct phy_provider *provider;
-	struct resource *res;

 	utmi =3D devm_kzalloc(dev, sizeof(*utmi), GFP_KERNEL);
 	if (!utmi)
 		return -ENOMEM;

 	/* Get UTMI memory region */
-	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res) {
-		dev_err(dev, "Missing UTMI PHY memory resource\n");
-		return -ENODEV;
-	}
-
-	utmi->regs =3D devm_ioremap_resource(dev, res);
+	utmi->regs =3D devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(utmi->regs))
 		return PTR_ERR(utmi->regs);

=2D-
2.23.0

