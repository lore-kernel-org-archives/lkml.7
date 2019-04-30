Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FFC0C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 16:18:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB8C320835
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 16:18:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726401AbfD3QSE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 12:18:04 -0400
Received: from honk.sigxcpu.org ([24.134.29.49]:48121 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725942AbfD3QSD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 12:18:03 -0400
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 3CBEFFB03;
        Tue, 30 Apr 2019 18:18:01 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id yvo4w9v-Tb9h; Tue, 30 Apr 2019 18:18:00 +0200 (CEST)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 111EA4027E; Tue, 30 Apr 2019 18:18:00 +0200 (CEST)
From:   =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] amd64: mxc: select CONFIG_SOC_BUS
Date:   Tue, 30 Apr 2019 18:17:59 +0200
Message-Id: <a45b70bae964b15317167304a89ba1094a769916.1556640947.git.agx@sigxcpu.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i.MX8 needs soc_device_register, otherwise the build fails like:

  aarch64-linux-gnu-ld: drivers/soc/imx/soc-imx8.o: in function `imx8_soc_init':
  soc-imx8.c:(.init.text+0x130): undefined reference to `soc_device_register'
  aarch64-linux-gnu-ld: soc-imx8.c:(.init.text+0x130): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `soc_device_register'
  make: *** [Makefile:1051: vmlinux] Error 1

Signed-off-by: Guido Günther <agx@sigxcpu.org>

---
This was seen on next-20190430.

 arch/arm64/Kconfig.platforms | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 0f4d91824e4b..c86bccbb118a 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -162,6 +162,7 @@ config ARCH_MXC
 	select IMX_GPCV2_PM_DOMAINS
 	select PM
 	select PM_GENERIC_DOMAINS
+	select SOC_BUS
 	help
 	  This enables support for the ARMv8 based SoCs in the
 	  NXP i.MX family.
-- 
2.20.1

