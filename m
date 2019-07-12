Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2591C742AE
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 09:24:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E8EB2084B
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 09:24:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbfGLJYl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 05:24:41 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:56443 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbfGLJYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 05:24:40 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MIxmm-1i1l0j3BPe-00KR95; Fri, 12 Jul 2019 11:24:27 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Sudeep Dutt <sudeep.dutt@intel.com>,
        Ashutosh Dixit <ashutosh.dixit@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Nikhil Rao <nikhil.rao@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexios Zavras <alexios.zavras@intel.com>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: [PATCH] [v2] mic: avoid statically declaring a 'struct device'.
Date:   Fri, 12 Jul 2019 11:24:09 +0200
Message-Id: <20190712092426.872625-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:EuvXqnFGFjdghSadGobgGnRW8OVHsQcwopkyBTTZGK0M8siqV5r
 GBadM6TdG+Ikwl5jKKS9BqU4PF/3TvVPYK7g8LLIDHe4QrLZ+JDyMaLHG8qsms77fwvmIGN
 aqvJfLFsr5QiqhApXR72zZI10YEwHqsP9+DeeYLlZmv5cTkBBf73B2ydjlT6bgNepPvcwii
 GefwYTendCWonJHrs57DQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9NBLRQvWpVQ=:g9QYcjamZlftSZOiSUV/w1
 2SREH8DtKk2xDZOgMU3i31DHxGrZmL+emc1Hpet88qTLmAXtB8wn+0G8TnPNB/PR4pgiMFkxI
 7uNsVr0wTeBOMXuYqY8nHiRe39UP0HSukM897vYGAdPGy7XQDbhUZ3vAwHVeJyuVEEVIFI5TG
 7y3r7PqgSM0MBO0XIyNx0DU4ZrR7rN+HjULVrqX3yJPfFTaYHf9DU9VvLaFlGZ3gdpG1LlPip
 V7yHJY2uaFu8VADZcmHlVU6TlcGk38q6+u3jW6l5ODCYhLb3Py1ViaXboGqhWO5UWhfvtwHXx
 FfkVUDys9zkFSDUVcyAsflgsqWdqqksxcijn4rhGgLlpcWaNiGR0hh/Ae4bvXCIPL6cLQDeM1
 PfFNPYvmdbEJwghfuB5mPuwUVzAVS6x1UYlyjIOxfSvRF4DGJJRbuXl9M0WHf0E+haAJUk0Fp
 6hcUfnr/6+Sq8F8Uil7jtfBe8QKEa6BnDZjYui0O8+RENH8QknMCsYRF6w5IpKrZPSCpE3KiU
 wz4HrzR04R7bOcXeQ3/zfJbPXCA7es4w2zpn3+3AtItsnUjsG0h35cY4BSBBIYAXYDwpRpOdF
 xivus5pYbhWwKb0c/MVqovUvtn9X2/YcsFIEvZaYPTzjXOmT2vj/TqoU9PycdlKcAXWVYb2uQ
 zMT9BK6CVJFVZmBN8ctsZR3XZBxlqJ3Xe6TRpVLMypHpgizQMkA/Uznh+fVdvP/AT/73CR2N/
 f+xW+hBQEBdW44Av+tNUPFxq1oKE8jl2osiTVA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Generally, declaring a platform device as a static variable is
a bad idea and can cause all kinds of problems, in particular
with the DMA configuration and lifetime rules.

A specific problem we hit here is from a bug in clang that warns
about certain (otherwise valid) macros when used in static variables:

drivers/misc/mic/card/mic_x100.c:285:27: warning: shift count >= width of type [-Wshift-count-overflow]
static u64 mic_dma_mask = DMA_BIT_MASK(64);
                          ^~~~~~~~~~~~~~~~
include/linux/dma-mapping.h:141:54: note: expanded from macro 'DMA_BIT_MASK'
 #define DMA_BIT_MASK(n) (((n) == 64) ? ~0ULL : ((1ULL<<(n))-1))
                                                     ^ ~~~

A slightly better way here is to create the platform device dynamically
and set the dma mask in the probe function.
This avoids the warning and some other problems, but is still not ideal
because the device creation should really be separated from the driver,
and the fact that the device has no parent means we have to force
the dma mask rather than having it set up from the bus that the device
is actually on.

Fixes: dd8d8d44df64 ("misc: mic: MIC card driver specific changes to enable SCIF")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v2: rewrite to use platform_device_register_simple() and make it
    actually build

Please merge after -rc1 is out.
---
 drivers/misc/mic/card/mic_x100.c | 28 ++++++++++++----------------
 1 file changed, 12 insertions(+), 16 deletions(-)

diff --git a/drivers/misc/mic/card/mic_x100.c b/drivers/misc/mic/card/mic_x100.c
index 266ffb6f6c44..c8bff2916d3d 100644
--- a/drivers/misc/mic/card/mic_x100.c
+++ b/drivers/misc/mic/card/mic_x100.c
@@ -237,6 +237,9 @@ static int __init mic_probe(struct platform_device *pdev)
 	mdrv->dev = &pdev->dev;
 	snprintf(mdrv->name, sizeof(mic_driver_name), mic_driver_name);
 
+	/* FIXME: use dma_set_mask_and_coherent() and check result */
+	dma_coerce_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
+
 	mdev->mmio.pa = MIC_X100_MMIO_BASE;
 	mdev->mmio.len = MIC_X100_MMIO_LEN;
 	mdev->mmio.va = devm_ioremap(&pdev->dev, MIC_X100_MMIO_BASE,
@@ -282,18 +285,6 @@ static void mic_platform_shutdown(struct platform_device *pdev)
 	mic_remove(pdev);
 }
 
-static u64 mic_dma_mask = DMA_BIT_MASK(64);
-
-static struct platform_device mic_platform_dev = {
-	.name = mic_driver_name,
-	.id   = 0,
-	.num_resources = 0,
-	.dev = {
-		.dma_mask = &mic_dma_mask,
-		.coherent_dma_mask = DMA_BIT_MASK(64),
-	},
-};
-
 static struct platform_driver __refdata mic_platform_driver = {
 	.probe = mic_probe,
 	.remove = mic_remove,
@@ -303,6 +294,8 @@ static struct platform_driver __refdata mic_platform_driver = {
 	},
 };
 
+static struct platform_device *mic_platform_dev;
+
 static int __init mic_init(void)
 {
 	int ret;
@@ -316,9 +309,12 @@ static int __init mic_init(void)
 
 	request_module("mic_x100_dma");
 	mic_init_card_debugfs();
-	ret = platform_device_register(&mic_platform_dev);
+
+	mic_platform_dev = platform_device_register_simple(mic_driver_name,
+							   0, NULL, 0);
+	ret = PTR_ERR_OR_ZERO(mic_platform_dev);
 	if (ret) {
-		pr_err("platform_device_register ret %d\n", ret);
+		pr_err("platform_device_register_full ret %d\n", ret);
 		goto cleanup_debugfs;
 	}
 	ret = platform_driver_register(&mic_platform_driver);
@@ -329,7 +325,7 @@ static int __init mic_init(void)
 	return ret;
 
 device_unregister:
-	platform_device_unregister(&mic_platform_dev);
+	platform_device_unregister(mic_platform_dev);
 cleanup_debugfs:
 	mic_exit_card_debugfs();
 done:
@@ -339,7 +335,7 @@ static int __init mic_init(void)
 static void __exit mic_exit(void)
 {
 	platform_driver_unregister(&mic_platform_driver);
-	platform_device_unregister(&mic_platform_dev);
+	platform_device_unregister(mic_platform_dev);
 	mic_exit_card_debugfs();
 }
 
-- 
2.20.0

