Return-Path: <SRS0=vISB=2T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD5E9C2D0C0
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 04:08:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 872C420720
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 04:08:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="NtWfhfM8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbfL2ECy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Dec 2019 23:02:54 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:13421 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbfL2ECy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Dec 2019 23:02:54 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e08255f0000>; Sat, 28 Dec 2019 20:02:39 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Sat, 28 Dec 2019 20:02:53 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Sat, 28 Dec 2019 20:02:53 -0800
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sun, 29 Dec
 2019 04:02:52 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Sun, 29 Dec 2019 04:02:52 +0000
Received: from dhcp-10-19-66-63.nvidia.com (Not Verified[10.19.66.63]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5e08256a0000>; Sat, 28 Dec 2019 20:02:52 -0800
From:   Bitan Biswas <bbiswas@nvidia.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Thierry Reding <treding@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Bitan Biswas <bbiswas@nvidia.com>
Subject: [PATCH V1] nvmem: core: fix memory abort in cleanup path
Date:   Sat, 28 Dec 2019 20:02:42 -0800
Message-ID: <1577592162-14817-1-git-send-email-bbiswas@nvidia.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1577592159; bh=OK1RKNnphUt5ZOJF1ejSbTS7CSZIPsea8rpQM1Q5/WI=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         MIME-Version:Content-Type;
        b=NtWfhfM8/noJc6lGVZgm6Pbi5qoU/9iv96uDFZJz4lNcu53oLVhsFnZG7bk751rrB
         7T9+2oCpzWR09XftIVc6vUaOTejiswqj927N7xVJgpTGOfqR/7GRbtwv6U+EJEEp+Z
         1HiGa0GUtS2xdie4Vce7y1RbqWwowgUSNaMYgbwbMDclGAAHexdswQ4+By2cWkturi
         V4ScO15tEssJS+GODMxYX0i5JUPqSlMeC/gq3Lo/YQYmFSvoRyCtnznzaQLDi2X6qO
         XO1jmCqxRcYMOQRJthtsVX/Jb0E1MfaNkrEerd1T/QCWAPW0T770fOkRoylPN5q6JI
         sML8bHIfoz0hw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

nvmem_cell_info_to_nvmem_cell implementation has static
allocation of name. nvmem_add_cells_from_of() call may
return error and kfree name results in memory abort. Use
kasprintf() instead of assigning pointer and prevent kfree crash.

[    8.076461] Unable to handle kernel paging request at virtual address ffffffffffe44888
[    8.084762] Mem abort info:
[    8.087694]   ESR = 0x96000006
[    8.090906]   EC = 0x25: DABT (current EL), IL = 32 bits
[    8.096476]   SET = 0, FnV = 0
[    8.099683]   EA = 0, S1PTW = 0
[    8.102976] Data abort info:
[    8.106004]   ISV = 0, ISS = 0x00000006
[    8.110026]   CM = 0, WnR = 0
[    8.113154] swapper pgtable: 64k pages, 48-bit VAs, pgdp=00000000815d0000
[    8.120279] [ffffffffffe44888] pgd=0000000081d30803, pud=0000000081d30803, pmd=0000000000000000
[    8.129429] Internal error: Oops: 96000006 [#1] PREEMPT SMP
[    8.135257] Modules linked in:
[    8.138456] CPU: 2 PID: 43 Comm: kworker/2:1 Tainted: G S                5.5.0-rc3-tegra-00051-g6989dd3-dirty #3   [    8.149098] Hardware name: quill (DT)
[    8.152968] Workqueue: events deferred_probe_work_func
[    8.158350] pstate: a0000005 (NzCv daif -PAN -UAO)
[    8.163386] pc : kfree+0x38/0x278
[    8.166873] lr : nvmem_cell_drop+0x68/0x80
[    8.171154] sp : ffff80001284f9d0
[    8.174620] x29: ffff80001284f9d0 x28: ffff0001f677e830
[    8.180189] x27: ffff800011b0b000 x26: ffff0001c36e1008
[    8.185755] x25: ffff8000112ad000 x24: ffff8000112c9000
[    8.191311] x23: ffffffffffffffea x22: ffff800010adc7f0
[    8.196865] x21: ffffffffffe44880 x20: ffff800011b0b068
[    8.202424] x19: ffff80001122d380 x18: ffffffffffffffff
[    8.207987] x17: 00000000d5cb4756 x16: 0000000070b193b8
[    8.213550] x15: ffff8000119538c8 x14: 0720072007200720
[    8.219120] x13: 07200720076e0772 x12: 07750762072d0765
[    8.224685] x11: 0773077507660765 x10: 072f073007300730
[    8.230253] x9 : 0730073207380733 x8 : 0000000000000151
[    8.235818] x7 : 07660765072f0720 x6 : ffff0001c00e0f00
[    8.241382] x5 : 0000000000000000 x4 : ffff0001c0b43800
[    8.247007] x3 : ffff800011b0b068 x2 : 0000000000000000
[    8.252567] x1 : 0000000000000000 x0 : ffffffdfffe00000
[    8.258126] Call trace:
[    8.260705]  kfree+0x38/0x278
[    8.263827]  nvmem_cell_drop+0x68/0x80
[    8.267773]  nvmem_device_remove_all_cells+0x2c/0x50
[    8.272988]  nvmem_register.part.9+0x520/0x628
[    8.277655]  devm_nvmem_register+0x48/0xa0
[    8.281966]  tegra_fuse_probe+0x140/0x1f0
[    8.286181]  platform_drv_probe+0x50/0xa0
[    8.290397]  really_probe+0x108/0x348
[    8.294243]  driver_probe_device+0x58/0x100
[    8.298618]  __device_attach_driver+0x90/0xb0
[    8.303172]  bus_for_each_drv+0x64/0xc8
[    8.307184]  __device_attach+0xd8/0x138
[    8.311195]  device_initial_probe+0x10/0x18
[    8.315562]  bus_probe_device+0x90/0x98
[    8.319572]  deferred_probe_work_func+0x74/0xb0
[    8.324304]  process_one_work+0x1e0/0x358
[    8.328490]  worker_thread+0x208/0x488
[    8.332411]  kthread+0x118/0x120
[    8.335783]  ret_from_fork+0x10/0x18
[    8.339561] Code: d350feb5 f2dffbe0 aa1e03f6 8b151815 (f94006a0)
[    8.345939] ---[ end trace 49b1303c6b83198e ]---

Fixes: badcdff107cbf ("nvmem: Convert to using %pOFn instead of device_node.name")

Signed-off-by: Bitan Biswas <bbiswas@nvidia.com>
---
 drivers/nvmem/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 9f1ee9c..0fc66e1 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -110,7 +110,7 @@ static int nvmem_cell_info_to_nvmem_cell(struct nvmem_device *nvmem,
 	cell->nvmem = nvmem;
 	cell->offset = info->offset;
 	cell->bytes = info->bytes;
-	cell->name = info->name;
+	cell->name = kasprintf(GFP_KERNEL, "%s", info->name);
 
 	cell->bit_offset = info->bit_offset;
 	cell->nbits = info->nbits;
-- 
2.7.4

