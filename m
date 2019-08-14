Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24185C32753
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 13:51:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC2E82084D
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 13:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565790696;
	bh=5au+uySpHKMUgQfB6f0HCtqCGXnnNO/toEwWtCgwQRU=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=2axNNPpCELhgFlC/WieZM5HK/X+D89gQaKQ/AxWVkDdNUKGd6ZlUemia5syF6lNcs
	 IF2RoqVEYyxdQ3YW182phkVObiHr9ejaN1ZW4ivItatKFduCeati1owYHfF6McscEj
	 KPyL+017SYvllgU02TN9hPbs9YLVrcHpoKAvgsDM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728045AbfHNNve (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 09:51:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:41720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726551AbfHNNve (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 09:51:34 -0400
Received: from localhost.localdomain (cpe-70-114-128-244.austin.res.rr.com [70.114.128.244])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 843A02083B;
        Wed, 14 Aug 2019 13:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565790693;
        bh=5au+uySpHKMUgQfB6f0HCtqCGXnnNO/toEwWtCgwQRU=;
        h=From:To:Cc:Subject:Date:From;
        b=uiOtBSWig10yz+nCoVHu1if2OzdDV4ch9JMoPw/VNHRPt2QVN+cjR3yw23yu7Nk0k
         n4D4OupfIZWb0Yr/4pEZsqvU/mCDaDVbjwPIlSZqiA+rJIroAd6hE5Cx9npR8da1BE
         gpCVMkJlH1DrUn4oHZerUB2yp/Qg0rb4jJcPITqo=
From:   Dinh Nguyen <dinguyen@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     dinguyen@kernel.org, devicetree@vger.kernel.org, robh@kernel.org,
        linux@armlinux.org.uk, frowand.list@gmail.com,
        keescook@chromium.org, anton@enomsg.org, ccross@android.com,
        tony.luck@intel.com
Subject: [PATCHv4] drivers/amba: add reset control to amba bus probe
Date:   Wed, 14 Aug 2019 08:51:16 -0500
Message-Id: <20190814135116.10123-1-dinguyen@kernel.org>
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
---
v4: cleaned up indentation in loop
    fix up a few checkpatch warnings
    add Reviewed-by:
v3: add a reset_control_put()
    add error handling
v2: move reset control to bus code
    find all reset properties and de-assert them
---
 drivers/amba/bus.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
index 100e798a5c82..76a1cd56a1ab 100644
--- a/drivers/amba/bus.c
+++ b/drivers/amba/bus.c
@@ -18,6 +18,7 @@
 #include <linux/limits.h>
 #include <linux/clk/clk-conf.h>
 #include <linux/platform_device.h>
+#include <linux/reset.h>
 
 #include <asm/irq.h>
 
@@ -401,6 +402,26 @@ static int amba_device_try_add(struct amba_device *dev, struct resource *parent)
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
+				if (PTR_ERR(rstc) == -EPROBE_DEFER)
+					ret = -EPROBE_DEFER;
+				else
+					dev_err(&dev->dev, "Can't get amba reset!\n");
+				break;
+			}
+			reset_control_deassert(rstc);
+			reset_control_put(rstc);
+			count--;
+		}
 
 		/*
 		 * Read pid and cid based on size of resource
-- 
2.20.0

