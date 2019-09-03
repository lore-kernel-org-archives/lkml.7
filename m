Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F089BC3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 14:20:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B97CE23697
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 14:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567520436;
	bh=ygZcufiEa4tPWQUTLwsIpxN5DMwkrJv3yH0ESnqY4bQ=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=za+mykG5iukdy8lp4twpj/wssUt74GGAnx38PxIz3pwBaGLKRiUszxJkr5pYk6Xds
	 LgPxSdyYnltQpSDgbm6FPuZuWIQxcXwRl28Kpu2RXdPH2mautSCXC+pIhcBB3IRGxD
	 BO/NZqQaAAokyo22N33751SbzxUNT7lFrwy/mydE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729273AbfICOUg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 10:20:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:57130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727107AbfICOUf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 10:20:35 -0400
Received: from localhost.localdomain (cpe-70-114-128-244.austin.res.rr.com [70.114.128.244])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8E2BE22D6D;
        Tue,  3 Sep 2019 14:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567520434;
        bh=ygZcufiEa4tPWQUTLwsIpxN5DMwkrJv3yH0ESnqY4bQ=;
        h=From:To:Cc:Subject:Date:From;
        b=qO+VPZHZBEPdHZs0lMom5N2QPKLnYZHR+43Y+b8JoVwKXDe/uARpF7uubMFjc/1zV
         W0nmnVF9tczCPEB3PoaGXpuF+4g66gM/IwLC9kQ4O4Q1oufMBr7bE5JQXCsDKDrojN
         YKD1RvVt8Uv2xoMWNmjE5BR9bH2BB8INavDEF33Y=
From:   Dinh Nguyen <dinguyen@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     dinguyen@kernel.org, devicetree@vger.kernel.org, robh@kernel.org,
        linux@armlinux.org.uk, frowand.list@gmail.com,
        keescook@chromium.org, anton@enomsg.org, ccross@android.com,
        tony.luck@intel.com, daniel.thompson@linaro.org,
        linus.walleij@linaro.org, manivannan.sadhasivam@linaro.org,
        linux-arm-kernel@lists.infradead.org, p.zabel@pengutronix.de
Subject: [PATCHv7] drivers/amba: add reset control to amba bus probe
Date:   Tue,  3 Sep 2019 09:12:15 -0500
Message-Id: <20190903141215.18283-1-dinguyen@kernel.org>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The primecell controller on some SoCs, i.e. SoCFPGA, is held in reset by
default. Until recently, the DMA controller was brought out of reset by the
bootloader(i.e. U-Boot). But a recent change in U-Boot, the peripherals
that are not used are held in reset and are left to Linux to bring them
out of reset.

Add a mechanism for getting the reset property and de-assert the primecell
module from reset if found. This is a not a hard fail if the reset properti
is not present in the device tree node, so the driver will continue to
probe.

Because there are different variants of the controller that may have
multiple reset signals, the code will find all reset(s) specified and
de-assert them.

Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
---
v7: added Philipp Zabel's Reviewed-by:
v6: remove the need to reset_control_get_count as
    of_reset_control_array_get_optional_shared is already doing that
v5: use of_reset_control_array_get_optional_shared()
v4: cleaned up indentation in loop
    fix up a few checkpatch warnings
    add Reviewed-by:
v3: add a reset_control_put()
    add error handling
v2: move reset control to bus code
    find all reset properties and de-assert them
---
 drivers/amba/bus.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
index 100e798a5c82..f39f075abff9 100644
--- a/drivers/amba/bus.c
+++ b/drivers/amba/bus.c
@@ -18,6 +18,7 @@
 #include <linux/limits.h>
 #include <linux/clk/clk-conf.h>
 #include <linux/platform_device.h>
+#include <linux/reset.h>
 
 #include <asm/irq.h>
 
@@ -401,6 +402,19 @@ static int amba_device_try_add(struct amba_device *dev, struct resource *parent)
 	ret = amba_get_enable_pclk(dev);
 	if (ret == 0) {
 		u32 pid, cid;
+		struct reset_control *rstc;
+
+		/*
+		 * Find reset control(s) of the amba bus and de-assert them.
+		 */
+		rstc = of_reset_control_array_get_optional_shared(dev->dev.of_node);
+		if (IS_ERR(rstc)) {
+			if (PTR_ERR(rstc) != -EPROBE_DEFER)
+				dev_err(&dev->dev, "Can't get amba reset!\n");
+			return PTR_ERR(rstc);
+		}
+		reset_control_deassert(rstc);
+		reset_control_put(rstc);
 
 		/*
 		 * Read pid and cid based on size of resource
-- 
2.20.0

