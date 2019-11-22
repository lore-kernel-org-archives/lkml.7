Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48DF6C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:49:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 220DF2072E
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:49:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574419774;
	bh=jBnr4IXGRdr3EgGfoNNpKX0LS2x7SiFPDYi49r8gSlE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EkN3SxQA0snWTzJXtngNbA220fNSfqlLJL8ifVvAff1wjAm4yLvjYbegRBE6zZ5z7
	 cSyEWDiFpCU1uR5cqTfIusGiSc1av0urPGaWKiH3ilLgNmIAyaJf0QCoWFN1UqMgEW
	 7ecnB9uyHB2vt4lh7s+jdLZdrTUt42l/Mt1YVZlI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730027AbfKVKtc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 05:49:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:58748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729668AbfKVKtW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 05:49:22 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D634C20715;
        Fri, 22 Nov 2019 10:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574419762;
        bh=jBnr4IXGRdr3EgGfoNNpKX0LS2x7SiFPDYi49r8gSlE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L9Cj/8yISHYbQAunN3kQMjkO4hUWDip5jxBgC+c2ozBAXgikDjDC3x8NodGRYuU3r
         ZmRayVGzKcHpMzuBrejwM4koWRYD4QMcYdIpFPcoOROcBA17/2MJ2gLw8Yt8vS6nEN
         Vdx2QCDJjBwzydz8O5XgiiGUWmwGg6zyUqDKFNfc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Trent Piepho <tpiepho@impinj.com>,
        =?UTF-8?q?Jan=20Kundr=C3=83=C2=A1t?= <jan.kundrat@cesnet.cz>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 213/222] spi: spidev: Fix OF tree warning logic
Date:   Fri, 22 Nov 2019 11:29:13 +0100
Message-Id: <20191122100917.831314922@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191122100830.874290814@linuxfoundation.org>
References: <20191122100830.874290814@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Trent Piepho <tpiepho@impinj.com>

[ Upstream commit 605b3bec73cbd74b4ac937b580cd0b47d1300484 ]

spidev will make a big fuss if a device tree node binds a device by
using "spidev" as the node's compatible property.

However, the logic for this isn't looking for "spidev" in the
compatible, but rather checking that the device is NOT compatible with
spidev's list of devices.

This causes a false positive if a device not named "rohm,dh2228fv", etc.
binds to spidev, even if a means other than putting "spidev" in the
device tree was used.  E.g., the sysfs driver_override attribute.

Signed-off-by: Trent Piepho <tpiepho@impinj.com>
Reviewed-by: Jan KundrÃ¡t <jan.kundrat@cesnet.cz>
Tested-by: Jan KundrÃ¡t <jan.kundrat@cesnet.cz>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spidev.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index 2e05046f866bd..f4ea286b0121e 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -751,11 +751,9 @@ static int spidev_probe(struct spi_device *spi)
 	 * compatible string, it is a Linux implementation thing
 	 * rather than a description of the hardware.
 	 */
-	if (spi->dev.of_node && !of_match_device(spidev_dt_ids, &spi->dev)) {
-		dev_err(&spi->dev, "buggy DT: spidev listed directly in DT\n");
-		WARN_ON(spi->dev.of_node &&
-			!of_match_device(spidev_dt_ids, &spi->dev));
-	}
+	WARN(spi->dev.of_node &&
+	     of_device_is_compatible(spi->dev.of_node, "spidev"),
+	     "%pOF: buggy DT: spidev listed directly in DT\n", spi->dev.of_node);
 
 	spidev_probe_acpi(spi);
 
-- 
2.20.1



