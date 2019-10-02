Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E39D1ECE58A
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 14:36:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAB7721783
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 14:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570026963;
	bh=Bm2O2u6t2yaiuz7SLXAiNV1/Uq8x19unELLdKvJJbww=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=IONJSFWKepdpmrQGnn2MfIaF3c81ZkzKEjvRZaeASKGpayxe1guFvjDPPJXXH7bvw
	 jI5NeRbBPgEIAJ9Ddz0ZL19tQLcCLYBhbQJef3FoXQyw7Rz9COoAI5m+l6YK/TF4j3
	 ha9DRcNSkAK2Ne+xTchORRlIrc60l/bLGNgzxAhw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728219AbfJBOgD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 10:36:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:45948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728135AbfJBOgA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 10:36:00 -0400
Received: from localhost.localdomain (cpe-70-114-128-244.austin.res.rr.com [70.114.128.244])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2066621920;
        Wed,  2 Oct 2019 14:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570026959;
        bh=Bm2O2u6t2yaiuz7SLXAiNV1/Uq8x19unELLdKvJJbww=;
        h=From:To:Cc:Subject:Date:From;
        b=oQvjJj2gdaEuB8qqxNRmNCZRGmh2CIBDlFBLog249ZqvD0j+3z1mAXtRCtQriFdAu
         TpSlphE/MQJMIKBpxYTUBRh9yebPAsIlJOikPaqaibSEC2Yqdd1yEsV67jZhqkqQ4A
         WMRNolUsKn6y4D09kwkEITpUHzrkHRXa+N95h9Sg=
From:   Dinh Nguyen <dinguyen@kernel.org>
To:     linux@armlinux.org.uk
Cc:     dinguyen@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linus.walleij@linaro.org,
        p.zabel@pengutronix.de, thor.thayer@linux.intel.com
Subject: [PATCHv3] ARM: drivers/amba: release and cleanup the resource to allow for deferred probe
Date:   Wed,  2 Oct 2019 09:35:51 -0500
Message-Id: <20191002143551.32288-1-dinguyen@kernel.org>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With commit "79bdcb202a35 ARM: 8906/1: drivers/amba: add reset control to
amba bus probe", the amba bus driver needs to be deferred probe because the
reset driver is probed later. However with a deferred probe, the call to
request_resource() in the driver returns -EBUSY. The reason is the driver
has not released the resource from the previous probe attempt.

This patch fixes how we handle the condition of EPROBE_DEFER that is returned
from getting the reset controls. For this condition, the patch will jump
to defer_probe, which will iounmap, dev_pm_domain_detach, and release the
resource.

Fixes: 79bdcb202a35 ("ARM: 8906/1: drivers/amba: add reset control to
amba bus probe")
Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
---
v3: jump to defer_probe where the driver will unmap and pm_detach the
    driver resource for the next probe attempt
v2: release the resource when of_reset_control_array_get_optional_shared()
    returns EPROBE_DEFER
---
 drivers/amba/bus.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
index f39f075abff9..4a021b1dab3d 100644
--- a/drivers/amba/bus.c
+++ b/drivers/amba/bus.c
@@ -409,9 +409,12 @@ static int amba_device_try_add(struct amba_device *dev, struct resource *parent)
 		 */
 		rstc = of_reset_control_array_get_optional_shared(dev->dev.of_node);
 		if (IS_ERR(rstc)) {
-			if (PTR_ERR(rstc) != -EPROBE_DEFER)
+			ret = PTR_ERR(rstc);
+			if (ret == -EPROBE_DEFER)
+				goto defer_probe;
+			else
 				dev_err(&dev->dev, "Can't get amba reset!\n");
-			return PTR_ERR(rstc);
+			return ret;
 		}
 		reset_control_deassert(rstc);
 		reset_control_put(rstc);
@@ -448,6 +451,7 @@ static int amba_device_try_add(struct amba_device *dev, struct resource *parent)
 			ret = -ENODEV;
 	}
 
+ defer_probe:
 	iounmap(tmp);
 	dev_pm_domain_detach(&dev->dev, true);
 
-- 
2.20.0

