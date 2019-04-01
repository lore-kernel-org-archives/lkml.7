Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE928C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 10:41:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E2E720883
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 10:41:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dXSKu/O3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726800AbfDAKlD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 06:41:03 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33998 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726544AbfDAKk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 06:40:58 -0400
Received: by mail-wm1-f66.google.com with SMTP id r186so1259273wmf.1;
        Mon, 01 Apr 2019 03:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PzMPSMusIBN2kUBwXbKhbx8a3kFNesUVRcOMpGCnO3A=;
        b=dXSKu/O3BMmznVABq9H5PFKJz0sK9imZbcE3QRskqqJMa+00fYExlst1V/qrK9Btmi
         eWoeXLojYVik0SkgOkKBmEQwLbj5jabNSConNbE/f/RJ7Uf35aWrtSZNAilCHRoV5G4v
         f96J5fTTn35TWd6I3IGkQkGI3VZe0NzexRUSfFb05Hd6sT6c3SpnzbxdDwjMp9Kz+tN8
         fL3neqnlXzHjhEKaRP6bazLrN8d4uihBpbsYVLsCKl2M/3ULgFl64zveVcol2a01x1XP
         yczx5Raw776kGKEfvU+QTRWzwNJdLcZbREKBU6oI3RPVGMjz5IwuHeATO/NhTduTZ8k4
         AZFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PzMPSMusIBN2kUBwXbKhbx8a3kFNesUVRcOMpGCnO3A=;
        b=tfbtj2+hoQ0hmRsnvTi1IHi97keurqRYshf189KqBOvIv48KVx6O/A7t6RuownDSFw
         op+5vTGtL8VTb+tixq+5xAqmbQ+KJQInqxgu3Xe2A85AulEX2pEM/Yn9vsALxeTwPsPb
         8xtxuZojPHDZMw17n4NyA8Q8z8n+lryQJ/Kk+4lF3mrzaMHMvrqGM/ZZN/uVLXqCVuDk
         worc8Sx4LXOrAp/kCLRQdT2KdFEVWkQYTI1p6wGTgPl/01l7nwxMXRfSpItdPSvUGH+f
         pz6pYwmv650Pzd0IZK37ruv/ut8qs/ZeLlBeAUXchi+BnN8WhwUv8q6yvcxaE6rurzZi
         VW1g==
X-Gm-Message-State: APjAAAXfXNrV/lSv0GYQGw+CCR2G2ABr4NOTJ7Nt/XztaeyS3hYG0111
        pkVVUyZY9vwHkuj8nzqtKiA=
X-Google-Smtp-Source: APXvYqzzGKEjGzla6ZIsM9x4C9t9wyHAC0U2P2fEWAmNSNLjdVJR6M5F4xGj8dgv5VRj/ESTVqIB3g==
X-Received: by 2002:a7b:c92f:: with SMTP id h15mr12567961wml.115.1554115256469;
        Mon, 01 Apr 2019 03:40:56 -0700 (PDT)
Received: from localhost (pD9E51B25.dip0.t-ipconnect.de. [217.229.27.37])
        by smtp.gmail.com with ESMTPSA id h131sm21677770wmh.1.2019.04.01.03.40.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Apr 2019 03:40:55 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Jon Hunter <jonathanh@nvidia.com>, linux-usb@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: [PATCH v2 3/6] usb: host: xhci-tegra: Add Tegra186 XUSB support
Date:   Mon,  1 Apr 2019 12:40:47 +0200
Message-Id: <20190401104050.31355-4-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401104050.31355-1-thierry.reding@gmail.com>
References: <20190401104050.31355-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: JC Kuo <jckuo@nvidia.com>

This commit adds Tegra186 XUSB host mode controller support. This is
very similar to the existing support for Tegra124 and Tegra210, except
that the number of ports and PHYs differs and the IPFS wrapper being
gone.

Signed-off-by: JC Kuo <jckuo@nvidia.com>
Acked-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/usb/host/xhci-tegra.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/usb/host/xhci-tegra.c b/drivers/usb/host/xhci-tegra.c
index 4d133bbabdda..294158113d62 100644
--- a/drivers/usb/host/xhci-tegra.c
+++ b/drivers/usb/host/xhci-tegra.c
@@ -1423,9 +1423,34 @@ static const struct tegra_xusb_soc tegra210_soc = {
 };
 MODULE_FIRMWARE("nvidia/tegra210/xusb.bin");
 
+static const char * const tegra186_supply_names[] = {
+};
+
+static const struct tegra_xusb_phy_type tegra186_phy_types[] = {
+	{ .name = "usb3", .num = 3, },
+	{ .name = "usb2", .num = 3, },
+	{ .name = "hsic", .num = 1, },
+};
+
+static const struct tegra_xusb_soc tegra186_soc = {
+	.firmware = "nvidia/tegra186/xusb.bin",
+	.supply_names = tegra186_supply_names,
+	.num_supplies = ARRAY_SIZE(tegra186_supply_names),
+	.phy_types = tegra186_phy_types,
+	.num_types = ARRAY_SIZE(tegra186_phy_types),
+	.ports = {
+		.usb3 = { .offset = 0, .count = 3, },
+		.usb2 = { .offset = 3, .count = 3, },
+		.hsic = { .offset = 6, .count = 1, },
+	},
+	.scale_ss_clock = false,
+	.has_ipfs = false,
+};
+
 static const struct of_device_id tegra_xusb_of_match[] = {
 	{ .compatible = "nvidia,tegra124-xusb", .data = &tegra124_soc },
 	{ .compatible = "nvidia,tegra210-xusb", .data = &tegra210_soc },
+	{ .compatible = "nvidia,tegra186-xusb", .data = &tegra186_soc },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, tegra_xusb_of_match);
-- 
2.21.0

