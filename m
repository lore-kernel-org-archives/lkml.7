Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED4CDC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 02:20:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF1292146E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 02:20:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WUT8cnTQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727656AbfCSCUk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 22:20:40 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:33683 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726832AbfCSCUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 22:20:38 -0400
Received: by mail-it1-f196.google.com with SMTP id f186so18185337ita.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 19:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WYJJMz7+U/WDAxesVZsDPRVhOdSz8XlsS9szhhVOU8U=;
        b=WUT8cnTQv0b1xkWJS1iC5nxS9FTTddEreaSfUfJvZVhpM5fLEFRtgX/yP72ln3ag/i
         Bi6P//36dJ/ZpJaZBvKksDaOdJuleWnzoNn3Y2lgf+yLZS+r1q07oTaL6RMZmhpqO4dM
         AHzC9MFzki0//yS1sJpGpwkpMHhZGlT/OaN37tUFcEsAanbCfAUfn5Lk6J/MLoM1TFUS
         Gc/vEcYw3NB6AWkNDWoR4tYIFacJ68qVdsyjdApp1K/d2rOQhCGUIxhlxrIrGZaLohOS
         59CcMzWpXTMfTDxnRbLAf0+q6WH05jl2+3eImF5+5RqVEP74IjjTAE3Vlmn4AhdusBiX
         BwVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WYJJMz7+U/WDAxesVZsDPRVhOdSz8XlsS9szhhVOU8U=;
        b=ZDPJL3FSWTNtVZD7BsUs4LDN5RI+e9hclNa8Sz46w01pRmKdprAdaLy1QGAEq0Jw2B
         STktV+z+i6yI2tKkht+yPOTyvLI36hjSsM9ovtHVPi/5+rIzD8N5pxoF2lmtCYfAVM0v
         TmUjKTPD8nElXgaxdky01EgUzGUKH7wksXM/AjztTRwW5M7AdP+cXD+3d5fvZ1aLML/P
         7WJRZivXcZsv26ourzWimxvgP5qrilcFCQH/lRnVR/GCJDShbaRdV6hSgjXXKl5G9cf/
         RAGy67M2vA7TbujCPtFxdW/4595DPM7vJjxe0MrEqrbe9sjWTsXtKJ/1B0oqXoMO2fUn
         y+9Q==
X-Gm-Message-State: APjAAAUztA6Z4J5cnYuvGFBaHGABnd+XBDEr9+oSHrs1U3DDzE1XhtMU
        wVR63N3me9CPFOyVJW+fz/o=
X-Google-Smtp-Source: APXvYqymIQRhbtqRlTx3U6Rd8vJIyCHa4HuORz+jCWyhgpjsT0WfkFkVH389QrIDMmBaj2AeS5CGvQ==
X-Received: by 2002:a24:640d:: with SMTP id t13mr39205itc.38.1552962037398;
        Mon, 18 Mar 2019 19:20:37 -0700 (PDT)
Received: from localhost.localdomain (c-73-242-244-99.hsd1.nm.comcast.net. [73.242.244.99])
        by smtp.gmail.com with ESMTPSA id l8sm673838itl.26.2019.03.18.19.20.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Mar 2019 19:20:36 -0700 (PDT)
From:   George Hilliard <thirtythreeforty@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        George Hilliard <thirtythreeforty@gmail.com>
Subject: [PATCH v2 04/11] staging: mt7621-mmc: Use pinctrl subsystem to select SDXC pin mode
Date:   Mon, 18 Mar 2019 20:20:05 -0600
Message-Id: <20190319022012.11051-5-thirtythreeforty@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190319022012.11051-1-thirtythreeforty@gmail.com>
References: <20190319022012.11051-1-thirtythreeforty@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver previously grabbed the SD pins for itself, ignoring the pin
controller.  Remove this, and allow the pinctrl subsystem to set up the
pins using the device tree mappings.  This allows this driver to work on
related devices that have a different pin controller mapping, such as
the MT7688.  The hardcoded bit index was incorrect on that device.

The driver now needs a pin controller reference in its device tree node:

	sdhci: /* ... */ {
		compatible = "ralink,mt7620-sdhci";

		pinctrl-names = "default";
		pinctrl-0 = <&sdhci_pins>;

		// ...
	};

This change could break SD controller functionality on existing devices
whose device trees do not specify a pin controller and state for the SD
node.

Signed-off-by: George Hilliard <thirtythreeforty@gmail.com>
---
 drivers/staging/mt7621-mmc/sd.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/staging/mt7621-mmc/sd.c b/drivers/staging/mt7621-mmc/sd.c
index 306b3b46f7c9..4380b321bc73 100644
--- a/drivers/staging/mt7621-mmc/sd.c
+++ b/drivers/staging/mt7621-mmc/sd.c
@@ -1820,12 +1820,6 @@ static struct platform_driver mt_msdc_driver = {
 static int __init mt_msdc_init(void)
 {
 	int ret;
-	u32 reg;
-
-	// Set the pins for sdxc to sdxc mode
-	//FIXME: this should be done by pinctl and not by the sd driver
-	reg = readl((void __iomem *)(RALINK_SYSCTL_BASE + 0x60)) & ~(0x3 << 18);
-	writel(reg, (void __iomem *)(RALINK_SYSCTL_BASE + 0x60));
 
 	ret = platform_driver_register(&mt_msdc_driver);
 	if (ret) {
-- 
2.21.0

