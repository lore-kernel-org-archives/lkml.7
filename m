Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C529C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:41:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB3392075C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574890898;
	bh=qls5kbsWPuCDNYYjX0eEPWKHkVav8I4/1tEG+ikA4aA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=odUy0OsLmjlig/AnKBw+vMCRxL1TtUg/ndN2B1+SkNEgVGH4UOnxZOJvAwJDRxI26
	 36g8uQEG9rJMWi4qR+SQrs3p3opNwNidlxnuOFvdqggOAxm6rP8mLr2BoELI7kTTd5
	 DWV+htC7Fp+XK07y5AXuW04c3JZqHFbVgD4/efis=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729176AbfK0UlY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 15:41:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:46398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729155AbfK0UlR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 15:41:17 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB988215A4;
        Wed, 27 Nov 2019 20:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574887277;
        bh=qls5kbsWPuCDNYYjX0eEPWKHkVav8I4/1tEG+ikA4aA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gDlOyDzT+N3Dxy6tg//hcS4IylLB6+PpBNIJR/Y5eOexyaqBl4sn8NxnzdcB3FjY5
         xqC3Ganu0LikH3duxBnu8hTU63TkyFe1tQyB/ySGEGRopPgFbBinuvKBEEqMmiF7KP
         eKtHM5p05q383OqUMl+zX/XmhFIJZ2b1pXe0QHKk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 021/151] spi: sh-msiof: fix deferred probing
Date:   Wed, 27 Nov 2019 21:30:04 +0100
Message-Id: <20191127203013.966868637@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191127203000.773542911@linuxfoundation.org>
References: <20191127203000.773542911@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

[ Upstream commit f34c6e6257aa477cdfe7e9bbbecd3c5648ecda69 ]

Since commit 9ec36cafe43b ("of/irq: do irq resolution in platform_get_irq")
platform_get_irq() can return -EPROBE_DEFER. However, the driver overrides
an error returned by that function with -ENOENT which breaks the deferred
probing. Propagate upstream an error code returned by platform_get_irq()
and remove the bogus "platform" from the error message, while at it...

Fixes: 9ec36cafe43b ("of/irq: do irq resolution in platform_get_irq")
Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-sh-msiof.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
index 711ea523b3251..8a69148a962a8 100644
--- a/drivers/spi/spi-sh-msiof.c
+++ b/drivers/spi/spi-sh-msiof.c
@@ -1198,8 +1198,8 @@ static int sh_msiof_spi_probe(struct platform_device *pdev)
 
 	i = platform_get_irq(pdev, 0);
 	if (i < 0) {
-		dev_err(&pdev->dev, "cannot get platform IRQ\n");
-		ret = -ENOENT;
+		dev_err(&pdev->dev, "cannot get IRQ\n");
+		ret = i;
 		goto err1;
 	}
 
-- 
2.20.1



