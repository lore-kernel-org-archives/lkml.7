Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11F6CC0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 14:02:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D313D2173E
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 14:02:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565272954;
	bh=rZdFt1nTqsCFfJecz9OvxRQYmusq8d4LHI3dbVndMis=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=MDIvWtw5Ex6qfp6Y2e0tgmBEDRsCOmilmsrX7X0rJ8wsMGqyKV9UEKc/YAQl5OR/F
	 UuzMmyOT+qJRPAkFXBI+JB0wiuf8zoGXKuuzqFqC20MKQ4fxXbYIexXwx8WJnEcOyt
	 8ixYD+ulakEvOHhizqzWJFI/CiZU08BcirdtUSSQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390080AbfHHOCd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 10:02:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:45572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732866AbfHHOCd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 10:02:33 -0400
Received: from localhost.localdomain (cpe-70-114-128-244.austin.res.rr.com [70.114.128.244])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5736B21743;
        Thu,  8 Aug 2019 14:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565272952;
        bh=rZdFt1nTqsCFfJecz9OvxRQYmusq8d4LHI3dbVndMis=;
        h=From:To:Cc:Subject:Date:From;
        b=BvBkOjzTXTL5BAvMofI5yEqRATA7GbCRZ7t0mWQ87KLXqEDmJOD/dFC+dYnTbXyMP
         Kbxjs5id9rI/Fp0MfBaI/kYag0ExphOHAzsEbpOtpFN0QKWyvdt9gN5jfnQYp3GnsR
         UUJJvqSeiemyvDqLBBxhE0LI6lwuzkLh/JBiZcXQ=
From:   Dinh Nguyen <dinguyen@kernel.org>
To:     devicetree@vger.kernel.org
Cc:     dinguyen@kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, frowand.list@gmail.com, keescook@chromium.org,
        anton@enomsg.org, ccross@android.com, tony.luck@intel.com
Subject: [PATCHv3] drivers/amba: add reset control to amba bus probe
Date:   Thu,  8 Aug 2019 09:01:53 -0500
Message-Id: <20190808140153.9156-1-dinguyen@kernel.org>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The primecell controller on some SoCs, i.e. SoCFPGA, is held in reset by
default. Until recently, the DMA controller was brought out of reset by the
bootloader(i.e. U-Boot). But a recent change in U-Boot, the peripherals that
are not used are held in reset and are left to Linux to bring them out of
reset.

Add a mechanism for getting the reset property and de-assert the primecell
module from reset if found. This is a not a hard fail if the reset property
is not present in the device tree node, so the driver will continue to probe.

Because there are different variants of the controller that may have multiple
reset signals, the code will find all reset(s) specified and de-assert them.

Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
---
v3: add a reset_control_put()
    add error handling for -EPROBE_DEFER
v2: move reset control to bus code
    find all reset properties and de-assert them
---
 drivers/amba/bus.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
index 100e798a5c82..00e68ea416ca 100644
--- a/drivers/amba/bus.c
+++ b/drivers/amba/bus.c
@@ -18,6 +18,7 @@
 #include <linux/limits.h>
 #include <linux/clk/clk-conf.h>
 #include <linux/platform_device.h>
+#include <linux/reset.h>
 
 #include <asm/irq.h>
 
@@ -401,6 +402,28 @@ static int amba_device_try_add(struct amba_device *dev, struct resource *parent)
 	ret = amba_get_enable_pclk(dev);
 	if (ret == 0) {
 		u32 pid, cid;
+		int count;
+		struct reset_control *rstc;
+
+		/*
+		 * Find reset control(s) of the amba bus and de-assert them.
+		 */
+		count = reset_control_get_count(&dev->dev);
+		while (count > 0) {
+			rstc = of_reset_control_get_shared_by_index(dev->dev.of_node, count - 1);
+			if (IS_ERR(rstc)) {
+				if (PTR_ERR(rstc) == -EPROBE_DEFER) {
+					ret = -EPROBE_DEFER;
+				} else {
+					dev_err(&dev->dev, "Can't get amba reset!\n");
+				}
+				break;
+			} else {
+				reset_control_deassert(rstc);
+				reset_control_put(rstc);
+				count--;
+			}
+		}
 
 		/*
 		 * Read pid and cid based on size of resource
-- 
2.20.0

