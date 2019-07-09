Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57EB0C73C53
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 18:57:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3852B20665
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 18:57:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729383AbfGIS5Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 14:57:16 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:41851 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbfGIS5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 14:57:16 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MOzjW-1i7z240g2u-00POJ0; Tue, 09 Jul 2019 20:57:04 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Laxman Dewangan <ldewangan@nvidia.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Sameer Pujar <spujar@nvidia.com>,
        Vinod Koul <vinod.koul@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dmaengine: tegra210-adma: mark PM funtions as __maybe_unused
Date:   Tue,  9 Jul 2019 20:56:47 +0200
Message-Id: <20190709185703.3298951-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:GpuBD0XBnSPull69qzcIKP+lHCIkqzMcihUX/F3Ms65lqi/kPjK
 oFoGx6oSBaJT6d8oc8bj9+5wgmlI0bi+AmF3+9eGAyfivixx6msc3XgJ0TRQCPkaYPnwtTu
 YipqxIddC+A5ACdh0vwzyK7R7sFPt0sWMyZUDhqzwVirWCB3tOqj9CtTahMDQQr8yIELAHe
 aoILbo0XTVcDB85JtOEzw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+CKo2D4GADQ=:o2+cIM7eMzMgsQ2z2sSZ4n
 NKrt0Y/Wi1L1KPQz+gOI4V26Z/781wnKmF9rEVSmyKUfEDqgBO3S7LVSxhOtFC5gQ78OY1GNI
 5os8zUjm7QFEuVJAOS5BFZ90dNzopW9hZ932Wb6faZLwJACRUpx7EcQYJLNklZVZEGJSxKGTe
 HHkEVKaj5I/twIIfctqgMzGqoBiyJzWNhj2FflA9C6gDdEYpl3VCuaVOeoADX3x7dLhodcjMd
 eTNigOBE9wCihC95tAEVMx4PaoAwYM+JKjrjho51CSMykJt9CllBksDmRs9ZlHYpusDIqeaab
 BmkHVucMIqrjGjkveTJRdJpEGf4TpwVAr5v6ndBTokqDZQB+z7QFcBnAZV5cwQeyWkgaYpqNX
 Vx4xMIBH93qYbJEaluM5QzVo+cxR7pZG2WBCpt/UjxL5i17ffC9sJ/juEKFwqqWK9qUleUGfn
 EROzxAFfO6xtlOee0aEmpKaByyKvHuX3bAeYyKlJ0tRkyOjglE9egcA66jJuKZ2lK5x8C2a1H
 eGxmF9K3YJnRIWB67P72KhLRvUze4zKc+6BVe8Vo2S4MbHOsmv6MpmeavDDurSNHHPCY5i6pl
 b1ON82XtPMROCnBqxxCI9MJlYbxq/qT711dzCjVriC9Pn+uUsLJBqjTG9xWmfeS7hiPGon+Mn
 RPucDyF8+m3JkNBmTdyovJyrSOs8lHuKUN53HJUR0pdEtihhqyFXypx6bBGhWXbBmaPqC7EuL
 Bko0dLS4PTBMHGgveGzBF4G5BN0wQOz243X68w==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Without the CONFIG_PM_CLK dependency, we can now build this file
in kernels that don't have CONFIG_PM at all, resulting in a harmless
warning from code that was always there since it got merged:

drivers/dma/tegra210-adma.c:747:12: error: 'tegra_adma_runtime_resume' defined but not used [-Werror=unused-function]
 static int tegra_adma_runtime_resume(struct device *dev)
            ^~~~~~~~~~~~~~~~~~~~~~~~~
drivers/dma/tegra210-adma.c:715:12: error: 'tegra_adma_runtime_suspend' defined but not used [-Werror=unused-function]
 static int tegra_adma_runtime_suspend(struct device *dev)
            ^~~~~~~~~~~~~~~~~~~~~~~~~~

Mark them __maybe_unused to let the compiler silently drop
those two functions.

Fixes: 3145d73e69ba ("dmaengine: tegra210-adma: remove PM_CLK dependency")
Fixes: f46b195799b5 ("dmaengine: tegra-adma: Add support for Tegra210 ADMA")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/dma/tegra210-adma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/tegra210-adma.c b/drivers/dma/tegra210-adma.c
index 2805853e963f..2b4be5557b37 100644
--- a/drivers/dma/tegra210-adma.c
+++ b/drivers/dma/tegra210-adma.c
@@ -712,7 +712,7 @@ static struct dma_chan *tegra_dma_of_xlate(struct of_phandle_args *dma_spec,
 	return chan;
 }
 
-static int tegra_adma_runtime_suspend(struct device *dev)
+static __maybe_unused int tegra_adma_runtime_suspend(struct device *dev)
 {
 	struct tegra_adma *tdma = dev_get_drvdata(dev);
 	struct tegra_adma_chan_regs *ch_reg;
@@ -744,7 +744,7 @@ static int tegra_adma_runtime_suspend(struct device *dev)
 	return 0;
 }
 
-static int tegra_adma_runtime_resume(struct device *dev)
+static __maybe_unused int tegra_adma_runtime_resume(struct device *dev)
 {
 	struct tegra_adma *tdma = dev_get_drvdata(dev);
 	struct tegra_adma_chan_regs *ch_reg;
-- 
2.20.0

