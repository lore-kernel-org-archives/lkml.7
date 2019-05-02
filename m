Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7653C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 15:34:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C92E20449
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 15:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556811253;
	bh=7bQ+PW8gp7kct0H9YCiXOXNn17fdj3o1WqXvABcad+Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OEn2/HyGCroLaI6hYmIKRdHZwllWQgwGzvGbCozmkE6iByvigrY3S2rn3fEbiBFgI
	 uwTIif9C2yXl2R9KP2qFyrNLqgPg/TefIbRPV3a/LD5pNCDS20oR582w/XXTWSBzxl
	 mC7RdFHqF63vS/9bHxFflrBNzQTS5IIU2hQERhms=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727921AbfEBPeM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 11:34:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:51962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728232AbfEBPcW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 11:32:22 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD3C4204FD;
        Thu,  2 May 2019 15:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556811142;
        bh=7bQ+PW8gp7kct0H9YCiXOXNn17fdj3o1WqXvABcad+Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GOceMRtykpIo4ZDgBbAhTJWP8nHGiaoR3Q2V9rMIt9dxpYaIt02cPxq4Jsgyasr8i
         H8h0r/rq46CmgV7wSUaeXUFeSNuzUH/KK0HU6PI3oua0ljOFerwr2y5TztDUNQM73i
         DUADbYlWOlN3uGkcPeiwzxb22c7ITtJ08NccXr0w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Mukesh Ojha <mojha@codeaurora.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "Sasha Levin (Microsoft)" <sashal@kernel.org>
Subject: [PATCH 5.0 090/101] gpio: of: Fix of_gpiochip_add() error path
Date:   Thu,  2 May 2019 17:21:32 +0200
Message-Id: <20190502143345.884814595@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190502143339.434882399@linuxfoundation.org>
References: <20190502143339.434882399@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit f7299d441a4da8a5088e651ea55023525a793a13 ]

If the call to of_gpiochip_scan_gpios() in of_gpiochip_add() fails, no
error handling is performed.  This lead to the need of callers to call
of_gpiochip_remove() on failure, which causes "BAD of_node_put() on ..."
if the failure happened before the call to of_node_get().

Fix this by adding proper error handling.

Note that calling gpiochip_remove_pin_ranges() multiple times causes no
harm: subsequent calls are a no-op.

Fixes: dfbd379ba9b7431e ("gpio: of: Return error if gpio hog configuration failed")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin (Microsoft) <sashal@kernel.org>
---
 drivers/gpio/gpiolib-of.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index f1ae28289a67..13a402ede07a 100644
--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -712,7 +712,13 @@ int of_gpiochip_add(struct gpio_chip *chip)
 
 	of_node_get(chip->of_node);
 
-	return of_gpiochip_scan_gpios(chip);
+	status = of_gpiochip_scan_gpios(chip);
+	if (status) {
+		of_node_put(chip->of_node);
+		gpiochip_remove_pin_ranges(chip);
+	}
+
+	return status;
 }
 
 void of_gpiochip_remove(struct gpio_chip *chip)
-- 
2.19.1



