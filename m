Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 022F5CA9EC0
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 00:43:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B935221835
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 00:43:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="C6DbVAC/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbfJ2AnL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 20:43:11 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:35475 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726636AbfJ2AnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 20:43:11 -0400
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 5508A886BF;
        Tue, 29 Oct 2019 13:43:09 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1572309789;
        bh=jDHnRZm14GJI/8ZawxhtbbZIWpFs2vGKs23EmX+ANjU=;
        h=From:To:Cc:Subject:Date;
        b=C6DbVAC/sjb2SdWjw1hWifHjWXfZv7k7QSmIVGTLMetbsZWqCpaUBAfnCrEdnmmP8
         Z3kaiwpiOabGlQ4yMxlaOmVUHfR16399DB1iJIKdn+4pro0Rp7+qLRrBsI2Zo/2GXL
         83uOZ+Dk1NKHA9VjLWsioxo5cMBEF4ZDC64eCeJ+Eim0zth2OLd4w/4t/hTX4ZMfvx
         mx20O6BYUxOOrq4Sus8YpdkDNpiCCKuIQWstlUOCc7Q6yC62KiNN/Sz1AD8zAmuz9x
         HsOsM9XfF1tUTHmRS1a44IqRZo8VS6lScn8EMFzKfmTMND+aSbbR6bhKVlwrRX8yAZ
         n56SuKarCj7Qw==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5db78b1d0000>; Tue, 29 Oct 2019 13:43:09 +1300
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.20])
        by smtp (Postfix) with ESMTP id ADC5013EE9C;
        Tue, 29 Oct 2019 13:43:09 +1300 (NZDT)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id EF3D128005C; Tue, 29 Oct 2019 13:43:08 +1300 (NZDT)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     sre@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH] power: reset: gpio-restart: don't error on deferral
Date:   Tue, 29 Oct 2019 13:43:02 +1300
Message-Id: <20191029004302.384-1-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
x-atlnz-ls: pat
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't generate an error message when devm_gpiod_get fails with
-EPROBE_DEFER.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
 drivers/power/reset/gpio-restart.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/power/reset/gpio-restart.c b/drivers/power/reset/gpi=
o-restart.c
index 308ca9d9d276..4aaa46b80ba2 100644
--- a/drivers/power/reset/gpio-restart.c
+++ b/drivers/power/reset/gpio-restart.c
@@ -65,7 +65,8 @@ static int gpio_restart_probe(struct platform_device *p=
dev)
 	gpio_restart->reset_gpio =3D devm_gpiod_get(&pdev->dev, NULL,
 			open_source ? GPIOD_IN : GPIOD_OUT_LOW);
 	if (IS_ERR(gpio_restart->reset_gpio)) {
-		dev_err(&pdev->dev, "Could not get reset GPIO\n");
+		if (PTR_ERR(gpio_restart->reset_gpio) !=3D -EPROBE_DEFER)
+			dev_err(&pdev->dev, "Could not get reset GPIO\n");
 		return PTR_ERR(gpio_restart->reset_gpio);
 	}
=20
--=20
2.23.0

