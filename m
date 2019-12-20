Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BF38C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 11:19:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 567A324679
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 11:19:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727261AbfLTLTF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 06:19:05 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:7725 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727177AbfLTLTF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 06:19:05 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 4A1A6CC09BE5C294C012;
        Fri, 20 Dec 2019 19:19:02 +0800 (CST)
Received: from DESKTOP-8RFUVS3.china.huawei.com (10.173.222.27) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.439.0; Fri, 20 Dec 2019 19:18:54 +0800
From:   Zenghui Yu <yuzenghui@huawei.com>
To:     <maz@kernel.org>
CC:     <andre.przywara@arm.com>, <eric.auger@redhat.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <kvmarm@lists.cs.columbia.edu>, <linux-kernel@vger.kernel.org>,
        <wanghaibin.wang@huawei.com>, Zenghui Yu <yuzenghui@huawei.com>
Subject: [PATCH] KVM: arm/arm64: vgic: Handle GICR_PENDBASER.PTZ filed as RAZ
Date:   Fri, 20 Dec 2019 19:18:33 +0800
Message-ID: <20191220111833.1422-1-yuzenghui@huawei.com>
X-Mailer: git-send-email 2.23.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.173.222.27]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Although guest will hardly read and use the PTZ (Pending Table Zero)
bit in GICR_PENDBASER, let us emulate the architecture strictly.
As per IHI 0069E 9.11.30, PTZ field is WO, and reads as 0.

Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
---

Noticed when checking all fields of GICR_PENDBASER register.
But _not_ sure whether it's worth a fix, as Linux never sets
the PTZ bit before enabling LPI (set GICR_CTLR_ENABLE_LPIS).

And I wonder under which scenarios can this bit be written as 1.
It seems difficult for software to determine whether the pending
table contains all zeros when writing this bit.

 virt/kvm/arm/vgic/vgic-mmio-v3.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/virt/kvm/arm/vgic/vgic-mmio-v3.c b/virt/kvm/arm/vgic/vgic-mmio-v3.c
index 7dfd15dbb308..ebc218840fc2 100644
--- a/virt/kvm/arm/vgic/vgic-mmio-v3.c
+++ b/virt/kvm/arm/vgic/vgic-mmio-v3.c
@@ -414,8 +414,11 @@ static unsigned long vgic_mmio_read_pendbase(struct kvm_vcpu *vcpu,
 					     gpa_t addr, unsigned int len)
 {
 	struct vgic_cpu *vgic_cpu = &vcpu->arch.vgic_cpu;
+	u64 value = vgic_cpu->pendbaser;
 
-	return extract_bytes(vgic_cpu->pendbaser, addr & 7, len);
+	value &= ~GICR_PENDBASER_PTZ;
+
+	return extract_bytes(value, addr & 7, len);
 }
 
 static void vgic_mmio_write_pendbase(struct kvm_vcpu *vcpu,
-- 
2.19.1


