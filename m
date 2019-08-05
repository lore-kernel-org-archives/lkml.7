Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69610C0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 14:53:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32129216B7
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 14:53:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565016780;
	bh=Cqmt7tjneQ4HtnjP8OfwvCqlK3SonszeggbFy2Va2d4=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=ok187rnnP5iPgdiA/qWsebJpP54gORNC1JPRqOfx4o5C0AP4Qy8TjbTeYzRRNJ/LC
	 Bw8gEPakwcwONzQJ5XD7QF51bcXtozs5IQMzQvScrzGKc1IScAOqDGyy2KDvPc4fag
	 dy1t9NpHJUQgfoe4SZKYdz4aGr1HzEtXiMWQEdxo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729264AbfHEOw7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 10:52:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:35096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728824AbfHEOw7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 10:52:59 -0400
Received: from localhost.localdomain (cpe-70-114-128-244.austin.res.rr.com [70.114.128.244])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5818F206C1;
        Mon,  5 Aug 2019 14:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565016778;
        bh=Cqmt7tjneQ4HtnjP8OfwvCqlK3SonszeggbFy2Va2d4=;
        h=From:To:Cc:Subject:Date:From;
        b=PEQ9/csDEthrHxgmCsXGzDcHkMBtOo3l70WrvEK4o+R3MnxVMxnEnZHS1Ek7Jkw2l
         CuXiBDjE9qMvXHCw+0N9Dxwun5RIO3uL6WRzQpkBlI/PSTTbZ+cisuUVQxcjQ33Wdw
         lDL5Wit0Q5LR23b9PjnxnSbcfHXJx2+D2HPVhowI=
From:   Dinh Nguyen <dinguyen@kernel.org>
To:     devicetree@vger.kernel.org
Cc:     dinguyen@kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, frowand.list@gmail.com, keescook@chromium.org,
        anton@enomsg.org, ccross@android.com, tony.luck@intel.com
Subject: [PATCHv2] drivers/amba: add reset control to primecell probe
Date:   Mon,  5 Aug 2019 09:52:11 -0500
Message-Id: <20190805145211.23161-1-dinguyen@kernel.org>
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
v2: move reset control to bus code
    find all reset properties and de-assert them
---
 drivers/amba/bus.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
index 100e798a5c82..75e18b9e4808 100644
--- a/drivers/amba/bus.c
+++ b/drivers/amba/bus.c
@@ -18,6 +18,7 @@
 #include <linux/limits.h>
 #include <linux/clk/clk-conf.h>
 #include <linux/platform_device.h>
+#include <linux/reset.h>
 
 #include <asm/irq.h>
 
@@ -401,6 +402,18 @@ static int amba_device_try_add(struct amba_device *dev, struct resource *parent)
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
+			reset_control_deassert(rstc);
+			count--;
+		}
 
 		/*
 		 * Read pid and cid based on size of resource
-- 
2.20.0

