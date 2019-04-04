Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64B50C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:36:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FEE4205F4
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554370567;
	bh=jxbQ3NQjUGKXlL7x5ek99KeFpVeChwiM4qS1Qgq5J3k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nxkrOsls4D8Y7C3e53/l2Yj/zkIL0Rq7W9tHYIiYhNGrwwoGByd6sGdQaNUT6dglO
	 BhbvpCapxOhul8vbleF9vbpqlq+XlWMJvEcXFLcPzY9k5+vewz0wqzly/YMxdjhkwF
	 c6QLb7uElWhbSJBT0O14OV7ZkDZyyEf/0ga8047A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731971AbfDDJgG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:36:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:44272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731546AbfDDJF5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:05:57 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A6C4B2177E;
        Thu,  4 Apr 2019 09:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554368756;
        bh=jxbQ3NQjUGKXlL7x5ek99KeFpVeChwiM4qS1Qgq5J3k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ytXmWzdT08tdO1o6d2RVSin5u+Pq5D/K4Y14G3BLlBpXHSFrQrNqSEgxhSlfLlCJ/
         fj9qjv09Gds5pmxiUaH5tViMmLu3PCQa/E1Q4oFXuejob7JkzW2u776cPHIEX/XXSc
         EPOlHbnXQkYP0tMuP5RsPxbJYTUv48qGs7h6z3+g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Timo Alho <talho@nvidia.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Thierry Reding <treding@nvidia.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 158/187] soc/tegra: fuse: Fix illegal free of IO base address
Date:   Thu,  4 Apr 2019 10:48:15 +0200
Message-Id: <20190404084610.555433405@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084603.119654039@linuxfoundation.org>
References: <20190404084603.119654039@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index a33ee8ef8b6b..51625703399e 100644
--- a/drivers/soc/tegra/fuse/fuse-tegra.c
+++ b/drivers/soc/tegra/fuse/fuse-tegra.c
@@ -137,13 +137,17 @@ static int tegra_fuse_probe(struct platform_device *pdev)
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	fuse->phys = res->start;
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
 
@@ -152,8 +156,10 @@ static int tegra_fuse_probe(struct platform_device *pdev)
 
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



