Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F28CDC2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 15:58:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEEFE20657
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 15:58:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="WiVfnV1X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731166AbfFGP57 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 11:57:59 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:33424 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729367AbfFGP55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 11:57:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1559923075; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:references; bh=LEAcNQEFSV4vEi4RU29MUMcA9Jz9XuPJ9DAENOw2h5s=;
        b=WiVfnV1X9xbWRAHKa8gRqq1hhkt2xZvf4pKWyy8C7np+GyxuaQZYV+0f1xBoHVyVQnueNJ
        Yu/+OPO7ZX9yIgoUOsgDOsvfL4l/uQML13BjKur+aUIN5qJCryZUyr2q7ZzOJFq/Hy/GZa
        7X+lxYJivVTeFOohhUHKvT+CFlQpHyQ=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Bin Liu <b-liu@ti.com>
Cc:     od@zcrc.me, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH] usb: musb: jz4740: Make probe function __init_or_module
Date:   Fri,  7 Jun 2019 17:57:51 +0200
Message-Id: <20190607155751.15778-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows the probe function to be dropped after the kernel finished
its initialization, in the case where the driver was not compiled as a
module.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/usb/musb/jz4740.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/musb/jz4740.c b/drivers/usb/musb/jz4740.c
index 5261f8dfedec..c881f6d14752 100644
--- a/drivers/usb/musb/jz4740.c
+++ b/drivers/usb/musb/jz4740.c
@@ -105,7 +105,7 @@ static const struct musb_platform_ops jz4740_musb_ops = {
 	.init		= jz4740_musb_init,
 };
 
-static int jz4740_probe(struct platform_device *pdev)
+static int __init_or_module jz4740_probe(struct platform_device *pdev)
 {
 	struct musb_hdrc_platform_data	*pdata = &jz4740_musb_platform_data;
 	struct platform_device		*musb;
@@ -174,7 +174,7 @@ static int jz4740_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int jz4740_remove(struct platform_device *pdev)
+static int __exit jz4740_remove(struct platform_device *pdev)
 {
 	struct jz4740_glue	*glue = platform_get_drvdata(pdev);
 
-- 
2.21.0.593.g511ec345e18

