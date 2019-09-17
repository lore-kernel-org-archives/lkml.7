Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAD91C4CECD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 09:12:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDE8521881
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 09:12:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=aurabindo.in header.i=@aurabindo.in header.b="D7mi3tO9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbfIQJMr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 05:12:47 -0400
Received: from mail1.protonmail.ch ([185.70.40.18]:36145 "EHLO
        mail1.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbfIQJMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 05:12:47 -0400
Date:   Tue, 17 Sep 2019 09:12:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aurabindo.in;
        s=protonmail; t=1568711564;
        bh=ZKYIzKdgRRtrB7OyOmWDzTMGg6uay9ipjlu1WQonyTU=;
        h=Date:To:From:Cc:Reply-To:Subject:Feedback-ID:From;
        b=D7mi3tO9OXOzH1MotQvSz5Xmg1HsCtocmFhGEDC8gaoDjaSgP8ZAH6lI4D5cv9xQR
         z4wJXjvbMhdrV9iw0HdgmUfCQ6saU63wOYPhAX9Wvn2LuRdRu3Qf2eRLfhxRFxlMZd
         1gAju0l8p9aV8sK57miyyI+8NQsuslGsmb7desLU=
To:     broonie@kernel.org, palmer@sifive.com, paul.walmsley@sifive.com
From:   Aurabindo Jayamohanan <mail@aurabindo.in>
Cc:     linux-spi@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Reply-To: Aurabindo Jayamohanan <mail@aurabindo.in>
Subject: [PATCH] spi: sifive: check return value for platform_get_resource()
Message-ID: <20190917085627.4562-1-mail@aurabindo.in>
Feedback-ID: D1Wwva8zb0UdpJtanaReRLGO3iCsewpGmDn8ZDKmpao-Gnxd2qXPmwwrSQ99r5Q15lmK-D8x6vKzqhUKCgzweA==:Ext:ProtonMail
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

platform_get_resource() may return NULL. If it is so, return -ENXIO

Signed-off-by: Aurabindo Jayamohanan <mail@aurabindo.in>
---
 drivers/spi/spi-sifive.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/spi/spi-sifive.c b/drivers/spi/spi-sifive.c
index 93ec2c6cdbfd..67485067a694 100644
--- a/drivers/spi/spi-sifive.c
+++ b/drivers/spi/spi-sifive.c
@@ -308,6 +308,12 @@ static int sifive_spi_probe(struct platform_device *pd=
ev)
 =09platform_set_drvdata(pdev, master);
=20
 =09res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
+=09if (!res) {
+=09=09dev_err(&pdev->dev, "no IOMEM resource found\n");
+=09=09ret =3D -ENXIO;
+=09=09goto put_master;
+=09}
+
 =09spi->regs =3D devm_ioremap_resource(&pdev->dev, res);
 =09if (IS_ERR(spi->regs)) {
 =09=09ret =3D PTR_ERR(spi->regs);
--=20
2.23.0


