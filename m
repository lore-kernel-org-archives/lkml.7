Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52C02C4646B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 07:37:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29D322133F
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 07:37:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fau.de header.i=@fau.de header.b="csQWE6Vp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbfFZHhQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 03:37:16 -0400
Received: from mx-rz-1.rrze.uni-erlangen.de ([131.188.11.20]:42767 "EHLO
        mx-rz-1.rrze.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726902AbfFZHhP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 03:37:15 -0400
Received: from mx-exchlnx-1.rrze.uni-erlangen.de (mx-exchlnx-1.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::37])
        by mx-rz-1.rrze.uni-erlangen.de (Postfix) with ESMTP id 45YZcB4Qq6z8tny;
        Wed, 26 Jun 2019 09:37:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fau.de; s=fau-2013;
        t=1561534634; bh=Tdi2jY4l88PA0y9syOuNCHzmZ2oVKA8Jf+3pxxM9to4=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From:To:CC:
         Subject;
        b=csQWE6VpPzvf+0af/ouT2pWjxuwxVmktNG/UwK34cL5Xs7bZKDbMGcGA+qjHJtyvY
         T+vU1dNMVPfyKBVF01ybgXJhlW5cAQhOnqqh2F12Xxu7J93Wt79uiMNp4LG3AQYI/r
         kf3egKaMEG1rEocCVgmehYSchY3V2z29UyB5ErONIktHinVdKw/0cRvNha1eZI5jB/
         kjEOxqX7T1OgWqeYw8sGfJExGLcgPnkWW5yx3HJ38v1TpVkKtQ9s5bzonR8Yjx5nI2
         /rZbcJNHlTeeoGC6KR/0a9V6vLNMVHEJEhOCS5hf5wY9fjxRdmaY9CWw4SyQRaJviA
         0PlP72MQJRvSg==
X-Virus-Scanned: amavisd-new at boeck5.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
Received: from hbt1.exch.fau.de (hbt1.exch.fau.de [10.15.8.13])
        by mx-exchlnx-1.rrze.uni-erlangen.de (Postfix) with ESMTP id 45YZc738j1z8sd8;
        Wed, 26 Jun 2019 09:37:11 +0200 (CEST)
Received: from MBX3.exch.uni-erlangen.de (10.15.8.45) by hbt1.exch.fau.de
 (10.15.8.13) with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 26 Jun 2019
 09:36:39 +0200
Received: from TroubleWorld.fritz.box (95.90.221.207) by
 MBX3.exch.uni-erlangen.de (10.15.8.45) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1591.10; Wed, 26 Jun 2019 09:36:38 +0200
From:   Fabian Krueger <fabian.krueger@fau.de>
CC:     <fabian.krueger@fau.de>,
        Michael Scheiderer <michael.scheiderer@fau.de>,
        <linux-kernel@i4.cs.fau.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <devel@driverdev.osuosl.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 7/8] staging: kpc2000: introduce __func__
Date:   Wed, 26 Jun 2019 09:35:25 +0200
Message-ID: <20190626073531.8946-8-fabian.krueger@fau.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190626073531.8946-1-fabian.krueger@fau.de>
References: <20190625115251.GA28859@kadam>
 <20190626073531.8946-1-fabian.krueger@fau.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [95.90.221.207]
X-ClientProxiedBy: MBX3.exch.uni-erlangen.de (10.15.8.45) To
 MBX3.exch.uni-erlangen.de (10.15.8.45)
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of using the function name hard coded as string, using __func__
and the '%s'-placeholder will always give the current name of the
function. When renaming a function, the debugging-messages won't have to
be rewritten.

Signed-off-by: Fabian Krueger <fabian.krueger@fau.de>
Signed-off-by: Michael Scheiderer <michael.scheiderer@fau.de>
Cc: <linux-kernel@i4.cs.fau.de>
---
 drivers/staging/kpc2000/kpc2000_spi.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/kpc2000/kpc2000_spi.c b/drivers/staging/kpc2000/kpc2000_spi.c
index eeb36d78402e..55bed617b0d8 100644
--- a/drivers/staging/kpc2000/kpc2000_spi.c
+++ b/drivers/staging/kpc2000/kpc2000_spi.c
@@ -428,13 +428,14 @@ kp_spi_probe(struct platform_device *pldev)
 
 	drvdata = pldev->dev.platform_data;
 	if (!drvdata) {
-		dev_err(&pldev->dev, "kp_spi_probe: platform_data is NULL!\n");
+		dev_err(&pldev->dev, "%s: platform_data is NULL\n", __func__);
 		return -ENODEV;
 	}
 
 	master = spi_alloc_master(&pldev->dev, sizeof(struct kp_spi));
 	if (master == NULL) {
-		dev_err(&pldev->dev, "kp_spi_probe: master allocation failed\n");
+		dev_err(&pldev->dev, "%s: master allocation failed\n",
+			__func__);
 		return -ENOMEM;
 	}
 
@@ -457,7 +458,8 @@ kp_spi_probe(struct platform_device *pldev)
 
 	r = platform_get_resource(pldev, IORESOURCE_MEM, 0);
 	if (r == NULL) {
-		dev_err(&pldev->dev, "kp_spi_probe: Unable to get platform resources\n");
+		dev_err(&pldev->dev, "%s: Unable to get platform resources\n",
+			__func__);
 		status = -ENODEV;
 		goto free_master;
 	}
-- 
2.17.1

