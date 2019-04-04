Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E679C10F05
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:47:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 091E620882
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:47:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728731AbfDDIrI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 04:47:08 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:6249 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728676AbfDDIrI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 04:47:08 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id BB6F6EAE9FFF7D452FD7;
        Thu,  4 Apr 2019 16:47:03 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.408.0; Thu, 4 Apr 2019 16:46:54 +0800
From:   Yonglong Liu <liuyonglong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <salil.mehta@huawei.com>,
        <yisen.zhuang@huawei.com>, <shiju.jose@huawei.com>
Subject: [PATCH net 5/6] net: hns: Fix WARNING when remove HNS driver with SMMU enabled
Date:   Thu, 4 Apr 2019 16:46:46 +0800
Message-ID: <1554367607-130891-6-git-send-email-liuyonglong@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1554367607-130891-1-git-send-email-liuyonglong@huawei.com>
References: <1554367607-130891-1-git-send-email-liuyonglong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When enable SMMU, remove HNS driver will cause a WARNING:

[  141.924177] WARNING: CPU: 36 PID: 2708 at drivers/iommu/dma-iommu.c:443 __iommu_dma_unmap+0xc0/0xc8
[  141.954673] Modules linked in: hns_enet_drv(-)
[  141.963615] CPU: 36 PID: 2708 Comm: rmmod Tainted: G        W         5.0.0-rc1-28723-gb729c57de95c-dirty #32
[  141.983593] Hardware name: Huawei D05/D05, BIOS Hisilicon D05 UEFI Nemo 1.8 RC0 08/31/2017
[  142.000244] pstate: 60000005 (nZCv daif -PAN -UAO)
[  142.009886] pc : __iommu_dma_unmap+0xc0/0xc8
[  142.018476] lr : __iommu_dma_unmap+0xc0/0xc8
[  142.027066] sp : ffff000013533b90
[  142.033728] x29: ffff000013533b90 x28: ffff8013e6983600
[  142.044420] x27: 0000000000000000 x26: 0000000000000000
[  142.055113] x25: 0000000056000000 x24: 0000000000000015
[  142.065806] x23: 0000000000000028 x22: ffff8013e66eee68
[  142.076499] x21: ffff8013db919800 x20: 0000ffffefbff000
[  142.087192] x19: 0000000000001000 x18: 0000000000000007
[  142.097885] x17: 000000000000000e x16: 0000000000000001
[  142.108578] x15: 0000000000000019 x14: 363139343a70616d
[  142.119270] x13: 6e75656761705f67 x12: 0000000000000000
[  142.129963] x11: 00000000ffffffff x10: 0000000000000006
[  142.140656] x9 : 1346c1aa88093500 x8 : ffff0000114de4e0
[  142.151349] x7 : 6662666578303d72 x6 : ffff0000105ffec8
[  142.162042] x5 : 0000000000000000 x4 : 0000000000000000
[  142.172734] x3 : 00000000ffffffff x2 : ffff0000114de500
[  142.183427] x1 : 0000000000000000 x0 : 0000000000000035
[  142.194120] Call trace:
[  142.199030]  __iommu_dma_unmap+0xc0/0xc8
[  142.206920]  iommu_dma_unmap_page+0x20/0x28
[  142.215335]  __iommu_unmap_page+0x40/0x60
[  142.223399]  hnae_unmap_buffer+0x110/0x134
[  142.231639]  hnae_free_desc+0x6c/0x10c
[  142.239177]  hnae_fini_ring+0x14/0x34
[  142.246540]  hnae_fini_queue+0x2c/0x40
[  142.254080]  hnae_put_handle+0x38/0xcc
[  142.261619]  hns_nic_dev_remove+0x54/0xfc [hns_enet_drv]
[  142.272312]  platform_drv_remove+0x24/0x64
[  142.280552]  device_release_driver_internal+0x17c/0x20c
[  142.291070]  driver_detach+0x4c/0x90
[  142.298259]  bus_remove_driver+0x5c/0xd8
[  142.306148]  driver_unregister+0x2c/0x54
[  142.314037]  platform_driver_unregister+0x10/0x18
[  142.323505]  hns_nic_dev_driver_exit+0x14/0xf0c [hns_enet_drv]
[  142.335248]  __arm64_sys_delete_module+0x214/0x25c
[  142.344891]  el0_svc_common+0xb0/0x10c
[  142.352430]  el0_svc_handler+0x24/0x80
[  142.359968]  el0_svc+0x8/0x7c0
[  142.366104] ---[ end trace 60ad1cd58e63c407 ]---

The tx ring buffer map when xmit and unmap when xmit done. So in
hnae_init_ring() did not map tx ring buffer, but in hnae_fini_ring()
have a unmap operation for tx ring buffer, which is already unmapped
when xmit done, than cause this WARNING.

The hnae_alloc_buffers() is called in hnae_init_ring(),
so the hnae_free_buffers() should be in hnae_fini_ring(), not in
hnae_free_desc().

In hnae_fini_ring(), adds a check is_rx_ring() as in hnae_init_ring().
When the ring buffer is tx ring, adds a piece of code to ensure that
the tx ring is unmap.

Signed-off-by: Yonglong Liu <liuyonglong@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns/hnae.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/hisilicon/hns/hnae.c b/drivers/net/ethernet/hisilicon/hns/hnae.c
index 79d03f8..c7fa97a 100644
--- a/drivers/net/ethernet/hisilicon/hns/hnae.c
+++ b/drivers/net/ethernet/hisilicon/hns/hnae.c
@@ -150,7 +150,6 @@ static int hnae_alloc_buffers(struct hnae_ring *ring)
 /* free desc along with its attached buffer */
 static void hnae_free_desc(struct hnae_ring *ring)
 {
-	hnae_free_buffers(ring);
 	dma_unmap_single(ring_to_dev(ring), ring->desc_dma_addr,
 			 ring->desc_num * sizeof(ring->desc[0]),
 			 ring_to_dma_dir(ring));
@@ -183,6 +182,9 @@ static int hnae_alloc_desc(struct hnae_ring *ring)
 /* fini ring, also free the buffer for the ring */
 static void hnae_fini_ring(struct hnae_ring *ring)
 {
+	if (is_rx_ring(ring))
+		hnae_free_buffers(ring);
+
 	hnae_free_desc(ring);
 	kfree(ring->desc_cb);
 	ring->desc_cb = NULL;
-- 
2.8.1

