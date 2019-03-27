Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EEC9C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:47:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F7CF205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553712445;
	bh=XP/+rft/QIwUXD6BlcYEPmCEzL0oQIeqTo12dAz3s3M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hZtgghD2m9GjpDfVwNvxWdMx+gzcwBhvHCAygHBio8IL5LXmdnKftcJFisoss7Ml5
	 sxL11hGObHu/TJfT7KQuS8tW6fbqvM1F1h3PVSg4UojXBlGeSIxCY3pRWX4kQ935lX
	 7ZUGLcLO4hTeOnShnZqExv1AzVOum7ebr7RDINq4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390812AbfC0ST4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:19:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:37314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390773AbfC0STy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:19:54 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C66322063F;
        Wed, 27 Mar 2019 18:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553710792;
        bh=XP/+rft/QIwUXD6BlcYEPmCEzL0oQIeqTo12dAz3s3M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=x3+mGTJkp59GNOxQxuyEqrSUkfd18/mc8DI7TyztX3Rx94y8AiS+ZXjiE7HqYt3RD
         kS3ruUsZZl5DFplyFv2V7wB8rllZNCGxViOrz/6s48zOQg9kvBp7jPHF+uu5wi1ml7
         +Aj1EExcE7qcOfXCO1mm+I8KK4jRFdf3nO04ODlw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Timo Alho <talho@nvidia.com>, Thierry Reding <treding@nvidia.com>,
        Sasha Levin <sashal@kernel.org>, linux-tegra@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 102/123] soc/tegra: fuse: Fix illegal free of IO base address
Date:   Wed, 27 Mar 2019 14:16:06 -0400
Message-Id: <20190327181628.15899-102-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327181628.15899-1-sashal@kernel.org>
References: <20190327181628.15899-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Timo Alho <talho@nvidia.com>

[ Upstream commit 51294bf6b9e897d595466dcda5a3f2751906a200 ]

On cases where device tree entries for fuse and clock provider are in
different order, fuse driver needs to defer probing. This leads to
freeing incorrect IO base address as the fuse->base variable gets
overwritten once during first probe invocation. This leads to the
following spew during boot:

[    3.082285] Trying to vfree() nonexistent vm area (00000000cfe8fd94)
[    3.082308] WARNING: CPU: 5 PID: 126 at /hdd/l4t/kernel/stable/mm/vmalloc.c:1511 __vunmap+0xcc/0xd8
[    3.082318] Modules linked in:
[    3.082330] CPU: 5 PID: 126 Comm: kworker/5:1 Tainted: G S                4.19.7-tegra-gce119d3 #1
[    3.082340] Hardware name: quill (DT)
[    3.082353] Workqueue: events deferred_probe_work_func
[    3.082364] pstate: 40000005 (nZcv daif -PAN -UAO)
[    3.082372] pc : __vunmap+0xcc/0xd8
[    3.082379] lr : __vunmap+0xcc/0xd8
[    3.082385] sp : ffff00000a1d3b60
[    3.082391] x29: ffff00000a1d3b60 x28: 0000000000000000
[    3.082402] x27: 0000000000000000 x26: ffff000008e8b610
[    3.082413] x25: 0000000000000000 x24: 0000000000000009
[    3.082423] x23: ffff000009221a90 x22: ffff000009f6d000
[    3.082432] x21: 0000000000000000 x20: 0000000000000000
[    3.082442] x19: ffff000009f6d000 x18: ffffffffffffffff
[    3.082452] x17: 0000000000000000 x16: 0000000000000000
[    3.082462] x15: ffff0000091396c8 x14: 0720072007200720
[    3.082471] x13: 0720072007200720 x12: 0720072907340739
[    3.082481] x11: 0764076607380765 x10: 0766076307300730
[    3.082491] x9 : 0730073007300730 x8 : 0730073007280720
[    3.082501] x7 : 0761076507720761 x6 : 0000000000000102
[    3.082510] x5 : 0000000000000000 x4 : 0000000000000000
[    3.082519] x3 : ffffffffffffffff x2 : ffff000009150ff8
[    3.082528] x1 : 3d95b1429fff5200 x0 : 0000000000000000
[    3.082538] Call trace:
[    3.082545]  __vunmap+0xcc/0xd8
[    3.082552]  vunmap+0x24/0x30
[    3.082561]  __iounmap+0x2c/0x38
[    3.082569]  tegra_fuse_probe+0xc8/0x118
[    3.082577]  platform_drv_probe+0x50/0xa0
[    3.082585]  really_probe+0x1b0/0x288
[    3.082593]  driver_probe_device+0x58/0x100
[    3.082601]  __device_attach_driver+0x98/0xf0
[    3.082609]  bus_for_each_drv+0x64/0xc8
[    3.082616]  __device_attach+0xd8/0x130
[    3.082624]  device_initial_probe+0x10/0x18
[    3.082631]  bus_probe_device+0x90/0x98
[    3.082638]  deferred_probe_work_func+0x74/0xb0
[    3.082649]  process_one_work+0x1e0/0x318
[    3.082656]  worker_thread+0x228/0x450
[    3.082664]  kthread+0x128/0x130
[    3.082672]  ret_from_fork+0x10/0x18
[    3.082678] ---[ end trace 0810fe6ba772c1c7 ]---

Fix this by retaining the value of fuse->base until driver has
successfully probed.

Signed-off-by: Timo Alho <talho@nvidia.com>
Acked-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/soc/tegra/fuse/fuse-tegra.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/soc/tegra/fuse/fuse-tegra.c b/drivers/soc/tegra/fuse/fuse-tegra.c
index b7c552e3133c..37bde5c8268d 100644
--- a/drivers/soc/tegra/fuse/fuse-tegra.c
+++ b/drivers/soc/tegra/fuse/fuse-tegra.c
@@ -133,13 +133,17 @@ static int tegra_fuse_probe(struct platform_device *pdev)
 	/* take over the memory region from the early initialization */
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	fuse->base = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(fuse->base))
-		return PTR_ERR(fuse->base);
+	if (IS_ERR(fuse->base)) {
+		err = PTR_ERR(fuse->base);
+		fuse->base = base;
+		return err;
+	}
 
 	fuse->clk = devm_clk_get(&pdev->dev, "fuse");
 	if (IS_ERR(fuse->clk)) {
 		dev_err(&pdev->dev, "failed to get FUSE clock: %ld",
 			PTR_ERR(fuse->clk));
+		fuse->base = base;
 		return PTR_ERR(fuse->clk);
 	}
 
@@ -148,8 +152,10 @@ static int tegra_fuse_probe(struct platform_device *pdev)
 
 	if (fuse->soc->probe) {
 		err = fuse->soc->probe(fuse);
-		if (err < 0)
+		if (err < 0) {
+			fuse->base = base;
 			return err;
+		}
 	}
 
 	if (tegra_fuse_create_sysfs(&pdev->dev, fuse->soc->info->size,
-- 
2.19.1

